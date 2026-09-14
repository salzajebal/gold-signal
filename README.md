# Gold Signal — AWS Lightsail 단일 VPS 배포 가이드

이 문서는 Ubuntu 기반 AWS Lightsail 인스턴스 한 대에서 다음 구성요소를 함께 운영하는 방법을 설명합니다.

- Node.js 웹 앱
- PostgreSQL 데이터베이스
- PM2 프로세스 관리자
- Nginx 리버스 프록시

외부 DB 서비스는 필요하지 않습니다. PostgreSQL은 외부에 공개하지 않고 같은 VPS의 `127.0.0.1:5432`에서만 앱이 접속합니다.

## 1. 운영 구성

```text
인터넷
  │
  ▼
Nginx :80/:443
  │
  ▼
Node.js + PM2 :3000
  │
  ▼
PostgreSQL :5432 (VPS 내부 전용)
```

앱은 다음 값을 사용합니다.

- 서버 주소: `0.0.0.0`
- 기본 앱 포트: `process.env.PORT || 3000`
- DB 주소: `process.env.DATABASE_URL`
- `DATABASE_URL` 미설정 시 개발용 기본값: `postgresql://postgres:password@localhost:5432/myapp`

운영 환경에서는 반드시 `.env`에 별도의 안전한 DB 비밀번호와 `SESSION_SECRET`을 설정하세요.

## 2. Lightsail 인스턴스 준비

권장 사양:

- Ubuntu 22.04 LTS 또는 24.04 LTS
- 최소 2GB RAM
- Lightsail 네트워킹 방화벽에서 TCP 22, 80, 443 허용
- PostgreSQL 포트 5432는 인터넷에 공개하지 않음

SSH로 접속합니다.

```bash
ssh -i /path/to/LightsailDefaultKey.pem ubuntu@서버_공인_IP
```

## 3. 프로젝트 내려받기

Git과 기본 도구를 설치하고 프로젝트를 복제합니다.

```bash
sudo apt-get update
sudo apt-get install -y git

git clone https://github.com/salzajebal/gold-signal.git
cd gold-signal
```

비공개 저장소라면 GitHub의 SSH 키 또는 안전한 배포 토큰 방식을 사용하세요. 토큰을 명령어나 저장소 파일에 기록하지 마세요.

## 4. 최초 1회 자동 구축

초기화 스크립트는 다음 작업을 수행합니다.

1. PostgreSQL, Nginx, PostgreSQL 클라이언트 설치
2. Node.js 20 설치
3. 로컬 DB 사용자와 데이터베이스 생성
4. `.env` 생성
5. 앱 의존성 설치 및 빌드
6. Nginx 설정
7. PM2 실행 및 재부팅 자동 시작 설정

먼저 실행 권한을 부여합니다.

```bash
chmod +x scripts/setup-lightsail.sh
```

DB 비밀번호와 세션 키는 스크립트가 안전한 임의 값으로 자동 생성합니다.

```bash
bash scripts/setup-lightsail.sh
```

완료 후 상태를 확인합니다.

```bash
pm2 status
pm2 logs gold-signal
sudo systemctl status postgresql --no-pager
sudo systemctl status nginx --no-pager
curl -I http://127.0.0.1:3000
```

브라우저에서 아래 주소를 엽니다.

```text
http://서버_공인_IP
```

## 5. 명령어를 직접 실행해 구축하는 방법

자동 스크립트를 사용하지 않을 경우 아래 순서대로 실행합니다.

### 5.1 PostgreSQL과 Nginx 설치

```bash
sudo apt-get update
sudo apt-get install -y ca-certificates curl gnupg nginx openssl \
  postgresql postgresql-contrib postgresql-client

sudo systemctl enable --now postgresql
sudo systemctl enable --now nginx
```

### 5.2 Node.js 20과 PM2 설치

```bash
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt-get install -y nodejs
sudo npm install -g pm2

node --version
npm --version
pm2 --version
```

### 5.3 PostgreSQL 사용자와 DB 생성

아래 예제의 비밀번호는 반드시 변경하세요.

```bash
sudo -u postgres psql
```

PostgreSQL 콘솔에서 실행합니다.

```sql
CREATE USER myapp WITH LOGIN PASSWORD '여기에_강한_DB_비밀번호';
CREATE DATABASE myapp OWNER myapp;
\q
```

연결을 확인합니다.

```bash
psql "postgresql://myapp:여기에_강한_DB_비밀번호@127.0.0.1:5432/myapp" \
  -c "SELECT current_database(), current_user;"
```

### 5.4 앱 환경 변수 설정

프로젝트 루트에서 `.env`를 만듭니다.

```bash
cp .env.example .env
nano .env
chmod 600 .env
```

예시:

```dotenv
NODE_ENV=production
PORT=3000
DATABASE_URL=postgresql://myapp:여기에_강한_DB_비밀번호@127.0.0.1:5432/myapp
SESSION_SECRET=openssl_rand_hex_32_결과
ADMIN_PASSWORD=별도의_강한_관리자_비밀번호
```

