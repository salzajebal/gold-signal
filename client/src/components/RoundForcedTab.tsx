import { useState, useEffect } from 'react';
import { useQuery } from '@tanstack/react-query';
import { Button } from '@/components/ui/button';
import { toast } from 'sonner';
import { cn } from '@/lib/utils';
import {
  Clock, Zap, Calendar, Check, X, RefreshCw, TrendingUp, TrendingDown, Trash2,
} from 'lucide-react';

const SYMBOL_NAMES: Record<string, string> = {
  GOLD: '금거래',
  GBP: '파운드',
  BTC: 'BTC',
  SILVER: '은거래',
};

interface RoundForcedTabProps {
  apiBase?: 'admin' | 'affiliate';
}

export function RoundForcedTab({ apiBase = 'admin' }: RoundForcedTabProps) {
  const [selectedSymbol, setSelectedSymbol] = useState<string>('GOLD');
  const [selectedDuration, setSelectedDuration] = useState<number>(300);
  const [timeLeft, setTimeLeft] = useState({ minutes: 0, seconds: 0 });
  const [currentRound, setCurrentRound] = useState(1);
  const [isToggling, setIsToggling] = useState(false);
  const [isGlobalToggling, setIsGlobalToggling] = useState(false);
  const [selectedRound, setSelectedRound] = useState<number | null>(null);
  const duration = selectedDuration;

  const apiPrefix = apiBase === 'affiliate' ? '/api/affiliate' : '/api/admin';

  const getKSTDate = (): Date => {
    const now = new Date();
    const kstOffset = 9 * 60;
    const utcOffset = now.getTimezoneOffset();
    return new Date(now.getTime() + (utcOffset + kstOffset) * 60 * 1000);
  };

  const calculateRoundNumber = (durationSeconds: number): number => {
    const kstTime = getKSTDate();
    const secondsSinceMidnight = kstTime.getHours() * 3600 + kstTime.getMinutes() * 60 + kstTime.getSeconds();
    return Math.floor(secondsSinceMidnight / durationSeconds) + 1;
  };

  const getRoundTimeRemaining = (durationSeconds: number): number => {
    const kstTime = getKSTDate();
    const secondsSinceMidnight = kstTime.getHours() * 3600 + kstTime.getMinutes() * 60 + kstTime.getSeconds();
    const elapsedInRound = secondsSinceMidnight % durationSeconds;
    return durationSeconds - elapsedInRound;
  };

  const getKSTDateKey = () => {
    const kstDate = getKSTDate();
    const year = kstDate.getFullYear();
    const month = String(kstDate.getMonth() + 1).padStart(2, '0');
    const day = String(kstDate.getDate()).padStart(2, '0');
    return `${year}-${month}-${day}`;
  };

  const dateKey = getKSTDateKey();
  const maxRounds = Math.floor(86400 / duration);

  const getRoundTimeWindow = (roundNumber: number, durationSeconds: number): { start: string; end: string } => {
    const startSec = (roundNumber - 1) * durationSeconds;
    const endSec = roundNumber * durationSeconds;
    const fmt = (s: number) => {
      const h = Math.floor(s / 3600);
      const m = Math.floor((s % 3600) / 60);
      return `${h.toString().padStart(2, '0')}:${m.toString().padStart(2, '0')}`;
    };
    return { start: fmt(startSec), end: fmt(Math.min(endSec, 86400)) };
  };

  useEffect(() => {
    const calculateRoundInfo = () => {
      const round = calculateRoundNumber(duration);
      const remainingSeconds = getRoundTimeRemaining(duration);
      const minutes = Math.floor(remainingSeconds / 60);
      const seconds = remainingSeconds % 60;
      setCurrentRound(round);
      setTimeLeft({ minutes, seconds });
      setSelectedRound(prev => {
        if (prev !== null && prev < round) return null;
        return prev;
      });
    };
    calculateRoundInfo();
    const interval = setInterval(calculateRoundInfo, 1000);
    return () => clearInterval(interval);
  }, [duration]);

  const { data: forcedDirections = [], refetch: refetchDirections } = useQuery<any[]>({
    queryKey: [`${apiPrefix}/round-forced`, dateKey],
    queryFn: async () => {
      const res = await fetch(`${apiPrefix}/round-forced?dateKey=${dateKey}`, { credentials: 'include' });
      if (!res.ok) return [];
      return res.json();
    },
    refetchInterval: 5000,
  });

  const { data: globalForced = {}, refetch: refetchGlobal } = useQuery<Record<string, string>>({
    queryKey: [`${apiPrefix}/global-forced`],
    queryFn: async () => {
      const res = await fetch(`${apiPrefix}/global-forced`, { credentials: 'include' });
      if (!res.ok) return {};
      return res.json();
    },
    refetchInterval: 5000,
  });

  const currentGlobalKey = `${selectedSymbol}:${duration}`;
  const currentGlobalValue = globalForced[currentGlobalKey] || '';

  const effectiveSelectedRound = selectedRound ?? currentRound;
  const isSelectedFuture = effectiveSelectedRound > currentRound;
  const isSelectedPast = effectiveSelectedRound < currentRound;

  const handleGlobalToggle = async (forcedOutcome: 'all_win' | 'all_lose') => {
    if (isGlobalToggling) return;
    setIsGlobalToggling(true);
    try {
      const newValue = currentGlobalValue === forcedOutcome ? 'none' : forcedOutcome;
      const res = await fetch(`${apiPrefix}/global-forced`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        credentials: 'include',
        body: JSON.stringify({ symbol: selectedSymbol, duration, forcedOutcome: newValue }),
      });
      if (!res.ok) throw new Error('설정 실패');
      const result = await res.json();
      if (newValue === 'none') {
        toast.success(`${selectedSymbol} ${duration / 60}분 전체 회차 강제설정 해제`);
      } else {
        const reSettled = result.reSettled || 0;
        const reSettledMsg = reSettled > 0 ? ` (${reSettled}건 재정산)` : '';
        toast.success(`${selectedSymbol} ${duration / 60}분 전체 회차 ${newValue === 'all_win' ? '전체적중' : '전체미적중'} 적용${reSettledMsg}`);
      }
      refetchGlobal();
    } catch {
      toast.error('글로벌 강제설정에 실패했습니다');
    } finally {
      setIsGlobalToggling(false);
    }
  };

  const currentRoundSettings = forcedDirections.filter(
    d => d.symbol === selectedSymbol && d.duration === duration && d.roundNumber === effectiveSelectedRound
  );
  const hasDirection = currentRoundSettings.find(d => d.forcedDirection === 'up' || d.forcedDirection === 'down');
  const hasOutcome = currentRoundSettings.find(d => d.forcedDirection === 'all_win' || d.forcedDirection === 'all_lose');
  const hasDisplay = currentRoundSettings.find(d => d.forcedDirection === 'display_up' || d.forcedDirection === 'display_down');

  const handleToggle = async (forcedDirection: string) => {
    if (isToggling) return;
    setIsToggling(true);
    try {
      const res = await fetch(`${apiPrefix}/round-forced/toggle`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        credentials: 'include',
        body: JSON.stringify({ symbol: selectedSymbol, duration, roundNumber: effectiveSelectedRound, dateKey, forcedDirection }),
      });
      if (!res.ok) throw new Error('설정 실패');
      const result = await res.json();
      const labels: Record<string, string> = { up: '매수', down: '매도', all_win: '전체적중', all_lose: '전체미적중', display_up: '결과표시↑', display_down: '결과표시↓' };
      if (result.action === 'created') {
        toast.success(`${effectiveSelectedRound}회차 ${labels[forcedDirection]} 적용`);
      } else {
        toast.success(`${effectiveSelectedRound}회차 ${labels[forcedDirection]} 해제`);
      }
      refetchDirections();
    } catch {
      toast.error('회차별 설정에 실패했습니다');
    } finally {
      setIsToggling(false);
    }
  };

  const handleDeleteForced = async (item: any) => {
    try {
      const res = await fetch(`${apiPrefix}/round-forced/toggle`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        credentials: 'include',
        body: JSON.stringify({ symbol: item.symbol, duration: item.duration, roundNumber: item.roundNumber, dateKey: item.dateKey, forcedDirection: item.forcedDirection }),
      });
      if (!res.ok) throw new Error('삭제 실패');
      toast.success('설정이 해제되었습니다');
      refetchDirections();
    } catch {
      toast.error('삭제에 실패했습니다');
    }
  };

  const filteredDirections = forcedDirections
    .filter(d => d.symbol === selectedSymbol && d.duration === duration)
    .sort((a, b) => b.roundNumber - a.roundNumber);

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <h1 className="text-2xl font-bold">회차별 거래결과 설정</h1>
      </div>

      {/* Current Round Status Bar */}
      <div className="bg-gradient-to-r from-blue-600 to-blue-700 rounded-lg p-4 text-white flex items-center justify-between">
        <div className="flex items-center gap-3">
          <div className="bg-white/20 rounded-full p-2">
            <Clock className="w-5 h-5" />
          </div>
          <div>
            <div className="text-xs opacity-80">현재 진행 중인 회차</div>
            <div className="text-2xl font-bold">{currentRound}회차</div>
            <div className="text-xs opacity-70">총 {maxRounds}회차 중</div>
          </div>
        </div>
        <div className="text-right">
          <div className="text-xs opacity-80">남은 시간</div>
          <div className="text-3xl font-mono font-bold">
            {String(timeLeft.minutes).padStart(2, '0')}:{String(timeLeft.seconds).padStart(2, '0')}
          </div>
        </div>
      </div>

      {/* Round Picker */}
      <div className="bg-card border border-border rounded-lg p-4">
        <div className="flex items-center justify-between mb-3">
          <h3 className="font-medium flex items-center gap-2 text-sm">
            <Zap className="w-4 h-4 text-yellow-500" />
            회차 선택
            {isSelectedFuture && (
              <span className="text-xs px-2 py-0.5 rounded-full bg-green-500/20 text-green-400 font-normal">예약 모드</span>
            )}
            {isSelectedPast && (
              <span className="text-xs px-2 py-0.5 rounded-full bg-muted text-muted-foreground font-normal">과거 회차</span>
            )}
          </h3>
          {selectedRound !== null && (
            <Button variant="outline" size="sm" className="h-7 text-xs" onClick={() => setSelectedRound(null)}>
              현재 회차로 돌아가기
            </Button>
          )}
        </div>
        <div className="overflow-x-auto -mx-1 px-1 pb-1">
          <div className="flex gap-2 min-w-max">
            {Array.from({ length: 20 }, (_, i) => currentRound - 2 + i)
              .filter(r => r >= 1 && r <= maxRounds)
              .map(r => {
                const { start, end } = getRoundTimeWindow(r, duration);
                const rSettings = forcedDirections.filter(
                  d => d.symbol === selectedSymbol && d.duration === duration && d.roundNumber === r
                );
                const isSelected = r === effectiveSelectedRound;
                const isCurrent = r === currentRound;
                const isFuture = r > currentRound;
                const isPast = r < currentRound;
                return (
                  <button
                    key={r}
                    onClick={() => setSelectedRound(isCurrent ? null : r)}
                    className={cn(
                      'flex flex-col items-center px-2.5 py-2 rounded-lg border min-w-[72px] transition-all text-left',
                      isSelected && isCurrent
                        ? 'border-blue-500 bg-blue-500/20 ring-1 ring-blue-500'
                        : isSelected
                        ? 'border-amber-500 bg-amber-500/20 ring-1 ring-amber-500'
                        : isCurrent
                        ? 'border-blue-500/50 bg-blue-500/10'
                        : isFuture
                        ? 'border-border hover:border-green-500/50 hover:bg-green-500/5 cursor-pointer'
                        : 'border-border/50 bg-muted/10 opacity-60 cursor-pointer'
                    )}
                  >
                    <span className={cn('text-xs font-bold', isCurrent ? 'text-blue-400' : isFuture ? 'text-foreground' : 'text-muted-foreground')}>
                      #{r}
                    </span>
                    <span className="text-[9px] text-muted-foreground leading-tight">{start}</span>
                    <span className="text-[9px] text-muted-foreground leading-tight">~{end}</span>
                    {isCurrent && <span className="text-[8px] text-blue-400 font-medium mt-0.5">진행중</span>}
                    {isFuture && rSettings.length === 0 && <span className="text-[8px] text-muted-foreground mt-0.5">대기</span>}
                    {isPast && rSettings.length === 0 && <span className="text-[8px] text-muted-foreground mt-0.5">종료</span>}
                    {rSettings.length > 0 && (
                      <div className="flex flex-wrap gap-0.5 mt-1 justify-center">
                        {rSettings.map((s: any) => (
                          <span key={s.id} className={cn(
                            'text-[8px] px-1 py-0.5 rounded font-bold',
                            s.forcedDirection === 'display_up' ? 'bg-cyan-500/30 text-cyan-400' :
                            s.forcedDirection === 'display_down' ? 'bg-amber-500/30 text-amber-400' :
                            s.forcedDirection === 'all_win' ? 'bg-green-500/30 text-green-400' :
                            s.forcedDirection === 'all_lose' ? 'bg-red-500/30 text-red-400' :
                            s.forcedDirection === 'up' ? 'bg-up/30 text-up' : 'bg-down/30 text-down'
                          )}>
                            {s.forcedDirection === 'display_up' ? '↑' :
                             s.forcedDirection === 'display_down' ? '↓' :
                             s.forcedDirection === 'all_win' ? '✓전' :
                             s.forcedDirection === 'all_lose' ? '✗전' :
                             s.forcedDirection === 'up' ? '↑매' : '↓매'}
                          </span>
                        ))}
                      </div>
                    )}
                  </button>
                );
              })}
          </div>
        </div>
        <p className="text-[10px] text-muted-foreground mt-2">
          현재 회차 이후를 선택하면 해당 회차 시작 전 미리 결과를 예약할 수 있습니다.
        </p>
      </div>

      {/* Symbol & Duration Selection */}
      <div className="bg-card border border-border rounded-lg p-6">
        <h3 className="font-medium mb-4 flex items-center gap-2">
          <Zap className="w-4 h-4 text-yellow-500" />
          종목/시간 선택
        </h3>
        <div className="space-y-6">
          <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
            <div className="space-y-3">
              <label className="text-sm text-muted-foreground font-medium">종목 선택</label>
              <div className="grid grid-cols-3 gap-2">
                {[{ s: 'GOLD', l: '금거래' }, { s: 'GBP', l: '파운드' }, { s: 'BTC', l: 'BTC' }, { s: 'SILVER', l: '은거래' }].map(({ s, l }) => (
                  <Button
                    key={s}
                    type="button"
                    variant={selectedSymbol === s ? 'default' : 'outline'}
                    className={cn('h-12 text-sm font-bold', selectedSymbol === s && 'bg-amber-600 hover:bg-amber-700')}
                    onClick={() => setSelectedSymbol(s)}
                  >
                    {l}
                  </Button>
                ))}
              </div>
            </div>
            <div className="space-y-3">
              <label className="text-sm text-muted-foreground font-medium">시간 선택</label>
              <div className="flex gap-2">
                {[300].map(d => (
                  <Button
                    key={d}
                    type="button"
                    variant={selectedDuration === d ? 'default' : 'outline'}
                    className={cn('flex-1 h-12 text-sm font-bold', selectedDuration === d && 'bg-amber-600 hover:bg-amber-700')}
                    onClick={() => setSelectedDuration(d)}
                  >
                    {d / 60}분
                  </Button>
                ))}
              </div>
            </div>
          </div>
        </div>
      </div>

      {/* Global Forced Settings */}
      <div className={cn(
        'border rounded-lg p-6',
        currentGlobalValue ? 'bg-gradient-to-r from-purple-900/30 to-purple-800/20 border-purple-500/50' : 'bg-card border-border'
      )}>
        <h3 className="font-medium mb-2 flex items-center gap-2">
          <Zap className="w-4 h-4 text-purple-400" />
          전체 회차 자동 적용 (끌 때까지 모든 회차에 적용)
        </h3>
        <p className="text-xs text-muted-foreground mb-4">
          켜두면 해당 종목/시간의 모든 회차에 자동으로 적용됩니다. 개별 회차 설정이 있으면 개별 설정이 우선합니다.
        </p>
        <div className="grid grid-cols-2 gap-3">
          <Button
            type="button"
            disabled={isGlobalToggling}
            className={cn(
              'h-16 text-lg font-bold transition-all',
              currentGlobalValue === 'all_win'
                ? 'bg-green-600 hover:bg-green-700 text-white ring-2 ring-green-500 ring-offset-2 ring-offset-background'
                : 'bg-transparent border-2 border-green-600/50 text-green-500 hover:bg-green-600/10'
            )}
            onClick={() => handleGlobalToggle('all_win')}
          >
            <Check className="w-5 h-5 mr-2" />
            전체적중 (자동)
            {currentGlobalValue === 'all_win' && <Check className="w-4 h-4 ml-2" />}
          </Button>
          <Button
            type="button"
            disabled={isGlobalToggling}
            className={cn(
              'h-16 text-lg font-bold transition-all',
              currentGlobalValue === 'all_lose'
                ? 'bg-red-600 hover:bg-red-700 text-white ring-2 ring-red-500 ring-offset-2 ring-offset-background'
                : 'bg-transparent border-2 border-red-600/50 text-red-500 hover:bg-red-600/10'
            )}
            onClick={() => handleGlobalToggle('all_lose')}
          >
            <X className="w-5 h-5 mr-2" />
            전체미적중 (자동)
            {currentGlobalValue === 'all_lose' && <Check className="w-4 h-4 ml-2" />}
          </Button>
        </div>
        {currentGlobalValue && (
          <div className="mt-4 bg-muted/50 rounded-lg p-3">
            <div className="flex items-center gap-2">
              <span className={cn(
                'px-3 py-1.5 rounded-full text-sm font-bold animate-pulse',
                currentGlobalValue === 'all_win' ? 'bg-green-600/20 text-green-500' : 'bg-red-600/20 text-red-500'
              )}>
                {currentGlobalValue === 'all_win' ? '✅ 전체적중' : '❌ 전체미적중'} 자동 적용 중
              </span>
              <span className="text-xs text-muted-foreground">{selectedSymbol} {duration / 60}분 - 모든 회차</span>
            </div>
          </div>
        )}
        {Object.keys(globalForced).filter(k => globalForced[k]).length > 0 && (
          <div className="mt-4 border-t border-border/50 pt-4">
            <div className="text-xs text-muted-foreground font-medium mb-2">현재 활성화된 글로벌 설정:</div>
            <div className="flex flex-wrap gap-2">
              {Object.entries(globalForced).filter(([, v]) => v).map(([key, value]) => {
                const [sym, dur] = key.split(':');
                return (
                  <span key={key} className={cn(
                    'px-2 py-1 rounded text-xs font-bold',
                    value === 'all_win' ? 'bg-green-600/20 text-green-500' : 'bg-red-600/20 text-red-500',
                    key === currentGlobalKey && 'ring-1 ring-white/30'
                  )}>
                    {sym} {parseInt(dur) / 60}분: {value === 'all_win' ? '전체적중' : '전체미적중'}
                  </span>
                );
              })}
            </div>
          </div>
        )}
      </div>

      {/* Selected Round Settings */}
      <div className={cn(
        'border rounded-lg p-6',
        isSelectedFuture ? 'bg-green-950/20 border-green-500/30' : 'bg-card border-border'
      )}>
        <h3 className="font-medium mb-1 flex items-center gap-2">
          <Zap className="w-4 h-4 text-yellow-500" />
          {effectiveSelectedRound}회차 설정
          {isSelectedFuture && <span className="text-xs px-2 py-0.5 rounded-full bg-green-500/20 text-green-400">예약 — 회차 종료 시 자동 적용</span>}
          {!isSelectedFuture && !isSelectedPast && <span className="text-xs px-2 py-0.5 rounded-full bg-blue-500/20 text-blue-400">진행중</span>}
          {isSelectedPast && <span className="text-xs px-2 py-0.5 rounded-full bg-muted text-muted-foreground">종료된 회차</span>}
        </h3>
        {isSelectedFuture && (
          <p className="text-xs text-green-400/70 mb-4">
            ⏰ {getRoundTimeWindow(effectiveSelectedRound, duration).start} ~ {getRoundTimeWindow(effectiveSelectedRound, duration).end} 회차에 미리 결과를 예약합니다.
          </p>
        )}
        {!isSelectedFuture && !isSelectedPast && <p className="text-xs text-muted-foreground mb-4">현재 진행 중인 회차입니다. 설정 즉시 적용됩니다.</p>}
        {isSelectedPast && <p className="text-xs text-muted-foreground mb-4">이미 종료된 회차입니다. 재정산이 발생할 수 있습니다.</p>}

        <div className="space-y-6">
          <div className="space-y-3">
            <label className="text-sm text-muted-foreground font-medium">결과 방향 강제 (표시 + 정산 연동)</label>
            <p className="text-xs text-muted-foreground">이 회차의 결과 방향을 강제합니다. 매수 설정 시 매수 베팅 유저는 적중, 매도 유저는 미적중 처리됩니다.</p>
            <div className="grid grid-cols-2 gap-3">
              <Button
                type="button" disabled={isToggling}
                className={cn('h-14 text-base font-bold transition-all',
                  hasDisplay?.forcedDirection === 'display_up'
                    ? 'bg-cyan-600 hover:bg-cyan-700 text-white ring-2 ring-cyan-500 ring-offset-2 ring-offset-background'
                    : 'bg-transparent border-2 border-cyan-600/50 text-cyan-500 hover:bg-cyan-600/10'
                )}
                onClick={() => handleToggle('display_up')}
              >
                <TrendingUp className="w-5 h-5 mr-2" />
                결과↑ LONG
                {hasDisplay?.forcedDirection === 'display_up' && <Check className="w-4 h-4 ml-2" />}
              </Button>
              <Button
                type="button" disabled={isToggling}
                className={cn('h-14 text-base font-bold transition-all',
                  hasDisplay?.forcedDirection === 'display_down'
                    ? 'bg-amber-600 hover:bg-amber-700 text-white ring-2 ring-amber-500 ring-offset-2 ring-offset-background'
                    : 'bg-transparent border-2 border-amber-600/50 text-amber-500 hover:bg-amber-600/10'
                )}
                onClick={() => handleToggle('display_down')}
              >
                <TrendingDown className="w-5 h-5 mr-2" />
                결과↓ SHORT
                {hasDisplay?.forcedDirection === 'display_down' && <Check className="w-4 h-4 ml-2" />}
              </Button>
            </div>
          </div>

          {(hasDirection || hasOutcome || hasDisplay) && (
            <div className="bg-muted/50 rounded-lg p-4">
              <div className="text-sm font-medium mb-2">{effectiveSelectedRound}회차 현재 설정:</div>
              <div className="flex flex-wrap gap-2">
                {hasDirection && (
                  <span className={cn('px-3 py-1.5 rounded-full text-sm font-bold',
                    hasDirection.forcedDirection === 'up' ? 'bg-up/20 text-up' : 'bg-down/20 text-down'
                  )}>
                    {hasDirection.forcedDirection === 'up' ? '📈 매수' : '📉 매도'}
                  </span>
                )}
                {hasOutcome && (
                  <span className={cn('px-3 py-1.5 rounded-full text-sm font-bold',
                    hasOutcome.forcedDirection === 'all_win' ? 'bg-green-600/20 text-green-500' : 'bg-red-600/20 text-red-500'
                  )}>
                    {hasOutcome.forcedDirection === 'all_win' ? '✅ 전체적중' : '❌ 전체미적중'}
                  </span>
                )}
                {hasDisplay && (
                  <span className={cn('px-3 py-1.5 rounded-full text-sm font-bold',
                    hasDisplay.forcedDirection === 'display_up' ? 'bg-cyan-600/20 text-cyan-500' : 'bg-amber-600/20 text-amber-500'
                  )}>
                    {hasDisplay.forcedDirection === 'display_up' ? '🔵 결과↑' : '🟠 결과↓'}
                  </span>
                )}
              </div>
            </div>
          )}
        </div>
      </div>

      {/* Settings List */}
      <div className="bg-card border border-border rounded-lg overflow-hidden">
        <div className="p-4 border-b border-border flex items-center justify-between">
          <h3 className="font-medium">
            {SYMBOL_NAMES[selectedSymbol] || selectedSymbol} {duration / 60}분 - 오늘 설정된 회차 목록
          </h3>
          <Button variant="outline" size="sm" onClick={() => refetchDirections()}>
            <RefreshCw className="w-4 h-4 mr-1" />
            새로고침
          </Button>
        </div>
        <div className="overflow-x-auto">
          <table className="w-full text-sm">
            <thead className="bg-muted/50 border-b border-border">
              <tr>
                <th className="px-4 py-3 text-left font-medium">회차</th>
                <th className="px-4 py-3 text-left font-medium">상태</th>
                <th className="px-4 py-3 text-center font-medium">설정</th>
                <th className="px-4 py-3 text-center font-medium">관리</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-border">
              {filteredDirections.map((item) => (
                <tr key={item.id} className={cn('hover:bg-muted/30', item.roundNumber === currentRound && 'bg-blue-500/10')}>
                  <td className="px-4 py-3 font-mono">
                    {item.roundNumber}회차
                    {item.roundNumber === currentRound && (
                      <span className="ml-2 text-xs bg-blue-500 text-white px-2 py-0.5 rounded">진행중</span>
                    )}
                  </td>
                  <td className="px-4 py-3">
                    {item.roundNumber < currentRound ? (
                      <span className="text-muted-foreground">완료</span>
                    ) : item.roundNumber === currentRound ? (
                      <span className="text-blue-500 font-medium">진행중</span>
                    ) : (
                      <span className="text-green-500">대기 중</span>
                    )}
                  </td>
                  <td className="px-4 py-3 text-center">
                    <span className={cn('px-3 py-1 rounded text-sm font-medium',
                      item.forcedDirection === 'up' ? 'bg-up/20 text-up' :
                      item.forcedDirection === 'down' ? 'bg-down/20 text-down' :
                      item.forcedDirection === 'all_win' ? 'bg-green-600/20 text-green-500' :
                      item.forcedDirection === 'all_lose' ? 'bg-red-600/20 text-red-500' :
                      item.forcedDirection === 'display_up' ? 'bg-cyan-600/20 text-cyan-500' :
                      item.forcedDirection === 'display_down' ? 'bg-amber-600/20 text-amber-500' :
                      'bg-muted text-muted-foreground'
                    )}>
                      {item.forcedDirection === 'up' ? '매수' :
                       item.forcedDirection === 'down' ? '매도' :
                       item.forcedDirection === 'all_win' ? '전체적중' :
                       item.forcedDirection === 'all_lose' ? '전체미적중' :
                       item.forcedDirection === 'display_up' ? '결과↑' :
                       item.forcedDirection === 'display_down' ? '결과↓' : item.forcedDirection}
                    </span>
                  </td>
                  <td className="px-4 py-3 text-center">
                    {item.roundNumber >= currentRound && (
                      <Button
                        variant="outline" size="sm"
                        className="h-7 px-2 border-red-500/50 text-red-500 hover:bg-red-500/10"
                        onClick={() => handleDeleteForced(item)}
                      >
                        <Trash2 className="w-3 h-3" />
                      </Button>
                    )}
                  </td>
                </tr>
              ))}
              {filteredDirections.length === 0 && (
                <tr>
                  <td colSpan={4} className="px-4 py-8 text-center text-muted-foreground">설정된 회차가 없습니다</td>
                </tr>
              )}
            </tbody>
          </table>
        </div>
      </div>

      <div className="bg-blue-500/10 border border-blue-500/30 rounded-lg p-4">
        <h3 className="font-medium text-blue-500 mb-2 flex items-center gap-2">
          <Calendar className="w-4 h-4" />
          회차별 설정 안내
        </h3>
        <p className="text-sm text-muted-foreground">
          현재 진행 중인 회차의 거래 결과를 강제로 설정합니다. 설정된 회차에서는 모든 사용자의 거래가 지정된 방향으로 정산됩니다.
          매수로 설정하면 매수 거래는 승리, 매도 거래는 패배로 처리됩니다.
        </p>
      </div>
    </div>
  );
}
