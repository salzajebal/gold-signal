#!/usr/bin/env bash
set -Eeuo pipefail

APP_DIR="${APP_DIR:-$HOME/gold-signal}"
DOWNLOAD_URL="https://raw.githubusercontent.com/salzajebal/gold-signal/main/migration/production-20260914.dump.cms"
EXPECTED_SHA256="96d544ed1fd0002a78550885b79ea43e9b8e213a2b372948905da61f17b4fa38"
PRIVATE_KEY="$HOME/.gold-signal-migration-key.pem"
CERTIFICATE="$HOME/.gold-signal-migration-cert.pem"
WORK_DIR="$(mktemp -d)"
ENCRYPTED_FILE="$WORK_DIR/production.dump.cms"
DUMP_FILE="$WORK_DIR/production.dump"
APP_STOPPED=0

cleanup() {
  rm -rf "$WORK_DIR"
  if (( APP_STOPPED == 1 )); then
    pm2 start gold-signal >/dev/null 2>&1 || true
  fi
}
trap cleanup EXIT

cd "$APP_DIR"

if [[ ! -f .env || ! -f "$PRIVATE_KEY" || ! -f "$CERTIFICATE" ]]; then
  echo "환경 파일 또는 VPS 전용 복호화 키가 없습니다." >&2
  exit 1
fi

set -a
# shellcheck disable=SC1091
source .env
set +a
: "${DATABASE_URL:?DATABASE_URL이 필요합니다}"
APP_PORT="${PORT:-3000}"

curl -fL --retry 3 --retry-delay 2 "$DOWNLOAD_URL" -o "$ENCRYPTED_FILE"
echo "$EXPECTED_SHA256  $ENCRYPTED_FILE" | sha256sum --check -

openssl cms -decrypt -binary -inform DER \
  -in "$ENCRYPTED_FILE" \
  -recip "$CERTIFICATE" \
  -inkey "$PRIVATE_KEY" \
  -out "$DUMP_FILE"
pg_restore --list "$DUMP_FILE" >/dev/null

if [[ -x /usr/local/sbin/gold-signal-backup ]]; then
  /usr/local/sbin/gold-signal-backup
else
  umask 077
  mkdir -p "$HOME/gold-signal-backups"
  pg_dump --format=custom --no-owner --no-privileges \
    --file="$HOME/gold-signal-backups/before-migration-$(date +%F-%H%M%S).dump" \
    --dbname="$DATABASE_URL"
fi

pm2 stop gold-signal
APP_STOPPED=1

psql "$DATABASE_URL" -v ON_ERROR_STOP=1 -c "
DROP SCHEMA public CASCADE;
CREATE SCHEMA public;
"

pg_restore \
  --no-owner \
  --no-privileges \
  --exit-on-error \
  --dbname="$DATABASE_URL" \
  "$DUMP_FILE"

pm2 start gold-signal
APP_STOPPED=0

READY=0
for attempt in $(seq 1 30); do
  if curl -fsS --max-time 5 "http://127.0.0.1:${APP_PORT}/" >/dev/null 2>&1; then
    READY=1
    break
  fi
  sleep 2
done

if (( READY != 1 )); then
  pm2 logs gold-signal --lines 80 --nostream
  exit 1
fi

psql "$DATABASE_URL" -v ON_ERROR_STOP=1 -P pager=off -c "
SELECT
  (SELECT count(*) FROM users) AS users,
  (SELECT count(*) FROM bets) AS bets,
  (SELECT count(*) FROM transaction_requests) AS transaction_requests,
  (SELECT count(*) FROM announcements) AS announcements,
  (SELECT count(*) FROM messages) AS messages,
  (SELECT count(*) FROM forex_candles) AS forex_candles;
"

curl -fsS --max-time 10 https://gold-sl.com/ >/dev/null
echo "최신 Replit 운영 DB 이전과 서비스 확인이 완료되었습니다."