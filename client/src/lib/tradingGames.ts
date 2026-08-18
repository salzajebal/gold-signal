export const FOREX_SYMBOLS = ['GOLD', 'GBP', 'BTC', 'SILVER'] as const;
export type ForexSymbol = typeof FOREX_SYMBOLS[number];

export const FOREX_DISPLAY: Record<ForexSymbol, { name: string; pair: string; flag: string }> = {
  GOLD: { name: 'Gold', pair: 'Gold', flag: '🪙' },
  GBP: { name: 'GBP', pair: 'GBP', flag: '🇬🇧' },
  BTC: { name: 'BTC', pair: 'Bitcoin', flag: '₿' },
  SILVER: { name: 'Silver', pair: 'Silver', flag: '🥈' },
};

export const FINNHUB_TICKER_MAP: Record<ForexSymbol, string> = {
  GOLD: 'GC=F',
  GBP: 'GBPUSD=X',
  BTC: 'BTC-USD',
  SILVER: 'SI=F',
};

export const TRADING_GAMES = [
  { id: 'GOLD-300', symbol: 'GOLD', duration: 300, label: 'Gold' },
  { id: 'GBP-300', symbol: 'GBP', duration: 300, label: 'GBP' },
  { id: 'BTC-300', symbol: 'BTC', duration: 300, label: 'BTC' },
  { id: 'SILVER-300', symbol: 'SILVER', duration: 300, label: 'Silver' },
  { id: 'GOLD-180', symbol: 'GOLD', duration: 180, label: 'Gold' },
  { id: 'GBP-180', symbol: 'GBP', duration: 180, label: 'GBP' },
  { id: 'BTC-180', symbol: 'BTC', duration: 180, label: 'BTC' },
  { id: 'SILVER-180', symbol: 'SILVER', duration: 180, label: 'Silver' },
];

export type TradingGame = typeof TRADING_GAMES[number];

// Unique symbols only (for navigation tabs)
export const TRADING_GAMES_NAV = TRADING_GAMES.filter(g => g.duration === 300);
