interface LogoProps {
  size?: number;
  height?: number;
  className?: string;
  variant?: "icon" | "full";
}

export function LearnInvestLogo({
  size,
  height,
  className = "",
  variant = "full",
}: LogoProps) {
  if (variant === "icon") {
    const h = size ?? height ?? 48;
    const w = h;
    return (
      <svg
        width={w}
        height={h}
        viewBox="0 0 64 64"
        fill="none"
        xmlns="http://www.w3.org/2000/svg"
        className={className}
      >
        <defs>
          <linearGradient id="gs-ibg" x1="0" y1="0" x2="64" y2="64" gradientUnits="userSpaceOnUse">
            <stop offset="0%" stopColor="#92400E" />
            <stop offset="100%" stopColor="#D97706" />
          </linearGradient>
        </defs>
        <rect width="64" height="64" rx="14" fill="url(#gs-ibg)" />
        {/* Signal / chart wave */}
        <polyline
          points="8,42 18,28 26,36 34,20 42,30 56,16"
          stroke="#FEF3C7"
          strokeWidth="4.5"
          strokeLinecap="round"
          strokeLinejoin="round"
          fill="none"
        />
        {/* Dot at peak */}
        <circle cx="34" cy="20" r="3.5" fill="#FCD34D" />
      </svg>
    );
  }

  const h = size ?? height ?? 32;
  const aspectRatio = 148 / 32;
  const w = Math.round(h * aspectRatio);

  return (
    <svg
      width={w}
      height={h}
      viewBox="0 0 148 32"
      fill="none"
      xmlns="http://www.w3.org/2000/svg"
      className={className}
    >
      {/* Mini icon */}
      <rect x="0" y="2" width="26" height="26" rx="6" fill="#D97706" />
      <polyline
        points="4,22 8,14 12,18 16,10 20,14 24,8"
        stroke="#FEF3C7"
        strokeWidth="2.2"
        strokeLinecap="round"
        strokeLinejoin="round"
        fill="none"
      />
      {/* Text */}
      <text
        x="32"
        y="23"
        fontFamily="'Helvetica Neue', Helvetica, Arial, sans-serif"
        fontSize="19"
        fontWeight="800"
        letterSpacing="0.3"
        fill="#92400E"
      >
        Gold
        <tspan fontWeight="500" fill="#D97706" letterSpacing="0.5">
          -signal
        </tspan>
      </text>
    </svg>
  );
}
