import { useState, useEffect } from 'react';
import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Textarea } from '@/components/ui/textarea';
import { toast } from 'sonner';
import { cn } from '@/lib/utils';
import { RoundForcedTab } from '@/components/RoundForcedTab';
import {
  Users, LogOut, MessageSquare, RefreshCw, Eye, EyeOff,
  Edit2, ChevronLeft, ChevronRight,
  List, Zap, ArrowUp, ArrowDown, ArrowUpDown, X,
  TrendingDown, TrendingUp, Copy, Check,
} from 'lucide-react';

interface AffiliateAuth {
  id: string;
  username: string;
  displayName: string;
  referralCode: string;
  commissionRate: string;
}

interface AffiliateSummary {
  referralCode: string;
  totalUsers: number;
  totalDepositAmount: number;
  totalWithdrawalAmount: number;
  todayVolume: number;
  monthVolume: number;
  totalVolume: number;
}

interface AffiliateUser {
  id: string;
  username: string;
  password: string;
  name: string | null;
  phone: string | null;
  balance: string;
  totalBet: string;
  totalWin: string;
  totalDeposit: string;
  totalWithdrawal: string;
  profitRate: string;
  betCount: number;
  winCount: number;
  isActive: boolean;
  isBettingBlocked: boolean;
  forcedBetDirection: 'up' | 'down' | null;
  alwaysPendingEnabled: boolean;
  grade: string;
  createdAt: string;
  lastLoginAt: string | null;
}

interface AffiliateBet {
  id: number;
  userId: string;
  username: string;
  name: string;
  symbol: string;
  direction: string;
  amount: string;
  duration: number;
  roundNumber: number | null;
  outcome: string;
  forcedOutcome: 'win' | 'lose' | null;
  balanceBefore: string | null;
  balanceAfter: string | null;
  createdAt: string;
}

interface AffiliateTransaction {
  id: number;
  userId: string;
  username: string | undefined;
  name: string | null | undefined;
  type: string;
  amount: string;
  status: string;
  bankName: string | null;
  accountHolder: string | null;
  accountNumber: string | null;
  senderName: string | null;
  adminNote: string | null;
  createdAt: string;
  processedAt: string | null;
  userBankName: string | null | undefined;
  userAccountHolder: string | null | undefined;
  userAccountNumber: string | null | undefined;
}

interface AffiliateInquiry {
  id: number;
  userId: string;
  username: string;
  subject: string;
  message: string;
  status: string;
  reply: string | null;
  createdAt: string;
  repliedAt: string | null;
}

const SYMBOL_NAMES: Record<string, string> = {
  GOLD: '금거래',
  GBP: '파운드',
  BTC: 'BTC',
  SILVER: '은거래',
};

const formatMoney = (amount: string | number) => {
  const num = typeof amount === 'string' ? parseFloat(amount) : amount;
  if (isNaN(num)) return '0원';
  return num.toLocaleString('ko-KR') + '원';
};

const formatDate = (date: string | null) => {
  if (!date) return '-';
  return new Date(date).toLocaleString('ko-KR', {
    month: '2-digit', day: '2-digit',
    hour: '2-digit', minute: '2-digit',
    timeZone: 'Asia/Seoul',
  });
};

function AffiliateLogin() {
  const [username, setUsername] = useState('');
  const [password, setPassword] = useState('');
  const [loading, setLoading] = useState(false);

  const handleLogin = async (e: React.FormEvent) => {
    e.preventDefault();
    setLoading(true);
    try {
      const res = await fetch('/api/affiliate/login', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        credentials: 'include',
        body: JSON.stringify({ username, password }),
      });
      if (!res.ok) {
        const err = await res.json();
        toast.error(err.error || '로그인에 실패했습니다');
        return;
      }
      window.location.reload();
    } catch {
      toast.error('로그인에 실패했습니다');
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="min-h-screen flex items-center justify-center bg-background">
      <div className="w-full max-w-sm bg-card border border-border rounded-xl p-8 space-y-6 shadow-lg">
        <div className="text-center">
          <h1 className="text-2xl font-bold">총판 로그인</h1>
          <p className="text-sm text-muted-foreground mt-1">Gold-signal 총판 관리 시스템</p>
        </div>
        <form onSubmit={handleLogin} className="space-y-4">
          <div className="space-y-2">
            <label className="text-sm font-medium">아이디</label>
            <Input value={username} onChange={e => setUsername(e.target.value)} placeholder="아이디 입력" required />
          </div>
          <div className="space-y-2">
            <label className="text-sm font-medium">비밀번호</label>
            <Input type="password" value={password} onChange={e => setPassword(e.target.value)} placeholder="비밀번호 입력" required />
          </div>
          <Button type="submit" className="w-full" disabled={loading}>
            {loading ? '로그인 중...' : '로그인'}
          </Button>
        </form>
      </div>
    </div>
  );
}

