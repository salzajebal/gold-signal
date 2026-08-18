export function Editorial() {
  return (
    <div
      className="min-h-screen w-full flex flex-col"
      style={{ background: "#FFFFFF", fontFamily: "'Helvetica Neue', Arial, sans-serif" }}
    >
      {/* Nav */}
      <nav style={{ borderBottom: "2px solid #1A1208", padding: "16px 48px", display: "flex", alignItems: "center", justifyContent: "space-between" }}>
        <div style={{ display: "flex", alignItems: "center", gap: 12 }}>
          <div style={{
            width: 40, height: 40, borderRadius: 8,
            border: "2px solid #C9960C",
            display: "flex", alignItems: "center", justifyContent: "center",
          }}>
            <span style={{ fontSize: 14, fontWeight: 900, color: "#C9960C", letterSpacing: 0.5 }}>GS</span>
          </div>
          <div>
            <span style={{ fontSize: 16, fontWeight: 900, color: "#1A1208", letterSpacing: 2 }}>GOLD</span>
            <span style={{ fontSize: 16, fontWeight: 300, color: "#C9960C", letterSpacing: 2 }}>-SIGNAL</span>
          </div>
        </div>
        <div style={{ display: "flex", gap: 32, alignItems: "center" }}>
          {["옵션거래", "거래내역", "입금/출금", "공지사항"].map(item => (
            <span key={item} style={{ fontSize: 12, color: "#1A1208", letterSpacing: 1.5, fontWeight: 600, textTransform: "uppercase" as const }}>{item}</span>
          ))}
          <button style={{
            border: "2px solid #C9960C", background: "transparent",
            color: "#C9960C", padding: "8px 24px", fontSize: 12,
            fontWeight: 700, letterSpacing: 1.5, cursor: "pointer", borderRadius: 4
          }}>로그인</button>
        </div>
      </nav>

      {/* Hero: asymmetric split */}
      <div style={{ flex: 1, display: "flex", minHeight: 640 }}>
        {/* Left: Text content */}
        <div style={{ flex: 1, padding: "72px 56px", display: "flex", flexDirection: "column", justifyContent: "center" }}>
          <div style={{ display: "flex", alignItems: "center", gap: 12, marginBottom: 32 }}>
            <div style={{ width: 32, height: 2, background: "#C9960C" }} />
            <span style={{ fontSize: 10, letterSpacing: 4, color: "#C9960C", fontWeight: 700 }}>GLOBAL FOREX TRADING</span>
          </div>

          <h1 style={{ fontSize: 72, fontWeight: 900, lineHeight: 1, letterSpacing: -1, color: "#1A1208", marginBottom: 0 }}>
            GOLD
          </h1>
          <h1 style={{
            fontSize: 72, fontWeight: 300, lineHeight: 1, letterSpacing: -1, marginBottom: 24,
            color: "transparent",
            WebkitTextStroke: "2px #C9960C",
          }}>
            SIGNAL
          </h1>

          <p style={{ fontSize: 18, color: "#5A4A2A", lineHeight: 1.7, marginBottom: 12, maxWidth: 380 }}>
            가장 신뢰받는 글로벌 선도거래
          </p>
          <p style={{ fontSize: 13, color: "#8A7250", lineHeight: 1.8, marginBottom: 48, maxWidth: 360 }}>
            안전하고 투명한 시스템으로 빠르고 편리한<br />외환 옵션 거래를 제공합니다.
          </p>

          <div style={{ display: "flex", gap: 16 }}>
            <button style={{
              background: "#1A1208", color: "#C9960C",
              border: "none", padding: "16px 40px", fontSize: 13,
              fontWeight: 700, letterSpacing: 2, cursor: "pointer", borderRadius: 4
            }}>거래 시작하기</button>
            <button style={{
              background: "transparent", color: "#1A1208",
              border: "2px solid #1A1208", padding: "16px 32px", fontSize: 13,
              fontWeight: 600, letterSpacing: 1, cursor: "pointer", borderRadius: 4
            }}>자세히 보기</button>
          </div>

          <div style={{ marginTop: 56, display: "flex", gap: 32 }}>
            {[["4,378", "GOLD 현재가"], ["63,400", "BTC 현재가"], ["1.3497", "GBP 현재가"]].map(([val, label]) => (
              <div key={label}>
                <div style={{ fontSize: 22, fontWeight: 800, color: "#C9960C", fontVariantNumeric: "tabular-nums" }}>{val}</div>
                <div style={{ fontSize: 10, color: "#8A7250", letterSpacing: 1.5, marginTop: 2 }}>{label}</div>
              </div>
            ))}
          </div>
        </div>

        {/* Right: Gold signal visualization */}
        <div style={{
          width: 480,
          background: "linear-gradient(160deg, #FDF6E3 0%, #F5E9C0 60%, #EDD88A 100%)",
          display: "flex", flexDirection: "column", alignItems: "center", justifyContent: "center",
          position: "relative", overflow: "hidden"
        }}>
          {/* Big GS mark */}
          <div style={{
            width: 180, height: 180,
            borderRadius: 36,
            background: "linear-gradient(145deg, #C9960C 0%, #E8C44A 50%, #9A6E0C 100%)",
            display: "flex", alignItems: "center", justifyContent: "center",
            boxShadow: "0 20px 60px rgba(180,130,20,0.40)",
            marginBottom: 32,
          }}>
            <span style={{ fontSize: 84, fontWeight: 900, color: "#fff", letterSpacing: -2, fontFamily: "Georgia,serif" }}>GS</span>
          </div>

          {/* Mini chart bars */}
          <div style={{ display: "flex", alignItems: "flex-end", gap: 6, height: 64 }}>
            {[40, 55, 35, 70, 50, 80, 60, 90, 65, 100].map((h, i) => (
              <div key={i} style={{
                width: 18, height: `${h * 0.64}px`,
                background: i === 9
                  ? "linear-gradient(180deg, #C9960C, #9A6E0C)"
                  : i > 5
                    ? `rgba(180,130,20,${0.4 + i * 0.06})`
                    : "rgba(180,130,20,0.2)",
                borderRadius: 4
              }} />
            ))}
          </div>
          <p style={{ marginTop: 16, fontSize: 11, color: "#9A6E0C", letterSpacing: 2 }}>REAL-TIME SIGNALS</p>

          {/* Decorative ring */}
          <div style={{
            position: "absolute", top: -60, right: -60,
            width: 240, height: 240, borderRadius: "50%",
            border: "1px solid rgba(180,130,20,0.20)"
          }} />
          <div style={{
            position: "absolute", bottom: -40, left: -40,
            width: 180, height: 180, borderRadius: "50%",
            border: "1px solid rgba(180,130,20,0.15)"
          }} />
        </div>
      </div>

      {/* Bottom bar */}
      <div style={{ borderTop: "1px solid #E8DFC8", padding: "16px 48px", display: "flex", justifyContent: "space-between", alignItems: "center" }}>
        <span style={{ fontSize: 11, color: "#8A7250", letterSpacing: 1 }}>© 2026 GOLD-SIGNAL. ALL RIGHTS RESERVED.</span>
        <div style={{ display: "flex", gap: 24 }}>
          {["$ 달러", "€ 유로", "¥ 엔화", "A$ 호주달러"].map(s => (
            <span key={s} style={{ fontSize: 11, color: "#C9960C", letterSpacing: 0.5 }}>{s}</span>
          ))}
        </div>
      </div>
    </div>
  );
}
