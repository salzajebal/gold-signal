import { Link, useLocation } from "wouter";
import { Menu, LogOut, Shield, ChevronDown, Wallet } from "lucide-react";
import { useAuth, useLogout } from "@/hooks/use-auth";
import { Button } from "@/components/ui/button";
import { cn } from "@/lib/utils";
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuSeparator,
  DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu";
import { TRADING_GAMES, TRADING_GAMES_NAV } from "@/lib/tradingGames";
import { SymbolIcon } from "@/components/SymbolIcon";
import { Sheet, SheetContent, SheetHeader, SheetTitle, SheetTrigger } from "@/components/ui/sheet";
import { useState } from "react";
import { useUserBalance } from "@/hooks/use-bets";

interface NavbarProps {
  onSelectGame?: (gameId: string) => void;
  selectedGameId?: string;
}

export function Navbar({ onSelectGame, selectedGameId }: NavbarProps) {
  const { data: user } = useAuth();
  const logout = useLogout();
  const [mobileMenuOpen, setMobileMenuOpen] = useState(false);
  const { data: balanceData } = useUserBalance();
  const [, setLocation] = useLocation();

  const goTo = (tab: string) => {
    setLocation(`/?tab=${tab}`);
  };
  
  const selectedGame = TRADING_GAMES_NAV.find(g => g.id === selectedGameId) || TRADING_GAMES_NAV.find(g => selectedGameId?.startsWith(g.symbol));
  const displayBalance = balanceData?.balance != null
    ? Math.floor(parseFloat(balanceData.balance))
    : user?.balance != null
      ? Math.floor(parseFloat(user.balance))
      : null;

  return (
    <header className="flex h-14 lg:h-16 items-center border-b border-border bg-card px-3 lg:px-6">
      <div className="flex items-center gap-2 lg:gap-6 flex-1 min-w-0">
        <Link href="/" className="flex items-center hover:opacity-90 transition-opacity shrink-0">
          <img src="/icons/gs-logo.png" alt="GOLD-SIGNAL" style={{height:30,width:"auto",objectFit:"contain"}} />
        </Link>
        
        {/* Mobile: Current game dropdown */}
        <DropdownMenu>
          <DropdownMenuTrigger asChild>
            <Button variant="outline" size="sm" className="lg:hidden flex items-center gap-1 text-xs h-10 min-h-[40px] px-3 touch-manipulation">
              <span className="max-w-[90px] truncate font-semibold">{selectedGame?.label || '종목선택'}</span>
              <span className="text-[10px] font-bold px-1 py-0.5 rounded shrink-0"
                style={{background: (TRADING_GAMES.find(g=>g.id===selectedGameId)?.duration ?? 300) === 180 ? 'rgba(196,160,40,0.15)' : 'rgba(59,130,246,0.15)',
                  color: (TRADING_GAMES.find(g=>g.id===selectedGameId)?.duration ?? 300) === 180 ? 'hsl(var(--primary))' : 'rgb(96,165,250)'}}>
                {(TRADING_GAMES.find(g=>g.id===selectedGameId)?.duration ?? 300) === 180 ? '3분' : '5분'}
              </span>
              <ChevronDown className="w-3.5 h-3.5 shrink-0 ml-0.5" />
            </Button>
          </DropdownMenuTrigger>
          <DropdownMenuContent align="start" className="w-52 max-h-[60vh] overflow-y-auto">
            {TRADING_GAMES.map(game => (
              <DropdownMenuItem
                key={game.id}
                onClick={() => onSelectGame?.(game.id)}
                className={cn(
                  "cursor-pointer flex items-center gap-2 min-h-[44px] touch-manipulation",
                  selectedGameId === game.id && "bg-primary/10 text-primary"
                )}
              >
                <span className="font-medium">{game.symbol}</span>
                <span className="text-[10px] font-bold px-1.5 py-0.5 rounded ml-auto shrink-0"
                  style={{background: game.duration === 180 ? 'rgba(196,160,40,0.15)' : 'rgba(59,130,246,0.15)',
                    color: game.duration === 180 ? 'hsl(var(--primary))' : 'rgb(96,165,250)'}}>
                  {game.duration === 180 ? '3분' : '5분'}
                </span>
              </DropdownMenuItem>
            ))}
          </DropdownMenuContent>
        </DropdownMenu>
        
        {/* Desktop: Game tabs */}
        <nav className="hidden lg:flex items-center gap-1 text-sm font-medium">
          {TRADING_GAMES_NAV.map(game => (
            <button
              key={game.id}
              onClick={() => onSelectGame?.(game.id)}
              data-testid={`nav-game-${game.id}`}
              className="flex items-center gap-1.5 px-3 py-1.5 rounded-md transition-all text-xs text-muted-foreground hover:text-foreground hover:bg-muted/30"
            >
              <SymbolIcon symbol={game.symbol} size={16} />
              <span className="font-medium">{game.symbol}</span>
            </button>
          ))}
        </nav>
      </div>

      {/* Desktop: Page navigation links */}
      {user && (
        <nav className="hidden lg:flex items-center gap-1 border-l border-border pl-4 ml-2 shrink-0">
          {[
            { label: '거래내역', tab: 'history' },
            { label: '예치신청', tab: 'deposit' },
            { label: '환급신청', tab: 'withdraw' },
            { label: '공지사항', tab: 'notice' },
            { label: '고객센터', tab: 'cs' },
            { label: '쪽지함', tab: 'messages' },
          ].map(({ label, tab }) => (
            <button
              key={tab}
              onClick={() => goTo(tab)}
              className="text-muted-foreground hover:text-amber-500 transition-colors text-xs font-medium px-2 py-1 rounded hover:bg-muted/30 whitespace-nowrap"
            >
              {label}
            </button>
          ))}
        </nav>
      )}

      <div className="flex items-center gap-1.5 lg:gap-3 shrink-0 ml-auto min-w-0">
        {/* Desktop: Balance Badge */}
        {user && displayBalance !== null && (
          <div
            data-testid="text-navbar-balance"
            className="hidden lg:flex items-center gap-1 px-2 py-1 rounded bg-primary/10 border border-primary/20 shrink min-w-0 max-w-[130px]"
          >
            <Wallet className="w-3 h-3 text-primary shrink-0" />
            <span className="text-[11px] font-bold font-mono text-primary truncate">
              {displayBalance.toLocaleString()}원
            </span>
          </div>
        )}

        {user ? (
          <>
            {/* Mobile: Hamburger Menu */}
            <Sheet open={mobileMenuOpen} onOpenChange={setMobileMenuOpen}>
              <SheetTrigger asChild>
                <Button variant="ghost" size="sm" className="lg:hidden p-2 min-h-[40px] min-w-[40px] touch-manipulation">
                  <Menu className="w-5 h-5" />
                </Button>
              </SheetTrigger>
              <SheetContent side="right" className="w-[280px] p-0">
                <SheetHeader className="p-5 border-b border-border">
                  <SheetTitle className="text-left">
                    <div className="flex items-center gap-2">
                      <div className="w-8 h-8 rounded-full bg-primary/20 flex items-center justify-center">
                        <span className="text-primary font-bold text-sm">{user.username[0]?.toUpperCase()}</span>
                      </div>
                      <div>
                        <p className="font-bold text-sm">{user.username}</p>
                        {(user as any).grade && (
                          <p className="text-xs text-primary font-medium">{(user as any).grade}</p>
                        )}
                      </div>
                    </div>
                  </SheetTitle>
                </SheetHeader>
                <div className="p-4 border-b border-border">
                  <div className="flex items-center justify-between px-3 py-2.5 rounded-lg bg-primary/10 border border-primary/20">
                    <div className="flex items-center gap-1.5 text-xs text-muted-foreground">
                      <Wallet className="w-3.5 h-3.5 text-primary" />
                      <span>보유금액</span>
                    </div>
                    <span className="text-sm font-bold font-mono text-primary">
                      {displayBalance !== null ? displayBalance.toLocaleString() : 0}원
                    </span>
                  </div>
                </div>
                <nav className="p-3 flex flex-col gap-1">
                  {[
                    { label: '거래내역', tab: 'history' },
                    { label: '예치신청', tab: 'deposit' },
                    { label: '환급신청', tab: 'withdraw' },
                    { label: '공지사항', tab: 'notice' },
                    { label: '고객센터', tab: 'cs' },
                    { label: '쪽지함', tab: 'messages' },
                  ].map(({ label, tab }) => (
                    <button
                      key={tab}
                      onClick={() => { goTo(tab); setMobileMenuOpen(false); }}
                      className="text-left px-4 py-3 rounded-lg text-sm font-medium text-foreground hover:bg-muted/50 active:bg-muted transition-colors touch-manipulation"
                    >
                      {label}
                    </button>
                  ))}
                  {user.role === 'admin' && (
                    <Link
                      href="/admin"
                      onClick={() => setMobileMenuOpen(false)}
                      className="flex items-center gap-2 px-4 py-3 rounded-lg text-sm font-medium text-primary hover:bg-primary/10 transition-colors touch-manipulation"
                    >
                      <Shield className="w-4 h-4" />
                      관리자 패널
                    </Link>
                  )}
                </nav>
                <div className="absolute bottom-0 left-0 right-0 p-4 border-t border-border">
                  <button
                    onClick={() => { logout.mutate(); setMobileMenuOpen(false); }}
                    className="w-full flex items-center justify-center gap-2 px-4 py-3 rounded-lg text-sm font-medium text-destructive hover:bg-destructive/10 transition-colors touch-manipulation"
                  >
                    <LogOut className="w-4 h-4" />
                    로그아웃
                  </button>
                </div>
              </SheetContent>
            </Sheet>

            {/* Desktop: Username dropdown */}
            <DropdownMenu>
              <DropdownMenuTrigger asChild>
                <Button variant="ghost" size="sm" className="hidden lg:flex gap-2 font-medium px-3 min-h-[40px] touch-manipulation">
                  <span className="text-foreground text-sm">{user.username}</span>
                  {user.role === 'admin' && (
                    <Shield className="w-4 h-4 text-primary shrink-0" />
                  )}
                </Button>
              </DropdownMenuTrigger>
              <DropdownMenuContent align="end" className="w-48">
                <div className="px-2 py-1.5 text-sm">
                  <p className="font-medium">{user.username}</p>
                  <p className="text-xs text-muted-foreground">
                    보유금액: {Math.floor(parseFloat(user.balance)).toLocaleString()}원
                  </p>
                  {(user as any).grade && (
                    <p className="text-xs text-primary font-medium mt-0.5">
                      등급: {(user as any).grade}
                    </p>
                  )}
                </div>
                <DropdownMenuSeparator />
                {user.role === 'admin' && (
                  <>
                    <DropdownMenuItem asChild>
                      <Link href="/admin" className="flex items-center gap-2 cursor-pointer">
                        <Shield className="w-4 h-4" />
                        관리자 패널
                      </Link>
                    </DropdownMenuItem>
                    <DropdownMenuSeparator />
                  </>
                )}
                <DropdownMenuItem
                  onClick={() => logout.mutate()}
                  className="text-destructive cursor-pointer"
                >
                  <LogOut className="w-4 h-4 mr-2" />
                  로그아웃
                </DropdownMenuItem>
              </DropdownMenuContent>
            </DropdownMenu>
          </>
        ) : null}
      </div>
    </header>
  );
}
