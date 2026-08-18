import { useState, useEffect, useRef } from "react";
import { SymbolIcon } from "@/components/SymbolIcon";
import { Link, useLocation } from "wouter";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Dialog, DialogContent, DialogTitle } from "@/components/ui/dialog";
import {
  AlertDialog,
  AlertDialogAction,
  AlertDialogContent,
  AlertDialogDescription,
  AlertDialogFooter,
  AlertDialogHeader,
  AlertDialogTitle,
} from "@/components/ui/alert-dialog";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuTrigger } from "@/components/ui/dropdown-menu";
import { Popover, PopoverContent, PopoverTrigger } from "@/components/ui/popover";
import { Calendar } from "@/components/ui/calendar";
import { Shield, Zap, Headphones, TrendingUp, Lock, Award, X, ChevronDown, ChevronRight, Phone, Mail, MessageCircle, History, Wallet, Menu, Bell, FileText, Check, Calendar as CalendarIcon, RefreshCw, UserCog, ArrowDownCircle, ArrowUpCircle, Clock, CheckCircle, XCircle } from "lucide-react";
import { Sheet, SheetContent, SheetHeader, SheetTitle, SheetTrigger } from "@/components/ui/sheet";
import { useLogin, useRegister, useAuth, useLogout } from "@/hooks/use-auth";
import { useUserWebSocket } from "@/hooks/use-user-websocket";
import { useQuery, useQueryClient } from "@tanstack/react-query";
import { toast } from "sonner";
import { cn } from "@/lib/utils";
import { format } from "date-fns";
import { LearnInvestLogo } from "@/components/LearnInvestLogo";

const CRYPTO_ASSETS = [
  { symbol: "GOLD", name: "금거래" },
  { symbol: "GBP", name: "파운드" },
  { symbol: "BTC", name: "BTC" },
  { symbol: "SILVER", name: "은거래" },
];

const KOREAN_BANKS = [
  "KB국민은행", "신한은행", "우리은행", "하나은행", "NH농협은행",
  "IBK기업은행", "SC제일은행", "한국씨티은행", "KDB산업은행",
  "카카오뱅크", "케이뱅크", "토스뱅크",
  "수협은행", "새마을금고", "신협", "우체국",
  "IM뱅크 (구 대구은행)", "부산은행", "광주은행", "전북은행", "경남은행", "제주은행",
  "산림조합", "저축은행",
];

const KOREAN_REGIONS = [
  "서울특별시", "부산광역시", "대구광역시", "인천광역시", "광주광역시",
  "대전광역시", "울산광역시", "세종특별자치시", "경기도", "강원도",
  "충청북도", "충청남도", "전라북도", "전라남도", "경상북도", "경상남도", "제주특별자치도",
];

function isWithinOperatingHours(): boolean {
  return true; // 24시간 운영
}

interface LandingMarketData {
  symbol: string;
  name: string;
  price: number;
  changePercent: number;
  priceHistory: number[];
}

function useLandingMarketData() {
  const [markets, setMarkets] = useState<LandingMarketData[]>([
    { symbol: "GOLD", name: "금거래", price: 3300.0, changePercent: 0, priceHistory: [] },
    { symbol: "GBP", name: "파운드", price: 1.2700, changePercent: 0, priceHistory: [] },
    { symbol: "BTC", name: "BTC", price: 97000.0, changePercent: 0, priceHistory: [] },
    { symbol: "SILVER", name: "은거래", price: 33.0, changePercent: 0, priceHistory: [] },
  ]);
  
  const historyRef = useRef<Record<string, number[]>>({
    GOLD: [],
    GBP: [],
    BTC: [],
    SILVER: [],
  });
  
  const lastApiPrices = useRef<Record<string, { price: number; changePercent: number }>>({});

  useEffect(() => {
    // Fetch real prices from API with timeout
    const fetchRealPrices = async () => {
      try {
        const controller = new AbortController();
        const timeoutId = setTimeout(() => controller.abort(), 5000);
        
        const response = await fetch('/api/market/prices', {
          signal: controller.signal,
          cache: 'no-store',
          headers: { 'Cache-Control': 'no-cache', 'Pragma': 'no-cache' }
        });
        clearTimeout(timeoutId);
        
        if (!response.ok) return;
        
        const result = await response.json();
        
        if (result.prices && !result.fallback) {
          setMarkets(prev => prev.map(m => {
            const apiPrice = result.prices.find((p: any) => p.symbol === m.symbol);
            if (apiPrice) {
              lastApiPrices.current[m.symbol] = {
                price: apiPrice.price,
                changePercent: apiPrice.changePercent,
              };
              
              if (historyRef.current[m.symbol].length === 0) {
                const history: number[] = [];
                let price = apiPrice.price * 0.998;
                for (let i = 0; i < 20; i++) {
                  price = price + (Math.random() - 0.45) * price * 0.001;
                  history.push(price);
                }
                historyRef.current[m.symbol] = history;
              }
              
              historyRef.current[m.symbol] = [...historyRef.current[m.symbol].slice(-19), apiPrice.price];
              
              return {
                ...m,
                price: apiPrice.price,
                changePercent: apiPrice.changePercent,
                priceHistory: [...historyRef.current[m.symbol]]
              };
            }
            return m;
          }));
        }
      } catch (error) {
        // Silent fail - keep last known prices
      }
    };

    // Initial fetch with multiple retries
    fetchRealPrices();
    setTimeout(fetchRealPrices, 300);
    setTimeout(fetchRealPrices, 800);

    // Fetch from API every 1 second for real-time updates
    const apiInterval = setInterval(fetchRealPrices, 1000);

    return () => {
      clearInterval(apiInterval);
    };
  }, []);

  return markets;
}

function generateSparklinePath(prices: number[]): string {
  if (prices.length < 2) return "M0,25 L120,25";
  
  const min = Math.min(...prices);
  const max = Math.max(...prices);
  const range = max - min || 1;
  
  const points = prices.map((price, i) => {
    const x = (i / (prices.length - 1)) * 120;
    const y = 45 - ((price - min) / range) * 40;
    return `${x},${y}`;
  });
  
  return `M${points.join(' L')}`;
}

/* ── Gold-signal design system ─────────────────────────────────────────── */
const GS = {
  gold   : "#C4A028",
  goldDk : "#8A6C10",
  goldLt : "#DEB840",
  face   : "#1A1206",
  ink    : "#111111",
  sub    : "#4A3D18",
} as const;

function GsEmblem({ size = 120 }: { size?: number }) {
  const s = size, cx = s/2, cy = s/2;
  const R = s/2 - 2, bR = R - 7, fR = bR - 5;
  const oct = (r: number) =>
    Array.from({length:8},(_,i)=>{
      const a=(i*45-22.5)*Math.PI/180;
      return `${(cx+r*Math.cos(a)).toFixed(2)},${(cy+r*Math.sin(a)).toFixed(2)}`;
    }).join(" ");
  const ticks = Array.from({length:12},(_,i)=>{
    const a=(i*30)*Math.PI/180, major=i%3===0, r1=R-(major?7:4);
    return <line key={i}
      x1={(cx+r1*Math.cos(a)).toFixed(2)} y1={(cy+r1*Math.sin(a)).toFixed(2)}
      x2={(cx+R*Math.cos(a)).toFixed(2)}  y2={(cy+R*Math.sin(a)).toFixed(2)}
      stroke={GS.gold} strokeWidth={major?1.8:0.9}/>;
  });
  const diamonds = [0,90,180,270].map(deg=>{
    const a=deg*Math.PI/180, px=cx+(bR-0.5)*Math.cos(a), py=cy+(bR-0.5)*Math.sin(a), d=size<60?2:3;
    return <polygon key={deg} points={`${px},${py-d} ${px+d},${py} ${px},${py+d} ${px-d},${py}`} fill={GS.goldLt}/>;
  });
  const fs = size < 60 ? size*0.26 : size*0.28;
  return (
    <svg width={s} height={s} viewBox={`0 0 ${s} ${s}`} fill="none">
      <circle cx={cx} cy={cy} r={R} stroke={GS.gold} strokeWidth="0.9"/>
      {ticks}
      <circle cx={cx} cy={cy} r={bR}   stroke={GS.gold}   strokeWidth="1.4"/>
      <circle cx={cx} cy={cy} r={bR-3} stroke={GS.goldDk} strokeWidth="0.6"/>
      <polygon points={oct(fR)} fill={GS.face}/>
      <polygon points={oct(fR)} fill="none" stroke={GS.gold} strokeWidth="0.8"/>
      {diamonds}
      <line x1={cx-fR*0.55} y1={cy-fs*0.3} x2={cx+fR*0.55} y2={cy-fs*0.3} stroke={GS.goldDk} strokeWidth="0.7"/>
      <text x={cx} y={cy+fs*0.55} textAnchor="middle"
        fontFamily="'Playfair Display',Georgia,serif"
        fontSize={fs} fontWeight="900" fill={GS.goldLt} letterSpacing="1.5">GS</text>
      <line x1={cx-fR*0.4} y1={cy+fs*0.78} x2={cx+fR*0.4} y2={cy+fs*0.78} stroke={GS.goldDk} strokeWidth="0.5"/>
    </svg>
  );
}

