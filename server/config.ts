export const DEFAULT_DATABASE_URL =
  "postgresql://postgres:password@localhost:5432/myapp";

export const DATABASE_URL =
  process.env.DATABASE_URL?.trim() || DEFAULT_DATABASE_URL;

export const PORT = Number.parseInt(process.env.PORT || "3000", 10);
export const HOST = "0.0.0.0";

if (!Number.isInteger(PORT) || PORT < 1 || PORT > 65535) {
  throw new Error(`Invalid PORT value: ${process.env.PORT}`);
}