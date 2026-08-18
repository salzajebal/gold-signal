import { execSync, exec } from "child_process";
import { promisify } from "util";

const execAsync = promisify(exec);

const GITHUB_TOKEN = process.env.GITHUB_PERSONAL_ACCESS_TOKEN || "";
const GITHUB_OWNER = "salzajebal";
const GITHUB_REPO = "rd-index";
const DB_SEED_PATH = "db-seed.sql";

function getGithubApiHeaders() {
  return {
    Authorization: `token ${GITHUB_TOKEN}`,
    Accept: "application/vnd.github.v3+json",
    "Content-Type": "application/json",
    "User-Agent": "rd-index-app",
  };
}

/**
 * 프로덕션 DB를 pg_dump로 덤프하여 GitHub에 db-seed.sql로 업로드
 */
export async function pushDbToGithub(): Promise<{ success: boolean; message: string }> {
  if (!GITHUB_TOKEN) {
    return { success: false, message: "GITHUB_PERSONAL_ACCESS_TOKEN 환경변수가 없습니다" };
  }

  const dbUrl = process.env.DATABASE_URL;
  if (!dbUrl) {
    return { success: false, message: "DATABASE_URL 환경변수가 없습니다" };
  }

  try {
    // pg_dump로 SQL 덤프 생성
    console.log("[githubDbSync] Running pg_dump...");
    const { stdout: sqlDump } = await execAsync(
      `pg_dump "${dbUrl}" --no-owner --no-acl --clean --if-exists`,
      { maxBuffer: 100 * 1024 * 1024 } // 100MB buffer
    );

    const content = Buffer.from(sqlDump).toString("base64");

    // 기존 파일 SHA 확인 (업데이트 시 필요)
    let sha: string | undefined;
    try {
      const checkRes = await fetch(
        `https://api.github.com/repos/${GITHUB_OWNER}/${GITHUB_REPO}/contents/${DB_SEED_PATH}`,
        { headers: getGithubApiHeaders() }
      );
      if (checkRes.ok) {
        const data = await checkRes.json() as any;
        sha = data.sha;
      }
    } catch {
      // 파일 없으면 새로 생성
    }

    // GitHub에 업로드
    const now = new Date().toLocaleString("ko-KR", { timeZone: "Asia/Seoul" });
    const body: any = {
      message: `DB backup ${now} (KST)`,
      content,
      branch: "main",
    };
    if (sha) body.sha = sha;

    const uploadRes = await fetch(
      `https://api.github.com/repos/${GITHUB_OWNER}/${GITHUB_REPO}/contents/${DB_SEED_PATH}`,
      {
        method: "PUT",
        headers: getGithubApiHeaders(),
        body: JSON.stringify(body),
      }
    );

    if (!uploadRes.ok) {
      const err = await uploadRes.json() as any;
      return { success: false, message: `GitHub 업로드 실패: ${err.message}` };
    }

    const sqlSizeMB = (sqlDump.length / 1024 / 1024).toFixed(2);
    console.log(`[githubDbSync] DB pushed to GitHub (${sqlSizeMB}MB)`);
    return { success: true, message: `DB 백업 완료 (${sqlSizeMB}MB) → GitHub/${DB_SEED_PATH}` };
  } catch (err: any) {
    console.error("[githubDbSync] pushDbToGithub error:", err);
    return { success: false, message: err.message };
  }
}

