import { spawn } from "node:child_process";
import { mkdtemp, rm } from "node:fs/promises";
import { tmpdir } from "node:os";
import path from "node:path";
import readline from "node:readline/promises";
import { stdin as input, stdout as output } from "node:process";

const DEFAULT_TARGET_DATABASE_URL =
  "postgresql://postgres:password@localhost:5432/myapp";

const sourceUrl =
  process.env.SOURCE_DATABASE_URL ||
  process.env.MIGRATION_SOURCE_DATABASE_URL;
const targetUrl = process.env.DATABASE_URL || DEFAULT_TARGET_DATABASE_URL;

function redactDatabaseUrl(value) {
  try {
    const url = new URL(value);
    if (url.password) url.password = "***";
    return url.toString();
  } catch {
    return "(invalid database URL)";
  }
}

function run(command, args) {
  return new Promise((resolve, reject) => {
    const child = spawn(command, args, {
      stdio: "inherit",
      env: process.env,
    });

    child.on("error", (error) => {
      if (error.code === "ENOENT") {
        reject(
          new Error(
            `${command} 명령을 찾을 수 없습니다. postgresql-client를 설치하세요.`,
          ),
        );
        return;
      }
      reject(error);
    });

    child.on("exit", (code, signal) => {
      if (code === 0) {
        resolve();
      } else {
        reject(
          new Error(
            `${command} 실행 실패 (code=${code ?? "null"}, signal=${signal ?? "none"})`,
          ),
        );
      }
    });
  });
}

async function confirmMigration() {
  if (process.env.MIGRATION_CONFIRM === "YES") return;

  if (!input.isTTY) {
    throw new Error(
      "비대화형 실행에서는 MIGRATION_CONFIRM=YES를 지정해야 합니다.",
    );
  }

  const rl = readline.createInterface({ input, output });
  try {
    const answer = await rl.question(
      "대상 DB의 기존 테이블과 데이터가 교체됩니다. 계속하려면 MIGRATE를 입력하세요: ",
    );
    if (answer.trim() !== "MIGRATE") {
      throw new Error("사용자가 데이터 이전을 취소했습니다.");
    }
  } finally {
    rl.close();
  }
}

async function main() {
  if (!sourceUrl) {
    throw new Error(
      "SOURCE_DATABASE_URL 환경 변수가 필요합니다. 기존 DB 주소를 설정한 뒤 다시 실행하세요.",
    );
  }

  if (sourceUrl === targetUrl) {
    throw new Error("소스 DB와 대상 DB가 같습니다. 데이터 이전을 중단합니다.");
  }

  console.log(`소스 DB: ${redactDatabaseUrl(sourceUrl)}`);
  console.log(`대상 DB: ${redactDatabaseUrl(targetUrl)}`);
  await confirmMigration();

  const workDir = await mkdtemp(path.join(tmpdir(), "myapp-db-migration-"));
  const dumpFile = path.join(workDir, "source.dump");

  try {
    console.log("1/3 소스 DB 백업 생성 중...");
    await run("pg_dump", [
      "--format=custom",
      "--no-owner",
      "--no-privileges",
      "--file",
      dumpFile,
      "--dbname",
      sourceUrl,
    ]);

    console.log("2/3 대상 DB 연결 확인 중...");
    await run("psql", [targetUrl, "-v", "ON_ERROR_STOP=1", "-c", "SELECT 1"]);

    console.log("3/3 대상 DB에 스키마와 데이터 복원 중...");
    await run("pg_restore", [
      "--clean",
      "--if-exists",
      "--single-transaction",
      "--no-owner",
      "--no-privileges",
      "--exit-on-error",
      "--dbname",
      targetUrl,
      dumpFile,
    ]);

    console.log("데이터 이전이 완료되었습니다.");
  } finally {
    await rm(workDir, { recursive: true, force: true });
  }
}

main().catch((error) => {
  console.error(`데이터 이전 실패: ${error.message}`);
  process.exit(1);
});