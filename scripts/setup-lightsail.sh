#!/usr/bin/env bash
set -Eeuo pipefail

APP_DIR="${APP_DIR:-$(pwd)}"
APP_DB_NAME="${APP_DB_NAME:-myapp}"
APP_DB_USER="${APP_DB_USER:-myapp}"
APP_DB_PASSWORD="${APP_DB_PASSWORD:-}"
APP_PORT="${PORT:-3000}"

if [[ ! "$APP_DB_NAME" =~ ^[A-Za-z_][A-Za-z0-9_]*$ ]]; then
  echo "APP_DB_NAME은 영문자, 숫자, 밑줄만 사용할 수 있습니다." >&2
  exit 1
fi

if [[ ! "$APP_DB_USER" =~ ^[A-Za-z_][A-Za-z0-9_]*$ ]]; then
  echo "APP_DB_USER는 영문자, 숫자, 밑줄만 사용할 수 있습니다." >&2
  exit 1
fi

if [[ -z "$APP_DB_PASSWORD" ]]; then
  if [[ -f "$APP_DIR/.env" ]]; then
    EXISTING_DATABASE_URL="$(grep -E '^DATABASE_URL=' "$APP_DIR/.env" | tail -n 1 | cut -d= -f2- || true)"
    if [[ "$EXISTING_DATABASE_URL" =~ ^postgresql://[^:]+:([^@]+)@ ]]; then
      APP_DB_PASSWORD="${BASH_REMATCH[1]}"
    fi
  fi

  if [[ -z "$APP_DB_PASSWORD" ]]; then
    APP_DB_PASSWORD="$(od -An -N24 -tx1 /dev/urandom | tr -d '[:space:]')"
  fi
fi

if [[ ! "$APP_DB_PASSWORD" =~ ^[A-Za-z0-9_-]+$ ]]; then
  echo "APP_DB_PASSWORD에는 URL 인코딩이 필요한 특수문자를 사용할 수 없습니다." >&2
  echo "영문 대소문자, 숫자, 하이픈(-), 밑줄(_) 조합을 사용하세요." >&2
  exit 1
fi

echo "[1/7] Ubuntu 패키지 설치"
sudo apt-get update
sudo apt-get install -y ca-certificates curl gnupg nginx openssl postgresql postgresql-contrib postgresql-client

if ! command -v node >/dev/null 2>&1 || [[ "$(node -p 'Number(process.versions.node.split(`.`)[0])')" -lt 20 ]]; then
  echo "[2/7] Node.js 20 설치"
  curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
  sudo apt-get install -y nodejs
else
  echo "[2/7] Node.js 20 이상이 이미 설치되어 있습니다."
fi

echo "[3/7] PostgreSQL 시작 및 DB/사용자 생성"
sudo systemctl enable --now postgresql
sudo -u postgres psql \
  --set=db_user="$APP_DB_USER" \
  --set=db_password="$APP_DB_PASSWORD" \
  --set=db_name="$APP_DB_NAME" <<'SQL'
SELECT format('CREATE ROLE %I LOGIN PASSWORD %L', :'db_user', :'db_password')
WHERE NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = :'db_user') \gexec

SELECT format('ALTER ROLE %I WITH LOGIN PASSWORD %L', :'db_user', :'db_password') \gexec

SELECT format('CREATE DATABASE %I OWNER %I', :'db_name', :'db_user')
WHERE NOT EXISTS (SELECT 1 FROM pg_database WHERE datname = :'db_name') \gexec

SELECT format('ALTER DATABASE %I OWNER TO %I', :'db_name', :'db_user') \gexec
SQL

echo "[4/7] 앱 환경 변수 파일 생성"
cd "$APP_DIR"
if [[ ! -f .env ]]; then
  SESSION_SECRET_VALUE="$(openssl rand -hex 32)"
  ADMIN_PASSWORD_VALUE="$(openssl rand -hex 16)"
  umask 077
  cat > .env <<EOF
NODE_ENV=production
PORT=${APP_PORT}
DATABASE_URL=postgresql://${APP_DB_USER}:${APP_DB_PASSWORD}@127.0.0.1:5432/${APP_DB_NAME}
SESSION_SECRET=${SESSION_SECRET_VALUE}
ADMIN_USERNAME=admin
ADMIN_PASSWORD=${ADMIN_PASSWORD_VALUE}
EOF
  echo ".env 파일을 안전한 자동 생성 값으로 만들었습니다."
else
  echo "기존 .env 파일을 유지합니다."
fi

echo "[5/7] 앱 의존성 설치, DB 스키마 적용 및 빌드"
npm ci
npm run db:push
npm run build
sudo npm install -g pm2

echo "[6/7] Nginx 설정"
sudo cp deploy/nginx-gold-signal.conf /etc/nginx/sites-available/gold-signal
sudo ln -sfn /etc/nginx/sites-available/gold-signal /etc/nginx/sites-enabled/gold-signal
sudo rm -f /etc/nginx/sites-enabled/default
sudo nginx -t
sudo systemctl enable --now nginx
sudo systemctl reload nginx

echo "[7/7] PM2 앱 시작 및 부팅 자동 실행 설정"
set -a
# shellcheck disable=SC1091
source .env
set +a
pm2 startOrReload ecosystem.config.cjs --update-env
pm2 save
sudo env "PATH=$PATH" pm2 startup systemd -u "$USER" --hp "$HOME"

if command -v ufw >/dev/null 2>&1; then
  sudo ufw allow OpenSSH
  sudo ufw allow 'Nginx Full'
fi

echo
echo "Lightsail 초기 설정이 완료되었습니다."
echo "PM2 상태: pm2 status"
echo "앱 로그: pm2 logs gold-signal"
echo "헬스 확인: curl -I http://127.0.0.1:${APP_PORT}"