/* Logo Concept 1 — PULSE
   Icon: A thin-arc circle (open at top) enclosing an upward signal pulse line.
   Concept: Premium fintech / real-time signal / market data.
   Style: hyper-minimal, single gold weight, generous whitespace.
*/

const G = "#C4A028";
const Gdk = "#8A6C10";
const Face = "#1A1206";

function PulseIcon({ size = 80 }: { size?: number }) {
  const s = size, cx = s / 2, cy = s / 2, r = s * 0.42;
  // Arc: 220° of circle (gap at top center, 70° total gap split 35° each side)
  const startAngle = -55 * Math.PI / 180;   // -55° from 12 o'clock = top-right
  const endAngle   = (180 + 55) * Math.PI / 180; // past bottom, back to top-left
  const startX = cx + r * Math.cos(startAngle - Math.PI / 2);
  const startY = cy + r * Math.sin(startAngle - Math.PI / 2);
  const endX   = cx + r * Math.cos(endAngle   - Math.PI / 2);
  const endY   = cy + r * Math.sin(endAngle   - Math.PI / 2);

  // Signal pulse path (ECG-style, upward spike in center)
  const pw = s * 0.44;
  const ph = s * 0.22;
  const py = cy + s * 0.04;
  const px = cx - pw / 2;
  const pulse = [
    `M${px},${py}`,
    `L${px + pw * 0.28},${py}`,
    `L${px + pw * 0.38},${py - ph * 0.4}`,
    `L${px + pw * 0.48},${py + ph * 0.3}`,
    `L${px + pw * 0.52},${py - ph}`,
    `L${px + pw * 0.56},${py + ph * 0.25}`,
    `L${px + pw * 0.65},${py}`,
    `L${px + pw},${py}`,
  ].join(" ");

  return (
    <svg width={s} height={s} viewBox={`0 0 ${s} ${s}`} fill="none">
      {/* Outer arc */}
      <path
        d={`M${startX},${startY} A${r},${r} 0 1 1 ${endX},${endY}`}
        stroke={G} strokeWidth={s * 0.03} strokeLinecap="round"
      />
      {/* Start cap dot */}
      <circle cx={startX} cy={startY} r={s * 0.025} fill={G} />
      <circle cx={endX}   cy={endY}   r={s * 0.025} fill={G} />
      {/* Signal pulse */}
      <path d={pulse} stroke={G} strokeWidth={s * 0.028} strokeLinecap="round" strokeLinejoin="round" />
    </svg>
  );
}

function LogoRow({ iconSize, fontSize, gap, subSize }: { iconSize: number; fontSize: number; gap: number; subSize: number }) {
  return (
    <div style={{ display: "flex", alignItems: "center", gap }}>
      <PulseIcon size={iconSize} />
      <div>
        <div style={{
          fontFamily: "'Playfair Display', Georgia, serif",
          fontSize, fontWeight: 700, color: Face,
          letterSpacing: "0.22em", lineHeight: 1.1,
        }}>GOLD-SIGNAL</div>
        <div style={{
          fontFamily: "sans-serif", fontSize: subSize,
          color: Gdk, letterSpacing: "0.35em", fontWeight: 600,
          marginTop: 2,
        }}>PREMIUM TRADING</div>
      </div>
    </div>
  );
}

export function LogoPulse() {
  return (
    <div style={{
      minHeight: "100vh", background: "#FFFFFF",
      display: "flex", flexDirection: "column", alignItems: "center", justifyContent: "center",
      gap: 0, fontFamily: "'Playfair Display', Georgia, serif",
      WebkitFontSmoothing: "antialiased",
    }}>
      {/* Label */}
      <p style={{ fontSize: 9, letterSpacing: "0.4em", color: "#999", fontFamily: "sans-serif", marginBottom: 56 }}>
        CONCEPT A — PULSE
      </p>

      {/* Hero: Icon alone */}
      <PulseIcon size={160} />

      <div style={{ margin: "40px 0 56px", width: 1, height: 64, background: `linear-gradient(${G}, transparent)` }} />

      {/* Full logo — large */}
      <LogoRow iconSize={80} fontSize={36} gap={20} subSize={10} />

      <div style={{ margin: "48px 0", width: 200, height: 1, background: "rgba(196,160,40,0.18)" }} />

      {/* Medium */}
      <LogoRow iconSize={48} fontSize={22} gap={14} subSize={7} />

      <div style={{ margin: "36px 0", width: 160, height: 1, background: "rgba(196,160,40,0.14)" }} />

      {/* Nav size */}
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
