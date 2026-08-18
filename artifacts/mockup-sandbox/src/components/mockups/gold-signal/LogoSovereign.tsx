/* Logo Concept 3 — SOVEREIGN
   Icon: A minimal three-arc crown where the center peak ends in a signal dot.
   Pure line work — no fills, only strokes.
   Concept: Regal authority, number-one market position, premium brand signal.
*/

const G    = "#C4A028";
const Gdk  = "#8A6C10";
const Face = "#1A1206";

function SovereignIcon({ size = 80 }: { size?: number }) {
  const s  = size;
  const cx = s / 2;
  const sw = s * 0.032; // stroke weight

  // Crown geometry — proportional to size
  const base    = s * 0.78;  // base width
  const bx      = (s - base) / 2;
  const by      = s * 0.72;  // base Y
  const midY    = s * 0.56;  // where arcs start from

  // Three peaks
  const leftPeakX  = bx + base * 0.12;
  const leftPeakY  = s * 0.38;
  const midPeakX   = cx;
  const midPeakY   = s * 0.18;  // tallest — center
  const rightPeakX = bx + base * 0.88;
  const rightPeakY = s * 0.38;

  // Flare points on base line (where peaks meet base)
  const lFlareX = bx + base * 0.28;
  const rFlareX = bx + base * 0.72;

  // Crown path: base → left side up → left peak → down → mid up → mid peak → down → right → right peak → down → base
  const crownPath = [
    `M${bx},${by}`,
    `L${leftPeakX},${leftPeakY}`,
    `L${lFlareX},${midY}`,
    `L${midPeakX},${midPeakY + s * 0.04}`,  // slight indent before center peak
    `L${midPeakX},${midPeakY + s * 0.04}`,
    `L${cx},${midPeakY}`,
    `L${rFlareX},${midY}`,
    `L${rightPeakX},${rightPeakY}`,
    `L${bx + base},${by}`,
  ].join(" ");

  // Horizontal base bar
  const basePath = `M${bx},${by} L${bx + base},${by}`;

  // Signal dot at center peak (slightly above the peak)
  const dotR = s * 0.04;
  const dotCy = midPeakY - dotR * 0.5;

  // Small notch dots on base (decorative)
  const notchY = by + s * 0.04;

  return (
    <svg width={s} height={s} viewBox={`0 0 ${s} ${s}`} fill="none">
      {/* Crown silhouette */}
      <path d={crownPath} stroke={G} strokeWidth={sw} strokeLinejoin="miter" strokeLinecap="round" />
      {/* Base bar */}
      <line x1={bx} y1={by} x2={bx + base} y2={by} stroke={G} strokeWidth={sw * 1.4} strokeLinecap="round" />
      {/* Bottom fill bar */}
      <line x1={bx} y1={notchY} x2={bx + base} y2={notchY} stroke={G} strokeWidth={sw * 0.6} strokeOpacity="0.4" />

      {/* Signal dot at center peak */}
      <circle cx={cx} cy={dotCy} r={dotR} fill={G} />
      {/* Tiny pulse lines radiating from dot */}
      {[-1, 0, 1].map(i => (
        <line key={i}
          x1={cx + i * s * 0.07} y1={dotCy + dotR * 1.8}
          x2={cx + i * s * 0.07} y2={dotCy + dotR * 3.2}
          stroke={G} strokeWidth={sw * 0.55} strokeOpacity={1 - Math.abs(i) * 0.4}
        />
      ))}

      {/* Left peak ornament dot */}
      <circle cx={leftPeakX}  cy={leftPeakY}  r={s * 0.025} fill={G} fillOpacity="0.7" />
      {/* Right peak ornament dot */}
      <circle cx={rightPeakX} cy={rightPeakY} r={s * 0.025} fill={G} fillOpacity="0.7" />
    </svg>
  );
}

function LogoRow({ iconSize, fontSize, gap, subSize }: { iconSize: number; fontSize: number; gap: number; subSize: number }) {
  return (
    <div style={{ display: "flex", alignItems: "center", gap }}>
      <SovereignIcon size={iconSize} />
      <div>
        <div style={{
          fontFamily: "'Playfair Display', Georgia, serif",
          fontSize, fontWeight: 700, color: Face,
          letterSpacing: "0.22em", lineHeight: 1.1,
        }}>GOLD-SIGNAL</div>
        <div style={{
          fontFamily: "sans-serif", fontSize: subSize,
          color: Gdk, letterSpacing: "0.4em", fontWeight: 600,
          marginTop: 2,
        }}>PREMIUM TRADING</div>
      </div>
    </div>
  );
}

export function LogoSovereign() {
  return (
    <div style={{
      minHeight: "100vh", background: "#FFFFFF",
      display: "flex", flexDirection: "column", alignItems: "center", justifyContent: "center",
      fontFamily: "'Playfair Display', Georgia, serif",
      WebkitFontSmoothing: "antialiased",
    }}>
      <p style={{ fontSize: 9, letterSpacing: "0.4em", color: "#999", fontFamily: "sans-serif", marginBottom: 56 }}>
        CONCEPT C — SOVEREIGN
      </p>

      {/* Hero icon */}
      <SovereignIcon size={160} />

      <div style={{ margin: "40px 0 56px", width: 1, height: 64, background: `linear-gradient(${G}, transparent)` }} />

      {/* Full logo — large */}
      <LogoRow iconSize={80} fontSize={36} gap={22} subSize={10} />

      <div style={{ margin: "48px 0", width: 200, height: 1, background: "rgba(196,160,40,0.18)" }} />

      {/* Medium */}
      <LogoRow iconSize={48} fontSize={22} gap={16} subSize={7} />

      <div style={{ margin: "36px 0", width: 160, height: 1, background: "rgba(196,160,40,0.14)" }} />

      {/* Nav bar preview */}
      <div style={{
        width: "100%", maxWidth: 640,
        borderTop: "1px solid rgba(196,160,40,0.22)",
        borderBottom: "1px solid rgba(196,160,40,0.22)",
        padding: "14px 28px",
        display: "flex", alignItems: "center", justifyContent: "space-between",
      }}>
        <LogoRow iconSize={32} fontSize={13} gap={10} subSize={6} />
        <div style={{ display: "flex", gap: 20 }}>
          {["거래하기", "로그인"].map((t, i) => (
            <span key={i} style={{
              fontSize: 11, fontFamily: "sans-serif",
              color: i === 0 ? "#fff" : Gdk,
              background: i === 0 ? G : "transparent",
              border: i === 0 ? "none" : `1.5px solid ${G}`,
              borderRadius: 3, padding: "5px 14px", cursor: "pointer",
              fontWeight: 600, letterSpacing: "0.08em",
            }}>{t}</span>
          ))}
        </div>
      </div>

      <p style={{ marginTop: 60, fontSize: 9, letterSpacing: "0.35em", color: "#ccc", fontFamily: "sans-serif" }}>
        GOLD-SIGNAL © 2026
      </p>
    </div>
  );
}
