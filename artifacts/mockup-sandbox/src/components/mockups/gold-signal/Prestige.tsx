/* ─── GOLD-SIGNAL · Classic Prestige v4 ─────────────────────────────────────
   v4: NO gradients anywhere — flat solid colors only.
   Depth comes from line weight, layering, and contrast, not gradients.
   ─────────────────────────────────────────────────────────────────────────── */

/* Flat gold system
   gold    : #C4A028  main gold (warm, contemporary)
   goldDk  : #8A6C10  dark gold (depth on strokes / secondary)
   goldLt  : #DEB840  lighter accent (GS text on dark face)
   face    : #1A1206  near-black badge face (contrast layer)
   ink     : #111111  main body text
   sub     : #4A3D18  secondary text
   bg      : #FFFFFF  pure white background
*/
const C = {
  gold   : "#C4A028",
  goldDk : "#8A6C10",
  goldLt : "#DEB840",
  face   : "#1A1206",
  ink    : "#111111",
  sub    : "#4A3D18",
  bg     : "#FFFFFF",
} as const;

/* ── Flat Precision Emblem ───────────────────────────────────────────────────
   No fill gradients. Depth via:
   · Dark solid face polygon (high contrast)
   · Gold stroke line-work (ring, bezel, ticks, rules)
   · Single-color GS text on dark face
   ─────────────────────────────────────────────────────────────────────────── */
function GsEmblem({ size = 120 }: { size?: number }) {
  const s   = size;
  const cx  = s / 2;
  const cy  = s / 2;
  const R   = s / 2 - 2;     // outer ring
  const bR  = R - 7;         // bezel ring
  const fR  = bR - 5;        // octagon "inradius" approximation

  // Octagon points helper
  const oct = (r: number, offset = -22.5) =>
    Array.from({ length: 8 }, (_, i) => {
      const a = (i * 45 + offset) * Math.PI / 180;
      return `${(cx + r * Math.cos(a)).toFixed(2)},${(cy + r * Math.sin(a)).toFixed(2)}`;
    }).join(" ");

  // Tick marks (12 positions)
  const ticks = Array.from({ length: 12 }, (_, i) => {
    const a     = (i * 30) * Math.PI / 180;
    const major = i % 3 === 0;
    const r1    = R - (major ? 7 : 4);
    return (
      <line key={i}
        x1={(cx + r1 * Math.cos(a)).toFixed(2)}
        y1={(cy + r1 * Math.sin(a)).toFixed(2)}
        x2={(cx + R  * Math.cos(a)).toFixed(2)}
        y2={(cy + R  * Math.sin(a)).toFixed(2)}
        stroke={C.gold}
        strokeWidth={major ? 1.8 : 0.9}
      />
    );
  });

  // Cardinal diamonds
  const diamonds = [0, 90, 180, 270].map(deg => {
    const a  = deg * Math.PI / 180;
    const px = cx + (bR - 0.5) * Math.cos(a);
    const py = cy + (bR - 0.5) * Math.sin(a);
    const d  = size < 60 ? 2 : 3;
    return (
      <polygon key={deg}
        points={`${px},${py - d} ${px + d},${py} ${px},${py + d} ${px - d},${py}`}
        fill={C.goldLt}
      />
    );
  });

  const fs = size < 60 ? size * 0.26 : size * 0.28;

  return (
    <svg width={s} height={s} viewBox={`0 0 ${s} ${s}`} fill="none">
      {/* 1 — Outer circle */}
      <circle cx={cx} cy={cy} r={R} stroke={C.gold} strokeWidth="0.9" />

      {/* 2 — Ticks */}
      {ticks}

      {/* 3 — Bezel double ring */}
      <circle cx={cx} cy={cy} r={bR}     stroke={C.gold}   strokeWidth="1.4" />
      <circle cx={cx} cy={cy} r={bR - 3} stroke={C.goldDk} strokeWidth="0.6" />

      {/* 4 — Octagon face (solid dark) */}
      <polygon points={oct(fR)} fill={C.face} />

      {/* 5 — Octagon border */}
      <polygon points={oct(fR)} fill="none" stroke={C.gold} strokeWidth="0.8" />

      {/* 6 — Cardinal diamonds on bezel */}
      {diamonds}

      {/* 7 — Horizontal rule above GS */}
      <line
        x1={cx - fR * 0.55} y1={cy - fs * 0.3}
        x2={cx + fR * 0.55} y2={cy - fs * 0.3}
        stroke={C.goldDk} strokeWidth="0.7"
      />

      {/* 8 — GS monogram */}
      <text
        x={cx} y={cy + fs * 0.55}
        textAnchor="middle"
        fontFamily="'Playfair Display', Georgia, serif"
        fontSize={fs}
        fontWeight="900"
        fill={C.goldLt}
        letterSpacing="1.5"
      >GS</text>

      {/* 9 — Horizontal rule below GS */}
      <line
        x1={cx - fR * 0.40} y1={cy + fs * 0.78}
        x2={cx + fR * 0.40} y2={cy + fs * 0.78}
        stroke={C.goldDk} strokeWidth="0.5"
      />
    </svg>
  );
}

