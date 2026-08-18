import { clsx, type ClassValue } from "clsx"
import { twMerge } from "tailwind-merge"

export function cn(...inputs: ClassValue[]) {
  return twMerge(clsx(inputs))
}

export function getForexDecimals(symbol?: string): number {
  if (!symbol) return 2;
  const base = symbol.split('-')[0].toUpperCase();
  if (base === 'GBP') return 4;
  if (base === 'SILVER') return 3;
  return 2;
}

export function formatForexPrice(price: number, symbol?: string): string {
  const decimals = getForexDecimals(symbol);
  return price.toFixed(decimals);
}