export default function Landing() {
  const [isIpBlocked, setIsIpBlocked] = useState(false);
  const [showLoginModal, setShowLoginModal] = useState(false);
  const [showRegisterModal, setShowRegisterModal] = useState(false);
  const [showHistoryModal, setShowHistoryModal] = useState(false);
  const [showCustomerServiceModal, setShowCustomerServiceModal] = useState(false);
  const [showAnnouncementsModal, setShowAnnouncementsModal] = useState(false);
  const [mobileMenuOpen, setMobileMenuOpen] = useState(false);
  // 예치 모달
  const [showDepositPageModal, setShowDepositPageModal] = useState(false);
  const [depositAmount, setDepositAmount] = useState('');
  const [depositSenderName, setDepositSenderName] = useState('');
  const [depositSubmitting, setDepositSubmitting] = useState(false);
  // 환급 모달
  const [showWithdrawalPageModal, setShowWithdrawalPageModal] = useState(false);
  const [withdrawalAmount, setWithdrawalAmount] = useState('');
  const [withdrawalSubmitting, setWithdrawalSubmitting] = useState(false);
  const [username, setUsername] = useState("");
  const [password, setPassword] = useState("");
  const [loginErrorMessage, setLoginErrorMessage] = useState("");
  
  // Register form state
  const [regUsername, setRegUsername] = useState("");
  const [regPassword, setRegPassword] = useState("");
  const [confirmPassword, setConfirmPassword] = useState("");
  const [name, setName] = useState("");
  const [phone, setPhone] = useState("");
  const [birthDate, setBirthDate] = useState<Date | undefined>(undefined);
  const [regBirthDate, setRegBirthDate] = useState("");
  const [bankName, setBankName] = useState("");
  const [accountHolder, setAccountHolder] = useState("");
  const [accountNumber, setAccountNumber] = useState("");
  const [region, setRegion] = useState("");
  const [branchCode, setBranchCode] = useState("");
  const [registerErrorMessage, setRegisterErrorMessage] = useState("");
  const [usernameChecked, setUsernameChecked] = useState(false);
  const [usernameCheckMessage, setUsernameCheckMessage] = useState("");
  const [usernameAvailable, setUsernameAvailable] = useState(false);
  const [checkingUsername, setCheckingUsername] = useState(false);
  
  // My Page state
  const [showMyPageModal, setShowMyPageModal] = useState(false);
  const [myPageNewPassword, setMyPageNewPassword] = useState("");
  const [myPageConfirmPassword, setMyPageConfirmPassword] = useState("");
  const [myPageBankName, setMyPageBankName] = useState("");
  const [myPageAccountNumber, setMyPageAccountNumber] = useState("");
  const [myPageAccountHolder, setMyPageAccountHolder] = useState("");
  const [myPageSaving, setMyPageSaving] = useState(false);

  const [showInquiryFormModal, setShowInquiryFormModal] = useState(false);
  const [showMyInquiriesModal, setShowMyInquiriesModal] = useState(false);
  const [showTransactionsModal, setShowTransactionsModal] = useState(false);
  const [transactionFilter, setTransactionFilter] = useState<'all' | 'deposit' | 'withdrawal'>('all');
  const [showWithdrawalSuccessModal, setShowWithdrawalSuccessModal] = useState(false);
  const [withdrawalSuccessAmount, setWithdrawalSuccessAmount] = useState('');
  const [showMessagesModal, setShowMessagesModal] = useState(false);
  const [selectedMessage, setSelectedMessage] = useState<{id: number; title: string; content: string; isRead: boolean; createdAt: string} | null>(null);
  const [selectedAnnouncement, setSelectedAnnouncement] = useState<{id: number; title: string; content: string; isPinned: boolean; displayDate: string; createdAt: string} | null>(null);
  const [inquiryTitle, setInquiryTitle] = useState("");
  const [inquiryContent, setInquiryContent] = useState("");
  const [inquirySubmitting, setInquirySubmitting] = useState(false);
  
  const login = useLogin();
  const register = useRegister();
  const logout = useLogout();
  const queryClient = useQueryClient();
  const { data: user } = useAuth();
  const [, setLocation] = useLocation();
  const marketData = useLandingMarketData();

  // 예치신청 "보내시는 분" 자동 세팅
  // IP 차단 여부 확인 (페이지 최초 로드 시)
  useEffect(() => {
    fetch('/api/blocked-ip-check')
      .then(res => res.json())
      .then(data => { if (data.blocked) setIsIpBlocked(true); })
      .catch(() => {});
  }, []);

  useEffect(() => {
    const autoName = user?.name || user?.accountHolder || '';
    if (autoName) {
      setDepositSenderName(autoName);
    }
  }, [user?.name, user?.accountHolder]);

  // URL ?tab= 파라미터로 모달 자동 오픈 (트레이딩 페이지에서 넘어올 때)
  useEffect(() => {
    const params = new URLSearchParams(window.location.search);
    const tab = params.get('tab');
    if (!tab) return;
    // 파라미터 제거
    const url = new URL(window.location.href);
    url.searchParams.delete('tab');
    window.history.replaceState({}, '', url.toString());
    const open = () => {
      if (tab === 'history') setShowHistoryModal(true);
      else if (tab === 'deposit') { setDepositAmount(''); setShowDepositPageModal(true); }
      else if (tab === 'withdraw') { if ((user as any)?.isBettingBlocked) { toast.error("거래정지 해제 이후 다시 시도해 주세요."); return; } setWithdrawalAmount(''); setShowWithdrawalPageModal(true); }
      else if (tab === 'notice') setShowAnnouncementsModal(true);
      else if (tab === 'cs') setShowCustomerServiceModal(true);
      else if (tab === 'messages') setShowMessagesModal(true);
    };
    // user 로드 후 열기
    if (user !== undefined) open();
  }, [user]);

  // Fetch user balance and bet history if logged in
  const { data: balanceData, refetch: refetchBalance } = useQuery({
    queryKey: ["/api/user/balance"],
    queryFn: async () => {
      const res = await fetch("/api/user/balance");
      if (!res.ok) return null;
      return res.json();
    },
    enabled: !!user,
    refetchInterval: 3000,
  });

  const { data: betHistory } = useQuery({
    queryKey: ["/api/bets/history"],
    queryFn: async () => {
      const res = await fetch("/api/bets/history");
      if (!res.ok) return [];
      return res.json();
    },
    enabled: !!user,
    refetchInterval: 3000,
  });

  // Fetch telegram link
  const { data: telegramData } = useQuery({
    queryKey: ["/api/settings/telegram"],
    queryFn: async () => {
      const res = await fetch("/api/settings/telegram");
      if (!res.ok) return { telegramLink: "" };
      return res.json();
    },
  });

  // Fetch kakao link
  const { data: kakaoData } = useQuery({
    queryKey: ["/api/settings/kakao"],
    queryFn: async () => {
      const res = await fetch("/api/settings/kakao");
      if (!res.ok) return { kakaoLink: "" };
      return res.json();
    },
  });

  // Fetch deposit notice
  const { data: depositNoticeData } = useQuery({
    queryKey: ["/api/settings/deposit-notice"],
    queryFn: async () => {
      const res = await fetch("/api/settings/deposit-notice");
      if (!res.ok) return { depositNotice: "" };
      return res.json();
    },
  });

  // Fetch public announcements
  const { data: announcements = [] } = useQuery<{id: number; title: string; content: string; isPinned: boolean; displayDate: string; createdAt: string}[]>({
    queryKey: ["/api/announcements"],
    queryFn: async () => {
      const res = await fetch("/api/announcements");
      if (!res.ok) return [];
      return res.json();
    },
  });

  // Fetch user messages
  const { data: messages = [], refetch: refetchMessages } = useQuery<{id: number; title: string; content: string; isRead: boolean; createdAt: string}[]>({
    queryKey: ["/api/messages"],
    queryFn: async () => {
      const res = await fetch("/api/messages");
      if (!res.ok) return [];
      return res.json();
    },
    enabled: !!user,
  });

  const handleOpenMessage = async (msg: {id: number; title: string; content: string; isRead: boolean; createdAt: string}) => {
    setSelectedMessage(msg);
    setShowMessagesModal(true);
    if (!msg.isRead) {
      await fetch(`/api/messages/${msg.id}/read`, { method: 'POST' });
      refetchMessages();
    }
  };

  // Fetch user inquiries
  const { data: myInquiries = [], refetch: refetchInquiries } = useQuery<{id: number; title: string; content: string; reply: string | null; status: string; createdAt: string; repliedAt: string | null}[]>({
    queryKey: ["/api/inquiries"],
    queryFn: async () => {
      const res = await fetch("/api/inquiries");
      if (!res.ok) return [];
      return res.json();
    },
    enabled: !!user,
  });

  // Fetch user transactions (입환급 내역)
  const { data: myTransactions = [], refetch: refetchTransactions } = useQuery<any[]>({
    queryKey: ["/api/transactions"],
    queryFn: async () => {
      const res = await fetch("/api/transactions");
      if (!res.ok) return [];
      return res.json();
    },
    enabled: !!user,
    staleTime: 0,
  });

  // 실시간 웹소켓: 고객센터 답변 알림 소리 + 쪽지/입환급 처리 알림
  useUserWebSocket(!!user, {
    onNewMessage: () => setShowMessagesModal(true),
    onInquiryReplied: () => setShowMyInquiriesModal(true),
    onTransactionProcessed: () => { refetchBalance(); refetchTransactions(); },
  });

  const handleTradeClick = () => {
    if (user) {
      // Redirect based on role
      if (user.role === 'admin') {
        setLocation("/admin");
      } else {
        setLocation("/trade");
      }
    } else {
      setShowLoginModal(true);
    }
  };

  const openMyPage = () => {
    if (!user) { setShowLoginModal(true); return; }
    setMyPageNewPassword("");
    setMyPageConfirmPassword("");
    setMyPageBankName((user as any).bankName || "");
    setMyPageAccountNumber((user as any).accountNumber || "");
    setMyPageAccountHolder((user as any).accountHolder || "");
    setShowMyPageModal(true);
  };

  const handleMyPageSave = async () => {
    if (myPageNewPassword || myPageConfirmPassword) {
      if (myPageNewPassword.length < 4) {
        toast.error("비밀번호는 4자 이상이어야 합니다");
        return;
      }
      if (myPageNewPassword !== myPageConfirmPassword) {
        toast.error("비밀번호가 일치하지 않습니다");
        return;
      }
    }
    if (!myPageBankName || !myPageAccountNumber || !myPageAccountHolder) {
      toast.error("환급 계좌 정보를 모두 입력해주세요");
      return;
    }
    setMyPageSaving(true);
    try {
      if (myPageNewPassword) {
        const pwRes = await fetch("/api/user/profile", {
          method: "PATCH",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify({ newPassword: myPageNewPassword, confirmPassword: myPageConfirmPassword }),
        });
        if (!pwRes.ok) {
          const err = await pwRes.json();
          toast.error(err.error || "비밀번호 변경 실패");
          setMyPageSaving(false);
          return;
        }
      }
      const bankRes = await fetch("/api/user/bank", {
        method: "PATCH",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ bankName: myPageBankName, accountNumber: myPageAccountNumber, accountHolder: myPageAccountHolder }),
      });
      if (!bankRes.ok) {
        const err = await bankRes.json();
        toast.error(err.error || "계좌 정보 변경 실패");
        setMyPageSaving(false);
        return;
      }
      toast.success("저장되었습니다");
      queryClient.invalidateQueries({ queryKey: ["/api/auth/me"] });
      setShowMyPageModal(false);
    } catch {
      toast.error("저장 중 오류가 발생했습니다");
    } finally {
      setMyPageSaving(false);
    }
  };

  const handleLoginSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    login.mutate({ username, password }, {
      onSuccess: () => {
        setShowLoginModal(false);
        setUsername("");
        setPassword("");
      },
      onError: (error: Error) => {
        setLoginErrorMessage(error.message || "아이디 또는 비밀번호가 일치하지 않습니다");
      }
    });
  };

  const handleCheckUsername = async () => {
    if (regUsername.length < 3) {
      setUsernameCheckMessage("아이디는 3자 이상이어야 합니다");
      setUsernameAvailable(false);
      setUsernameChecked(true);
      return;
    }
    setCheckingUsername(true);
    try {
      const res = await fetch("/api/auth/check-username", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ username: regUsername }),
      });
      const data = await res.json();
      setUsernameAvailable(data.available);
      setUsernameCheckMessage(data.available ? data.message : data.error);
      setUsernameChecked(true);
    } catch {
      setUsernameCheckMessage("중복확인에 실패했습니다");
      setUsernameAvailable(false);
      setUsernameChecked(true);
    } finally {
      setCheckingUsername(false);
    }
  };

  const handleRegisterSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    setRegisterErrorMessage("");
    
    if (regUsername.length < 3) {
      setRegisterErrorMessage("아이디는 3자 이상이어야 합니다");
      return;
    }
    if (!usernameChecked || !usernameAvailable) {
      setRegisterErrorMessage("아이디 중복확인을 해주세요");
      return;
    }
    if (regPassword.length < 4) {
      setRegisterErrorMessage("비밀번호는 4자 이상이어야 합니다");
      return;
    }
    if (regPassword !== confirmPassword) {
      setRegisterErrorMessage("비밀번호가 일치하지 않습니다");
      return;
    }
    if (!name) {
      setRegisterErrorMessage("이름을 입력해주세요");
      return;
    }
    if (!phone || phone.length < 10) {
      setRegisterErrorMessage("올바른 휴대폰 번호를 입력해주세요");
      return;
    }
    if (!regBirthDate || regBirthDate.replace(/\D/g, '').length !== 6) {
      setRegisterErrorMessage("생년월일을 6자리로 입력해주세요 (예: 901231)");
      return;
    }
    if (!bankName) {
      setRegisterErrorMessage("은행을 선택해주세요");
      return;
    }
    if (!accountHolder) {
      setRegisterErrorMessage("예금주를 입력해주세요");
      return;
    }
    if (!accountNumber) {
      setRegisterErrorMessage("계좌번호를 입력해주세요");
      return;
    }
    
    register.mutate({ 
      username: regUsername, 
      password: regPassword, 
      name, 
      phone,
      birthDate: regBirthDate,
      bankName, 
      accountHolder, 
      accountNumber,
      branchCode: branchCode || undefined,
    }, {
      onSuccess: () => {
        setRegisterErrorMessage("");
        setShowRegisterModal(false);
        setRegUsername("");
        setRegPassword("");
        setConfirmPassword("");
        setName("");
        setPhone("");
        setRegBirthDate("");
        setBirthDate(undefined);
        setRegion("");
        setBranchCode("");
        setBankName("");
        setAccountHolder("");
        setAccountNumber("");
        setUsernameChecked(false);
        setUsernameCheckMessage("");
        setUsernameAvailable(false);
      },
      onError: (error: Error) => {
        setRegisterErrorMessage(error.message);
      }
    });
  };

  if (isIpBlocked) {
    return (
      <div className="min-h-screen bg-[#FAF9F6] flex flex-col items-center justify-center px-4">
        <div className="text-center space-y-6 max-w-md">
          <div className="w-20 h-20 mx-auto rounded-full bg-red-50 border border-red-200 flex items-center justify-center">
            <svg className="w-10 h-10 text-red-500" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M18.364 18.364A9 9 0 005.636 5.636m12.728 12.728A9 9 0 015.636 5.636m12.728 12.728L5.636 5.636" />
            </svg>
          </div>
          <h1 className="text-2xl font-bold" style={{color:"#111111"}}>접근이 차단되었습니다</h1>
          <p className="text-gray-500 text-sm leading-relaxed">
            해당 IP 주소는 관리자에 의해 차단되었습니다.<br />
            문의사항이 있으시면 고객센터로 연락해 주세요.
          </p>
        </div>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-[#FAF9F6] text-[#181A2A] overflow-x-hidden">
      {/* Header */}
      <header className="fixed top-0 left-0 right-0 z-50 bg-[#FAF9F6] border-b" style={{borderColor:"rgba(196,160,40,0.22)",boxShadow:"none"}}>
        <div className="max-w-7xl mx-auto px-3 md:px-4 h-14 md:h-16 flex items-center justify-between">
          {/* Logo */}
          <div className="flex items-center gap-3 md:gap-5 min-w-0">
            <Link href="/" data-testid="link-logo" style={{display:"flex",alignItems:"center",textDecoration:"none"}}>
              <img src="/icons/gs-logo.png" alt="GOLD-SIGNAL" style={{height:44,width:"auto",objectFit:"contain"}} />
            </Link>
            
            {/* Desktop Navigation */}
            <nav className="hidden md:flex items-center gap-3">
              <DropdownMenu>
                <DropdownMenuTrigger className="text-gray-600 hover:text-[#C4A028] transition-colors text-xs font-medium flex items-center gap-1 whitespace-nowrap" data-testid="nav-options-trading">
                  옵션거래 <ChevronDown className="w-3 h-3" />
                </DropdownMenuTrigger>
                <DropdownMenuContent className="bg-[#FAF9F6] border-black/10 min-w-[180px]">
                  {[
                    { id: 'GOLD-180', symbol: 'GOLD', label: 'GOLD 3분거래' },
                    { id: 'GOLD-300', symbol: 'GOLD', label: 'GOLD 5분거래' },
                    { id: 'GBP-180',  symbol: 'GBP',  label: 'GBP 3분거래'  },
                    { id: 'GBP-300',  symbol: 'GBP',  label: 'GBP 5분거래'  },
                    { id: 'BTC-180',  symbol: 'BTC',  label: 'BTC 3분거래'  },
                    { id: 'BTC-300',  symbol: 'BTC',  label: 'BTC 5분거래'  },
                    { id: 'SILVER-180', symbol: 'SILVER', label: 'SILVER 3분거래' },
                    { id: 'SILVER-300', symbol: 'SILVER', label: 'SILVER 5분거래' },
                  ].map((item) => (
                    <DropdownMenuItem
                      key={item.id}
                      className="text-gray-700 hover:text-[#C4A028] hover:bg-amber-50 cursor-pointer"
                      onClick={() => {
                        if (user) {
                          setLocation(`/trade?game=${item.id}`);
                        } else {
                          setShowLoginModal(true);
                        }
                      }}
                    >
                      <span className="font-semibold text-[#C4A028] mr-2 text-xs">{item.symbol}</span>
                      <span className="text-xs">{item.label.replace(item.symbol + ' ', '')}</span>
                    </DropdownMenuItem>
                  ))}
                </DropdownMenuContent>
              </DropdownMenu>
              <button 
                onClick={() => {
                  if (user) {
                    setShowHistoryModal(true);
                  } else {
                    setShowLoginModal(true);
                  }
                }}
                className="text-gray-600 hover:text-[#C4A028] transition-colors text-xs font-medium whitespace-nowrap" 
                data-testid="nav-trade-history"
              >
                거래내역
              </button>
              <button 
                onClick={() => {
                  if (!user) { setShowLoginModal(true); return; }
                  if (!isWithinOperatingHours()) { toast.error("입환급 신청은 오전 09:00 ~ 18:00 사이에만 가능합니다"); return; }
                  setDepositAmount(''); setDepositSenderName(user?.name || user?.accountHolder || ''); setShowDepositPageModal(true);
                }}
                className="text-gray-600 hover:text-[#C4A028] transition-colors text-xs font-medium whitespace-nowrap" 
                data-testid="nav-deposit"
              >
                예치신청
              </button>
              <button 
                onClick={() => {
                  if (!user) { setShowLoginModal(true); return; }
                  if ((user as any)?.isBettingBlocked) { toast.error("거래정지 해제 이후 다시 시도해 주세요."); return; }
                  if (!isWithinOperatingHours()) { toast.error("입환급 신청은 오전 09:00 ~ 18:00 사이에만 가능합니다"); return; }
                  setWithdrawalAmount(''); setShowWithdrawalPageModal(true);
                }}
                className="text-gray-600 hover:text-[#C4A028] transition-colors text-xs font-medium whitespace-nowrap" 
                data-testid="nav-withdrawal"
              >
                환급신청
              </button>
              <button 
                onClick={() => setShowAnnouncementsModal(true)}
                className="text-gray-600 hover:text-[#C4A028] transition-colors text-xs font-medium whitespace-nowrap" 
                data-testid="nav-announcements"
              >
                공지사항
              </button>
              {user && (
                <button 
                  onClick={openMyPage}
                  className="text-gray-600 hover:text-[#C4A028] transition-colors text-xs font-medium whitespace-nowrap" 
                  data-testid="nav-mypage"
                >
                  마이페이지
                </button>
              )}
              <button 
                onClick={() => setShowCustomerServiceModal(true)}
                className="text-gray-600 hover:text-[#C4A028] transition-colors text-xs font-medium whitespace-nowrap" 
                data-testid="nav-customer-service"
              >
                고객센터
              </button>
              <button 
                onClick={() => {
                  if (user) {
                    setShowMessagesModal(true);
                  } else {
                    setShowLoginModal(true);
                  }
                }}
                className="text-gray-600 hover:text-[#C4A028] transition-colors text-xs font-medium whitespace-nowrap relative" 
                data-testid="nav-messages"
              >
                쪽지함
                {user && messages.filter(m => !m.isRead).length > 0 && (
                  <span className="absolute -top-1 -right-3 bg-red-500 text-white text-[10px] w-4 h-4 rounded-full flex items-center justify-center">
                    {messages.filter(m => !m.isRead).length}
                  </span>
                )}
              </button>
            </nav>
          </div>
          
          {/* Auth Buttons - Desktop */}
          <div className="hidden md:flex items-center gap-3">
            {user ? (
              <>
                {/* Balance Display */}
                <div className="flex items-center gap-2 bg-[#FAF9F6] border border-[#C4A028]/15 rounded-lg px-3 py-1.5">
                  <Wallet className="w-4 h-4 text-[#C4A028]" />
                  <span className="text-xs" style={{color:"#aaa"}}>보유금액</span>
                  <span className="text-[#181A2A] font-bold text-sm" data-testid="text-header-balance">
                    {balanceData?.balance ? Math.floor(parseFloat(balanceData.balance)).toLocaleString() : '0'}원
                  </span>
                </div>
                
                {/* Deposit/Withdraw Buttons */}
                <div className="flex items-center gap-1">
                  <Button 
                    variant="ghost"
                    size="sm"
                    className="text-gray-900 hover:text-gray-700 hover:bg-gray-100 text-xs px-2"
                    data-testid="button-header-deposit"
                    onClick={() => { 
                      if (!isWithinOperatingHours()) { toast.error("입환급 신청은 오전 09:00 ~ 18:00 사이에만 가능합니다"); return; }
                      setDepositAmount(''); setDepositSenderName(user?.name || user?.accountHolder || ''); setShowDepositPageModal(true);
                    }}
                  >
                    예치
                  </Button>
                  <Button 
                    variant="ghost"
                    size="sm"
                    className="text-gray-900 hover:text-gray-700 hover:bg-gray-100 text-xs px-2"
                    data-testid="button-header-withdraw"
                    onClick={() => { 
                      if ((user as any)?.isBettingBlocked) { toast.error("거래정지 해제 이후 다시 시도해 주세요."); return; }
                      if (!isWithinOperatingHours()) { toast.error("입환급 신청은 오전 09:00 ~ 18:00 사이에만 가능합니다"); return; }
                      setWithdrawalAmount(''); setShowWithdrawalPageModal(true);
                    }}
                  >
                    환급
                  </Button>
                </div>

                <span className="text-gray-500 text-sm hidden lg:block">
                  {user.username}님
                </span>
                {user.role === 'admin' ? (
                  <Button 
                    className="bg-[#C4A028] hover:opacity-90 text-white font-semibold" 
                    data-testid="button-header-admin"
                    onClick={() => setLocation("/admin")}
                  >
                    관리자
                  </Button>
                ) : (
                  <Button 
                    className="bg-[#C4A028] hover:opacity-90 text-white font-semibold" 
                    data-testid="button-header-trade"
                    onClick={() => setLocation("/trade")}
                  >
                    거래하기
                  </Button>
                )}
                <Button 
                  variant="ghost" 
                  className="text-gray-500 hover:text-[#181A2A] hover:bg-black/5" 
                  data-testid="button-header-logout"
                  onClick={() => logout.mutate()}
                >
                  로그아웃
                </Button>
              </>
            ) : (
              <>
                <Button 
                  variant="ghost" 
                  className="text-gray-500 hover:text-[#181A2A] hover:bg-black/5" 
                  data-testid="button-header-login"
                  onClick={() => setShowLoginModal(true)}
                >
                  로그인
                </Button>
                <Button 
                  className="bg-[#C4A028] hover:opacity-90 text-white font-semibold" 
                  data-testid="button-header-register"
                  onClick={() => setShowRegisterModal(true)}
                >
                  회원가입
                </Button>
              </>
            )}
          </div>
          
          {/* Mobile Menu Button */}
          <Sheet open={mobileMenuOpen} onOpenChange={setMobileMenuOpen}>
            <SheetTrigger asChild>
              <button className="md:hidden p-2 text-gray-500 hover:text-[#181A2A]">
                <Menu className="w-6 h-6" />
              </button>
            </SheetTrigger>
            <SheetContent side="right" className="bg-[#FAF9F6] border-black/10 w-[280px]">
              <SheetHeader>
                <SheetTitle className="text-[#181A2A] text-left">메뉴</SheetTitle>
              </SheetHeader>
              <nav className="flex flex-col gap-2 mt-6">
                {user && (
                  <div className="flex items-center gap-2 bg-[#FAF9F6] border border-[#C4A028]/15 rounded-lg px-3 py-2 mb-4">
                    <Wallet className="w-4 h-4 text-[#C4A028]" />
                    <span className="text-xs" style={{color:"#aaa"}}>보유금액</span>
                    <span className="text-[#181A2A] font-bold text-sm">
                      {balanceData?.balance ? Math.floor(parseFloat(balanceData.balance)).toLocaleString() : '0'}원
                    </span>
                  </div>
                )}
                
                <button 
                  onClick={() => {
                    if (user) {
                      setLocation("/trade");
                    } else {
                      setShowLoginModal(true);
                    }
                    setMobileMenuOpen(false);
                  }}
                  className="text-left text-gray-600 hover:text-[#C4A028] py-3 border-b border-black/5 w-full touch-manipulation"
                  style={{ WebkitTapHighlightColor: 'transparent' }}
                >
                  옵션거래
                </button>
                <button 
                  onClick={() => {
                    if (user) {
                      setShowHistoryModal(true);
                    } else {
                      setShowLoginModal(true);
                    }
                    setMobileMenuOpen(false);
                  }}
                  className="text-left text-gray-600 hover:text-[#C4A028] py-3 border-b border-black/5 w-full touch-manipulation"
                  style={{ WebkitTapHighlightColor: 'transparent' }}
                >
                  거래내역
                </button>
                <button 
                  onClick={() => {
                    if (!user) { setShowLoginModal(true); setMobileMenuOpen(false); return; }
                    if (!isWithinOperatingHours()) { toast.error("입환급 신청은 오전 09:00 ~ 18:00 사이에만 가능합니다"); setMobileMenuOpen(false); return; }
                    setDepositAmount(''); setDepositSenderName(user?.name || user?.accountHolder || ''); setShowDepositPageModal(true);
                    setMobileMenuOpen(false);
                  }}
                  className="text-left text-gray-600 hover:text-[#C4A028] py-3 border-b border-black/5 w-full touch-manipulation"
                  style={{ WebkitTapHighlightColor: 'transparent' }}
                >
                  예치신청
                </button>
                <button 
                  onClick={() => {
                    if (!user) { setShowLoginModal(true); setMobileMenuOpen(false); return; }
                    if ((user as any)?.isBettingBlocked) { toast.error("거래정지 해제 이후 다시 시도해 주세요."); setMobileMenuOpen(false); return; }
                    if (!isWithinOperatingHours()) { toast.error("입환급 신청은 오전 09:00 ~ 18:00 사이에만 가능합니다"); setMobileMenuOpen(false); return; }
                    setWithdrawalAmount(''); setShowWithdrawalPageModal(true);
                    setMobileMenuOpen(false);
                  }}
                  className="text-left text-gray-600 hover:text-[#C4A028] py-3 border-b border-black/5 w-full touch-manipulation"
                  style={{ WebkitTapHighlightColor: 'transparent' }}
                >
                  환급신청
                </button>
                <button 
                  onClick={() => {
                    setShowAnnouncementsModal(true);
                    setMobileMenuOpen(false);
                  }}
                  className="text-left text-gray-600 hover:text-[#C4A028] py-3 border-b border-black/5 w-full touch-manipulation"
                  style={{ WebkitTapHighlightColor: 'transparent' }}
                >
                  공지사항
                </button>
                {user && (
                  <button 
                    onClick={() => {
                      openMyPage();
                      setMobileMenuOpen(false);
                    }}
                    className="text-left text-gray-600 hover:text-[#C4A028] py-3 border-b border-black/5 w-full touch-manipulation"
                    style={{ WebkitTapHighlightColor: 'transparent' }}
                    data-testid="mobile-nav-mypage"
                  >
                    마이페이지
                  </button>
                )}
                <button 
                  onClick={() => {
                    setShowCustomerServiceModal(true);
                    setMobileMenuOpen(false);
                  }}
                  className="text-left text-gray-600 hover:text-[#C4A028] py-3 border-b border-black/5 w-full touch-manipulation"
                  style={{ WebkitTapHighlightColor: 'transparent' }}
                >
                  고객센터
                </button>
                <button 
                  onClick={() => {
                    if (user) {
                      setShowMessagesModal(true);
                    } else {
                      setShowLoginModal(true);
                    }
                    setMobileMenuOpen(false);
                  }}
                  className="text-left text-gray-600 hover:text-[#C4A028] py-3 border-b border-black/5 w-full touch-manipulation"
                  style={{ WebkitTapHighlightColor: 'transparent' }}
                >
                  쪽지함
                </button>
                
                <div className="mt-4 flex flex-col gap-2">
                  {user ? (
                    <>
                      <p className="text-gray-500 text-sm mb-2">{user.username}님</p>
                      {user.role === 'admin' && (
                        <Button 
                          className="w-full bg-[#C4A028] hover:opacity-90 text-white font-semibold" 
                          onClick={() => { setLocation("/admin"); setMobileMenuOpen(false); }}
                        >
                          관리자
                        </Button>
                      )}
                      <Button 
                        className="w-full bg-[#C4A028] hover:opacity-90 text-white font-semibold" 
                        onClick={() => { setLocation("/trade"); setMobileMenuOpen(false); }}
                      >
                        거래하기
                      </Button>
                      <Button 
                        variant="outline" 
                        className="w-full border-black/10 text-gray-600 hover:text-[#181A2A]" 
                        onClick={() => { logout.mutate(); setMobileMenuOpen(false); }}
                      >
                        로그아웃
                      </Button>
                    </>
                  ) : (
                    <>
                      <Button 
                        variant="outline" 
                        className="w-full border-black/10 text-gray-600 hover:text-[#181A2A]" 
                        onClick={() => { setShowLoginModal(true); setMobileMenuOpen(false); }}
                      >
                        로그인
                      </Button>
                      <Button 
                        className="w-full bg-[#C4A028] hover:opacity-90 text-white font-semibold" 
                        onClick={() => { setShowRegisterModal(true); setMobileMenuOpen(false); }}
                      >
                        회원가입
                      </Button>
                    </>
                  )}
                </div>
              </nav>
            </SheetContent>
          </Sheet>
        </div>
      </header>

      {/* Hero Section */}
      {/* ── PRESTIGE HERO ── */}
      <section className="pt-20 pb-0 bg-[#FAF9F6]">
        {/* Centered hero */}
        <div className="flex flex-col items-center text-center px-4 py-8">
          {/* Eyebrow */}
          <div className="flex items-center gap-4 mb-8">
            <div style={{width:36,height:1,background:GS.gold}} />
            <span style={{fontSize:9,letterSpacing:"5.5px",color:GS.goldDk,fontFamily:"sans-serif",fontWeight:700}}>
              GLOBAL FOREX TRADING
            </span>
            <div style={{width:36,height:1,background:GS.gold}} />
          </div>

          {/* Hero logo — large */}
          <div className="mb-6">
            <img
              src="/icons/gs-logo.png"
              alt="GOLD-SIGNAL"
              data-testid="text-hero-title"
              style={{width:"clamp(260px,38vw,480px)",height:"auto",objectFit:"contain"}}
            />
          </div>

          {/* Tagline */}
          <p style={{fontSize:19,fontWeight:400,letterSpacing:"0.06em",marginBottom:12,color:GS.ink,fontFamily:"'Playfair Display',serif"}}>
            가장 신뢰받는 글로벌 선도거래
          </p>

          {/* Body */}
          <p data-testid="text-hero-description" style={{fontSize:13.5,color:GS.sub,lineHeight:1.9,marginBottom:44,fontFamily:"sans-serif"}}>
            안전하고 투명한 시스템으로<br/>빠르고 편리한 외환 옵션 거래를 제공합니다.
          </p>

          {/* CTA buttons */}
          <div className="flex flex-col sm:flex-row items-center gap-4 mb-16">
            <button
              data-testid="button-trade"
              onClick={handleTradeClick}
              style={{
                background:GS.gold, border:"none", borderRadius:4,
                padding:"15px 64px", fontSize:13.5, fontWeight:700,
                color:"#fff", fontFamily:"sans-serif", letterSpacing:"0.22em",
                cursor:"pointer", boxShadow:"0 4px 18px rgba(61,40,0,0.22)",
              }}
            >
              거래 시작하기
            </button>
            <button
              data-testid="button-hero-more"
              onClick={() => setShowCustomerServiceModal(true)}
              style={{
                background:"transparent",
                border:`1.5px solid ${GS.gold}`,
                borderRadius:4, padding:"14px 40px",
                fontSize:13.5, fontWeight:600,
                color:GS.goldDk, fontFamily:"sans-serif",
                letterSpacing:"0.1em", cursor:"pointer",
              }}
            >
              자세히 보기
            </button>
          </div>

        </div>

        {/* Market data row */}
        <div style={{borderTop:`1px solid rgba(196,160,40,0.18)`,background:"#FAF9F6"}}>
          <div className="max-w-5xl mx-auto px-4 py-6">
            <div className="grid grid-cols-2 md:grid-cols-4 gap-4">
              {marketData.map((item, index) => {
                const isPositive = item.changePercent >= 0;
                const priceDecimals = item.symbol === 'GBP' ? 4 : item.symbol === 'SILVER' ? 3 : 2;
                const nameMap: Record<string, string> = { GOLD: '금거래', GBP: '파운드', BTC: 'BTC', SILVER: '은거래' };
                return (
                  <div
                    key={item.symbol}
                    className="flex items-center justify-between bg-[#FAF9F6] border rounded-xl px-4 py-3 hover:shadow-sm transition-shadow cursor-pointer"
                    style={{borderColor:"rgba(196,160,40,0.20)"}}
                    data-testid={`card-market-${index}`}
                    onClick={handleTradeClick}
                  >
                    <div>
                      <p style={{fontSize:10,color:GS.gold,fontWeight:700,marginBottom:3,fontFamily:"sans-serif",letterSpacing:"0.08em"}}>{item.symbol}</p>
                      <p style={{fontSize:15,fontWeight:700,color:GS.ink,fontFamily:"sans-serif"}}>
                        {item.price.toLocaleString('ko-KR', { minimumFractionDigits: priceDecimals, maximumFractionDigits: priceDecimals })}
                      </p>
                      <p style={{fontSize:10.5,color:"#888",marginTop:1,fontFamily:"sans-serif"}}>{nameMap[item.symbol]}</p>
                    </div>
                    <span style={{
                      fontSize:11, fontWeight:600, padding:"2px 8px", borderRadius:4,
                      background: isPositive ? "#f0fdf4" : "#fef2f2",
                      color: isPositive ? "#16a34a" : "#dc2626",
                    }}>
                      {isPositive ? '+' : ''}{item.changePercent.toFixed(2)}%
                    </span>
                  </div>
                );
              })}
            </div>
          </div>
        </div>
      </section>


      {/* Notice & Insight Section */}
      {/* ── 01 NOTICE & INSIGHT ── */}
      <section style={{background:"#0D0D0D",padding:"clamp(40px,8vw,80px) 16px"}}>
        <div className="max-w-6xl mx-auto">
          {/* Section label */}
          <div className="mb-12">
            <p style={{fontSize:9,letterSpacing:"0.45em",color:GS.gold,fontFamily:"sans-serif",fontWeight:700,marginBottom:10}}>01 · NOTICE &amp; INSIGHT</p>
            <div style={{display:"flex",alignItems:"center",gap:20}}>
              <h2 style={{fontSize:"clamp(22px,3.5vw,32px)",fontWeight:700,color:"#FAF9F6",fontFamily:"sans-serif",margin:0}}>공지사항 &amp; 투자정보</h2>
              <div style={{flex:1,height:1,background:"rgba(196,160,40,0.2)"}} />
            </div>
          </div>
          <div className="grid md:grid-cols-2 gap-6">
            {/* Messages panel */}
            <div style={{border:`1px solid rgba(196,160,40,0.25)`,borderRadius:4,padding:"clamp(16px,4vw,24px)",minHeight:"auto",display:"flex",flexDirection:"column",background:"rgba(255,255,255,0.03)",overflow:"hidden"}}>
              <div style={{display:"flex",alignItems:"center",gap:12,marginBottom:20,paddingBottom:16,borderBottom:"1px solid rgba(255,255,255,0.07)"}}>
                <div style={{width:36,height:36,border:`1px solid ${GS.gold}`,borderRadius:4,display:"flex",alignItems:"center",justifyContent:"center"}}>
                  <Mail className="w-4 h-4" style={{color:GS.gold}} />
                </div>
                <h3 style={{fontSize:15,fontWeight:700,color:"#fff",margin:0,letterSpacing:"0.04em"}}>쪽지함</h3>
                {user && messages.filter(m => !m.isRead).length > 0 && (
                  <span style={{fontSize:10,color:GS.gold,background:"rgba(196,160,40,0.15)",padding:"2px 8px",borderRadius:2,marginLeft:"auto"}}>
                    {messages.filter(m => !m.isRead).length}개 미확인
                  </span>
                )}
              </div>
              {/* Message list */}
              <div style={{flex:1,overflowY:"auto",maxHeight:260}}>
                {!user ? (
                  <div style={{textAlign:"center",padding:"40px 16px"}}>
                    <p style={{color:"rgba(255,255,255,0.8)",fontSize:13,marginBottom:16,fontFamily:"sans-serif"}}>로그인 후 쪽지를 확인하세요</p>
                    <button onClick={() => setShowLoginModal(true)} style={{border:`1px solid ${GS.gold}`,background:"transparent",color:GS.gold,padding:"8px 24px",borderRadius:3,fontSize:12,fontWeight:600,letterSpacing:"0.1em",cursor:"pointer",fontFamily:"sans-serif"}}>로그인</button>
                  </div>
                ) : messages.length === 0 ? (
                  <p style={{color:"rgba(255,255,255,0.75)",fontSize:13,textAlign:"center",padding:"40px 0",fontFamily:"sans-serif"}}>받은 쪽지가 없습니다</p>
                ) : (
                  messages.slice(0, 4).map((msg) => (
                    <div key={msg.id} onClick={() => handleOpenMessage(msg)}
                      style={{width:"100%",boxSizing:"border-box",textAlign:"left",padding:"12px 0",borderBottom:"1px solid rgba(255,255,255,0.06)",cursor:"pointer",overflow:"hidden"}}
                      data-testid={`message-item-${msg.id}`}>
                      <div style={{display:"flex",alignItems:"center",gap:8,marginBottom:3,width:"100%",overflow:"hidden"}}>
                        {!msg.isRead && <span style={{width:5,height:5,borderRadius:"50%",background:GS.gold,display:"inline-block",flexShrink:0}} />}
                        <div style={{fontSize:13,fontWeight:600,color:"#fff",fontFamily:"sans-serif",overflow:"hidden",textOverflow:"ellipsis",whiteSpace:"nowrap",flex:1,minWidth:0}}>{msg.title}</div>
                      </div>
                      <div style={{fontSize:11,color:"rgba(255,255,255,0.6)",fontFamily:"sans-serif",overflow:"hidden",textOverflow:"ellipsis",whiteSpace:"nowrap",width:"100%",boxSizing:"border-box"}}>{msg.content}</div>
                    </div>
                  ))
                )}
              </div>
            </div>

            {/* Announcements panel */}
            <div style={{border:"1px solid rgba(255,255,255,0.08)",borderRadius:4,padding:"clamp(16px,4vw,24px)",minHeight:"auto",display:"flex",flexDirection:"column",background:"rgba(255,255,255,0.02)",overflow:"hidden"}}>
              <div style={{display:"flex",alignItems:"center",gap:12,marginBottom:20,paddingBottom:16,borderBottom:"1px solid rgba(255,255,255,0.07)"}}>
                <div style={{width:36,height:36,border:"1px solid rgba(255,255,255,0.15)",borderRadius:4,display:"flex",alignItems:"center",justifyContent:"center"}}>
                  <svg viewBox="0 0 24 24" width="16" height="16" fill="none" stroke="rgba(255,255,255,0.7)" strokeWidth="1.5" strokeLinecap="round">
                    <path d="M18 8A6 6 0 0 0 6 8c0 7-3 9-3 9h18s-3-2-3-9"/><path d="M13.73 21a2 2 0 0 1-3.46 0"/>
                  </svg>
                </div>
                <h3 style={{fontSize:15,fontWeight:700,color:"#fff",margin:0,letterSpacing:"0.04em",fontFamily:"sans-serif"}}>공지사항</h3>
              </div>
              <div style={{flex:1,overflowY:"auto",maxHeight:280}}>
                {announcements.length === 0 ? (
                  <p style={{color:"rgba(255,255,255,0.3)",fontSize:13,textAlign:"center",padding:"40px 0",fontFamily:"sans-serif"}}>등록된 공지사항이 없습니다</p>
                ) : (
                  announcements.slice(0, 5).map((ann) => (
                    <div key={ann.id}
                      onClick={() => { setSelectedAnnouncement(ann); setShowAnnouncementsModal(true); }}
                      style={{width:"100%",boxSizing:"border-box",textAlign:"left",padding:"12px 0",borderBottom:"1px solid rgba(255,255,255,0.06)",cursor:"pointer",overflow:"hidden"}}
                      data-testid={`landing-announcement-${ann.id}`}>
                      <div style={{display:"flex",alignItems:"center",gap:8,marginBottom:3,width:"100%",overflow:"hidden"}}>
                        {ann.isPinned && <span style={{fontSize:9,padding:"2px 6px",border:`1px solid ${GS.gold}`,color:GS.gold,borderRadius:2,flexShrink:0,letterSpacing:"0.05em",fontFamily:"sans-serif"}}>고정</span>}
                        <div style={{fontSize:13,fontWeight:500,color:"rgba(255,255,255,0.85)",fontFamily:"sans-serif",overflow:"hidden",textOverflow:"ellipsis",whiteSpace:"nowrap",flex:1,minWidth:0}}>{ann.title}</div>
                      </div>
                      <div style={{fontSize:11,color:"rgba(255,255,255,0.5)",fontFamily:"sans-serif",overflow:"hidden",textOverflow:"ellipsis",whiteSpace:"nowrap",width:"100%",boxSizing:"border-box"}}>{ann.content}</div>
                    </div>
                  ))
                )}
              </div>
            </div>
          </div>
        </div>
      </section>

      {/* ── 02 INVESTMENT PHILOSOPHY ── */}
      <section style={{background:"#FAF9F6",padding:"clamp(44px,8vw,88px) 16px"}}>
        <div className="max-w-6xl mx-auto">
          <div style={{marginBottom:56}}>
            <p style={{fontSize:9,letterSpacing:"0.45em",color:GS.gold,fontFamily:"sans-serif",fontWeight:700,marginBottom:10}}>02 · INVESTMENT PHILOSOPHY</p>
            <div style={{display:"flex",alignItems:"center",gap:20}}>
              <h2 style={{fontSize:"clamp(22px,3.5vw,32px)",fontWeight:700,color:"#0D0D0D",fontFamily:"sans-serif",margin:0}} data-testid="text-features-title">왜 Gold-signal인가?</h2>
              <div style={{flex:1,height:1,background:"rgba(196,160,40,0.2)"}} />
            </div>
          </div>
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-0" style={{border:"1px solid rgba(196,160,40,0.18)"}}>
            {[
              { icon: TrendingUp, num:"01", title:"실시간 시세", description:"글로벌 지수의 가격 변동을 지연 없이 실시간으로 확인하세요.", img:"/icons/icon-realtime.png" },
              { icon: Award,      num:"02", title:"투명한 정산", description:"명확한 기준의 스트라이크 가격으로 공정하게 정산됩니다.", img:"/icons/icon-settlement.png" },
              { icon: Shield,     num:"03", title:"자산 보안",   description:"은행급 보안 시스템으로 회원님의 자산을 안전하게 보호합니다.", img:"/icons/icon-security.png" },
              { icon: Headphones, num:"04", title:"24시간 운영", description:"연중무휴 24시간, 언제든 원하는 시간에 거래할 수 있습니다.", img:"/icons/icon-support.png" },
            ].map((f, i) => (
              <div key={i} data-testid={`card-feature-${i}`}
                className={[
                  i < 3 ? "border-b border-[rgba(196,160,40,0.18)]" : "",
                  "lg:border-b-0",
                  i < 3 ? "lg:border-r lg:border-[rgba(196,160,40,0.18)]" : "",
                ].join(" ")}
                style={{padding:"clamp(20px,4vw,36px) clamp(16px,3vw,28px)",borderTop:`3px solid ${i === 0 ? GS.gold : "transparent"}`}}>
                <div style={{display:"flex",alignItems:"center",justifyContent:"space-between",marginBottom:24}}>
                  {f.img ? (
                    <img src={f.img} alt={f.title} style={{width:44,height:44,objectFit:"contain"}} />
                  ) : (
                    <div style={{width:40,height:40,border:`1px solid rgba(196,160,40,0.35)`,borderRadius:3,display:"flex",alignItems:"center",justifyContent:"center"}}>
                      <f.icon className="w-5 h-5" style={{color:GS.gold}} />
                    </div>
                  )}
                  <span style={{fontSize:11,fontWeight:700,color:"rgba(0,0,0,0.12)",fontFamily:"sans-serif",letterSpacing:"0.04em"}}>{f.num}</span>
                </div>
                <h3 style={{fontSize:16,fontWeight:700,color:"#0D0D0D",marginBottom:10,fontFamily:"sans-serif"}}>{f.title}</h3>
                <p style={{fontSize:13,color:"#666",lineHeight:1.75,fontFamily:"sans-serif",margin:0}}>{f.description}</p>
              </div>
            ))}
          </div>
        </div>
      </section>

      {/* ── 03 TESTIMONIALS ── */}
      <section style={{background:"#0D0D0D",padding:"clamp(44px,8vw,88px) 16px"}}>
        <div className="max-w-6xl mx-auto">
          <div style={{marginBottom:56}}>
            <p style={{fontSize:9,letterSpacing:"0.45em",color:GS.gold,fontFamily:"sans-serif",fontWeight:700,marginBottom:10}}>03 · PLATFORM REVIEWS</p>
            <div style={{display:"flex",alignItems:"center",gap:20}}>
              <h2 style={{fontSize:"clamp(22px,3.5vw,32px)",fontWeight:700,color:"#FAF9F6",fontFamily:"sans-serif",margin:0}} data-testid="text-reviews-title">고객리뷰</h2>
              <div style={{flex:1,height:1,background:"rgba(196,160,40,0.18)"}} />
            </div>
          </div>
          <div className="grid md:grid-cols-3 gap-4 md:gap-6">
            {[
              { text:"처음 보자마자 거래 플랫폼과 사랑에 빠졌습니다. 깔끔하고 간편한 디자인이 정말 마음에 들었거든요.", name:"투자자 01" },
              { text:"이 플랫폼을 통해 옵션 거래에 대해 많은 것을 배웠어요. 이제 투자를 통해 수익을 올릴 수 있게 되었죠.", name:"투자자 02" },
              { text:"지원팀 문의가 간단하고 쉽더라고요. 빠르게 문의 사항에 답변해 주시는 것에 놀랐습니다.", name:"투자자 03" },
            ].map((r, i) => (
              <div key={i} data-testid={`card-review-${i}`}
                style={{border:"1px solid rgba(255,255,255,0.07)",padding:"clamp(20px,4vw,36px) clamp(16px,4vw,32px)",background:"rgba(255,255,255,0.02)",display:"flex",flexDirection:"column",justifyContent:"space-between",minHeight:"auto"}}>
                {/* Gold quote mark */}
                <div>
                  <div style={{fontSize:"clamp(36px,8vw,56px)",lineHeight:1,color:GS.gold,fontFamily:"Georgia,serif",marginBottom:16,opacity:0.65}}>"</div>
                  <p style={{fontSize:"clamp(14px,4vw,19px)",color:"rgba(255,255,255,0.82)",lineHeight:1.75,fontFamily:"sans-serif",marginBottom:0,fontWeight:400,letterSpacing:"-0.01em"}}>{r.text}</p>
                </div>
                <div style={{paddingTop:24,marginTop:28,borderTop:"1px solid rgba(255,255,255,0.07)"}}>
                  <p style={{fontSize:14,fontWeight:600,color:"#fff",fontFamily:"sans-serif",margin:0}}>{r.name}</p>
                  <p style={{fontSize:10,color:"rgba(255,255,255,0.35)",fontFamily:"sans-serif",margin:0,letterSpacing:"0.08em"}}>PREMIUM 회원</p>
                </div>
              </div>
            ))}
          </div>
        </div>
      </section>

      {/* ── STATS ── */}
      <section style={{background:"#FAF9F6",padding:"clamp(36px,6vw,72px) 16px",borderTop:`1px solid rgba(196,160,40,0.14)`}}>
        <div className="max-w-6xl mx-auto">
          <div className="grid grid-cols-2 md:grid-cols-4">
            {[
              { value:"12,400+", unit:"명", label:"누적회원수" },
              { value:"3.2억",   unit:"원", label:"일평균거래량" },
              { value:"24/7",    unit:"",   label:"서비스운영" },
              { value:"99.9",    unit:"%",  label:"시스템가동률" },
            ].map((s, i) => (
              <div key={i} data-testid={`stat-${i}`}
                className={[
                  i % 2 === 0 ? "border-r border-[rgba(196,160,40,0.14)]" : "",
                  i < 2 ? "border-b border-[rgba(196,160,40,0.14)] md:border-b-0" : "",
                  "md:border-r md:border-[rgba(196,160,40,0.14)] last:border-r-0 md:[&:nth-child(2)]:border-r",
                ].join(" ")}
                style={{padding:"clamp(20px,3vw,32px) clamp(12px,2vw,20px)",textAlign:"center"}}>
                <p style={{fontSize:"clamp(24px,6vw,52px)",fontWeight:900,color:"#0D0D0D",fontFamily:"sans-serif",margin:0,lineHeight:1,letterSpacing:"-0.02em"}}>
                  {s.value}<span style={{fontSize:"0.5em",color:GS.gold}}>{s.unit}</span>
                </p>
                <div style={{width:24,height:2,background:GS.gold,margin:"10px auto 8px"}} />
                <p style={{fontSize:11,color:"#888",fontFamily:"sans-serif",letterSpacing:"0.12em",margin:0}}>{s.label}</p>
              </div>
            ))}
          </div>
        </div>
      </section>

      {/* ── CTA ── */}
      {!user && (
        <section style={{background:"#0D0D0D",padding:"clamp(48px,8vw,96px) 16px"}}>
          <div style={{maxWidth:680,margin:"0 auto",textAlign:"center"}}>
            <p style={{fontSize:9,letterSpacing:"0.45em",color:GS.gold,fontFamily:"sans-serif",fontWeight:700,marginBottom:20}}>GET STARTED</p>
            <h2 style={{fontSize:"clamp(26px,4vw,44px)",fontWeight:700,color:"#FAF9F6",lineHeight:1.2,marginBottom:16,fontFamily:"sans-serif"}} data-testid="text-cta-title">
              Gold-signal에 가입하고<br />지금 바로 시작하세요
            </h2>
            <p style={{fontSize:15,color:"rgba(255,255,255,0.45)",marginBottom:44,lineHeight:1.7,fontFamily:"sans-serif"}}>
              당신의 첫 투자, 믿을 수 있는 Gold-signal에서 시작하세요.
            </p>
            <div style={{display:"flex",flexWrap:"wrap",gap:16,justifyContent:"center"}}>
              <button data-testid="button-login-cta" onClick={() => setShowLoginModal(true)}
                style={{border:`1.5px solid rgba(255,255,255,0.2)`,background:"transparent",color:"rgba(255,255,255,0.75)",padding:"14px 48px",borderRadius:3,fontSize:14,fontWeight:600,letterSpacing:"0.1em",cursor:"pointer",fontFamily:"sans-serif"}}>
                로그인
              </button>
              <button data-testid="button-register-cta" onClick={() => setShowRegisterModal(true)}
                style={{border:"none",background:GS.gold,color:"#fff",padding:"14px 48px",borderRadius:3,fontSize:14,fontWeight:700,letterSpacing:"0.1em",cursor:"pointer",fontFamily:"sans-serif",boxShadow:`0 4px 18px rgba(196,160,40,0.30)`}}>
                회원가입
              </button>
            </div>
          </div>
        </section>
      )}

      {/* Footer */}
      <footer className="py-8 md:py-16 px-4 border-t" style={{background:"#0D0D0D",borderColor:"rgba(196,160,40,0.18)"}}>
        <div className="max-w-6xl mx-auto">
          <div className="grid grid-cols-2 md:grid-cols-5 gap-6 md:gap-10 mb-8 md:mb-12">
            <div>
              <div className="mb-4">
                <img src="/icons/gs-logo.png" alt="GOLD-SIGNAL" style={{height:56,width:"auto",objectFit:"contain"}} />
              </div>
              <p className="text-gray-400 text-sm">
                안전하고 투명한 시스템으로<br />
                빠르고 편리한 옵션 거래를 제공합니다.
              </p>
            </div>
            <div>
              <h4 className="font-semibold mb-4 text-gray-300">거래 종목</h4>
              <ul className="space-y-2 text-gray-400 text-sm">
                <li><Link href="/trade" className="hover:text-[#C4A028] transition-colors" data-testid="link-trade-gold">금거래 (GOLD)</Link></li>
                <li><Link href="/trade" className="hover:text-[#C4A028] transition-colors" data-testid="link-trade-gbp">파운드 (GBP/USD)</Link></li>
                <li><Link href="/trade" className="hover:text-[#C4A028] transition-colors" data-testid="link-trade-btc">BTC (비트코인)</Link></li>
                <li><Link href="/trade" className="hover:text-[#C4A028] transition-colors" data-testid="link-trade-silver">은거래 (SILVER)</Link></li>
              </ul>
            </div>
            <div>
              <h4 className="font-semibold mb-4 text-gray-300">입환급</h4>
              <ul className="space-y-2 text-gray-400 text-sm">
                <li><button onClick={() => { 
                  if (!user) { setShowLoginModal(true); return; }
                  if (!isWithinOperatingHours()) { toast.error("입환급 신청은 오전 09:00 ~ 18:00 사이에만 가능합니다"); return; }
                  setDepositAmount(''); setDepositSenderName(user?.name || user?.accountHolder || ''); setShowDepositPageModal(true);
                }} className="hover:text-[#C4A028] transition-colors" data-testid="link-deposit">예치신청</button></li>
                <li><button onClick={() => { 
                  if (!user) { setShowLoginModal(true); return; }
                  if ((user as any)?.isBettingBlocked) { toast.error("거래정지 해제 이후 다시 시도해 주세요."); return; }
                  if (!isWithinOperatingHours()) { toast.error("입환급 신청은 오전 09:00 ~ 18:00 사이에만 가능합니다"); return; }
                  setWithdrawalAmount(''); setShowWithdrawalPageModal(true);
                }} className="hover:text-[#C4A028] transition-colors" data-testid="link-withdraw">환급신청</button></li>
                <li><button onClick={() => { if (user) { setShowHistoryModal(true); } else { setShowLoginModal(true); } }} className="hover:text-[#C4A028] transition-colors" data-testid="link-transaction-history">입환급내역</button></li>
              </ul>
            </div>
            <div>
              <h4 className="font-semibold mb-4 text-gray-300">고객센터</h4>
              <ul className="space-y-2 text-gray-400 text-sm">
                <li><button onClick={() => setShowAnnouncementsModal(true)} className="hover:text-[#C4A028] transition-colors" data-testid="link-notice">공지사항</button></li>
                <li><button onClick={() => setShowCustomerServiceModal(true)} className="hover:text-[#C4A028] transition-colors" data-testid="link-inquiry">고객센터</button></li>
              </ul>
            </div>
            <div>
              <h4 className="font-semibold mb-4 text-gray-300">가능시간</h4>
              <p className="text-gray-500 text-xs mb-2">(주말/공휴일 제외)</p>
              <ul className="space-y-2 text-gray-400 text-xs">
                <li><span className="text-gray-500">고객상담</span><br />평일 09:00 ~ 21:00</li>
                <li><span className="text-gray-500">예치시간</span><br />평일 09:00 ~ 21:00</li>
                <li><span className="text-gray-500">환급시간</span><br />평일 09:00 ~ 21:00</li>
              </ul>
            </div>
          </div>

          <div className="border-t border-white/10 pt-6 text-center text-gray-500 text-sm space-y-2">
            <p>© 2024 Gold-signal. All rights reserved.</p>
          </div>
        </div>
      </footer>

      {/* Login Modal */}
      <Dialog open={showLoginModal} onOpenChange={setShowLoginModal}>
        <DialogContent className="sm:max-w-md p-0 bg-transparent border-none shadow-none [&>button]:hidden">
          <DialogTitle className="sr-only">로그인</DialogTitle>
          <div className="relative">
            <div style={{background:"#FAF9F6",border:"1px solid rgba(196,160,40,0.22)",borderTop:"3px solid #C4A028",borderRadius:8,padding:"clamp(16px,4vw,24px)",position:"relative",boxShadow:"0 20px 60px rgba(0,0,0,0.18)"}}>
              <button 
                onClick={() => setShowLoginModal(false)}
                className="absolute top-4 right-4 transition-colors z-10" style={{color:"#999"}} onMouseEnter={e=>(e.currentTarget.style.color="#C4A028")} onMouseLeave={e=>(e.currentTarget.style.color="rgba(255,255,255,0.4)")}
                data-testid="button-close-login-modal"
              >
                <X className="w-5 h-5" />
              </button>
              
              <div className="text-center mb-3">
                <div className="flex items-center justify-center gap-2 mb-2">
                  <img src="/icons/gs-logo.png" alt="GOLD-SIGNAL" style={{height:40,width:"auto",objectFit:"contain"}} />
                </div>
                <h2 className="text-xl font-bold mb-1" style={{color:"#111111"}}>로그인</h2>
                <p className="text-sm" style={{color:"#888"}}>계정에 접속하여 거래를 시작하세요</p>
              </div>
              
              <form onSubmit={handleLoginSubmit} className="space-y-3">
                <div className="space-y-2">
                  <label className="text-sm font-medium" style={{color:"#666"}}>아이디</label>
                  <Input
                    type="text"
                    value={username}
                    onChange={(e) => setUsername(e.target.value)}
                    placeholder="아이디를 입력하세요"
                    className="h-10 border transition-all" style={{background:"#FAF9F6",borderColor:"rgba(196,160,40,0.3)",color:"#111"}}
                    data-testid="input-modal-username"
                    required
                  />
                </div>

                <div className="space-y-2">
                  <label className="text-sm font-medium" style={{color:"#666"}}>비밀번호</label>
                  <Input
                    type="password"
                    value={password}
                    onChange={(e) => setPassword(e.target.value)}
                    placeholder="비밀번호를 입력하세요"
                    className="h-10 border transition-all" style={{background:"#FAF9F6",borderColor:"rgba(196,160,40,0.3)",color:"#111"}}
                    data-testid="input-modal-password"
                    required
                  />
                </div>

                <Button
                  type="submit"
                  className="w-full h-10 text-base font-semibold text-white transition-all" style={{background:"#C4A028",border:"none",borderRadius:4,letterSpacing:"0.1em",cursor:"pointer"}}
                  disabled={login.isPending}
                  data-testid="button-modal-login"
                >
                  {login.isPending ? "로그인 중..." : "로그인"}
                </Button>
              </form>

              <div className="mt-4 pt-4 text-center text-sm" style={{borderTop:"1px solid rgba(196,160,40,0.15)",color:"#999"}}>
                계정이 없으신가요?{" "}
                <button 
                  className="font-medium transition-colors" style={{color:"#C4A028"}}
                  onClick={() => {
                    setShowLoginModal(false);
                    setShowRegisterModal(true);
                  }}
                >
                  회원가입
                </button>
              </div>
              
              <div className="mt-4 flex items-center justify-center gap-4 text-xs text-gray-500">
                <span className="flex items-center gap-1">
                  <span className="w-1.5 h-1.5 rounded-full bg-emerald-500 animate-pulse" />
                  실시간 거래
                </span>
                <span>|</span>
                <span>24시간 운영</span>
              </div>
            </div>
          </div>
        </DialogContent>
      </Dialog>

      {/* Register Modal */}
      <Dialog open={showRegisterModal} onOpenChange={(open) => { setShowRegisterModal(open); if (!open) { setRegisterErrorMessage(""); setUsernameChecked(false); setUsernameCheckMessage(""); setUsernameAvailable(false); } }}>
        <DialogContent className="sm:max-w-lg p-0 bg-transparent border-none shadow-none [&>button]:hidden max-h-[90vh] overflow-y-auto">
          <DialogTitle className="sr-only">회원가입</DialogTitle>
          <div className="relative">
            <div style={{background:"#FAF9F6",border:"1px solid rgba(196,160,40,0.22)",borderTop:"3px solid #C4A028",borderRadius:8,padding:"clamp(16px,4vw,24px)",position:"relative",boxShadow:"0 20px 60px rgba(0,0,0,0.18)"}}>
              <button 
                onClick={() => setShowRegisterModal(false)}
                className="absolute top-4 right-4 transition-colors z-10" style={{color:"#999"}} onMouseEnter={e=>(e.currentTarget.style.color="#C4A028")} onMouseLeave={e=>(e.currentTarget.style.color="rgba(255,255,255,0.4)")}
                data-testid="button-close-register-modal"
              >
                <X className="w-5 h-5" />
              </button>
              
              <div className="text-center mb-4">
                <div className="flex items-center justify-center gap-2 mb-3">
                  <img src="/icons/gs-logo.png" alt="GOLD-SIGNAL" style={{height:36,width:"auto",objectFit:"contain"}} />
                </div>
                <h2 className="text-xl font-bold mb-1" style={{color:"#111111"}}>회원가입</h2>
                <p className="text-sm" style={{color:"#888"}}>지금 가입하고 거래를 시작하세요</p>
              </div>
              
              <form onSubmit={handleRegisterSubmit} className="space-y-3">
                <div className="space-y-1">
                  <label className="text-xs font-medium" style={{color:"#666"}}>아이디</label>
                  <div className="flex gap-2">
                    <Input
                      type="text"
                      value={regUsername}
                      onChange={(e) => { setRegUsername(e.target.value); setUsernameChecked(false); setUsernameCheckMessage(""); setUsernameAvailable(false); }}
                      placeholder="아이디 (3자 이상)"
                      className="h-10 border text-sm flex-1" style={{background:"#FAF9F6",borderColor:"rgba(196,160,40,0.3)",color:"#111"}}
                      data-testid="input-reg-username"
                      required
                    />
                    <Button
                      type="button"
                      onClick={handleCheckUsername}
                      disabled={checkingUsername || regUsername.length < 3}
                      className="h-10 px-3 text-xs font-medium whitespace-nowrap" style={{background:"transparent",border:"1px solid #C4A028",color:"#C4A028",borderRadius:4}}
                      data-testid="button-check-username"
                    >
                      {checkingUsername ? "확인중..." : "중복확인"}
                    </Button>
                  </div>
                  {usernameChecked && usernameCheckMessage && (
                    <p className={`text-xs mt-1 ${usernameAvailable ? 'text-green-400' : 'text-red-400'}`} data-testid="text-username-check">
                      {usernameCheckMessage}
                    </p>
                  )}
                </div>

                <div className="grid grid-cols-2 gap-3">
                  <div className="space-y-1">
                    <label className="text-xs font-medium" style={{color:"#666"}}>이름</label>
                    <Input
                      type="text"
                      value={name}
                      onChange={(e) => setName(e.target.value)}
                      placeholder="실명"
                      className="h-10 bg-gray-50 border-gray-200 text-gray-900 placeholder:text-gray-500 focus:border-[#F59E0B]/50 text-sm"
                      data-testid="input-reg-name"
                      required
                    />
                  </div>
                </div>

                <div className="space-y-1">
                  <div className="grid grid-cols-2 gap-3">
                    <div className="space-y-1">
                      <label className="text-xs font-medium" style={{color:"#666"}}>비밀번호</label>
                      <Input
                        type="password"
                        value={regPassword}
                        onChange={(e) => setRegPassword(e.target.value)}
                        placeholder="비밀번호 입력"
                        className="h-10 bg-gray-50 border-gray-200 text-gray-900 placeholder:text-gray-500 focus:border-[#F59E0B]/50 text-sm"
                        data-testid="input-reg-password"
                        required
                      />
                    </div>
                    <div className="space-y-1">
                      <label className="text-xs font-medium" style={{color:"#666"}}>비밀번호 확인</label>
                      <Input
                        type="password"
                        value={confirmPassword}
                        onChange={(e) => setConfirmPassword(e.target.value)}
                        placeholder="비밀번호 재입력"
                        className="h-10 bg-gray-50 border-gray-200 text-gray-900 placeholder:text-gray-500 focus:border-[#F59E0B]/50 text-sm"
                        data-testid="input-reg-confirm-password"
                        required
                      />
                    </div>
                  </div>
                  <p className="text-xs text-gray-500">대소문자, 숫자, 특수문자 필수 기입 8자리 이상</p>
                </div>

                <div className="grid grid-cols-2 gap-3">
                  <div className="space-y-1">
                    <label className="text-xs font-medium" style={{color:"#666"}}>휴대폰 번호</label>
                    <Input
                      type="tel"
                      value={phone}
                      onChange={(e) => setPhone(e.target.value)}
                      placeholder="01012345678"
                      className="h-10 bg-gray-50 border-gray-200 text-gray-900 placeholder:text-gray-500 focus:border-[#F59E0B]/50 text-sm"
                      data-testid="input-reg-phone"
                      required
                    />
                  </div>
                  <div className="space-y-1">
                    <label className="text-xs font-medium" style={{color:"#666"}}>생년월일</label>
                    <Input
                      type="text"
                      value={regBirthDate}
                      onChange={(e) => {
                        const val = e.target.value.replace(/\D/g, '').slice(0, 6);
                        setRegBirthDate(val);
                      }}
                      placeholder="예: 901231"
                      maxLength={6}
                      className="h-10 bg-gray-50 border-gray-200 text-gray-900 placeholder:text-gray-500 focus:border-[#F59E0B]/50 text-sm"
                      data-testid="input-reg-birthdate"
                      required
                    />
                  </div>
                </div>

                <div className="pt-2 border-t border-gray-200">
                  <p className="text-xs text-gray-500 mb-2">환급 계좌 정보</p>
                  
                  <div className="space-y-3">
                    <div className="space-y-1">
                      <label className="text-xs font-medium" style={{color:"#666"}}>은행 선택</label>
                      <Select value={bankName} onValueChange={setBankName}>
                        <SelectTrigger className="h-10 bg-gray-50 border-gray-200 text-gray-900 text-sm">
                          <SelectValue placeholder="은행을 선택하세요" />
                        </SelectTrigger>
                        <SelectContent className="bg-[#FAF9F6] border-gray-200 max-h-60 overflow-y-auto">
                          {KOREAN_BANKS.map((bank) => (
                            <SelectItem key={bank} value={bank} className="text-gray-900 hover:bg-gray-100">
                              {bank}
                            </SelectItem>
                          ))}
                        </SelectContent>
                      </Select>
                    </div>

                    <div className="grid grid-cols-2 gap-3">
                      <div className="space-y-1">
                        <label className="text-xs font-medium" style={{color:"#666"}}>예금주</label>
                        <Input
                          type="text"
                          value={accountHolder}
                          onChange={(e) => setAccountHolder(e.target.value)}
                          placeholder="예금주명"
                          className="h-10 bg-gray-50 border-gray-200 text-gray-900 placeholder:text-gray-500 focus:border-[#F59E0B]/50 text-sm"
                          data-testid="input-reg-account-holder"
                          required
                        />
                      </div>
                      <div className="space-y-1">
                        <label className="text-xs font-medium" style={{color:"#666"}}>계좌번호</label>
                        <Input
                          type="text"
                          value={accountNumber}
                          onChange={(e) => setAccountNumber(e.target.value)}
                          placeholder="- 없이 입력"
                          className="h-10 bg-gray-50 border-gray-200 text-gray-900 placeholder:text-gray-500 focus:border-[#F59E0B]/50 text-sm"
                          data-testid="input-reg-account-number"
                          required
                        />
                      </div>
                    </div>
                  </div>
                </div>

                <div className="space-y-1">
                  <label className="text-xs font-medium" style={{color:"#666"}}>가입 코드 <span className="text-gray-400">(선택)</span></label>
                  <Input
                    type="text"
                    value={branchCode}
                    onChange={(e) => setBranchCode(e.target.value)}
                    placeholder="초대 코드가 있으면 입력하세요"
                    className="h-10 bg-gray-50 border-gray-200 text-gray-900 placeholder:text-gray-500 focus:border-[#F59E0B]/50 text-sm"
                    data-testid="input-reg-branch-code"
                  />
                </div>

                {registerErrorMessage && (
                  <div className="bg-red-500/10 border border-red-500/30 rounded-lg p-3 mt-2" data-testid="text-register-error">
                    <p className="text-red-400 text-sm text-center font-medium">{registerErrorMessage}</p>
                  </div>
                )}

                <Button
                  type="submit"
                  className="w-full h-11 text-base font-semibold text-white transition-all mt-4" style={{background:"#C4A028",border:"none",borderRadius:4,letterSpacing:"0.08em",cursor:"pointer"}}
                  disabled={register.isPending}
                  data-testid="button-modal-register"
                >
                  {register.isPending ? "가입 중..." : "회원가입"}
                </Button>
              </form>

              <div className="mt-4 pt-4 text-center text-sm" style={{borderTop:"1px solid rgba(196,160,40,0.15)",color:"#999"}}>
                이미 계정이 있으신가요?{" "}
                <button 
                  className="font-medium transition-colors" style={{color:"#C4A028"}}
                  onClick={() => {
                    setShowRegisterModal(false);
                    setShowLoginModal(true);
                  }}
                >
                  로그인
                </button>
              </div>
            </div>
          </div>
        </DialogContent>
      </Dialog>

      {/* Trade History Modal */}
      <Dialog open={showHistoryModal} onOpenChange={setShowHistoryModal}>
        <DialogContent className="sm:max-w-lg p-0 bg-transparent border-none shadow-none [&>button]:hidden max-h-[90vh] overflow-y-auto">
          <DialogTitle className="sr-only">거래내역</DialogTitle>
          <div className="relative">
            <div style={{background:"#FAF9F6",border:"1px solid rgba(196,160,40,0.22)",borderTop:"3px solid #C4A028",borderRadius:8,padding:"clamp(16px,4vw,24px)",position:"relative",boxShadow:"0 20px 60px rgba(0,0,0,0.18)"}}>
              <button 
                onClick={() => setShowHistoryModal(false)}
                className="absolute top-4 right-4 transition-colors z-10" style={{color:"#999"}} onMouseEnter={e=>(e.currentTarget.style.color="#C4A028")} onMouseLeave={e=>(e.currentTarget.style.color="rgba(255,255,255,0.4)")}
              >
                <X className="w-5 h-5" />
              </button>
              
              <div className="text-center mb-6">
                <div className="flex items-center justify-center gap-2 mb-3">
                  <History className="w-8 h-8" style={{color:"#C4A028"}} />
                </div>
                <h2 className="text-xl font-bold mb-1" style={{color:"#111111"}}>거래내역</h2>
                <p className="text-sm" style={{color:"#888"}}>나의 거래 기록과 보유금액을 확인하세요</p>
              </div>

              {/* Balance Card */}
              <div className="rounded p-4 mb-6" style={{background:"rgba(196,160,40,0.06)",border:"1px solid rgba(196,160,40,0.22)"}}>
                <div className="flex items-center justify-between">
                  <div className="flex items-center gap-3">
                    <Wallet className="w-6 h-6" style={{color:"#C4A028"}} />
                    <span className="" style={{color:"#666"}}>보유금액</span>
                  </div>
                  <span className="text-2xl font-bold" style={{color:"#111111"}}>
                    {balanceData?.balance ? Number(balanceData.balance).toLocaleString() : '0'}원
                  </span>
                </div>
              </div>

              {/* Bet History */}
              <div className="space-y-3 max-h-[300px] overflow-y-auto">
                <h3 className="text-sm font-medium mb-2" style={{color:"#888"}}>최근 거래 내역</h3>
                {betHistory && betHistory.length > 0 ? (
                  betHistory.slice(0, 10).map((bet: any) => (
                    <div 
                      key={bet.id} 
                      className="rounded p-3 flex items-center justify-between" style={{background:"#F3F2EF",border:"1px solid #EDEDED"}}
                    >
                      <div>
                        <div className="flex items-center gap-2">
                          <span className={`text-xs px-2 py-0.5 rounded ${bet.direction === 'long' ? 'bg-red-500/20 text-red-400' : 'bg-red-500/20 text-red-400'}`}>
                            {bet.direction === 'long' ? 'Long' : 'Short'}
                          </span>
                          <span className="font-medium" style={{color:"#111111"}}>{bet.symbol}</span>
                          {bet.roundNumber && (
                            <span className="text-[10px] px-1.5 py-0.5 rounded bg-yellow-500/20 text-yellow-400">
                              {bet.roundNumber}회차
                            </span>
                          )}
                        </div>
                        <div className="text-xs text-gray-500 mt-1">
                          {new Date(bet.createdAt).toLocaleDateString('ko-KR', { timeZone: 'Asia/Seoul' })}{' '}
                          {new Date(bet.createdAt).toLocaleTimeString('ko-KR', { hour: '2-digit', minute: '2-digit', hour12: false, timeZone: 'Asia/Seoul' })}
                        </div>
                      </div>
                      <div className="text-right">
                        <div className="font-medium" style={{color:"#111111"}}>
                          {Number(bet.amount).toLocaleString()}원
                        </div>
                        <div className={`text-xs ${bet.outcome === 'win' ? 'text-green-400' : bet.outcome === 'lose' ? 'text-red-400' : 'text-yellow-400'}`}>
                          {bet.outcome === 'win' ? '실현' : bet.outcome === 'lose' ? '실격' : '진행중'}
                        </div>
                      </div>
                    </div>
                  ))
                ) : (
                  <div className="text-center py-8" style={{color:"#aaa"}}>
                    거래 내역이 없습니다
                  </div>
                )}
              </div>

              <Button
                className="w-full mt-4 text-white font-semibold" style={{background:"#C4A028",border:"none",borderRadius:4}}
                onClick={() => {
                  setShowHistoryModal(false);
                  setLocation("/trade");
                }}
              >
                거래하러 가기
              </Button>
            </div>
          </div>
        </DialogContent>
      </Dialog>

      {/* ===== 예치 신청 모달 ===== */}
      <Dialog open={showDepositPageModal} onOpenChange={(open) => { if (!open) { setShowDepositPageModal(false); setDepositAmount(''); setDepositSenderName(''); } }}>
        <DialogContent className="sm:max-w-lg p-0 bg-transparent border-none shadow-none [&>button]:hidden max-h-[90vh] overflow-y-auto overflow-x-hidden">
          <DialogTitle className="sr-only">예치 신청</DialogTitle>
          <div className="relative overflow-x-hidden">
            <div style={{background:"#FAF9F6",border:"1px solid rgba(196,160,40,0.22)",borderTop:"3px solid #C4A028",borderRadius:8,padding:"clamp(16px,4vw,24px)",position:"relative",boxShadow:"0 20px 60px rgba(0,0,0,0.18)"}}>
              {/* 헤더 */}
              <div className="flex items-center justify-between mb-5">
                <button onClick={() => { setShowDepositPageModal(false); setDepositAmount(''); setDepositSenderName(''); }}
                  className="flex items-center gap-2 transition-colors" style={{color:"#888"}}>
                  <ChevronRight className="w-5 h-5 rotate-180" />
                  <span className="text-sm">뒤로가기</span>
                </button>
                <h2 className="text-lg font-bold" style={{color:"#111111"}}>예치 신청</h2>
                <button onClick={() => { setShowDepositPageModal(false); setDepositAmount(''); setDepositSenderName(''); }}
                  className="transition-colors" style={{color:"#999"}}>
                  <X className="w-5 h-5" />
                </button>
              </div>

              {/* 현재 보유금액 */}
              <div className="rounded p-3 mb-5" style={{background:"rgba(196,160,40,0.06)",border:"1px solid rgba(196,160,40,0.22)"}}>
                <div className="flex items-center justify-between">
                  <span className="text-sm" style={{color:"#888"}}>현재 보유금액</span>
                  <span className="text-xl font-bold" style={{color:"#111111"}}>{balanceData?.balance ? Number(balanceData.balance).toLocaleString() : '0'}원</span>
                </div>
              </div>

              {/* 예치 안내 */}
              <div className="rounded p-4 mb-5" style={{background:"#F3F2EF",border:"1px solid #EEEEEE"}}>
                <h3 className="text-sm font-bold mb-3" style={{color:"#C4A028"}}>예치 안내</h3>
                <div className="space-y-3" style={{maxHeight:220,overflowY:"auto",paddingRight:4}}>
                  {[
                    { step: '1', text: '예치하실 금액을 송금하시기 전에는 필히 예치 전용 계좌 정보 확인을 당부드립니다.(예치 전용 계좌 정보를 확인하시지 않고 이전 계좌 및 해당하지 않는 계좌로 송금하실 경우 예치확인이 불가하여 정상적인 처리가 되지않아 불이익이 발생할수 있습니다.)' },
                    { step: '2', text: '예치신청 접수 후 20분 이내에 실제 예치확인이 되지 않는 경우에는 신청하신 내용이 자동 삭제(취소)처리가 됩니다.(예치신청 접수 후 20분이 초과 되신경우 다시한번 예치 신청을 해주시기 바랍니다.)' },
                    { step: '3', text: '입금자명(보내시는분) / 예치신청 접수 금액 / 실제 예치금액이 모두 일치하시면 송금하신 후 보다 신속한 예치신청 접수 접수의 승인처리가 됩니다.' },
                    { step: '4', text: '예치신청 접수는 신청하신 내용이 완료되지 않거나 삭제(취소)되지 않은 상태에서는 중복신청 또는 추가신청이 불가합니다.' },
                    { step: '5', text: '재예치 신청을 하고자 하실때에는 최근 예치내역에서 기존 신청건을 취소해 주신 후 재예치 신청을 해주시기 바랍니다.' },
                    { step: '6', text: '수표예치 시 예치 처리가 되지 않습니다.' },
                    { step: '7', text: '정산 보고 정상 처리를 위해 반드시 초기 등록 계좌로 예치해 주시기 바랍니다. 미등록 계좌 예치 시 불이익이 발생할 수 있습니다.' },
                  ].map(({ step, text }) => (
                    <div key={step} className="flex gap-3">
                      <span className="shrink-0 w-6 h-6 rounded-full flex items-center justify-center text-xs font-bold" style={{background:"rgba(196,160,40,0.1)",border:"1px solid rgba(196,160,40,0.35)",color:"#8A6C10",fontSize:10}}>{step}</span>
                      <p className="text-xs leading-relaxed pt-0.5" style={{color:"#666"}}>{text}</p>
                    </div>
                  ))}
                </div>
              </div>

              {/* 예치 계좌 정보 */}
              <div className="rounded p-4 mb-5" style={{background:"#F3F2EF",border:"1px solid #EEEEEE"}}>
                <div className="flex items-center justify-between">
                  <div>
                    <p className="text-gray-600 text-sm font-medium mb-1">예치 계좌 정보</p>
                    <p className="text-xs" style={{color:"#aaa"}}>예치 계좌 정보는 고객센터를 통해 개별 안내드립니다.</p>
                  </div>
                  <button
                    onClick={async () => {
                      try {
                        const res = await fetch('/api/inquiries', {
                          method: 'POST',
                          headers: { 'Content-Type': 'application/json' },
                          body: JSON.stringify({
                            title: '예치계좌 안내 요청',
                            content: '예치계좌 정보를 안내해 주세요.',
                          }),
                        });
                        if (!res.ok) {
                          const data = await res.json();
                          throw new Error(data.error || '문의 생성에 실패했습니다');
                        }
                        refetchInquiries();
                        toast.success('예치계좌 안내 문의가 접수되었습니다.');
                        setShowDepositPageModal(false);
                        setShowMyInquiriesModal(true);
                      } catch (err: any) {
                        toast.error(err.message || '문의 생성에 실패했습니다');
                      }
                    }}
                    className="text-xs bg-[#92400E]/10 border border-[#92400E]/30 text-[#92400E] px-3 py-1 rounded-full hover:bg-[#92400E]/20 transition-colors whitespace-nowrap"
                    data-testid="button-deposit-inquiry"
                  >
                    계좌번호 문의하기
                  </button>
                </div>
              </div>

              {/* 보내시는 분 */}
              <div className="mb-4">
                <label className="block text-gray-600 text-sm mb-2">보내시는 분 <span className="text-red-400">*</span></label>
                <Input
                  type="text"
                  value={depositSenderName}
                  onChange={(e) => setDepositSenderName(e.target.value)}
                  placeholder="실제 송금 통장의 예금주 성함 입력"
                  className="bg-gray-50 border-gray-200 text-gray-900 placeholder:text-gray-500"
                  data-testid="input-deposit-sender"
                />
              </div>

              {/* 예치 금액 */}
              <div className="mb-4">
                <label className="block text-gray-600 text-sm mb-2">예치 금액 <span className="text-red-400">*</span></label>
                <div className="relative">
                  <Input
                    type="text"
                    value={depositAmount}
                    onChange={(e) => setDepositAmount(e.target.value.replace(/[^0-9]/g, ''))}
                    placeholder="금액을 입력하세요"
                    className="bg-gray-50 border-gray-200 text-gray-900 pr-12"
                    data-testid="input-deposit-amount"
                  />
                  <span className="absolute right-4 top-1/2 -translate-y-1/2 text-gray-500">원</span>
                </div>
                {depositAmount && <p className="text-xs mt-1" style={{color:"#aaa"}}>{Number(depositAmount).toLocaleString()}원</p>}
              </div>

              {/* 빠른 금액 */}
              <div className="grid grid-cols-4 gap-2 mb-2">
                {[10000, 50000, 100000, 500000].map((amt) => (
                  <button key={amt} onClick={() => setDepositAmount(String(Number(depositAmount || 0) + amt))}
                    className="py-2 bg-gray-100 hover:bg-gray-200 text-gray-600 text-xs rounded transition-colors" data-testid={`button-deposit-quick-${amt}`}>
                    +{amt / 10000}만
                  </button>
                ))}
              </div>
              <div className="grid grid-cols-2 gap-2 mb-5">
                <button onClick={() => setDepositAmount(String(Number(depositAmount || 0) + 1000000))}
                  className="py-2 bg-gray-100 hover:bg-gray-200 text-gray-600 text-xs rounded transition-colors" data-testid="button-deposit-quick-100">
                  +100만
                </button>
                <button onClick={() => setDepositAmount('')}
                  className="py-2 bg-gray-100 hover:bg-gray-200 text-gray-600 text-xs rounded transition-colors" data-testid="button-deposit-reset">
                  초기화
                </button>
              </div>

              {/* 예치신청 버튼 */}
              <Button
                className="w-full bg-green-600 hover:bg-green-700 text-gray-900 font-bold mb-6"
                disabled={depositSubmitting || !depositAmount || Number(depositAmount) <= 0 || !depositSenderName.trim()}
                data-testid="button-deposit-submit"
                onClick={async () => {
                  if (!depositSenderName.trim()) { toast.error('보내시는 분 성함을 입력해주세요'); return; }
                  if (!depositAmount || Number(depositAmount) <= 0) { toast.error('금액을 입력해주세요'); return; }
                  if (Number(depositAmount) < 10000) { toast.error('최소 예치금액은 10,000원입니다'); return; }
                  setDepositSubmitting(true);
                  try {
                    const res = await fetch('/api/transactions', {
                      method: 'POST',
                      headers: { 'Content-Type': 'application/json' },
                      body: JSON.stringify({ type: 'deposit', amount: depositAmount, senderName: depositSenderName.trim() }),
                    });
                    const data = await res.json();
                    if (!res.ok) throw new Error(data.error || '요청에 실패했습니다');

                    toast.success('예치 신청이 완료되었습니다.');
                    setDepositAmount('');
                    setDepositSenderName('');
                    setShowDepositPageModal(false);
                    refetchTransactions();
                  } catch (err: any) {
                    toast.error(err.message || '요청에 실패했습니다');
                  } finally {
                    setDepositSubmitting(false);
                  }
                }}
              >
                {depositSubmitting ? '처리중...' : '예치신청'}
              </Button>

              {/* 최근 예치 내역 */}
              <div>
                <h3 className="text-sm font-bold text-gray-600 mb-3">최근 예치 내역</h3>
                {(() => {
                  const depositHistory = (myTransactions || []).filter((t: any) => t.type === 'deposit').slice(0, 5);
                  if (depositHistory.length === 0) {
                    return <p className="text-gray-500 text-xs text-center py-4">예치 내역이 없습니다</p>;
                  }
                  return (
                    <div className="rounded-lg overflow-hidden border border-gray-200">
                      <table className="w-full text-xs">
                        <thead>
                          <tr className="bg-gray-50">
                            <th className="text-left text-gray-500 px-3 py-2">신청금액</th>
                            <th className="text-center text-gray-500 px-3 py-2">상태</th>
                            <th className="text-right text-gray-500 px-3 py-2">신청일</th>
                          </tr>
                        </thead>
                        <tbody>
                          {depositHistory.map((t: any) => (
                            <tr key={t.id} className="border-t border-gray-100">
                              <td className="px-3 py-2 text-gray-900 font-medium">{Number(t.amount).toLocaleString()}원</td>
                              <td className="px-3 py-2 text-center">
                                <span className={`px-2 py-0.5 rounded-full text-xs ${
                                  t.status === 'approved' ? 'bg-green-500/20 text-green-400' :
                                  t.status === 'rejected' ? 'bg-red-500/20 text-red-400' :
                                  'bg-yellow-500/20 text-yellow-400'
                                }`}>
                                  {t.status === 'approved' ? '승인' : t.status === 'rejected' ? '거절' : '대기'}
                                </span>
                              </td>
                              <td className="px-3 py-2 text-right text-gray-500">
                                {new Date(t.createdAt).toLocaleDateString('ko-KR', { month: '2-digit', day: '2-digit', hour: '2-digit', minute: '2-digit', timeZone: 'Asia/Seoul' })}
                              </td>
                            </tr>
                          ))}
                        </tbody>
                      </table>
                    </div>
                  );
                })()}
              </div>
            </div>
          </div>
        </DialogContent>
      </Dialog>

      {/* ===== 환급 신청 모달 ===== */}
      <Dialog open={showWithdrawalPageModal} onOpenChange={(open) => { if (!open) { setShowWithdrawalPageModal(false); setWithdrawalAmount(''); } }}>
        <DialogContent className="sm:max-w-lg p-0 bg-transparent border-none shadow-none [&>button]:hidden max-h-[90vh] overflow-y-auto overflow-x-hidden">
          <DialogTitle className="sr-only">환급 신청</DialogTitle>
          <div className="relative overflow-x-hidden">
            <div style={{background:"#FAF9F6",border:"1px solid rgba(196,160,40,0.22)",borderTop:"3px solid #C4A028",borderRadius:8,padding:"clamp(16px,4vw,24px)",position:"relative",boxShadow:"0 20px 60px rgba(0,0,0,0.18)"}}>
              {/* 헤더 */}
              <div className="flex items-center justify-between mb-5">
                <button onClick={() => { setShowWithdrawalPageModal(false); setWithdrawalAmount(''); }}
                  className="flex items-center gap-2 transition-colors" style={{color:"#888"}}>
                  <ChevronRight className="w-5 h-5 rotate-180" />
                  <span className="text-sm">뒤로가기</span>
                </button>
                <h2 className="text-lg font-bold" style={{color:"#111111"}}>환급 신청</h2>
                <button onClick={() => { setShowWithdrawalPageModal(false); setWithdrawalAmount(''); }}
                  className="transition-colors" style={{color:"#999"}}>
                  <X className="w-5 h-5" />
                </button>
              </div>

              {/* 현재 보유금액 */}
              <div className="rounded p-3 mb-5" style={{background:"rgba(196,160,40,0.06)",border:"1px solid rgba(196,160,40,0.22)"}}>
                <div className="flex items-center justify-between">
                  <span className="text-sm" style={{color:"#888"}}>현재 보유금액</span>
                  <span className="text-xl font-bold" style={{color:"#111111"}}>{balanceData?.balance ? Number(balanceData.balance).toLocaleString() : '0'}원</span>
                </div>
              </div>

              {/* 환급 진행 절차 STEP 1~4 */}
              <div className="rounded p-4 mb-5" style={{background:"#F3F2EF",border:"1px solid #EEEEEE"}}>
                <h3 className="text-sm font-bold text-blue-400 mb-3">환급 진행 절차</h3>
                <div className="space-y-3">
                  {[
                    { step: '1', text: '환급 처리는 영업 시간(평일 오전09:00~21:00)내 순차적으로 진행됩니다. 신청즉시 보유금액에서 우선 차감됩니다.' },
                    { step: '2', text: '24시간 이상 지연 시, 등록된 환급 계좌 정보(은행명,계좌번호,예금주 성명)가 실제 계좌와 일치하는지 확인해 주세요.' },
                    { step: '3', text: '환급신청 버튼 클릭 후 운영팀 검수를 거쳐 은행 이체가 진행됩니다.' },
                  ].map(({ step, text }) => (
                    <div key={step} className="flex gap-3">
                      <span className="shrink-0 w-8 h-8 rounded-full bg-blue-500/20 border border-blue-500/40 flex items-center justify-center text-blue-400 text-xs font-bold">{step}</span>
                      <p className="text-xs leading-relaxed pt-1" style={{color:"#888"}}>{text}</p>
                    </div>
                  ))}
                </div>
              </div>

              {/* 환급 계좌 정보 (읽기전용) */}
              <div className="bg-gray-50 border border-gray-200 rounded-xl p-4 mb-5 space-y-3">
                <h3 className="text-sm font-bold text-gray-600 mb-1">환급 계좌 정보</h3>
                {!user?.bankName && !user?.accountNumber ? (
                  <div className="text-center py-2">
                    <p className="text-yellow-400 text-xs mb-2">등록된 환급 계좌가 없습니다.</p>
                    <button onClick={() => { setShowWithdrawalPageModal(false); openMyPage(); }}
                      className="text-[#92400E] text-xs underline hover:text-[#C4A028] transition-colors">
                      마이페이지에서 계좌 등록하기
                    </button>
                  </div>
                ) : (
                  <>
                    <div className="flex justify-between">
                      <span className="text-xs" style={{color:"#aaa"}}>거래은행</span>
                      <span className="text-gray-900 text-xs font-medium">{user?.bankName || '-'}</span>
                    </div>
                    <div className="flex justify-between">
                      <span className="text-xs" style={{color:"#aaa"}}>계좌번호</span>
                      <span className="text-gray-900 text-xs font-medium">{user?.accountNumber || '-'}</span>
                    </div>
                    <div className="flex justify-between">
                      <span className="text-xs" style={{color:"#aaa"}}>예금주</span>
                      <span className="text-gray-900 text-xs font-medium">{user?.accountHolder || '-'}</span>
                    </div>
                  </>
                )}
              </div>

              {/* 환급 가능액 */}
              <div className="flex justify-between items-center bg-gray-50 border border-gray-200 rounded-xl px-4 py-3 mb-4">
                <span className="text-sm" style={{color:"#888"}}>환급가능액</span>
                <span className="text-gray-900 font-bold">{balanceData?.balance ? Number(balanceData.balance).toLocaleString() : '0'}원</span>
              </div>

              {/* 환급 금액 */}
              <div className="mb-4">
                <label className="block text-gray-600 text-sm mb-2">환급 금액 <span className="text-red-400">*</span></label>
                <div className="relative">
                  <Input
                    type="text"
                    value={withdrawalAmount}
                    onChange={(e) => setWithdrawalAmount(e.target.value.replace(/[^0-9]/g, ''))}
                    placeholder="금액을 입력하세요"
                    className="bg-gray-50 border-gray-200 text-gray-900 pr-12"
                    data-testid="input-withdrawal-amount"
                  />
                  <span className="absolute right-4 top-1/2 -translate-y-1/2 text-gray-500">원</span>
                </div>
                {withdrawalAmount && <p className="text-xs mt-1" style={{color:"#aaa"}}>{Number(withdrawalAmount).toLocaleString()}원</p>}
                {withdrawalAmount && Number(withdrawalAmount) > Number(balanceData?.balance || 0) && (
                  <p className="text-red-400 text-xs mt-1">보유금액을 초과할 수 없습니다</p>
                )}
              </div>

              {/* 빠른 금액 */}
              <div className="grid grid-cols-4 gap-2 mb-2">
                {[10000, 50000, 100000, 500000].map((amt) => (
                  <button key={amt} onClick={() => setWithdrawalAmount(String(Math.min(Number(withdrawalAmount || 0) + amt, Number(balanceData?.balance || 0))))}
                    className="py-2 bg-gray-100 hover:bg-gray-200 text-gray-600 text-xs rounded transition-colors" data-testid={`button-withdrawal-quick-${amt}`}>
                    +{amt / 10000}만
                  </button>
                ))}
              </div>
              <div className="grid grid-cols-2 gap-2 mb-5">
                <button onClick={() => setWithdrawalAmount(String(balanceData?.balance ? Math.floor(Number(balanceData.balance)) : 0))}
                  className="py-2 bg-gray-100 hover:bg-gray-200 text-gray-600 text-xs rounded transition-colors" data-testid="button-withdrawal-all">
                  전액
                </button>
                <button onClick={() => setWithdrawalAmount('')}
                  className="py-2 bg-gray-100 hover:bg-gray-200 text-gray-600 text-xs rounded transition-colors" data-testid="button-withdrawal-reset">
                  초기화
                </button>
              </div>

              {/* 환급신청 버튼 */}
              <Button
                className="w-full bg-blue-600 hover:bg-blue-700 text-gray-900 font-bold"
                disabled={
                  withdrawalSubmitting ||
                  !withdrawalAmount ||
                  Number(withdrawalAmount) <= 0 ||
                  Number(withdrawalAmount) > Number(balanceData?.balance || 0) ||
                  (!user?.bankName && !user?.accountNumber)
                }
                data-testid="button-withdrawal-submit"
                onClick={async () => {
                  if (!user?.bankName && !user?.accountNumber) { toast.error('환급 계좌를 먼저 등록해주세요'); return; }
                  if (!withdrawalAmount || Number(withdrawalAmount) <= 0) { toast.error('금액을 입력해주세요'); return; }
                  if (Number(withdrawalAmount) < 10000) { toast.error('최소 환급금액은 10,000원입니다'); return; }
                  if (Number(withdrawalAmount) > Number(balanceData?.balance || 0)) { toast.error('보유금액을 초과할 수 없습니다'); return; }
                  setWithdrawalSubmitting(true);
                  try {
                    const res = await fetch('/api/transactions', {
                      method: 'POST',
                      headers: { 'Content-Type': 'application/json' },
                      body: JSON.stringify({ type: 'withdrawal', amount: withdrawalAmount }),
                    });
                    const data = await res.json();
                    if (!res.ok) throw new Error(data.error || '요청에 실패했습니다');
                    setWithdrawalSuccessAmount(withdrawalAmount);
                    setShowWithdrawalPageModal(false);
                    setWithdrawalAmount('');
                    refetchBalance();
                    setShowWithdrawalSuccessModal(true);
                  } catch (err: any) {
                    toast.error(err.message || '요청에 실패했습니다');
                  } finally {
                    setWithdrawalSubmitting(false);
                  }
                }}
              >
                {withdrawalSubmitting ? '처리중...' : '환급신청'}
              </Button>

              {/* 최근 환급 내역 */}
              <div className="mt-4">
                <h3 className="text-sm font-bold text-gray-600 mb-3">최근 환급 내역</h3>
                {(() => {
                  const withdrawalHistory = (myTransactions || []).filter((t: any) => t.type === 'withdrawal').slice(0, 5);
                  if (withdrawalHistory.length === 0) {
                    return <p className="text-gray-500 text-xs text-center py-4">환급 내역이 없습니다</p>;
                  }
                  return (
                    <div className="rounded-lg overflow-hidden border border-gray-200">
                      <table className="w-full text-xs">
                        <thead>
                          <tr className="bg-gray-50">
                            <th className="text-left text-gray-500 px-3 py-2">신청금액</th>
                            <th className="text-center text-gray-500 px-3 py-2">상태</th>
                            <th className="text-right text-gray-500 px-3 py-2">신청일</th>
                          </tr>
                        </thead>
                        <tbody>
                          {withdrawalHistory.map((t: any) => (
                            <tr key={t.id} className="border-t border-gray-100">
                              <td className="px-3 py-2 text-gray-900 font-medium">{Number(t.amount).toLocaleString()}원</td>
                              <td className="px-3 py-2 text-center">
                                <span className={`px-2 py-0.5 rounded-full text-xs ${
                                  t.status === 'approved' ? 'bg-green-500/20 text-green-400' :
                                  t.status === 'rejected' ? 'bg-red-500/20 text-red-400' :
                                  t.status === 'hold' ? 'bg-orange-500/20 text-orange-400' :
                                  'bg-yellow-500/20 text-yellow-400'
                                }`}>
                                  {t.status === 'approved' ? '승인' : t.status === 'rejected' ? '거절' : t.status === 'hold' ? '보류' : '대기'}
                                </span>
                              </td>
                              <td className="px-3 py-2 text-right text-gray-500">
                                {new Date(t.createdAt).toLocaleDateString('ko-KR', { month: '2-digit', day: '2-digit', hour: '2-digit', minute: '2-digit', timeZone: 'Asia/Seoul' })}
                              </td>
                            </tr>
                          ))}
                        </tbody>
                      </table>
                    </div>
                  );
                })()}
              </div>
            </div>
          </div>
        </DialogContent>
      </Dialog>

      {/* Customer Service Modal - 고객센터 메뉴 */}
      <Dialog open={showCustomerServiceModal} onOpenChange={(open) => { setShowCustomerServiceModal(open); if (open) refetchInquiries(); }}>
        <DialogContent className="sm:max-w-lg p-0 bg-transparent border-none shadow-none [&>button]:hidden">
          <DialogTitle className="sr-only">고객센터</DialogTitle>
          <div className="relative">
            <div style={{background:"#FAF9F6",border:"1px solid rgba(196,160,40,0.22)",borderTop:"3px solid #C4A028",borderRadius:8,padding:"clamp(16px,4vw,24px)",position:"relative",boxShadow:"0 20px 60px rgba(0,0,0,0.18)"}}>
              <button 
                onClick={() => setShowCustomerServiceModal(false)}
                className="absolute top-4 right-4 transition-colors z-10" style={{color:"#999"}} onMouseEnter={e=>(e.currentTarget.style.color="#C4A028")} onMouseLeave={e=>(e.currentTarget.style.color="rgba(255,255,255,0.4)")}
              >
                <X className="w-5 h-5" />
              </button>
              
              <div className="text-center mb-6">
                <div className="flex items-center justify-center gap-2 mb-3">
                  <Headphones className="w-8 h-8" style={{color:"#C4A028"}} />
                </div>
                <h2 className="text-xl font-bold mb-1" style={{color:"#111111"}}>고객센터</h2>
                <p className="text-sm" style={{color:"#888"}}>문의를 남기시면 빠르게 답변드립니다</p>
              </div>

              <div className="space-y-3">
                {/* 문의 작성하기 */}
                <button 
                  className="w-full block rounded p-4 transition-colors cursor-pointer text-left" style={{background:"rgba(196,160,40,0.04)",border:"1px solid rgba(196,160,40,0.2)"}}
                  onClick={() => {
                    if (!user) {
                      toast.error("로그인이 필요합니다");
                      setShowCustomerServiceModal(false);
                      setShowLoginModal(true);
                      return;
                    }
                    const hasPending = myInquiries.some(inq => inq.status === 'pending');
                    if (hasPending) {
                      toast.error("이전 문의에 답변이 완료된 후 새로운 문의를 작성할 수 있습니다.");
                      return;
                    }
                    setShowCustomerServiceModal(false);
                    setShowInquiryFormModal(true);
                  }}
                >
                  <div className="flex items-center gap-4">
                    <div className="w-12 h-12 rounded flex items-center justify-center" style={{background:"rgba(196,160,40,0.08)",border:"1px solid rgba(196,160,40,0.2)"}}>
                      <FileText className="w-6 h-6" style={{color:"#C4A028"}} />
                    </div>
                    <div className="flex-1">
                      <h3 className="font-medium" style={{color:"#111111"}}>문의 작성하기</h3>
                      <p className="text-sm" style={{color:"rgba(196,160,40,0.8)"}}>새로운 문의를 작성합니다</p>
                      <p className="text-xs" style={{color:"#aaa"}}>빠른 답변 보장</p>
                    </div>
                    <div style={{color:"#C4A028"}}>
                      <ChevronRight className="w-5 h-5" />
                    </div>
                  </div>
                </button>

                {/* 내 문의 내역 */}
                <button 
                  className="w-full block rounded p-4 transition-colors cursor-pointer text-left" style={{background:"#F3F2EF",border:"1px solid #EEEEEE"}}
                  onClick={() => {
                    if (!user) {
                      toast.error("로그인이 필요합니다");
                      setShowCustomerServiceModal(false);
                      setShowLoginModal(true);
                      return;
                    }
                    setShowCustomerServiceModal(false);
                    setShowMyInquiriesModal(true);
                  }}
                >
                  <div className="flex items-center gap-4">
                    <div className="w-12 h-12 rounded flex items-center justify-center" style={{background:"rgba(196,160,40,0.08)",border:"1px solid rgba(196,160,40,0.2)"}}>
                      <MessageCircle className="w-6 h-6" style={{color:"#C4A028"}} />
                    </div>
                    <div className="flex-1">
                      <h3 className="font-medium" style={{color:"#111111"}}>내 문의 내역</h3>
                      <p className="text-sm" style={{color:"rgba(196,160,40,0.8)"}}>작성한 문의와 답변 확인</p>
                      <p className="text-xs" style={{color:"#aaa"}}>{myInquiries.length}건의 문의</p>
                    </div>
                    <div style={{color:"#C4A028"}}>
                      <ChevronRight className="w-5 h-5" />
                    </div>
                  </div>
                </button>

                {/* 입환급 내역 */}
                <button
                  className="w-full block rounded p-4 transition-colors cursor-pointer text-left" style={{background:"#F3F2EF",border:"1px solid #EEEEEE"}}
                  onClick={() => {
                    if (!user) {
                      toast.error("로그인이 필요합니다");
                      setShowCustomerServiceModal(false);
                      setShowLoginModal(true);
                      return;
                    }
                    setShowCustomerServiceModal(false);
                    refetchTransactions().then(() => setShowTransactionsModal(true));
                  }}
                  data-testid="button-my-transactions"
                >
                  <div className="flex items-center gap-4">
                    <div className="w-12 h-12 rounded flex items-center justify-center" style={{background:"rgba(196,160,40,0.08)",border:"1px solid rgba(196,160,40,0.2)"}}>
                      <History className="w-6 h-6 text-[#C4A028]" />
                    </div>
                    <div className="flex-1">
                      <h3 className="font-medium" style={{color:"#111111"}}>입환급 내역</h3>
                      <p className="text-sm" style={{color:"rgba(196,160,40,0.8)"}}>예치·환급 신청 및 처리 현황</p>
                      <p className="text-xs" style={{color:"#aaa"}}>{myTransactions.length}건의 거래 내역</p>
                    </div>
                    <div style={{color:"#C4A028"}}>
                      <ChevronRight className="w-5 h-5" />
                    </div>
                  </div>
                </button>

                {/* 고객센터 (텔레그램) */}
                {telegramData?.telegramLink && (
                  <a 
                    href={telegramData.telegramLink}
                    target="_blank"
                    rel="noopener noreferrer"
                    className="w-full block rounded p-4 transition-colors cursor-pointer text-left" style={{background:"#F3F2EF",border:"1px solid #EEEEEE"}}
                    onClick={() => setShowCustomerServiceModal(false)}
                  >
                    <div className="flex items-center gap-4">
                      <div className="w-12 h-12 rounded flex items-center justify-center" style={{background:"rgba(196,160,40,0.08)",border:"1px solid rgba(196,160,40,0.2)"}}>
                        <Phone className="w-6 h-6" style={{color:"#C4A028"}} />
                      </div>
                      <div className="flex-1">
                        <h3 className="font-medium" style={{color:"#111111"}}>텔레그램 고객센터</h3>
                        <p className="text-sm" style={{color:"rgba(196,160,40,0.75)"}}>텔레그램으로 바로 문의</p>
                        <p className="text-xs" style={{color:"#aaa"}}>실시간 상담 가능</p>
                      </div>
                      <div style={{color:"#C4A028"}}>
                        <ChevronRight className="w-5 h-5" />
                      </div>
                    </div>
                  </a>
                )}

                {/* 고객센터 (카카오톡) */}
                {kakaoData?.kakaoLink && (
                  <a 
                    href={kakaoData.kakaoLink}
                    target="_blank"
                    rel="noopener noreferrer"
                    className="w-full block bg-gradient-to-r from-yellow-500/10 to-amber-500/10 border border-yellow-500/30 rounded-xl p-4 hover:border-yellow-500/50 transition-colors cursor-pointer text-left"
                    onClick={() => setShowCustomerServiceModal(false)}
                    data-testid="link-kakao"
                  >
                    <div className="flex items-center gap-4">
                      <div className="w-12 h-12 bg-yellow-500/20 rounded-full flex items-center justify-center">
                        <MessageCircle className="w-6 h-6 text-yellow-500" />
                      </div>
                      <div className="flex-1">
                        <h3 className="font-medium" style={{color:"#111111"}}>카카오톡 고객센터</h3>
                        <p className="text-yellow-400 text-sm">카카오톡으로 바로 문의</p>
                        <p className="text-xs" style={{color:"#aaa"}}>실시간 상담 가능</p>
                      </div>
                      <div className="text-yellow-500">
                        <ChevronRight className="w-5 h-5" />
                      </div>
                    </div>
                  </a>
                )}
              </div>
            </div>
          </div>
        </DialogContent>
      </Dialog>

      {/* Withdrawal Success Modal */}
      <AlertDialog open={showWithdrawalSuccessModal} onOpenChange={setShowWithdrawalSuccessModal}>
        <AlertDialogContent className="bg-[#FAF9F6] border border-gray-200">
          <AlertDialogHeader>
            <AlertDialogTitle className="text-gray-900 flex items-center gap-2">
              <div className="w-10 h-10 bg-green-500/20 rounded-full flex items-center justify-center">
                <Check className="w-5 h-5 text-green-500" />
              </div>
              환급 신청 완료
            </AlertDialogTitle>
            <AlertDialogDescription className="text-gray-500 space-y-3">
              <p className="text-lg">
                <span className="text-green-400 font-bold">{Number(withdrawalSuccessAmount).toLocaleString()}원</span> 환급 신청이 완료되었습니다.
              </p>
              <p>처리까지 약 30분이 소요됩니다.</p>
              <p className="text-sm text-gray-500">가입 시 등록한 계좌로 예치됩니다.</p>
            </AlertDialogDescription>
          </AlertDialogHeader>
          <AlertDialogFooter>
            <AlertDialogAction 
              onClick={() => setShowWithdrawalSuccessModal(false)}
              className="text-white font-semibold" style={{background:"#C4A028",border:"none",borderRadius:4}}
            >
              확인
            </AlertDialogAction>
          </AlertDialogFooter>
        </AlertDialogContent>
      </AlertDialog>

      {/* Inquiry Form Modal - 문의 작성 */}
      <Dialog open={showInquiryFormModal} onOpenChange={setShowInquiryFormModal}>
        <DialogContent className="sm:max-w-lg p-0 bg-transparent border-none shadow-none [&>button]:hidden">
          <DialogTitle className="sr-only">문의 작성</DialogTitle>
          <div className="relative">
            <div style={{background:"#FAF9F6",border:"1px solid rgba(196,160,40,0.22)",borderTop:"3px solid #C4A028",borderRadius:8,padding:"clamp(16px,4vw,24px)",position:"relative",boxShadow:"0 20px 60px rgba(0,0,0,0.18)"}}>
              <button 
                onClick={() => setShowInquiryFormModal(false)}
                className="absolute top-4 right-4 transition-colors z-10" style={{color:"#999"}} onMouseEnter={e=>(e.currentTarget.style.color="#C4A028")} onMouseLeave={e=>(e.currentTarget.style.color="rgba(255,255,255,0.4)")}
              >
                <X className="w-5 h-5" />
              </button>
              
              <div className="text-center mb-6">
                <div className="flex items-center justify-center gap-2 mb-3">
                  <FileText className="w-8 h-8" style={{color:"#C4A028"}} />
                </div>
                <h2 className="text-xl font-bold mb-1" style={{color:"#111111"}}>문의 작성</h2>
                <p className="text-sm" style={{color:"#888"}}>문의를 남기시면 빠르게 답변드립니다</p>
              </div>

              <div className="space-y-4">
                <div>
                  <label className="block text-sm text-gray-500 mb-2">제목</label>
                  <input
                    type="text"
                    placeholder="문의 제목을 입력해주세요"
                    value={inquiryTitle}
                    onChange={(e) => setInquiryTitle(e.target.value)}
                    className="w-full bg-gray-50 border border-gray-200 rounded-lg px-4 py-3 text-gray-900 placeholder-gray-400 focus:outline-none focus:border-[#F59E0B]"
                    data-testid="input-inquiry-title"
                  />
                </div>
                <div>
                  <label className="block text-sm text-gray-500 mb-2">내용</label>
                  <textarea
                    placeholder="문의 내용을 자세히 작성해주세요"
                    value={inquiryContent}
                    onChange={(e) => setInquiryContent(e.target.value)}
                    rows={5}
                    className="w-full bg-gray-50 border border-gray-200 rounded-lg px-4 py-3 text-gray-900 placeholder-gray-400 focus:outline-none focus:border-[#F59E0B] resize-none"
                    data-testid="input-inquiry-content"
                  />
                </div>
                <Button
                  className="w-full bg-[#C4A028] hover:opacity-90 text-white font-semibold py-3"
                  disabled={inquirySubmitting || !inquiryTitle.trim() || !inquiryContent.trim()}
                  onClick={async () => {
                    try {
                      setInquirySubmitting(true);
                      const res = await fetch('/api/inquiries', {
                        method: 'POST',
                        headers: { 'Content-Type': 'application/json' },
                        body: JSON.stringify({ title: inquiryTitle, content: inquiryContent }),
                      });
                      const data = await res.json();
                      if (!res.ok) {
                        throw new Error(data.error || '문의 등록에 실패했습니다');
                      }
                      toast.success('문의가 등록되었습니다. 빠른 시일 내에 답변드리겠습니다.');
                      setInquiryTitle('');
                      setInquiryContent('');
                      setShowInquiryFormModal(false);
                      refetchInquiries();
                      setShowMyInquiriesModal(true);
                    } catch (error: any) {
                      toast.error(error.message || '문의 등록에 실패했습니다');
                    } finally {
                      setInquirySubmitting(false);
                    }
                  }}
                  data-testid="button-submit-inquiry"
                >
                  {inquirySubmitting ? '등록 중...' : '문의 등록하기'}
                </Button>
              </div>
            </div>
          </div>
        </DialogContent>
      </Dialog>

      {/* My Inquiries Modal - 내 문의 내역 */}
      <Dialog open={showMyInquiriesModal} onOpenChange={setShowMyInquiriesModal}>
        <DialogContent className="sm:max-w-lg p-0 bg-transparent border-none shadow-none [&>button]:hidden">
          <DialogTitle className="sr-only">내 문의 내역</DialogTitle>
          <div className="relative">
            <div style={{background:"#FAF9F6",border:"1px solid rgba(196,160,40,0.22)",borderTop:"3px solid #C4A028",borderRadius:8,padding:"clamp(16px,4vw,24px)",position:"relative",boxShadow:"0 20px 60px rgba(0,0,0,0.18)"}}>
              <button 
                onClick={() => setShowMyInquiriesModal(false)}
                className="absolute top-4 right-4 transition-colors z-10" style={{color:"#999"}} onMouseEnter={e=>(e.currentTarget.style.color="#C4A028")} onMouseLeave={e=>(e.currentTarget.style.color="rgba(255,255,255,0.4)")}
              >
                <X className="w-5 h-5" />
              </button>
              
              <div className="text-center mb-6">
                <div className="flex items-center justify-center gap-2 mb-3">
                  <MessageCircle className="w-8 h-8" style={{color:"#C4A028"}} />
                </div>
                <div className="flex items-center justify-center gap-2 mb-1">
                  <h2 className="text-xl font-bold" style={{color:"#111111"}}>내 문의 내역</h2>
                  <button
                    onClick={() => refetchInquiries()}
                    className="p-1.5 text-gray-500 hover:text-[#92400E] hover:bg-[#92400E]/10 rounded-lg transition-colors"
                    title="새로고침"
                    data-testid="button-refresh-inquiries"
                  >
                    <RefreshCw className="w-5 h-5" />
                  </button>
                </div>
                <p className="text-sm" style={{color:"#888"}}>총 {myInquiries.length}건의 문의</p>
              </div>

              <div className="space-y-3">
                {myInquiries.length === 0 ? (
                  <p className="text-sm py-8 text-center" style={{color:"#aaa"}}>등록된 문의가 없습니다</p>
                ) : (
                  myInquiries.map((inquiry) => (
                    <div key={inquiry.id} className="rounded p-4" style={{background:"rgba(255,255,255,0.04)",border:"1px solid rgba(196,160,40,0.2)"}}>
                      <div className="flex items-start justify-between mb-2">
                        <h3 className="font-medium" style={{color:"#111111"}}>{inquiry.title}</h3>
                        <span className={`px-2 py-0.5 rounded text-xs font-medium ${
                          inquiry.status === 'answered' 
                            ? 'bg-red-500/20 text-red-400' 
                            : 'bg-[#92400E]/10 text-[#92400E]'
                        }`}>
                          {inquiry.status === 'answered' ? '답변완료' : '대기중'}
                        </span>
                      </div>
                      <p className="text-gray-500 text-sm mb-2 whitespace-pre-wrap">{inquiry.content}</p>
                      <p className="text-xs mb-3" style={{color:"#aaa"}}>
                        {new Date(inquiry.createdAt).toLocaleDateString('ko-KR', {
                          year: 'numeric',
                          month: '2-digit',
                          day: '2-digit',
                          hour: '2-digit',
                          minute: '2-digit'
                        })}
                      </p>
                      
                      {inquiry.reply && (
                        <div className="mt-3 pt-3 border-t border-gray-200">
                          <div className="flex items-center gap-2 mb-2">
                            <span className="text-[#92400E] text-sm font-medium">고객센터</span>
                            {inquiry.repliedAt && (
                              <span className="text-xs" style={{color:"#aaa"}}>
                                {new Date(inquiry.repliedAt).toLocaleDateString('ko-KR', {
                                  year: 'numeric',
                                  month: '2-digit',
                                  day: '2-digit',
                                  hour: '2-digit',
                                  minute: '2-digit'
                                })}
                              </span>
                            )}
                          </div>
                          <p className="text-gray-600 text-sm whitespace-pre-wrap bg-[#92400E]/10 p-3 rounded-lg">{inquiry.reply}</p>
                        </div>
                      )}
                    </div>
                  ))
                )}
              </div>
              
              <Button
                className="w-full mt-4 bg-[#C4A028] hover:opacity-90 text-white font-semibold"
                onClick={() => {
                  setShowMyInquiriesModal(false);
                  setShowInquiryFormModal(true);
                }}
              >
                새 문의 작성하기
              </Button>
            </div>
          </div>
        </DialogContent>
      </Dialog>

      {/* Transactions Modal - 입환급 내역 */}
      <Dialog open={showTransactionsModal} onOpenChange={(open) => { setShowTransactionsModal(open); if (open) refetchTransactions(); }}>
        <DialogContent className="sm:max-w-lg p-0 bg-transparent border-none shadow-none [&>button]:hidden">
          <DialogTitle className="sr-only">입환급 내역</DialogTitle>
          <div className="relative">
            <div className="relative backdrop-blur-xl bg-[#FAF9F6] border border-gray-200 rounded-2xl p-6 shadow-2xl max-h-[85vh] flex flex-col">
              <button
                onClick={() => setShowTransactionsModal(false)}
                className="absolute top-4 right-4 transition-colors z-10" style={{color:"#999"}} onMouseEnter={e=>(e.currentTarget.style.color="#C4A028")} onMouseLeave={e=>(e.currentTarget.style.color="rgba(255,255,255,0.4)")}
              >
                <X className="w-5 h-5" />
              </button>

              {/* Header */}
              <div className="text-center mb-5">
                <div className="flex items-center justify-center gap-2 mb-3">
                  <History className="w-8 h-8" style={{color:"#C4A028"}} />
                </div>
                <div className="flex items-center justify-center gap-2 mb-1">
                  <h2 className="text-xl font-bold" style={{color:"#111111"}}>입환급 내역</h2>
                  <button
                    onClick={() => refetchTransactions()}
                    className="p-1.5 text-gray-500 hover:text-[#92400E] hover:bg-[#92400E]/10 rounded-lg transition-colors"
                    title="새로고침"
                  >
                    <RefreshCw className="w-5 h-5" />
                  </button>
                </div>
                <p className="text-sm" style={{color:"#888"}}>총 {myTransactions.length}건의 거래 내역</p>
              </div>

              {/* Filter Tabs */}
              <div className="flex gap-2 mb-4">
                {(['all', 'deposit', 'withdrawal'] as const).map((f) => (
                  <button
                    key={f}
                    onClick={() => setTransactionFilter(f)}
                    className={`flex-1 py-2 rounded-lg text-sm font-medium transition-all ${
                      transactionFilter === f
                        ? 'bg-gradient-to-r from-[#92400E] to-[#F59E0B] text-white'
                        : 'bg-gray-100 text-gray-500 hover:bg-gray-200'
                    }`}
                    data-testid={`tab-transaction-${f}`}
                  >
                    {f === 'all' ? '전체' : f === 'deposit' ? '예치' : '환급'}
                  </button>
                ))}
              </div>

              {/* List */}
              <div className="overflow-y-auto flex-1 space-y-3 pr-1">
                {(() => {
                  const filtered = myTransactions.filter((t: any) =>
                    transactionFilter === 'all' || t.type === transactionFilter
                  );
                  if (filtered.length === 0) {
                    return (
                      <div className="text-center py-12 text-gray-500">
                        <History className="w-12 h-12 mx-auto mb-3 opacity-30" />
                        <p className="text-sm">거래 내역이 없습니다</p>
                      </div>
                    );
                  }
                  const statusMap: Record<string, { label: string; color: string; icon: JSX.Element }> = {
                    pending: { label: '대기중', color: 'text-yellow-400 bg-yellow-500/10 border-yellow-500/30', icon: <Clock className="w-3 h-3" /> },
                    approved: { label: '승인', color: 'text-green-400 bg-green-500/10 border-green-500/30', icon: <CheckCircle className="w-3 h-3" /> },
                    rejected: { label: '거절', color: 'text-red-400 bg-red-500/10 border-red-500/30', icon: <XCircle className="w-3 h-3" /> },
                    hold: { label: '보류', color: 'text-orange-400 bg-orange-500/10 border-orange-500/30', icon: <Clock className="w-3 h-3" /> },
                  };
                  return filtered.map((tx: any) => {
                    const isDeposit = tx.type === 'deposit';
                    const status = statusMap[tx.status] || statusMap.pending;
                    return (
                      <div key={tx.id} className="rounded p-4" style={{background:"rgba(255,255,255,0.04)",border:"1px solid rgba(196,160,40,0.2)"}} data-testid={`tx-item-${tx.id}`}>
                        <div className="flex items-center justify-between mb-2">
                          <div className="flex items-center gap-2">
                            {isDeposit
                              ? <ArrowDownCircle className="w-5 h-5 text-blue-400" />
                              : <ArrowUpCircle className="w-5 h-5 text-red-400" />
                            }
                            <span className={`font-semibold text-base ${isDeposit ? 'text-blue-400' : 'text-red-400'}`}>
                              {isDeposit ? '예치' : '환급'}
                            </span>
                          </div>
                          <span className={`flex items-center gap-1 text-xs px-2 py-1 rounded border ${status.color}`}>
                            {status.icon}{status.label}
                          </span>
                        </div>
                        <div className="flex items-center justify-between">
                          <span className="text-gray-900 font-bold text-lg">
                            {Number(tx.amount).toLocaleString('ko-KR')}원
                          </span>
                          <span className="text-xs" style={{color:"#aaa"}}>
                            {new Date(tx.createdAt).toLocaleString('ko-KR', { timeZone: 'Asia/Seoul',
                              month: '2-digit', day: '2-digit',
                              hour: '2-digit', minute: '2-digit'
                            })}
                          </span>
                        </div>
                        {tx.bankName && (
                          <p className="text-xs mt-1" style={{color:"#aaa"}}>
                            {tx.bankName} · {tx.accountHolder} · {tx.accountNumber}
                          </p>
                        )}
                        {tx.adminNote && (
                          <div className="mt-2 pt-2 border-t border-gray-200">
                            <p className="text-[#92400E] text-xs font-medium mb-0.5">관리자 메모</p>
                            <p className="text-gray-600 text-xs">{tx.adminNote}</p>
                          </div>
                        )}
                      </div>
                    );
                  });
                })()}
              </div>
            </div>
          </div>
        </DialogContent>
      </Dialog>

      {/* Messages Modal - 쪽지함 */}
      <Dialog open={showMessagesModal} onOpenChange={setShowMessagesModal}>
        <DialogContent className="sm:max-w-lg p-0 bg-transparent border-none shadow-none [&>button]:hidden max-h-[90vh] overflow-y-auto">
          <DialogTitle className="sr-only">쪽지함</DialogTitle>
          <div className="relative">
            <div style={{background:"#FAF9F6",border:"1px solid rgba(196,160,40,0.22)",borderTop:"3px solid #C4A028",borderRadius:8,padding:"clamp(16px,4vw,24px)",position:"relative",boxShadow:"0 20px 60px rgba(0,0,0,0.18)"}}>
              <button 
                onClick={() => { setShowMessagesModal(false); setSelectedMessage(null); }}
                className="absolute top-4 right-4 transition-colors z-10" style={{color:"#999"}} onMouseEnter={e=>(e.currentTarget.style.color="#C4A028")} onMouseLeave={e=>(e.currentTarget.style.color="rgba(255,255,255,0.4)")}
              >
                <X className="w-5 h-5" />
              </button>
              
              <div className="text-center mb-6">
                <div className="flex items-center justify-center gap-2 mb-3">
                  <Mail className="w-8 h-8" style={{color:"#C4A028"}} />
                </div>
                <h2 className="text-xl font-bold mb-1" style={{color:"#111111"}}>쪽지함</h2>
                <p className="text-sm" style={{color:"#888"}}>
                  {selectedMessage ? '쪽지 내용' : `총 ${messages.length}건의 쪽지`}
                </p>
              </div>

              {selectedMessage ? (
                <div className="space-y-4">
                  <button
                    onClick={() => setSelectedMessage(null)}
                    className="flex items-center gap-2 text-sm transition-colors" style={{color:"#C4A028"}}
                  >
                    <ChevronRight className="w-4 h-4 rotate-180" />
                    목록으로 돌아가기
                  </button>
                  <div className="rounded p-4" style={{background:"rgba(255,255,255,0.04)",border:"1px solid rgba(196,160,40,0.2)"}}>
                    <div className="flex items-start justify-between mb-3">
                      <h3 className="font-medium text-lg" style={{color:"#111111"}}>{selectedMessage.title}</h3>
                    </div>
                    <p className="text-sm whitespace-pre-wrap break-words mb-3" style={{color:"#555"}}>{selectedMessage.content}</p>
                    <p className="text-xs" style={{color:"#aaa"}}>
                      {new Date(selectedMessage.createdAt).toLocaleDateString('ko-KR', {
                        year: 'numeric',
                        month: '2-digit',
                        day: '2-digit',
                        hour: '2-digit',
                        minute: '2-digit'
                      })}
                    </p>
                  </div>
                </div>
              ) : (
                <div className="space-y-3">
                  {messages.length === 0 ? (
                    <p className="text-sm py-8 text-center" style={{color:"#aaa"}}>받은 쪽지가 없습니다</p>
                  ) : (
                    messages.map((msg) => (
                      <button
                        key={msg.id}
                        onClick={() => handleOpenMessage(msg)}
                        className="w-full text-left rounded p-4 transition-colors" style={{background: msg.isRead ? "#F3F2EF" : "rgba(196,160,40,0.05)", border: msg.isRead ? "1px solid #EEEEEE" : "1px solid rgba(196,160,40,0.3)"}}
                      >
                        <div className="flex items-start justify-between mb-2">
                          <div className="flex items-center gap-2">
                            {!msg.isRead && <span className="w-2 h-2 rounded-full" style={{background:"#C4A028"}} />}
                            <h3 className="font-medium" style={{color: msg.isRead ? "rgba(255,255,255,0.45)" : "#fff"}}>{msg.title}</h3>
                          </div>
                        </div>
                        <p className="text-sm line-clamp-2" style={{color:"#888"}}>{msg.content}</p>
                        <p className="text-xs mt-2" style={{color:"#bbb"}}>
                          {new Date(msg.createdAt).toLocaleDateString('ko-KR', {
                            year: 'numeric',
                            month: '2-digit',
                            day: '2-digit',
                            hour: '2-digit',
                            minute: '2-digit'
                          })}
                        </p>
                      </button>
                    ))
                  )}
                </div>
              )}
            </div>
          </div>
        </DialogContent>
      </Dialog>

      {/* Announcements Modal */}
      <Dialog open={showAnnouncementsModal} onOpenChange={(open) => { setShowAnnouncementsModal(open); if (!open) setSelectedAnnouncement(null); }}>
        <DialogContent className="sm:max-w-lg p-0 bg-transparent border-none shadow-none [&>button]:hidden">
          <DialogTitle className="sr-only">공지사항</DialogTitle>
          <div className="relative">
            <div style={{background:"#FAF9F6",border:"1px solid rgba(196,160,40,0.22)",borderTop:"3px solid #C4A028",borderRadius:8,padding:"clamp(16px,4vw,24px)",position:"relative",boxShadow:"0 20px 60px rgba(0,0,0,0.18)"}}>
              <button 
                onClick={() => { setShowAnnouncementsModal(false); setSelectedAnnouncement(null); }}
                className="absolute top-4 right-4 transition-colors z-10" style={{color:"#999"}} onMouseEnter={e=>(e.currentTarget.style.color="#C4A028")} onMouseLeave={e=>(e.currentTarget.style.color="rgba(255,255,255,0.4)")}
              >
                <X className="w-5 h-5" />
              </button>
              
              <div className="text-center mb-6">
                <div className="flex items-center justify-center gap-2 mb-3">
                  <Bell className="w-8 h-8" style={{color:"#C4A028"}} />
                </div>
                <h2 className="text-xl font-bold mb-1" style={{color:"#111111"}}>공지사항</h2>
                <p className="text-sm" style={{color:"#888"}}>
                  {selectedAnnouncement ? '공지사항 상세' : '중요한 안내사항을 확인하세요'}
                </p>
              </div>

              {selectedAnnouncement ? (
                <div className="space-y-4">
                  <button
                    onClick={() => setSelectedAnnouncement(null)}
                    className="flex items-center gap-2 text-sm transition-colors" style={{color:"#C4A028"}}
                  >
                    <ChevronRight className="w-4 h-4 rotate-180" />
                    목록으로 돌아가기
                  </button>
                  <div className="rounded p-4" style={{background:"rgba(255,255,255,0.04)",border:"1px solid rgba(196,160,40,0.2)"}}>
                    <div className="flex items-start gap-3 mb-2">
                      {selectedAnnouncement.isPinned && (
                        <span className="px-2 py-0.5 rounded text-xs font-medium" style={{background:"rgba(196,160,40,0.15)",color:"#C4A028",border:"1px solid rgba(196,160,40,0.3)"}}>고정</span>
                      )}
                      <h3 className="font-medium text-lg" style={{color:"#111111"}}>{selectedAnnouncement.title}</h3>
                    </div>
                    <p className="text-xs mb-3" style={{color:"#aaa"}}>
                      등록일: {new Date(selectedAnnouncement.displayDate || selectedAnnouncement.createdAt).toLocaleDateString('ko-KR', { year: 'numeric', month: '2-digit', day: '2-digit' })}
                    </p>
                    <div style={{maxHeight:340,overflowY:"auto",paddingRight:4}}>
                      <p className="text-sm whitespace-pre-wrap" style={{color:"#555"}}>{selectedAnnouncement.content}</p>
                    </div>
                  </div>
                </div>
              ) : (
                <div className="space-y-3">
                  {announcements.length === 0 ? (
                    <p className="text-sm py-8 text-center" style={{color:"#aaa"}}>등록된 공지사항이 없습니다</p>
                  ) : (
                    announcements.map((ann) => (
                      <button
                        key={ann.id}
                        onClick={() => setSelectedAnnouncement(ann)}
                        className="w-full text-left rounded p-4 transition-colors" style={{background:"#F3F2EF",border:"1px solid #EEEEEE"}}
                        data-testid={`announcement-item-${ann.id}`}
                      >
                        <div className="flex items-start gap-3">
                          {ann.isPinned && (
                            <span className="px-2 py-0.5 rounded text-xs font-medium" style={{background:"rgba(196,160,40,0.15)",color:"#C4A028",border:"1px solid rgba(196,160,40,0.3)"}}>고정</span>
                          )}
                          <div className="flex-1">
                            <h3 className="font-medium mb-1" style={{color:"#111111"}}>{ann.title}</h3>
                            <p className="text-sm line-clamp-2" style={{color:"#888"}}>{ann.content}</p>
                            <p className="text-xs mt-1" style={{color:"#aaa"}}>
                              {new Date(ann.displayDate || ann.createdAt).toLocaleDateString('ko-KR', { year: 'numeric', month: '2-digit', day: '2-digit' })}
                            </p>
                          </div>
                        </div>
                      </button>
                    ))
                  )}
                </div>
              )}
            </div>
          </div>
        </DialogContent>
      </Dialog>

      {/* My Page Modal */}
      <Dialog open={showMyPageModal} onOpenChange={setShowMyPageModal}>
        <DialogContent className="max-w-lg w-full max-h-[90vh] overflow-y-auto p-0" style={{background:"#FAF9F6",border:"1px solid rgba(196,160,40,0.22)",borderTop:"3px solid #C4A028",borderRadius:8,boxShadow:"0 20px 60px rgba(0,0,0,0.18)"}}>
          <div className="p-6">
            <DialogTitle className="text-xl font-bold text-white mb-6">마이페이지</DialogTitle>

            {/* 계정 정보 */}
            <div className="mb-6">
              <h3 className="text-base font-semibold mb-4 pb-2" style={{color:"#8A6C10",borderBottom:"1px solid rgba(196,160,40,0.2)"}}>계정 정보</h3>
              <div className="space-y-4">
                <div>
                  <label className="block text-xs mb-1" style={{color:"#888"}}>아이디</label>
                  <input
                    type="text"
                    value={user?.username || ""}
                    readOnly
                    className="w-full rounded px-3 py-2 text-sm cursor-not-allowed" style={{background:"#EDECE9",border:"1px solid #E5E5E5",color:"#888"}}
                    data-testid="input-mypage-username"
                  />
                  <p className="text-xs text-gray-500 mt-1">로그인에 사용되는 고유 아이디입니다.</p>
                </div>
                <div className="grid grid-cols-2 gap-3">
                  <div>
                    <label className="block text-xs mb-1" style={{color:"#888"}}>새 비밀번호</label>
                    <Input
                      type="password"
                      placeholder="새 비밀번호"
                      value={myPageNewPassword}
                      onChange={e => setMyPageNewPassword(e.target.value)}
                      className="border text-sm" style={{background:"#FAF9F6",borderColor:"rgba(196,160,40,0.3)",color:"#111"}}
                      data-testid="input-mypage-new-password"
                    />
                  </div>
                  <div>
                    <label className="block text-xs mb-1" style={{color:"#888"}}>비밀번호 확인</label>
                    <Input
                      type="password"
                      placeholder="새 비밀번호 확인"
                      value={myPageConfirmPassword}
                      onChange={e => setMyPageConfirmPassword(e.target.value)}
                      className="border text-sm" style={{background:"#FAF9F6",borderColor:"rgba(196,160,40,0.3)",color:"#111"}}
                      data-testid="input-mypage-confirm-password"
                    />
                  </div>
                </div>
                <p className="text-xs text-gray-500">영문, 숫자, 기호를 조합하여 안전한 비밀번호를 설정해 주세요. (비워두면 변경 안됨)</p>
              </div>
            </div>

            {/* 본인 정보 */}
            <div className="mb-6">
              <h3 className="text-base font-semibold mb-4 pb-2" style={{color:"#8A6C10",borderBottom:"1px solid rgba(196,160,40,0.2)"}}>본인 정보</h3>
              <div className="grid grid-cols-2 gap-3">
                <div>
                  <label className="block text-xs mb-1" style={{color:"#888"}}>이름</label>
                  <input
                    type="text"
                    value={(user as any)?.name || ""}
                    readOnly
                    className="w-full rounded px-3 py-2 text-sm cursor-not-allowed" style={{background:"#EDECE9",border:"1px solid #E5E5E5",color:"#888"}}
                    data-testid="input-mypage-name"
                  />
                </div>
                <div>
                  <label className="block text-xs mb-1" style={{color:"#888"}}>생년월일 (YYMMDD)</label>
                  <input
                    type="text"
                    value={(user as any)?.birthDate || ""}
                    readOnly
                    className="w-full rounded px-3 py-2 text-sm cursor-not-allowed" style={{background:"#EDECE9",border:"1px solid #E5E5E5",color:"#888"}}
                    data-testid="input-mypage-birthdate"
                  />
                  <p className="text-xs text-gray-500 mt-1">회원 가입 시 등록한 정보 기준으로 표시됩니다.</p>
                </div>
              </div>
            </div>

            {/* 환급 계좌 */}
            <div className="mb-6">
              <h3 className="text-base font-semibold mb-4 pb-2" style={{color:"#8A6C10",borderBottom:"1px solid rgba(196,160,40,0.2)"}}>환급 계좌</h3>
              <div className="space-y-3">
                <div>
                  <label className="block text-xs mb-1" style={{color:"#888"}}>은행명</label>
                  <Select value={myPageBankName} onValueChange={setMyPageBankName}>
                    <SelectTrigger className="border text-sm" style={{background:"#FAF9F6",borderColor:"rgba(196,160,40,0.3)",color:"#111"}} data-testid="select-mypage-bank">
                      <SelectValue placeholder="은행 선택" />
                    </SelectTrigger>
                    <SelectContent className="max-h-60" style={{background:"#FAF9F6",border:"1px solid rgba(196,160,40,0.2)"}}>
                      {KOREAN_BANKS.map(bank => (
                        <SelectItem key={bank} value={bank} className="" style={{color:"#555"}}>{bank}</SelectItem>
                      ))}
                    </SelectContent>
                  </Select>
                  <p className="text-xs text-gray-500 mt-1">정산 및 환급 시 사용될 계좌 정보를 정확히 입력해 주세요.</p>
                </div>
                <div>
                  <label className="block text-xs mb-1" style={{color:"#888"}}>계좌번호</label>
                  <Input
                    type="text"
                    placeholder="계좌번호 (숫자만)"
                    value={myPageAccountNumber}
                    onChange={e => setMyPageAccountNumber(e.target.value)}
                    className="border text-sm" style={{background:"#FAF9F6",borderColor:"rgba(196,160,40,0.3)",color:"#111"}}
                    data-testid="input-mypage-account-number"
                  />
                </div>
                <div>
                  <label className="block text-xs mb-1" style={{color:"#888"}}>예금주</label>
                  <Input
                    type="text"
                    placeholder="예금주명"
                    value={myPageAccountHolder}
                    onChange={e => setMyPageAccountHolder(e.target.value)}
                    className="border text-sm" style={{background:"#FAF9F6",borderColor:"rgba(196,160,40,0.3)",color:"#111"}}
                    data-testid="input-mypage-account-holder"
                  />
                  <p className="text-xs text-gray-500 mt-1">회원 실명과 동일해야 정상 환급이 가능합니다.</p>
                </div>
              </div>
            </div>

            {/* 보유금 */}
            <div className="mb-6">
              <h3 className="text-base font-semibold mb-4 pb-2" style={{color:"#8A6C10",borderBottom:"1px solid rgba(196,160,40,0.2)"}}>보유금</h3>
              <div>
                <label className="block text-xs mb-1" style={{color:"#888"}}>보유금액</label>
                <input
                  type="text"
                  value={`₩ ${balanceData?.balance ? Math.floor(parseFloat(balanceData.balance)).toLocaleString() : '0'}`}
                  readOnly
                  className="w-full rounded px-3 py-2 font-bold text-sm cursor-not-allowed" style={{background:"rgba(196,160,40,0.06)",border:"1px solid rgba(196,160,40,0.25)",color:"#8A6C10"}}
                  data-testid="input-mypage-balance"
                />
              </div>
            </div>

            {/* 저장 버튼 */}
            <Button
              onClick={handleMyPageSave}
              disabled={myPageSaving}
              className="w-full bg-[#C4A028] hover:opacity-90 text-white font-semibold h-11"
              data-testid="button-mypage-save"
            >
              {myPageSaving ? "저장 중..." : "저장하기"}
            </Button>
          </div>
        </DialogContent>
      </Dialog>

      {/* Login Error Alert Dialog */}
      <AlertDialog open={!!loginErrorMessage} onOpenChange={() => setLoginErrorMessage("")}>
        <AlertDialogContent className="" style={{background:"#FAF9F6",border:"1px solid rgba(196,160,40,0.22)",borderTop:"3px solid #C4A028",borderRadius:8,boxShadow:"0 20px 60px rgba(0,0,0,0.18)"}}>
          <AlertDialogHeader>
            <AlertDialogTitle className="text-red-500 flex items-center gap-2">
              <X className="w-5 h-5" />
              로그인 실패
            </AlertDialogTitle>
            <AlertDialogDescription className="" style={{color:"#666"}}>
              {loginErrorMessage}
            </AlertDialogDescription>
          </AlertDialogHeader>
          <AlertDialogFooter>
            <AlertDialogAction 
              onClick={() => setLoginErrorMessage("")}
              className="text-white font-semibold" style={{background:"#C4A028",border:"none",borderRadius:4}}
            >
              확인
            </AlertDialogAction>
          </AlertDialogFooter>
        </AlertDialogContent>
      </AlertDialog>
    </div>
  );
}
