#!/usr/bin/env bash
set -Eeuo pipefail

APP_DIR="${APP_DIR:-$HOME/gold-signal}"
cd "$APP_DIR"

if [[ ! -f .env ]]; then
  echo ".env 파일이 없습니다. 초기 설치를 먼저 실행하세요." >&2
  exit 1
fi

if ! grep -q '^ADMIN_USERNAME=' .env; then
  printf '\nADMIN_USERNAME=admin\n' >> .env
fi

if ! grep -Eq '^ADMIN_PASSWORD=.+$' .env; then
  sed -i '/^ADMIN_PASSWORD=/d' .env
  printf 'ADMIN_PASSWORD=%s\n' "$(openssl rand -hex 16)" >> .env
fi
chmod 600 .env

set -a
# shellcheck disable=SC1091
source .env
set +a

if [[ -z "${ADMIN_PASSWORD//[[:space:]]/}" ]]; then
  echo "유효한 ADMIN_PASSWORD를 생성하지 못했습니다." >&2
  exit 1
fi
if [[ ! "${PORT:-3000}" =~ ^[0-9]+$ ]] || (( ${PORT:-3000} < 1 || ${PORT:-3000} > 65535 )); then
  echo "PORT 값이 올바르지 않습니다: ${PORT:-}" >&2
  exit 1
fi
APP_PORT="${PORT:-3000}"

mapfile -t SSH_PORTS < <(sudo sshd -T | awk '$1 == "port" { print $2 }' | sort -u)
if (( ${#SSH_PORTS[@]} == 0 )); then
  echo "SSH 포트를 확인할 수 없어 방화벽 설정을 중단합니다." >&2
  exit 1
fi

if [[ ! -e /swapfile ]]; then
  sudo fallocate -l 2G /swapfile
  sudo chmod 600 /swapfile
  sudo mkswap /swapfile
fi
if ! swapon --show=NAME --noheadings | grep -qx '/swapfile'; then
  sudo swapon /swapfile
fi
grep -q '^/swapfile ' /etc/fstab || echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab >/dev/null

export DEBIAN_FRONTEND=noninteractive
sudo apt-get update
sudo apt-get install -y certbot fail2ban python3-certbot-nginx
sudo systemctl enable --now fail2ban

for SSH_PORT in "${SSH_PORTS[@]}"; do
  sudo ufw allow "${SSH_PORT}/tcp"
done
sudo ufw allow 'Nginx Full'
sudo ufw --force enable

BACKUP_DIR="$HOME/gold-signal-backups"
install -d -m 700 "$BACKUP_DIR"
sudo tee /usr/local/sbin/gold-signal-backup >/dev/null <<EOF
#!/usr/bin/env bash
set -Eeuo pipefail
set -a
source "$APP_DIR/.env"
set +a
umask 077
TEMP_FILE="$BACKUP_DIR/.db-\$(date +%F-%H%M%S).dump.tmp"
FINAL_FILE="\${TEMP_FILE%.tmp}"
trap 'rm -f "\$TEMP_FILE"' EXIT
pg_dump --format=custom --no-owner --no-privileges \
  --file="\$TEMP_FILE" \
  --dbname="\$DATABASE_URL"
pg_restore --list "\$TEMP_FILE" >/dev/null
mv "\$TEMP_FILE" "\$FINAL_FILE"
trap - EXIT
find "$BACKUP_DIR" -type f -name 'db-*.dump' -mtime +7 -delete
EOF
sudo chmod 700 /usr/local/sbin/gold-signal-backup
echo "15 3 * * * $USER /usr/local/sbin/gold-signal-backup" | sudo tee /etc/cron.d/gold-signal-backup >/dev/null
sudo chmod 644 /etc/cron.d/gold-signal-backup
/usr/local/sbin/gold-signal-backup

if [[ ! -f /etc/letsencrypt/live/gold-sl.com/fullchain.pem ]]; then
  sudo cp deploy/nginx-gold-signal.conf /etc/nginx/sites-available/gold-signal
  sudo nginx -t
  sudo systemctl reload nginx
  sudo certbot --nginx -d gold-sl.com --non-interactive --agree-tos --register-unsafely-without-email --redirect
fi
if ! sudo nginx -T 2>&1 | grep -q 'server_name gold-sl.com'; then
  echo "Nginx에 gold-sl.com 설정이 없습니다." >&2
  exit 1
fi
if ! sudo nginx -T 2>&1 | grep -q '/etc/letsencrypt/live/gold-sl.com/'; then
  echo "Nginx에 gold-sl.com 인증서 설정이 없습니다." >&2
  exit 1
fi
sudo nginx -t
sudo systemctl reload nginx
sudo certbot renew --dry-run

npm ci
npm run build
pm2 startOrReload ecosystem.config.cjs --update-env
pm2 save

curl -fsS "http://127.0.0.1:${APP_PORT}/" >/dev/null
curl -fsS https://gold-sl.com/ >/dev/null

echo
echo "운영 마무리 설정이 완료되었습니다."
echo "관리자 아이디: admin"
echo "관리자 비밀번호 확인: grep '^ADMIN_PASSWORD=' $APP_DIR/.env"
echo "백업 위치: $BACKUP_DIR"