import { useState } from "react";

/* ─── Mini sparkline SVG ─── */
function Spark({ up }: { up: boolean }) {
  const pts = up
    ? "0,28 12,22 24,26 36,16 48,20 60,10 72,14 84,8 96,12 108,6 120,10"
    : "0,8 12,14 24,10 36,18 48,15 60,24 72,20 84,26 96,22 108,28 120,24";
  return (
    <svg viewBox="0 0 120 36" className="w-full h-8 mt-2" preserveAspectRatio="none">
      <polyline points={pts} fill="none" stroke="rgba(255,255,255,0.6)" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" />
    </svg>
  );
}

/* ─── Static candle chart for hero ─── */
function HeroChart() {
  const candles = [
    {o:60,h:70,l:55,c:66},{o:66,h:74,l:63,c:71},{o:71,h:78,l:68,c:75},
    {o:75,h:80,l:70,c:73},{o:73,h:79,l:70,c:77},{o:77,h:84,l:74,c:82},
    {o:82,h:88,l:79,c:85},{o:85,h:91,l:82,c:89},{o:89,h:94,l:86,c:91},
    {o:91,h:97,l:88,c:94},
  ];
  const h = 80; const w = 200; const pad = 8;
  const mn = 50; const mx = 100;
  const sc = (v: number) => h - pad - ((v - mn) / (mx - mn)) * (h - 2 * pad);
  const cw = (w - pad * 2) / candles.length;
  return (
    <svg width={w} height={h} className="opacity-80">
      {candles.map((c, i) => {
        const up = c.c >= c.o;
        const x = pad + i * cw + cw * 0.15;
        const bw = cw * 0.7;
        const cx2 = x + bw / 2;
        const top = sc(Math.max(c.o, c.c));
        const bh = Math.max(sc(Math.min(c.o, c.c)) - top, 2);
        return (
          <g key={i}>
            <line x1={cx2} x2={cx2} y1={sc(c.h)} y2={sc(c.l)} stroke={up ? "#86efac" : "#fca5a5"} strokeWidth="1.5" />
            <rect x={x} y={top} width={bw} height={bh} fill={up ? "#86efac" : "#fca5a5"} rx="1" />
          </g>
        );
      })}
    </svg>
  );
}

const SLIDES = [
  {
    badge: "• 실시간 거래",
    title: "글로벌 시장의 중심,\nBTK에서 투자하세요",
    sub: "S&P500 · 다우존스 · 달러지수 5분 거래",
    bg: "linear-gradient(135deg,#1e3a8a 0%,#3b3ac4 55%,#6c63ff 100%)",
    chart: true,
    tag: "S&P500 · 실시간"
  },
  {
    badge: "• 수익률 이벤트",
    title: "첫 입금 보너스\n최대 10% 지급",
    sub: "6월 한정 신규 회원 특별 혜택",
    bg: "linear-gradient(135deg,#7c3aed 0%,#a855f7 100%)",
    chart: false,
    tag: "6월 이벤트"
  },
  {
    badge: "• 24시간 운영",
    title: "언제 어디서나\n글로벌 투자",
    sub: "모바일 최적화 · 실시간 알림",
    bg: "linear-gradient(135deg,#0369a1 0%,#0ea5e9 100%)",
    chart: false,
    tag: "모바일 지원"
  }
];

const ASSETS = [
  { sym: "SP500", name: "S&P 500", price: "5,320.00", change: "+0.42%", up: true,  bg: "linear-gradient(135deg,#7c3aed,#a855f7)" },
  { sym: "DOW",  name: "다우존스", price: "39,500.00",change: "-0.18%", up: false, bg: "linear-gradient(135deg,#0ea5e9,#38bdf8)" },
  { sym: "DXY",  name: "달러(DXY)",price: "104.50",   change: "+0.05%", up: true,  bg: "linear-gradient(135deg,#059669,#34d399)" },
];