export default function AffiliateDashboard() {
  const queryClient = useQueryClient();
  const [activeTab, setActiveTab] = useState<'users' | 'order-history' | 'round-forced' | 'inquiries' | 'deposits' | 'withdrawals'>('users');

  // Users tab state
  const [userSearchQuery, setUserSearchQuery] = useState('');
  const [showPasswords, setShowPasswords] = useState<Record<string, boolean>>({});
  const [editingUser, setEditingUser] = useState<AffiliateUser | null>(null);
  const [userSortField, setUserSortField] = useState<string | null>(null);
  const [userSortDirection, setUserSortDirection] = useState<'asc' | 'desc'>('desc');
  const [isManualRefreshing, setIsManualRefreshing] = useState(false);

  // Edit dialog state
  const [editBalanceAdjust, setEditBalanceAdjust] = useState('');
  const [editForcedDir, setEditForcedDir] = useState<'up' | 'down' | 'none'>('none');
  const [editAlwaysPending, setEditAlwaysPending] = useState(false);
  const [editBettingBlocked, setEditBettingBlocked] = useState(false);
  const [editIsActive, setEditIsActive] = useState(true);
  const [isSaving, setIsSaving] = useState(false);

  // Order history state
  const [orderPage, setOrderPage] = useState(1);
  const [orderPageSize, setOrderPageSize] = useState(20);
  const [orderSearch, setOrderSearch] = useState('');
  const [orderSearchInput, setOrderSearchInput] = useState('');

  // Inquiries state
  const [replyingTo, setReplyingTo] = useState<number | null>(null);
  const [replyText, setReplyText] = useState('');

  const [codeCopied, setCodeCopied] = useState(false);

  // Auth check
  const { data: auth, isLoading: authLoading } = useQuery<AffiliateAuth | null>({
    queryKey: ['/api/affiliate/me'],
    queryFn: async () => {
      const res = await fetch('/api/affiliate/me', { credentials: 'include' });
      if (!res.ok) return null;
      return res.json();
    },
    retry: false,
  });

  // Summary
  const { data: summary, refetch: refetchSummary } = useQuery<AffiliateSummary>({
    queryKey: ['/api/affiliate/summary'],
    queryFn: async () => {
      const res = await fetch('/api/affiliate/summary', { credentials: 'include' });
      if (!res.ok) throw new Error('failed');
      return res.json();
    },
    enabled: !!auth,
    refetchInterval: 30000,
  });

  // Users
  const { data: users = [], refetch: refetchUsers } = useQuery<AffiliateUser[]>({
    queryKey: ['/api/affiliate/users'],
    queryFn: async () => {
      const res = await fetch('/api/affiliate/users', { credentials: 'include' });
      if (!res.ok) return [];
      return res.json();
    },
    enabled: !!auth,
    refetchInterval: 15000,
  });

  // Order history
  const { data: orderHistory, refetch: refetchOrderHistory, isFetching: isOrderFetching } = useQuery<{
    bets: AffiliateBet[];
    total: number;
    totalPages: number;
  }>({
    queryKey: ['/api/affiliate/bets/history', orderPage, orderPageSize, orderSearch],
    queryFn: async () => {
      const params = new URLSearchParams({
        page: orderPage.toString(),
        pageSize: orderPageSize.toString(),
        search: orderSearch,
      });
      const res = await fetch(`/api/affiliate/bets/history?${params}`, { credentials: 'include' });
      if (!res.ok) return { bets: [], total: 0, totalPages: 0 };
      return res.json();
    },
    enabled: !!auth && activeTab === 'order-history',
    refetchInterval: 10000,
  });

  // Inquiries
  const { data: inquiries = [], refetch: refetchInquiries, isFetching: isInquiriesFetching } = useQuery<AffiliateInquiry[]>({
    queryKey: ['/api/affiliate/inquiries'],
    queryFn: async () => {
      const res = await fetch('/api/affiliate/inquiries', { credentials: 'include' });
      if (!res.ok) return [];
      return res.json();
    },
    enabled: !!auth && activeTab === 'inquiries',
    refetchInterval: 15000,
  });

  // Deposits
  const { data: deposits = [], refetch: refetchDeposits, isFetching: isDepositsFetching } = useQuery<AffiliateTransaction[]>({
    queryKey: ['/api/affiliate/transactions', 'deposit'],
    queryFn: async () => {
      const res = await fetch('/api/affiliate/transactions?type=deposit', { credentials: 'include' });
      if (!res.ok) return [];
      return res.json();
    },
    enabled: !!auth && activeTab === 'deposits',
    refetchInterval: 15000,
  });

  // Withdrawals
  const { data: withdrawals = [], refetch: refetchWithdrawals, isFetching: isWithdrawalsFetching } = useQuery<AffiliateTransaction[]>({
    queryKey: ['/api/affiliate/transactions', 'withdrawal'],
    queryFn: async () => {
      const res = await fetch('/api/affiliate/transactions?type=withdrawal', { credentials: 'include' });
      if (!res.ok) return [];
      return res.json();
    },
    enabled: !!auth && activeTab === 'withdrawals',
    refetchInterval: 15000,
  });

  // Open edit dialog → init state
  useEffect(() => {
    if (editingUser) {
      setEditBalanceAdjust('');
      setEditForcedDir(editingUser.forcedBetDirection ?? 'none');
      setEditAlwaysPending(editingUser.alwaysPendingEnabled);
      setEditBettingBlocked(editingUser.isBettingBlocked);
      setEditIsActive(editingUser.isActive);
    }
  }, [editingUser]);

  const handleLogout = async () => {
    await fetch('/api/affiliate/logout', { method: 'POST', credentials: 'include' });
    window.location.reload();
  };

  const handleSaveUser = async () => {
    if (!editingUser) return;
    setIsSaving(true);
    try {
      const body: any = {
        forcedBetDirection: editForcedDir,
        alwaysPendingEnabled: editAlwaysPending,
        isBettingBlocked: editBettingBlocked,
        isActive: editIsActive,
      };
      const adj = parseFloat(editBalanceAdjust);
      if (!isNaN(adj) && adj !== 0) {
        body.balanceAdjust = adj;
      }
      const res = await fetch(`/api/affiliate/users/${editingUser.id}/manage`, {
        method: 'PATCH',
        headers: { 'Content-Type': 'application/json' },
        credentials: 'include',
        body: JSON.stringify(body),
      });
      if (!res.ok) throw new Error();
      toast.success(`${editingUser.username} 정보가 저장되었습니다`);
      setEditingUser(null);
      refetchUsers();
    } catch {
      toast.error('저장에 실패했습니다');
    } finally {
      setIsSaving(false);
    }
  };

  const handleProcessTransaction = async (id: number, status: 'approved' | 'rejected', refetch: () => void) => {
    try {
      const res = await fetch(`/api/affiliate/transactions/${id}/process`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        credentials: 'include',
        body: JSON.stringify({ status }),
      });
      if (!res.ok) {
        const d = await res.json().catch(() => ({}));
        toast.error(d.error || '처리에 실패했습니다');
        return;
      }
      toast.success(status === 'approved' ? '승인 완료' : '거절 완료');
      refetch();
      refetchUsers();
    } catch {
      toast.error('처리에 실패했습니다');
    }
  };

  const handleReply = async (inquiryId: number) => {
    if (!replyText.trim()) { toast.error('답변을 입력해주세요'); return; }
    try {
      const res = await fetch(`/api/affiliate/inquiries/${inquiryId}/reply`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        credentials: 'include',
        body: JSON.stringify({ reply: replyText }),
      });
      if (!res.ok) throw new Error();
      toast.success('답변이 등록되었습니다');
      setReplyingTo(null);
      setReplyText('');
      refetchInquiries();
    } catch {
      toast.error('답변 등록에 실패했습니다');
    }
  };

  if (authLoading) {
    return <div className="min-h-screen flex items-center justify-center">로딩 중...</div>;
  }
  if (!auth) return <AffiliateLogin />;

  const filteredUsers = users
    .filter(user => {
      const q = userSearchQuery.toLowerCase();
      return !q || user.username.toLowerCase().includes(q) || (user.name || '').toLowerCase().includes(q);
    })
    .sort((a, b) => {
      if (!userSortField) return 0;
      const aVal = parseFloat((a as any)[userSortField] || '0');
      const bVal = parseFloat((b as any)[userSortField] || '0');
      return userSortDirection === 'desc' ? bVal - aVal : aVal - bVal;
    });

  const tabs = [
    { key: 'users', label: '회원관리', icon: Users },
    { key: 'order-history', label: '주문내역', icon: List },
    { key: 'deposits', label: '입금신청', icon: TrendingUp },
    { key: 'withdrawals', label: '출금신청', icon: TrendingDown },
    { key: 'round-forced', label: '회차별 설정', icon: Zap },
    { key: 'inquiries', label: '1:1 문의', icon: MessageSquare },
  ] as const;

  return (
    <div className="min-h-screen bg-background">
      {/* Header */}
      <header className="border-b border-border bg-card sticky top-0 z-50">
        <div className="max-w-7xl mx-auto px-4 py-3 flex items-center justify-between">
          <div className="flex items-center gap-3">
            <span className="text-lg font-bold">Gold-signal 총판</span>
            <span className="text-sm text-muted-foreground">{auth.displayName}</span>
          </div>
          <button
            onClick={handleLogout}
            className="flex items-center gap-1.5 text-sm text-muted-foreground hover:text-foreground transition-colors"
          >
            <LogOut className="w-4 h-4" />
            로그아웃
          </button>
        </div>
      </header>

      <div className="max-w-7xl mx-auto px-4 py-6 space-y-6">

        {/* ── 요약 대시보드 ── */}
        <div className="grid grid-cols-2 lg:grid-cols-4 gap-3">
          {/* 총판코드 */}
          <div className="bg-card border border-border rounded-xl p-4 space-y-1">
            <p className="text-xs text-muted-foreground font-medium">총판코드</p>
            <div className="flex items-center gap-2">
              <span className="text-lg font-bold tracking-widest text-primary">
                {summary?.referralCode ?? auth.referralCode ?? '-'}
              </span>
              <button
                onClick={() => {
                  const code = summary?.referralCode ?? auth.referralCode;
                  if (!code) return;
                  navigator.clipboard.writeText(code).then(() => {
                    setCodeCopied(true);
                    setTimeout(() => setCodeCopied(false), 1500);
                  });
                }}
                className="text-muted-foreground hover:text-foreground transition-colors"
              >
                {codeCopied ? <Check className="w-3.5 h-3.5 text-up" /> : <Copy className="w-3.5 h-3.5" />}
              </button>
            </div>
          </div>

          {/* 총 회원 수 */}
          <div className="bg-card border border-border rounded-xl p-4 space-y-1">
            <p className="text-xs text-muted-foreground font-medium">총 회원 수</p>
            <p className="text-lg font-bold">
              {summary != null ? `${summary.totalUsers.toLocaleString('ko-KR')}명` : `${users.length.toLocaleString('ko-KR')}명`}
            </p>
          </div>

          {/* 총 입금 합계 */}
          <div className="bg-card border border-border rounded-xl p-4 space-y-1">
            <p className="text-xs text-muted-foreground font-medium">총 입금 합계</p>
            <p className="text-lg font-bold text-up">
              {summary != null ? (summary.totalDepositAmount).toLocaleString('ko-KR') + '원' : '-'}
            </p>
            <p className="text-xs text-muted-foreground">승인 완료 기준</p>
          </div>

          {/* 총 출금 합계 */}
          <div className="bg-card border border-border rounded-xl p-4 space-y-1">
            <p className="text-xs text-muted-foreground font-medium">총 출금 합계</p>
            <p className="text-lg font-bold text-down">
              {summary != null ? (summary.totalWithdrawalAmount).toLocaleString('ko-KR') + '원' : '-'}
            </p>
            <p className="text-xs text-muted-foreground">승인 완료 기준</p>
          </div>
        </div>

        {/* Tabs */}
        <div className="flex gap-1 border-b border-border overflow-x-auto">
          {tabs.map(({ key, label, icon: Icon }) => (
            <button
              key={key}
              onClick={() => setActiveTab(key)}
              className={cn(
                'flex items-center gap-2 px-4 py-2.5 text-sm font-medium whitespace-nowrap border-b-2 transition-colors',
                activeTab === key
                  ? 'border-primary text-primary'
                  : 'border-transparent text-muted-foreground hover:text-foreground'
              )}
            >
              <Icon className="w-4 h-4" />
              {label}
            </button>
          ))}
        </div>

        {/* ── 회원관리 탭 ── */}
        {activeTab === 'users' && (
          <div className="space-y-3 lg:space-y-4">
            <div className="flex items-center justify-between flex-wrap gap-2">
              <h1 className="text-lg lg:text-2xl font-bold">회원 관리</h1>
              <Button variant="outline" size="sm" disabled={isManualRefreshing} onClick={async () => {
                setIsManualRefreshing(true);
                await refetchUsers();
                setTimeout(() => { setIsManualRefreshing(false); toast.success('새로고침 완료'); }, 600);
              }} className="h-8 px-2 lg:px-3">
                <RefreshCw className={cn('w-4 h-4 lg:mr-2', isManualRefreshing && 'animate-spin')} />
                <span className="hidden lg:inline">새로고침</span>
              </Button>
            </div>

            <div className="flex items-center gap-2 flex-wrap">
              <div className="relative flex-1 max-w-md">
                <Input
                  type="text"
                  placeholder="아이디, 이름으로 검색..."
                  value={userSearchQuery}
                  onChange={e => setUserSearchQuery(e.target.value)}
                  className="pr-8"
                />
                {userSearchQuery && (
                  <button onClick={() => setUserSearchQuery('')} className="absolute right-2 top-1/2 -translate-y-1/2 text-muted-foreground hover:text-foreground">
                    <X className="w-4 h-4" />
                  </button>
                )}
              </div>
              {userSearchQuery && (
                <span className="text-sm text-muted-foreground">{filteredUsers.length}건 검색됨</span>
              )}
            </div>

            <div className="bg-card border border-border rounded-lg overflow-hidden">
              <div className="overflow-x-auto">
                <table className="w-full text-xs lg:text-sm">
                  <thead className="bg-muted/30">
                    <tr className="text-left text-muted-foreground">
                      <th className="px-2 lg:px-3 py-2 whitespace-nowrap">상태</th>
                      <th className="px-2 lg:px-3 py-2 whitespace-nowrap">아이디</th>
                      <th className="px-2 lg:px-3 py-2 whitespace-nowrap">비밀번호</th>
                      <th className="px-2 lg:px-3 py-2 whitespace-nowrap">이름</th>
                      <th className="px-2 lg:px-3 py-2 whitespace-nowrap">강제설정</th>
                      {[
                        { field: 'balance', label: '보유머니' },
                        { field: 'totalBet', label: '총거래' },
                        { field: 'totalDeposit', label: '총입금' },
                        { field: 'totalWithdrawal', label: '총출금' },
                        { field: 'profitRate', label: '수익률' },
                      ].map(col => (
                        <th key={col.field} className="px-2 lg:px-3 py-2 whitespace-nowrap">
                          <button
                            onClick={() => {
                              if (userSortField === col.field) {
                                if (userSortDirection === 'desc') setUserSortDirection('asc');
                                else setUserSortField(null);
                              } else {
                                setUserSortField(col.field);
                                setUserSortDirection('desc');
                              }
                            }}
                            className={cn('flex items-center gap-1 hover:text-foreground transition-colors', userSortField === col.field ? 'text-primary font-semibold' : '')}
                          >
                            {col.label}
                            {userSortField === col.field
                              ? (userSortDirection === 'desc' ? <ArrowDown className="w-3 h-3" /> : <ArrowUp className="w-3 h-3" />)
                              : <ArrowUpDown className="w-3 h-3 opacity-40" />}
                          </button>
                        </th>
                      ))}
                      <th className="px-2 lg:px-3 py-2 whitespace-nowrap">최근로그인</th>
                      <th className="px-2 lg:px-3 py-2 whitespace-nowrap">가입일</th>
                      <th className="px-2 lg:px-3 py-2 whitespace-nowrap text-right">관리</th>
                    </tr>
                  </thead>
                  <tbody>
                    {filteredUsers.length === 0 && (
                      <tr><td colSpan={13} className="px-3 py-8 text-center text-muted-foreground">회원이 없습니다</td></tr>
                    )}
                    {filteredUsers.map(user => (
                      <tr key={user.id} className="border-t border-border/50 hover:bg-muted/10">
                        <td className="px-2 lg:px-3 py-1.5 lg:py-2">
                          <span className={cn('inline-flex items-center px-1.5 lg:px-2 py-0.5 rounded text-[10px] lg:text-xs font-medium',
                            user.isActive ? 'bg-up/20 text-up' : 'bg-down/20 text-down'
                          )}>
                            {user.isActive ? '활성' : '동결'}
                          </span>
                        </td>
                        <td className="px-2 lg:px-3 py-1.5 lg:py-2 font-medium">
                          <button onClick={() => setEditingUser(user)} className="text-primary hover:text-primary/80 hover:underline font-medium">
                            {user.username}
                          </button>
                          {user.isBettingBlocked && (
                            <span className="ml-1 text-[10px] bg-red-500/20 text-red-400 px-1 rounded">배팅차단</span>
                          )}
                        </td>
                        <td className="px-2 lg:px-3 py-1.5 lg:py-2">
                          <div className="flex items-center gap-1">
                            <span className="font-mono text-[10px] lg:text-xs">
                              {showPasswords[user.id] ? user.password : '••••••'}
                            </span>
                            <button onClick={() => setShowPasswords(p => ({ ...p, [user.id]: !p[user.id] }))} className="text-muted-foreground hover:text-foreground p-0.5">
                              {showPasswords[user.id] ? <EyeOff className="w-3 h-3" /> : <Eye className="w-3 h-3" />}
                            </button>
                          </div>
                        </td>
                        <td className="px-2 lg:px-3 py-1.5 lg:py-2">{user.name || '-'}</td>
                        <td className="px-2 lg:px-3 py-1.5 lg:py-2">
                          <div className="flex flex-col gap-0.5">
                            {user.forcedBetDirection ? (
                              <span className={cn('inline-flex items-center gap-1 px-1.5 lg:px-2 py-0.5 rounded text-[10px] lg:text-xs font-bold',
                                user.forcedBetDirection === 'up' ? 'bg-up/30 text-up' : 'bg-down/30 text-down'
                              )}>
                                {user.forcedBetDirection === 'up' ? '매수' : '매도'}
                              </span>
                            ) : null}
                            {user.alwaysPendingEnabled && (
                              <span className="inline-flex items-center gap-0.5 px-1.5 py-0.5 rounded text-[10px] font-bold bg-red-500/20 text-red-400">미실현</span>
                            )}
                            {!user.forcedBetDirection && !user.alwaysPendingEnabled && (
                              <span className="text-muted-foreground">-</span>
                            )}
                          </div>
                        </td>
                        <td className="px-2 lg:px-3 py-1.5 lg:py-2 font-mono">{formatMoney(user.balance)}</td>
                        <td className="px-2 lg:px-3 py-1.5 lg:py-2 font-mono">{formatMoney(user.totalBet)}</td>
                        <td className="px-2 lg:px-3 py-1.5 lg:py-2 font-mono">{formatMoney(user.totalDeposit)}</td>
                        <td className="px-2 lg:px-3 py-1.5 lg:py-2 font-mono">{formatMoney(user.totalWithdrawal)}</td>
                        <td className="px-2 lg:px-3 py-1.5 lg:py-2">
                          <span className={cn('font-medium', parseFloat(user.profitRate) >= 0 ? 'text-up' : 'text-down')}>
                            {parseFloat(user.profitRate) >= 0 ? '+' : ''}{user.profitRate}%
                          </span>
                        </td>
                        <td className="px-2 lg:px-3 py-1.5 lg:py-2 text-[10px] lg:text-xs text-muted-foreground whitespace-nowrap">
                          {formatDate(user.lastLoginAt)}
                        </td>
                        <td className="px-2 lg:px-3 py-1.5 lg:py-2 text-[10px] lg:text-xs text-muted-foreground whitespace-nowrap">
                          {formatDate(user.createdAt)}
                        </td>
                        <td className="px-2 lg:px-3 py-1.5 lg:py-2">
                          <div className="flex items-center justify-end gap-1">
                            <button
                              onClick={() => setEditingUser(user)}
                              className="inline-flex items-center gap-1 px-2 lg:px-3 py-1 lg:py-1.5 rounded-md bg-primary text-primary-foreground hover:bg-primary/90 text-[10px] lg:text-xs font-medium transition-colors"
                            >
                              <Edit2 className="w-3 h-3" />
                              <span className="hidden lg:inline">수정</span>
                            </button>
                          </div>
                        </td>
                      </tr>
                    ))}
                  </tbody>
                </table>
              </div>
            </div>
          </div>
        )}

        {/* ── 주문내역 탭 ── */}
        {activeTab === 'order-history' && (
          <div className="space-y-4">
            <div className="flex items-center justify-between flex-wrap gap-2">
              <h1 className="text-lg lg:text-2xl font-bold flex items-center gap-2">
                <List className="w-5 h-5 text-primary" />
                주문내역
              </h1>
              <Button variant="outline" size="sm" onClick={async () => {
                await refetchOrderHistory();
                toast.success('새로고침 완료');
              }} className="h-8 px-2 lg:px-3">
                <RefreshCw className={cn("w-4 h-4 lg:mr-2", isOrderFetching && "animate-spin")} />
                <span className="hidden lg:inline">새로고침</span>
              </Button>
            </div>

            <div className="flex items-center gap-2 flex-wrap">
              <div className="flex items-center gap-2 flex-1 min-w-[200px]">
                <Input
                  placeholder="회원 아이디 또는 이름 검색"
                  value={orderSearchInput}
                  onChange={e => setOrderSearchInput(e.target.value)}
                  onKeyDown={e => { if (e.key === 'Enter') { setOrderSearch(orderSearchInput); setOrderPage(1); } }}
                  className="h-8 text-sm"
                />
                <Button size="sm" className="h-8 px-3" onClick={() => { setOrderSearch(orderSearchInput); setOrderPage(1); }}>검색</Button>
                {orderSearch && (
                  <Button size="sm" variant="ghost" className="h-8 px-2" onClick={() => { setOrderSearch(''); setOrderSearchInput(''); setOrderPage(1); }}>
                    <X className="w-4 h-4" />
                  </Button>
                )}
              </div>
              <div className="flex items-center gap-1 text-sm text-muted-foreground">
                <span>보기:</span>
                <select value={orderPageSize} onChange={e => { setOrderPageSize(Number(e.target.value)); setOrderPage(1); }} className="h-8 rounded border border-border bg-background text-sm px-1">
                  {[10, 20, 50, 100].map(n => <option key={n} value={n}>{n}</option>)}
                </select>
                <span>개</span>
              </div>
            </div>

            {orderHistory && (
              <p className="text-xs text-muted-foreground">
                전체 <span className="text-foreground font-medium">{orderHistory.total.toLocaleString()}</span>건 중{' '}
                {((orderPage - 1) * orderPageSize + 1).toLocaleString()}–{Math.min(orderPage * orderPageSize, orderHistory.total).toLocaleString()}번째
              </p>
            )}

            <div className="bg-card border border-border rounded-lg overflow-hidden">
              <div className="overflow-x-auto">
                <table className="w-full text-xs lg:text-sm">
                  <thead className="bg-muted/30">
                    <tr className="text-left text-muted-foreground">
                      <th className="px-2 lg:px-3 py-2 whitespace-nowrap">거래번호</th>
                      <th className="px-2 lg:px-3 py-2 whitespace-nowrap">아이디 (이름)</th>
                      <th className="px-2 lg:px-3 py-2 whitespace-nowrap">종목</th>
                      <th className="px-2 lg:px-3 py-2 whitespace-nowrap">시간</th>
                      <th className="px-2 lg:px-3 py-2 whitespace-nowrap text-right">회차</th>
                      <th className="px-2 lg:px-3 py-2 whitespace-nowrap text-center">회원픽</th>
                      <th className="px-2 lg:px-3 py-2 whitespace-nowrap text-center">리모컨</th>
                      <th className="px-2 lg:px-3 py-2 whitespace-nowrap text-center">결과</th>
                      <th className="px-2 lg:px-3 py-2 whitespace-nowrap text-right">거래금액</th>
                      <th className="px-2 lg:px-3 py-2 whitespace-nowrap text-right">거래전 보유금</th>
                      <th className="px-2 lg:px-3 py-2 whitespace-nowrap text-right">거래후 보유금</th>
                      <th className="px-2 lg:px-3 py-2 whitespace-nowrap text-center">상태</th>
                    </tr>
                  </thead>
                  <tbody>
                    {!orderHistory && (
                      <tr><td colSpan={12} className="px-3 py-8 text-center text-muted-foreground">불러오는 중...</td></tr>
                    )}
                    {orderHistory?.bets.length === 0 && (
                      <tr><td colSpan={12} className="px-3 py-8 text-center text-muted-foreground">거래 내역이 없습니다</td></tr>
                    )}
                    {orderHistory?.bets.map(bet => {
                      const timeStr = new Date(bet.createdAt).toLocaleString('ko-KR', {
                        month: '2-digit', day: '2-digit',
                        hour: '2-digit', minute: '2-digit',
                        timeZone: 'Asia/Seoul',
                      });
                      const isWin = bet.outcome === 'win';
                      const isLose = bet.outcome === 'lose';
                      const isPending = bet.outcome === 'pending';
                      return (
                        <tr key={bet.id} className="border-t border-border/50 hover:bg-muted/10">
                          <td className="px-2 lg:px-3 py-1.5 font-mono text-muted-foreground">{bet.id}</td>
                          <td className="px-2 lg:px-3 py-1.5">
                            <div className="font-medium">{bet.username}</div>
                            {bet.name && <div className="text-[10px] text-muted-foreground">{bet.name}</div>}
                          </td>
                          <td className="px-2 lg:px-3 py-1.5 whitespace-nowrap">{SYMBOL_NAMES[bet.symbol] || bet.symbol}</td>
                          <td className="px-2 lg:px-3 py-1.5 whitespace-nowrap text-muted-foreground">{timeStr}</td>
                          <td className="px-2 lg:px-3 py-1.5 text-right">
                            <span className="inline-flex items-center px-1.5 py-0.5 rounded text-[10px] font-medium bg-yellow-500/20 text-yellow-500">
                              {bet.roundNumber}회차
                            </span>
                          </td>
                          <td className="px-2 lg:px-3 py-1.5 text-center">
                            <span className={cn('inline-flex items-center px-1.5 py-0.5 rounded text-[10px] font-bold',
                              bet.direction === 'long' ? 'bg-up/20 text-up' : 'bg-down/20 text-down'
                            )}>
                              {bet.direction === 'long' ? '매수' : '매도'}
                            </span>
                          </td>
                          <td className="px-2 lg:px-3 py-1.5 text-center">
                            {bet.forcedOutcome ? (
                              <span className={cn('inline-flex items-center px-1.5 py-0.5 rounded text-[10px] font-bold',
                                bet.forcedOutcome === 'win' ? 'bg-up/20 text-up' : 'bg-down/20 text-down'
                              )}>
                                {bet.forcedOutcome === 'win' ? '적중' : '미적중'}
                              </span>
                            ) : <span className="text-muted-foreground">-</span>}
                          </td>
                          <td className="px-2 lg:px-3 py-1.5 text-center">
                            {isPending ? (
                              <span className="inline-flex items-center px-1.5 py-0.5 rounded text-[10px] font-medium bg-yellow-500/20 text-yellow-500">진행중</span>
                            ) : (() => {
                              const resultDir = isWin ? bet.direction : (bet.direction === 'long' ? 'short' : 'long');
                              return resultDir === 'long'
                                ? <span className="inline-flex items-center px-1.5 py-0.5 rounded text-[10px] font-medium bg-up/20 text-up">매수</span>
                                : <span className="inline-flex items-center px-1.5 py-0.5 rounded text-[10px] font-medium bg-down/20 text-down">매도</span>;
                            })()}
                          </td>
                          <td className="px-2 lg:px-3 py-1.5 text-right whitespace-nowrap font-medium">{formatMoney(parseFloat(bet.amount))}</td>
                          <td className="px-2 lg:px-3 py-1.5 text-right whitespace-nowrap text-muted-foreground">
                            {bet.balanceBefore ? formatMoney(parseFloat(bet.balanceBefore)) : '-'}
                          </td>
                          <td className="px-2 lg:px-3 py-1.5 text-right whitespace-nowrap text-muted-foreground">
                            {bet.balanceAfter ? formatMoney(parseFloat(bet.balanceAfter)) : '-'}
                          </td>
                          <td className="px-2 lg:px-3 py-1.5 text-center">
                            {isPending ? (
                              <span className="inline-flex items-center px-1.5 py-0.5 rounded text-[10px] font-medium bg-yellow-500/20 text-yellow-500">대기</span>
                            ) : isWin ? (
                              <span className="inline-flex items-center px-1.5 py-0.5 rounded text-[10px] font-bold bg-up text-white">실현</span>
                            ) : (
                              <span className="inline-flex items-center px-1.5 py-0.5 rounded text-[10px] font-bold bg-down text-white">실격</span>
                            )}
                          </td>
                        </tr>
                      );
                    })}
                  </tbody>
                </table>
              </div>
            </div>

            {/* Pagination */}
            {orderHistory && orderHistory.totalPages > 1 && (
              <div className="flex items-center justify-center gap-1 flex-wrap">
                <Button variant="outline" size="sm" className="h-8 w-8 p-0" onClick={() => setOrderPage(1)} disabled={orderPage === 1}>
                  <ChevronLeft className="w-3 h-3" /><ChevronLeft className="w-3 h-3 -ml-2" />
                </Button>
                <Button variant="outline" size="sm" className="h-8 w-8 p-0" onClick={() => setOrderPage(p => Math.max(1, p - 1))} disabled={orderPage === 1}>
                  <ChevronLeft className="w-4 h-4" />
                </Button>
                {Array.from({ length: Math.min(7, orderHistory.totalPages) }, (_, i) => {
                  const half = 3;
                  let start = Math.max(1, orderPage - half);
                  const end = Math.min(orderHistory.totalPages, start + 6);
                  start = Math.max(1, end - 6);
                  return start + i;
                }).filter(p => p <= orderHistory.totalPages).map(p => (
                  <Button key={p} variant={p === orderPage ? 'default' : 'outline'} size="sm" className="h-8 w-8 p-0 text-xs" onClick={() => setOrderPage(p)}>{p}</Button>
                ))}
                <Button variant="outline" size="sm" className="h-8 w-8 p-0" onClick={() => setOrderPage(p => Math.min(orderHistory.totalPages, p + 1))} disabled={orderPage === orderHistory.totalPages}>
                  <ChevronRight className="w-4 h-4" />
                </Button>
                <Button variant="outline" size="sm" className="h-8 w-8 p-0" onClick={() => setOrderPage(orderHistory.totalPages)} disabled={orderPage === orderHistory.totalPages}>
                  <ChevronRight className="w-3 h-3" /><ChevronRight className="w-3 h-3 -ml-2" />
                </Button>
                <span className="text-xs text-muted-foreground ml-2">{orderPage} / {orderHistory.totalPages} 페이지</span>
              </div>
            )}
          </div>
        )}

        {/* ── 회차별 설정 탭 ── */}
        {activeTab === 'round-forced' && (
          <RoundForcedTab apiBase="affiliate" />
        )}

        {/* ── 입금신청 탭 ── */}
        {activeTab === 'deposits' && (
          <div className="space-y-4">
            <div className="flex items-center justify-between">
              <h1 className="text-lg lg:text-2xl font-bold flex items-center gap-2">
                <TrendingUp className="w-5 h-5 text-up" />
                입금신청
              </h1>
              <Button variant="outline" size="sm" onClick={async () => {
                await refetchDeposits();
                toast.success('새로고침 완료');
              }} className="h-8 px-2 lg:px-3">
                <RefreshCw className={cn("w-4 h-4 lg:mr-2", isDepositsFetching && "animate-spin")} />
                <span className="hidden lg:inline">새로고침</span>
              </Button>
            </div>
            <div className="bg-card border border-border rounded-lg overflow-hidden">
              <div className="overflow-x-auto">
                <table className="w-full text-sm">
                  <thead className="bg-muted/40 border-b border-border">
                    <tr>
                      {['신청일시', '아이디', '이름', '금액', '입금자명', '상태', '처리'].map(h => (
                        <th key={h} className="px-3 py-2.5 text-left text-xs font-medium text-muted-foreground whitespace-nowrap">{h}</th>
                      ))}
                    </tr>
                  </thead>
                  <tbody className="divide-y divide-border">
                    {deposits.length === 0 && (
                      <tr><td colSpan={7} className="px-4 py-10 text-center text-muted-foreground">입금신청 내역이 없습니다</td></tr>
                    )}
                    {deposits.map(tx => (
                      <tr key={tx.id} className="hover:bg-muted/20 transition-colors">
                        <td className="px-3 py-2.5 whitespace-nowrap text-xs text-muted-foreground">{formatDate(tx.createdAt)}</td>
                        <td className="px-3 py-2.5 font-medium whitespace-nowrap">{tx.username || '-'}</td>
                        <td className="px-3 py-2.5 whitespace-nowrap">{tx.name || '-'}</td>
                        <td className="px-3 py-2.5 whitespace-nowrap font-mono text-up font-semibold">+{formatMoney(tx.amount)}</td>
                        <td className="px-3 py-2.5 whitespace-nowrap">{tx.senderName || '-'}</td>
                        <td className="px-3 py-2.5 whitespace-nowrap">
                          <span className={cn('text-xs px-2 py-0.5 rounded-full font-medium',
                            tx.status === 'approved' ? 'bg-up/20 text-up' :
                            tx.status === 'rejected' ? 'bg-down/20 text-down' :
                            tx.status === 'hold' ? 'bg-yellow-500/20 text-yellow-500' :
                            'bg-muted text-muted-foreground'
                          )}>
                            {tx.status === 'approved' ? '승인' : tx.status === 'rejected' ? '거절' : tx.status === 'hold' ? '보류' : '대기'}
                          </span>
                        </td>
                        <td className="px-3 py-2.5 whitespace-nowrap">
                          {(tx.status === 'pending' || tx.status === 'hold') ? (
                            <div className="flex gap-1">
                              <Button size="sm" className="h-6 px-2 text-xs bg-up hover:bg-up/90 text-white"
                                onClick={() => handleProcessTransaction(tx.id, 'approved', refetchDeposits)}>승인</Button>
                              <Button size="sm" variant="outline" className="h-6 px-2 text-xs text-down border-down/40 hover:bg-down/10"
                                onClick={() => handleProcessTransaction(tx.id, 'rejected', refetchDeposits)}>거절</Button>
                            </div>
                          ) : (
                            <span className="text-xs text-muted-foreground">{tx.processedAt ? formatDate(tx.processedAt) : '-'}</span>
                          )}
                        </td>
                      </tr>
                    ))}
                  </tbody>
                </table>
              </div>
            </div>
          </div>
        )}

        {/* ── 출금신청 탭 ── */}
        {activeTab === 'withdrawals' && (
          <div className="space-y-4">
            <div className="flex items-center justify-between">
              <h1 className="text-lg lg:text-2xl font-bold flex items-center gap-2">
                <TrendingDown className="w-5 h-5 text-down" />
                출금신청
              </h1>
              <Button variant="outline" size="sm" onClick={async () => {
                await refetchWithdrawals();
                toast.success('새로고침 완료');
              }} className="h-8 px-2 lg:px-3">
                <RefreshCw className={cn("w-4 h-4 lg:mr-2", isWithdrawalsFetching && "animate-spin")} />
                <span className="hidden lg:inline">새로고침</span>
              </Button>
            </div>
            <div className="bg-card border border-border rounded-lg overflow-hidden">
              <div className="overflow-x-auto">
                <table className="w-full text-sm">
                  <thead className="bg-muted/40 border-b border-border">
                    <tr>
                      {['신청일시', '아이디', '이름', '금액', '은행', '계좌번호', '상태', '처리'].map(h => (
                        <th key={h} className="px-3 py-2.5 text-left text-xs font-medium text-muted-foreground whitespace-nowrap">{h}</th>
                      ))}
                    </tr>
                  </thead>
                  <tbody className="divide-y divide-border">
                    {withdrawals.length === 0 && (
                      <tr><td colSpan={8} className="px-4 py-10 text-center text-muted-foreground">출금신청 내역이 없습니다</td></tr>
                    )}
                    {withdrawals.map(tx => (
                      <tr key={tx.id} className="hover:bg-muted/20 transition-colors">
                        <td className="px-3 py-2.5 whitespace-nowrap text-xs text-muted-foreground">{formatDate(tx.createdAt)}</td>
                        <td className="px-3 py-2.5 font-medium whitespace-nowrap">{tx.username || '-'}</td>
                        <td className="px-3 py-2.5 whitespace-nowrap">{tx.name || '-'}</td>
                        <td className="px-3 py-2.5 whitespace-nowrap font-mono text-down font-semibold">-{formatMoney(tx.amount)}</td>
                        <td className="px-3 py-2.5 whitespace-nowrap">{tx.userBankName || tx.bankName || '-'}</td>
                        <td className="px-3 py-2.5 whitespace-nowrap font-mono text-xs">{tx.userAccountNumber || tx.accountNumber || '-'}</td>
                        <td className="px-3 py-2.5 whitespace-nowrap">
                          <span className={cn('text-xs px-2 py-0.5 rounded-full font-medium',
                            tx.status === 'approved' ? 'bg-up/20 text-up' :
                            tx.status === 'rejected' ? 'bg-down/20 text-down' :
                            tx.status === 'hold' ? 'bg-yellow-500/20 text-yellow-500' :
                            'bg-muted text-muted-foreground'
                          )}>
                            {tx.status === 'approved' ? '승인' : tx.status === 'rejected' ? '거절' : tx.status === 'hold' ? '보류' : '대기'}
                          </span>
                        </td>
                        <td className="px-3 py-2.5 whitespace-nowrap">
                          {(tx.status === 'pending' || tx.status === 'hold') ? (
                            <div className="flex gap-1">
                              <Button size="sm" className="h-6 px-2 text-xs bg-up hover:bg-up/90 text-white"
                                onClick={() => handleProcessTransaction(tx.id, 'approved', refetchWithdrawals)}>승인</Button>
                              <Button size="sm" variant="outline" className="h-6 px-2 text-xs text-down border-down/40 hover:bg-down/10"
                                onClick={() => handleProcessTransaction(tx.id, 'rejected', refetchWithdrawals)}>거절</Button>
                            </div>
                          ) : (
                            <span className="text-xs text-muted-foreground">{tx.processedAt ? formatDate(tx.processedAt) : '-'}</span>
                          )}
                        </td>
                      </tr>
                    ))}
                  </tbody>
                </table>
              </div>
            </div>
          </div>
        )}

        {/* ── 1:1 문의 탭 ── */}
        {activeTab === 'inquiries' && (
          <div className="space-y-4">
            <div className="flex items-center justify-between">
              <h1 className="text-lg lg:text-2xl font-bold flex items-center gap-2">
                <MessageSquare className="w-5 h-5 text-primary" />
                1:1 문의
              </h1>
              <Button variant="outline" size="sm" onClick={async () => {
                await refetchInquiries();
                toast.success('새로고침 완료');
              }} className="h-8 px-2 lg:px-3">
                <RefreshCw className={cn("w-4 h-4 lg:mr-2", isInquiriesFetching && "animate-spin")} />
                <span className="hidden lg:inline">새로고침</span>
              </Button>
            </div>
            <div className="space-y-3">
              {inquiries.length === 0 && (
                <div className="text-center py-12 text-muted-foreground">문의가 없습니다</div>
              )}
              {inquiries.map(inquiry => (
                <div key={inquiry.id} className="bg-card border border-border rounded-lg p-4 space-y-3">
                  <div className="flex items-start justify-between gap-2">
                    <div>
                      <div className="flex items-center gap-2 flex-wrap">
                        <span className="font-medium text-sm">{inquiry.username}</span>
                        <span className={cn('text-xs px-2 py-0.5 rounded-full font-medium',
                          inquiry.status === 'answered' ? 'bg-up/20 text-up' : 'bg-yellow-500/20 text-yellow-500'
                        )}>
                          {inquiry.status === 'answered' ? '답변완료' : '대기중'}
                        </span>
                      </div>
                      <p className="text-xs text-muted-foreground mt-0.5">{formatDate(inquiry.createdAt)}</p>
                    </div>
                    {inquiry.status === 'pending' && (
                      <Button size="sm" variant="outline" className="h-7 px-3 text-xs shrink-0" onClick={() => { setReplyingTo(inquiry.id); setReplyText(''); }}>
                        답변하기
                      </Button>
                    )}
                  </div>
                  <div>
                    <p className="text-xs text-muted-foreground font-medium mb-1">제목</p>
                    <p className="text-sm">{inquiry.title}</p>
                  </div>
                  <div>
                    <p className="text-xs text-muted-foreground font-medium mb-1">문의 내용</p>
                    <p className="text-sm whitespace-pre-wrap bg-muted/30 rounded p-2">{inquiry.content}</p>
                  </div>
                  {inquiry.reply && (
                    <div>
                      <p className="text-xs text-muted-foreground font-medium mb-1">답변</p>
                      <p className="text-sm whitespace-pre-wrap bg-primary/10 border border-primary/20 rounded p-2">{inquiry.reply}</p>
                    </div>
                  )}
                  {replyingTo === inquiry.id && (
                    <div className="space-y-2 pt-2 border-t border-border">
                      <Textarea
                        placeholder="답변을 입력하세요..."
                        value={replyText}
                        onChange={e => setReplyText(e.target.value)}
                        rows={3}
                        className="text-sm"
                      />
                      <div className="flex gap-2 justify-end">
                        <Button size="sm" variant="outline" className="h-8" onClick={() => setReplyingTo(null)}>취소</Button>
                        <Button size="sm" className="h-8" onClick={() => handleReply(inquiry.id)}>답변 등록</Button>
                      </div>
                    </div>
                  )}
                </div>
              ))}
            </div>
          </div>
        )}
      </div>

      {/* ── 회원 편집 다이얼로그 ── */}
      {editingUser && (
        <div className="fixed inset-0 bg-black/60 z-50 flex items-center justify-center p-4">
          <div className="bg-card border border-border rounded-xl w-full max-w-md shadow-xl">
            <div className="flex items-center justify-between p-5 border-b border-border">
              <div>
                <h2 className="text-lg font-bold">{editingUser.username}</h2>
                <p className="text-xs text-muted-foreground">{editingUser.name || '-'} / 보유금: {formatMoney(editingUser.balance)}</p>
              </div>
              <button onClick={() => setEditingUser(null)} className="text-muted-foreground hover:text-foreground">
                <X className="w-5 h-5" />
              </button>
            </div>
            <div className="p-5 space-y-5">
              {/* 보유금 조정 */}
              <div className="space-y-2">
                <label className="text-sm font-medium">보유금 조정</label>
                <p className="text-xs text-muted-foreground">현재: {formatMoney(editingUser.balance)} — 양수: 지급, 음수: 차감</p>
                <Input
                  type="number"
                  placeholder="예: 10000 (지급) 또는 -5000 (차감)"
                  value={editBalanceAdjust}
                  onChange={e => setEditBalanceAdjust(e.target.value)}
                  className="font-mono"
                />
                {editBalanceAdjust && !isNaN(parseFloat(editBalanceAdjust)) && (
                  <p className="text-xs text-muted-foreground">
                    조정 후: {formatMoney(Math.max(0, parseFloat(editingUser.balance) + parseFloat(editBalanceAdjust)))}
                  </p>
                )}
              </div>

              {/* 강제방향 */}
              <div className="space-y-2">
                <label className="text-sm font-medium">강제 베팅 방향</label>
                <div className="flex gap-2">
                  {[
                    { val: 'none', label: '해제', cls: '' },
                    { val: 'up', label: '매수 강제', cls: 'border-up/50 text-up' },
                    { val: 'down', label: '매도 강제', cls: 'border-down/50 text-down' },
                  ].map(({ val, label, cls }) => (
                    <button
                      key={val}
                      onClick={() => setEditForcedDir(val as any)}
                      className={cn('flex-1 py-1.5 rounded border text-sm font-medium transition-colors',
                        editForcedDir === val
                          ? val === 'up' ? 'bg-up/20 border-up text-up' : val === 'down' ? 'bg-down/20 border-down text-down' : 'bg-muted border-border'
                          : `border-border hover:bg-muted/50 ${cls}`
                      )}
                    >
                      {label}
                    </button>
                  ))}
                </div>
              </div>

              {/* 토글들 */}
              <div className="space-y-3">
                {[
                  { label: '항상 미실현 (alwaysPending)', state: editAlwaysPending, set: setEditAlwaysPending, desc: '베팅 결과를 항상 미실현으로 처리합니다' },
                  { label: '배팅 차단', state: editBettingBlocked, set: setEditBettingBlocked, desc: '이 회원의 새 베팅을 차단합니다' },
                  { label: '계정 활성화', state: editIsActive, set: setEditIsActive, desc: '비활성화 시 로그인이 차단됩니다' },
                ].map(({ label, state, set, desc }) => (
                  <div key={label} className="flex items-center justify-between gap-4 p-3 rounded-lg bg-muted/30">
                    <div>
                      <p className="text-sm font-medium">{label}</p>
                      <p className="text-xs text-muted-foreground">{desc}</p>
                    </div>
                    <button
                      onClick={() => set(!state)}
                      className={cn('relative w-10 h-5 rounded-full transition-colors shrink-0', state ? 'bg-primary' : 'bg-muted-foreground/30')}
                    >
                      <span className={cn('absolute top-0.5 w-4 h-4 bg-white rounded-full transition-transform shadow', state ? 'translate-x-5' : 'translate-x-0.5')} />
                    </button>
                  </div>
                ))}
              </div>
            </div>
            <div className="flex gap-3 p-5 border-t border-border">
              <Button variant="outline" className="flex-1" onClick={() => setEditingUser(null)}>취소</Button>
              <Button className="flex-1" disabled={isSaving} onClick={handleSaveUser}>
                {isSaving ? '저장 중...' : '저장'}
              </Button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}
