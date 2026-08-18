export function Opulent() {
  return (
    <div
      className="min-h-screen w-full flex flex-col"
      style={{
        background: "linear-gradient(160deg, #FEFCF5 0%, #FDF5DC 50%, #FEFCF5 100%)",
        fontFamily: "'Georgia', 'Cormorant Garamond', serif"
      }}
    >
      {/* Nav with cream bar */}
      <nav style={{
        background: "rgba(255,252,245,0.95)",
        borderBottom: "1px solid #E0C97A",
        padding: "14px 48px",
        display: "flex", alignItems: "center", justifyContent: "space-between",
        backdropFilter: "blur(8px)"
      }}>
        <div style={{ display: "flex", alignItems: "center", gap: 14 }}>
          {/* Ornate GS badge */}
          <div style={{
            width: 48, height: 48,
            borderRadius: 10,
            background: "linear-gradient(145deg, #F5E6A0 0%, #D4A417 40%, #9A6E0C 100%)",
            border: "1.5px solid #E8C44A",
            display: "flex", alignItems: "center", justifyContent: "center",
            boxShadow: "inset 0 1px 0 rgba(255,255,255,0.4), 0 4px 16px rgba(180,130,20,0.35)",
          }}>
            <svg width="32" height="28" viewBox="0 0 32 28" fill="none">
              <text x="16" y="21" textAnchor="middle" fontFamily="Georgia,serif" fontSize="18" fontWeight="800" fill="white">GS</text>
            </svg>
          </div>
          <div>
            <div style={{ fontSize: 16, fontWeight: 700, color: "#2A1F06", letterSpacing: 2.5 }}>GOLD-SIGNAL</div>
            <div style={{ fontSize: 8.5, color: "#C9960C", letterSpacing: 3.5, fontFamily: "sans-serif", fontWeight: 600 }}>PREMIUM TRADING</div>
          </div>
        </div>
        <div style={{ display: "flex", gap: 24, alignItems: "center" }}>
          {["옵션거래", "거래내역", "입금/출금", "공지사항", "고객센터"].map(item => (
            <span key={item} style={{ fontSize: 12.5, color: "#4A3520", fontFamily: "sans-serif", cursor: "pointer", letterSpacing: 0.3 }}>{item}</span>
          ))}
          <div style={{ width: 1, height: 20, background: "#D4B86A" }} />
          <button style={{
            background: "linear-gradient(135deg, #C9960C, #E8C44A, #C9960C)",
            color: "#fff", border: "none", borderRadius: 8,
            padding: "9px 24px", fontSize: 12.5, fontWeight: 700, cursor: "pointer",
            fontFamily: "sans-serif", letterSpacing: 0.8,
            boxShadow: "0 3px 14px rgba(180,130,20,0.40)"
          }}>거래하기</button>
        </div>
      </nav>

      {/* Hero */}
      <main style={{ flex: 1, display: "flex", flexDirection: "column", alignItems: "center", justifyContent: "center", padding: "60px 24px 80px", textAlign: "center" }}>
        
        {/* Top label with ornament */}
        <div style={{ display: "flex", alignItems: "center", gap: 14, marginBottom: 36 }}>
          <svg width="40" height="10" viewBox="0 0 40 10"><path d="M0 5 Q10 0 20 5 Q30 10 40 5" stroke="#C9960C" strokeWidth="1" fill="none"/></svg>
          <span style={{ fontSize: 10.5, letterSpacing: 4, color: "#C9960C", fontFamily: "sans-serif", fontWeight: 700 }}>GLOBAL FOREX TRADING</span>
          <svg width="40" height="10" viewBox="0 0 40 10"><path d="M0 5 Q10 10 20 5 Q30 0 40 5" stroke="#C9960C" strokeWidth="1" fill="none"/></svg>
        </div>

        {/* Main Logo Icon */}
        <div style={{ position: "relative", marginBottom: 28, display: "inline-block" }}>
          {/* Outer ring */}
          <div style={{
            width: 120, height: 120, borderRadius: "50%",
            border: "1px solid rgba(180,130,20,0.30)",
            position: "absolute", top: -12, left: -12,
          }} />
          {/* Main badge */}
          <div style={{
            width: 96, height: 96, borderRadius: 20,
            background: "linear-gradient(145deg, #F8E9A0 0%, #D4A417 35%, #8B6208 100%)",
            display: "flex", alignItems: "center", justifyContent: "center",
            boxShadow: "0 12px 40px rgba(160,120,10,0.45), inset 0 1px 0 rgba(255,255,255,0.5)",
            border: "1px solid #E8C44A",
          }}>
            <svg width="56" height="48" viewBox="0 0 56 48" fill="none">
              <text x="28" y="36" textAnchor="middle" fontFamily="Georgia,serif" fontSize="32" fontWeight="800" fill="white">GS</text>
            </svg>
          </div>
        </div>

        {/* Gold title */}
        <h1 style={{
          fontSize: 76, fontWeight: 700, letterSpacing: 8, lineHeight: 1,
          background: "linear-gradient(180deg, #F0D060 0%, #C9960C 30%, #8B6208 55%, #C9960C 75%, #E8C44A 100%)",
          WebkitBackgroundClip: "text", WebkitTextFillColor: "transparent",
          backgroundClip: "text", marginBottom: 6,
          filter: "drop-shadow(0 2px 8px rgba(180,130,20,0.25))"
        }}>GOLD-SIGNAL</h1>

        {/* Thin ornament line */}
        <div style={{ display: "flex", alignItems: "center", gap: 12, margin: "14px auto 20px", width: "fit-content" }}>
          <div style={{ width: 60, height: 1, background: "linear-gradient(90deg, transparent, #C9960C)" }} />
          <div style={{ width: 5, height: 5, borderRadius: "50%", background: "#C9960C" }} />
          <div style={{ width: 60, height: 1, background: "linear-gradient(90deg, #C9960C, transparent)" }} />
        </div>

        {/* Subtitle */}
        <p style={{ fontSize: 22, color: "#2A1F06", fontWeight: 400, letterSpacing: 1.5, marginBottom: 12 }}>
          가장 신뢰받는 글로벌 선도거래
        </p>
        <p style={{ fontSize: 14.5, color: "#7A6240", lineHeight: 1.8, marginBottom: 44, fontFamily: "sans-serif" }}>
          안전하고 투명한 시스템으로<br/>빠르고 편리한 외환 옵션 거래를 제공합니다.
        </p>

        {/* Currency symbols */}
        <div style={{ display: "flex", alignItems: "center", gap: 20, marginBottom: 44 }}>
          {[["$", "달러"], ["€", "유로"], ["¥", "엔화"], ["A$", "호주달러"]].map(([sym, name], i) => (
            <div key={i} style={{ display: "flex", alignItems: "center", gap: i === 0 ? 0 : 20 }}>
              {i > 0 && <div style={{ width: 4, height: 4, borderRadius: "50%", background: "#C9960C", marginRight: -12 }} />}
              <span style={{ fontSize: 14, color: "#5A4020", fontFamily: "sans-serif", marginLeft: i > 0 ? 20 : 0 }}>
                <span style={{ color: "#C9960C", marginRight: 4 }}>{sym}</span>{name}
              </span>
            </div>
          ))}
        </div>

        {/* CTA button */}
        <button style={{
          background: "linear-gradient(135deg, #9A6E0C 0%, #C9960C 30%, #E8C44A 55%, #D4A417 75%, #8B6208 100%)",
          color: "#fff", border: "1px solid #E8C44A",
          borderRadius: 14, padding: "18px 72px",
          fontSize: 18, fontWeight: 700, cursor: "pointer",
          letterSpacing: 1.5,
          boxShadow: "0 8px 36px rgba(160,120,10,0.45), inset 0 1px 0 rgba(255,255,255,0.25)",
        }}>거래 시작하기</button>

        {/* Bottom trust row */}
        <div style={{ marginTop: 52, display: "flex", gap: 40, alignItems: "center" }}>
          {[
            { icon: "🛡", label: "자산 안전 보장" },
            { icon: "📊", label: "실시간 시세 제공" },
            { icon: "🕐", label: "24/7 무중단 거래" },
          ].map(({ icon, label }) => (
            <div key={label} style={{ textAlign: "center" }}>
              <div style={{
                width: 48, height: 48, borderRadius: 12, margin: "0 auto 8px",
                background: "rgba(201,150,12,0.10)", border: "1px solid rgba(201,150,12,0.30)",
                display: "flex", alignItems: "center", justifyContent: "center", fontSize: 22
              }}>{icon}</div>
              <div style={{ fontSize: 11, color: "#7A6240", letterSpacing: 0.5, fontFamily: "sans-serif" }}>{label}</div>
            </div>
          ))}
        </div>
      </main>

      {/* Marquee-style footer */}
      <div style={{ background: "#2A1F06", padding: "12px 0", overflow: "hidden" }}>
        <div style={{ display: "flex", gap: 48, justifyContent: "center" }}>
          {["GOLD-SIGNAL", "•", "GLOBAL FOREX TRADING", "•", "PREMIUM OPTION TRADING", "•", "REAL-TIME SIGNALS"].map((t, i) => (
            <span key={i} style={{ fontSize: 10, color: i % 2 === 0 ? "#C9960C" : "#6A5030", letterSpacing: 2.5, whiteSpace: "nowrap" as const }}>{t}</span>
          ))}
        </div>
      </div>
    </div>
  );
}