export function Prestige() {
  return (
    <div style={{
      minHeight: "100vh",
      width: "100%",
      display: "flex",
      flexDirection: "column",
      background: C.bg,
      fontFamily: "'Playfair Display', Georgia, serif",
      WebkitFontSmoothing: "antialiased",
    }}>

      {/* ── NAV ── */}
      <nav style={{
        background: C.bg,
        borderBottom: `1px solid rgba(196,160,40,0.22)`,
        padding: "0 52px",
        height: 66,
        display: "flex",
        alignItems: "center",
        justifyContent: "space-between",
      }}>
        <div style={{ display: "flex", alignItems: "center", gap: 12 }}>
          <GsEmblem size={40} />
          <div>
            <div style={{
              fontSize: 13.5, fontWeight: 700, letterSpacing: 3.5,
              color: C.face, fontFamily: "'Playfair Display', serif",
            }}>GOLD-SIGNAL</div>
            <div style={{
              fontSize: 7, letterSpacing: 4, color: C.goldDk,
              fontFamily: "sans-serif", fontWeight: 600, marginTop: 1,
            }}>PREMIUM TRADING</div>
          </div>
        </div>

        <div style={{ display: "flex", alignItems: "center", gap: 30 }}>
          {["옵션거래","거래내역","입금/출금","공지사항","고객센터"].map(item => (
            <span key={item} style={{
              fontSize: 12.5, color: C.ink,
              fontFamily: "sans-serif", cursor: "pointer", letterSpacing: 0.2,
            }}>{item}</span>
          ))}
          <button style={{
            background: "transparent",
            border: `1.5px solid ${C.gold}`,
            color: C.goldDk,
            borderRadius: 3,
            padding: "7px 20px",
            fontSize: 11.5, fontWeight: 700,
            fontFamily: "sans-serif", letterSpacing: 2,
            cursor: "pointer",
          }}>거래하기</button>
        </div>
      </nav>

      {/* ── HERO ── */}
      <main style={{
        flex: 1,
        display: "flex",
        flexDirection: "column",
        alignItems: "center",
        justifyContent: "center",
        textAlign: "center",
        padding: "64px 32px 88px",
      }}>

        {/* Eyebrow */}
        <div style={{ display: "flex", alignItems: "center", gap: 14, marginBottom: 48 }}>
          <div style={{ width: 36, height: 1, background: C.gold }} />
          <span style={{
            fontSize: 9, letterSpacing: 5.5, color: C.goldDk,
            fontFamily: "sans-serif", fontWeight: 700,
          }}>GLOBAL FOREX TRADING</span>
          <div style={{ width: 36, height: 1, background: C.gold }} />
        </div>

        {/* Hero emblem */}
        <div style={{ marginBottom: 40 }}>
          <GsEmblem size={128} />
        </div>

        {/* Wordmark — solid gold, no gradient */}
        <h1 style={{
          margin: 0,
          fontSize: 80,
          fontWeight: 900,
          letterSpacing: 10,
          lineHeight: 1,
          fontFamily: "'Playfair Display', Georgia, serif",
          color: C.gold,
        }}>GOLD-SIGNAL</h1>

        {/* Underline — single solid line */}
        <div style={{
          margin: "20px auto 28px",
          width: 180,
          height: 1,
          background: C.gold,
        }} />

        {/* Tagline */}
        <p style={{
          fontSize: 19.5, fontWeight: 400, letterSpacing: 1.2, marginBottom: 14,
          color: C.ink, fontFamily: "'Playfair Display', serif",
        }}>가장 신뢰받는 글로벌 선도거래</p>

        {/* Body */}
        <p style={{
          fontSize: 13.5, color: C.sub, lineHeight: 1.9,
          marginBottom: 48, fontFamily: "sans-serif", letterSpacing: 0.1,
        }}>
          안전하고 투명한 시스템으로<br />
          빠르고 편리한 외환 옵션 거래를 제공합니다.
        </p>

        {/* Currency row */}
        <div style={{ display: "flex", alignItems: "center", marginBottom: 48, fontFamily: "sans-serif" }}>
          {[["$","달러"],["€","유로"],["¥","엔화"],["A$","호주달러"]].map(([sym,name],i) => (
            <div key={i} style={{ display: "flex", alignItems: "center" }}>
              {i > 0 && (
                <span style={{
                  display: "inline-block",
                  width: 3, height: 3, borderRadius: "50%",
                  background: C.gold, margin: "0 18px",
                }} />
              )}
              <span style={{ fontSize: 13.5, color: C.gold, marginRight: 5, fontWeight: 600 }}>{sym}</span>
              <span style={{ fontSize: 13, color: C.sub }}>{name}</span>
            </div>
          ))}
        </div>

        {/* CTA — solid flat button */}
        <button style={{
          background: C.gold,
          border: "none",
          borderRadius: 4,
          padding: "16px 76px",
          fontSize: 13.5,
          fontWeight: 700,
          color: "#FFFFFF",
          fontFamily: "sans-serif",
          letterSpacing: 3.5,
          cursor: "pointer",
          boxShadow: "0 4px 18px rgba(61,40,0,0.22)",
        }}>
          거래 시작하기
        </button>

        {/* Trust icons */}
        <div style={{ marginTop: 56, display: "flex", gap: 56 }}>
          {["안전 보장","실시간 시세","24/7 거래"].map(label => (
            <div key={label} style={{ display: "flex", flexDirection: "column", alignItems: "center", gap: 8 }}>
              <div style={{
                width: 38, height: 38, borderRadius: 6,
                border: `1px solid ${C.gold}`,
                display: "flex", alignItems: "center", justifyContent: "center",
              }}>
                <svg width="14" height="14" viewBox="0 0 14 14">
                  <polygon
                    points="7,0 8.5,5 13.5,5 9.5,8 11,13 7,10 3,13 4.5,8 0.5,5 5.5,5"
                    fill={C.gold}
                  />
                </svg>
              </div>
              <span style={{
                fontSize: 10, color: C.goldDk, letterSpacing: 1,
                fontFamily: "sans-serif", fontWeight: 500,
              }}>{label}</span>
            </div>
          ))}
        </div>
      </main>

      {/* ── FOOTER ── */}
      <div style={{
        background: C.face,
        padding: "12px 52px",
        display: "flex", alignItems: "center", justifyContent: "center", gap: 16,
      }}>
        <div style={{ width: 1, height: 10, background: C.goldDk }} />
        <span style={{
          fontSize: 9, color: C.gold, letterSpacing: 4,
          fontFamily: "sans-serif", fontWeight: 600,
        }}>GOLD-SIGNAL PREMIUM TRADING</span>
        <div style={{ width: 1, height: 10, background: C.goldDk }} />
        <span style={{
          fontSize: 9, color: C.goldDk, letterSpacing: 2, fontFamily: "sans-serif",
        }}>글로벌 외환 옵션 거래의 새로운 기준</span>
        <div style={{ width: 1, height: 10, background: C.goldDk }} />
      </div>
    </div>
  );
}
