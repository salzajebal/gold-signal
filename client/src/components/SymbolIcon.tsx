import { useState } from "react";

interface SymbolIconProps {
  symbol: string;
  size?: number;
}

function GoldLogo({ size }: { size: number }) {
  return (
    <svg width={size} height={size} viewBox="0 0 36 36" fill="none">
      <rect width="36" height="36" rx="7" fill="#B8860B" />
      <text
        x="18"
        y="15"
        textAnchor="middle"
        fontFamily="'Arial Black', Arial, sans-serif"
        fontSize="9"
        fontWeight="900"
        fill="#FFD700"
        letterSpacing="0.5"
      >GOLD</text>
      <text
        x="18"
        y="27"
        textAnchor="middle"
        fontFamily="'Georgia', serif"
        fontSize="12"
        fontWeight="bold"
        fill="#FFD700"
      >Au</text>
    </svg>
  );
}

function GBPLogo({ size }: { size: number }) {
  return (
    <svg width={size} height={size} viewBox="0 0 36 36" fill="none">
      <rect width="36" height="36" rx="7" fill="#003087" />
      {/* Union Jack simplified */}
      <rect x="0" y="15" width="36" height="6" fill="white" rx="0"/>
      <rect x="15" y="0" width="6" height="36" fill="white" rx="0"/>
      <rect x="0" y="16.5" width="36" height="3" fill="#CC0000"/>
      <rect x="16.5" y="0" width="3" height="36" fill="#CC0000"/>
      {/* £ symbol overlay */}
      <rect width="36" height="36" rx="7" fill="#00308788"/>
      <text
        x="18"
        y="24"
        textAnchor="middle"
        fontFamily="'Georgia', 'Times New Roman', serif"
        fontSize="20"
        fontWeight="bold"
        fill="white"
      >£</text>
    </svg>
  );
}

function BTCLogo({ size }: { size: number }) {
  return (
    <svg width={size} height={size} viewBox="0 0 36 36" fill="none">
      <rect width="36" height="36" rx="7" fill="#F7931A" />
      <text
        x="19"
        y="26"
        textAnchor="middle"
        fontFamily="'Arial Black', Arial, sans-serif"
        fontSize="22"
        fontWeight="900"
        fill="white"
      >₿</text>
    </svg>
  );
}

function SilverLogo({ size }: { size: number }) {
  return (
    <svg width={size} height={size} viewBox="0 0 36 36" fill="none">
      <rect width="36" height="36" rx="7" fill="#708090" />
      <text
        x="18"
        y="15"
        textAnchor="middle"
        fontFamily="'Arial Black', Arial, sans-serif"
        fontSize="8"
        fontWeight="900"
        fill="#E8E8E8"
        letterSpacing="0.3"
      >SILVER</text>
      <text
        x="18"
        y="27"
        textAnchor="middle"
        fontFamily="'Georgia', serif"
        fontSize="12"
        fontWeight="bold"
        fill="#E8E8E8"
      >Ag</text>
    </svg>
  );
}

export function SymbolIcon({ symbol, size = 22 }: SymbolIconProps) {
  const base = symbol.split("-")[0];

  const renderLogo = () => {
    if (base === "GOLD") return <GoldLogo size={size} />;
    if (base === "GBP") return <GBPLogo size={size} />;
    if (base === "BTC") return <BTCLogo size={size} />;
    if (base === "SILVER") return <SilverLogo size={size} />;
    return (
      <svg width={size} height={size} viewBox="0 0 28 28" fill="none">
        <rect width="28" height="28" rx="5" fill="#1e293b" />
        <text x="14" y="18" textAnchor="middle" fill="white" fontSize="10" fontFamily="Arial" fontWeight="bold">
          {base.slice(0, 2)}
        </text>
      </svg>
    );
  };

  return (
    <div style={{ position: "relative", width: size, height: size, display: "inline-flex", flexShrink: 0 }}>
      {renderLogo()}
    </div>
  );
}