const NEWS = [
  { badge: "공지", date: "2026.06.05", title: "6월 신규 이벤트 — 입금 보너스 최대 10%", desc: "이번 달 특별 프로모션으로 첫 입금 시 보너스 혜택을 드립니다." },
  { badge: "업데이트", date: "2026.06.03", title: "시스템 점검 완료 — 더욱 빠른 거래 환경 제공", desc: "서버 인프라 업그레이드로 안정적인 거래 환경을 제공합니다." },
  { badge: "투자정보", date: "2026.06.01", title: "S&P500 주간 전망 — 연준 발언 주목 필요", desc: "이번 주 연준 의사록 공개를 앞두고 시장 변동성이 예상됩니다." },
];

export function LandingPreview() {
  const [slide, setSlide] = useState(0);
  const s = SLIDES[slide];

  return (
    <div className="min-h-screen bg-white" style={{ fontFamily: "'Pretendard','Apple SD Gothic Neo',sans-serif", color: "#111" }}>

      {/* ─── Navbar ─── */}
      <header style={{ borderBottom: "1px solid #f1f5f9" }} className="bg-white sticky top-0 z-50">
        <div className="max-w-6xl mx-auto px-8 h-16 flex items-center justify-between">
          <div className="flex items-center gap-8">
            <a className="flex items-center gap-2 cursor-pointer">
              <span className="text-2xl font-black" style={{ letterSpacing: "0.04em", color: "#0f172a" }}>BTK</span>
              <span style={{ fontSize: 11, color: "#94a3b8", fontWeight: 500 }}>BizTech Korea</span>
            </a>
            <nav className="hidden md:flex items-center gap-6">
              {["회사소개", "투자 상품", "실시간 시세", "투자정보", "고객라운지"].map(m => (
                <span key={m} style={{ fontSize: 14, color: "#475569", fontWeight: 500, cursor: "pointer" }}
                  className="hover:text-indigo-600 transition-colors">{m}</span>
              ))}
            </nav>
          </div>
          <div className="flex items-center gap-2">
            <button style={{ fontSize: 13, color: "#475569", padding: "6px 16px", border: "1px solid #e2e8f0", borderRadius: 6, background: "white" }}>로그인</button>
            <button style={{ fontSize: 13, fontWeight: 700, color: "white", padding: "7px 18px", background: "linear-gradient(135deg,#3b3ac4,#6c63ff)", borderRadius: 6, border: "none" }}>거래 시작하기 →</button>
          </div>
        </div>
      </header>

      {/* ─── Hero 슬라이드 카드 (KoAct 스타일) ─── */}
      <section className="max-w-6xl mx-auto px-8 pt-10 pb-4">
        <div className="grid gap-4" style={{ gridTemplateColumns: "2fr 1fr" }}>

          {/* 메인 대형 카드 */}
          <div style={{ background: s.bg, borderRadius: 24, minHeight: 320, padding: 36 }}
            className="flex flex-col justify-between relative overflow-hidden">
            {/* 배경 장식 */}
            <div style={{ position: "absolute", right: -20, bottom: -20, opacity: 0.07 }}>
              <svg width="240" height="180" viewBox="0 0 240 180">
                <circle cx="120" cy="90" r="90" fill="white" />
              </svg>
            </div>
            <div>
              <span style={{ display: "inline-block", background: "rgba(255,255,255,0.2)", color: "white", fontSize: 11, padding: "3px 10px", borderRadius: 20, marginBottom: 14, fontWeight: 600 }}>{s.badge}</span>
              <h2 style={{ fontSize: 28, fontWeight: 900, color: "white", lineHeight: 1.35, whiteSpace: "pre-line", marginBottom: 10 }}>{s.title}</h2>
              <p style={{ fontSize: 14, color: "rgba(255,255,255,0.75)", fontWeight: 400 }}>{s.sub}</p>
            </div>
            {s.chart ? (
              <div className="mt-4">
                <HeroChart />
                <div style={{ fontSize: 11, color: "rgba(255,255,255,0.5)", marginTop: 4 }}>{s.tag}</div>
              </div>
            ) : (
              <div style={{ marginTop: 16 }}>
                <span style={{ fontSize: 11, color: "rgba(255,255,255,0.5)" }}>{s.tag}</span>
              </div>
            )}
            <div style={{ marginTop: 20, display: "flex", alignItems: "center", gap: 16 }}>
              <button style={{ background: "white", color: "#3b3ac4", fontWeight: 700, fontSize: 13, padding: "10px 22px", borderRadius: 100, border: "none", cursor: "pointer" }}>지금 거래하기</button>
              <span style={{ color: "rgba(255,255,255,0.65)", fontSize: 13, cursor: "pointer" }}>→ 자세히 보기</span>
            </div>
          </div>

          {/* 우측 두 개 작은 카드 */}
          <div className="flex flex-col gap-4">
            {ASSETS.slice(0, 2).map(a => (
              <div key={a.sym} style={{ background: a.bg, borderRadius: 20, padding: 22, flex: 1, cursor: "pointer" }}
                className="flex flex-col justify-between hover:opacity-90 transition-opacity">
                <div style={{ fontSize: 11, color: "rgba(255,255,255,0.7)", fontWeight: 600, marginBottom: 6 }}>• {a.name}</div>
                <div>
                  <div style={{ fontSize: 22, fontWeight: 900, color: "white" }}>{a.price}</div>
                  <div style={{ fontSize: 12, color: "rgba(255,255,255,0.75)", marginTop: 2 }}>{a.change} 실시간 변동</div>
                </div>
                <Spark up={a.up} />
              </div>
            ))}
          </div>
        </div>

        {/* 슬라이드 인디케이터 */}
        <div className="flex items-center justify-center gap-2 mt-5">
          <button style={{ fontSize: 16, color: "#94a3b8", background: "none", border: "none", cursor: "pointer" }} onClick={() => setSlide((slide - 1 + SLIDES.length) % SLIDES.length)}>‹</button>
          {SLIDES.map((_, i) => (
            <button key={i} onClick={() => setSlide(i)}
              style={{ width: i === slide ? 24 : 8, height: 8, borderRadius: 4, background: i === slide ? "#3b3ac4" : "#cbd5e1", border: "none", cursor: "pointer", transition: "all 0.2s" }} />
          ))}
          <button style={{ fontSize: 16, color: "#94a3b8", background: "none", border: "none", cursor: "pointer" }} onClick={() => setSlide((slide + 1) % SLIDES.length)}>›</button>
        </div>
      </section>

      {/* ─── 시세 현황 스트립 ─── */}
      <section style={{ background: "#f8fafc", borderTop: "1px solid #f1f5f9", borderBottom: "1px solid #f1f5f9" }} className="py-4">
        <div className="max-w-6xl mx-auto px-8">
          <div className="grid grid-cols-3 gap-4">
            {ASSETS.map(a => (
              <div key={a.sym} style={{ background: "white", borderRadius: 12, padding: "14px 18px", border: "1px solid #f1f5f9" }}
                className="flex items-center justify-between hover:shadow-md transition-shadow cursor-pointer">
                <div>
                  <div style={{ fontSize: 11, color: "#94a3b8", fontWeight: 600 }}>{a.sym}</div>
                  <div style={{ fontSize: 16, fontWeight: 800, color: "#0f172a", marginTop: 2 }}>{a.price}</div>
                  <div style={{ fontSize: 11, color: "#94a3b8", marginTop: 1 }}>{a.name}</div>
                </div>
                <div className="text-right">
                  <span style={{ fontSize: 13, fontWeight: 700, color: a.up ? "#ef4444" : "#3b82f6",
                    background: a.up ? "#fef2f2" : "#eff6ff", padding: "3px 8px", borderRadius: 6 }}>{a.change}</span>
                  <button style={{ display: "block", marginTop: 8, marginLeft: "auto", fontSize: 11, fontWeight: 700, color: "white",
                    background: "linear-gradient(135deg,#3b3ac4,#6c63ff)", padding: "4px 12px", borderRadius: 100, border: "none", cursor: "pointer" }}>거래</button>
                </div>
              </div>
            ))}
          </div>
        </div>
      </section>

      {/* ─── 인사이트 & 공지 (KoAct Insight 스타일) ─── */}
      <section style={{ background: "#eef2ff" }} className="py-14">
        <div className="max-w-6xl mx-auto px-8">
          <div className="flex items-end justify-between mb-8">
            <div>
              <p style={{ fontSize: 10, fontWeight: 800, color: "#6366f1", letterSpacing: "0.15em", marginBottom: 6 }}>01. NOTICE & INSIGHT</p>
              <h2 style={{ fontSize: 26, fontWeight: 900, color: "#0f172a", marginBottom: 4 }}>공지사항 & 투자정보</h2>
              <p style={{ fontSize: 13, color: "#64748b" }}>BTK의 최신 소식과 글로벌 투자 인사이트를 확인하세요</p>
            </div>
            <span style={{ fontSize: 13, color: "#6366f1", fontWeight: 600, cursor: "pointer" }}>전체보기 →</span>
          </div>
          <div style={{ display: "grid", gridTemplateColumns: "1.6fr 1fr", gap: 20 }}>
            {/* 메인 뉴스 */}
            <div style={{ background: "white", borderRadius: 20, overflow: "hidden", boxShadow: "0 2px 12px rgba(0,0,0,0.06)", cursor: "pointer" }}>
              <div style={{ background: "linear-gradient(135deg,#1e3a8a,#3b3ac4)", height: 160, display: "flex", alignItems: "center", justifyContent: "center", position: "relative", overflow: "hidden" }}>
                <div style={{ position: "absolute", inset: 0, display: "flex", alignItems: "center", justifyContent: "center", opacity: 0.15 }}>
                  <svg width="200" height="120" viewBox="0 0 200 120">
                    <polyline points="0,90 40,60 80,70 120,30 160,50 200,20" fill="none" stroke="white" strokeWidth="3" />
                    <polyline points="0,100 40,80 80,85 120,55 160,65 200,45" fill="none" stroke="white" strokeWidth="2" />
                  </svg>
                </div>
                <span style={{ fontSize: 36, fontWeight: 900, color: "white", letterSpacing: "0.1em", position: "relative", zIndex: 1 }}>BTK</span>
              </div>
              <div style={{ padding: 22 }}>
                <div className="flex items-center gap-2 mb-3">
                  <span style={{ background: "#eef2ff", color: "#6366f1", fontSize: 11, fontWeight: 700, padding: "2px 8px", borderRadius: 20 }}>공지</span>
                  <span style={{ fontSize: 11, color: "#94a3b8" }}>2026.06.05</span>
                </div>
                <h3 style={{ fontSize: 16, fontWeight: 800, color: "#0f172a", lineHeight: 1.4, marginBottom: 8 }}>6월 신규 이벤트 — 입금 보너스 최대 10% 지급</h3>
                <p style={{ fontSize: 13, color: "#64748b", lineHeight: 1.6 }}>이번 달 특별 프로모션으로 첫 입금 시 보너스 혜택을 드립니다. 지금 바로 확인하세요.</p>
              </div>
            </div>
            {/* 사이드 뉴스 */}
            <div className="flex flex-col gap-3">
              {NEWS.slice(1).map(n => (
                <div key={n.title} style={{ background: "white", borderRadius: 16, padding: "18px 20px", boxShadow: "0 2px 8px rgba(0,0,0,0.05)", cursor: "pointer", flex: 1 }}>
                  <div className="flex items-center gap-2 mb-2">
                    <span style={{ background: "#eef2ff", color: "#6366f1", fontSize: 10, fontWeight: 700, padding: "2px 7px", borderRadius: 20 }}>{n.badge}</span>
                    <span style={{ fontSize: 10, color: "#94a3b8" }}>{n.date}</span>
                  </div>
                  <h3 style={{ fontSize: 13, fontWeight: 700, color: "#0f172a", lineHeight: 1.45, marginBottom: 6 }}>{n.title}</h3>
                  <p style={{ fontSize: 12, color: "#94a3b8", lineHeight: 1.5 }}>{n.desc}</p>
                </div>
              ))}
            </div>
          </div>
        </div>
      </section>

      {/* ─── Investment Philosophy (다크 그라데이션) ─── */}
      <section style={{ background: "linear-gradient(160deg,#0f172a 0%,#1e1b4b 50%,#2e1065 100%)", padding: "60px 0" }}>
        <div className="max-w-6xl mx-auto px-8">
          <div className="text-center mb-10">
            <p style={{ fontSize: 10, fontWeight: 800, color: "#818cf8", letterSpacing: "0.15em", marginBottom: 8 }}>Investment Philosophy</p>
            <h2 style={{ fontSize: 26, fontWeight: 900, color: "white", marginBottom: 8 }}>왜 BTK인가?</h2>
            <p style={{ fontSize: 13, color: "#94a3b8" }}>신뢰와 투명성을 기반으로 한 글로벌 투자 환경</p>
          </div>
          <div style={{ display: "grid", gridTemplateColumns: "1fr 1fr", gap: 16, marginBottom: 20 }}>
            {[
              { icon: "📡", t: "실시간 시세", d: "Finnhub API 기반 글로벌 실시간 가격 데이터로 정확한 진입가를 보장합니다" },
              { icon: "⚖️", t: "투명한 정산", d: "진입가 대비 마감가 비교로 공정하고 투명한 결과를 제공합니다" },
              { icon: "🛡️", t: "자산 보안", d: "최고 수준 보안 체계로 회원 자산과 개인정보를 안전하게 보호합니다" },
              { icon: "🌍", t: "24시간 운영", d: "글로벌 시장 기준 24시간 중단 없는 거래 서비스를 제공합니다" },
            ].map(item => (
              <div key={item.t} style={{ background: "rgba(255,255,255,0.07)", border: "1px solid rgba(255,255,255,0.08)", borderRadius: 18, padding: "24px 26px" }}
                className="hover:bg-white/10 transition-colors cursor-pointer">
                <div style={{ fontSize: 28, marginBottom: 10 }}>{item.icon}</div>
                <h3 style={{ fontSize: 16, fontWeight: 800, color: "white", marginBottom: 6 }}>{item.t}</h3>
                <p style={{ fontSize: 13, color: "#94a3b8", lineHeight: 1.65 }}>{item.d}</p>
              </div>
            ))}
          </div>
          <div className="text-center">
            <button style={{ background: "rgba(255,255,255,0.1)", border: "1px solid rgba(255,255,255,0.15)", color: "white", fontSize: 13, fontWeight: 600, padding: "12px 32px", borderRadius: 100, cursor: "pointer" }}>
              BTK 소개 자세히 보기
            </button>
          </div>
        </div>
      </section>

      {/* ─── Stats ─── */}
      <section style={{ background: "white", borderTop: "1px solid #f1f5f9", padding: "40px 0" }}>
        <div className="max-w-6xl mx-auto px-8">
          <div className="grid grid-cols-4 gap-6 text-center">
            {[
              { v: "12,400+", u: "명", l: "누적 회원수" },
              { v: "3.2억", u: "원", l: "일 평균 거래량" },
              { v: "24/7", u: "", l: "서비스 운영" },
              { v: "99.9", u: "%", l: "시스템 가동률" },
            ].map(s => (
              <div key={s.l}>
                <div style={{ fontSize: 28, fontWeight: 900, color: "#3b3ac4" }}>
                  {s.v}<span style={{ fontSize: 16 }}>{s.u}</span>
                </div>
                <div style={{ fontSize: 13, color: "#64748b", marginTop: 4 }}>{s.l}</div>
              </div>
            ))}
          </div>
        </div>
      </section>

      {/* ─── Footer ─── */}
      <footer style={{ background: "#0f172a", padding: "36px 0" }}>
        <div className="max-w-6xl mx-auto px-8">
          <div className="flex items-start justify-between mb-5">
            <div>
              <div style={{ fontSize: 20, fontWeight: 900, color: "white", letterSpacing: "0.08em", marginBottom: 2 }}>BTK</div>
              <div style={{ fontSize: 10, color: "#94a3b8", letterSpacing: "0.05em" }}>BizTech Korea</div>
              <div style={{ fontSize: 11, color: "#64748b", marginTop: 2 }}>대한민국 대표 글로벌 투자 거래소</div>
            </div>
            <div className="flex gap-6">
              {["개인정보처리방침", "이용약관", "고객센터", "1:1 문의"].map(l => (
                <span key={l} style={{ fontSize: 12, color: "#64748b", cursor: "pointer" }} className="hover:text-white transition-colors">{l}</span>
              ))}
            </div>
          </div>
          <div style={{ borderTop: "1px solid #1e293b", paddingTop: 20 }}>
            <p style={{ fontSize: 11, color: "#475569" }}>Copyright © 2026 BizTech Korea. All rights reserved.</p>
          </div>
        </div>
      </footer>
    </div>
  );
}
