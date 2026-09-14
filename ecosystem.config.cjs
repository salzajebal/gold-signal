module.exports = {
  apps: [
    {
      name: "gold-signal",
      script: "dist/index.cjs",
      cwd: __dirname,
      instances: 1,
      exec_mode: "fork",
      autorestart: true,
      watch: false,
      max_memory_restart: "1G",
      kill_timeout: 10000,
      listen_timeout: 15000,
      max_restarts: 10,
      min_uptime: "10s",
      env: {
        NODE_ENV: "production",
        PORT: process.env.PORT || "3000",
        DATABASE_URL:
          process.env.DATABASE_URL ||
          "postgresql://postgres:password@localhost:5432/myapp",
        SESSION_SECRET: process.env.SESSION_SECRET,
        ADMIN_PASSWORD: process.env.ADMIN_PASSWORD,
      },
    },
  ],
};