세션 키는 다음 명령으로 생성할 수 있습니다.

```bash
openssl rand -hex 32
```

### 5.5 설치, DB 스키마 적용, 빌드

```bash
set -a
source .env
set +a

npm ci
npm run db:push
npm run build
```

`npm run db:push`가 기존 테이블의 이름 변경 여부를 질문하면 내용을 확인하지 않은 상태에서 rename을 선택하지 마세요.

### 5.6 PM2로 앱 실행

```bash
set -a
source .env
set +a

pm2 start ecosystem.config.cjs
pm2 save
sudo env "PATH=$PATH" pm2 startup systemd -u "$USER" --hp "$HOME"
```

`pm2 startup`이 별도의 `sudo ...` 명령을 출력하면 그 명령을 한 번 실행한 뒤 다시 `pm2 save`를 실행합니다.

### 5.7 Nginx 설정

```bash
sudo cp deploy/nginx-gold-signal.conf /etc/nginx/sites-available/gold-signal
sudo ln -sfn /etc/nginx/sites-available/gold-signal \
  /etc/nginx/sites-enabled/gold-signal
sudo rm -f /etc/nginx/sites-enabled/default

sudo nginx -t
sudo systemctl reload nginx
```

### 5.8 Ubuntu 방화벽

```bash
sudo ufw allow OpenSSH
sudo ufw allow 'Nginx Full'
sudo ufw enable
sudo ufw status
```

AWS Lightsail 네트워킹 화면에서도 TCP 22, 80, 443만 허용하고 5432는 열지 마세요.

## 6. 기존 데이터 수동 이전

데이터 이전은 앱 시작 또는 PM2 재시작 시 자동 실행되지 않습니다. 아래 명령을 직접 실행할 때만 동작합니다.

필수 환경 변수:

- `SOURCE_DATABASE_URL`: 데이터를 가져올 기존 PostgreSQL DB
- `DATABASE_URL`: 데이터를 넣을 Lightsail 내부 PostgreSQL DB

먼저 앱과 자동 정산 작업을 잠시 멈춥니다.

```bash
pm2 stop gold-signal
```

환경 변수를 현재 터미널에 로드하고 소스 DB 주소를 설정합니다.

```bash
set -a
source .env
set +a

export SOURCE_DATABASE_URL='postgresql://기존사용자:기존비밀번호@기존호스트:5432/기존DB'
node scripts/migrate-data.js
```

화면에 경고가 나오면 대상 DB 주소를 확인하고 `MIGRATE`를 입력합니다.

자동화된 비대화형 실행이 꼭 필요한 경우에만 다음을 사용합니다.

```bash
MIGRATION_CONFIRM=YES node scripts/migrate-data.js
```

이 스크립트는 다음 순서로 동작합니다.

1. `pg_dump`로 소스 DB의 스키마와 데이터를 임시 파일에 추출
2. 대상 DB 연결 확인
3. `pg_restore --clean --single-transaction`으로 대상 DB 교체
4. 성공 또는 실패 후 임시 파일 삭제

주의:

- 대상 DB의 기존 테이블과 데이터가 교체됩니다.
- 소스와 대상 주소가 같으면 실행을 거부합니다.
- 접속 문자열은 출력할 때 비밀번호를 가립니다.
- 실패하면 즉시 중단하고 오류 코드를 반환합니다.

완료 후 앱을 다시 시작합니다.

```bash
pm2 start gold-signal
pm2 logs gold-signal --lines 100
```

## 7. 이후 코드 업데이트

```bash
cd ~/gold-signal
git pull
npm ci

set -a
source .env
set +a

npm run build
pm2 reload ecosystem.config.cjs --update-env
pm2 save
```

DB 스키마가 변경된 배포라면 앱 빌드 전에 변경 내용을 검토하고 다음을 실행합니다.

```bash
npm run db:push
```

## 8. 운영 명령어

```bash
# 상태
pm2 status

# 로그
pm2 logs gold-signal

# 재시작
pm2 restart gold-signal

# 중지
pm2 stop gold-signal

# PostgreSQL 상태
sudo systemctl status postgresql

# PostgreSQL 로그
sudo journalctl -u postgresql -n 100 --no-pager

# Nginx 설정 검사 및 재시작
sudo nginx -t
sudo systemctl reload nginx
```

## 9. HTTPS 적용

도메인의 DNS가 Lightsail 고정 IP를 가리킨 후 Certbot을 사용할 수 있습니다.

```bash
sudo apt-get install -y certbot python3-certbot-nginx
sudo certbot --nginx -d example.com -d www.example.com
sudo certbot renew --dry-run
```

## 10. 백업 권장 명령

```bash
mkdir -p ~/db-backups

set -a
source .env
set +a

pg_dump -Fc "$DATABASE_URL" \
  --no-owner \
  --no-privileges \
  -f "$HOME/db-backups/myapp-$(date +%F-%H%M%S).dump"
```

백업 파일에는 운영 데이터가 들어 있으므로 Git 저장소에 커밋하지 마세요.