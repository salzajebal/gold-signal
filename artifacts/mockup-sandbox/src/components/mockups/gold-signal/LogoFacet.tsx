/* Logo Concept 2 — FACET
   Icon: A cut diamond / gem shape divided into 4 clean triangular facets.
   Two-tone gold creates the illusion of a 3D polished surface.
   Concept: Precious metal, jewel-grade luxury, rare asset trading.
*/

const G    = "#C4A028";
const Gdk  = "#8A6C10";
const Glt  = "#DEB840";
const Face = "#1A1206";

function FacetIcon({ size = 80 }: { size?: number }) {
  const s = size, cx = s / 2, cy = s / 2;
  const w = s * 0.46, h = s * 0.50; // half-widths
  // Diamond 4 corners
  const top    = [cx,      cy - h];
  const right  = [cx + w,  cy];
  const bottom = [cx,      cy + h];
  const left   = [cx - w,  cy];
  // Center point (slightly above true center for elegance)
  const center = [cx, cy - h * 0.08];

  const toStr = (pts: number[][]) => pts.map(p => p.join(",")).join(" ");

  return (
    <svg width={s} height={s} viewBox={`0 0 ${s} ${s}`} fill="none">
      {/* Top facet — bright */}
      <polygon
        points={toStr([top, right, center, left])}
        fill={Glt} fillOpacity="0.92"
      />
      {/* Right facet — dark */}
      <polygon
        points={toStr([center, right, bottom])}
        fill={Gdk} fillOpacity="0.80"
      />
      {/* Bottom facet — medium */}
      <polygon
        points={toStr([center, bottom, left])}
        fill={G} fillOpacity="0.88"
      />
      {/* Outline */}
      <polygon
        points={toStr([top, right, bottom, left])}
        fill="none" stroke={G} strokeWidth={s * 0.018}
      />
      {/* Internal facet lines */}
      <line x1={center[0]} y1={center[1]} x2={top[0]}    y2={top[1]}    stroke="rgba(255,255,255,0.4)" strokeWidth={s * 0.012} />
      <line x1={center[0]} y1={center[1]} x2={right[0]}  y2={right[1]}  stroke="rgba(0,0,0,0.18)"    strokeWidth={s * 0.012} />
      <line x1={center[0]} y1={center[1]} x2={bottom[0]} y2={bottom[1]} stroke="rgba(0,0,0,0.12)"    strokeWidth={s * 0.012} />
      <line x1={center[0]} y1={center[1]} x2={left[0]}   y2={left[1]}   stroke="rgba(255,255,255,0.3)" strokeWidth={s * 0.012} />
      {/* Top edge highlight */}
      <line x1={top[0]} y1={top[1]} x2={right[0]} y2={right[1]}
        stroke="rgba(255,255,255,0.55)" strokeWidth={s * 0.018} />
    </svg>
  );
}

function LogoRow({ iconSize, fontSize, gap, subSize }: { iconSize: number; fontSize: number; gap: number; subSize: number }) {
  return (
    <div style={{ display: "flex", alignItems: "center", gap }}>
      <FacetIcon size={iconSize} />
      <div>
        <div style={{
          fontFamily: "'Playfair Display', Georgia, serif",
          fontSize, fontWeight: 700, color: Face,
          letterSpacing: "0.20em", lineHeight: 1.1,
        }}>GOLD<span style={{ color: G, margin: "0 4px", fontSize: fontSize * 0.7 }}>·</span>SIGNAL</div>
        <div style={{
          fontFamily: "sans-serif", fontSize: subSize,
          color: Gdk, letterSpacing: "0.4em", fontWeight: 600,
          marginTop: 2,
        }}>PREMIUM TRADING</div>
      </div>
    </div>
  );
}

export function LogoFacet() {
  return (
    <div style={{
      minHeight: "100vh", background: "#FFFFFF",
      display: "flex", flexDirection: "column", alignItems: "center", justifyContent: "center",
      fontFamily: "'Playfair Display', Georgia, serif",
      WebkitFontSmoothing: "antialiased",
    }}>
      <p style={{ fontSize: 9, letterSpacing: "0.4em", color: "#999", fontFamily: "sans-serif", marginBottom: 56 }}>
        CONCEPT B — FACET
      </p>

      {/* Hero icon */}
      <FacetIcon size={160} />

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
