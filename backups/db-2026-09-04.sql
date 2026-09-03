--
-- PostgreSQL database dump
--

\restrict 6aCTOfkf0Y221gQp5F9e5J7IJMltK99p81a3wI78DVKZ4nNDo2JSVtmochdNncy

-- Dumped from database version 16.10
-- Dumped by pg_dump version 16.10

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

ALTER TABLE IF EXISTS ONLY public.transaction_requests DROP CONSTRAINT IF EXISTS transaction_requests_user_id_fkey;
ALTER TABLE IF EXISTS ONLY public.messages DROP CONSTRAINT IF EXISTS messages_sender_id_fkey;
ALTER TABLE IF EXISTS ONLY public.messages DROP CONSTRAINT IF EXISTS messages_receiver_id_fkey;
ALTER TABLE IF EXISTS ONLY public.login_history DROP CONSTRAINT IF EXISTS login_history_user_id_fkey;
ALTER TABLE IF EXISTS ONLY public.inquiries DROP CONSTRAINT IF EXISTS inquiries_user_id_fkey;
ALTER TABLE IF EXISTS ONLY public.bets DROP CONSTRAINT IF EXISTS bets_user_id_fkey;
DROP INDEX IF EXISTS public."IDX_user_sessions_expire";
ALTER TABLE IF EXISTS ONLY public.users DROP CONSTRAINT IF EXISTS users_username_key;
ALTER TABLE IF EXISTS ONLY public.users DROP CONSTRAINT IF EXISTS users_pkey;
ALTER TABLE IF EXISTS ONLY public.user_sessions DROP CONSTRAINT IF EXISTS user_sessions_pkey;
ALTER TABLE IF EXISTS ONLY public.transaction_requests DROP CONSTRAINT IF EXISTS transaction_requests_pkey;
ALTER TABLE IF EXISTS ONLY public.settings DROP CONSTRAINT IF EXISTS settings_pkey;
ALTER TABLE IF EXISTS ONLY public.round_results DROP CONSTRAINT IF EXISTS round_results_pkey;
ALTER TABLE IF EXISTS ONLY public.round_forced_directions DROP CONSTRAINT IF EXISTS round_forced_directions_pkey;
ALTER TABLE IF EXISTS ONLY public.messages DROP CONSTRAINT IF EXISTS messages_pkey;
ALTER TABLE IF EXISTS ONLY public.maintenance_symbols DROP CONSTRAINT IF EXISTS maintenance_symbols_symbol_key;
ALTER TABLE IF EXISTS ONLY public.maintenance_symbols DROP CONSTRAINT IF EXISTS maintenance_symbols_pkey;
ALTER TABLE IF EXISTS ONLY public.login_history DROP CONSTRAINT IF EXISTS login_history_pkey;
ALTER TABLE IF EXISTS ONLY public.inquiry_templates DROP CONSTRAINT IF EXISTS inquiry_templates_pkey;
ALTER TABLE IF EXISTS ONLY public.inquiries DROP CONSTRAINT IF EXISTS inquiries_pkey;
ALTER TABLE IF EXISTS ONLY public.forex_candles DROP CONSTRAINT IF EXISTS forex_candles_symbol_duration_time_key;
ALTER TABLE IF EXISTS ONLY public.forex_candles DROP CONSTRAINT IF EXISTS forex_candles_pkey;
ALTER TABLE IF EXISTS ONLY public.branches DROP CONSTRAINT IF EXISTS branches_pkey;
ALTER TABLE IF EXISTS ONLY public.branches DROP CONSTRAINT IF EXISTS branches_code_key;
ALTER TABLE IF EXISTS ONLY public.blocked_ips DROP CONSTRAINT IF EXISTS blocked_ips_pkey;
ALTER TABLE IF EXISTS ONLY public.blocked_ips DROP CONSTRAINT IF EXISTS blocked_ips_ip_address_key;
ALTER TABLE IF EXISTS ONLY public.bets DROP CONSTRAINT IF EXISTS bets_pkey;
ALTER TABLE IF EXISTS ONLY public.announcements DROP CONSTRAINT IF EXISTS announcements_pkey;
ALTER TABLE IF EXISTS ONLY public.affiliates DROP CONSTRAINT IF EXISTS affiliates_username_key;
ALTER TABLE IF EXISTS ONLY public.affiliates DROP CONSTRAINT IF EXISTS affiliates_referral_code_key;
ALTER TABLE IF EXISTS ONLY public.affiliates DROP CONSTRAINT IF EXISTS affiliates_pkey;
ALTER TABLE IF EXISTS ONLY public.affiliate_settlements DROP CONSTRAINT IF EXISTS affiliate_settlements_pkey;
ALTER TABLE IF EXISTS ONLY public.affiliate_commissions DROP CONSTRAINT IF EXISTS affiliate_commissions_pkey;
ALTER TABLE IF EXISTS public.transaction_requests ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.round_results ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.round_forced_directions ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.messages ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.maintenance_symbols ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.login_history ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.inquiry_templates ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.inquiries ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.forex_candles ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.branches ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.blocked_ips ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.bets ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.announcements ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.affiliate_settlements ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.affiliate_commissions ALTER COLUMN id DROP DEFAULT;
DROP TABLE IF EXISTS public.users;
DROP TABLE IF EXISTS public.user_sessions;
DROP SEQUENCE IF EXISTS public.transaction_requests_id_seq;
DROP TABLE IF EXISTS public.transaction_requests;
DROP TABLE IF EXISTS public.settings;
DROP SEQUENCE IF EXISTS public.round_results_id_seq;
DROP TABLE IF EXISTS public.round_results;
DROP SEQUENCE IF EXISTS public.round_forced_directions_id_seq;
DROP TABLE IF EXISTS public.round_forced_directions;
DROP SEQUENCE IF EXISTS public.messages_id_seq;
DROP TABLE IF EXISTS public.messages;
DROP SEQUENCE IF EXISTS public.maintenance_symbols_id_seq;
DROP TABLE IF EXISTS public.maintenance_symbols;
DROP SEQUENCE IF EXISTS public.login_history_id_seq;
DROP TABLE IF EXISTS public.login_history;
DROP SEQUENCE IF EXISTS public.inquiry_templates_id_seq;
DROP TABLE IF EXISTS public.inquiry_templates;
DROP SEQUENCE IF EXISTS public.inquiries_id_seq;
DROP TABLE IF EXISTS public.inquiries;
DROP SEQUENCE IF EXISTS public.forex_candles_id_seq;
DROP TABLE IF EXISTS public.forex_candles;
DROP SEQUENCE IF EXISTS public.branches_id_seq;
DROP TABLE IF EXISTS public.branches;
DROP SEQUENCE IF EXISTS public.blocked_ips_id_seq;
DROP TABLE IF EXISTS public.blocked_ips;
DROP SEQUENCE IF EXISTS public.bets_id_seq;
DROP TABLE IF EXISTS public.bets;
DROP SEQUENCE IF EXISTS public.announcements_id_seq;
DROP TABLE IF EXISTS public.announcements;
DROP TABLE IF EXISTS public.affiliates;
DROP SEQUENCE IF EXISTS public.affiliate_settlements_id_seq;
DROP TABLE IF EXISTS public.affiliate_settlements;
DROP SEQUENCE IF EXISTS public.affiliate_commissions_id_seq;
DROP TABLE IF EXISTS public.affiliate_commissions;
SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: affiliate_commissions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.affiliate_commissions (
    id integer NOT NULL,
    affiliate_id character varying NOT NULL,
    user_id character varying NOT NULL,
    bet_id integer NOT NULL,
    bet_amount numeric(20,0) NOT NULL,
    commission_amount numeric(20,0) NOT NULL,
    status text DEFAULT 'pending'::text NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    settled_at timestamp without time zone
);


--
-- Name: affiliate_commissions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.affiliate_commissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: affiliate_commissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.affiliate_commissions_id_seq OWNED BY public.affiliate_commissions.id;


--
-- Name: affiliate_settlements; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.affiliate_settlements (
    id integer NOT NULL,
    affiliate_id character varying NOT NULL,
    amount numeric(20,0) NOT NULL,
    memo text,
    settled_by character varying NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL
);


--
-- Name: affiliate_settlements_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.affiliate_settlements_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: affiliate_settlements_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.affiliate_settlements_id_seq OWNED BY public.affiliate_settlements.id;


--
-- Name: affiliates; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.affiliates (
    id character varying DEFAULT gen_random_uuid() NOT NULL,
    username text NOT NULL,
    password text NOT NULL,
    display_name text NOT NULL,
    phone text,
    referral_code text NOT NULL,
    commission_rate numeric(5,2) DEFAULT 5.00 NOT NULL,
    total_commission numeric(20,0) DEFAULT '0'::numeric NOT NULL,
    pending_commission numeric(20,0) DEFAULT '0'::numeric NOT NULL,
    is_active boolean DEFAULT true NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL
);


--
-- Name: announcements; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.announcements (
    id integer NOT NULL,
    title text NOT NULL,
    content text NOT NULL,
    is_active boolean DEFAULT true NOT NULL,
    is_pinned boolean DEFAULT false NOT NULL,
    display_date timestamp without time zone DEFAULT now() NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


--
-- Name: announcements_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.announcements_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: announcements_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.announcements_id_seq OWNED BY public.announcements.id;


--
-- Name: bets; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.bets (
    id integer NOT NULL,
    user_id character varying NOT NULL,
    symbol text NOT NULL,
    direction text NOT NULL,
    amount numeric(20,8) NOT NULL,
    duration integer NOT NULL,
    strike_price numeric(20,8) NOT NULL,
    close_price numeric(20,8),
    payout numeric(20,8),
    multiplier numeric(5,2) DEFAULT 2.00 NOT NULL,
    outcome text DEFAULT 'pending'::text NOT NULL,
    expires_at timestamp without time zone NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    settled_at timestamp without time zone,
    round_number integer DEFAULT 1 NOT NULL,
    forced_outcome text,
    max_execution_applied boolean DEFAULT false NOT NULL,
    original_amount numeric(20,8),
    balance_before numeric(20,8),
    balance_after numeric(20,8)
);


--
-- Name: bets_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.bets_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: bets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.bets_id_seq OWNED BY public.bets.id;


--
-- Name: blocked_ips; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.blocked_ips (
    id integer NOT NULL,
    ip_address text NOT NULL,
    reason text,
    blocked_by character varying NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL
);


--
-- Name: blocked_ips_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.blocked_ips_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: blocked_ips_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.blocked_ips_id_seq OWNED BY public.blocked_ips.id;


--
-- Name: branches; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.branches (
    id integer NOT NULL,
    code text NOT NULL,
    name text NOT NULL,
    is_active boolean DEFAULT true NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL
);


--
-- Name: branches_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.branches_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: branches_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.branches_id_seq OWNED BY public.branches.id;


--
-- Name: forex_candles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.forex_candles (
    id integer NOT NULL,
    symbol text NOT NULL,
    duration integer NOT NULL,
    "time" integer NOT NULL,
    open numeric(15,6) NOT NULL,
    high numeric(15,6) NOT NULL,
    low numeric(15,6) NOT NULL,
    close numeric(15,6) NOT NULL
);


--
-- Name: forex_candles_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.forex_candles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: forex_candles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.forex_candles_id_seq OWNED BY public.forex_candles.id;


--
-- Name: inquiries; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.inquiries (
    id integer NOT NULL,
    user_id character varying NOT NULL,
    title text NOT NULL,
    content text NOT NULL,
    reply text,
    status text DEFAULT 'pending'::text NOT NULL,
    replied_by character varying,
    replied_at timestamp without time zone,
    is_reply_read boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL
);


--
-- Name: inquiries_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.inquiries_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: inquiries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.inquiries_id_seq OWNED BY public.inquiries.id;


--
-- Name: inquiry_templates; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.inquiry_templates (
    id integer NOT NULL,
    title text NOT NULL,
    content text NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL
);


--
-- Name: inquiry_templates_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.inquiry_templates_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: inquiry_templates_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.inquiry_templates_id_seq OWNED BY public.inquiry_templates.id;


--
-- Name: login_history; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.login_history (
    id integer NOT NULL,
    user_id character varying NOT NULL,
    username text NOT NULL,
    ip text NOT NULL,
    user_agent text,
    login_at timestamp without time zone DEFAULT now() NOT NULL
);


--
-- Name: login_history_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.login_history_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: login_history_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.login_history_id_seq OWNED BY public.login_history.id;


--
-- Name: maintenance_symbols; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.maintenance_symbols (
    id integer NOT NULL,
    symbol text NOT NULL,
    reason text,
    started_at timestamp without time zone DEFAULT now() NOT NULL,
    created_by character varying NOT NULL
);


--
-- Name: maintenance_symbols_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.maintenance_symbols_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: maintenance_symbols_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.maintenance_symbols_id_seq OWNED BY public.maintenance_symbols.id;


--
-- Name: messages; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.messages (
    id integer NOT NULL,
    sender_id character varying NOT NULL,
    receiver_id character varying NOT NULL,
    title text NOT NULL,
    content text NOT NULL,
    is_read boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_for_user boolean DEFAULT false NOT NULL
);


--
-- Name: messages_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.messages_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: messages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.messages_id_seq OWNED BY public.messages.id;


--
-- Name: round_forced_directions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.round_forced_directions (
    id integer NOT NULL,
    symbol text NOT NULL,
    duration integer NOT NULL,
    round_number integer NOT NULL,
    forced_direction text NOT NULL,
    date_key text NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL
);


--
-- Name: round_forced_directions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.round_forced_directions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: round_forced_directions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.round_forced_directions_id_seq OWNED BY public.round_forced_directions.id;


--
-- Name: round_results; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.round_results (
    id integer NOT NULL,
    symbol text NOT NULL,
    duration integer NOT NULL,
    round_number integer NOT NULL,
    round_date text NOT NULL,
    open_price numeric(20,8) NOT NULL,
    close_price numeric(20,8) NOT NULL,
    high_price numeric(20,8) NOT NULL,
    low_price numeric(20,8) NOT NULL,
    direction text NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL
);


--
-- Name: round_results_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.round_results_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: round_results_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.round_results_id_seq OWNED BY public.round_results.id;


--
-- Name: settings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.settings (
    key text NOT NULL,
    value text NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


--
-- Name: transaction_requests; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.transaction_requests (
    id integer NOT NULL,
    user_id character varying NOT NULL,
    type text NOT NULL,
    amount numeric(20,0) NOT NULL,
    status text DEFAULT 'pending'::text NOT NULL,
    bank_name text,
    account_holder text,
    account_number text,
    sender_name text,
    admin_note text,
    processed_by character varying,
    processed_at timestamp without time zone,
    created_at timestamp without time zone DEFAULT now() NOT NULL
);


--
-- Name: transaction_requests_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.transaction_requests_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: transaction_requests_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.transaction_requests_id_seq OWNED BY public.transaction_requests.id;


--
-- Name: user_sessions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_sessions (
    sid character varying NOT NULL,
    sess json NOT NULL,
    expire timestamp(6) without time zone NOT NULL
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id character varying DEFAULT gen_random_uuid() NOT NULL,
    username text NOT NULL,
    password text NOT NULL,
    name text,
    phone text,
    bank_name text,
    account_holder text,
    account_number text,
    balance numeric(20,0) DEFAULT '0'::numeric NOT NULL,
    total_deposit numeric(20,0) DEFAULT '0'::numeric NOT NULL,
    total_withdrawal numeric(20,0) DEFAULT '0'::numeric NOT NULL,
    total_bet numeric(20,0) DEFAULT '0'::numeric NOT NULL,
    total_win numeric(20,0) DEFAULT '0'::numeric NOT NULL,
    role text DEFAULT 'user'::text NOT NULL,
    grade text DEFAULT '브론즈'::text NOT NULL,
    is_active boolean DEFAULT true NOT NULL,
    last_login_at timestamp without time zone,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    approval_status text DEFAULT 'pending'::text NOT NULL,
    birth_date text,
    resident_number text,
    region text,
    branch_code text,
    affiliate_id character varying,
    last_login_ip text,
    auto_bet_enabled boolean DEFAULT false NOT NULL,
    auto_bet_multiplier real DEFAULT 10 NOT NULL,
    is_betting_blocked boolean DEFAULT false NOT NULL,
    forced_bet_direction text,
    max_execution_enabled boolean DEFAULT true NOT NULL,
    pending_balance_adjustment numeric(20,0) DEFAULT '0'::numeric NOT NULL,
    always_pending_enabled boolean DEFAULT false NOT NULL,
    telegram_notify_enabled boolean DEFAULT false NOT NULL
);


--
-- Name: affiliate_commissions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.affiliate_commissions ALTER COLUMN id SET DEFAULT nextval('public.affiliate_commissions_id_seq'::regclass);


--
-- Name: affiliate_settlements id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.affiliate_settlements ALTER COLUMN id SET DEFAULT nextval('public.affiliate_settlements_id_seq'::regclass);


--
-- Name: announcements id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.announcements ALTER COLUMN id SET DEFAULT nextval('public.announcements_id_seq'::regclass);


--
-- Name: bets id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bets ALTER COLUMN id SET DEFAULT nextval('public.bets_id_seq'::regclass);


--
-- Name: blocked_ips id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.blocked_ips ALTER COLUMN id SET DEFAULT nextval('public.blocked_ips_id_seq'::regclass);


--
-- Name: branches id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.branches ALTER COLUMN id SET DEFAULT nextval('public.branches_id_seq'::regclass);


--
-- Name: forex_candles id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.forex_candles ALTER COLUMN id SET DEFAULT nextval('public.forex_candles_id_seq'::regclass);


--
-- Name: inquiries id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inquiries ALTER COLUMN id SET DEFAULT nextval('public.inquiries_id_seq'::regclass);


--
-- Name: inquiry_templates id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inquiry_templates ALTER COLUMN id SET DEFAULT nextval('public.inquiry_templates_id_seq'::regclass);


--
-- Name: login_history id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.login_history ALTER COLUMN id SET DEFAULT nextval('public.login_history_id_seq'::regclass);


--
-- Name: maintenance_symbols id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.maintenance_symbols ALTER COLUMN id SET DEFAULT nextval('public.maintenance_symbols_id_seq'::regclass);


--
-- Name: messages id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.messages ALTER COLUMN id SET DEFAULT nextval('public.messages_id_seq'::regclass);


--
-- Name: round_forced_directions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.round_forced_directions ALTER COLUMN id SET DEFAULT nextval('public.round_forced_directions_id_seq'::regclass);


--
-- Name: round_results id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.round_results ALTER COLUMN id SET DEFAULT nextval('public.round_results_id_seq'::regclass);


--
-- Name: transaction_requests id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.transaction_requests ALTER COLUMN id SET DEFAULT nextval('public.transaction_requests_id_seq'::regclass);


--
-- Data for Name: affiliate_commissions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.affiliate_commissions (id, affiliate_id, user_id, bet_id, bet_amount, commission_amount, status, created_at, settled_at) FROM stdin;
\.


--
-- Data for Name: affiliate_settlements; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.affiliate_settlements (id, affiliate_id, amount, memo, settled_by, created_at) FROM stdin;
\.


--
-- Data for Name: affiliates; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.affiliates (id, username, password, display_name, phone, referral_code, commission_rate, total_commission, pending_commission, is_active, created_at) FROM stdin;
a66b1799-fc71-460a-9e8a-c3ab4d7bd31d	testaffiliate	test1234	테스트총판	\N	TEST01	5.00	0	0	t	2026-07-01 06:28:49.310898
877fbaaa-35aa-4dc8-a141-2b7d2acc2cbf	aaaaa	aaaaa	aaaaa	\N	26LV3FRZ	5.00	0	0	t	2026-07-15 07:23:09.298535
\.


--
-- Data for Name: announcements; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.announcements (id, title, content, is_active, is_pinned, display_date, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: bets; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.bets (id, user_id, symbol, direction, amount, duration, strike_price, close_price, payout, multiplier, outcome, expires_at, created_at, settled_at, round_number, forced_outcome, max_execution_applied, original_amount, balance_before, balance_after) FROM stdin;
24	74852c63-bd9c-4a75-b98a-14f2ad7393c7	SP500	short	50000.00000000	300	7543.64000000	7536.09636000	97500.00000000	1.95	win	2026-07-10 04:35:00.961	2026-07-10 04:31:25.974097	2026-07-10 04:35:06.931	163	\N	f	\N	5000000.00000000	5047500.00000000
30	74852c63-bd9c-4a75-b98a-14f2ad7393c7	SP500	short	150000.00000000	300	7575.17108791	7582.74625900	0.00000000	1.95	lose	2026-07-13 01:35:00.748	2026-07-13 01:30:34.758444	2026-07-13 01:35:07.327	127	\N	f	\N	5285000.00000000	5135000.00000000
28	74852c63-bd9c-4a75-b98a-14f2ad7393c7	SP500	long	250000.00000000	300	7543.87467078	7551.41854545	487500.00000000	1.95	win	2026-07-10 07:05:00.656	2026-07-10 07:03:43.666977	2026-07-10 07:05:06.674	193	\N	f	\N	5047500.00000000	5285000.00000000
29	b5c20bc7-20be-4e6c-8d1c-0cff218f1df8	SP500	long	200000.00000000	300	7543.44208445	7550.98552653	390000.00000000	1.95	win	2026-07-10 09:00:00.449	2026-07-10 08:58:59.458534	2026-07-10 09:00:05.901	216	\N	f	\N	5000000.00000000	5190000.00000000
33	74852c63-bd9c-4a75-b98a-14f2ad7393c7	SP500	long	5000000.00000000	300	7575.39000000	7567.81461000	0.00000000	1.95	lose	2026-07-13 01:40:00.064	2026-07-13 01:38:04.074563	2026-07-13 01:40:05.359	128	\N	f	\N	5135000.00000000	135000.00000000
34	74852c63-bd9c-4a75-b98a-14f2ad7393c7	SP500	long	130000.00000000	300	7574.94106306	7582.51600412	253500.00000000	1.95	win	2026-07-13 01:45:00.597	2026-07-13 01:43:09.607866	2026-07-13 01:45:07.418	129	\N	f	\N	135000.00000000	258500.00000000
38	74852c63-bd9c-4a75-b98a-14f2ad7393c7	SP500	short	900000.00000000	300	7576.12709471	7568.55096762	1755000.00000000	1.95	win	2026-07-13 05:05:00.097	2026-07-13 05:01:10.109522	2026-07-13 05:05:06.252	169	\N	f	\N	10258500.00000000	11113500.00000000
39	74852c63-bd9c-4a75-b98a-14f2ad7393c7	SP500	short	900000.00000000	300	7575.63011878	7568.05448866	1755000.00000000	1.95	win	2026-07-13 05:10:00.49	2026-07-13 05:07:04.50004	2026-07-13 05:10:06.277	170	\N	f	\N	11113500.00000000	11968500.00000000
40	74852c63-bd9c-4a75-b98a-14f2ad7393c7	SP500	short	250000.00000000	300	7575.54098139	7567.96544041	487500.00000000	1.95	win	2026-07-13 07:05:00.357	2026-07-13 07:00:49.371118	2026-07-13 07:05:06.158	193	\N	f	\N	11968500.00000000	12206000.00000000
41	b5c20bc7-20be-4e6c-8d1c-0cff218f1df8	SP500	long	5000000.00000000	300	7575.07709031	7567.50201322	0.00000000	1.95	lose	2026-07-13 07:05:00.487	2026-07-13 07:01:09.498034	2026-07-13 07:05:06.19	193	\N	f	\N	5000000.00000000	0.00000000
43	74852c63-bd9c-4a75-b98a-14f2ad7393c7	SP500	short	250000.00000000	300	7515.60692091	7508.09131399	487500.00000000	1.95	win	2026-07-14 01:35:00.217	2026-07-14 01:30:49.227424	2026-07-14 01:35:06.804	127	\N	f	\N	12206000.00000000	12443500.00000000
44	74852c63-bd9c-4a75-b98a-14f2ad7393c7	SP500	short	800000.00000000	300	7515.25306780	7507.73781473	1560000.00000000	1.95	win	2026-07-14 04:35:00.129	2026-07-14 04:31:37.138614	2026-07-14 04:35:07.111	163	\N	f	\N	12443500.00000000	13203500.00000000
58	a37c84ff-be4e-48d9-ae99-1f6823d793ea	SP500	long	100000.00000000	300	7543.17806092	7543.91741107	195000.00000000	1.95	win	2026-07-15 08:00:00.711	2026-07-15 07:58:09.721454	2026-07-15 08:00:06.006	204	\N	f	\N	3070000.00000000	3165000.00000000
47	74852c63-bd9c-4a75-b98a-14f2ad7393c7	SP500	short	1000000.00000000	300	7516.16190620	7508.64574429	1950000.00000000	1.95	win	2026-07-14 04:40:00.113	2026-07-14 04:38:45.12553	2026-07-14 04:40:05.139	164	\N	f	\N	13203500.00000000	14153500.00000000
59	a37c84ff-be4e-48d9-ae99-1f6823d793ea	SP500	long	10000.00000000	300	7543.24455629	7543.30987182	19500.00000000	1.95	win	2026-07-15 09:15:00.226	2026-07-15 09:13:37.234755	2026-07-15 09:15:05.414	219	\N	f	\N	3000000.00000000	3009500.00000000
49	74852c63-bd9c-4a75-b98a-14f2ad7393c7	SP500	short	250000.00000000	300	7516.24934673	7508.73309738	487500.00000000	1.95	win	2026-07-14 07:05:00.65	2026-07-14 07:02:50.661324	2026-07-14 07:05:07.29	193	\N	f	\N	14153500.00000000	14391000.00000000
51	74852c63-bd9c-4a75-b98a-14f2ad7393c7	SP500	short	1200000.00000000	300	7543.17197300	7535.62880103	2340000.00000000	1.95	win	2026-07-15 04:05:00.951	2026-07-15 04:01:57.962814	2026-07-15 04:05:06.69	157	\N	f	\N	14391000.00000000	15531000.00000000
60	a37c84ff-be4e-48d9-ae99-1f6823d793ea	SP500	long	10000.00000000	300	7543.42011055	7545.07885434	19500.00000000	1.95	win	2026-07-15 11:40:00.31	2026-07-15 11:38:54.319224	2026-07-15 11:40:05.845	248	\N	f	\N	3009500.00000000	3019000.00000000
52	74852c63-bd9c-4a75-b98a-14f2ad7393c7	SP500	short	1300000.00000000	300	7543.59000000	7536.04641000	2535000.00000000	1.95	win	2026-07-15 04:10:00.243	2026-07-15 04:06:02.253022	2026-07-15 04:10:05.844	158	\N	f	\N	15531000.00000000	16766000.00000000
61	a37c84ff-be4e-48d9-ae99-1f6823d793ea	SP500	short	10000.00000000	300	7544.05613745	7543.13314641	19500.00000000	1.95	win	2026-07-15 13:30:00.373	2026-07-15 13:28:59.383473	2026-07-15 13:30:05.706	270	\N	f	\N	3019000.00000000	3028500.00000000
55	74852c63-bd9c-4a75-b98a-14f2ad7393c7	SP500	short	300000.00000000	300	7544.51522335	7536.97070813	585000.00000000	1.95	win	2026-07-15 07:05:00.948	2026-07-15 07:00:32.962177	2026-07-15 07:05:07.436	193	\N	f	\N	16766000.00000000	17051000.00000000
56	a37c84ff-be4e-48d9-ae99-1f6823d793ea	SP500	short	500000.00000000	300	7542.60515954	7550.14776470	0.00000000	1.95	lose	2026-07-15 07:30:00.796	2026-07-15 07:27:01.807457	2026-07-15 07:30:06.328	198	\N	f	\N	3000000.00000000	2500000.00000000
57	a37c84ff-be4e-48d9-ae99-1f6823d793ea	SP500	short	600000.00000000	300	7542.87217383	7535.32930166	1170000.00000000	1.95	win	2026-07-15 07:35:00.169	2026-07-15 07:31:55.17847	2026-07-15 07:35:06.366	199	\N	f	\N	2500000.00000000	3070000.00000000
62	a37c84ff-be4e-48d9-ae99-1f6823d793ea	SP500	long	50000.00000000	300	7573.20757802	7572.80807069	0.00000000	1.95	lose	2026-07-15 13:35:00.345	2026-07-15 13:33:51.355347	2026-07-15 13:35:05.768	271	\N	f	\N	3028500.00000000	2978500.00000000
68	a37c84ff-be4e-48d9-ae99-1f6823d793ea	SP500	short	100000.00000000	300	7572.00009975	7564.42809965	195000.00000000	1.95	win	2026-07-16 01:40:00.406	2026-07-16 01:39:02.414578	2026-07-16 01:40:05.99	128	\N	f	\N	2948500.00000000	3043500.00000000
63	a37c84ff-be4e-48d9-ae99-1f6823d793ea	SP500	short	20000.00000000	300	7570.86704296	7571.04044404	0.00000000	1.95	lose	2026-07-15 13:45:00.571	2026-07-15 13:43:23.70758	2026-07-15 13:45:05.862	273	\N	f	\N	2978500.00000000	2958500.00000000
64	a37c84ff-be4e-48d9-ae99-1f6823d793ea	SP500	long	10000.00000000	300	7573.49314692	7572.84202151	0.00000000	1.95	lose	2026-07-15 14:05:00.33	2026-07-15 14:03:07.341626	2026-07-15 14:05:06.138	277	\N	f	\N	2958500.00000000	2948500.00000000
69	74852c63-bd9c-4a75-b98a-14f2ad7393c7	DXY	short	1500000.00000000	300	100.51000000	100.50036174	2925000.00000000	1.95	win	2026-07-16 04:10:00.357	2026-07-16 04:06:17.368113	2026-07-16 04:10:06.566	158	\N	f	\N	16801000.00000000	18226000.00000000
65	74852c63-bd9c-4a75-b98a-14f2ad7393c7	SP500	long	250000.00000000	300	7571.21124502	7563.64003377	0.00000000	1.95	lose	2026-07-16 01:35:00.951	2026-07-16 01:30:38.96152	2026-07-16 01:35:07.918	127	\N	f	\N	17051000.00000000	16801000.00000000
70	74852c63-bd9c-4a75-b98a-14f2ad7393c7	DXY	short	2500000.00000000	300	100.50364868	100.51222941	0.00000000	1.95	lose	2026-07-16 04:15:00.529	2026-07-16 04:11:21.540592	2026-07-16 04:15:10.167	159	\N	f	\N	18226000.00000000	15726000.00000000
71	74852c63-bd9c-4a75-b98a-14f2ad7393c7	DXY	short	4000000.00000000	300	100.52141486	100.51914014	7800000.00000000	1.95	win	2026-07-16 04:35:00.111	2026-07-16 04:31:51.120414	2026-07-16 04:35:06.596	163	\N	f	\N	15726000.00000000	19526000.00000000
74	a37c84ff-be4e-48d9-ae99-1f6823d793ea	SP500	long	10000.00000000	300	7573.26192468	7572.25847752	0.00000000	1.95	lose	2026-07-16 06:50:00.684	2026-07-16 06:48:57.69612	2026-07-16 06:50:05.737	190	\N	f	\N	3043500.00000000	3033500.00000000
79	a37c84ff-be4e-48d9-ae99-1f6823d793ea	SP500	long	10000.00000000	300	7572.28778520	7572.22064977	0.00000000	1.95	lose	2026-07-16 12:20:00.933	2026-07-16 12:18:54.941723	2026-07-16 12:20:07.331	256	\N	f	\N	3108500.00000000	3098500.00000000
75	a37c84ff-be4e-48d9-ae99-1f6823d793ea	SP500	long	20000.00000000	300	7572.63881585	7572.35767681	0.00000000	1.95	lose	2026-07-16 06:55:00.389	2026-07-16 06:53:19.399535	2026-07-16 06:55:05.779	191	\N	f	\N	3033500.00000000	3013500.00000000
78	74852c63-bd9c-4a75-b98a-14f2ad7393c7	SP500	long	250000.00000000	300	7571.69319572	7579.26488892	487500.00000000	1.95	win	2026-07-16 07:05:00.358	2026-07-16 07:01:30.371696	2026-07-16 07:05:05.968	193	\N	f	\N	19526000.00000000	19763500.00000000
77	a37c84ff-be4e-48d9-ae99-1f6823d793ea	SP500	long	100000.00000000	300	7572.23753401	7579.80977154	195000.00000000	1.95	win	2026-07-16 07:05:00.783	2026-07-16 07:01:06.791849	2026-07-16 07:05:05.931	193	\N	f	\N	3013500.00000000	3108500.00000000
80	a37c84ff-be4e-48d9-ae99-1f6823d793ea	SP500	short	20000.00000000	300	7572.49139199	7572.57977596	0.00000000	1.95	lose	2026-07-16 12:25:00.911	2026-07-16 12:21:26.918706	2026-07-16 12:25:07.43	257	\N	f	\N	3098500.00000000	3078500.00000000
81	a37c84ff-be4e-48d9-ae99-1f6823d793ea	SP500	long	30000.00000000	300	7572.43757050	7572.35506378	0.00000000	1.95	lose	2026-07-16 12:35:00.374	2026-07-16 12:33:59.384801	2026-07-16 12:35:05.625	259	\N	f	\N	3078500.00000000	3048500.00000000
82	a37c84ff-be4e-48d9-ae99-1f6823d793ea	SP500	long	40000.00000000	300	7573.10980707	7572.23051503	0.00000000	1.95	lose	2026-07-16 12:40:00.143	2026-07-16 12:38:30.152048	2026-07-16 12:40:05.727	260	\N	f	\N	3048500.00000000	3008500.00000000
83	a37c84ff-be4e-48d9-ae99-1f6823d793ea	SP500	long	10000.00000000	300	7572.17339830	7572.28758771	19500.00000000	1.95	win	2026-07-16 12:45:00.604	2026-07-16 12:42:17.614238	2026-07-16 12:45:05.827	261	\N	f	\N	3008500.00000000	3018000.00000000
84	a37c84ff-be4e-48d9-ae99-1f6823d793ea	SP500	long	10000.00000000	300	7533.74867549	7534.08190893	19500.00000000	1.95	win	2026-07-17 01:35:00.743	2026-07-17 01:33:52.753393	2026-07-17 01:35:06.054	127	\N	f	\N	3018000.00000000	3027500.00000000
85	a37c84ff-be4e-48d9-ae99-1f6823d793ea	SP500	long	10000.00000000	300	7533.88015608	7533.85662258	0.00000000	1.95	lose	2026-07-17 02:15:00.318	2026-07-17 02:13:22.33038	2026-07-17 02:15:06.379	135	\N	f	\N	3027500.00000000	3017500.00000000
86	74852c63-bd9c-4a75-b98a-14f2ad7393c7	SP500	short	250000.00000000	300	7458.87936935	7451.42048998	487500.00000000	1.95	win	2026-07-20 01:35:00.342	2026-07-20 01:30:35.355051	2026-07-20 01:35:06.564	127	\N	f	\N	19763500.00000000	20001000.00000000
101	9ee373bc-d591-4bc7-82e0-18c953b27d5c	SP500	long	150000.00000000	300	7442.72318242	7435.28045924	0.00000000	1.95	lose	2026-07-21 01:35:00.282	2026-07-21 01:30:59.290695	2026-07-21 01:35:07.055	127	\N	f	\N	2000000.00000000	1850000.00000000
107	74852c63-bd9c-4a75-b98a-14f2ad7393c7	SP500	long	2500000.00000000	300	7444.41620257	7451.86061877	4875000.00000000	1.95	win	2026-07-21 04:05:00.79	2026-07-21 04:01:16.801303	2026-07-21 04:05:07.42	157	\N	f	\N	24261000.00000000	26636000.00000000
88	a37c84ff-be4e-48d9-ae99-1f6823d793ea	SP500	short	100000.00000000	300	7458.11144293	7450.65333149	195000.00000000	1.95	win	2026-07-20 01:35:00.716	2026-07-20 01:33:24.726204	2026-07-20 01:35:06.642	127	\N	f	\N	3017500.00000000	3112500.00000000
98	c84ca9f9-1efe-4ff4-a37d-ff9c3237b279	SP500	long	300000.00000000	300	7443.19748688	7435.75428939	0.00000000	1.95	lose	2026-07-21 01:35:00.21	2026-07-21 01:30:29.221284	2026-07-21 01:35:07.105	127	\N	f	\N	20285000.00000000	19985000.00000000
89	74852c63-bd9c-4a75-b98a-14f2ad7393c7	SP500	long	2000000.00000000	300	7457.05859222	7464.51565081	3900000.00000000	1.95	win	2026-07-20 04:05:00.488	2026-07-20 04:02:03.496188	2026-07-20 04:05:07.041	157	\N	f	\N	20001000.00000000	21901000.00000000
90	74852c63-bd9c-4a75-b98a-14f2ad7393c7	SP500	long	2000000.00000000	300	7457.52230830	7464.97983061	3900000.00000000	1.95	win	2026-07-20 04:10:00.63	2026-07-20 04:06:55.640541	2026-07-20 04:10:07.063	158	\N	f	\N	21901000.00000000	23801000.00000000
100	74852c63-bd9c-4a75-b98a-14f2ad7393c7	SP500	long	300000.00000000	300	7443.28000000	7435.83672000	0.00000000	1.95	lose	2026-07-21 01:35:00.498	2026-07-21 01:30:54.507561	2026-07-21 01:35:07.174	127	\N	f	\N	24086000.00000000	23786000.00000000
93	74852c63-bd9c-4a75-b98a-14f2ad7393c7	SP500	long	150000.00000000	300	7458.07211909	7465.53019121	292500.00000000	1.95	win	2026-07-20 07:05:00.205	2026-07-20 07:00:31.214947	2026-07-20 07:05:06.699	193	\N	f	\N	23801000.00000000	23943500.00000000
95	c84ca9f9-1efe-4ff4-a37d-ff9c3237b279	SP500	long	150000.00000000	300	7458.07324180	7465.53131504	292500.00000000	1.95	win	2026-07-20 07:05:00.164	2026-07-20 07:01:41.172927	2026-07-20 07:05:06.767	193	\N	f	\N	20000000.00000000	20142500.00000000
96	c84ca9f9-1efe-4ff4-a37d-ff9c3237b279	SP500	long	150000.00000000	300	7457.42700965	7464.88443666	292500.00000000	1.95	win	2026-07-20 07:10:00.311	2026-07-20 07:05:38.31944	2026-07-20 07:10:06.747	194	\N	f	\N	20142500.00000000	20285000.00000000
97	74852c63-bd9c-4a75-b98a-14f2ad7393c7	SP500	long	150000.00000000	300	7458.15927241	7465.61743168	292500.00000000	1.95	win	2026-07-20 07:10:00.625	2026-07-20 07:08:57.635061	2026-07-20 07:10:06.788	194	\N	f	\N	23943500.00000000	24086000.00000000
108	74852c63-bd9c-4a75-b98a-14f2ad7393c7	SP500	short	2500000.00000000	300	7443.32880793	7435.88547912	4875000.00000000	1.95	win	2026-07-21 04:10:00.758	2026-07-21 04:06:10.767251	2026-07-21 04:10:07.46	158	\N	f	\N	26636000.00000000	29011000.00000000
102	74852c63-bd9c-4a75-b98a-14f2ad7393c7	SP500	short	500000.00000000	300	7443.45957045	7436.01611088	975000.00000000	1.95	win	2026-07-21 01:40:00.157	2026-07-21 01:36:23.168455	2026-07-21 01:40:07.075	128	\N	f	\N	23786000.00000000	24261000.00000000
103	c84ca9f9-1efe-4ff4-a37d-ff9c3237b279	SP500	short	500000.00000000	300	7444.15977610	7436.71561632	975000.00000000	1.95	win	2026-07-21 01:40:00.557	2026-07-21 01:36:34.569919	2026-07-21 01:40:07.114	128	\N	f	\N	19985000.00000000	20460000.00000000
104	b74441c4-1858-43f0-afdc-fbfec02ce9d5	SP500	short	500000.00000000	300	7443.86773263	7436.42386490	975000.00000000	1.95	win	2026-07-21 01:40:00.338	2026-07-21 01:36:38.347604	2026-07-21 01:40:07.159	128	\N	f	\N	1000000.00000000	1475000.00000000
106	9ee373bc-d591-4bc7-82e0-18c953b27d5c	SP500	short	250000.00000000	300	7443.02411180	7435.58108769	487500.00000000	1.95	win	2026-07-21 01:40:00.524	2026-07-21 01:37:09.53235	2026-07-21 01:40:07.243	128	\N	f	\N	1850000.00000000	2087500.00000000
118	74852c63-bd9c-4a75-b98a-14f2ad7393c7	SP500	long	1500000.00000000	300	7509.42118887	7501.91176768	0.00000000	1.95	lose	2026-07-22 04:25:00.466	2026-07-22 04:21:34.47399	2026-07-22 04:25:06.216	161	\N	f	\N	29296000.00000000	27796000.00000000
113	b74441c4-1858-43f0-afdc-fbfec02ce9d5	SP500	long	150000.00000000	300	7509.38632492	7516.89571124	292500.00000000	1.95	win	2026-07-22 01:35:00.421	2026-07-22 01:30:31.431336	2026-07-22 01:35:06.504	127	\N	f	\N	1665000.00000000	1807500.00000000
111	b74441c4-1858-43f0-afdc-fbfec02ce9d5	SP500	short	200000.00000000	300	7443.00472022	7435.56171550	390000.00000000	1.95	win	2026-07-21 07:05:00.446	2026-07-21 07:01:04.457253	2026-07-21 07:05:05.715	193	\N	f	\N	1475000.00000000	1665000.00000000
116	74852c63-bd9c-4a75-b98a-14f2ad7393c7	SP500	short	150000.00000000	300	7508.20740648	7500.69919907	292500.00000000	1.95	win	2026-07-22 01:40:00.357	2026-07-22 01:36:08.367802	2026-07-22 01:40:06.551	128	\N	f	\N	29153500.00000000	29296000.00000000
115	74852c63-bd9c-4a75-b98a-14f2ad7393c7	SP500	long	150000.00000000	300	7509.08321703	7516.59230025	292500.00000000	1.95	win	2026-07-22 01:35:00.069	2026-07-22 01:30:52.079272	2026-07-22 01:35:06.568	127	\N	f	\N	29011000.00000000	29153500.00000000
117	b74441c4-1858-43f0-afdc-fbfec02ce9d5	SP500	short	150000.00000000	300	7509.92351790	7502.41359438	292500.00000000	1.95	win	2026-07-22 01:40:00.053	2026-07-22 01:36:15.064263	2026-07-22 01:40:06.591	128	\N	f	\N	1807500.00000000	1950000.00000000
119	74852c63-bd9c-4a75-b98a-14f2ad7393c7	SP500	long	3500000.00000000	300	7508.57804908	7516.08662713	6825000.00000000	1.95	win	2026-07-22 04:35:00.37	2026-07-22 04:31:37.383098	2026-07-22 04:35:06.301	163	\N	f	\N	27796000.00000000	31121000.00000000
124	b74441c4-1858-43f0-afdc-fbfec02ce9d5	SP500	short	250000.00000000	300	7508.78072499	7501.27194427	487500.00000000	1.95	win	2026-07-22 07:05:00.833	2026-07-22 07:01:49.843059	2026-07-22 07:05:06.649	193	\N	f	\N	1950000.00000000	2187500.00000000
126	b74441c4-1858-43f0-afdc-fbfec02ce9d5	SP500	short	200000.00000000	300	7498.51543920	7491.01692376	390000.00000000	1.95	win	2026-07-23 01:35:00.308	2026-07-23 01:31:21.318509	2026-07-23 01:35:06.591	127	\N	f	\N	2187500.00000000	2377500.00000000
128	3007b845-7394-4cb1-81d7-7a5289591da2	SP500	short	500000.00000000	300	7498.99454679	7506.49354134	0.00000000	1.95	lose	2026-07-23 04:10:00.116	2026-07-23 04:06:07.130138	2026-07-23 04:10:06.817	158	\N	f	\N	5000000.00000000	4500000.00000000
142	b74441c4-1858-43f0-afdc-fbfec02ce9d5	SP500	short	950000.00000000	300	7498.77592124	7491.27714532	1852500.00000000	1.95	win	2026-07-23 07:15:00.354	2026-07-23 07:11:10.379567	2026-07-23 07:15:05.448	195	\N	f	\N	1677500.00000000	2580000.00000000
150	74852c63-bd9c-4a75-b98a-14f2ad7393c7	SP500	short	1200000.00000000	300	7408.16304657	7400.75488352	2340000.00000000	1.95	win	2026-07-24 04:35:00.118	2026-07-24 04:31:16.12712	2026-07-24 04:35:05.222	163	\N	f	\N	33733500.00000000	34873500.00000000
132	74852c63-bd9c-4a75-b98a-14f2ad7393c7	SP500	short	1500000.00000000	300	7498.59062985	7491.09203922	2925000.00000000	1.95	win	2026-07-23 04:55:00.312	2026-07-23 04:50:48.321763	2026-07-23 04:55:07.216	167	\N	f	\N	31121000.00000000	32546000.00000000
133	74852c63-bd9c-4a75-b98a-14f2ad7393c7	SP500	short	1000000.00000000	300	7499.26195308	7491.76269113	1950000.00000000	1.95	win	2026-07-23 05:00:00.637	2026-07-23 04:56:55.647545	2026-07-23 05:00:07.258	168	\N	f	\N	32546000.00000000	33496000.00000000
134	3007b845-7394-4cb1-81d7-7a5289591da2	SP500	long	50000.00000000	300	7499.27719023	7499.16060517	0.00000000	1.95	lose	2026-07-23 06:20:00.821	2026-07-23 06:17:32.830744	2026-07-23 06:20:06.599	184	\N	f	\N	5000000.00000000	4950000.00000000
143	55cd7cf5-4d59-4914-affa-f306a49ff5c2	SP500	short	30000.00000000	300	7408.22386876	7400.81564489	58500.00000000	1.95	win	2026-07-24 00:25:00.375	2026-07-24 00:23:24.386567	2026-07-24 00:25:06.114	113	\N	f	\N	3000000.00000000	3028500.00000000
136	b74441c4-1858-43f0-afdc-fbfec02ce9d5	SP500	short	200000.00000000	300	7498.88239471	7506.38127710	0.00000000	1.95	lose	2026-07-23 07:05:00.546	2026-07-23 07:00:17.567303	2026-07-23 07:05:07.37	193	\N	f	\N	2377500.00000000	2177500.00000000
140	b74441c4-1858-43f0-afdc-fbfec02ce9d5	SP500	long	500000.00000000	300	7498.42517469	7490.92674952	0.00000000	1.95	lose	2026-07-23 07:10:00.768	2026-07-23 07:07:02.77582	2026-07-23 07:10:07.391	194	\N	f	\N	2177500.00000000	1677500.00000000
147	55cd7cf5-4d59-4914-affa-f306a49ff5c2	SP500	long	250000.00000000	300	7408.46640357	7415.87486997	487500.00000000	1.95	win	2026-07-24 01:35:00.049	2026-07-24 01:31:14.058577	2026-07-24 01:35:05.235	127	\N	f	\N	3000000.00000000	3237500.00000000
148	b74441c4-1858-43f0-afdc-fbfec02ce9d5	SP500	long	250000.00000000	300	7408.58651158	7415.99509809	487500.00000000	1.95	win	2026-07-24 01:35:00.218	2026-07-24 01:32:00.22662	2026-07-24 01:35:05.269	127	\N	f	\N	2580000.00000000	2817500.00000000
144	c84ca9f9-1efe-4ff4-a37d-ff9c3237b279	SP500	long	250000.00000000	300	7408.27065222	7415.67892287	487500.00000000	1.95	win	2026-07-24 01:35:00.675	2026-07-24 01:30:44.683584	2026-07-24 01:35:05.834	127	\N	f	\N	20460000.00000000	20697500.00000000
145	74852c63-bd9c-4a75-b98a-14f2ad7393c7	SP500	long	250000.00000000	300	7408.40464436	7415.81304900	487500.00000000	1.95	win	2026-07-24 01:35:00.724	2026-07-24 01:30:50.733711	2026-07-24 01:35:05.881	127	\N	f	\N	33496000.00000000	33733500.00000000
152	74852c63-bd9c-4a75-b98a-14f2ad7393c7	SP500	long	1200000.00000000	300	7407.15588202	7414.56303790	2340000.00000000	1.95	win	2026-07-24 04:40:00.633	2026-07-24 04:36:43.642257	2026-07-24 04:40:06.621	164	\N	f	\N	34873500.00000000	36013500.00000000
158	b74441c4-1858-43f0-afdc-fbfec02ce9d5	SP500	long	250000.00000000	300	7408.22801385	7400.81978584	0.00000000	1.95	lose	2026-07-24 07:05:00.422	2026-07-24 07:00:56.435986	2026-07-24 07:05:06.835	193	\N	f	\N	2817500.00000000	2567500.00000000
155	3007b845-7394-4cb1-81d7-7a5289591da2	SP500	short	50000.00000000	300	7408.53037726	7401.12184688	97500.00000000	1.95	win	2026-07-24 07:05:00.569	2026-07-24 07:00:12.580378	2026-07-24 07:05:06.739	193	\N	f	\N	4950000.00000000	4997500.00000000
156	74852c63-bd9c-4a75-b98a-14f2ad7393c7	SP500	long	250000.00000000	300	7408.57316307	7401.16458991	0.00000000	1.95	lose	2026-07-24 07:05:00.927	2026-07-24 07:00:32.936821	2026-07-24 07:05:06.771	193	\N	f	\N	36013500.00000000	35763500.00000000
161	74852c63-bd9c-4a75-b98a-14f2ad7393c7	SP500	short	450000.00000000	300	7407.42990689	7400.02247698	877500.00000000	1.95	win	2026-07-24 07:10:00.072	2026-07-24 07:06:12.081606	2026-07-24 07:10:05.089	194	\N	f	\N	35763500.00000000	36191000.00000000
163	b74441c4-1858-43f0-afdc-fbfec02ce9d5	SP500	short	450000.00000000	300	7407.91158572	7400.50367413	877500.00000000	1.95	win	2026-07-24 07:10:00.163	2026-07-24 07:06:38.172024	2026-07-24 07:10:06.781	194	\N	f	\N	2567500.00000000	2995000.00000000
160	3007b845-7394-4cb1-81d7-7a5289591da2	SP500	long	250000.00000000	300	7408.10602318	7400.69791716	0.00000000	1.95	lose	2026-07-24 07:10:00.12	2026-07-24 07:05:39.131254	2026-07-24 07:10:06.812	194	\N	f	\N	4997500.00000000	4747500.00000000
165	3007b845-7394-4cb1-81d7-7a5289591da2	SP500	short	450000.00000000	300	7407.89059858	7400.48270798	877500.00000000	1.95	win	2026-07-24 07:15:00.49	2026-07-24 07:11:12.500468	2026-07-24 07:15:06.84	195	\N	f	\N	4747500.00000000	5175000.00000000
167	b74441c4-1858-43f0-afdc-fbfec02ce9d5	SP500	short	200000.00000000	300	7411.24404014	7418.65528418	0.00000000	1.95	lose	2026-07-27 01:35:00.008	2026-07-27 01:30:45.017395	2026-07-27 01:35:05.171	127	\N	f	\N	2995000.00000000	2795000.00000000
169	3007b845-7394-4cb1-81d7-7a5289591da2	SP500	short	200000.00000000	300	7411.88280882	7419.29469163	0.00000000	1.95	lose	2026-07-27 01:35:00.134	2026-07-27 01:31:38.145311	2026-07-27 01:35:05.208	127	\N	f	\N	5175000.00000000	4975000.00000000
168	74852c63-bd9c-4a75-b98a-14f2ad7393c7	SP500	short	200000.00000000	300	7411.64075434	7419.05239509	0.00000000	1.95	lose	2026-07-27 01:35:00.979	2026-07-27 01:30:46.989861	2026-07-27 01:35:06.717	127	\N	f	\N	36191000.00000000	35991000.00000000
181	680bfe1a-2a6d-4661-8111-c86c439f1598	SP500	long	200000.00000000	300	7411.60107038	7404.18946931	0.00000000	1.95	lose	2026-07-27 07:05:00.037	2026-07-27 07:00:05.047044	2026-07-27 07:05:05.573	193	\N	f	\N	3047500.00000000	2847500.00000000
170	b74441c4-1858-43f0-afdc-fbfec02ce9d5	SP500	long	300000.00000000	300	7411.59282394	7404.18123112	0.00000000	1.95	lose	2026-07-27 01:40:00.013	2026-07-27 01:35:47.023693	2026-07-27 01:40:05.198	128	\N	f	\N	2795000.00000000	2495000.00000000
172	74852c63-bd9c-4a75-b98a-14f2ad7393c7	SP500	long	35991000.00000000	300	7410.78777516	7403.37698738	0.00000000	1.95	lose	2026-07-27 01:40:00.032	2026-07-27 01:36:04.041235	2026-07-27 01:40:05.233	128	\N	f	\N	35991000.00000000	0.00000000
192	55cd7cf5-4d59-4914-affa-f306a49ff5c2	SP500	long	500000.00000000	300	7412.74661083	7405.33386422	0.00000000	1.95	lose	2026-07-27 07:10:00.191	2026-07-27 07:06:16.201764	2026-07-27 07:10:05.667	194	\N	f	\N	1237500.00000000	737500.00000000
173	3007b845-7394-4cb1-81d7-7a5289591da2	SP500	long	300000.00000000	300	7412.79389593	7405.38110203	0.00000000	1.95	lose	2026-07-27 01:40:00.417	2026-07-27 01:37:19.426508	2026-07-27 01:40:06.753	128	\N	f	\N	4975000.00000000	4675000.00000000
183	55cd7cf5-4d59-4914-affa-f306a49ff5c2	SP500	long	2000000.00000000	300	7411.43687615	7404.02543927	0.00000000	1.95	lose	2026-07-27 07:05:00.057	2026-07-27 07:00:20.068367	2026-07-27 07:05:05.631	193	\N	f	\N	3237500.00000000	1237500.00000000
199	55cd7cf5-4d59-4914-affa-f306a49ff5c2	SP500	short	700000.00000000	300	7411.98000000	7419.39198000	0.00000000	1.95	lose	2026-07-27 07:15:00.977	2026-07-27 07:11:55.986597	2026-07-27 07:15:07.038	195	\N	f	\N	737500.00000000	37500.00000000
175	b74441c4-1858-43f0-afdc-fbfec02ce9d5	SP500	long	800000.00000000	300	7412.56066345	7419.97322411	1560000.00000000	1.95	win	2026-07-27 01:45:00.545	2026-07-27 01:40:55.555858	2026-07-27 01:45:06.808	129	\N	f	\N	2495000.00000000	3255000.00000000
176	3007b845-7394-4cb1-81d7-7a5289591da2	SP500	long	800000.00000000	300	7411.44395240	7418.85539635	1560000.00000000	1.95	win	2026-07-27 01:45:00.53	2026-07-27 01:41:04.540714	2026-07-27 01:45:06.843	129	\N	f	\N	4675000.00000000	5435000.00000000
188	680bfe1a-2a6d-4661-8111-c86c439f1598	SP500	long	500000.00000000	300	7412.00726725	7404.59525998	0.00000000	1.95	lose	2026-07-27 07:10:00.939	2026-07-27 07:05:45.948593	2026-07-27 07:10:06.999	194	\N	f	\N	2847500.00000000	2347500.00000000
177	680bfe1a-2a6d-4661-8111-c86c439f1598	SP500	long	50000.00000000	300	7410.92629027	7418.33721656	97500.00000000	1.95	win	2026-07-27 04:20:00.609	2026-07-27 04:15:47.619653	2026-07-27 04:20:05.777	160	\N	f	\N	3000000.00000000	3047500.00000000
186	3007b845-7394-4cb1-81d7-7a5289591da2	SP500	long	200000.00000000	300	7412.13491956	7404.72278464	0.00000000	1.95	lose	2026-07-27 07:05:00.54	2026-07-27 07:00:48.550796	2026-07-27 07:05:05.691	193	\N	f	\N	5435000.00000000	5235000.00000000
194	680bfe1a-2a6d-4661-8111-c86c439f1598	SP500	short	700000.00000000	300	7411.95073219	7419.36268292	0.00000000	1.95	lose	2026-07-27 07:15:00.2	2026-07-27 07:10:41.210726	2026-07-27 07:15:05.682	195	\N	f	\N	2347500.00000000	1647500.00000000
184	b74441c4-1858-43f0-afdc-fbfec02ce9d5	SP500	long	200000.00000000	300	7411.87780972	7404.46593191	0.00000000	1.95	lose	2026-07-27 07:05:00.824	2026-07-27 07:00:21.833313	2026-07-27 07:05:06.957	193	\N	f	\N	3255000.00000000	3055000.00000000
180	c84ca9f9-1efe-4ff4-a37d-ff9c3237b279	SP500	long	200000.00000000	300	7412.11344854	7404.70133509	0.00000000	1.95	lose	2026-07-27 07:05:00.099	2026-07-27 07:00:00.11178	2026-07-27 07:05:05.542	193	\N	f	\N	20697500.00000000	20497500.00000000
187	c84ca9f9-1efe-4ff4-a37d-ff9c3237b279	SP500	long	500000.00000000	300	7411.73924359	7404.32750435	0.00000000	1.95	lose	2026-07-27 07:10:00.399	2026-07-27 07:05:40.413407	2026-07-27 07:10:05.595	194	\N	f	\N	20497500.00000000	19997500.00000000
191	3007b845-7394-4cb1-81d7-7a5289591da2	SP500	long	5000000.00000000	300	7412.02340591	7404.61138250	0.00000000	1.95	lose	2026-07-27 07:10:00.664	2026-07-27 07:06:05.674982	2026-07-27 07:10:07.071	194	\N	f	\N	5235000.00000000	235000.00000000
193	b74441c4-1858-43f0-afdc-fbfec02ce9d5	SP500	long	500000.00000000	300	7410.79018976	7403.37939957	0.00000000	1.95	lose	2026-07-27 07:10:00.795	2026-07-27 07:07:04.803953	2026-07-27 07:10:07.107	194	\N	f	\N	3055000.00000000	2555000.00000000
196	c84ca9f9-1efe-4ff4-a37d-ff9c3237b279	SP500	short	700000.00000000	300	7411.94440439	7419.35634879	0.00000000	1.95	lose	2026-07-27 07:15:00.634	2026-07-27 07:11:11.646169	2026-07-27 07:15:05.737	195	\N	f	\N	19997500.00000000	19297500.00000000
198	b74441c4-1858-43f0-afdc-fbfec02ce9d5	SP500	short	700000.00000000	300	7412.22905327	7419.64128232	0.00000000	1.95	lose	2026-07-27 07:15:00.442	2026-07-27 07:11:26.44923	2026-07-27 07:15:05.761	195	\N	f	\N	2555000.00000000	1855000.00000000
200	680bfe1a-2a6d-4661-8111-c86c439f1598	SP500	short	1600000.00000000	300	7412.00156756	7404.58956599	3120000.00000000	1.95	win	2026-07-27 07:20:00.292	2026-07-27 07:15:54.302477	2026-07-27 07:20:05.729	196	\N	f	\N	1647500.00000000	3167500.00000000
202	b74441c4-1858-43f0-afdc-fbfec02ce9d5	SP500	short	1600000.00000000	300	7411.84333871	7404.43149537	3120000.00000000	1.95	win	2026-07-27 07:20:00.387	2026-07-27 07:16:09.397458	2026-07-27 07:20:05.809	196	\N	f	\N	1855000.00000000	3375000.00000000
203	c84ca9f9-1efe-4ff4-a37d-ff9c3237b279	SP500	short	1600000.00000000	300	7411.61637960	7404.20476322	3120000.00000000	1.95	win	2026-07-27 07:20:00.295	2026-07-27 07:16:19.312812	2026-07-27 07:20:05.84	196	\N	f	\N	19297500.00000000	20817500.00000000
205	55cd7cf5-4d59-4914-affa-f306a49ff5c2	SP500	short	200000.00000000	300	7411.25142827	7403.84017684	390000.00000000	1.95	win	2026-07-27 08:00:00.097	2026-07-27 07:56:04.104191	2026-07-27 08:00:05.418	204	\N	f	\N	3037500.00000000	3227500.00000000
206	55cd7cf5-4d59-4914-affa-f306a49ff5c2	SP500	long	200000.00000000	300	7411.77702522	7419.18880225	390000.00000000	1.95	win	2026-07-27 08:05:00.851	2026-07-27 08:01:03.861826	2026-07-27 08:05:06.534	205	\N	f	\N	3227500.00000000	3417500.00000000
207	680bfe1a-2a6d-4661-8111-c86c439f1598	SP500	short	10000.00000000	300	7431.04553783	7419.87565923	19500.00000000	1.95	win	2026-07-27 14:25:00.459	2026-07-27 14:21:43.468268	2026-07-27 14:25:06.571	281	\N	f	\N	3167500.00000000	3177000.00000000
208	680bfe1a-2a6d-4661-8111-c86c439f1598	SP500	short	77000.00000000	300	7413.35014196	7408.00811770	150150.00000000	1.95	win	2026-07-27 14:30:00.969	2026-07-27 14:28:34.978883	2026-07-27 14:30:06.816	282	\N	f	\N	3177000.00000000	3250150.00000000
209	680bfe1a-2a6d-4661-8111-c86c439f1598	SP500	long	250000.00000000	300	7399.22942992	7404.41000000	487500.00000000	1.95	win	2026-07-27 14:50:00.072	2026-07-27 14:49:01.082682	2026-07-27 14:50:06.616	286	\N	f	\N	3250150.00000000	3487650.00000000
210	680bfe1a-2a6d-4661-8111-c86c439f1598	SP500	long	487650.00000000	300	7417.53772334	7418.19981725	950917.50000000	1.95	win	2026-07-27 15:00:00.184	2026-07-27 14:59:01.194727	2026-07-27 15:00:06.317	288	\N	f	\N	3487650.00000000	3950917.50000000
226	c84ca9f9-1efe-4ff4-a37d-ff9c3237b279	SP500	long	150000.00000000	300	7413.07853626	7420.49161480	292500.00000000	1.95	win	2026-07-28 01:35:00.56	2026-07-28 01:31:52.569131	2026-07-28 01:35:05.868	127	\N	f	\N	20817500.00000000	20960000.00000000
211	680bfe1a-2a6d-4661-8111-c86c439f1598	SP500	short	200000.00000000	300	7406.92146803	7411.95000000	0.00000000	1.95	lose	2026-07-27 15:20:00.947	2026-07-27 15:18:58.957042	2026-07-27 15:20:06.616	4	\N	f	\N	3950918.00000000	3750918.00000000
212	680bfe1a-2a6d-4661-8111-c86c439f1598	SP500	short	50000.00000000	300	7406.20407604	7406.21000000	0.00000000	1.95	lose	2026-07-27 15:25:00.403	2026-07-27 15:23:58.41119	2026-07-27 15:25:06.416	5	\N	f	\N	3750918.00000000	3700918.00000000
213	680bfe1a-2a6d-4661-8111-c86c439f1598	SP500	long	10000.00000000	300	7403.89772055	7405.27378899	19500.00000000	1.95	win	2026-07-27 15:30:00.844	2026-07-27 15:29:00.851561	2026-07-27 15:30:07.108	6	\N	f	\N	3700918.00000000	3710418.00000000
214	680bfe1a-2a6d-4661-8111-c86c439f1598	SP500	short	10000.00000000	300	7398.49769612	7397.59000000	19500.00000000	1.95	win	2026-07-27 15:35:00.588	2026-07-27 15:33:58.598177	2026-07-27 15:35:06.816	7	\N	f	\N	3710418.00000000	3719918.00000000
222	55cd7cf5-4d59-4914-affa-f306a49ff5c2	SP500	long	150000.00000000	300	7413.78913285	7421.20292198	292500.00000000	1.95	win	2026-07-28 01:35:00.638	2026-07-28 01:30:27.646946	2026-07-28 01:35:06.379	127	\N	f	\N	3987500.00000000	4130000.00000000
215	680bfe1a-2a6d-4661-8111-c86c439f1598	SP500	short	19000.00000000	300	7393.39430527	7396.41304332	0.00000000	1.95	lose	2026-07-27 15:45:00.911	2026-07-27 15:44:00.921914	2026-07-27 15:45:07.2	9	\N	f	\N	3719918.00000000	3700918.00000000
237	c84ca9f9-1efe-4ff4-a37d-ff9c3237b279	SP500	short	850000.00000000	300	7412.50602435	7405.09351833	1657500.00000000	1.95	win	2026-07-28 01:50:00.453	2026-07-28 01:46:10.463289	2026-07-28 01:50:06.446	130	\N	f	\N	20260000.00000000	21067500.00000000
216	680bfe1a-2a6d-4661-8111-c86c439f1598	SP500	short	50000.00000000	300	7393.51798601	7391.14776961	97500.00000000	1.95	win	2026-07-27 15:50:00.846	2026-07-27 15:49:00.855766	2026-07-27 15:50:07.239	10	\N	f	\N	3700918.00000000	3748418.00000000
223	680bfe1a-2a6d-4661-8111-c86c439f1598	SP500	long	150000.00000000	300	7413.03577600	7420.44881178	292500.00000000	1.95	win	2026-07-28 01:35:00.93	2026-07-28 01:31:05.93984	2026-07-28 01:35:06.414	127	\N	f	\N	3748418.00000000	3890918.00000000
217	55cd7cf5-4d59-4914-affa-f306a49ff5c2	SP500	short	300000.00000000	300	7413.83576102	7406.42192526	585000.00000000	1.95	win	2026-07-28 01:05:00.155	2026-07-28 01:01:29.165232	2026-07-28 01:05:05.838	121	\N	f	\N	3417500.00000000	3702500.00000000
218	3007b845-7394-4cb1-81d7-7a5289591da2	SP500	short	1000000.00000000	300	7412.58916835	7405.17657918	1950000.00000000	1.95	win	2026-07-28 01:05:00.68	2026-07-28 01:04:10.690302	2026-07-28 01:05:05.881	121	\N	f	\N	10085000.00000000	11035000.00000000
219	55cd7cf5-4d59-4914-affa-f306a49ff5c2	SP500	long	300000.00000000	300	7413.59254949	7421.00614204	585000.00000000	1.95	win	2026-07-28 01:10:00.876	2026-07-28 01:06:37.886253	2026-07-28 01:10:05.945	122	\N	f	\N	3702500.00000000	3987500.00000000
220	3007b845-7394-4cb1-81d7-7a5289591da2	SP500	long	1000000.00000000	300	7414.01483823	7421.42885307	1950000.00000000	1.95	win	2026-07-28 01:10:00.521	2026-07-28 01:07:40.530981	2026-07-28 01:10:05.98	122	\N	f	\N	11035000.00000000	11985000.00000000
224	b74441c4-1858-43f0-afdc-fbfec02ce9d5	SP500	long	150000.00000000	300	7412.85449671	7420.26735121	292500.00000000	1.95	win	2026-07-28 01:35:00.18	2026-07-28 01:31:44.190237	2026-07-28 01:35:05.812	127	\N	f	\N	3375000.00000000	3517500.00000000
225	3007b845-7394-4cb1-81d7-7a5289591da2	SP500	long	150000.00000000	300	7412.72105995	7420.13378101	292500.00000000	1.95	win	2026-07-28 01:35:00.316	2026-07-28 01:31:46.326658	2026-07-28 01:35:05.841	127	\N	f	\N	11985000.00000000	12127500.00000000
233	b74441c4-1858-43f0-afdc-fbfec02ce9d5	SP500	long	350000.00000000	300	7413.45395708	7406.04050312	0.00000000	1.95	lose	2026-07-28 01:45:00.241	2026-07-28 01:41:01.252427	2026-07-28 01:45:06.324	129	\N	f	\N	3167500.00000000	2817500.00000000
227	b74441c4-1858-43f0-afdc-fbfec02ce9d5	SP500	short	350000.00000000	300	7413.17443214	7420.58760657	0.00000000	1.95	lose	2026-07-28 01:40:00.585	2026-07-28 01:36:00.595827	2026-07-28 01:40:06.116	128	\N	f	\N	3517500.00000000	3167500.00000000
228	55cd7cf5-4d59-4914-affa-f306a49ff5c2	SP500	short	350000.00000000	300	7412.58147343	7419.99405490	0.00000000	1.95	lose	2026-07-28 01:40:00.643	2026-07-28 01:36:08.651964	2026-07-28 01:40:06.342	128	\N	f	\N	4130000.00000000	3780000.00000000
234	55cd7cf5-4d59-4914-affa-f306a49ff5c2	SP500	long	350000.00000000	300	7413.18000000	7405.76682000	0.00000000	1.95	lose	2026-07-28 01:45:00.017	2026-07-28 01:41:02.028503	2026-07-28 01:45:06.361	129	\N	f	\N	3780000.00000000	3430000.00000000
229	c84ca9f9-1efe-4ff4-a37d-ff9c3237b279	SP500	short	350000.00000000	300	7413.52169843	7420.93522013	0.00000000	1.95	lose	2026-07-28 01:40:00.219	2026-07-28 01:36:35.228723	2026-07-28 01:40:06.379	128	\N	f	\N	20960000.00000000	20610000.00000000
238	b74441c4-1858-43f0-afdc-fbfec02ce9d5	SP500	short	850000.00000000	300	7412.32440350	7404.91207910	1657500.00000000	1.95	win	2026-07-28 01:50:00.567	2026-07-28 01:46:11.579203	2026-07-28 01:50:06.478	130	\N	f	\N	2817500.00000000	3625000.00000000
230	3007b845-7394-4cb1-81d7-7a5289591da2	SP500	short	350000.00000000	300	7412.93663879	7420.34957543	0.00000000	1.95	lose	2026-07-28 01:40:00.38	2026-07-28 01:36:48.390388	2026-07-28 01:40:06.418	128	\N	f	\N	12127500.00000000	11777500.00000000
235	680bfe1a-2a6d-4661-8111-c86c439f1598	SP500	long	150000.00000000	300	7413.60000399	7406.18640399	0.00000000	1.95	lose	2026-07-28 01:45:00.849	2026-07-28 01:43:58.858726	2026-07-28 01:45:06.399	129	\N	f	\N	390918.00000000	240918.00000000
231	680bfe1a-2a6d-4661-8111-c86c439f1598	SP500	short	3500000.00000000	300	7412.32238946	7419.73471185	0.00000000	1.95	lose	2026-07-28 01:40:00.225	2026-07-28 01:38:37.23732	2026-07-28 01:40:06.459	128	\N	f	\N	3890918.00000000	390918.00000000
241	55cd7cf5-4d59-4914-affa-f306a49ff5c2	SP500	short	150000.00000000	300	7412.86233602	7412.83686177	292500.00000000	1.95	win	2026-07-28 04:40:00.892	2026-07-28 04:36:45.90161	2026-07-28 04:40:06.897	164	\N	f	\N	4475000.00000000	4617500.00000000
232	c84ca9f9-1efe-4ff4-a37d-ff9c3237b279	SP500	long	350000.00000000	300	7413.59411893	7406.18052481	0.00000000	1.95	lose	2026-07-28 01:45:00.208	2026-07-28 01:40:53.218971	2026-07-28 01:45:06.437	129	\N	f	\N	20610000.00000000	20260000.00000000
239	55cd7cf5-4d59-4914-affa-f306a49ff5c2	SP500	short	850000.00000000	300	7413.05992868	7405.64686875	1657500.00000000	1.95	win	2026-07-28 01:50:00.005	2026-07-28 01:46:23.01466	2026-07-28 01:50:06.511	130	\N	f	\N	3430000.00000000	4237500.00000000
236	3007b845-7394-4cb1-81d7-7a5289591da2	SP500	long	350000.00000000	300	7412.67166810	7405.25899643	0.00000000	1.95	lose	2026-07-28 01:50:00.117	2026-07-28 01:45:22.126795	2026-07-28 01:50:06.412	130	\N	f	\N	11777500.00000000	11427500.00000000
240	55cd7cf5-4d59-4914-affa-f306a49ff5c2	SP500	short	250000.00000000	300	7413.98376737	7413.30290516	487500.00000000	1.95	win	2026-07-28 04:35:00.136	2026-07-28 04:31:01.150907	2026-07-28 04:35:05.16	163	\N	f	\N	4237500.00000000	4475000.00000000
244	b74441c4-1858-43f0-afdc-fbfec02ce9d5	SP500	short	200000.00000000	300	7412.56009162	7405.14753153	390000.00000000	1.95	win	2026-07-28 07:05:00.312	2026-07-28 07:00:38.323462	2026-07-28 07:05:05.439	193	\N	f	\N	3625000.00000000	3815000.00000000
245	3007b845-7394-4cb1-81d7-7a5289591da2	SP500	short	200000.00000000	300	7413.36655895	7405.95319239	390000.00000000	1.95	win	2026-07-28 07:05:00.198	2026-07-28 07:00:59.208602	2026-07-28 07:05:05.473	193	\N	f	\N	11427500.00000000	11617500.00000000
247	3007b845-7394-4cb1-81d7-7a5289591da2	SP500	short	900000.00000000	300	7428.25908350	7420.83082442	1755000.00000000	1.95	win	2026-07-29 01:05:00.674	2026-07-29 01:01:03.688953	2026-07-29 01:05:05.909	121	\N	f	\N	16617500.00000000	17472500.00000000
246	55cd7cf5-4d59-4914-affa-f306a49ff5c2	SP500	short	900000.00000000	300	7429.13670016	7421.70756346	1755000.00000000	1.95	win	2026-07-29 01:05:00.739	2026-07-29 01:00:40.749314	2026-07-29 01:05:05.946	121	\N	f	\N	29600000.00000000	30455000.00000000
248	55cd7cf5-4d59-4914-affa-f306a49ff5c2	SP500	short	950000.00000000	300	7428.48579616	7421.05731036	1852500.00000000	1.95	win	2026-07-29 01:10:00.627	2026-07-29 01:06:17.638298	2026-07-29 01:10:05.962	122	\N	f	\N	30455000.00000000	31357500.00000000
249	3007b845-7394-4cb1-81d7-7a5289591da2	SP500	short	950000.00000000	300	7428.51666702	7421.08815035	1852500.00000000	1.95	win	2026-07-29 01:10:00.807	2026-07-29 01:06:44.816853	2026-07-29 01:10:05.998	122	\N	f	\N	17472500.00000000	18375000.00000000
250	55cd7cf5-4d59-4914-affa-f306a49ff5c2	SP500	short	250000.00000000	300	7428.66160625	7421.23294464	487500.00000000	1.95	win	2026-07-29 01:35:00.101	2026-07-29 01:30:28.110529	2026-07-29 01:35:06.337	127	\N	f	\N	31000000.00000000	31237500.00000000
251	b74441c4-1858-43f0-afdc-fbfec02ce9d5	SP500	short	250000.00000000	300	7428.79361179	7421.36481818	487500.00000000	1.95	win	2026-07-29 01:35:00.33	2026-07-29 01:30:35.340044	2026-07-29 01:35:06.369	127	\N	f	\N	3815000.00000000	4052500.00000000
252	3007b845-7394-4cb1-81d7-7a5289591da2	SP500	short	250000.00000000	300	7428.78983048	7421.36104065	487500.00000000	1.95	win	2026-07-29 01:35:00.957	2026-07-29 01:31:44.965828	2026-07-29 01:35:06.398	127	\N	f	\N	18375000.00000000	18612500.00000000
265	680bfe1a-2a6d-4661-8111-c86c439f1598	SP500	short	50000.00000000	300	7401.63910044	7402.25602638	0.00000000	1.95	lose	2026-07-29 13:55:00.404	2026-07-29 13:53:51.414257	2026-07-29 13:55:06.938	275	\N	f	\N	140918.00000000	90918.00000000
253	55cd7cf5-4d59-4914-affa-f306a49ff5c2	SP500	long	1100000.00000000	300	7428.59244893	7436.02104138	2145000.00000000	1.95	win	2026-07-29 06:05:00.807	2026-07-29 06:03:14.81812	2026-07-29 06:05:06.284	181	\N	f	\N	56000000.00000000	57045000.00000000
254	55cd7cf5-4d59-4914-affa-f306a49ff5c2	SP500	short	1400000.00000000	300	7428.59906112	7421.17046206	2730000.00000000	1.95	win	2026-07-29 06:15:00.222	2026-07-29 06:10:59.236981	2026-07-29 06:15:06.377	183	\N	f	\N	57045000.00000000	58375000.00000000
255	55cd7cf5-4d59-4914-affa-f306a49ff5c2	SP500	short	250000.00000000	300	7428.71222491	7436.14093713	0.00000000	1.95	lose	2026-07-29 07:05:00.03	2026-07-29 07:00:23.039518	2026-07-29 07:05:05.126	193	\N	f	\N	58375000.00000000	58125000.00000000
266	680bfe1a-2a6d-4661-8111-c86c439f1598	SP500	short	50000.00000000	300	7394.80591768	7399.09593794	0.00000000	1.95	lose	2026-07-29 14:00:00.733	2026-07-29 13:58:47.741578	2026-07-29 14:00:06.976	276	\N	f	\N	90918.00000000	40918.00000000
257	3007b845-7394-4cb1-81d7-7a5289591da2	SP500	short	250000.00000000	300	7429.85433179	7437.28418612	0.00000000	1.95	lose	2026-07-29 07:05:00.984	2026-07-29 07:00:40.994461	2026-07-29 07:05:07.159	193	\N	f	\N	18612500.00000000	18362500.00000000
281	3007b845-7394-4cb1-81d7-7a5289591da2	SP500	short	200000.00000000	300	7315.41426334	7308.09884908	390000.00000000	1.95	win	2026-07-30 07:05:00.595	2026-07-30 07:00:41.603831	2026-07-30 07:05:06.329	193	\N	f	\N	21390000.00000000	21580000.00000000
258	b74441c4-1858-43f0-afdc-fbfec02ce9d5	SP500	short	250000.00000000	300	7428.41296095	7435.84137391	0.00000000	1.95	lose	2026-07-29 07:05:00.937	2026-07-29 07:00:50.946623	2026-07-29 07:05:07.204	193	\N	f	\N	4052500.00000000	3802500.00000000
267	680bfe1a-2a6d-4661-8111-c86c439f1598	SP500	long	40918.00000000	300	7399.84841018	7399.82472295	0.00000000	1.95	lose	2026-07-29 14:05:00.972	2026-07-29 14:03:58.978388	2026-07-29 14:05:07.03	277	\N	f	\N	40918.00000000	0.00000000
259	b74441c4-1858-43f0-afdc-fbfec02ce9d5	SP500	short	500000.00000000	300	7428.73372539	7421.30499166	975000.00000000	1.95	win	2026-07-29 07:10:00.358	2026-07-29 07:05:41.368853	2026-07-29 07:10:07.148	194	\N	f	\N	3802500.00000000	4277500.00000000
274	3007b845-7394-4cb1-81d7-7a5289591da2	SP500	long	250000.00000000	300	7316.41285908	7309.09644622	0.00000000	1.95	lose	2026-07-30 01:35:00.767	2026-07-30 01:30:59.774232	2026-07-30 01:35:07.036	127	\N	f	\N	21212500.00000000	20962500.00000000
260	55cd7cf5-4d59-4914-affa-f306a49ff5c2	SP500	short	500000.00000000	300	7428.78000000	7421.35122000	975000.00000000	1.95	win	2026-07-29 07:10:00.589	2026-07-29 07:05:43.599087	2026-07-29 07:10:07.177	194	\N	f	\N	58125000.00000000	58600000.00000000
268	3007b845-7394-4cb1-81d7-7a5289591da2	SP500	short	1200000.00000000	300	7316.24689579	7308.93064889	2340000.00000000	1.95	win	2026-07-30 01:05:00.722	2026-07-30 01:01:30.731084	2026-07-30 01:05:06.721	121	\N	f	\N	18837500.00000000	19977500.00000000
261	3007b845-7394-4cb1-81d7-7a5289591da2	SP500	short	500000.00000000	300	7428.78000000	7421.35122000	975000.00000000	1.95	win	2026-07-29 07:10:00.764	2026-07-29 07:05:57.773541	2026-07-29 07:10:07.205	194	\N	f	\N	18362500.00000000	18837500.00000000
263	680bfe1a-2a6d-4661-8111-c86c439f1598	SP500	short	50000.00000000	300	7418.91689830	7420.66742633	0.00000000	1.95	lose	2026-07-29 13:45:00.6	2026-07-29 13:44:02.609133	2026-07-29 13:45:06.852	273	\N	f	\N	240918.00000000	190918.00000000
279	3007b845-7394-4cb1-81d7-7a5289591da2	SP500	short	450000.00000000	300	7316.99311459	7309.67612148	877500.00000000	1.95	win	2026-07-30 01:40:00.205	2026-07-30 01:36:23.2147	2026-07-30 01:40:07.083	128	\N	f	\N	20962500.00000000	21390000.00000000
264	680bfe1a-2a6d-4661-8111-c86c439f1598	SP500	short	50000.00000000	300	7415.51542499	7416.38118740	0.00000000	1.95	lose	2026-07-29 13:50:00.587	2026-07-29 13:49:01.598149	2026-07-29 13:50:06.886	274	\N	f	\N	190918.00000000	140918.00000000
269	3007b845-7394-4cb1-81d7-7a5289591da2	SP500	short	1300000.00000000	300	7315.71232470	7308.39661238	2535000.00000000	1.95	win	2026-07-30 01:10:00.937	2026-07-30 01:06:14.945351	2026-07-30 01:10:06.75	122	\N	f	\N	19977500.00000000	21212500.00000000
275	b74441c4-1858-43f0-afdc-fbfec02ce9d5	SP500	long	250000.00000000	300	7316.24238336	7308.92614098	0.00000000	1.95	lose	2026-07-30 01:35:00.796	2026-07-30 01:32:36.804636	2026-07-30 01:35:07.064	127	\N	f	\N	4277500.00000000	4027500.00000000
270	55cd7cf5-4d59-4914-affa-f306a49ff5c2	SP500	long	1700000.00000000	300	7316.08689229	7323.40297918	3315000.00000000	1.95	win	2026-07-30 01:15:00.482	2026-07-30 01:10:59.492177	2026-07-30 01:15:06.778	123	\N	f	\N	83375000.00000000	84990000.00000000
271	55cd7cf5-4d59-4914-affa-f306a49ff5c2	SP500	short	2300000.00000000	300	7316.89931040	7309.58241109	4485000.00000000	1.95	win	2026-07-30 01:20:00.325	2026-07-30 01:16:26.336786	2026-07-30 01:20:06.827	124	\N	f	\N	84990000.00000000	87175000.00000000
272	55cd7cf5-4d59-4914-affa-f306a49ff5c2	SP500	long	250000.00000000	300	7316.17553335	7308.85935782	0.00000000	1.95	lose	2026-07-30 01:35:00.619	2026-07-30 01:30:30.62821	2026-07-30 01:35:06.955	127	\N	f	\N	87175000.00000000	86925000.00000000
276	55cd7cf5-4d59-4914-affa-f306a49ff5c2	SP500	short	450000.00000000	300	7316.35223544	7309.03588320	877500.00000000	1.95	win	2026-07-30 01:40:00.056	2026-07-30 01:35:54.067211	2026-07-30 01:40:06.987	128	\N	f	\N	86925000.00000000	87352500.00000000
277	b74441c4-1858-43f0-afdc-fbfec02ce9d5	SP500	short	450000.00000000	300	7316.35223544	7309.03588320	877500.00000000	1.95	win	2026-07-30 01:40:00.177	2026-07-30 01:35:54.188211	2026-07-30 01:40:07.019	128	\N	f	\N	4027500.00000000	4455000.00000000
282	c84ca9f9-1efe-4ff4-a37d-ff9c3237b279	SP500	short	200000.00000000	300	7316.02311096	7308.70708785	390000.00000000	1.95	win	2026-07-30 07:05:00.705	2026-07-30 07:00:43.713348	2026-07-30 07:05:06.377	193	\N	f	\N	21067500.00000000	21257500.00000000
280	b74441c4-1858-43f0-afdc-fbfec02ce9d5	SP500	short	200000.00000000	300	7315.60392495	7308.28832103	390000.00000000	1.95	win	2026-07-30 07:05:00.83	2026-07-30 07:00:36.840673	2026-07-30 07:05:06.286	193	\N	f	\N	4455000.00000000	4645000.00000000
284	3007b845-7394-4cb1-81d7-7a5289591da2	SP500	long	1000000.00000000	300	7437.60770830	7430.17010059	0.00000000	1.95	lose	2026-07-31 01:05:00.493	2026-07-31 01:03:31.502216	2026-07-31 01:05:05.6	121	\N	f	\N	20580000.00000000	19580000.00000000
285	3007b845-7394-4cb1-81d7-7a5289591da2	SP500	short	2000000.00000000	300	7438.17519066	7430.73701547	3900000.00000000	1.95	win	2026-07-31 01:10:00.715	2026-07-31 01:06:43.725815	2026-07-31 01:10:07.641	122	\N	f	\N	19580000.00000000	21480000.00000000
286	55cd7cf5-4d59-4914-affa-f306a49ff5c2	SP500	long	200000.00000000	300	7437.49241111	7444.92990352	390000.00000000	1.95	win	2026-07-31 01:35:00.825	2026-07-31 01:30:57.835151	2026-07-31 01:35:06.022	127	\N	f	\N	82127500.00000000	82317500.00000000
288	3007b845-7394-4cb1-81d7-7a5289591da2	SP500	long	200000.00000000	300	7437.26056700	7444.69782757	390000.00000000	1.95	win	2026-07-31 01:35:00.031	2026-07-31 01:31:20.040849	2026-07-31 01:35:06.099	127	\N	f	\N	21480000.00000000	21670000.00000000
289	c84ca9f9-1efe-4ff4-a37d-ff9c3237b279	SP500	long	200000.00000000	300	7437.69177924	7445.12947102	390000.00000000	1.95	win	2026-07-31 01:35:00.667	2026-07-31 01:32:59.677721	2026-07-31 01:35:06.137	127	\N	f	\N	21257500.00000000	21447500.00000000
290	55cd7cf5-4d59-4914-affa-f306a49ff5c2	SP500	long	1500000.00000000	300	7437.30706940	7429.86976233	0.00000000	1.95	lose	2026-07-31 04:35:00.058	2026-07-31 04:31:19.06742	2026-07-31 04:35:07.022	163	\N	f	\N	82317500.00000000	80817500.00000000
291	55cd7cf5-4d59-4914-affa-f306a49ff5c2	SP500	long	3000000.00000000	300	7438.15160686	7445.58975847	5850000.00000000	1.95	win	2026-07-31 04:40:00.717	2026-07-31 04:36:27.727013	2026-07-31 04:40:07.058	164	\N	f	\N	80817500.00000000	83667500.00000000
292	55cd7cf5-4d59-4914-affa-f306a49ff5c2	SP500	short	2000000.00000000	300	7438.17467591	7430.73650123	3900000.00000000	1.95	win	2026-07-31 04:45:00.619	2026-07-31 04:41:20.631036	2026-07-31 04:45:07.125	165	\N	f	\N	83667500.00000000	85567500.00000000
293	55cd7cf5-4d59-4914-affa-f306a49ff5c2	SP500	short	200000.00000000	300	7437.60741632	7430.16980890	390000.00000000	1.95	win	2026-07-31 07:05:00.326	2026-07-31 07:00:39.337917	2026-07-31 07:05:05.572	193	\N	f	\N	85567500.00000000	85757500.00000000
306	3007b845-7394-4cb1-81d7-7a5289591da2	SP500	long	500000.00000000	300	7490.08241276	7497.57249517	975000.00000000	1.95	win	2026-08-03 04:10:00.525	2026-08-03 04:06:39.533449	2026-08-03 04:10:05.858	158	\N	f	\N	5000000.00000000	5475000.00000000
294	b74441c4-1858-43f0-afdc-fbfec02ce9d5	SP500	short	200000.00000000	300	7437.84949457	7430.41164508	390000.00000000	1.95	win	2026-07-31 07:05:00.166	2026-07-31 07:01:01.179602	2026-07-31 07:05:05.605	193	\N	f	\N	4645000.00000000	4835000.00000000
295	c84ca9f9-1efe-4ff4-a37d-ff9c3237b279	SP500	short	200000.00000000	300	7437.51557808	7430.07806250	390000.00000000	1.95	win	2026-07-31 07:05:00.179	2026-07-31 07:01:14.200772	2026-07-31 07:05:05.638	193	\N	f	\N	21447500.00000000	21637500.00000000
320	c84ca9f9-1efe-4ff4-a37d-ff9c3237b279	SP500	short	200000.00000000	300	7599.89925049	7592.29935124	390000.00000000	1.95	win	2026-08-04 01:35:00.23	2026-08-04 01:32:24.240061	2026-08-04 01:35:06.836	127	\N	f	\N	21627500.00000000	21817500.00000000
296	3007b845-7394-4cb1-81d7-7a5289591da2	SP500	short	200000.00000000	300	7437.38135421	7429.94397286	390000.00000000	1.95	win	2026-07-31 07:05:00.266	2026-07-31 07:01:17.276441	2026-07-31 07:05:05.67	193	\N	f	\N	21670000.00000000	21860000.00000000
307	3007b845-7394-4cb1-81d7-7a5289591da2	SP500	long	500000.00000000	300	7489.12895419	7496.61808314	975000.00000000	1.95	win	2026-08-03 04:15:00.406	2026-08-03 04:11:30.413493	2026-08-03 04:15:05.913	159	\N	f	\N	5475000.00000000	5950000.00000000
298	3007b845-7394-4cb1-81d7-7a5289591da2	SP500	long	21860000.00000000	300	7491.06239680	7483.57133440	0.00000000	1.95	lose	2026-08-03 01:05:00.02	2026-08-03 01:01:35.029995	2026-08-03 01:05:05.496	121	\N	f	\N	21860000.00000000	0.00000000
297	55cd7cf5-4d59-4914-affa-f306a49ff5c2	SP500	long	2000000.00000000	300	7489.56278381	7482.07322103	0.00000000	1.95	lose	2026-08-03 01:05:00.72	2026-08-03 01:00:06.731214	2026-08-03 01:05:05.976	121	\N	f	\N	85377500.00000000	83377500.00000000
299	55cd7cf5-4d59-4914-affa-f306a49ff5c2	SP500	long	4000000.00000000	300	7489.50320499	7496.99270819	7800000.00000000	1.95	win	2026-08-03 01:10:00.919	2026-08-03 01:05:40.927918	2026-08-03 01:10:06.021	122	\N	f	\N	83377500.00000000	87177500.00000000
300	55cd7cf5-4d59-4914-affa-f306a49ff5c2	SP500	short	2500000.00000000	300	7488.79982456	7481.31102474	4875000.00000000	1.95	win	2026-08-03 01:15:00.429	2026-08-03 01:11:04.438822	2026-08-03 01:15:05.691	123	\N	f	\N	87177500.00000000	89552500.00000000
301	b74441c4-1858-43f0-afdc-fbfec02ce9d5	SP500	short	200000.00000000	300	7489.14214497	7496.63128711	0.00000000	1.95	lose	2026-08-03 01:35:00.442	2026-08-03 01:30:19.453283	2026-08-03 01:35:06.041	127	\N	f	\N	4835000.00000000	4635000.00000000
315	55cd7cf5-4d59-4914-affa-f306a49ff5c2	SP500	short	2500000.00000000	300	7599.58656018	7591.98697362	4875000.00000000	1.95	win	2026-08-04 01:20:00.042	2026-08-04 01:16:21.051692	2026-08-04 01:20:05.228	124	\N	f	\N	93407500.00000000	95782500.00000000
308	c84ca9f9-1efe-4ff4-a37d-ff9c3237b279	SP500	long	200000.00000000	300	7489.62313151	7497.11275464	390000.00000000	1.95	win	2026-08-03 07:05:00.41	2026-08-03 07:00:34.556796	2026-08-03 07:05:05.492	193	\N	f	\N	21437500.00000000	21627500.00000000
303	c84ca9f9-1efe-4ff4-a37d-ff9c3237b279	SP500	short	200000.00000000	300	7490.73008337	7498.22081345	0.00000000	1.95	lose	2026-08-03 01:35:00.007	2026-08-03 01:30:32.019649	2026-08-03 01:35:06.124	127	\N	f	\N	21637500.00000000	21437500.00000000
304	b74441c4-1858-43f0-afdc-fbfec02ce9d5	SP500	short	400000.00000000	300	7490.13064137	7482.64051073	780000.00000000	1.95	win	2026-08-03 01:40:00.68	2026-08-03 01:36:15.693365	2026-08-03 01:40:06.067	128	\N	f	\N	4635000.00000000	5015000.00000000
310	3007b845-7394-4cb1-81d7-7a5289591da2	SP500	long	200000.00000000	300	7489.10131515	7496.59041647	390000.00000000	1.95	win	2026-08-03 07:05:00.288	2026-08-03 07:01:03.29688	2026-08-03 07:05:05.525	193	\N	f	\N	5950000.00000000	6140000.00000000
311	b74441c4-1858-43f0-afdc-fbfec02ce9d5	SP500	long	200000.00000000	300	7489.04515154	7496.53419669	390000.00000000	1.95	win	2026-08-03 07:05:00.705	2026-08-03 07:01:03.717763	2026-08-03 07:05:05.895	193	\N	f	\N	5015000.00000000	5205000.00000000
312	55cd7cf5-4d59-4914-affa-f306a49ff5c2	SP500	long	900000.00000000	300	7601.05546272	7608.65651818	1755000.00000000	1.95	win	2026-08-04 01:05:00.412	2026-08-04 01:01:19.432993	2026-08-04 01:05:05.867	121	\N	f	\N	92552500.00000000	93407500.00000000
313	3007b845-7394-4cb1-81d7-7a5289591da2	SP500	long	900000.00000000	300	7599.87953531	7607.47941485	1755000.00000000	1.95	win	2026-08-04 01:05:00.175	2026-08-04 01:01:46.183679	2026-08-04 01:05:05.895	121	\N	f	\N	11140000.00000000	11995000.00000000
314	3007b845-7394-4cb1-81d7-7a5289591da2	SP500	short	1200000.00000000	300	7600.31153420	7592.71122267	2340000.00000000	1.95	win	2026-08-04 01:10:00.025	2026-08-04 01:06:32.033618	2026-08-04 01:10:05.491	122	\N	f	\N	11995000.00000000	13135000.00000000
317	55cd7cf5-4d59-4914-affa-f306a49ff5c2	SP500	short	200000.00000000	300	7600.35777130	7592.75741353	390000.00000000	1.95	win	2026-08-04 01:35:00.791	2026-08-04 01:30:54.800539	2026-08-04 01:35:06.722	127	\N	f	\N	95782500.00000000	95972500.00000000
321	c84ca9f9-1efe-4ff4-a37d-ff9c3237b279	SP500	short	200000.00000000	300	7601.48252215	7593.88103963	390000.00000000	1.95	win	2026-08-04 06:05:00.236	2026-08-04 06:02:02.244637	2026-08-04 06:05:05.867	181	\N	f	\N	21817500.00000000	22007500.00000000
318	b74441c4-1858-43f0-afdc-fbfec02ce9d5	SP500	short	200000.00000000	300	7600.13878868	7592.53864989	390000.00000000	1.95	win	2026-08-04 01:35:00.384	2026-08-04 01:30:59.394212	2026-08-04 01:35:06.759	127	\N	f	\N	5205000.00000000	5395000.00000000
319	3007b845-7394-4cb1-81d7-7a5289591da2	SP500	short	200000.00000000	300	7601.07546269	7593.47438723	390000.00000000	1.95	win	2026-08-04 01:35:00.078	2026-08-04 01:31:06.087422	2026-08-04 01:35:06.797	127	\N	f	\N	13135000.00000000	13325000.00000000
325	c84ca9f9-1efe-4ff4-a37d-ff9c3237b279	SP500	short	200000.00000000	300	7600.40539595	7608.00580135	0.00000000	1.95	lose	2026-08-04 07:05:00.723	2026-08-04 07:00:41.735374	2026-08-04 07:05:05.857	193	\N	f	\N	22007500.00000000	21807500.00000000
323	b74441c4-1858-43f0-afdc-fbfec02ce9d5	SP500	short	200000.00000000	300	7600.35596074	7607.95631670	0.00000000	1.95	lose	2026-08-04 07:05:00.969	2026-08-04 07:00:26.987781	2026-08-04 07:05:07.001	193	\N	f	\N	5395000.00000000	5195000.00000000
324	3007b845-7394-4cb1-81d7-7a5289591da2	SP500	short	200000.00000000	300	7601.06768038	7608.66874806	0.00000000	1.95	lose	2026-08-04 07:05:00.991	2026-08-04 07:00:29.998518	2026-08-04 07:05:07.03	193	\N	f	\N	13325000.00000000	13125000.00000000
326	b74441c4-1858-43f0-afdc-fbfec02ce9d5	SP500	short	350000.00000000	300	7600.20606182	7592.60585576	682500.00000000	1.95	win	2026-08-04 07:10:00.488	2026-08-04 07:05:39.501509	2026-08-04 07:10:05.841	194	\N	f	\N	5195000.00000000	5527500.00000000
328	3007b845-7394-4cb1-81d7-7a5289591da2	SP500	short	350000.00000000	300	7599.55489926	7591.95534436	682500.00000000	1.95	win	2026-08-04 07:10:00.285	2026-08-04 07:06:34.296148	2026-08-04 07:10:05.911	194	\N	f	\N	13125000.00000000	13457500.00000000
329	c84ca9f9-1efe-4ff4-a37d-ff9c3237b279	SP500	short	350000.00000000	300	7600.25243307	7592.65218064	682500.00000000	1.95	win	2026-08-04 07:10:00.7	2026-08-04 07:07:22.712226	2026-08-04 07:10:05.939	194	\N	f	\N	21807500.00000000	22140000.00000000
330	55cd7cf5-4d59-4914-affa-f306a49ff5c2	SP500	short	2000000.00000000	300	7735.92664883	7728.19072218	3900000.00000000	1.95	win	2026-08-05 01:05:00.285	2026-08-05 01:01:32.294279	2026-08-05 01:05:06.552	121	\N	f	\N	95972500.00000000	97872500.00000000
331	3007b845-7394-4cb1-81d7-7a5289591da2	SP500	short	800000.00000000	300	7736.45642685	7728.71997042	1560000.00000000	1.95	win	2026-08-05 01:05:00.609	2026-08-05 01:01:49.618257	2026-08-05 01:05:06.579	121	\N	f	\N	13457500.00000000	14217500.00000000
333	3007b845-7394-4cb1-81d7-7a5289591da2	SP500	short	800000.00000000	300	7736.52000000	7728.78348000	1560000.00000000	1.95	win	2026-08-05 01:10:00.178	2026-08-05 01:06:27.184209	2026-08-05 01:10:05.39	122	\N	f	\N	14217500.00000000	14977500.00000000
332	55cd7cf5-4d59-4914-affa-f306a49ff5c2	SP500	short	3000000.00000000	300	7736.34914644	7728.61279729	5850000.00000000	1.95	win	2026-08-05 01:10:00.289	2026-08-05 01:06:15.295882	2026-08-05 01:10:05.348	122	\N	f	\N	97872500.00000000	100722500.00000000
336	3007b845-7394-4cb1-81d7-7a5289591da2	SP500	short	250000.00000000	300	7736.81254092	7729.07572838	487500.00000000	1.95	win	2026-08-05 01:35:00.112	2026-08-05 01:31:05.119984	2026-08-05 01:35:05.6	127	\N	f	\N	14977500.00000000	15215000.00000000
337	c84ca9f9-1efe-4ff4-a37d-ff9c3237b279	SP500	short	250000.00000000	300	7737.72416250	7729.98643834	487500.00000000	1.95	win	2026-08-05 01:35:00.507	2026-08-05 01:32:22.51891	2026-08-05 01:35:05.643	127	\N	f	\N	22140000.00000000	22377500.00000000
356	b74441c4-1858-43f0-afdc-fbfec02ce9d5	SP500	short	200000.00000000	300	7723.03109314	7724.11949445	0.00000000	1.95	lose	2026-08-06 07:05:00.969	2026-08-06 07:00:36.980081	2026-08-06 07:05:06.657	193	\N	f	\N	5735000.00000000	5535000.00000000
348	55cd7cf5-4d59-4914-affa-f306a49ff5c2	SP500	short	4000000.00000000	300	7723.45591946	7731.17937538	0.00000000	1.95	lose	2026-08-06 01:10:00.198	2026-08-06 01:06:32.206297	2026-08-06 01:10:06.532	122	\N	f	\N	102622500.00000000	98622500.00000000
335	b74441c4-1858-43f0-afdc-fbfec02ce9d5	SP500	short	250000.00000000	300	7736.15507723	7728.41892215	487500.00000000	1.95	win	2026-08-05 01:35:00.883	2026-08-05 01:30:55.896214	2026-08-05 01:35:06.955	127	\N	f	\N	5527500.00000000	5765000.00000000
338	b74441c4-1858-43f0-afdc-fbfec02ce9d5	SP500	short	300000.00000000	300	7736.57555037	7744.31212592	0.00000000	1.95	lose	2026-08-05 07:05:00.593	2026-08-05 07:00:17.604455	2026-08-05 07:05:06.572	193	\N	f	\N	5765000.00000000	5465000.00000000
349	3007b845-7394-4cb1-81d7-7a5289591da2	SP500	long	600000.00000000	300	7723.36391589	7731.08727981	1170000.00000000	1.95	win	2026-08-06 01:10:00.666	2026-08-06 01:07:46.673855	2026-08-06 01:10:06.606	122	\N	f	\N	15865000.00000000	16435000.00000000
340	3007b845-7394-4cb1-81d7-7a5289591da2	SP500	short	300000.00000000	300	7736.16852849	7743.90469702	0.00000000	1.95	lose	2026-08-05 07:05:00.797	2026-08-05 07:00:53.807613	2026-08-05 07:05:06.652	193	\N	f	\N	15215000.00000000	14915000.00000000
341	c84ca9f9-1efe-4ff4-a37d-ff9c3237b279	SP500	short	300000.00000000	300	7737.12578606	7744.86291185	0.00000000	1.95	lose	2026-08-05 07:05:00.721	2026-08-05 07:01:24.734918	2026-08-05 07:05:06.691	193	\N	f	\N	22377500.00000000	22077500.00000000
350	55cd7cf5-4d59-4914-affa-f306a49ff5c2	SP500	short	7000000.00000000	300	7723.62922233	7715.90559311	13650000.00000000	1.95	win	2026-08-06 01:20:00.211	2026-08-06 01:17:08.219925	2026-08-06 01:20:05.312	124	\N	f	\N	98622500.00000000	105272500.00000000
343	3007b845-7394-4cb1-81d7-7a5289591da2	SP500	long	600000.00000000	300	7736.26510791	7744.00137302	1170000.00000000	1.95	win	2026-08-05 07:10:00.809	2026-08-05 07:06:22.821359	2026-08-05 07:10:06.665	194	\N	f	\N	14915000.00000000	15485000.00000000
344	c84ca9f9-1efe-4ff4-a37d-ff9c3237b279	SP500	long	600000.00000000	300	7736.02501611	7743.76104113	1170000.00000000	1.95	win	2026-08-05 07:10:00.441	2026-08-05 07:06:26.455065	2026-08-05 07:10:06.703	194	\N	f	\N	22077500.00000000	22647500.00000000
345	b74441c4-1858-43f0-afdc-fbfec02ce9d5	SP500	long	600000.00000000	300	7736.42056927	7744.15698984	1170000.00000000	1.95	win	2026-08-05 07:10:00.282	2026-08-05 07:06:54.293573	2026-08-05 07:10:06.74	194	\N	f	\N	5465000.00000000	6035000.00000000
346	55cd7cf5-4d59-4914-affa-f306a49ff5c2	SP500	long	2000000.00000000	300	7722.75862214	7730.48138076	3900000.00000000	1.95	win	2026-08-06 01:05:00.536	2026-08-06 01:01:11.544611	2026-08-06 01:05:06.443	121	\N	f	\N	100722500.00000000	102622500.00000000
347	3007b845-7394-4cb1-81d7-7a5289591da2	SP500	long	400000.00000000	300	7723.49877503	7731.22227381	780000.00000000	1.95	win	2026-08-06 01:05:00.981	2026-08-06 01:02:28.995039	2026-08-06 01:05:06.475	121	\N	f	\N	15485000.00000000	15865000.00000000
358	55cd7cf5-4d59-4914-affa-f306a49ff5c2	SP500	short	4000000.00000000	300	7708.94524995	7701.23630470	7800000.00000000	1.95	win	2026-08-07 01:05:00.085	2026-08-07 01:00:43.094706	2026-08-07 01:05:05.414	121	\N	f	\N	105272500.00000000	109072500.00000000
353	b74441c4-1858-43f0-afdc-fbfec02ce9d5	SP500	short	300000.00000000	300	7724.14916757	7731.87331674	0.00000000	1.95	lose	2026-08-06 01:40:00.359	2026-08-06 01:37:21.369212	2026-08-06 01:40:05.699	128	\N	f	\N	6035000.00000000	5735000.00000000
359	55cd7cf5-4d59-4914-affa-f306a49ff5c2	SP500	short	3000000.00000000	300	7709.09040141	7701.38131101	5850000.00000000	1.95	win	2026-08-07 01:10:00.673	2026-08-07 01:06:02.684169	2026-08-07 01:10:06.16	122	\N	f	\N	109072500.00000000	111922500.00000000
355	3007b845-7394-4cb1-81d7-7a5289591da2	SP500	short	16435000.00000000	300	7723.49811334	7731.22161145	0.00000000	1.95	lose	2026-08-06 01:45:00.612	2026-08-06 01:41:33.622253	2026-08-06 01:45:05.787	129	\N	f	\N	16435000.00000000	0.00000000
360	b74441c4-1858-43f0-afdc-fbfec02ce9d5	SP500	long	200000.00000000	300	7710.17354469	7717.88371823	390000.00000000	1.95	win	2026-08-07 01:35:00.809	2026-08-07 01:31:39.818047	2026-08-07 01:35:06.447	127	\N	f	\N	5535000.00000000	5725000.00000000
367	c84ca9f9-1efe-4ff4-a37d-ff9c3237b279	SP500	long	200000.00000000	300	7709.83082693	7717.54065776	390000.00000000	1.95	win	2026-08-07 07:05:00.017	2026-08-07 07:01:18.029973	2026-08-07 07:05:05.533	193	\N	f	\N	22647500.00000000	22837500.00000000
368	b74441c4-1858-43f0-afdc-fbfec02ce9d5	SP500	long	200000.00000000	300	7709.78264243	7717.49242507	390000.00000000	1.95	win	2026-08-07 07:05:00.574	2026-08-07 07:01:36.584091	2026-08-07 07:05:06.288	193	\N	f	\N	5725000.00000000	5915000.00000000
\.


--
-- Data for Name: blocked_ips; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.blocked_ips (id, ip_address, reason, blocked_by, created_at) FROM stdin;
\.


--
-- Data for Name: branches; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.branches (id, code, name, is_active, created_at) FROM stdin;
\.


--
-- Data for Name: forex_candles; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.forex_candles (id, symbol, duration, "time", open, high, low, close) FROM stdin;
1729	DXY	300	1786320300	99.632000	99.644309	99.625115	99.632997
3462	SP500	300	1786323300	7757.039323	7758.862683	7756.163258	7757.631455
3463	DOW	300	1786323300	54036.885463	54046.817980	54031.111793	54039.893617
3464	DXY	300	1786323300	99.659091	99.665693	99.626641	99.636632
1288	SP500	300	1786278300	7757.345875	7758.781838	7756.558505	7758.025433
559	SP500	300	1786277100	7757.439901	7758.661066	7756.628841	7757.298955
560	DOW	300	1786277100	54037.403442	54050.536713	54025.393208	54033.305145
561	DXY	300	1786277100	99.603124	99.617159	99.592364	99.600589
502	SP500	300	1786276800	7757.508004	7758.297242	7756.886350	7757.202345
503	DOW	300	1786276800	54034.927554	54043.945594	54028.650668	54038.933121
504	DXY	300	1786276800	99.603786	99.613301	99.595474	99.602822
94	SP500	300	1786275900	7757.640000	7758.897384	7756.633022	7757.467283
95	DOW	300	1786275900	54036.930000	54045.268356	54032.233342	54035.927542
96	DXY	300	1786275900	99.604000	99.611579	99.600592	99.605639
49	SP500	300	1786274400	7757.577525	7758.203128	7756.370523	7757.797290
50	DOW	300	1786274400	54038.025136	54045.281493	54028.279510	54038.183001
51	DXY	300	1786274400	99.602311	99.612473	99.594248	99.605293
742	SP500	300	1786277400	7757.537495	7759.175192	7756.042945	7758.389200
743	DOW	300	1786277400	54035.402992	54042.787062	54021.841517	54040.693856
744	DXY	300	1786277400	99.602059	99.615116	99.597350	99.604991
319	SP500	300	1786276500	7757.641082	7758.598882	7756.427811	7757.558183
320	DOW	300	1786276500	54034.183208	54046.679763	54029.889027	54036.631162
321	DXY	300	1786276500	99.603189	99.613324	99.590249	99.602177
1	SP500	300	1786274100	7757.640000	7759.082068	7756.606203	7757.640000
2	DOW	300	1786274100	54036.930000	54041.474266	54028.329251	54036.930000
3	DXY	300	1786274100	99.604000	99.611398	99.595563	99.604000
1289	DOW	300	1786278300	54040.733064	54050.007590	54028.675577	54032.363572
1290	DXY	300	1786278300	99.595874	99.616972	99.593302	99.602256
925	SP500	300	1786277700	7758.506202	7759.006679	7756.410474	7757.108358
926	DOW	300	1786277700	54039.828074	54046.651423	54026.222988	54039.438079
927	DXY	300	1786277700	99.606304	99.613389	99.590745	99.603142
3281	SP500	300	1786323000	7758.428614	7758.935039	7756.339955	7757.281066
3282	DOW	300	1786323000	54037.813031	54044.308692	54024.409712	54036.608217
3283	DXY	300	1786323000	99.649177	99.661131	99.635251	99.658065
2738	SP500	300	1786322100	7757.804816	7759.184508	7755.721120	7758.162925
2739	DOW	300	1786322100	54031.578434	54047.946092	54023.677810	54043.238767
2740	DXY	300	1786322100	99.638723	99.653492	99.627917	99.642090
2558	SP500	300	1786321800	7758.872138	7759.210747	7756.300907	7758.026319
2559	DOW	300	1786321800	54035.152214	54044.137934	54027.226534	54033.361929
2195	SP500	300	1786321200	7757.358057	7758.772862	7756.267983	7757.284434
2196	DOW	300	1786321200	54034.966926	54046.917751	54024.476916	54037.321353
2197	DXY	300	1786321200	99.619135	99.635604	99.605089	99.608333
139	SP500	300	1786276200	7757.458284	7758.861316	7756.321354	7757.471963
140	DOW	300	1786276200	54036.729971	54042.960984	54026.039132	54034.980784
141	DXY	300	1786276200	99.605218	99.612921	99.593313	99.602912
1655	DOW	300	1786278900	54039.237449	54051.396340	54032.495547	54036.999445
1656	DXY	300	1786278900	99.601250	99.613803	99.596516	99.602025
1654	SP500	300	1786278900	7757.827516	7758.426800	7756.850686	7757.724355
1105	SP500	300	1786278000	7757.057495	7758.877780	7756.202025	7757.208199
1106	DOW	300	1786278000	54037.847279	54044.440253	54025.202444	54039.267456
1107	DXY	300	1786278000	99.605227	99.617534	99.597015	99.597015
2560	DXY	300	1786321800	99.635566	99.656673	99.620385	99.639273
1832	SP500	300	1786320600	7757.637101	7758.878048	7756.212504	7757.315163
1833	DOW	300	1786320600	54043.864687	54049.615183	54026.567732	54037.974581
1834	DXY	300	1786320600	99.635158	99.639000	99.605597	99.621463
2378	SP500	300	1786321500	7757.022469	7759.088349	7756.130267	7758.632838
2379	DOW	300	1786321500	54039.404756	54046.471381	54025.383836	54034.094803
2380	DXY	300	1786321500	99.610757	99.641503	99.607505	99.635175
2012	SP500	300	1786320900	7757.391231	7759.431425	7755.774700	7757.315051
2013	DOW	300	1786320900	54038.819369	54050.637186	54026.748049	54034.059287
1471	SP500	300	1786278600	7758.170845	7759.086563	7755.924402	7757.621363
2014	DXY	300	1786320900	99.622595	99.632179	99.609108	99.620362
1727	SP500	300	1786320300	7757.640000	7758.661995	7755.949879	7757.571738
1472	DOW	300	1786278600	54030.700483	54045.146131	54025.930251	54038.452687
1473	DXY	300	1786278600	99.603895	99.612060	99.596623	99.601883
1728	DOW	300	1786320300	54036.930000	54045.802595	54031.159478	54045.802595
2921	SP500	300	1786322400	7758.370273	7758.976246	7756.354733	7758.051077
2922	DOW	300	1786322400	54041.340467	54049.374446	54028.716835	54039.935076
2923	DXY	300	1786322400	99.641736	99.657564	99.629534	99.638008
3101	SP500	300	1786322700	7758.201337	7758.807601	7755.940871	7758.208814
3102	DOW	300	1786322700	54041.712778	54044.083120	54026.020657	54036.860149
3103	DXY	300	1786322700	99.639717	99.656681	99.634359	99.650134
3822	SP500	300	1786323900	7756.987285	7759.183772	7756.050904	7758.027118
3823	DOW	300	1786323900	54029.132723	54043.778866	54026.184931	54039.721067
3642	SP500	300	1786323600	7757.345437	7759.128742	7756.007917	7757.283007
3824	DXY	300	1786323900	99.634474	99.640117	99.613137	99.625608
4005	SP500	300	1786324200	7757.864778	7759.091094	7756.305051	7757.043355
4006	DOW	300	1786324200	54038.227966	54047.830046	54026.401666	54036.700549
3643	DOW	300	1786323600	54040.993253	54045.375554	54028.122896	54030.552835
3644	DXY	300	1786323600	99.638248	99.642002	99.614376	99.633255
4007	DXY	300	1786324200	99.623975	99.672598	99.612451	99.652142
4188	SP500	300	1786324500	7757.061215	7759.185914	7756.124378	7757.601008
4189	DOW	300	1786324500	54034.800779	54042.435649	54027.136344	54034.716564
4190	DXY	300	1786324500	99.654059	99.685332	99.650005	99.668222
4359	SP500	300	1786422900	7753.110000	7754.321178	7752.514405	7753.186837
4360	DOW	300	1786422900	53975.980000	53980.503236	53966.627391	53973.779575
4361	DXY	300	1786422900	99.778000	99.783068	99.766021	99.776368
4413	SP500	300	1786423200	7753.172427	7754.164224	7751.880751	7753.391327
4414	DOW	300	1786423200	53973.718665	53987.202384	53964.765975	53976.941079
7260	SP500	300	1786669200	7798.277107	7800.827430	7797.048953	7798.837133
7261	DOW	300	1786669200	53842.642642	53847.606901	53830.767299	53843.625015
5868	SP500	300	1786610100	7748.843694	7750.273143	7747.179458	7748.796575
5869	DOW	300	1786610100	53770.469928	53779.811902	53761.296910	53773.598093
5870	DXY	300	1786610100	99.989731	99.996369	99.979142	99.981828
7262	DXY	300	1786669200	99.898109	99.915313	99.878727	99.885055
6231	SP500	300	1786610700	7748.796770	7750.104228	7746.449955	7748.894488
6232	DOW	300	1786610700	53766.869052	53786.884240	53758.817724	53778.211983
6233	DXY	300	1786610700	99.977223	99.989712	99.962541	99.962541
5130	SP500	300	1786424400	7752.442202	7754.433951	7751.862072	7752.947182
5131	DOW	300	1786424400	53971.321707	53989.164506	53964.523404	53980.348280
5132	DXY	300	1786424400	99.817222	99.829633	99.802825	99.802825
6597	SP500	300	1786611300	7748.910915	7749.410129	7747.058729	7749.154239
6598	DOW	300	1786611300	53763.228118	53775.663429	53757.308108	53770.123412
6599	DXY	300	1786611300	99.978607	99.982752	99.952090	99.956940
4770	SP500	300	1786423800	7752.873926	7754.460916	7751.364013	7751.988743
4771	DOW	300	1786423800	53975.475461	53988.990088	53968.632343	53971.066838
4772	DXY	300	1786423800	99.794427	99.816864	99.786157	99.811787
8059	DOW	300	1786670700	53841.655587	53848.730189	53828.224450	53839.480091
8060	DXY	300	1786670700	99.920448	99.932611	99.904350	99.923573
7443	SP500	300	1786669500	7798.968100	7800.753098	7797.956112	7799.261632
7444	DOW	300	1786669500	53843.134736	53847.503275	53830.602911	53841.064183
7445	DXY	300	1786669500	99.883456	99.892343	99.868190	99.873300
6048	SP500	300	1786610400	7748.673053	7749.431266	7746.718840	7748.657464
6049	DOW	300	1786610400	53775.356629	53777.984842	53764.780426	53768.928833
6050	DXY	300	1786610400	99.982090	99.996516	99.972004	99.977364
7983	SP500	300	1786670400	7798.451707	7799.804357	7798.281587	7798.542412
7623	SP500	300	1786669800	7799.142286	7800.494118	7797.392092	7798.781600
7077	SP500	300	1786668900	7799.299816	7800.376202	7797.436861	7798.389804
7078	DOW	300	1786668900	53834.146211	53850.017023	53829.872780	53841.048251
5676	SP500	300	1786425300	7752.746715	7754.253790	7752.144130	7752.761205
5677	DOW	300	1786425300	53974.539932	53981.699621	53964.118846	53978.331080
4415	DXY	300	1786423200	99.774448	99.791610	99.768031	99.790657
5493	SP500	300	1786425000	7753.188093	7754.109680	7751.863591	7752.628051
5494	DOW	300	1786425000	53979.405878	53984.533636	53967.361778	53973.033412
5495	DXY	300	1786425000	99.793009	99.809983	99.779968	99.800648
4950	SP500	300	1786424100	7751.737576	7754.350539	7751.534917	7752.149676
4951	DOW	300	1786424100	53972.789875	53982.318965	53963.915678	53973.393628
4952	DXY	300	1786424100	99.810092	99.821952	99.782491	99.817436
4590	SP500	300	1786423500	7753.432143	7754.669180	7751.711096	7752.835148
4591	DOW	300	1786423500	53975.642372	53986.860289	53967.565494	53974.491072
4592	DXY	300	1786423500	99.788180	99.804858	99.780578	99.793892
5678	DXY	300	1786425300	99.799678	99.806211	99.790773	99.797964
7079	DXY	300	1786668900	99.897385	99.908854	99.885436	99.899636
6963	SP500	300	1786611900	7748.210534	7749.751438	7746.734704	7748.500000
5310	SP500	300	1786424700	7753.072955	7754.713558	7751.750678	7753.491860
5311	DOW	300	1786424700	53979.085442	53985.445987	53966.940670	53978.878828
5312	DXY	300	1786424700	99.801796	99.810905	99.782684	99.794443
6964	DOW	300	1786611900	53774.433552	53777.704909	53762.246984	53770.270000
6965	DXY	300	1786611900	99.980587	99.990973	99.965008	99.984000
5739	SP500	300	1786609800	7748.500000	7750.363874	7747.562016	7748.634454
5740	DOW	300	1786609800	53770.270000	53778.645548	53764.977905	53769.554131
5741	DXY	300	1786609800	99.988000	100.006665	99.979092	99.989818
6780	SP500	300	1786611600	7749.162616	7749.802091	7747.114095	7748.384052
6781	DOW	300	1786611600	53768.096665	53779.571837	53762.475604	53775.798210
6782	DXY	300	1786611600	99.954617	99.979367	99.954013	99.979367
7074	SP500	300	1786668600	7798.990000	7799.507608	7798.990000	7799.507608
7075	DOW	300	1786668600	53839.990000	53839.990000	53835.891298	53835.891298
7076	DXY	300	1786668600	99.896000	99.898046	99.894073	99.898046
7624	DOW	300	1786669800	53841.557548	53846.005002	53829.014163	53836.680199
7625	DXY	300	1786669800	99.871234	99.901472	99.868361	99.891276
6414	SP500	300	1786611000	7748.715842	7749.756815	7747.426686	7748.636816
6415	DOW	300	1786611000	53777.954673	53779.457774	53760.245548	53763.372130
6416	DXY	300	1786611000	99.964283	99.983605	99.955657	99.977135
7984	DOW	300	1786670400	53838.758341	53844.425416	53829.671607	53843.125659
7985	DXY	300	1786670400	99.907929	99.922549	99.897830	99.919564
7803	SP500	300	1786670100	7798.874017	7800.353580	7797.404058	7798.741206
7804	DOW	300	1786670100	53834.586207	53847.905216	53832.795677	53838.694082
7805	DXY	300	1786670100	99.893229	99.917925	99.893229	99.906240
8418	SP500	300	1786671300	7799.110333	7800.882422	7797.909922	7799.101828
8419	DOW	300	1786671300	53836.424070	53852.503789	53829.412338	53839.840073
8420	DXY	300	1786671300	99.934314	99.937834	99.912712	99.922204
8781	SP500	300	1786671900	7798.958378	7800.754181	7797.931860	7799.274870
8238	SP500	300	1786671000	7799.184340	7800.482755	7797.900055	7799.222971
8058	SP500	300	1786670700	7798.764441	7800.171212	7797.302065	7798.887874
8782	DOW	300	1786671900	53839.492867	53848.299942	53832.075835	53840.725215
8239	DOW	300	1786671000	53841.426060	53856.003780	53829.653142	53837.841727
8240	DXY	300	1786671000	99.925281	99.938815	99.912881	99.933436
8598	SP500	300	1786671600	7798.896766	7800.348955	7797.823003	7799.247035
8599	DOW	300	1786671600	53839.034168	53847.104355	53828.430135	53840.414866
8600	DXY	300	1786671600	99.921790	99.934024	99.893588	99.902641
8783	DXY	300	1786671900	99.903525	99.910250	99.884732	99.897621
8964	SP500	300	1786672200	7799.408801	7800.764602	7797.842359	7798.924621
8965	DOW	300	1786672200	53841.833798	53848.596340	53830.580853	53840.204503
8966	DXY	300	1786672200	99.899727	99.910642	99.886036	99.901994
9147	SP500	300	1786672500	7799.099207	7799.872571	7796.903275	7798.528034
9148	DOW	300	1786672500	53840.033762	53849.778711	53826.586969	53841.757305
9149	DXY	300	1786672500	99.903992	99.917059	99.891028	99.903106
9330	SP500	300	1786672800	7798.373708	7800.069077	7797.413900	7798.603361
10058	DXY	300	1786674000	99.907721	99.914183	99.890601	99.905838
9696	SP500	300	1786673400	7799.644411	7800.707313	7797.494358	7798.737724
9697	DOW	300	1786673400	53839.455433	53852.702461	53830.425458	53837.909544
9698	DXY	300	1786673400	99.927582	99.930204	99.901081	99.912579
11521	DOW	300	1786676400	53840.409391	53849.416566	53825.658811	53841.964789
11522	DXY	300	1786676400	99.906328	99.924901	99.893483	99.913119
11337	SP500	300	1786676100	7799.022433	7800.701403	7797.560911	7799.074350
11338	DOW	300	1786676100	53840.755592	53851.883177	53832.446375	53842.191501
11339	DXY	300	1786676100	99.888958	99.915145	99.884777	99.904714
12303	SILVER	180	1786677660	64.045000	64.159687	64.034395	64.158551
12648	SILVER	300	1786677900	64.098114	64.167913	64.093151	64.157015
12551	SILVER	180	1786677840	64.156671	64.177074	64.093151	64.125142
11154	SP500	300	1786675800	7799.236955	7800.711638	7797.443120	7798.787298
11155	DOW	300	1786675800	53835.992262	53847.916908	53830.060934	53841.838627
11156	DXY	300	1786675800	99.901046	99.905440	99.881746	99.890686
9331	DOW	300	1786672800	53842.509479	53849.457328	53833.447652	53840.796780
9332	DXY	300	1786672800	99.902129	99.910946	99.891056	99.895582
9876	SP500	300	1786673700	7798.473630	7800.177905	7796.957702	7798.683775
9877	DOW	300	1786673700	53838.488960	53849.036418	53829.803411	53838.449628
9878	DXY	300	1786673700	99.910672	99.927539	99.901737	99.907751
10605	SP500	300	1786674900	7799.334056	7799.807199	7797.520787	7798.922961
10606	DOW	300	1786674900	53841.980066	53847.805204	53829.984739	53842.985516
10607	DXY	300	1786674900	99.904489	99.915136	99.887247	99.898251
10422	SP500	300	1786674600	7798.663357	7800.945450	7797.234592	7799.121089
10423	DOW	300	1786674600	53839.539932	53848.688538	53831.633290	53840.107980
10424	DXY	300	1786674600	99.905733	99.920748	99.893508	99.903656
12249	SP500	300	1786677600	7799.545471	7799.757595	7798.195146	7798.536594
9513	SP500	300	1786673100	7798.796754	7800.139709	7797.652804	7799.371460
9514	DOW	300	1786673100	53840.702420	53852.103097	53833.173487	53839.449691
9515	DXY	300	1786673100	99.896127	99.928819	99.892245	99.925327
12250	DOW	300	1786677600	53838.404080	53852.639123	53833.131824	53844.592732
11700	SP500	300	1786676700	7798.399693	7800.384559	7797.856282	7798.997635
11701	DOW	300	1786676700	53843.317915	53854.727965	53829.724580	53838.241842
11702	DXY	300	1786676700	99.911488	99.926834	99.906254	99.914213
10239	SP500	300	1786674300	7798.752498	7800.477810	7797.149600	7798.700488
10240	DOW	300	1786674300	53841.867094	53851.763072	53828.215090	53838.590926
10241	DXY	300	1786674300	99.905362	99.914727	99.894776	99.903325
10788	SP500	300	1786675200	7798.944185	7800.503138	7797.519507	7798.973089
10789	DOW	300	1786675200	53842.379558	53850.964246	53832.209191	53838.644860
10790	DXY	300	1786675200	99.895981	99.913771	99.886147	99.894821
12251	DXY	300	1786677600	99.904792	99.913651	99.899336	99.911902
10056	SP500	300	1786674000	7798.653500	7800.875898	7797.447327	7798.662998
10057	DOW	300	1786674000	53840.026624	53847.902013	53833.482723	53841.154659
12298	GOLD	300	1786677600	4374.300000	4377.597543	4373.139154	4375.086731
12300	GBP	300	1786677600	1.349473	1.349871	1.349323	1.349682
10971	SP500	300	1786675500	7799.172543	7800.822046	7797.687122	7799.483560
10972	DOW	300	1786675500	53839.691947	53850.206917	53833.436250	53837.633549
10973	DXY	300	1786675500	99.893379	99.902677	99.886559	99.899932
129551	BTC	180	1788307920	77329.845507	77370.413376	77309.014720	77353.265313
12304	SILVER	300	1786677600	64.045000	64.177074	64.034395	64.100296
129552	SILVER	180	1788307920	64.736474	64.868215	64.628859	64.859653
12066	SP500	300	1786677300	7798.942741	7800.475960	7797.663550	7799.426027
12067	DOW	300	1786677300	53841.468439	53849.187239	53828.374829	53836.710233
11883	SP500	300	1786677000	7798.739946	7800.454101	7797.350519	7799.115547
11520	SP500	300	1786676400	7799.241580	7800.020339	7797.481448	7798.653497
11884	DOW	300	1786677000	53836.360052	53850.525545	53833.452921	53842.902480
11885	DXY	300	1786677000	99.915885	99.925548	99.895337	99.898471
12068	DXY	300	1786677300	99.897209	99.917059	99.886835	99.905684
129549	GOLD	180	1788307920	4370.212480	4376.100000	4363.886810	4375.970313
129550	GBP	180	1788307920	1.351192	1.351214	1.350904	1.351186
12297	GOLD	180	1786677660	4374.300000	4377.597543	4373.139154	4377.285973
12299	GBP	180	1786677660	1.349473	1.349871	1.349323	1.349756
12833	GOLD	180	1786678020	4376.409391	4378.284473	4376.118011	4377.547047
12642	GOLD	300	1786677900	4375.060487	4378.284473	4375.060487	4377.547047
12835	GBP	180	1786678020	1.349480	1.349794	1.349414	1.349751
12644	GBP	300	1786677900	1.349699	1.349794	1.349414	1.349751
12545	GOLD	180	1786677840	4377.413084	4377.470503	4374.731845	4376.427349
12547	GBP	180	1786677840	1.349728	1.349787	1.349451	1.349470
13122	GOLD	300	1786678200	4377.438445	4380.758873	4377.438445	4379.496965
142438	GBP	300	1788437100	1.349705	1.349910	1.349526	1.349830
12839	SILVER	180	1786678020	64.123920	64.167913	64.121521	64.157015
142243	BTC	180	1788436980	77907.717067	77929.612606	77853.035416	77905.842260
13124	GBP	300	1786678200	1.349729	1.350021	1.349565	1.349674
13602	GOLD	300	1786678500	4379.488047	4381.271799	4379.429694	4380.252763
13411	GBP	180	1786678380	1.349857	1.350021	1.349602	1.349760
13121	GOLD	180	1786678200	4377.438445	4380.758873	4377.438445	4379.591990
142244	SILVER	180	1788436980	66.346911	66.361526	66.333322	66.357070
13123	GBP	180	1786678200	1.349729	1.349874	1.349565	1.349874
13127	SILVER	180	1786678200	64.155514	64.235000	64.153180	64.219498
142241	GOLD	180	1788436980	4487.081345	4487.718020	4484.756921	4486.803730
13128	SILVER	300	1786678200	64.155514	64.258681	64.153180	64.254174
142242	GBP	180	1788436980	1.349483	1.349741	1.349439	1.349689
13415	SILVER	180	1786678380	64.217462	64.271799	64.195000	64.224432
13697	GOLD	180	1786678560	4380.220653	4381.173130	4379.432689	4380.986381
13699	GBP	180	1786678560	1.349727	1.349813	1.349514	1.349560
13409	GOLD	180	1786678380	4379.470597	4380.420698	4379.240805	4380.100120
13608	SILVER	300	1786678500	64.253238	64.271799	64.220546	64.261404
13604	GBP	300	1786678500	1.349643	1.349848	1.349501	1.349514
142437	GOLD	300	1788437100	4486.430180	4490.565686	4485.315102	4490.368723
14571	GBP	180	1786679100	1.349720	1.349793	1.349404	1.349493
14868	SILVER	180	1786679280	64.330528	64.337861	64.239680	64.244852
14575	SILVER	180	1786679100	64.337342	64.361585	64.313068	64.330686
16041	GOLD	180	1786680000	4382.455043	4382.757153	4380.247903	4381.087461
16043	GBP	180	1786680000	1.349540	1.349657	1.349399	1.349416
15453	GOLD	180	1786679640	4380.892308	4382.000000	4380.414626	4381.940846
14570	GOLD	300	1786679100	4383.248541	4383.822524	4380.894964	4381.998782
14572	GBP	300	1786679100	1.349720	1.349793	1.349404	1.349635
15454	GBP	180	1786679640	1.349414	1.349577	1.349364	1.349532
14576	SILVER	300	1786679100	64.337342	64.361585	64.244488	64.248874
13985	GOLD	180	1786678740	4381.101351	4381.273617	4379.901551	4380.868993
14277	GOLD	180	1786678920	4380.952375	4383.625845	4380.386452	4383.220924
13987	GBP	180	1786678740	1.349579	1.349711	1.349501	1.349626
14081	GOLD	300	1786678800	4380.301901	4383.625845	4380.255160	4383.220924
13703	SILVER	180	1786678560	64.224352	64.248561	64.220546	64.240623
14278	GBP	180	1786678920	1.349651	1.349713	1.349420	1.349702
13991	SILVER	180	1786678740	64.238499	64.288080	64.233173	64.267345
14082	GBP	300	1786678800	1.349532	1.349713	1.349420	1.349702
14280	SILVER	180	1786678920	64.267628	64.345968	64.247211	64.338070
14084	SILVER	300	1786678800	64.261582	64.345968	64.247211	64.338070
16042	GOLD	300	1786680000	4382.455043	4382.757153	4379.320680	4379.886666
15456	SILVER	180	1786679640	64.225770	64.236083	64.202260	64.212313
16047	SILVER	180	1786680000	64.201939	64.205608	64.159477	64.160741
129841	GOLD	180	1788308100	4375.888106	4375.888106	4365.100000	4366.684634
129842	GOLD	300	1788308100	4375.888106	4375.888106	4365.100000	4370.122057
16044	GBP	300	1786680000	1.349540	1.349812	1.349399	1.349610
129843	GBP	180	1788308100	1.351198	1.351256	1.351058	1.351204
129844	GBP	300	1788308100	1.351198	1.351371	1.351058	1.351095
17018	GBP	300	1786680600	1.349756	1.349927	1.349587	1.349789
15161	GOLD	180	1786679460	4381.370241	4382.094223	4380.316954	4381.007912
16048	SILVER	300	1786680000	64.201939	64.205608	64.140000	64.158858
15162	GBP	180	1786679460	1.349598	1.349701	1.349371	1.349398
129845	BTC	180	1788308100	77352.128961	77407.607327	77335.240028	77397.649957
15749	GOLD	180	1786679820	4381.948280	4382.912618	4381.134794	4382.348513
15164	SILVER	180	1786679460	64.242636	64.255552	64.222200	64.227206
15061	GOLD	300	1786679400	4381.941666	4382.327310	4380.316954	4381.548144
129846	BTC	300	1788308100	77352.128961	77425.665382	77335.240028	77357.371873
129847	SILVER	180	1788308100	64.857388	64.857633	64.665000	64.735449
15553	GOLD	300	1786679700	4381.611878	4382.912618	4380.957931	4382.348513
15062	GBP	300	1786679400	1.349618	1.349701	1.349364	1.349504
15750	GBP	180	1786679820	1.349498	1.349834	1.349318	1.349546
129848	SILVER	300	1788308100	64.857388	64.857633	64.665000	64.749527
14569	GOLD	180	1786679100	4383.248541	4383.822524	4382.034456	4383.127143
15554	GBP	300	1786679700	1.349523	1.349834	1.349318	1.349546
15064	SILVER	300	1786679400	64.249991	64.255552	64.215165	64.226473
130806	BTC	300	1788426000	77767.550000	77799.340123	77760.047896	77786.739143
14865	GOLD	180	1786679280	4383.183493	4383.458549	4380.894964	4381.489581
130801	GOLD	180	1788426000	4480.700000	4481.433080	4480.590802	4480.909614
15752	SILVER	180	1786679820	64.210454	64.228010	64.197179	64.200958
15556	SILVER	300	1786679700	64.228737	64.229632	64.197179	64.200958
14866	GBP	180	1786679280	1.349519	1.349737	1.349440	1.349567
130808	SILVER	300	1788426000	66.475000	66.492124	66.447288	66.483461
130803	GBP	180	1788426000	1.350147	1.350219	1.350094	1.350195
130875	BTC	180	1788426180	77787.525560	77803.508182	77760.047896	77769.060072
130805	BTC	180	1788426000	77767.550000	77792.339109	77767.550000	77786.867935
130876	SILVER	180	1788426180	66.456829	66.492124	66.447288	66.477757
17497	GOLD	180	1786680900	4378.833372	4380.318212	4378.093321	4379.141894
16920	SILVER	180	1786680540	64.182749	64.188429	64.132437	64.141335
16525	GOLD	300	1786680300	4379.950203	4380.200000	4378.831256	4379.298819
16337	GOLD	180	1786680180	4380.996498	4381.140215	4379.057774	4380.117696
130807	SILVER	180	1788426000	66.475000	66.475716	66.450436	66.458804
16338	GBP	180	1786680180	1.349401	1.349812	1.349401	1.349698
16625	GOLD	180	1786680360	4380.176048	4380.200000	4378.873221	4379.786557
17216	SILVER	180	1786680720	64.138773	64.169863	64.134243	64.163923
16340	SILVER	180	1786680180	64.162714	64.187521	64.139872	64.161648
17504	SILVER	300	1786680900	64.163773	64.163773	64.084734	64.090793
16526	GBP	300	1786680300	1.349622	1.349859	1.349508	1.349735
16626	GBP	180	1786680360	1.349673	1.349859	1.349508	1.349788
16528	SILVER	300	1786680300	64.157228	64.188429	64.139872	64.149568
17020	SILVER	300	1786680600	64.148299	64.169863	64.132437	64.163923
16917	GOLD	180	1786680540	4379.657934	4379.889463	4378.817350	4379.396075
16628	SILVER	180	1786680360	64.163094	64.183630	64.143155	64.182624
130873	GOLD	180	1788426180	4481.007640	4482.333134	4480.177365	4480.727416
17213	GOLD	180	1786680720	4379.407143	4380.729226	4378.054656	4378.896134
17499	GBP	180	1786680900	1.349800	1.349977	1.349636	1.349697
130874	GBP	180	1788426180	1.350210	1.350210	1.349777	1.349912
16918	GBP	180	1786680540	1.349809	1.349927	1.349688	1.349820
130802	GOLD	300	1788426000	4480.700000	4482.333134	4480.590802	4481.485149
17017	GOLD	300	1786680600	4379.206596	4380.729226	4378.054656	4378.896134
17214	GBP	180	1786680720	1.349810	1.349895	1.349587	1.349789
130804	GBP	300	1788426000	1.350147	1.350219	1.349777	1.349862
17503	SILVER	180	1786680900	64.163773	64.163773	64.130194	64.139145
17796	SILVER	180	1786681080	64.140358	64.148372	64.084734	64.103381
17793	GOLD	180	1786681080	4379.063138	4380.585068	4379.062302	4379.535679
17794	GBP	180	1786681080	1.349687	1.349880	1.349616	1.349698
17498	GOLD	300	1786680900	4378.833372	4380.585068	4378.093321	4379.330083
17500	GBP	300	1786680900	1.349800	1.349977	1.349616	1.349806
132233	BTC	180	1788430680	77579.000000	77653.650000	77572.008145	77646.105837
132230	GOLD	300	1788430500	4471.800000	4472.285100	4471.655467	4472.178914
132231	GBP	180	1788430680	1.349109	1.349189	1.348960	1.349116
132232	GBP	300	1788430500	1.349109	1.349177	1.349024	1.349062
20136	SILVER	180	1786682520	64.106487	64.123164	64.085443	64.085443
19546	GBP	180	1786682160	1.349834	1.350033	1.349816	1.349912
19940	SILVER	300	1786682400	64.127578	64.136921	64.085443	64.085443
19548	SILVER	180	1786682160	64.167167	64.178505	64.123849	64.126356
130140	SILVER	180	1788308280	64.733337	64.812453	64.707381	64.722021
18381	GOLD	180	1786681440	4381.937111	4382.702332	4380.972262	4381.925693
18089	GOLD	180	1786681260	4379.631358	4382.300000	4379.044436	4382.047668
20426	GOLD	300	1786682700	4380.347034	4381.125340	4378.943645	4380.200710
18090	GBP	180	1786681260	1.349683	1.349995	1.349539	1.349709
18382	GBP	180	1786681440	1.349705	1.349813	1.349571	1.349625
18092	SILVER	180	1786681260	64.105316	64.123208	64.075263	64.113654
19257	GOLD	180	1786681980	4381.657978	4382.940204	4381.305836	4382.237176
18384	SILVER	180	1786681440	64.114804	64.144280	64.080571	64.116380
21304	SILVER	180	1786683240	64.097317	64.102769	64.047979	64.075096
131171	BTC	180	1788426360	77771.431050	77859.571579	77755.050332	77857.535045
19258	GBP	180	1786681980	1.349545	1.350092	1.349545	1.349862
20431	SILVER	180	1786682700	64.084133	64.116939	64.081830	64.095804
131071	BTC	300	1788426300	77790.132974	77859.571579	77755.050332	77844.156886
20428	GBP	300	1786682700	1.349750	1.349829	1.349497	1.349673
17989	GOLD	300	1786681200	4379.349057	4382.702332	4379.044436	4382.172487
19260	SILVER	180	1786681980	64.170918	64.171078	64.143449	64.166746
17990	GBP	300	1786681200	1.349787	1.349995	1.349539	1.349686
131072	SILVER	300	1788426300	66.485894	66.514654	66.451219	66.500466
17992	SILVER	300	1786681200	64.089687	64.143231	64.075263	64.141277
131169	GOLD	180	1788426360	4480.750893	4483.564224	4480.064352	4483.287821
18962	GOLD	300	1786681800	4382.035868	4383.015340	4381.305836	4382.382844
18964	GBP	300	1786681800	1.349607	1.350092	1.349466	1.349997
130137	GOLD	180	1788308280	4366.743328	4373.235327	4366.583429	4369.129413
130138	GBP	180	1788308280	1.351199	1.351371	1.351008	1.351015
18968	SILVER	300	1786681800	64.143624	64.184152	64.110595	64.164034
130139	BTC	180	1788308280	77395.395420	77425.665382	77328.836074	77328.836074
19453	GOLD	300	1786682100	4382.493829	4382.940204	4380.136628	4380.766758
19454	GBP	300	1786682100	1.349969	1.350087	1.349757	1.349877
131172	SILVER	180	1788426360	66.479472	66.514654	66.453674	66.508958
132235	SILVER	180	1788430680	66.195000	66.201599	66.176962	66.179214
18669	GOLD	180	1786681620	4381.849444	4383.074713	4381.556100	4381.990916
18473	GOLD	300	1786681500	4382.103902	4383.074713	4380.972262	4381.990916
18670	GBP	180	1786681620	1.349634	1.349756	1.349462	1.349584
18474	GBP	300	1786681500	1.349700	1.349813	1.349462	1.349584
132372	SILVER	180	1788430860	66.178291	66.237631	66.173511	66.184431
131170	GBP	180	1788426360	1.349886	1.350282	1.349567	1.350249
18672	SILVER	180	1786681620	64.117911	64.155192	64.116883	64.143770
18476	SILVER	300	1786681500	64.139502	64.155192	64.080571	64.143770
19456	SILVER	300	1786682100	64.165988	64.178505	64.107376	64.125511
18961	GOLD	180	1786681800	4382.035868	4383.015340	4381.396114	4381.711290
21404	SILVER	300	1786683300	64.090138	64.095735	64.047979	64.060214
131069	GOLD	300	1788426300	4481.547449	4483.564224	4480.064352	4482.042036
18963	GBP	180	1786681800	1.349607	1.349686	1.349466	1.349570
20432	SILVER	300	1786682700	64.084133	64.131164	64.081830	64.130637
18967	SILVER	180	1786681800	64.143624	64.184152	64.110595	64.172433
20133	GOLD	180	1786682520	4380.210758	4380.525456	4378.785527	4380.255965
19837	GOLD	180	1786682340	4380.305260	4381.600359	4379.312305	4380.092956
19545	GOLD	180	1786682160	4382.282308	4382.783500	4380.423016	4380.423016
131070	GBP	300	1788426300	1.349843	1.350340	1.349567	1.350137
19937	GOLD	300	1786682400	4380.859433	4381.024549	4378.785527	4380.255965
20134	GBP	180	1786682520	1.349746	1.349879	1.349590	1.349751
19938	GBP	300	1786682400	1.349872	1.349948	1.349590	1.349751
21009	GOLD	180	1786683060	4379.954612	4381.225629	4379.954612	4380.725947
20910	GBP	300	1786683000	1.349669	1.349855	1.349500	1.349751
20713	GOLD	180	1786682880	4379.839967	4381.125340	4379.199532	4379.830450
21010	GBP	180	1786683060	1.349570	1.349821	1.349500	1.349706
19838	GBP	180	1786682340	1.349902	1.349948	1.349642	1.349762
20714	GBP	180	1786682880	1.349680	1.349829	1.349502	1.349543
132234	BTC	300	1788430500	77579.000000	77588.676370	77572.008145	77579.756675
21597	GOLD	180	1786683420	4379.329019	4380.388419	4378.839523	4379.015301
19840	SILVER	180	1786682340	64.128560	64.136921	64.107319	64.107319
132370	GBP	180	1788430860	1.349112	1.349345	1.348882	1.349126
132236	SILVER	300	1788430500	66.195000	66.201599	66.194506	66.197141
21302	GBP	180	1786683240	1.349712	1.349868	1.349608	1.349866
20716	SILVER	180	1786682880	64.094855	64.131175	64.091337	64.101588
20425	GOLD	180	1786682700	4380.347034	4380.692871	4378.943645	4379.875886
20427	GBP	180	1786682700	1.349750	1.349817	1.349497	1.349647
20909	GOLD	300	1786683000	4380.094150	4381.225629	4379.199532	4380.894192
21012	SILVER	180	1786683060	64.100098	64.122059	64.077464	64.098906
21301	GOLD	180	1786683240	4380.815495	4381.133474	4378.852508	4379.313892
20912	SILVER	300	1786683000	64.130210	64.131175	64.077464	64.088163
21401	GOLD	300	1786683300	4380.987185	4380.987185	4378.839523	4379.015301
132269	GOLD	300	1788430800	4472.286273	4472.346624	4469.088427	4471.046260
21402	GBP	300	1786683300	1.349724	1.350013	1.349599	1.349871
132229	GOLD	180	1788430680	4471.800000	4472.346624	4470.446943	4470.584108
132369	GOLD	180	1788430860	4470.459610	4471.100094	4469.088427	4470.167467
132371	BTC	180	1788430860	77646.497664	77683.915295	77617.551593	77636.273916
21598	GBP	180	1786683420	1.349883	1.350013	1.349599	1.349871
21600	SILVER	180	1786683420	64.077514	64.087175	64.060214	64.060214
132270	GBP	300	1788430800	1.349083	1.349345	1.348882	1.349222
21889	GOLD	180	1786683600	4378.962171	4380.364221	4378.857317	4379.843442
21890	GOLD	300	1786683600	4378.962171	4380.364221	4378.857317	4379.926264
21892	GBP	300	1786683600	1.349869	1.350025	1.349646	1.349934
132271	BTC	300	1788430800	77576.010302	77683.915295	77574.952049	77597.638855
132272	SILVER	300	1788430800	66.199087	66.237631	66.161524	66.179002
142440	SILVER	300	1788437100	66.334695	66.396439	66.326455	66.379428
25096	SILVER	180	1786685580	63.939950	63.965116	63.927774	63.955172
22185	GOLD	180	1786683780	4379.942629	4380.389570	4379.353904	4379.550691
22186	GBP	180	1786683780	1.349851	1.350025	1.349714	1.349956
25289	GOLD	300	1786685700	4372.919307	4374.383852	4372.184724	4374.330793
22188	SILVER	180	1786683780	64.080066	64.110345	64.065284	64.100107
24213	GOLD	180	1786685040	4375.169302	4375.711200	4372.967858	4373.171115
24505	GOLD	180	1786685220	4373.124641	4374.635166	4372.500000	4373.384406
22481	GOLD	180	1786683960	4379.456016	4381.380067	4379.339118	4380.256765
24215	GBP	180	1786685040	1.349752	1.350108	1.349673	1.349794
22482	GBP	180	1786683960	1.349941	1.349964	1.349690	1.349884
21891	GBP	180	1786683600	1.349869	1.349942	1.349646	1.349853
21895	SILVER	180	1786683600	64.060205	64.097751	64.044297	64.078365
24309	GOLD	300	1786685100	4375.597074	4375.646546	4372.500000	4373.384406
22484	SILVER	180	1786683960	64.101737	64.128414	64.096504	64.127858
24506	GBP	180	1786685220	1.349827	1.350195	1.349749	1.350156
24219	SILVER	180	1786685040	63.972887	63.991037	63.909488	63.911811
24310	GBP	300	1786685100	1.349944	1.350195	1.349673	1.350156
23349	GOLD	180	1786684500	4380.389028	4380.495538	4376.709357	4376.740014
23830	GOLD	300	1786684800	4374.545500	4377.275860	4374.317442	4375.546525
23351	GBP	180	1786684500	1.349862	1.350007	1.349679	1.349865
23832	GBP	300	1786684800	1.349784	1.350108	1.349699	1.349961
23355	SILVER	180	1786684500	64.073241	64.077717	63.947778	63.950547
130333	GOLD	300	1788308400	4370.174112	4374.000000	4364.979096	4372.945757
130334	GBP	300	1788308400	1.351071	1.351536	1.350881	1.351262
130335	BTC	300	1788308400	77355.710149	77420.919865	77296.433611	77368.672370
23925	GOLD	180	1786684860	4375.507583	4377.275860	4375.167180	4375.245143
23836	SILVER	300	1786684800	63.953291	63.997038	63.905000	63.975797
23061	GOLD	180	1786684320	4378.468157	4381.088834	4378.450108	4380.386680
22873	GOLD	300	1786684200	4381.319310	4381.528630	4378.450108	4380.386680
23063	GBP	180	1786684320	1.349890	1.350066	1.349751	1.349855
22874	GBP	300	1786684200	1.349767	1.350066	1.349655	1.349855
130336	SILVER	300	1788308400	64.747933	64.800580	64.614851	64.797646
22773	GOLD	180	1786684140	4380.229463	4381.528630	4378.512189	4378.512189
23067	SILVER	180	1786684320	64.073449	64.082463	64.060000	64.070900
22774	GBP	180	1786684140	1.349916	1.349996	1.349655	1.349890
22381	GOLD	300	1786683900	4379.800618	4381.380067	4379.339118	4381.317429
22876	SILVER	300	1786684200	64.112155	64.146387	64.060000	64.070900
22382	GBP	300	1786683900	1.349935	1.349996	1.349690	1.349783
21896	SILVER	300	1786683600	64.060205	64.103174	64.044297	64.101337
132755	BTC	300	1788431100	77600.234269	77625.584953	77559.402209	77596.778052
22384	SILVER	300	1786683900	64.102926	64.129038	64.082423	64.111493
132656	SILVER	180	1788431040	66.183140	66.201847	66.161524	66.184554
22776	SILVER	180	1786684140	64.129038	64.146387	64.068736	64.073189
142439	BTC	300	1788437100	77880.730281	77928.922373	77846.590449	77913.388422
131453	GOLD	180	1788426540	4483.217758	4483.801189	4480.576388	4483.009340
23927	GBP	180	1786684860	1.349805	1.349897	1.349699	1.349742
23350	GOLD	300	1786684500	4380.389028	4380.495538	4374.564394	4374.564481
23352	GBP	300	1786684500	1.349862	1.350007	1.349679	1.349797
131455	GBP	180	1788426540	1.350279	1.350340	1.350082	1.350129
131457	BTC	180	1788426540	77854.835782	77886.061419	77831.334511	77883.270025
23356	SILVER	300	1786684500	64.073241	64.077717	63.900388	63.950736
23931	SILVER	180	1786684860	63.932138	63.997038	63.930100	63.973886
131459	SILVER	180	1788426540	66.508745	66.514398	66.453155	66.514018
132753	GOLD	300	1788431100	4471.043144	4472.215858	4468.455434	4469.090409
23637	GOLD	180	1786684680	4376.640481	4376.788148	4374.317442	4375.447605
132754	GBP	300	1788431100	1.349228	1.349561	1.349130	1.349281
23639	GBP	180	1786684680	1.349854	1.350003	1.349688	1.349772
132756	SILVER	300	1788431100	66.178274	66.191887	66.049604	66.049604
132653	GOLD	180	1788431040	4470.085835	4472.215858	4470.085835	4470.599193
23643	SILVER	180	1786684680	63.951533	63.957222	63.900388	63.933305
24508	SILVER	180	1786685220	63.913179	63.961551	63.894060	63.961551
24312	SILVER	300	1786685100	63.977126	63.986842	63.894060	63.961551
24797	GOLD	180	1786685400	4373.260179	4373.965972	4371.973123	4372.083828
25681	GOLD	180	1786685940	4373.667063	4374.679951	4366.394875	4368.294115
24799	GBP	180	1786685400	1.350128	1.350274	1.349794	1.350065
24798	GOLD	300	1786685400	4373.260179	4373.965972	4371.809412	4373.020760
132654	GBP	180	1788431040	1.349151	1.349561	1.349096	1.349474
24803	SILVER	180	1786685400	63.959181	64.002634	63.937759	63.939436
24800	GBP	300	1786685400	1.350128	1.350274	1.349794	1.350005
25093	GOLD	180	1786685580	4372.151364	4373.824318	4371.809412	4373.133220
132655	BTC	180	1788431040	77640.042755	77642.336478	77559.402209	77615.254462
25094	GBP	180	1786685580	1.350045	1.350089	1.349853	1.349933
25389	GOLD	180	1786685760	4373.143038	4374.034697	4372.184724	4373.749803
24804	SILVER	300	1786685400	63.959181	64.002634	63.927774	63.951824
25390	GBP	180	1786685760	1.349962	1.350124	1.349823	1.350035
25682	GBP	180	1786685940	1.350044	1.350130	1.349848	1.350011
25392	SILVER	180	1786685760	63.955716	63.968996	63.937380	63.957033
142537	GOLD	180	1788437160	4486.918221	4490.200000	4486.439385	4490.077847
25290	GBP	300	1786685700	1.349993	1.350130	1.349823	1.349885
142538	GBP	180	1788437160	1.349683	1.349910	1.349526	1.349787
25292	SILVER	300	1786685700	63.953845	63.975707	63.937380	63.965474
25784	SILVER	300	1786686000	63.965020	63.969730	63.645646	63.777711
142539	BTC	180	1788437160	77902.326380	77905.716499	77846.590449	77864.390683
25684	SILVER	180	1786685940	63.955807	63.975707	63.645646	63.708529
25781	GOLD	300	1786686000	4374.445389	4374.679951	4366.394875	4371.235871
25782	GBP	300	1786686000	1.349917	1.350139	1.349879	1.350015
25969	GOLD	180	1786686120	4368.165440	4373.110990	4368.061279	4371.235871
142540	SILVER	180	1788437160	66.357174	66.378542	66.326455	66.375772
25971	GBP	180	1786686120	1.350006	1.350139	1.349891	1.350015
153537	GOLD	180	1788444000	4504.983318	4510.149361	4504.923173	4509.650858
153538	GOLD	300	1788444000	4504.983318	4510.149361	4504.923173	4509.732461
28009	GOLD	180	1786687380	4383.341512	4386.852410	4382.582665	4386.606334
26744	SILVER	300	1786686600	63.954042	64.023799	63.915000	63.919638
28208	SILVER	300	1786687500	64.339622	64.440608	64.328967	64.401631
28010	GBP	180	1786687380	1.350148	1.350329	1.349981	1.350281
27713	GOLD	180	1786687200	4378.489585	4383.700000	4378.489585	4383.296331
27715	GBP	180	1786687200	1.349932	1.350343	1.349919	1.350155
27421	GOLD	180	1786687020	4377.109390	4378.958731	4375.520709	4378.411645
27225	GOLD	300	1786686900	4372.877127	4378.958731	4372.461533	4378.411645
26833	GOLD	180	1786686660	4376.152214	4378.159207	4374.200000	4374.454540
27422	GBP	180	1786687020	1.349911	1.350133	1.349907	1.349962
26834	GBP	180	1786686660	1.350009	1.350107	1.349751	1.349916
26258	GOLD	300	1786686300	4371.166194	4379.410192	4371.166194	4377.382459
27226	GBP	300	1786686900	1.350114	1.350201	1.349907	1.349962
26260	GBP	300	1786686300	1.350018	1.350130	1.349730	1.349985
26264	SILVER	300	1786686300	63.777290	64.050119	63.768656	63.956460
26836	SILVER	180	1786686660	63.969611	64.023799	63.938069	63.941109
142929	GOLD	300	1788437400	4490.443415	4494.137655	4487.557778	4493.914286
131747	SILVER	180	1788426720	66.514169	66.515698	66.453568	66.502464
27424	SILVER	180	1786687020	64.036697	64.138427	64.029689	64.127449
27228	SILVER	300	1786686900	63.921525	64.138427	63.910000	64.127449
27125	GOLD	180	1786686840	4374.574957	4377.200000	4372.461533	4377.115529
26257	GOLD	180	1786686300	4371.166194	4376.715534	4371.166194	4375.370708
131556	SILVER	300	1788426600	66.499967	66.515698	66.453155	66.502464
26259	GBP	180	1786686300	1.350018	1.350130	1.349827	1.349960
27126	GBP	180	1786686840	1.349935	1.350201	1.349880	1.349925
131743	GBP	180	1788426720	1.350133	1.350294	1.349900	1.350045
131552	GBP	300	1788426600	1.350130	1.350303	1.349900	1.350045
26263	SILVER	180	1786686300	63.777290	63.925454	63.768656	63.921362
131745	BTC	180	1788426720	77881.098816	77929.614132	77805.200978	77835.250207
27128	SILVER	180	1786686840	63.940952	64.040000	63.910000	64.034403
26545	GOLD	180	1786686480	4375.272851	4379.410192	4375.272851	4376.245632
26547	GBP	180	1786686480	1.349955	1.350115	1.349730	1.349990
130433	GOLD	180	1788308460	4369.038333	4370.787714	4364.979096	4370.787714
130434	GBP	180	1788308460	1.351007	1.351536	1.350881	1.351272
26551	SILVER	180	1786686480	63.921462	64.050119	63.910473	63.970951
27719	SILVER	180	1786687200	64.129701	64.328254	64.126267	64.299550
130435	BTC	180	1788308460	77328.121541	77420.919865	77296.433611	77368.065528
25975	SILVER	180	1786686120	63.709050	63.816382	63.709050	63.777711
130436	SILVER	180	1788308460	64.720302	64.724602	64.614851	64.704633
27714	GOLD	300	1786687200	4378.489585	4385.227118	4378.489585	4384.398671
28012	SILVER	180	1786687380	64.297167	64.399763	64.293191	64.395999
27716	GBP	300	1786687200	1.349932	1.350343	1.349919	1.350223
28308	SILVER	180	1786687560	64.396345	64.440608	64.328967	64.363376
132949	GOLD	180	1788431220	4470.683200	4470.706747	4468.455434	4469.090409
27720	SILVER	300	1786687200	64.129701	64.399763	64.126267	64.339768
131741	GOLD	180	1788426720	4483.071181	4483.506313	4480.355123	4483.339502
26738	GOLD	300	1786686600	4377.392329	4378.700000	4372.485319	4372.933888
131550	GOLD	300	1788426600	4481.968699	4483.801189	4480.355123	4483.339502
131554	BTC	300	1788426600	77847.408700	77929.614132	77805.200978	77835.250207
26740	GBP	300	1786686600	1.350005	1.350108	1.349751	1.350108
132950	GBP	180	1788431220	1.349487	1.349487	1.349130	1.349281
28600	SILVER	180	1786687740	64.361021	64.443065	64.353322	64.389452
28896	SILVER	180	1786687920	64.390103	64.418104	64.362789	64.406803
132951	BTC	180	1788431220	77611.876865	77625.584953	77569.893899	77596.778052
28700	SILVER	300	1786687800	64.400929	64.443065	64.353322	64.406803
132952	SILVER	180	1788431220	66.184375	66.189123	66.049604	66.049604
28597	GOLD	180	1786687740	4387.397626	4389.567477	4387.243735	4388.576417
29479	SILVER	180	1786688280	64.318899	64.331393	64.284743	64.299125
29185	GOLD	180	1786688100	4391.555162	4392.361175	4387.281892	4387.451140
28598	GBP	180	1786687740	1.350267	1.350358	1.350100	1.350184
28205	GOLD	300	1786687500	4384.490943	4389.478871	4384.490943	4389.361555
28305	GOLD	180	1786687560	4386.541991	4387.792141	4385.224938	4387.282809
29475	GBP	180	1786688280	1.350226	1.350343	1.349930	1.350147
28306	GBP	180	1786687560	1.350248	1.350369	1.350082	1.350288
28206	GBP	300	1786687500	1.350214	1.350369	1.350082	1.350273
28893	GOLD	180	1786687920	4388.487375	4391.744812	4388.369594	4391.560247
28697	GOLD	300	1786687800	4389.236804	4391.744812	4388.000000	4391.560247
28894	GBP	180	1786687920	1.350168	1.350373	1.350005	1.350164
28698	GBP	300	1786687800	1.350281	1.350373	1.350005	1.350164
29187	GBP	180	1786688100	1.350159	1.350377	1.350107	1.350219
142930	GBP	300	1788437400	1.349839	1.349899	1.349368	1.349722
142931	BTC	300	1788437400	77912.347803	78060.868945	77897.630904	78057.663180
29672	SILVER	300	1786688400	64.307836	64.327846	64.277995	64.280130
142932	SILVER	300	1788437400	66.377849	66.436660	66.319145	66.406364
142832	SILVER	180	1788437340	66.374544	66.396439	66.319145	66.349221
29186	GOLD	300	1786688100	4391.555162	4392.361175	4385.859066	4386.894755
29191	SILVER	180	1786688100	64.407761	64.421676	64.315000	64.320951
29192	SILVER	300	1786688100	64.407761	64.421676	64.285329	64.305772
29188	GBP	300	1786688100	1.350159	1.350377	1.350028	1.350028
29761	GOLD	180	1786688460	4385.497744	4386.086059	4385.497744	4385.860463
29763	GBP	180	1786688460	1.350141	1.350141	1.350037	1.350060
29668	GBP	300	1786688400	1.350053	1.350300	1.349930	1.350060
29473	GOLD	180	1786688280	4387.389034	4387.547835	4384.943510	4385.535862
29767	SILVER	180	1786688460	64.301251	64.305000	64.277995	64.280130
29666	GOLD	300	1786688400	4386.875304	4386.875304	4384.943510	4385.860463
29804	GBP	300	1786695300	1.351753	1.351788	1.351662	1.351781
29801	GOLD	180	1786695480	4400.400000	4402.213245	4399.702374	4401.312849
29803	GBP	180	1786695480	1.351753	1.351827	1.351538	1.351665
142829	GOLD	180	1788437340	4489.992216	4490.865269	4487.557778	4489.700564
142830	GBP	180	1788437340	1.349800	1.349899	1.349584	1.349618
142831	BTC	180	1788437340	77868.618344	78038.088323	77848.766131	78030.208890
31377	GOLD	300	1786696500	4400.325006	4402.258329	4399.808130	4401.028143
32849	GOLD	300	1786697400	4404.094557	4405.487283	4399.520335	4399.632806
31378	GBP	300	1786696500	1.352226	1.352540	1.352065	1.352432
32656	SILVER	180	1786697280	64.861224	64.897083	64.825734	64.856988
32950	GBP	180	1786697460	1.352053	1.352242	1.351886	1.352146
31380	SILVER	300	1786696500	64.701205	64.722394	64.659495	64.708945
31477	GOLD	180	1786696560	4400.458051	4401.489351	4399.808130	4401.489351
30321	GOLD	180	1786695840	4402.516561	4404.906103	4402.279673	4403.331205
30322	GBP	180	1786695840	1.351632	1.352123	1.351454	1.351928
31478	GBP	180	1786696560	1.352230	1.352540	1.352065	1.352364
29929	GOLD	300	1786695600	4401.532509	4403.887388	4400.371433	4403.362619
29930	GBP	300	1786695600	1.351781	1.352000	1.351454	1.351876
30324	SILVER	180	1786695840	64.815302	64.820073	64.754801	64.788192
132035	SILVER	180	1788426900	66.500325	66.507459	66.455735	66.505564
132036	SILVER	300	1788426900	66.500325	66.507459	66.455735	66.505564
29932	SILVER	300	1786695600	64.803785	64.820073	64.743947	64.798870
132030	GOLD	300	1788426900	4483.408624	4484.317066	4481.342641	4484.227034
132031	GBP	180	1788426900	1.350030	1.350152	1.349854	1.349872
31480	SILVER	180	1786696560	64.686152	64.722394	64.659495	64.686034
133238	BTC	300	1788431400	77594.023857	77615.229970	77547.771160	77559.763235
30893	GOLD	180	1786696200	4402.894199	4403.120787	4399.974165	4399.999267
133240	SILVER	300	1788431400	66.047542	66.058886	65.974089	65.994737
30895	GBP	180	1786696200	1.352313	1.352381	1.352029	1.352144
130725	GOLD	180	1788308640	4370.730354	4374.000000	4370.692816	4372.945757
32358	GOLD	300	1786697100	4400.092693	4405.496883	4400.092693	4404.167954
30899	SILVER	180	1786696200	64.772768	64.772768	64.685937	64.699039
33342	GBP	300	1786697700	1.352353	1.352522	1.351978	1.352419
130726	GBP	180	1788308640	1.351267	1.351410	1.351129	1.351262
32360	GBP	300	1786697100	1.352409	1.352426	1.352051	1.352153
30894	GOLD	300	1786696200	4402.894199	4403.120787	4399.600000	4400.278441
30896	GBP	300	1786696200	1.352313	1.352381	1.351948	1.352224
130727	BTC	180	1788308640	77370.461121	77377.320000	77358.677928	77368.672370
130728	SILVER	180	1788308640	64.702966	64.800580	64.695813	64.797646
30900	SILVER	300	1786696200	64.772768	64.772768	64.671783	64.700676
31769	GOLD	180	1786696740	4401.371901	4402.300000	4400.626075	4401.200566
31770	GBP	180	1786696740	1.352352	1.352768	1.352282	1.352674
32065	GOLD	180	1786696920	4401.278852	4402.756780	4399.851554	4400.137301
30029	GOLD	180	1786695660	4401.380221	4402.611421	4400.451106	4402.515959
31869	GOLD	300	1786696800	4401.068951	4402.756780	4399.851554	4400.137301
31181	GOLD	180	1786696380	4399.938903	4400.784331	4399.600000	4400.583835
30030	GBP	180	1786695660	1.351661	1.351790	1.351508	1.351644
31772	SILVER	180	1786696740	64.687333	64.730729	64.673638	64.675927
29807	SILVER	180	1786695480	64.730000	64.808658	64.726581	64.770529
29802	GOLD	300	1786695300	4400.400000	4402.213245	4399.702374	4401.429712
31182	GBP	180	1786696380	1.352134	1.352380	1.351948	1.352236
132029	GOLD	180	1788426900	4483.408624	4484.317066	4481.342641	4484.227034
32066	GBP	180	1786696920	1.352688	1.352690	1.352232	1.352384
29808	SILVER	300	1786695300	64.730000	64.805857	64.726581	64.802116
132032	GBP	300	1788426900	1.350030	1.350152	1.349854	1.349872
132033	BTC	180	1788426900	77836.691858	77879.323434	77807.571821	77848.301789
30605	GOLD	180	1786696020	4403.337413	4405.624958	4402.000000	4402.965588
132034	BTC	300	1788426900	77836.691858	77879.323434	77807.571821	77848.301789
30414	GOLD	300	1786695900	4403.284763	4405.624958	4402.000000	4402.965588
30032	SILVER	180	1786695660	64.771379	64.813314	64.743947	64.813025
30607	GBP	180	1786696020	1.351953	1.352404	1.351872	1.352281
30416	GBP	300	1786695900	1.351866	1.352404	1.351826	1.352281
31184	SILVER	180	1786696380	64.701188	64.711619	64.671783	64.687419
30611	SILVER	180	1786696020	64.788957	64.870469	64.770306	64.770306
30420	SILVER	300	1786695900	64.800843	64.870469	64.754801	64.770306
31870	GBP	300	1786696800	1.352448	1.352768	1.352232	1.352384
32068	SILVER	180	1786696920	64.675523	64.697589	64.656078	64.675480
31872	SILVER	300	1786696800	64.711364	64.730729	64.656078	64.675480
32952	SILVER	180	1786697460	64.858498	64.863779	64.784228	64.808220
32653	GOLD	180	1786697280	4405.252998	4405.496883	4403.176474	4404.703816
133233	GOLD	180	1788431400	4469.082091	4469.622327	4466.930209	4468.804464
32364	SILVER	300	1786697100	64.675510	64.866932	64.675510	64.865189
143125	GOLD	180	1788437520	4489.584672	4494.137655	4489.549755	4493.914286
32357	GOLD	180	1786697100	4400.092693	4405.400000	4400.092693	4405.162117
32359	GBP	180	1786697100	1.352409	1.352426	1.352067	1.352263
133235	GBP	180	1788431400	1.349293	1.349356	1.348897	1.349040
133234	GOLD	300	1788431400	4469.082091	4469.622327	4465.842985	4465.905693
32363	SILVER	180	1786697100	64.675510	64.862076	64.675510	64.862076
133237	BTC	180	1788431400	77594.023857	77613.877386	77547.771160	77613.527120
32654	GBP	180	1786697280	1.352253	1.352312	1.351936	1.352020
133236	GBP	300	1788431400	1.349293	1.349356	1.348767	1.348933
133239	SILVER	180	1788431400	66.047542	66.050000	65.974089	66.036010
32949	GOLD	180	1786697460	4404.620175	4405.487283	4401.407601	4401.407601
33341	GOLD	300	1786697700	4399.742728	4400.767530	4399.065748	4400.465809
32850	GBP	300	1786697400	1.352162	1.352373	1.351886	1.352347
32852	SILVER	300	1786697400	64.864726	64.897083	64.763255	64.765531
33244	SILVER	180	1786697640	64.806655	64.814547	64.759082	64.808768
33344	SILVER	300	1786697700	64.766179	64.864273	64.759082	64.858853
33241	GOLD	180	1786697640	4401.344857	4402.231712	4399.065748	4400.676577
33242	GBP	180	1786697640	1.352165	1.352373	1.352027	1.352112
143126	GBP	180	1788437520	1.349590	1.349771	1.349368	1.349722
33537	GOLD	180	1786697820	4400.725489	4400.767530	4399.532426	4400.465809
33538	GBP	180	1786697820	1.352134	1.352522	1.351978	1.352419
143127	BTC	180	1788437520	78025.742653	78060.868945	77973.682141	78057.663180
33540	SILVER	180	1786697820	64.809073	64.864273	64.790014	64.858853
143128	SILVER	180	1788437520	66.347017	66.436660	66.324476	66.406364
153539	GBP	180	1788444000	1.351441	1.351947	1.351123	1.351374
34410	GBP	180	1786698360	1.352177	1.352447	1.352131	1.352328
35776	GBP	300	1786699200	1.352253	1.352332	1.351974	1.352202
34412	SILVER	180	1786698360	64.885059	64.905000	64.833872	64.842636
143422	BTC	300	1788437700	78053.004731	78108.444282	77911.588822	77959.336945
33830	GOLD	300	1786698000	4400.511607	4403.771653	4399.826893	4403.288882
33832	GBP	300	1786698000	1.352425	1.352642	1.352241	1.352325
34704	SILVER	180	1786698540	64.841833	64.885446	64.833251	64.847126
143713	GOLD	180	1788437880	4491.273940	4496.357425	4491.219977	4496.288632
143424	SILVER	300	1788437700	66.404261	66.404301	66.291654	66.321866
33836	SILVER	300	1786698000	64.861091	64.883488	64.844978	64.863603
143714	GBP	180	1788437880	1.349617	1.349738	1.349458	1.349504
133521	GOLD	180	1788431580	4468.917640	4469.439428	4465.767752	4468.168840
35289	GOLD	180	1786698900	4403.835799	4403.835799	4402.369722	4403.658566
133523	GBP	180	1788431580	1.349043	1.349059	1.348767	1.348944
35291	GBP	180	1786698900	1.352282	1.352427	1.352010	1.352344
37041	GOLD	180	1786699980	4406.492472	4410.000000	4405.526566	4408.956132
133525	BTC	180	1788431580	77611.739522	77615.229970	77465.530576	77509.938859
35780	SILVER	300	1786699200	64.917143	64.919424	64.809963	64.844047
35295	SILVER	180	1786698900	64.890873	64.901971	64.869237	64.882493
133527	SILVER	180	1788431580	66.034567	66.058886	65.984776	66.017369
143417	GOLD	180	1788437700	4493.845931	4495.181290	4491.269042	4491.324965
33829	GOLD	180	1786698000	4400.511607	4402.505133	4399.826893	4402.494977
35585	GOLD	180	1786699080	4403.689971	4405.361607	4403.582632	4404.334463
33831	GBP	180	1786698000	1.352425	1.352642	1.352269	1.352568
36752	SILVER	300	1786699800	64.827382	64.891021	64.824668	64.882693
143715	BTC	180	1788437880	77988.935962	77988.935962	77900.863772	77905.070219
35586	GBP	180	1786699080	1.352322	1.352413	1.352052	1.352107
33835	SILVER	180	1786698000	64.861091	64.875655	64.844978	64.858580
35869	GOLD	180	1786699260	4404.204986	4405.524068	4403.848132	4405.019440
34117	GOLD	180	1786698180	4402.531620	4404.600366	4402.220229	4403.930961
143419	GBP	180	1788437700	1.349705	1.349718	1.349446	1.349632
143418	GOLD	300	1788437700	4493.845931	4495.181290	4491.219977	4493.315784
34119	GBP	180	1786698180	1.352545	1.352585	1.352202	1.352202
34997	GOLD	180	1786698720	4404.450639	4404.961745	4403.387080	4403.926452
34801	GOLD	300	1786698600	4404.939704	4405.393953	4403.182380	4403.926452
34123	SILVER	180	1786698180	64.859327	64.895000	64.857999	64.885273
34998	GBP	180	1786698720	1.352294	1.352365	1.352083	1.352285
34802	GBP	300	1786698600	1.352239	1.352419	1.352083	1.352285
34309	GOLD	300	1786698300	4403.391135	4405.700000	4402.850424	4404.829388
34310	GBP	300	1786698300	1.352353	1.352481	1.352131	1.352261
35000	SILVER	180	1786698720	64.846789	64.900474	64.838159	64.891339
34804	SILVER	300	1786698600	64.877560	64.900474	64.838159	64.891339
34312	SILVER	300	1786698300	64.861452	64.905000	64.833251	64.877238
36745	GOLD	180	1786699800	4405.282740	4407.919916	4405.040618	4406.381353
35588	SILVER	180	1786699080	64.881935	64.919424	64.879602	64.886317
35871	GBP	180	1786699260	1.352089	1.352276	1.351974	1.352203
37044	SILVER	180	1786699980	64.860705	64.952063	64.852634	64.922105
143421	BTC	180	1788437700	78053.004731	78108.444282	77977.575611	77985.579022
34409	GOLD	180	1786698360	4403.942148	4405.700000	4402.915393	4404.617589
143716	SILVER	180	1788437880	66.317796	66.381437	66.291654	66.373806
36157	GOLD	180	1786699440	4404.994699	4407.769543	4404.911998	4406.800488
35875	SILVER	180	1786699260	64.888196	64.889630	64.809963	64.837639
36747	GBP	180	1786699800	1.352295	1.352477	1.352192	1.352354
35290	GOLD	300	1786698900	4403.835799	4405.361607	4402.369722	4405.036652
35292	GBP	300	1786698900	1.352282	1.352427	1.352010	1.352256
143423	SILVER	180	1788437700	66.404261	66.404301	66.303894	66.316355
34701	GOLD	180	1786698540	4404.702422	4405.393953	4403.182380	4404.505977
34702	GBP	180	1786698540	1.352360	1.352481	1.352182	1.352261
36158	GBP	180	1786699440	1.352203	1.352340	1.352076	1.352224
35296	SILVER	300	1786698900	64.890873	64.918807	64.869237	64.915977
36160	SILVER	180	1786699440	64.837282	64.874908	64.830401	64.859486
36453	GOLD	180	1786699620	4406.768659	4407.214622	4404.824091	4405.174074
36257	GOLD	300	1786699500	4406.800308	4407.769543	4404.824091	4405.174074
143420	GBP	300	1788437700	1.349705	1.349727	1.349446	1.349483
36454	GBP	180	1786699620	1.352241	1.352444	1.352184	1.352327
36746	GOLD	300	1786699800	4405.282740	4407.919916	4405.040618	4407.554735
36751	SILVER	180	1786699800	64.827382	64.891021	64.824668	64.862987
37042	GBP	180	1786699980	1.352387	1.352490	1.352068	1.352120
37325	GOLD	180	1786700160	4409.000806	4409.273471	4405.620417	4407.201723
36748	GBP	300	1786699800	1.352295	1.352490	1.352105	1.352224
37327	GBP	180	1786700160	1.352128	1.352280	1.351976	1.352171
35774	GOLD	300	1786699200	4405.150849	4406.900000	4403.848132	4406.802003
36258	GBP	300	1786699500	1.352203	1.352444	1.352076	1.352327
36456	SILVER	180	1786699620	64.860878	64.883837	64.827590	64.828788
36260	SILVER	300	1786699500	64.841919	64.883837	64.827590	64.828788
153540	GBP	300	1788444000	1.351441	1.351947	1.350896	1.351297
153541	BTC	180	1788444000	78813.050327	78827.120000	78683.006257	78774.328197
37331	SILVER	180	1786700160	64.924112	64.931053	64.853703	64.864308
37230	GOLD	300	1786700100	4407.499091	4410.000000	4405.620417	4407.414646
153542	BTC	300	1788444000	78813.050327	78907.440000	78683.006257	78873.711497
37232	GBP	300	1786700100	1.352235	1.352339	1.351976	1.352247
153543	SILVER	180	1788444000	66.655437	66.825000	66.654361	66.816481
37236	SILVER	300	1786700100	64.881899	64.952063	64.850318	64.853308
37710	GOLD	300	1786700400	4407.348175	4410.002230	4406.187251	4408.819567
153544	SILVER	300	1788444000	66.655437	66.828291	66.654361	66.825169
37615	GBP	180	1786700340	1.352176	1.352387	1.352059	1.352217
37619	SILVER	180	1786700340	64.866075	64.881627	64.796941	64.796941
37613	GOLD	180	1786700340	4407.276504	4408.141463	4406.399253	4406.399253
39067	GBP	180	1786701240	1.352355	1.352590	1.352262	1.352305
37901	GOLD	180	1786700520	4406.304167	4410.002230	4406.187251	4408.819567
37902	GBP	180	1786700520	1.352207	1.352333	1.352015	1.352161
37712	GBP	300	1786700400	1.352272	1.352387	1.352015	1.352161
37904	SILVER	180	1786700520	64.799236	64.915000	64.799236	64.911813
37716	SILVER	300	1786700400	64.850966	64.915000	64.796941	64.911813
133815	SILVER	180	1788431760	66.017513	66.067948	66.001890	66.026605
133718	BTC	300	1788431700	77561.963373	77565.179333	77465.258190	77499.228887
38194	GOLD	300	1786700700	4408.856458	4410.857190	4408.120862	4408.953849
39931	GBP	180	1786701780	1.352634	1.352668	1.352366	1.352609
38196	GBP	300	1786700700	1.352131	1.352533	1.352023	1.352293
39071	SILVER	180	1786701240	64.897434	64.932134	64.892466	64.926852
133720	SILVER	300	1788431700	65.993578	66.067948	65.984776	66.019665
38193	GOLD	180	1786700700	4408.856458	4410.857190	4408.642163	4410.219464
39647	SILVER	180	1786701600	64.907268	64.934309	64.880933	64.930819
38195	GBP	180	1786700700	1.352131	1.352533	1.352023	1.352288
38200	SILVER	300	1786700700	64.912799	64.945050	64.852667	64.866504
133809	GOLD	180	1788431760	4468.282111	4470.002244	4467.636948	4468.438428
38199	SILVER	180	1786700700	64.912799	64.945050	64.872184	64.886676
38685	GOLD	300	1786701000	4409.083822	4409.916601	4408.135654	4409.796398
143909	GOLD	300	1788438000	4493.393938	4496.655791	4489.521452	4490.816544
38686	GBP	300	1786701000	1.352320	1.352458	1.352175	1.352428
133811	GBP	180	1788431760	1.348924	1.348940	1.348608	1.348743
38688	SILVER	300	1786701000	64.865157	64.911209	64.858221	64.901768
143910	GBP	300	1788438000	1.349470	1.349738	1.349012	1.349355
40223	SILVER	180	1786701960	64.934933	64.980125	64.926755	64.980125
133813	BTC	180	1788431760	77507.750088	77508.870757	77465.258190	77465.291273
38777	GOLD	180	1786701060	4409.438668	4409.730101	4408.135654	4409.535821
38779	GBP	180	1786701060	1.352305	1.352458	1.352175	1.352356
133714	GOLD	300	1788431700	4466.032026	4470.002244	4465.767752	4467.744517
38489	GOLD	180	1786700880	4410.117777	4410.343206	4408.120862	4409.367190
38783	SILVER	180	1786701060	64.866103	64.911209	64.860945	64.898862
38490	GBP	180	1786700880	1.352263	1.352471	1.352179	1.352310
38492	SILVER	180	1786700880	64.884272	64.899819	64.852667	64.865293
40795	GBP	180	1786702320	1.352678	1.352919	1.352616	1.352741
39353	GOLD	180	1786701420	4409.930886	4410.775373	4408.397838	4409.736486
144011	BTC	180	1788438060	77903.268058	77971.018443	77891.288561	77956.643871
39162	GOLD	300	1786701300	4409.890210	4410.775373	4408.397838	4409.736486
39355	GBP	180	1786701420	1.352295	1.352557	1.352246	1.352482
39164	GBP	300	1786701300	1.352459	1.352590	1.352246	1.352482
144012	SILVER	180	1788438060	66.371651	66.395387	66.249359	66.286136
133716	GBP	300	1788431700	1.348921	1.348978	1.348575	1.348685
39359	SILVER	180	1786701420	64.924299	64.931914	64.901543	64.905859
39168	SILVER	300	1786701300	64.902765	64.932134	64.900332	64.905859
144009	GOLD	180	1788438060	4496.405550	4496.655791	4489.521452	4490.877168
144010	GBP	180	1788438060	1.349514	1.349605	1.349072	1.349085
39935	SILVER	180	1786701780	64.928314	64.965578	64.912897	64.937000
40505	GOLD	180	1786702140	4411.074274	4414.176156	4410.910679	4412.518833
40604	GBP	300	1786702200	1.352521	1.352919	1.352481	1.352741
40507	GBP	180	1786702140	1.352536	1.352847	1.352427	1.352700
40122	GOLD	300	1786701900	4410.703925	4413.800138	4410.265759	4413.800138
39642	GOLD	300	1786701600	4409.758666	4411.542229	4409.156126	4410.791699
143911	BTC	300	1788438000	77962.303925	77984.603037	77891.288561	77959.134371
40124	GBP	300	1786701900	1.352472	1.352744	1.352366	1.352535
40511	SILVER	180	1786702140	64.981169	65.061770	64.977608	65.041838
39065	GOLD	180	1786701240	4409.514063	4410.741038	4408.662575	4409.871610
143912	SILVER	300	1788438000	66.321647	66.395387	66.249359	66.273075
40799	SILVER	180	1786702320	65.039644	65.079509	65.033518	65.033518
40217	GOLD	180	1786701960	4410.694234	4411.803293	4410.626925	4411.143914
39929	GOLD	180	1786701780	4410.531164	4411.515351	4410.024057	4410.764231
41081	GOLD	180	1786702500	4413.472061	4415.003153	4412.585119	4413.347747
40608	SILVER	300	1786702200	65.060287	65.079509	65.005366	65.033518
39644	GBP	300	1786701600	1.352488	1.352684	1.352352	1.352459
40128	SILVER	300	1786701900	64.954430	65.057946	64.926755	65.057946
153833	GOLD	180	1788444180	4509.691694	4512.315321	4506.795978	4511.974303
39641	GOLD	180	1786701600	4409.758666	4411.542229	4409.156126	4410.660116
39643	GBP	180	1786701600	1.352488	1.352684	1.352352	1.352616
39648	SILVER	300	1786701600	64.907268	64.960000	64.880933	64.956715
40219	GBP	180	1786701960	1.352591	1.352744	1.352501	1.352567
41087	SILVER	180	1786702500	65.033053	65.034778	64.984331	64.998889
41574	GBP	300	1786702800	1.352745	1.352946	1.352653	1.352668
41377	GOLD	180	1786702680	4413.429504	4413.877309	4411.700000	4412.040514
40793	GOLD	180	1786702320	4412.467327	4414.039137	4412.304796	4413.359025
153834	GBP	180	1788444180	1.351360	1.351397	1.350896	1.351201
154029	GOLD	300	1788444300	4509.674735	4517.068262	4509.230197	4516.901100
40602	GOLD	300	1786702200	4413.683861	4414.176156	4411.972980	4413.359025
41088	SILVER	300	1786702500	65.033053	65.034778	64.973031	64.976644
41083	GBP	180	1786702500	1.352766	1.352912	1.352581	1.352780
154030	GBP	300	1788444300	1.351308	1.351621	1.351014	1.351170
41573	GOLD	300	1786702800	4412.172500	4413.223533	4409.889138	4410.214863
41378	GBP	180	1786702680	1.352797	1.352949	1.352580	1.352713
41082	GOLD	300	1786702500	4413.472061	4415.003153	4412.300000	4412.303085
41084	GBP	300	1786702500	1.352766	1.352949	1.352580	1.352762
41380	SILVER	180	1786702680	65.001012	65.025800	64.969294	64.969677
41673	GOLD	180	1786702860	4411.923348	4413.223533	4411.681629	4412.579627
41674	GBP	180	1786702860	1.352746	1.352946	1.352653	1.352805
41576	SILVER	300	1786702800	64.977128	64.994744	64.922654	64.939781
153835	BTC	180	1788444180	78778.915162	78907.440000	78775.662250	78847.965716
153836	SILVER	180	1788444180	66.818234	66.945593	66.774302	66.919907
154031	BTC	300	1788444300	78873.207560	78945.505931	78835.892070	78878.646135
154032	SILVER	300	1788444300	66.827614	66.995039	66.822887	66.995039
41965	GOLD	180	1786703040	4412.659223	4412.719258	4409.889138	4410.102128
43604	SILVER	180	1786704660	64.804287	64.837024	64.789795	64.801487
41966	GBP	180	1786703040	1.352782	1.352873	1.352612	1.352644
43896	SILVER	180	1786704840	64.802522	64.834491	64.794122	64.815533
41968	SILVER	180	1786703040	64.959890	64.959890	64.912832	64.917974
42560	SILVER	300	1786703400	64.902433	64.940746	64.877539	64.933077
42261	GOLD	180	1786703220	4410.019003	4411.061384	4408.233598	4409.480580
42065	GOLD	300	1786703100	4410.168883	4411.354646	4408.233598	4409.480580
42262	GBP	180	1786703220	1.352662	1.352834	1.352592	1.352750
42066	GBP	300	1786703100	1.352690	1.352873	1.352592	1.352750
134101	BTC	180	1788431940	77468.580732	77521.950303	77443.839604	77480.746973
134388	SILVER	180	1788432120	65.977736	66.035737	65.971563	66.004719
42264	SILVER	180	1786703220	64.920343	64.925618	64.895000	64.903845
42068	SILVER	300	1786703100	64.942023	64.948254	64.895000	64.903845
134103	SILVER	180	1788431940	66.025486	66.033672	65.978030	65.978030
134194	GOLD	300	1788432000	4467.617456	4470.326225	4466.396375	4469.031533
134386	GBP	180	1788432120	1.348513	1.348758	1.348467	1.348685
43437	GOLD	180	1786703940	4407.542926	4407.716784	4405.971309	4407.020382
43045	GOLD	300	1786703700	4410.157362	4410.383307	4405.971309	4407.020382
43438	GBP	180	1786703940	1.352828	1.353030	1.352794	1.353007
43046	GBP	300	1786703700	1.352745	1.353030	1.352624	1.353007
134200	SILVER	300	1788432000	66.017955	66.035737	65.971563	66.004719
43440	SILVER	180	1786703940	64.905466	64.907232	64.870000	64.870967
43048	SILVER	300	1786703700	64.930829	64.934472	64.870000	64.870967
43513	GOLD	180	1786704480	4405.600000	4405.850617	4404.955802	4405.025942
43145	GOLD	180	1786703760	4409.293353	4409.935122	4407.056353	4407.501561
43514	GOLD	300	1786704600	4405.600000	4407.947332	4404.859181	4407.842725
43146	GBP	180	1786703760	1.352709	1.352905	1.352671	1.352812
43515	GBP	180	1786704480	1.352924	1.353031	1.352864	1.352930
134196	GBP	300	1788432000	1.348696	1.348758	1.348467	1.348685
43148	SILVER	180	1786703760	64.918781	64.925371	64.870945	64.905828
134387	BTC	180	1788432120	77479.981952	77516.601873	77431.082069	77476.869318
42553	GOLD	180	1786703400	4409.510537	4410.507869	4408.142541	4410.118490
41676	SILVER	180	1786702860	64.968189	64.982690	64.948502	64.958421
42555	GBP	180	1786703400	1.352724	1.352982	1.352663	1.352845
134097	GOLD	180	1788431940	4468.503467	4468.646864	4466.396375	4468.646864
42559	SILVER	180	1786703400	64.902433	64.935966	64.877539	64.913254
42849	GOLD	180	1786703580	4410.120117	4410.407326	4409.231770	4409.231770
43516	GBP	300	1786704600	1.352924	1.353151	1.352692	1.352926
42850	GBP	180	1786703580	1.352842	1.352914	1.352608	1.352723
43519	SILVER	180	1786704480	64.810000	64.822099	64.804591	64.804591
134099	GBP	180	1788431940	1.348742	1.348784	1.348494	1.348523
154129	GOLD	180	1788444360	4512.102734	4514.188136	4510.417084	4513.358728
42852	SILVER	180	1786703580	64.912134	64.940746	64.910449	64.920498
144293	GOLD	180	1788438240	4490.942483	4491.084764	4487.663357	4487.765606
43520	SILVER	300	1786704600	64.810000	64.837024	64.789795	64.798127
134385	GOLD	180	1788432120	4468.551445	4470.326225	4466.432529	4469.031533
134198	BTC	300	1788432000	77498.024066	77516.601873	77431.082069	77476.869318
42554	GOLD	300	1786703400	4409.510537	4410.507869	4408.142541	4410.245026
42556	GBP	300	1786703400	1.352724	1.352982	1.352608	1.352757
45057	GOLD	180	1786705560	4406.257602	4406.377094	4404.384033	4405.445802
44481	GOLD	180	1786705200	4407.613547	4409.590046	4407.396508	4409.212463
44769	GOLD	180	1786705380	4409.187537	4409.536803	4405.933119	4406.292663
144295	GBP	180	1788438240	1.349060	1.349463	1.349012	1.349231
44189	GOLD	180	1786705020	4407.900150	4408.898307	4406.980235	4407.714536
43601	GOLD	180	1786704660	4405.092300	4407.468173	4404.859181	4407.303541
43993	GOLD	300	1786704900	4407.935965	4408.898307	4406.980235	4407.714536
43602	GBP	180	1786704660	1.352907	1.353151	1.352692	1.352894
44190	GBP	180	1786705020	1.352828	1.352908	1.352598	1.352814
144297	BTC	180	1788438240	77959.737108	77984.603037	77904.099512	77924.978696
43994	GBP	300	1786704900	1.352944	1.352986	1.352598	1.352814
45063	SILVER	180	1786705560	64.788119	64.815762	64.763379	64.811010
44482	GOLD	300	1786705200	4407.613547	4409.590046	4406.842163	4407.091669
44775	SILVER	180	1786705380	64.857086	64.857086	64.757555	64.787186
44484	GBP	300	1786705200	1.352787	1.353275	1.352701	1.352961
144396	SILVER	300	1788438300	66.274899	66.278659	66.172091	66.255963
43893	GOLD	180	1786704840	4407.369268	4408.859759	4406.611621	4407.980158
44488	SILVER	300	1786705200	64.828318	64.870000	64.815185	64.818505
44483	GBP	180	1786705200	1.352787	1.353171	1.352701	1.353083
43894	GBP	180	1786704840	1.352886	1.352986	1.352710	1.352795
44192	SILVER	180	1786705020	64.817786	64.830164	64.791760	64.830164
43996	SILVER	300	1786704900	64.799727	64.834491	64.791760	64.830164
144299	SILVER	180	1788438240	66.287035	66.292981	66.172091	66.179325
44487	SILVER	180	1786705200	64.828318	64.870000	64.824547	64.855858
45059	GBP	180	1786705560	1.352751	1.352939	1.352680	1.352765
144390	GOLD	300	1788438300	4490.732729	4490.926246	4487.329228	4488.296013
44962	GOLD	300	1786705500	4407.173663	4407.542900	4404.384033	4405.847222
144392	GBP	300	1788438300	1.349324	1.349463	1.348909	1.349167
144394	BTC	300	1788438300	77963.313584	77968.762393	77904.099512	77952.413242
44771	GBP	180	1786705380	1.353094	1.353275	1.352722	1.352722
45445	GOLD	300	1786705800	4405.907011	4407.544955	4404.003742	4405.489405
45448	SILVER	300	1786705800	64.811399	64.831501	64.766897	64.799538
44964	GBP	300	1786705500	1.352934	1.353076	1.352680	1.352889
44968	SILVER	300	1786705500	64.818098	64.829214	64.757555	64.813913
45346	GBP	180	1786705740	1.352779	1.353153	1.352755	1.352942
154130	GBP	180	1788444360	1.351214	1.351621	1.351108	1.351206
154131	BTC	180	1788444360	78852.096445	78945.505931	78847.658035	78867.728175
154132	SILVER	180	1788444360	66.919908	66.984363	66.862777	66.905586
45345	GOLD	180	1786705740	4405.351483	4406.578804	4404.003742	4405.864962
120532	GBP	300	1787020200	1.354148	1.354457	1.353910	1.354253
46214	GBP	180	1786706280	1.353331	1.353541	1.353227	1.353401
46216	SILVER	180	1786706280	64.834763	64.878440	64.829831	64.850439
47390	GOLD	300	1786707000	4411.200035	4413.055068	4409.702750	4410.036554
47984	SILVER	180	1786707360	64.901391	64.990462	64.895089	64.954331
47392	GBP	300	1786707000	1.353541	1.353851	1.353466	1.353758
47396	SILVER	300	1786707000	64.882766	64.943127	64.880721	64.936448
47389	GOLD	180	1786707000	4411.200035	4413.055068	4411.102982	4412.088861
47391	GBP	180	1786707000	1.353541	1.353743	1.353466	1.353582
47395	SILVER	180	1786707000	64.882766	64.943127	64.880721	64.930825
48276	SILVER	180	1786707540	64.954406	64.985105	64.902255	64.952361
46801	GOLD	180	1786706640	4406.895380	4409.634826	4406.201813	4409.503170
45926	GOLD	300	1786706100	4405.531369	4407.977787	4405.002113	4406.952629
45928	GBP	300	1786706100	1.353110	1.353522	1.352939	1.353389
46802	GBP	180	1786706640	1.353682	1.353753	1.353546	1.353625
134677	GOLD	180	1788432300	4468.988711	4471.116854	4468.537160	4469.077264
45348	SILVER	180	1786705740	64.810613	64.829214	64.771105	64.782634
144585	BTC	180	1788438420	77923.288510	77967.394979	77905.882757	77952.413242
45932	SILVER	300	1786706100	64.797895	64.878440	64.783556	64.847759
45925	GOLD	180	1786706100	4405.531369	4406.666138	4405.002113	4406.167137
45927	GBP	180	1786706100	1.353110	1.353325	1.352939	1.353325
134679	GBP	180	1788432300	1.348679	1.348837	1.348626	1.348695
144587	SILVER	180	1788438420	66.179264	66.271371	66.175000	66.255963
45931	SILVER	180	1786706100	64.797895	64.833493	64.783556	64.833493
134681	BTC	180	1788432300	77480.822652	77530.951466	77470.010000	77499.828629
45641	GOLD	180	1786705920	4405.800730	4407.544955	4405.087975	4405.489405
45642	GBP	180	1786705920	1.352927	1.353241	1.352787	1.353090
45446	GBP	300	1786705800	1.352876	1.353241	1.352787	1.353090
134678	GOLD	300	1788432300	4468.988711	4471.116854	4468.133943	4470.845508
45644	SILVER	180	1786705920	64.783441	64.831501	64.766897	64.799538
134680	GBP	300	1788432300	1.348679	1.348941	1.348609	1.348842
134682	BTC	300	1788432300	77480.822652	77563.745527	77470.010000	77553.581859
134684	SILVER	300	1788432300	66.007358	66.150253	65.986704	66.129788
144874	BTC	300	1788438600	77956.799334	78353.685900	77949.851473	78288.252987
46804	SILVER	180	1786706640	64.856828	64.869158	64.821446	64.856410
144581	GOLD	180	1788438420	4487.815758	4489.977379	4487.329228	4488.296013
46409	GOLD	300	1786706400	4407.049939	4408.102917	4406.201813	4406.289298
47685	GOLD	180	1786707180	4412.130574	4412.669429	4409.702750	4410.262058
46410	GBP	300	1786706400	1.353400	1.353753	1.353300	1.353586
144583	GBP	180	1788438420	1.349256	1.349424	1.348909	1.349167
47686	GBP	180	1786707180	1.353573	1.354042	1.353516	1.354035
46412	SILVER	300	1786706400	64.849791	64.873720	64.821446	64.833737
134683	SILVER	180	1788432300	66.007358	66.076106	65.986704	66.026327
47688	SILVER	180	1786707180	64.929001	64.940034	64.887541	64.899748
46509	GOLD	180	1786706460	4406.982305	4408.102917	4406.676217	4406.856571
47097	GOLD	180	1786706820	4409.381861	4411.527942	4409.350343	4411.239435
46901	GOLD	300	1786706700	4406.379963	4411.527942	4406.379963	4411.239435
47098	GBP	180	1786706820	1.353627	1.353722	1.353385	1.353556
46510	GBP	180	1786706460	1.353394	1.353715	1.353300	1.353664
46902	GBP	300	1786706700	1.353602	1.353722	1.353385	1.353556
46512	SILVER	180	1786706460	64.851792	64.868621	64.845413	64.858134
47100	SILVER	180	1786706820	64.855421	64.914649	64.855199	64.881147
46904	SILVER	300	1786706700	64.834730	64.914649	64.829071	64.881147
46213	GOLD	180	1786706280	4406.103099	4407.977787	4406.028141	4406.931744
144876	SILVER	300	1788438600	66.253668	66.420000	66.202775	66.415830
48569	GOLD	180	1786707720	4415.010704	4415.100049	4414.932042	4415.100049
47881	GOLD	300	1786707300	4409.908427	4413.753060	4409.619623	4412.913597
48373	GOLD	300	1786707600	4412.939045	4415.487823	4412.161966	4415.100049
47882	GBP	300	1786707300	1.353785	1.354225	1.353764	1.354031
48570	GBP	180	1786707720	1.354254	1.354254	1.354220	1.354236
48374	GBP	300	1786707600	1.354035	1.354319	1.354011	1.354236
47884	SILVER	300	1786707300	64.933855	64.990462	64.887541	64.925353
47981	GOLD	180	1786707360	4410.195263	4413.753060	4409.619623	4413.138157
47982	GBP	180	1786707360	1.354037	1.354225	1.353818	1.354005
48273	GOLD	180	1786707540	4413.263794	4415.487823	4412.161966	4415.111357
48587	SILVER	180	1786707900	65.105000	65.150977	65.096855	65.135000
48274	GBP	180	1786707540	1.354026	1.354319	1.353916	1.354269
144869	GOLD	180	1788438600	4488.379244	4488.713485	4483.941910	4487.677555
48572	SILVER	180	1786707720	64.950557	64.952487	64.949175	64.952487
48376	SILVER	300	1786707600	64.924218	64.985105	64.902255	64.952487
49017	GOLD	300	1786708200	4418.074951	4420.176722	4417.652746	4418.799687
144871	GBP	180	1788438600	1.349140	1.350881	1.349135	1.350881
48588	SILVER	300	1786707900	65.105000	65.165000	65.096855	65.125000
144870	GOLD	300	1788438600	4488.379244	4495.695611	4483.941910	4495.695611
48821	GOLD	180	1786708080	4418.101673	4420.340518	4417.652746	4418.500000
48583	GBP	180	1786707900	1.353986	1.354134	1.353823	1.353931
49020	SILVER	300	1786708200	65.125419	65.137176	65.077167	65.096955
48581	GOLD	180	1786707900	4418.000000	4418.509085	4416.457279	4418.100000
144873	BTC	180	1788438600	77956.799334	78353.685900	77949.851473	78232.201999
144872	GBP	300	1788438600	1.349140	1.350904	1.349135	1.350393
48822	GBP	180	1786708080	1.353951	1.354141	1.353770	1.354060
48582	GOLD	300	1786707900	4418.000000	4420.340518	4416.457279	4418.100000
48584	GBP	300	1786707900	1.353986	1.354141	1.353770	1.353931
144875	SILVER	180	1788438600	66.253668	66.285806	66.202775	66.258428
48824	SILVER	180	1786708080	65.136625	65.165000	65.122100	65.135000
49018	GBP	300	1786708200	1.353928	1.354211	1.353553	1.353648
49117	GOLD	180	1786708260	4418.416525	4420.176722	4418.336626	4419.437023
49118	GBP	180	1786708260	1.354068	1.354211	1.353840	1.353868
154421	GOLD	180	1788444540	4513.388957	4517.068262	4505.936395	4512.803569
49120	SILVER	180	1786708260	65.132722	65.133047	65.077167	65.115805
154422	GBP	180	1788444540	1.351206	1.351308	1.350882	1.351228
154423	BTC	180	1788444540	78871.001989	78914.812489	78781.800000	78877.601973
49708	SILVER	180	1786708620	65.064137	65.068945	65.013232	65.015000
49410	GBP	180	1786708440	1.353868	1.353941	1.353515	1.353711
49512	SILVER	300	1786708500	65.096858	65.098208	65.013232	65.015000
49412	SILVER	180	1786708440	65.115233	65.122388	65.065000	65.065000
134976	SILVER	180	1788432480	66.025095	66.150253	66.022003	66.109906
51768	SILVER	180	1786709880	65.123055	65.188083	65.089559	65.100376
52652	SILVER	180	1786710420	65.037436	65.056542	65.032277	65.054050
50881	GOLD	180	1786709340	4424.247721	4428.829494	4423.431213	4427.979665
50882	GBP	180	1786709340	1.354178	1.354272	1.353495	1.353515
52064	SILVER	180	1786710060	65.100705	65.113235	65.040000	65.040000
52456	SILVER	300	1786710300	65.072236	65.073116	65.021287	65.054050
50293	GOLD	180	1786708980	4423.363836	4424.617910	4422.179110	4423.000000
50884	SILVER	180	1786709340	65.141459	65.191051	65.115000	65.116634
50294	GBP	180	1786708980	1.353833	1.354129	1.353632	1.353785
145163	SILVER	180	1788438780	66.256248	66.422454	66.256248	66.421099
50296	SILVER	180	1786708980	65.133470	65.170000	65.126343	65.150000
49997	GOLD	180	1786708800	4417.961938	4423.990455	4417.742893	4423.400000
49999	GBP	180	1786708800	1.353606	1.353908	1.353429	1.353821
154524	SILVER	300	1788444600	66.996063	66.996616	66.769299	66.896695
50003	SILVER	180	1786708800	65.013872	65.140732	65.013367	65.135000
134973	GOLD	180	1788432480	4468.953064	4471.281154	4468.133943	4470.978339
134974	GBP	180	1788432480	1.348679	1.348941	1.348609	1.348845
134975	BTC	180	1788432480	77502.022320	77563.745527	77498.690744	77555.506531
51470	GOLD	300	1786709700	4429.548797	4432.123064	4428.300000	4428.336395
51177	GOLD	180	1786709520	4427.893470	4431.660023	4427.893470	4429.570272
49998	GOLD	300	1786708800	4417.961938	4424.617910	4417.742893	4423.200000
50981	GOLD	300	1786709400	4425.907818	4431.660023	4425.691992	4429.570272
50000	GBP	300	1786708800	1.353606	1.354129	1.353429	1.353803
51178	GBP	180	1786709520	1.353533	1.353864	1.353457	1.353633
50982	GBP	300	1786709400	1.353792	1.353892	1.353457	1.353633
50004	SILVER	300	1786708800	65.013872	65.170000	65.013367	65.145000
51180	SILVER	180	1786709520	65.114778	65.183480	65.097503	65.139630
50984	SILVER	300	1786709400	65.168759	65.191051	65.097503	65.139630
49705	GOLD	180	1786708620	4417.799960	4418.505468	4416.992273	4417.900000
49509	GOLD	300	1786708500	4418.850216	4419.157508	4416.992273	4417.900000
49409	GOLD	180	1786708440	4419.565741	4419.858378	4417.247358	4417.800000
49706	GBP	180	1786708620	1.353733	1.353882	1.353500	1.353583
145157	GOLD	180	1788438780	4487.755252	4496.366628	4487.631571	4493.381916
50489	GOLD	300	1786709100	4423.159913	4425.939422	4421.475011	4425.800000
50589	GOLD	180	1786709160	4422.953584	4424.378650	4421.475011	4424.200000
145159	GBP	180	1788438780	1.350904	1.350904	1.349982	1.349984
50590	GBP	180	1786709160	1.353809	1.354261	1.353630	1.354188
50490	GBP	300	1786709100	1.353821	1.354272	1.353630	1.353785
49510	GBP	300	1786708500	1.353674	1.353882	1.353500	1.353583
145161	BTC	180	1788438780	78228.119497	78342.662416	78172.010000	78194.139995
154522	GBP	300	1788444600	1.351181	1.351770	1.350882	1.351712
50592	SILVER	180	1786709160	65.149090	65.166342	65.111291	65.140000
154521	GOLD	300	1788444600	4516.779001	4516.946716	4505.936395	4513.084046
50492	SILVER	300	1786709100	65.144491	65.183852	65.111291	65.170000
51469	GOLD	180	1786709700	4429.548797	4431.268646	4429.011339	4429.544350
52356	SILVER	180	1786710240	65.040598	65.073116	65.021287	65.035000
51471	GBP	180	1786709700	1.353661	1.353834	1.353542	1.353756
51472	GBP	300	1786709700	1.353661	1.353856	1.353542	1.353704
154523	BTC	300	1788444600	78881.104397	78989.663169	78781.800000	78926.947408
51961	GOLD	300	1786710000	4428.273651	4428.379968	4424.873980	4428.100000
154424	SILVER	180	1788444540	66.908192	66.996616	66.769299	66.890418
51475	SILVER	180	1786709700	65.137033	65.152338	65.110892	65.124904
51476	SILVER	300	1786709700	65.137033	65.188083	65.110892	65.113011
51765	GOLD	180	1786709880	4429.566273	4432.123064	4427.337468	4428.120890
51962	GBP	300	1786710000	1.353717	1.354394	1.353684	1.354298
51766	GBP	180	1786709880	1.353782	1.353856	1.353678	1.353809
52723	SILVER	180	1786757760	64.825000	64.828244	64.817398	64.822994
52649	GOLD	180	1786710420	4426.146984	4427.291272	4425.834231	4426.762553
52453	GOLD	300	1786710300	4428.101530	4428.649051	4425.834231	4426.762553
52061	GOLD	180	1786710060	4428.064110	4428.379968	4425.100000	4425.100000
52650	GBP	180	1786710420	1.354251	1.354251	1.354121	1.354121
52062	GBP	180	1786710060	1.353780	1.354270	1.353715	1.354060
51964	SILVER	300	1786710000	65.112248	65.119314	65.037261	65.070000
52454	GBP	300	1786710300	1.354276	1.354445	1.354121	1.354121
52353	GOLD	180	1786710240	4424.972879	4428.649051	4424.873980	4426.200000
52354	GBP	180	1786710240	1.354062	1.354445	1.354034	1.354224
52718	GOLD	300	1786757700	4432.000000	4432.225873	4431.449664	4431.779592
52784	SILVER	180	1786757940	64.822042	64.840579	64.818133	64.830927
52717	GOLD	180	1786757760	4432.000000	4432.225873	4431.606411	4432.159370
52781	GOLD	180	1786757940	4432.127085	4432.389693	4431.449664	4431.922187
52719	GBP	180	1786757760	1.353583	1.353693	1.353560	1.353614
52881	GOLD	300	1786758000	4431.823996	4432.557724	4431.395574	4431.734169
52782	GBP	180	1786757940	1.353631	1.353757	1.353516	1.353654
52720	GBP	300	1786757700	1.353583	1.353720	1.353516	1.353703
52724	SILVER	300	1786757700	64.825000	64.834844	64.817398	64.825638
52882	GBP	300	1786758000	1.353708	1.353757	1.353464	1.353549
54125	GOLD	180	1786758840	4431.929815	4432.520247	4431.252276	4431.858060
54127	GBP	180	1786758840	1.353649	1.353722	1.353458	1.353557
55680	SILVER	300	1786759800	64.823062	64.842575	64.813260	64.827599
54711	SILVER	180	1786759200	64.823004	64.838250	64.814377	64.828659
54131	SILVER	180	1786758840	64.827571	64.835493	64.815698	64.824883
53370	GOLD	300	1786758300	4431.714027	4432.466290	4431.336138	4431.903176
55196	SILVER	300	1786759500	64.822033	64.839338	64.811756	64.821992
53372	GBP	300	1786758300	1.353516	1.353758	1.353449	1.353552
53376	SILVER	300	1786758300	64.821184	64.836366	64.816042	64.822837
135169	GOLD	300	1788432600	4470.908083	4472.772070	4470.125906	4471.666007
53665	GOLD	180	1786758480	4431.859199	4432.466290	4431.336138	4432.206306
135170	GBP	300	1788432600	1.348817	1.349095	1.348764	1.349040
53666	GBP	180	1786758480	1.353612	1.353766	1.353481	1.353486
53077	GOLD	180	1786758120	4431.921687	4432.557724	4431.395574	4431.734169
53078	GBP	180	1786758120	1.353650	1.353699	1.353464	1.353549
135269	GOLD	180	1788432660	4470.910789	4472.772070	4470.769789	4471.075856
135171	BTC	300	1788432600	77550.702065	77735.477039	77525.494009	77674.089944
53080	SILVER	180	1786758120	64.829710	64.833864	64.814439	64.819020
52884	SILVER	300	1786758000	64.827379	64.840579	64.814439	64.819020
135270	GBP	180	1788432660	1.348855	1.349091	1.348805	1.348885
135172	SILVER	300	1788432600	66.131388	66.180171	66.109906	66.142572
53369	GOLD	180	1786758300	4431.714027	4432.445029	4431.362005	4431.774998
53371	GBP	180	1786758300	1.353516	1.353758	1.353449	1.353606
53854	GOLD	300	1786758600	4431.855266	4432.480564	4431.455261	4431.888536
53668	SILVER	180	1786758480	64.826745	64.831147	64.817668	64.823693
53375	SILVER	180	1786758300	64.821184	64.836366	64.816042	64.825977
53856	GBP	300	1786758600	1.353558	1.353766	1.353469	1.353539
135271	BTC	180	1788432660	77551.681225	77735.477039	77532.796055	77724.377705
145451	SILVER	180	1788438960	66.419279	66.458932	66.368755	66.408059
135272	SILVER	180	1788432660	66.111363	66.180171	66.111363	66.148781
53860	SILVER	300	1786758600	64.822392	64.835493	64.815698	64.824650
55285	GOLD	180	1786759560	4431.935848	4432.658539	4431.492157	4431.908634
55286	GBP	180	1786759560	1.353553	1.353718	1.353462	1.353510
54413	GOLD	180	1786759020	4431.738129	4432.413826	4431.652487	4432.210511
54222	GOLD	300	1786758900	4431.916266	4432.520247	4431.252276	4432.210511
53925	GOLD	180	1786758660	4432.000000	4432.480564	4431.455261	4431.902219
54414	GBP	180	1786759020	1.353562	1.353709	1.353480	1.353623
53927	GBP	180	1786758660	1.353583	1.353713	1.353473	1.353631
54224	GBP	300	1786758900	1.353518	1.353722	1.353458	1.353623
53931	SILVER	180	1786758660	64.825000	64.834965	64.819281	64.828874
54416	SILVER	180	1786759020	64.826393	64.835396	64.816665	64.824083
54228	SILVER	300	1786758900	64.824779	64.835396	64.816665	64.824083
145447	GBP	180	1788438960	1.349954	1.350955	1.349906	1.350936
145350	GOLD	300	1788438900	4495.814598	4496.366628	4492.573003	4493.034183
145352	GBP	300	1788438900	1.350417	1.351271	1.349906	1.351252
145445	GOLD	180	1788438960	4493.303646	4495.257920	4493.194446	4493.668791
55288	SILVER	180	1786759560	64.817598	64.839338	64.811756	64.821019
55578	GBP	180	1786759740	1.353499	1.353720	1.353373	1.353558
54706	GOLD	300	1786759200	4432.203247	4432.556731	4431.619268	4431.756767
54708	GBP	300	1786759200	1.353632	1.353666	1.353421	1.353606
145449	BTC	180	1788438960	78192.829853	78377.004893	78189.761564	78358.111641
54712	SILVER	300	1786759200	64.823004	64.838250	64.814377	64.823707
55001	GOLD	180	1786759380	4432.215170	4432.556731	4431.555168	4432.033920
55002	GBP	180	1786759380	1.353580	1.353666	1.353461	1.353583
145354	BTC	300	1788438900	78289.173274	78377.004893	78172.010000	78321.209452
55580	SILVER	180	1786759740	64.822333	64.837130	64.814251	64.826779
55004	SILVER	180	1786759380	64.828214	64.837863	64.816472	64.818348
54705	GOLD	180	1786759200	4432.203247	4432.498366	4431.619268	4432.142789
145356	SILVER	300	1788438900	66.414278	66.458932	66.368755	66.450044
54707	GBP	180	1786759200	1.353632	1.353660	1.353421	1.353598
154717	GOLD	180	1788444720	4512.742807	4515.600921	4511.052642	4513.084046
55190	GOLD	300	1786759500	4431.666247	4432.658539	4431.492157	4432.170396
55192	GBP	300	1786759500	1.353576	1.353720	1.353421	1.353623
56461	GOLD	180	1786760280	4431.809323	4432.645151	4431.650502	4431.800394
56172	SILVER	300	1786760100	64.827711	64.835107	64.813803	64.815363
56462	GBP	180	1786760280	1.353590	1.353733	1.353487	1.353511
55577	GOLD	180	1786759740	4432.015779	4432.662580	4431.577113	4431.718581
56165	GOLD	180	1786760100	4431.907285	4432.568241	4431.367977	4431.768868
55873	GOLD	180	1786759920	4431.600701	4432.564413	4431.532347	4431.986996
55677	GOLD	300	1786759800	4432.251730	4432.662580	4431.532347	4431.986996
55874	GBP	180	1786759920	1.353589	1.353673	1.353442	1.353561
55678	GBP	300	1786759800	1.353631	1.353673	1.353373	1.353561
154718	GBP	180	1788444720	1.351217	1.351770	1.351018	1.351712
154719	BTC	180	1788444720	78876.109932	78989.663169	78868.609414	78926.947408
55876	SILVER	180	1786759920	64.827425	64.842575	64.813260	64.827599
56658	GBP	300	1786760400	1.353628	1.353800	1.353414	1.353581
56167	GBP	180	1786760100	1.353530	1.353694	1.353468	1.353598
56166	GOLD	300	1786760100	4431.907285	4432.645151	4431.367977	4432.082707
154720	SILVER	180	1788444720	66.889441	66.957779	66.805163	66.896695
56171	SILVER	180	1786760100	64.827711	64.834440	64.813803	64.818292
56758	GBP	180	1786760460	1.353519	1.353800	1.353414	1.353600
56168	GBP	300	1786760100	1.353530	1.353733	1.353468	1.353658
56464	SILVER	180	1786760280	64.817603	64.835107	64.813558	64.819596
56660	SILVER	300	1786760400	64.813558	64.835757	64.811802	64.821738
56657	GOLD	300	1786760400	4431.988908	4432.713720	4431.481859	4432.034080
56757	GOLD	180	1786760460	4431.702832	4432.713720	4431.481859	4432.286677
59067	GBP	180	1786761900	1.353541	1.353713	1.353458	1.353538
135652	GBP	300	1788432900	1.349060	1.349569	1.348945	1.349417
58106	GOLD	300	1786761300	4431.601434	4432.316102	4431.467596	4431.816648
58201	GOLD	180	1786761360	4431.973593	4432.267969	4431.573773	4431.865501
59071	SILVER	180	1786761900	64.825557	64.834458	64.813422	64.821809
58203	GBP	180	1786761360	1.353632	1.353675	1.353480	1.353567
58108	GBP	300	1786761300	1.353628	1.353675	1.353480	1.353566
59939	SILVER	180	1786776840	65.108000	65.115440	65.107821	65.113052
58207	SILVER	180	1786761360	64.825209	64.838314	64.813827	64.828147
135654	BTC	300	1788432900	77675.487697	77746.358365	77670.010000	77717.619481
57337	GOLD	180	1786760820	4431.676364	4432.617446	4431.483224	4431.770249
57149	GOLD	300	1786760700	4432.070493	4432.617446	4431.483224	4431.770249
57339	GBP	180	1786760820	1.353579	1.353760	1.353430	1.353575
57150	GBP	300	1786760700	1.353552	1.353760	1.353392	1.353575
57049	GOLD	180	1786760640	4432.358539	4432.643481	4431.620078	4431.634989
135555	GBP	180	1788432840	1.348915	1.349250	1.348868	1.349143
57050	GBP	180	1786760640	1.353569	1.353638	1.353392	1.353580
57343	SILVER	180	1786760820	64.822876	64.839054	64.812314	64.823987
57152	SILVER	300	1786760700	64.819235	64.839054	64.812314	64.823987
56760	SILVER	180	1786760460	64.819124	64.835757	64.811802	64.828551
135656	SILVER	300	1788432900	66.145022	66.187190	66.123920	66.131203
57052	SILVER	180	1786760640	64.827470	64.829739	64.814591	64.821392
135557	BTC	180	1788432840	77727.575849	77746.358365	77669.572354	77720.390680
145735	GBP	180	1788439140	1.350969	1.351351	1.350803	1.350803
58112	SILVER	300	1786761300	64.820812	64.838314	64.813549	64.823242
145737	BTC	180	1788439140	78354.079333	78381.582635	78255.110000	78262.967163
59641	GOLD	180	1786762260	4431.886437	4432.600548	4431.393241	4432.053951
59546	GOLD	300	1786762200	4432.256916	4432.600548	4431.393241	4432.103332
59066	GOLD	300	1786761900	4432.174820	4432.419629	4431.468561	4432.229265
57913	GOLD	180	1786761180	4431.674862	4432.451490	4431.467596	4431.948531
57915	GBP	180	1786761180	1.353583	1.353702	1.353504	1.353621
59643	GBP	180	1786762260	1.353627	1.353662	1.353460	1.353583
135553	GOLD	180	1788432840	4471.093339	4472.892752	4471.064243	4471.551671
59068	GBP	300	1786761900	1.353541	1.353713	1.353456	1.353579
57919	SILVER	180	1786761180	64.826689	64.835916	64.813549	64.827568
59548	GBP	300	1786762200	1.353564	1.353662	1.353432	1.353594
135559	SILVER	180	1788432840	66.150534	66.187190	66.139069	66.147985
145836	SILVER	300	1788439200	66.451835	66.918713	66.451469	66.775177
57625	GOLD	180	1786761000	4431.882970	4432.813371	4431.577808	4431.715947
57627	GBP	180	1786761000	1.353570	1.353675	1.353494	1.353576
59072	SILVER	300	1786761900	64.825557	64.834458	64.812586	64.822471
57631	SILVER	180	1786761000	64.823111	64.835382	64.814395	64.826147
58489	GOLD	180	1786761540	4431.856713	4432.316102	4431.519103	4431.784942
59353	GOLD	180	1786762080	4432.195900	4432.419629	4431.493314	4431.977625
58491	GBP	180	1786761540	1.353553	1.353776	1.353400	1.353533
135650	GOLD	300	1788432900	4471.743197	4472.892752	4470.364603	4470.771112
145733	GOLD	180	1788439140	4493.772372	4513.100000	4492.855442	4513.033793
58495	SILVER	180	1786761540	64.830262	64.837502	64.810775	64.822601
59355	GBP	180	1786762080	1.353534	1.353687	1.353432	1.353620
57626	GOLD	300	1786761000	4431.882970	4432.813371	4431.531365	4431.694205
146027	SILVER	180	1788439320	66.856584	66.918713	66.742351	66.775177
57628	GBP	300	1786761000	1.353570	1.353702	1.353494	1.353602
59647	SILVER	180	1786762260	64.822729	64.835545	64.810497	64.825941
57632	SILVER	300	1786761000	64.823111	64.835916	64.814395	64.820981
59065	GOLD	180	1786761900	4432.174820	4432.306780	4431.468561	4432.306780
59940	SILVER	300	1786776900	65.108000	65.126622	65.097768	65.106792
58777	GOLD	180	1786761720	4431.809079	4432.502488	4431.654446	4432.045847
59359	SILVER	180	1786762080	64.821852	64.832102	64.812586	64.821158
59552	SILVER	300	1786762200	64.820898	64.835545	64.810497	64.824284
60256	SILVER	300	1786777200	65.106956	65.128875	65.095460	65.114410
59957	GOLD	180	1786777020	4437.300000	4437.624952	4436.776836	4437.326742
59934	GOLD	300	1786776900	4437.300000	4437.624952	4436.776836	4437.326742
59958	GBP	180	1786777020	1.353583	1.353726	1.353433	1.353663
59933	GOLD	180	1786776840	4437.300000	4437.458312	4437.180959	4437.180959
58586	GOLD	300	1786761600	4431.774394	4432.502488	4431.519103	4432.045847
58779	GBP	180	1786761720	1.353550	1.353794	1.353446	1.353574
58588	GBP	300	1786761600	1.353586	1.353794	1.353400	1.353574
145739	SILVER	180	1788439140	66.408197	66.887658	66.408142	66.855772
146021	GOLD	180	1788439320	4513.114428	4516.824483	4510.777951	4513.087529
58783	SILVER	180	1786761720	64.825071	64.831593	64.812113	64.825001
58592	SILVER	300	1786761600	64.824214	64.837502	64.810775	64.825001
146023	GBP	180	1788439320	1.350812	1.351032	1.350717	1.351013
146025	BTC	180	1788439320	78258.448290	78314.694052	78214.990634	78276.854238
59929	GOLD	180	1786762440	4432.103332	4432.103332	4432.103332	4432.103332
59930	GBP	180	1786762440	1.353594	1.353594	1.353594	1.353594
59936	GBP	300	1786776900	1.353583	1.353726	1.353433	1.353663
59935	GBP	180	1786776840	1.353583	1.353646	1.353559	1.353559
59932	SILVER	180	1786762440	64.824284	64.824284	64.824284	64.824284
155011	GBP	180	1788444900	1.351725	1.351771	1.351144	1.351285
145830	GOLD	300	1788439200	4493.076876	4516.824483	4492.976428	4513.087529
59960	SILVER	180	1786777020	65.108000	65.126622	65.097768	65.106792
145832	GBP	300	1788439200	1.351221	1.351351	1.350717	1.351013
145834	BTC	300	1788439200	78322.386946	78381.582635	78214.990634	78276.854238
60249	GOLD	180	1786777200	4437.330598	4437.948211	4436.957233	4437.295391
60545	GOLD	180	1786777380	4437.387311	4437.724050	4436.828695	4437.426122
60251	GBP	180	1786777200	1.353660	1.353696	1.353393	1.353464
60250	GOLD	300	1786777200	4437.330598	4437.948211	4436.828695	4437.257494
60252	GBP	300	1786777200	1.353660	1.353697	1.353393	1.353591
60255	SILVER	180	1786777200	65.106956	65.115060	65.095460	65.109020
155009	GOLD	180	1788444900	4513.202837	4520.126291	4511.870418	4519.357540
155010	GOLD	300	1788444900	4513.202837	4520.126291	4509.688142	4510.130301
62596	SILVER	180	1786778640	65.110446	65.118183	65.100107	65.110010
62201	GOLD	300	1786778400	4437.230874	4438.021149	4436.819940	4437.483692
62693	GOLD	300	1786778700	4437.504071	4437.864368	4436.593103	4437.015637
62202	GBP	300	1786778400	1.353519	1.353751	1.353410	1.353603
61121	GOLD	180	1786777740	4437.893153	4437.893153	4436.935503	4437.370501
61122	GBP	180	1786777740	1.353555	1.353706	1.353470	1.353579
62204	SILVER	300	1786778400	65.110625	65.121034	65.096597	65.105712
61124	SILVER	180	1786777740	65.102349	65.117339	65.094149	65.114405
60734	GOLD	300	1786777500	4437.337043	4438.019993	4436.674039	4437.464635
61710	GOLD	300	1786778100	4437.547843	4437.936024	4436.675462	4437.191765
60736	GBP	300	1786777500	1.353619	1.353692	1.353470	1.353511
60740	SILVER	300	1786777500	65.113692	65.115730	65.096484	65.113705
146313	BTC	180	1788439500	78278.802562	78349.040290	78223.580436	78344.423303
146310	GOLD	300	1788439500	4513.070046	4525.460042	4506.690880	4522.395458
61712	GBP	300	1786778100	1.353619	1.353758	1.353442	1.353524
61709	GOLD	180	1786778100	4437.547843	4437.913774	4436.960363	4437.107408
146315	SILVER	180	1788439500	66.775771	66.810000	66.557296	66.723927
61711	GBP	180	1786778100	1.353619	1.353696	1.353442	1.353636
146312	GBP	300	1788439500	1.351033	1.351583	1.350615	1.351429
155016	SILVER	300	1788444900	66.896346	67.023235	66.794237	66.869951
61715	SILVER	180	1786778100	65.105103	65.120167	65.099090	65.107102
61716	SILVER	300	1786778100	65.105103	65.120167	65.096860	65.110173
155303	SILVER	180	1788445080	66.979196	66.980817	66.794237	66.835616
155013	BTC	180	1788444900	78922.984374	79096.119873	78907.491743	79051.648940
62005	GOLD	180	1786778280	4437.211192	4438.021149	4436.675462	4437.539287
62890	GBP	180	1786778820	1.353520	1.353695	1.353494	1.353535
62006	GBP	180	1786778280	1.353630	1.353758	1.353410	1.353559
62301	GOLD	180	1786778460	4437.599108	4437.836506	4436.894107	4437.836506
146309	GOLD	180	1788439500	4513.070046	4515.300512	4506.690880	4515.013181
62694	GBP	300	1786778700	1.353583	1.353695	1.353490	1.353535
62008	SILVER	180	1786778280	65.108795	65.117017	65.096860	65.101669
62302	GBP	180	1786778460	1.353586	1.353751	1.353439	1.353715
60829	GOLD	180	1786777560	4437.379022	4438.019993	4436.674039	4438.019993
146314	BTC	300	1788439500	78278.802562	78368.660199	78223.580436	78327.572733
60830	GBP	180	1786777560	1.353635	1.353692	1.353482	1.353523
146311	GBP	180	1788439500	1.351033	1.351477	1.350615	1.351477
146316	SILVER	300	1788439500	66.775771	66.933188	66.557296	66.880012
60832	SILVER	180	1786777560	65.112896	65.114643	65.099491	65.103671
135841	GOLD	180	1788433020	4471.594002	4472.451225	4470.364603	4470.771112
60546	GBP	180	1786777380	1.353488	1.353697	1.353445	1.353653
135842	GBP	180	1788433020	1.349153	1.349569	1.349133	1.349417
135843	BTC	180	1788433020	77717.014015	77733.427789	77670.010000	77717.619481
60548	SILVER	180	1786777380	65.110535	65.128875	65.096484	65.111121
135844	SILVER	180	1788433020	66.145642	66.171610	66.123920	66.131203
62304	SILVER	180	1786778460	65.104153	65.121034	65.096597	65.107892
61417	GOLD	180	1786777920	4437.243190	4437.720373	4436.737700	4437.508939
61221	GOLD	300	1786777800	4437.592598	4437.720373	4436.737700	4437.508939
61418	GBP	180	1786777920	1.353562	1.353694	1.353413	1.353641
61222	GBP	300	1786777800	1.353527	1.353706	1.353413	1.353641
61420	SILVER	180	1786777920	65.112318	65.117297	65.098119	65.104647
61224	SILVER	300	1786777800	65.113339	65.117339	65.094149	65.104647
62892	SILVER	180	1786778820	65.107475	65.120713	65.098633	65.106730
62696	SILVER	300	1786778700	65.106969	65.120713	65.098633	65.106730
63387	SILVER	180	1786783320	65.108000	65.119413	65.100328	65.106463
63388	SILVER	300	1786783200	65.108000	65.119413	65.100328	65.106463
63669	GOLD	180	1786783500	4437.161815	4437.856859	4436.875432	4437.701820
63675	SILVER	180	1786783500	65.106243	65.117816	65.095462	65.107947
64162	GBP	300	1786783800	1.353594	1.353758	1.353435	1.353583
63381	GOLD	180	1786783320	4437.300000	4437.959592	4436.677566	4437.244671
63382	GOLD	300	1786783200	4437.300000	4437.959592	4436.677566	4437.244671
63383	GBP	180	1786783320	1.353583	1.353696	1.353518	1.353559
62593	GOLD	180	1786778640	4437.920500	4437.920500	4436.881231	4437.449157
63181	GOLD	180	1786779000	4436.950538	4437.783771	4436.772833	4437.270440
63384	GBP	300	1786783200	1.353583	1.353696	1.353518	1.353559
62594	GBP	180	1786778640	1.353700	1.353700	1.353455	1.353503
155297	GOLD	180	1788445080	4519.345746	4519.345746	4508.123690	4509.045665
62889	GOLD	180	1786778820	4437.362889	4437.565827	4436.593103	4437.015637
155015	SILVER	180	1788444900	66.896346	67.023235	66.890000	66.980682
63182	GOLD	300	1786779000	4436.950538	4437.783771	4436.772833	4437.270440
63183	GBP	180	1786779000	1.353540	1.353734	1.353456	1.353574
63184	GBP	300	1786779000	1.353540	1.353734	1.353456	1.353574
63187	SILVER	180	1786779000	65.106169	65.115571	65.101287	65.107293
63188	SILVER	300	1786779000	65.106169	65.115571	65.101287	65.107293
155299	GBP	180	1788445080	1.351257	1.351496	1.351161	1.351222
63965	GOLD	180	1786783680	4437.300000	4437.789000	4436.837737	4437.300000
63676	SILVER	300	1786783500	65.106243	65.117847	65.095462	65.108000
63671	GBP	180	1786783500	1.353542	1.353642	1.353460	1.353528
155301	BTC	180	1788445080	79052.336529	79121.316763	78984.320118	79087.551073
64161	GOLD	300	1786783800	4437.379760	4437.816780	4436.831300	4437.300000
155012	GBP	300	1788444900	1.351725	1.351771	1.351144	1.351400
63966	GBP	180	1786783680	1.353583	1.353692	1.353459	1.353583
63670	GOLD	300	1786783500	4437.161815	4437.856859	4436.837737	4437.300000
63672	GBP	300	1786783500	1.353542	1.353665	1.353460	1.353583
155014	BTC	300	1788444900	78922.984374	79121.316763	78907.491743	79018.137026
63968	SILVER	180	1786783680	65.108000	65.117847	65.095644	65.108000
64261	GOLD	180	1786783860	4437.261416	4437.693623	4436.831300	4437.300000
64262	GBP	180	1786783860	1.353598	1.353758	1.353435	1.353583
64164	SILVER	300	1786783800	65.109165	65.117854	65.095380	65.108000
65509	GOLD	180	1786787640	4436.783545	4437.794833	4436.697802	4437.494572
65225	GOLD	180	1786787460	4436.836218	4438.308395	4436.553323	4436.873515
65804	SILVER	180	1786787820	65.114544	65.114713	65.098103	65.102051
65226	GBP	180	1786787460	1.353535	1.353709	1.353411	1.353552
65511	GBP	180	1786787640	1.353552	1.353709	1.353510	1.353558
65608	SILVER	300	1786787700	65.112494	65.119008	65.098103	65.102051
65228	SILVER	180	1786787460	65.112715	65.120318	65.099857	65.109645
64833	GOLD	180	1786787100	4437.300000	4437.603648	4436.842004	4437.603648
64835	GBP	180	1786787100	1.353583	1.353652	1.353458	1.353477
65515	SILVER	180	1786787640	65.108818	65.119008	65.098449	65.113870
64839	SILVER	180	1786787100	65.108000	65.117614	65.101208	65.108741
64834	GOLD	300	1786787100	4437.300000	4437.726172	4436.610828	4437.069840
64836	GBP	300	1786787100	1.353583	1.353715	1.353458	1.353578
64840	SILVER	300	1786787100	65.108000	65.119082	65.093099	65.093099
136138	BTC	300	1788433200	77721.657849	77761.803480	77657.835623	77717.229591
136140	SILVER	300	1788433200	66.133454	66.221994	66.119200	66.201391
67853	GOLD	180	1786789080	4437.365227	4437.715453	4436.686316	4437.305166
66094	GOLD	300	1786788000	4437.379726	4438.001537	4436.602105	4437.576272
67565	GOLD	180	1786788900	4437.671335	4437.843509	4437.080130	4437.383145
66096	GBP	300	1786788000	1.353637	1.353716	1.353460	1.353568
66392	SILVER	180	1786788180	65.114620	65.116219	65.096515	65.105026
67572	SILVER	300	1786788900	65.115358	65.117195	65.094728	65.100283
66100	SILVER	300	1786788000	65.100548	65.118580	65.092397	65.109045
146601	BTC	180	1788439680	78344.163188	78403.527065	78302.704690	78328.748501
66093	GOLD	180	1786788000	4437.379726	4438.001537	4436.602105	4437.463232
66095	GBP	180	1786788000	1.353637	1.353716	1.353470	1.353628
64553	GOLD	180	1786784040	4437.284098	4437.816780	4436.972734	4437.111106
64653	GOLD	300	1786784100	4437.187016	4437.786109	4436.972734	4437.111106
64554	GBP	180	1786784040	1.353574	1.353722	1.353458	1.353560
64654	GBP	300	1786784100	1.353557	1.353611	1.353458	1.353560
146794	BTC	300	1788439800	78326.688117	78548.428760	78317.510959	78537.008350
64556	SILVER	180	1786784040	65.107143	65.115577	65.097984	65.111265
64656	SILVER	300	1786784100	65.107059	65.115577	65.097984	65.111265
136133	GOLD	180	1788433200	4470.835447	4472.595557	4470.198725	4472.218223
64264	SILVER	180	1786783860	65.107697	65.117854	65.095380	65.108000
146796	SILVER	300	1788439800	66.881769	66.884654	66.592631	66.595613
136135	GBP	180	1788433200	1.349427	1.349598	1.349107	1.349216
66099	SILVER	180	1786788000	65.100548	65.118580	65.092397	65.113366
136137	BTC	180	1788433200	77721.657849	77744.851421	77674.941738	77740.628800
136134	GOLD	300	1788433200	4470.835447	4474.120418	4470.198725	4473.329831
136139	SILVER	180	1788433200	66.133454	66.169691	66.119200	66.169691
65125	GOLD	300	1786787400	4436.983381	4438.308395	4436.553323	4436.972562
66977	GOLD	180	1786788540	4437.015436	4437.928011	4436.571890	4437.057694
65126	GBP	300	1786787400	1.353575	1.353709	1.353411	1.353577
64929	GOLD	180	1786787280	4437.702201	4437.726172	4436.610828	4436.857285
65801	GOLD	180	1786787820	4437.511034	4437.796656	4436.849599	4437.337955
64930	GBP	180	1786787280	1.353478	1.353715	1.353478	1.353512
65605	GOLD	300	1786787700	4436.854725	4437.796656	4436.842960	4437.337955
136136	GBP	300	1788433200	1.349427	1.349598	1.349107	1.349310
65802	GBP	180	1786787820	1.353532	1.353723	1.353445	1.353632
65606	GBP	300	1786787700	1.353570	1.353723	1.353445	1.353632
146603	SILVER	180	1788439680	66.722538	66.933188	66.722538	66.861736
66585	GOLD	300	1786788300	4437.492819	4437.823556	4436.864154	4437.226458
64932	SILVER	180	1786787280	65.109664	65.119082	65.093099	65.110719
67273	GOLD	180	1786788720	4437.038818	4437.704356	4436.797037	4437.643219
146599	GBP	180	1788439680	1.351454	1.351595	1.351235	1.351402
66586	GBP	300	1786788300	1.353563	1.353808	1.353418	1.353542
155587	GBP	180	1788445260	1.351217	1.351623	1.350843	1.350959
66978	GBP	180	1786788540	1.353463	1.353680	1.353463	1.353622
65128	SILVER	300	1786787400	65.095428	65.120318	65.095428	65.111563
146790	GOLD	300	1788439800	4522.376624	4525.092247	4512.893013	4514.774305
67077	GOLD	300	1786788600	4437.305922	4437.928011	4436.571890	4437.643219
146792	GBP	300	1788439800	1.351438	1.352138	1.351334	1.351946
67274	GBP	180	1786788720	1.353590	1.353720	1.353473	1.353506
66685	GOLD	180	1786788360	4437.399412	4437.823556	4436.864154	4437.102150
66980	SILVER	180	1786788540	65.097266	65.118685	65.097266	65.112423
66686	GBP	180	1786788360	1.353803	1.353803	1.353418	1.353481
67078	GBP	300	1786788600	1.353536	1.353720	1.353473	1.353506
67567	GBP	180	1786788900	1.353489	1.353677	1.353480	1.353594
146597	GOLD	180	1788439680	4515.023864	4525.460042	4514.983784	4524.943106
66588	SILVER	300	1786788300	65.110264	65.114945	65.094105	65.102250
66389	GOLD	180	1786788180	4437.375218	4437.764202	4436.774977	4437.291794
66390	GBP	180	1786788180	1.353622	1.353808	1.353460	1.353808
66688	SILVER	180	1786788360	65.107621	65.114945	65.094105	65.097139
67856	SILVER	180	1786789080	65.109704	65.114501	65.099380	65.107203
67571	SILVER	180	1786788900	65.115358	65.117195	65.094728	65.108472
155589	BTC	180	1788445260	79087.729243	79301.480000	79080.725140	79261.558511
155591	SILVER	180	1788445260	66.835235	66.946140	66.809320	66.941613
67276	SILVER	180	1786788720	65.113288	65.118014	65.095744	65.117704
155490	GOLD	300	1788445200	4510.174779	4516.234652	4508.123690	4513.574599
67080	SILVER	300	1786788600	65.100221	65.118685	65.095744	65.117704
155585	GOLD	180	1788445260	4508.937807	4516.234652	4508.360114	4515.310654
67854	GBP	180	1786789080	1.353607	1.353760	1.353421	1.353731
67566	GOLD	300	1786788900	4437.671335	4437.843509	4436.783623	4436.808120
67568	GBP	300	1786788900	1.353489	1.353715	1.353421	1.353689
155492	GBP	300	1788445200	1.351399	1.351623	1.350716	1.350912
68049	GOLD	300	1786789200	4436.686316	4437.815165	4436.624828	4437.527332
155494	BTC	300	1788445200	79020.470474	79382.091352	78998.690917	79335.682664
155496	SILVER	300	1788445200	66.868542	66.946140	66.800140	66.878993
120536	SILVER	300	1787020200	65.636414	65.642404	65.541627	65.619569
69605	GOLD	180	1786790160	4437.495762	4437.682950	4436.782564	4437.633920
69030	GOLD	300	1786789800	4437.184583	4437.983777	4436.799029	4437.798194
69032	GBP	300	1786789800	1.353545	1.353780	1.353439	1.353632
69607	GBP	180	1786790160	1.353692	1.353752	1.353440	1.353579
69036	SILVER	300	1786789800	65.104073	65.117898	65.090454	65.104803
136431	BTC	180	1788433380	77738.879373	77761.803480	77657.835623	77743.199303
136624	SILVER	300	1788433500	66.201941	66.239372	66.179030	66.182191
136432	SILVER	180	1788433380	66.170734	66.221994	66.165922	66.209680
70475	SILVER	180	1786790700	65.118155	65.118155	65.095152	65.111226
69611	SILVER	180	1786790160	65.115803	65.116790	65.095806	65.102156
71045	GOLD	180	1786791060	4437.430541	4437.796022	4437.034300	4437.056025
70476	SILVER	300	1786790700	65.118155	65.118437	65.095152	65.116197
136618	GOLD	300	1788433500	4473.456646	4474.717331	4472.957145	4473.691639
69893	GOLD	180	1786790340	4437.634095	4437.705186	4436.782963	4437.208355
68441	GOLD	180	1786789440	4437.481822	4437.643121	4436.679241	4436.962047
69895	GBP	180	1786790340	1.353583	1.353748	1.353366	1.353374
68442	GBP	180	1786789440	1.353497	1.353723	1.353391	1.353416
69510	GOLD	300	1786790100	4437.850344	4437.850344	4436.579406	4437.414338
136717	BTC	180	1788433560	77747.587858	77765.478766	77703.770000	77757.805980
71339	SILVER	180	1786791240	65.110260	65.119216	65.097250	65.106775
68444	SILVER	180	1786789440	65.103637	65.122306	65.094887	65.112538
69512	GBP	300	1786790100	1.353646	1.353752	1.353440	1.353482
69029	GOLD	180	1786789800	4437.184583	4437.690523	4436.859086	4437.057501
69031	GBP	180	1786789800	1.353545	1.353780	1.353477	1.353563
136620	GBP	300	1788433500	1.349326	1.349538	1.349123	1.349440
69516	SILVER	300	1786790100	65.103620	65.116790	65.095806	65.108888
69035	SILVER	180	1786789800	65.104073	65.117898	65.090454	65.103503
69899	SILVER	180	1786790340	65.101065	65.123889	65.100241	65.112108
136429	GOLD	180	1788433380	4472.218818	4474.543519	4472.199222	4473.471231
68050	GBP	300	1786789200	1.353705	1.353760	1.353414	1.353676
68149	GOLD	180	1786789260	4437.346589	4437.815165	4436.624828	4437.454913
68150	GBP	180	1786789260	1.353744	1.353744	1.353414	1.353512
68152	SILVER	180	1786789260	65.106021	65.125030	65.096159	65.104422
68052	SILVER	300	1786789200	65.099380	65.125030	65.095601	65.095601
68737	GOLD	180	1786789620	4437.010915	4437.804100	4436.711233	4437.235156
68541	GOLD	300	1786789500	4437.489341	4437.804100	4436.679241	4437.235156
68738	GBP	180	1786789620	1.353434	1.353728	1.353421	1.353536
68542	GBP	300	1786789500	1.353674	1.353728	1.353391	1.353536
136430	GBP	180	1788433380	1.349231	1.349428	1.349148	1.349308
68740	SILVER	180	1786789620	65.110234	65.116686	65.098527	65.105869
68544	SILVER	300	1786789500	65.094887	65.116880	65.094887	65.105869
136715	GBP	180	1788433560	1.349309	1.349538	1.349206	1.349216
136719	SILVER	180	1788433560	66.209667	66.239372	66.181998	66.190997
70757	GOLD	180	1786790880	4437.517610	4438.127010	4436.792793	4437.406158
155877	BTC	180	1788445440	79262.189245	79529.220000	79259.474455	79518.255762
71047	GBP	180	1786791060	1.353591	1.353667	1.353469	1.353555
136622	BTC	300	1788433500	77715.419953	77785.329949	77695.427138	77774.553649
70759	GBP	180	1786790880	1.353518	1.353690	1.353424	1.353615
70181	GOLD	180	1786790520	4437.286038	4437.892902	4436.671055	4436.947739
69990	GOLD	300	1786790400	4437.462815	4437.892902	4436.671055	4436.947739
70183	GBP	180	1786790520	1.353398	1.353679	1.353398	1.353459
69992	GBP	300	1786790400	1.353513	1.353679	1.353366	1.353459
136713	GOLD	180	1788433560	4473.511956	4474.717331	4472.957145	4473.717998
69317	GOLD	180	1786789980	4437.102964	4437.983777	4436.579406	4437.563122
69319	GBP	180	1786789980	1.353573	1.353701	1.353439	1.353701
70187	SILVER	180	1786790520	65.111446	65.117801	65.098679	65.116241
69996	SILVER	300	1786790400	65.106819	65.123889	65.098679	65.116241
69323	SILVER	180	1786789980	65.101210	65.117486	65.097297	65.116677
146885	GOLD	180	1788439860	4524.966226	4525.092247	4512.893013	4513.197950
70763	SILVER	180	1786790880	65.111978	65.118513	65.101345	65.116685
146887	GBP	180	1788439860	1.351411	1.352114	1.351334	1.352107
146889	BTC	180	1788439860	78329.162101	78504.710829	78323.160635	78500.447202
146891	SILVER	180	1788439860	66.862483	66.862897	66.592708	66.595419
70469	GOLD	180	1786790700	4437.054282	4437.794134	4436.998558	4437.393127
71436	SILVER	300	1786791300	65.110582	65.119216	65.096046	65.096046
70471	GBP	180	1786790700	1.353467	1.353733	1.353467	1.353529
70956	SILVER	300	1786791000	65.118513	65.118973	65.100264	65.111744
70470	GOLD	300	1786790700	4437.054282	4438.127010	4436.792793	4436.875938
71051	SILVER	180	1786791060	65.118973	65.118973	65.100462	65.109735
70472	GBP	300	1786790700	1.353467	1.353733	1.353424	1.353573
71914	GOLD	300	1786791600	4437.709359	4437.804565	4436.752698	4437.688928
71621	GOLD	180	1786791420	4437.051336	4437.874261	4436.745273	4437.680390
71335	GBP	180	1786791240	1.353585	1.353678	1.353471	1.353546
71432	GBP	300	1786791300	1.353549	1.353731	1.353464	1.353648
70950	GOLD	300	1786791000	4437.008047	4437.847936	4436.790622	4436.790622
70952	GBP	300	1786791000	1.353581	1.353690	1.353469	1.353579
71333	GOLD	180	1786791240	4437.001617	4437.847936	4436.780262	4436.977382
71430	GOLD	300	1786791300	4436.780262	4437.874261	4436.745273	4437.680390
71624	SILVER	180	1786791420	65.108822	65.115364	65.096046	65.096046
147173	GOLD	180	1788440040	4513.254522	4519.800000	4512.985216	4519.628755
71622	GBP	180	1786791420	1.353537	1.353731	1.353464	1.353648
147175	GBP	180	1788440040	1.352123	1.352287	1.351728	1.351728
147177	BTC	180	1788440040	78501.438734	78656.835137	78490.436109	78612.106020
147179	SILVER	180	1788440040	66.595117	66.716072	66.584856	66.714176
71916	GBP	300	1786791600	1.353620	1.353740	1.353373	1.353483
71919	SILVER	180	1786791600	65.095951	65.120380	65.095951	65.107232
71920	SILVER	300	1786791600	65.095951	65.120380	65.095951	65.105338
71913	GOLD	180	1786791600	4437.709359	4437.773400	4436.752698	4437.406115
71915	GBP	180	1786791600	1.353620	1.353740	1.353373	1.353473
155873	GOLD	180	1788445440	4515.436958	4521.062753	4511.502853	4520.035528
155875	GBP	180	1788445440	1.350986	1.351161	1.350716	1.350815
74841	GOLD	180	1786793400	4436.943371	4437.853344	4436.895731	4437.853344
73392	SILVER	300	1786792500	65.109970	65.116934	65.093727	65.106708
73093	GOLD	180	1786792320	4437.692398	4437.692398	4436.762328	4437.360082
72897	GOLD	300	1786792200	4437.050560	4438.035729	4436.762328	4437.360082
73094	GBP	180	1786792320	1.353448	1.353705	1.353439	1.353664
72898	GBP	300	1786792200	1.353666	1.353727	1.353424	1.353664
137005	BTC	180	1788433740	77761.154757	77785.329949	77705.056947	77739.028074
137098	GOLD	300	1788433800	4473.779528	4474.950857	4471.196745	4472.773019
73096	SILVER	180	1786792320	65.097671	65.116030	65.097671	65.112436
72900	SILVER	300	1786792200	65.101063	65.116507	65.092670	65.112436
72797	GOLD	180	1786792140	4437.710169	4438.035729	4436.784132	4437.686996
72405	GOLD	300	1786791900	4437.658909	4437.843764	4436.822827	4437.174587
137007	SILVER	180	1788433740	66.192928	66.271625	66.129877	66.183536
72406	GBP	300	1786791900	1.353501	1.353734	1.353393	1.353658
72798	GBP	180	1786792140	1.353610	1.353727	1.353424	1.353424
137100	GBP	300	1788433800	1.349435	1.349965	1.349435	1.349659
137102	BTC	300	1788433800	77770.392120	77803.112002	77705.056947	77781.871131
72408	SILVER	300	1786791900	65.106909	65.117483	65.097965	65.100223
137104	SILVER	300	1788433800	66.181646	66.271625	66.129877	66.186781
72800	SILVER	180	1786792140	65.116095	65.116507	65.092670	65.097172
73877	GOLD	300	1786792800	4437.286014	4438.021894	4436.937836	4437.652118
74843	GBP	180	1786793400	1.353580	1.353716	1.353438	1.353605
73878	GBP	300	1786792800	1.353508	1.353752	1.353463	1.353692
73681	GOLD	180	1786792680	4437.073156	4437.758835	4436.940575	4437.439708
73682	GBP	180	1786792680	1.353649	1.353701	1.353425	1.353631
147276	SILVER	300	1788440100	66.596961	66.897343	66.584856	66.887781
73880	SILVER	300	1786792800	65.106546	65.119604	65.094429	65.098081
73684	SILVER	180	1786792680	65.112921	65.119604	65.102599	65.106971
147465	BTC	180	1788440220	78614.701291	78756.724520	78614.701291	78632.179270
74847	SILVER	180	1786793400	65.102654	65.124614	65.092807	65.111338
73977	GOLD	180	1786792860	4437.399041	4438.021894	4436.984683	4437.561493
74261	GOLD	180	1786793040	4437.463561	4437.697285	4436.602621	4436.869692
73978	GBP	180	1786792860	1.353619	1.353700	1.353463	1.353580
72505	GOLD	180	1786791960	4437.380648	4437.843764	4436.935314	4437.655956
72209	GOLD	180	1786791780	4437.301259	4437.804565	4436.950042	4437.455796
72210	GBP	180	1786791780	1.353498	1.353734	1.353393	1.353673
72506	GBP	180	1786791960	1.353687	1.353694	1.353436	1.353583
137001	GOLD	180	1788433740	4473.748807	4474.950857	4471.300000	4471.613395
72212	SILVER	180	1786791780	65.109534	65.118297	65.098210	65.112751
147461	GOLD	180	1788440220	4519.609185	4527.314997	4519.476134	4525.883667
73980	SILVER	180	1786792860	65.108761	65.115571	65.094429	65.104079
74263	GBP	180	1786793040	1.353585	1.353752	1.353451	1.353530
74549	GOLD	180	1786793220	4436.871677	4437.865517	4436.578858	4437.021420
137003	GBP	180	1788433740	1.349194	1.349908	1.349123	1.349800
73385	GOLD	180	1786792500	4437.294658	4437.755154	4436.600307	4437.055466
147463	GBP	180	1788440220	1.351737	1.351980	1.351603	1.351876
72508	SILVER	180	1786791960	65.115107	65.117483	65.103354	65.115403
73387	GBP	180	1786792500	1.353647	1.353748	1.353485	1.353620
74358	GOLD	300	1786793100	4437.548468	4437.865517	4436.578858	4437.021420
74267	SILVER	180	1786793040	65.103860	65.117439	65.097015	65.110901
74550	GBP	180	1786793220	1.353538	1.353690	1.353462	1.353549
147467	SILVER	180	1788440220	66.713974	66.897343	66.711710	66.887781
74360	GBP	300	1786793100	1.353720	1.353724	1.353451	1.353549
73391	SILVER	180	1786792500	65.109970	65.116934	65.093727	65.111470
147270	GOLD	300	1788440100	4514.679476	4527.314997	4513.600000	4525.883667
147272	GBP	300	1788440100	1.351944	1.352287	1.351603	1.351876
73386	GOLD	300	1786792500	4437.294658	4437.758835	4436.600307	4437.327058
74552	SILVER	180	1786793220	65.110054	65.115877	65.099662	65.101272
73388	GBP	300	1786792500	1.353647	1.353748	1.353425	1.353510
74364	SILVER	300	1786793100	65.097015	65.117439	65.097015	65.101272
75129	GOLD	180	1786793580	4437.781222	4437.781222	4436.463088	4437.142662
147274	BTC	300	1788440100	78534.675395	78756.724520	78528.368096	78632.179270
75324	GBP	300	1786793700	1.353497	1.353705	1.353348	1.353600
74842	GOLD	300	1786793400	4436.943371	4437.853344	4436.463088	4437.209437
75131	GBP	180	1786793580	1.353592	1.353685	1.353348	1.353544
74844	GBP	300	1786793400	1.353580	1.353716	1.353424	1.353496
155976	SILVER	300	1788445500	66.880973	67.152348	66.880459	67.151051
75417	GOLD	180	1786793760	4437.034601	4437.745162	4436.933190	4436.963063
75707	GBP	180	1786793940	1.353593	1.353719	1.353379	1.353608
75423	SILVER	180	1786793760	65.105310	65.120914	65.092660	65.108500
74848	SILVER	300	1786793400	65.102654	65.124614	65.092807	65.110970
155970	GOLD	300	1788445500	4513.466122	4523.508208	4513.081376	4523.508208
75328	SILVER	300	1786793700	65.111312	65.120914	65.092660	65.104821
75419	GBP	180	1786793760	1.353557	1.353705	1.353451	1.353625
75135	SILVER	180	1786793580	65.109504	65.121284	65.101692	65.104360
75322	GOLD	300	1786793700	4437.150388	4437.745162	4436.709321	4437.463653
155972	GBP	300	1788445500	1.350889	1.351271	1.350626	1.351068
155974	BTC	300	1788445500	79333.244879	79645.206973	79328.516450	79636.023884
75711	SILVER	180	1786793940	65.107479	65.117106	65.100083	65.100083
75801	GOLD	300	1786794000	4437.488517	4437.633667	4436.822086	4436.948265
155879	SILVER	180	1788445440	66.942637	67.022282	66.831063	66.964770
75802	GBP	300	1786794000	1.353573	1.353719	1.353379	1.353608
75804	SILVER	300	1786794000	65.105284	65.117106	65.100083	65.100083
75705	GOLD	180	1786793940	4437.022609	4437.633667	4436.709321	4436.948265
75965	GOLD	180	1786849920	4437.300000	4438.191339	4436.853128	4436.853128
75967	GBP	180	1786849920	1.353290	1.353403	1.353148	1.353309
75968	GBP	300	1786849800	1.353290	1.353403	1.353148	1.353309
78709	GOLD	300	1786851600	4437.136734	4437.480790	4437.059705	4437.253731
76552	SILVER	180	1786850280	65.108591	65.119405	65.095965	65.111230
77137	GOLD	180	1786850640	4437.014639	4437.681353	4436.721215	4437.253554
77433	GOLD	180	1786850820	4437.242614	4437.884170	4437.004337	4437.723410
77138	GBP	180	1786850640	1.353375	1.353405	1.353146	1.353248
77237	GOLD	300	1786850700	4437.410284	4437.884170	4436.934604	4437.723410
77434	GBP	180	1786850820	1.353221	1.353408	1.353081	1.353338
77140	SILVER	180	1786850640	65.109712	65.116436	65.097334	65.113523
77238	GBP	300	1786850700	1.353292	1.353408	1.353081	1.353338
147753	BTC	180	1788440400	78635.538337	78642.676032	78503.078278	78606.611507
147750	GOLD	300	1788440400	4525.961009	4538.936230	4525.748581	4538.697575
77436	SILVER	180	1786850820	65.115388	65.117910	65.094471	65.098634
77240	SILVER	300	1786850700	65.103201	65.117910	65.094471	65.098634
76745	GOLD	300	1786850400	4436.992823	4437.906163	4436.721215	4437.312627
76746	GBP	300	1786850400	1.353250	1.353393	1.353144	1.353294
76254	GOLD	300	1786850100	4436.732574	4437.691465	4436.650152	4436.947550
147755	SILVER	180	1788440400	66.888952	67.048087	66.885293	67.046976
76256	GBP	300	1786850100	1.353292	1.353475	1.353162	1.353263
147752	GBP	300	1788440400	1.351875	1.352014	1.351539	1.351777
137289	GOLD	180	1788433920	4471.612081	4473.925996	4471.196745	4472.773019
137291	GBP	180	1788433920	1.349809	1.349965	1.349622	1.349659
76260	SILVER	300	1786850100	65.112229	65.124134	65.097653	65.116978
137293	BTC	180	1788433920	77736.552338	77803.112002	77733.412724	77781.871131
76748	SILVER	300	1786850400	65.117333	65.117333	65.095965	65.104309
76253	GOLD	180	1786850100	4436.732574	4437.686856	4436.650152	4437.247994
137295	SILVER	180	1788433920	66.183814	66.227788	66.163105	66.186781
76255	GBP	180	1786850100	1.353292	1.353437	1.353162	1.353231
156454	BTC	300	1788445800	79639.556044	79875.113907	79614.734990	79719.440281
76259	SILVER	180	1786850100	65.112229	65.124134	65.097653	65.108932
75966	GOLD	300	1786849800	4437.300000	4438.191339	4436.853128	4436.853128
156161	GOLD	180	1788445620	4519.973300	4523.508208	4518.884849	4523.508208
75971	SILVER	180	1786849920	65.108000	65.117138	65.102419	65.114478
75972	SILVER	300	1786849800	65.108000	65.117138	65.102419	65.114478
156163	GBP	180	1788445620	1.350822	1.351271	1.350626	1.351068
156165	BTC	180	1788445620	79520.058564	79645.206973	79520.058564	79636.023884
78610	GBP	180	1786851540	1.353243	1.353429	1.353148	1.353429
78710	GBP	300	1786851600	1.353326	1.353429	1.353158	1.353429
76845	GOLD	180	1786850460	4437.503269	4437.906163	4436.815858	4436.993041
76846	GBP	180	1786850460	1.353218	1.353393	1.353144	1.353342
78612	SILVER	180	1786851540	65.113831	65.115297	65.097822	65.115297
76848	SILVER	180	1786850460	65.111463	65.116975	65.098708	65.110139
78712	SILVER	300	1786851600	65.108974	65.115297	65.102865	65.115297
77725	GOLD	180	1786851000	4437.630821	4437.809346	4436.792406	4436.796622
77727	GBP	180	1786851000	1.353331	1.353456	1.353174	1.353273
76549	GOLD	180	1786850280	4437.320039	4437.691465	4436.857789	4437.470873
77731	SILVER	180	1786851000	65.098304	65.114741	65.097774	65.110311
78317	GOLD	180	1786851360	4437.428658	4437.898044	4436.820986	4437.533031
76550	GBP	180	1786850280	1.353243	1.353475	1.353145	1.353230
78318	GBP	180	1786851360	1.353287	1.353401	1.353184	1.353259
147749	GOLD	180	1788440400	4525.961009	4533.462565	4525.748581	4533.342291
147754	BTC	300	1788440400	78635.538337	78681.705134	78503.078278	78595.066597
147751	GBP	180	1788440400	1.351875	1.352014	1.351607	1.351607
78779	GBP	180	1786851900	1.353290	1.353376	1.353221	1.353282
78320	SILVER	180	1786851360	65.114537	65.119404	65.096590	65.112259
78905	GOLD	180	1786852080	4437.458346	4437.959953	4436.667527	4437.217002
147756	SILVER	300	1788440400	66.888952	67.220000	66.885293	67.215800
77726	GOLD	300	1786851000	4437.630821	4437.848743	4436.770249	4437.488340
77728	GBP	300	1786851000	1.353331	1.353456	1.353174	1.353295
77732	SILVER	300	1786851000	65.098304	65.120750	65.094394	65.120390
78217	GOLD	300	1786851300	4437.442726	4437.898044	4436.776697	4437.258611
78021	GOLD	180	1786851180	4436.770249	4437.848743	4436.770249	4437.330702
78022	GBP	180	1786851180	1.353245	1.353436	1.353146	1.353280
156167	SILVER	180	1788445620	66.962473	67.152348	66.939637	67.151051
78784	SILVER	300	1786851900	65.108000	65.118413	65.097973	65.106244
78024	SILVER	180	1786851180	65.110319	65.121437	65.094394	65.116639
78218	GBP	300	1786851300	1.353280	1.353401	1.353146	1.353338
78220	SILVER	300	1786851300	65.121437	65.121437	65.096590	65.110150
78783	SILVER	180	1786851900	65.108000	65.116014	65.104981	65.109065
78906	GBP	180	1786852080	1.353309	1.353384	1.353195	1.353279
78609	GOLD	180	1786851540	4437.503682	4437.662986	4436.819508	4437.253731
78778	GOLD	300	1786851900	4437.300000	4437.959953	4436.667527	4437.221427
78908	SILVER	180	1786852080	65.106959	65.118413	65.097673	65.106666
78780	GBP	300	1786851900	1.353290	1.353384	1.353200	1.353326
79496	SILVER	180	1786852440	65.113110	65.116099	65.096982	65.107806
78777	GOLD	180	1786851900	4437.300000	4437.543720	4436.746471	4437.347139
79494	GBP	180	1786852440	1.353199	1.353439	1.353067	1.353287
79101	GOLD	300	1786852200	4437.327507	4437.961150	4436.850419	4437.640422
79201	GOLD	180	1786852260	4437.333356	4437.961150	4436.850419	4437.395020
156456	SILVER	300	1788445800	67.149448	67.190058	67.055250	67.097891
79202	GBP	180	1786852260	1.353291	1.353444	1.353189	1.353201
156449	GOLD	180	1788445800	4523.531580	4526.393196	4519.949671	4519.957445
79204	SILVER	180	1786852260	65.108597	65.116439	65.097442	65.112602
79102	GBP	300	1786852200	1.353324	1.353444	1.353184	1.353334
156451	GBP	180	1788445800	1.351087	1.351301	1.350842	1.351114
79104	SILVER	300	1786852200	65.106819	65.116439	65.096982	65.109793
79493	GOLD	180	1786852440	4437.485011	4437.912379	4436.567230	4437.522549
79593	GOLD	300	1786852500	4437.740694	4437.995270	4436.567230	4437.063926
156450	GOLD	300	1788445800	4523.531580	4526.393196	4518.633998	4521.386525
156453	BTC	180	1788445800	79639.556044	79875.113907	79614.734990	79875.113907
156452	GBP	300	1788445800	1.351087	1.351301	1.350653	1.350949
156455	SILVER	180	1788445800	67.149448	67.190058	67.068634	67.070962
80084	GBP	300	1786852800	1.353269	1.353434	1.353151	1.353306
81838	GBP	180	1786853880	1.353308	1.353429	1.353130	1.353291
80088	SILVER	300	1786852800	65.111274	65.121885	65.098151	65.106493
79789	GOLD	180	1786852620	4437.591913	4437.995270	4436.830933	4437.063926
79790	GBP	180	1786852620	1.353282	1.353479	1.353198	1.353287
79594	GBP	300	1786852500	1.353341	1.353479	1.353067	1.353287
79792	SILVER	180	1786852620	65.107734	65.119949	65.096835	65.108822
79596	SILVER	300	1786852500	65.108162	65.119949	65.096835	65.108822
82134	GBP	180	1786854060	1.353322	1.353444	1.353206	1.353283
137577	GOLD	180	1788434100	4472.871844	4474.378466	4472.041348	4473.050040
137865	GOLD	180	1788434280	4473.060193	4477.388263	4471.287250	4476.025855
80081	GOLD	180	1786852800	4437.050084	4438.130401	4436.425136	4437.303016
81840	SILVER	180	1786853880	65.107737	65.117915	65.099570	65.108731
80083	GBP	180	1786852800	1.353269	1.353434	1.353163	1.353290
137579	GBP	180	1788434100	1.349658	1.349869	1.349485	1.349805
137578	GOLD	300	1788434100	4472.871844	4477.349180	4471.287250	4477.222528
80087	SILVER	180	1786852800	65.111274	65.121885	65.098786	65.111714
137581	BTC	180	1788434100	77782.483313	77874.002766	77779.107552	77841.888722
137866	GBP	180	1788434280	1.349783	1.349964	1.349605	1.349738
80953	GOLD	180	1786853340	4436.977828	4437.668869	4436.586830	4437.567443
80954	GBP	180	1786853340	1.353336	1.353477	1.353162	1.353162
82036	SILVER	300	1786854000	65.112071	65.119781	65.098396	65.103696
137583	SILVER	180	1788434100	66.185205	66.223177	66.181803	66.206105
80566	GOLD	300	1786853100	4437.665826	4437.778820	4436.671592	4437.342006
82136	SILVER	180	1786854060	65.109568	65.119781	65.098396	65.112053
80568	GBP	300	1786853100	1.353327	1.353468	1.353127	1.353262
80956	SILVER	180	1786853340	65.109153	65.114637	65.100165	65.105544
137582	BTC	300	1788434100	77782.483313	77916.514023	77779.107552	77896.490652
80572	SILVER	300	1786853100	65.105057	65.118509	65.096937	65.107960
148325	GOLD	180	1788440760	4540.079013	4542.689667	4538.125967	4541.795964
80661	GOLD	180	1786853160	4437.398310	4437.616248	4436.671592	4437.072137
80377	GOLD	180	1786852980	4437.310611	4437.778820	4436.675302	4437.389225
80662	GBP	180	1786853160	1.353280	1.353381	1.353127	1.353368
80378	GBP	180	1786852980	1.353308	1.353468	1.353151	1.353266
148327	GBP	180	1788440760	1.351602	1.351692	1.351418	1.351470
148039	GBP	180	1788440580	1.351586	1.351827	1.351497	1.351596
80380	SILVER	180	1786852980	65.112454	65.121523	65.098151	65.116711
148041	BTC	180	1788440580	78604.286503	78681.705134	78558.329768	78559.170671
80664	SILVER	180	1786853160	65.115250	65.118509	65.096937	65.110455
137867	BTC	180	1788434280	77842.254880	77917.160011	77839.730000	77879.906512
137580	GBP	300	1788434100	1.349658	1.349964	1.349485	1.349835
137868	SILVER	180	1788434280	66.205609	66.335088	66.192604	66.321037
137584	SILVER	300	1788434100	66.185205	66.315000	66.181803	66.301434
81542	GOLD	300	1786853700	4436.870712	4437.956122	4436.589263	4437.442419
81544	GBP	300	1786853700	1.353238	1.353462	1.353130	1.353218
81541	GOLD	180	1786853700	4436.870712	4437.956122	4436.589263	4437.340114
81543	GBP	180	1786853700	1.353238	1.353462	1.353149	1.353309
80082	GOLD	300	1786852800	4437.050084	4438.130401	4436.425136	4437.622201
81547	SILVER	180	1786853700	65.111234	65.114219	65.100685	65.105538
81548	SILVER	300	1786853700	65.111234	65.117459	65.099570	65.111676
81249	GOLD	180	1786853520	4437.674594	4437.807853	4436.920956	4436.920956
81053	GOLD	300	1786853400	4437.377195	4437.807853	4436.586830	4436.920956
81250	GBP	180	1786853520	1.353133	1.353423	1.353017	1.353255
81054	GBP	300	1786853400	1.353233	1.353477	1.353017	1.353255
81252	SILVER	180	1786853520	65.104228	65.120241	65.094239	65.110638
81056	SILVER	300	1786853400	65.110266	65.120241	65.094239	65.110638
82428	SILVER	180	1786854240	65.111602	65.118852	65.095953	65.108968
82724	SILVER	180	1786854420	65.108897	65.116611	65.099515	65.105265
148043	SILVER	180	1788440580	67.044299	67.259019	67.015000	67.240465
82528	SILVER	300	1786854300	65.104300	65.116611	65.095953	65.105265
83013	GOLD	180	1786854600	4437.011244	4437.788592	4436.670274	4437.321934
82033	GOLD	300	1786854000	4437.542333	4438.151251	4436.823874	4437.174033
83014	GOLD	300	1786854600	4437.011244	4437.788592	4436.670274	4437.243648
81837	GOLD	180	1786853880	4437.360494	4437.703826	4436.823874	4437.477940
82034	GBP	300	1786854000	1.353188	1.353445	1.353182	1.353275
82425	GOLD	180	1786854240	4437.214080	4438.151251	4436.891538	4437.481310
82133	GOLD	180	1786854060	4437.539511	4437.563898	4436.885682	4437.249675
83019	SILVER	180	1786854600	65.104664	65.120160	65.097677	65.108761
82426	GBP	180	1786854240	1.353266	1.353445	1.353132	1.353318
82721	GOLD	180	1786854420	4437.474726	4438.189669	4436.861588	4437.057338
148329	BTC	180	1788440760	78557.789520	78568.256158	78470.073295	78533.075478
82525	GOLD	300	1786854300	4437.257172	4438.189669	4436.861588	4437.057338
82722	GBP	180	1786854420	1.353306	1.353499	1.353150	1.353253
82526	GBP	300	1786854300	1.353250	1.353499	1.353132	1.353253
148331	SILVER	180	1788440760	67.239888	67.325000	67.190000	67.323457
83494	GBP	300	1786854900	1.353328	1.353465	1.353104	1.353300
148230	GOLD	300	1788440700	4538.631676	4542.689667	4537.284465	4540.548150
83301	GOLD	180	1786854780	4437.399408	4437.830922	4436.818741	4437.214187
83303	GBP	180	1786854780	1.353292	1.353405	1.353201	1.353259
83015	GBP	180	1786854600	1.353245	1.353490	1.353161	1.353270
148037	GOLD	180	1788440580	4533.308584	4540.360600	4531.956060	4540.119824
83020	SILVER	300	1786854600	65.104664	65.120160	65.092889	65.107581
83307	SILVER	180	1786854780	65.111198	65.118892	65.092889	65.106235
83016	GBP	300	1786854600	1.353245	1.353490	1.353161	1.353301
83593	GOLD	180	1786854960	4437.135884	4437.691757	4436.848504	4437.453657
83594	GBP	180	1786854960	1.353254	1.353465	1.353139	1.353297
83493	GOLD	300	1786854900	4437.358695	4437.830922	4436.848504	4436.939738
83496	SILVER	300	1786854900	65.106710	65.118157	65.094662	65.109295
148232	GBP	300	1788440700	1.351800	1.351827	1.351418	1.351469
148234	BTC	300	1788440700	78591.812879	78601.498504	78470.073295	78513.463949
148236	SILVER	300	1788440700	67.214137	67.327545	67.190000	67.219305
83885	GOLD	180	1786855140	4437.418901	4437.728284	4436.716080	4437.407577
86497	GOLD	180	1786856760	4437.094009	4437.853458	4436.704215	4437.158569
83886	GBP	180	1786855140	1.353324	1.353438	1.353104	1.353327
83888	SILVER	180	1786855140	65.109422	65.117441	65.097103	65.111260
148616	SILVER	180	1788440940	67.320851	67.327545	67.190000	67.256264
84181	GOLD	180	1786855320	4437.481693	4437.679005	4436.713772	4437.258013
83985	GOLD	300	1786855200	4436.845750	4437.679005	4436.713772	4437.258013
84182	GBP	180	1786855320	1.353315	1.353427	1.353142	1.353318
83986	GBP	300	1786855200	1.353277	1.353438	1.353142	1.353318
148715	BTC	300	1788441000	78509.263156	78591.820109	78489.126777	78526.645674
138061	GOLD	300	1788434400	4477.352872	4479.108350	4476.004803	4477.505721
84184	SILVER	180	1786855320	65.110270	65.116882	65.098612	65.107753
83988	SILVER	300	1786855200	65.110513	65.117441	65.098612	65.107753
138062	GBP	300	1788434400	1.349837	1.349856	1.349370	1.349601
138063	BTC	300	1788434400	77897.636553	77917.160011	77804.524102	77847.288456
86205	GOLD	180	1786856580	4436.991235	4437.959146	4436.693611	4437.134043
85923	SILVER	180	1786856400	65.112381	65.119238	65.098921	65.104855
86400	SILVER	300	1786856700	65.106040	65.116947	65.096865	65.112654
86207	GBP	180	1786856580	1.353277	1.353439	1.353195	1.353312
86498	GBP	180	1786856760	1.353323	1.353467	1.353110	1.353324
85629	GOLD	180	1786856220	4437.305962	4437.764213	4436.841120	4437.585573
85057	GOLD	180	1786855860	4437.197696	4437.905650	4436.841504	4437.435694
85438	GOLD	300	1786856100	4437.238375	4438.052698	4436.810041	4437.585573
85058	GBP	180	1786855860	1.353235	1.353381	1.353196	1.353309
84957	GOLD	300	1786855800	4437.333431	4438.075916	4436.803319	4437.347536
138064	SILVER	300	1788434400	66.303546	66.380065	66.299903	66.364300
85631	GBP	180	1786856220	1.353269	1.353416	1.353157	1.353328
85060	SILVER	180	1786855860	65.112613	65.120853	65.098428	65.111087
84958	GBP	300	1786855800	1.353316	1.353462	1.353169	1.353310
85440	GBP	300	1786856100	1.353282	1.353449	1.353157	1.353328
84960	SILVER	300	1786855800	65.109098	65.120853	65.096882	65.115073
148716	SILVER	300	1788441000	67.220596	67.286974	67.118711	67.150402
85635	SILVER	180	1786856220	65.115901	65.117889	65.098704	65.111224
84473	GOLD	180	1786855500	4437.217917	4437.871169	4436.540227	4437.323380
85444	SILVER	300	1786856100	65.117374	65.127114	65.098522	65.111224
84475	GBP	180	1786855500	1.353346	1.353453	1.353075	1.353262
84761	GOLD	180	1786855680	4437.388799	4437.671439	4436.601586	4437.189108
148614	GBP	180	1788440940	1.351493	1.351667	1.351205	1.351205
84479	SILVER	180	1786855500	65.108921	65.120689	65.096648	65.105761
84762	GBP	180	1786855680	1.353291	1.353497	1.353107	1.353248
156737	GOLD	180	1788445980	4519.895578	4524.700000	4518.633998	4520.738923
83596	SILVER	180	1786854960	65.107774	65.114954	65.094662	65.109414
148613	GOLD	180	1788440940	4541.864399	4542.605693	4537.500000	4541.518515
148713	GOLD	300	1788441000	4540.620447	4541.696107	4535.696172	4537.357887
148615	BTC	180	1788440940	78533.463732	78569.810839	78483.366073	78536.879073
84764	SILVER	180	1786855680	65.103907	65.117499	65.092615	65.112524
148714	GBP	300	1788441000	1.351448	1.351592	1.351189	1.351490
84474	GOLD	300	1786855500	4437.217917	4437.871169	4436.540227	4437.428758
84476	GBP	300	1786855500	1.353346	1.353497	1.353075	1.353318
86211	SILVER	180	1786856580	65.104582	65.115291	65.099033	65.107754
85341	GOLD	180	1786856040	4437.351047	4438.075916	4436.810041	4437.423503
85343	GBP	180	1786856040	1.353284	1.353462	1.353169	1.353238
84480	SILVER	300	1786855500	65.108921	65.120689	65.092615	65.106919
85347	SILVER	180	1786856040	65.110592	65.127114	65.098522	65.114165
85918	GOLD	300	1786856400	4437.580428	4437.913395	4436.738078	4436.935882
156739	GBP	180	1788445980	1.351087	1.351149	1.350617	1.350710
85920	GBP	300	1786856400	1.353332	1.353439	1.353195	1.353344
156741	BTC	180	1788445980	79871.033148	79874.227197	79681.281842	79759.850335
86500	SILVER	180	1786856760	65.107253	65.115130	65.096865	65.110794
156743	SILVER	180	1788445980	67.070781	67.178910	67.039798	67.046095
86789	GOLD	180	1786856940	4437.068814	4437.658347	4436.632348	4437.190671
87384	SILVER	300	1786857300	65.105032	65.110494	65.101092	65.109222
87085	GOLD	180	1786857120	4437.081334	4437.899066	4436.546350	4437.592012
86397	GOLD	300	1786856700	4436.846933	4437.959146	4436.681405	4437.113477
85924	SILVER	300	1786856400	65.112381	65.119238	65.098921	65.105705
85917	GOLD	180	1786856400	4437.580428	4437.913395	4436.738078	4437.048948
85919	GBP	180	1786856400	1.353332	1.353408	1.353200	1.353306
86790	GBP	180	1786856940	1.353309	1.353390	1.353083	1.353312
86398	GBP	300	1786856700	1.353329	1.353467	1.353110	1.353259
86889	GOLD	300	1786857000	4437.133923	4437.899066	4436.546350	4437.592012
87383	SILVER	180	1786857300	65.105032	65.108000	65.101092	65.102220
87086	GBP	180	1786857120	1.353324	1.353393	1.353066	1.353271
86890	GBP	300	1786857000	1.353240	1.353393	1.353066	1.353271
87088	SILVER	180	1786857120	65.102436	65.115496	65.093011	65.103824
86792	SILVER	180	1786856940	65.113034	65.119132	65.100237	65.105028
86892	SILVER	300	1786857000	65.110586	65.119132	65.093011	65.103824
87377	GOLD	180	1786857300	4437.715774	4437.838569	4437.154108	4437.194987
87380	GBP	300	1786857300	1.353245	1.353333	1.353238	1.353238
87379	GBP	180	1786857300	1.353245	1.353333	1.353242	1.353255
87378	GOLD	300	1786857300	4437.715774	4437.838569	4437.154108	4437.257498
87433	GOLD	180	1786857480	4437.300000	4437.524784	4436.879441	4437.288688
87435	GBP	180	1786857480	1.353290	1.353503	1.353140	1.353267
90294	GBP	300	1786865100	1.353180	1.353398	1.353165	1.353384
88421	GOLD	180	1786858200	4437.160398	4437.419410	4436.927025	4437.071377
88422	GOLD	300	1786858200	4437.160398	4437.419410	4436.927025	4437.071377
88423	GBP	180	1786858200	1.353268	1.353384	1.353181	1.353267
88424	GBP	300	1786858200	1.353268	1.353384	1.353181	1.353267
148909	GOLD	180	1788441120	4541.636838	4541.696107	4535.696172	4537.357887
88427	SILVER	180	1786858200	65.115521	65.119601	65.106163	65.109445
88428	SILVER	300	1786858200	65.115521	65.119601	65.106163	65.109445
88129	GOLD	180	1786858020	4437.292236	4437.646258	4436.869314	4437.083037
87933	GOLD	300	1786857900	4437.346248	4437.847187	4436.730507	4437.083037
88130	GBP	180	1786858020	1.353315	1.353453	1.353119	1.353297
87934	GBP	300	1786857900	1.353350	1.353453	1.353119	1.353297
148910	GBP	180	1788441120	1.351215	1.351516	1.351189	1.351490
148911	BTC	180	1788441120	78541.497512	78591.820109	78499.159174	78526.645674
88132	SILVER	180	1786858020	65.097550	65.118728	65.095465	65.116359
87936	SILVER	300	1786857900	65.109750	65.118728	65.095465	65.116359
148912	SILVER	180	1788441120	67.254856	67.270231	67.118711	67.150402
157029	BTC	180	1788446160	79761.765932	79856.493140	79677.091144	79732.069163
87541	GOLD	180	1786857660	4437.383019	4437.810082	4436.707197	4437.282863
157031	SILVER	180	1788446160	67.045227	67.106651	67.011226	67.063546
87542	GBP	180	1786857660	1.353236	1.353430	1.353172	1.353294
156930	GOLD	300	1788446100	4521.416268	4523.979183	4517.443017	4523.569991
87544	SILVER	180	1786857660	65.101609	65.115642	65.097717	65.111588
88477	GOLD	180	1786859640	4437.300000	4437.842387	4436.993270	4437.198219
88996	SILVER	300	1786860000	65.105568	65.116022	65.098117	65.103494
88479	GBP	180	1786859640	1.353290	1.353409	1.353181	1.353320
89515	SILVER	180	1786864500	65.108000	65.111825	65.104088	65.110299
88483	SILVER	180	1786859640	65.108000	65.115009	65.102338	65.111851
89516	SILVER	300	1786864500	65.108000	65.117712	65.102030	65.116082
87833	GOLD	180	1786857840	4437.348277	4437.847187	4436.716255	4437.311605
87834	GBP	180	1786857840	1.353285	1.353367	1.353146	1.353316
87439	SILVER	180	1786857480	65.108000	65.114251	65.101448	65.103455
87836	SILVER	180	1786857840	65.111713	65.119514	65.100089	65.100089
138161	GOLD	180	1788434460	4476.005588	4479.108350	4476.004803	4478.372235
138162	GBP	180	1788434460	1.349731	1.349800	1.349435	1.349595
87441	GOLD	300	1786857600	4437.308737	4437.810082	4436.707197	4437.459421
87442	GBP	300	1786857600	1.353213	1.353503	1.353140	1.353362
138163	BTC	180	1788434460	77881.572609	77881.572609	77804.524102	77820.167305
138164	SILVER	180	1788434460	66.319236	66.374323	66.305168	66.369493
88705	GOLD	180	1786859820	4437.199110	4437.949699	4436.942254	4437.211327
88509	GOLD	300	1786859700	4437.472107	4437.949699	4436.942254	4437.211327
88478	GOLD	300	1786859400	4437.300000	4437.532775	4437.230736	4437.384610
88706	GBP	180	1786859820	1.353303	1.353419	1.353069	1.353327
88480	GBP	300	1786859400	1.353290	1.353391	1.353265	1.353265
88510	GBP	300	1786859700	1.353285	1.353419	1.353069	1.353327
87444	SILVER	300	1786857600	65.109174	65.119514	65.097717	65.110054
88484	SILVER	300	1786859400	65.108000	65.109160	65.105223	65.108023
88708	SILVER	180	1786859820	65.113488	65.120316	65.097103	65.105090
157025	GOLD	180	1788446160	4520.644250	4521.979411	4517.443017	4520.228806
88512	SILVER	300	1786859700	65.109721	65.120316	65.097103	65.105090
157027	GBP	180	1788446160	1.350693	1.350855	1.350507	1.350683
89608	SILVER	180	1786864680	65.110696	65.117712	65.102030	65.111428
89277	GOLD	180	1786860180	4437.268080	4438.389083	4436.594820	4437.360808
88989	GOLD	180	1786860000	4437.222022	4437.712364	4436.734879	4437.190381
89470	GOLD	300	1786860300	4437.652704	4437.779559	4437.124847	4437.360808
88991	GBP	180	1786860000	1.353347	1.353468	1.353228	1.353267
89279	GBP	180	1786860180	1.353235	1.353399	1.353153	1.353348
89472	GBP	300	1786860300	1.353269	1.353367	1.353213	1.353348
156932	GBP	300	1788446100	1.350954	1.350994	1.350371	1.350407
88995	SILVER	180	1786860000	65.105568	65.116022	65.099730	65.108747
156934	BTC	300	1788446100	79722.402502	79856.493140	79676.764775	79691.535168
89283	SILVER	180	1786860180	65.107171	65.113209	65.098117	65.102307
88990	GOLD	300	1786860000	4437.222022	4438.389083	4436.594820	4437.540311
89476	SILVER	300	1786860300	65.101277	65.108950	65.101277	65.102307
156936	SILVER	300	1788446100	67.096162	67.135000	67.011226	67.131177
89606	GBP	180	1786864680	1.353445	1.353445	1.353180	1.353278
88992	GBP	300	1786860000	1.353347	1.353468	1.353153	1.353285
89801	GOLD	300	1786864800	4437.201203	4437.925838	4436.553143	4437.148162
89509	GOLD	180	1786864500	4437.300000	4437.855948	4436.790203	4437.855948
89510	GOLD	300	1786864500	4437.300000	4438.114039	4436.685882	4437.106509
89511	GBP	180	1786864500	1.353290	1.353427	1.353252	1.353427
89512	GBP	300	1786864500	1.353290	1.353445	1.353180	1.353283
90293	GOLD	300	1786865100	4437.183123	4437.876593	4436.861784	4437.359549
90296	SILVER	300	1786865100	65.112026	65.120103	65.092631	65.108071
89901	GOLD	180	1786864860	4437.345208	4437.925838	4436.615234	4436.615234
89605	GOLD	180	1786864680	4437.881668	4438.114039	4436.685882	4437.329782
89902	GBP	180	1786864860	1.353249	1.353426	1.353042	1.353238
89904	SILVER	180	1786864860	65.110468	65.118470	65.101364	65.112196
89802	GBP	300	1786864800	1.353268	1.353426	1.353042	1.353198
89804	SILVER	300	1786864800	65.116036	65.119467	65.099584	65.111618
90196	SILVER	180	1786865040	65.110359	65.119467	65.092631	65.114064
90193	GOLD	180	1786865040	4436.553143	4437.882066	4436.553143	4437.143561
90194	GBP	180	1786865040	1.353256	1.353375	1.353141	1.353252
91077	GOLD	180	1786865580	4437.125179	4437.756320	4436.697197	4437.574608
92233	GOLD	180	1786866300	4437.450484	4438.005797	4436.832804	4436.891469
91078	GBP	180	1786865580	1.353352	1.353472	1.353194	1.353314
91080	SILVER	180	1786865580	65.107570	65.118367	65.098511	65.104750
157313	GOLD	180	1788446340	4520.286332	4526.148325	4520.185281	4524.440243
92235	GBP	180	1786866300	1.353316	1.353423	1.353142	1.353287
93416	SILVER	180	1786867020	65.110901	65.118545	65.098802	65.112011
149481	GOLD	180	1788441480	4538.074138	4540.915535	4533.804394	4533.804394
93220	SILVER	300	1786866900	65.112103	65.118886	65.097756	65.112011
92239	SILVER	180	1786866300	65.110847	65.119387	65.094405	65.108907
149193	GOLD	180	1788441300	4537.253429	4539.675486	4532.750974	4538.064531
91273	GOLD	300	1786865700	4436.799429	4437.781339	4436.697197	4437.250174
91274	GBP	300	1786865700	1.353215	1.353441	1.353194	1.353373
92825	GOLD	180	1786866660	4436.763626	4437.870648	4436.763626	4437.447186
149483	GBP	180	1788441480	1.351043	1.351211	1.350917	1.350927
91276	SILVER	300	1786865700	65.098679	65.119354	65.094602	65.108753
92826	GBP	180	1786866660	1.353414	1.353439	1.353170	1.353299
149195	GBP	180	1788441300	1.351486	1.351601	1.351005	1.351065
90782	GOLD	300	1786865400	4437.440133	4437.664053	4436.643294	4436.770204
149194	GOLD	300	1788441300	4537.253429	4540.915535	4532.750974	4537.051600
90784	GBP	300	1786865400	1.353379	1.353472	1.353176	1.353210
94002	GBP	180	1786867380	1.353310	1.353440	1.353173	1.353222
149197	BTC	180	1788441300	78522.782433	78558.610664	78473.863778	78489.144637
90788	SILVER	300	1786865400	65.108048	65.118367	65.097051	65.101242
149196	GBP	300	1788441300	1.351486	1.351601	1.350917	1.351134
92828	SILVER	180	1786866660	65.108885	65.121048	65.098554	65.111175
93707	GBP	180	1786867200	1.353220	1.353396	1.353138	1.353293
92234	GOLD	300	1786866300	4437.450484	4438.005797	4436.592786	4436.592786
90781	GOLD	180	1786865400	4437.440133	4437.631779	4436.643294	4437.151412
90783	GBP	180	1786865400	1.353379	1.353411	1.353176	1.353322
92236	GBP	300	1786866300	1.353316	1.353440	1.353096	1.353274
138453	GOLD	180	1788434640	4478.421024	4481.049537	4476.663433	4480.942375
92529	GOLD	180	1786866480	4436.890004	4437.841199	4436.592786	4436.755269
90787	SILVER	180	1786865400	65.108048	65.116148	65.097051	65.108131
91373	GOLD	180	1786865760	4437.450449	4437.781339	4436.737395	4436.898962
90489	GOLD	180	1786865220	4437.135023	4437.876593	4436.943600	4437.359549
90490	GBP	180	1786865220	1.353223	1.353398	1.353178	1.353384
138553	GOLD	300	1788434700	4477.402652	4482.268986	4477.323534	4480.177667
90492	SILVER	180	1786865220	65.115736	65.120103	65.094860	65.108071
138454	GBP	180	1788434640	1.349582	1.349628	1.349370	1.349418
138554	GBP	300	1788434700	1.349606	1.349606	1.349018	1.349310
138455	BTC	180	1788434640	77816.739544	77918.060471	77813.904431	77918.060471
138555	BTC	300	1788434700	77849.732608	77931.910452	77845.615047	77894.994477
91374	GBP	180	1786865760	1.353321	1.353441	1.353197	1.353286
138456	SILVER	180	1788434640	66.370660	66.410766	66.361007	66.381752
92240	SILVER	300	1786866300	65.110847	65.119387	65.094405	65.100514
91376	SILVER	180	1786865760	65.102451	65.119354	65.094602	65.112471
138556	SILVER	300	1788434700	66.362225	66.425896	66.349971	66.392984
92530	GBP	180	1786866480	1.353289	1.353440	1.353096	1.353430
91945	GOLD	180	1786866120	4436.607684	4437.793107	4436.607684	4437.481830
91754	GOLD	300	1786866000	4437.332008	4437.945191	4436.607684	4437.481830
91947	GBP	180	1786866120	1.353366	1.353478	1.353167	1.353313
91756	GBP	300	1786866000	1.353406	1.353478	1.353167	1.353313
91657	GOLD	180	1786865940	4436.866254	4437.945191	4436.648357	4436.685317
92532	SILVER	180	1786866480	65.108564	65.116299	65.097511	65.109068
93706	GOLD	300	1786867200	4437.391513	4438.042742	4436.636659	4437.907270
92725	GOLD	300	1786866600	4436.677350	4437.870648	4436.677350	4437.382616
93413	GOLD	180	1786867020	4437.366045	4438.091575	4436.600740	4437.409272
92726	GBP	300	1786866600	1.353260	1.353439	1.353170	1.353372
91951	SILVER	180	1786866120	65.106793	65.120969	65.098452	65.108523
91659	GBP	180	1786865940	1.353280	1.353406	1.353191	1.353361
91760	SILVER	300	1786866000	65.108780	65.120969	65.097706	65.108523
91663	SILVER	180	1786865940	65.111316	65.115288	65.097706	65.106410
93117	GOLD	180	1786866840	4437.564684	4437.692495	4436.832889	4437.280001
92728	SILVER	300	1786866600	65.102168	65.121048	65.098554	65.111287
93118	GBP	180	1786866840	1.353321	1.353440	1.353173	1.353219
93217	GOLD	300	1786866900	4437.449960	4438.091575	4436.600740	4437.409272
93414	GBP	180	1786867020	1.353216	1.353469	1.353162	1.353237
149199	SILVER	180	1788441300	67.152780	67.165000	67.077318	67.129535
93218	GBP	300	1786866900	1.353350	1.353469	1.353162	1.353237
93120	SILVER	180	1786866840	65.113038	65.118886	65.097756	65.113310
149198	BTC	300	1788441300	78522.782433	78558.610664	78426.245275	78463.228621
149200	SILVER	300	1788441300	67.152780	67.218412	67.077318	67.126609
94001	GOLD	180	1786867380	4437.279886	4438.042742	4436.725473	4437.101835
93712	SILVER	300	1786867200	65.112810	65.121779	65.095008	65.110801
93705	GOLD	180	1786867200	4437.391513	4437.911211	4436.636659	4437.378321
93708	GBP	300	1786867200	1.353220	1.353440	1.353138	1.353285
93711	SILVER	180	1786867200	65.112810	65.121779	65.095008	65.109243
94198	GBP	300	1786867500	1.353293	1.353534	1.353170	1.353170
149485	BTC	180	1788441480	78490.595122	78498.813740	78417.021475	78456.735646
94200	SILVER	300	1786867500	65.110625	65.119861	65.098365	65.105669
149487	SILVER	180	1788441480	67.132012	67.218412	67.115000	67.145818
94004	SILVER	180	1786867380	65.109623	65.119861	65.098824	65.106091
94197	GOLD	300	1786867500	4437.880513	4437.880513	4436.725473	4437.438703
94297	GOLD	180	1786867560	4437.098016	4437.725090	4436.954814	4437.038957
94298	GBP	180	1786867560	1.353196	1.353398	1.353196	1.353359
94300	SILVER	180	1786867560	65.104021	65.115624	65.098754	65.106394
94589	GOLD	180	1786867740	4437.007035	4437.834661	4436.720740	4437.397347
157314	GBP	180	1788446340	1.350667	1.350668	1.350137	1.350173
157315	BTC	180	1788446340	79736.267470	79748.002438	79612.550000	79642.445936
157316	SILVER	180	1788446340	67.061606	67.156428	67.060931	67.123737
96633	GOLD	180	1786869000	4437.155042	4438.028808	4436.953444	4437.466299
96635	GBP	180	1786869000	1.353254	1.353430	1.353203	1.353281
96045	GOLD	180	1786868640	4437.755406	4437.805406	4436.801720	4437.204949
139042	GOLD	300	1788435000	4480.289062	4480.877124	4476.303482	4477.182937
96046	GBP	180	1786868640	1.353316	1.353430	1.353204	1.353365
96341	GOLD	180	1786868820	4437.155393	4437.755304	4436.675708	4437.281422
139044	GBP	300	1788435000	1.349303	1.349379	1.348811	1.349328
96145	GOLD	300	1786868700	4437.175548	4437.755304	4436.675708	4437.281422
96048	SILVER	180	1786868640	65.109212	65.117712	65.094669	65.108284
96342	GBP	180	1786868820	1.353364	1.353387	1.353189	1.353265
139046	BTC	300	1788435000	77892.234032	77938.564469	77803.303627	77909.526324
96146	GBP	300	1786868700	1.353320	1.353393	1.353189	1.353265
139048	SILVER	300	1788435000	66.393423	66.393423	66.303705	66.319684
139041	GOLD	180	1788435000	4480.289062	4480.877124	4477.000000	4477.008034
96344	SILVER	180	1786868820	65.105952	65.121129	65.092647	65.100131
96148	SILVER	300	1786868700	65.110466	65.121129	65.092647	65.100131
95473	GOLD	180	1786868280	4437.750161	4437.750161	4436.626557	4437.501210
149771	GBP	180	1788441660	1.350908	1.351262	1.350871	1.351185
95474	GBP	180	1786868280	1.353295	1.353408	1.353104	1.353286
139043	GBP	180	1788435000	1.349303	1.349351	1.348811	1.349063
94885	GOLD	180	1786867920	4437.503451	4437.811460	4436.589539	4437.005376
94689	GOLD	300	1786867800	4437.526419	4437.811460	4436.589539	4437.005376
94886	GBP	180	1786867920	1.353318	1.353385	1.353126	1.353280
94690	GBP	300	1786867800	1.353183	1.353416	1.353124	1.353280
149773	BTC	180	1788441660	78452.575164	78586.274997	78451.094652	78549.943012
139045	BTC	180	1788435000	77892.234032	77938.564469	77803.303627	77889.660571
149775	SILVER	180	1788441660	67.148061	67.178373	67.095000	67.098816
94888	SILVER	180	1786867920	65.117750	65.117750	65.095270	65.111159
94692	SILVER	300	1786867800	65.107775	65.119000	65.095270	65.111159
94590	GBP	180	1786867740	1.353334	1.353534	1.353124	1.353286
139047	SILVER	180	1788435000	66.393423	66.393423	66.305644	66.309517
94592	SILVER	180	1786867740	65.105208	65.119000	65.098365	65.115263
149674	GOLD	300	1788441600	4537.108149	4537.343776	4532.232243	4534.296938
138749	GOLD	180	1788434820	4480.998917	4482.268986	4479.281177	4480.177667
138750	GBP	180	1788434820	1.349426	1.349490	1.349018	1.349310
138751	BTC	180	1788434820	77922.335249	77931.910452	77861.178805	77894.994477
95476	SILVER	180	1786868280	65.104926	65.120106	65.097413	65.113050
96640	SILVER	300	1786869000	65.098914	65.118391	65.097896	65.117197
96639	SILVER	180	1786869000	65.098914	65.118391	65.098914	65.112494
138752	SILVER	180	1788434820	66.380571	66.425896	66.349971	66.392984
96932	SILVER	180	1786869180	65.110184	65.118560	65.094794	65.108584
95662	GOLD	300	1786868400	4437.475698	4437.805406	4436.626557	4437.199859
97228	SILVER	180	1786869360	65.108196	65.118069	65.094202	65.107301
95178	GOLD	300	1786868100	4436.974023	4437.750161	4436.800794	4437.381196
95757	GOLD	180	1786868460	4437.459301	4437.803389	4436.634229	4437.803389
95180	GBP	300	1786868100	1.353257	1.353408	1.353104	1.353364
95177	GOLD	180	1786868100	4436.974023	4437.746994	4436.800794	4437.728096
95179	GBP	180	1786868100	1.353257	1.353403	1.353107	1.353306
95759	GBP	180	1786868460	1.353265	1.353434	1.353191	1.353324
95664	GBP	300	1786868400	1.353398	1.353434	1.353190	1.353312
95183	SILVER	180	1786868100	65.110663	65.116413	65.093342	65.104950
95184	SILVER	300	1786868100	65.110663	65.120106	65.093342	65.115485
95763	SILVER	180	1786868460	65.113683	65.118285	65.098434	65.107797
97511	GBP	180	1786869540	1.353339	1.353394	1.353176	1.353342
95668	SILVER	300	1786868400	65.117154	65.118285	65.098434	65.109122
98089	GOLD	180	1786869900	4437.303395	4437.912392	4436.872103	4437.912392
149769	GOLD	180	1788441660	4533.832344	4536.653376	4532.583578	4532.609506
97798	GBP	180	1786869720	1.353321	1.353423	1.353179	1.353285
97608	GBP	300	1786869600	1.353294	1.353423	1.353176	1.353285
97800	SILVER	180	1786869720	65.108822	65.113480	65.097215	65.108447
97612	SILVER	300	1786869600	65.108625	65.115928	65.097215	65.108447
96634	GOLD	300	1786869000	4437.155042	4438.028808	4436.716144	4437.446808
97125	GOLD	300	1786869300	4437.356108	4437.938413	4436.563893	4437.838385
96636	GBP	300	1786869000	1.353254	1.353430	1.353164	1.353275
96929	GOLD	180	1786869180	4437.410743	4437.960886	4436.716144	4437.210351
98096	SILVER	300	1786869900	65.107059	65.123077	65.097923	65.111136
97509	GOLD	180	1786869540	4437.469923	4437.993630	4436.892192	4437.693786
98091	GBP	180	1786869900	1.353312	1.353380	1.353176	1.353251
97515	SILVER	180	1786869540	65.107945	65.115928	65.100563	65.107620
96930	GBP	180	1786869180	1.353281	1.353391	1.353164	1.353283
97225	GOLD	180	1786869360	4437.258798	4437.886736	4436.563893	4437.530759
97126	GBP	300	1786869300	1.353307	1.353451	1.353178	1.353270
97226	GBP	180	1786869360	1.353284	1.353451	1.353178	1.353315
98388	SILVER	180	1786870080	65.103753	65.115250	65.098380	65.105309
149676	GBP	300	1788441600	1.351153	1.351262	1.350871	1.351121
97128	SILVER	300	1786869300	65.118560	65.118560	65.094202	65.111193
149680	SILVER	300	1788441600	67.125906	67.180503	67.095000	67.176847
97797	GOLD	180	1786869720	4437.720998	4437.800485	4436.448029	4437.297339
97606	GOLD	300	1786869600	4437.954293	4437.993630	4436.448029	4437.297339
149678	BTC	300	1788441600	78459.868409	78586.274997	78417.021475	78559.137152
98385	GOLD	180	1786870080	4437.954480	4437.954480	4436.583687	4437.449151
98095	SILVER	180	1786869900	65.107059	65.123077	65.097923	65.105319
98386	GBP	180	1786870080	1.353260	1.353431	1.353147	1.353319
98582	GBP	300	1786870200	1.353365	1.353396	1.353153	1.353334
98090	GOLD	300	1786869900	4437.303395	4437.954480	4436.872103	4437.167524
98092	GBP	300	1786869900	1.353312	1.353431	1.353147	1.353387
98581	GOLD	300	1786870200	4437.240331	4437.821986	4436.583687	4437.108443
157413	GOLD	300	1788446400	4523.625917	4526.148325	4518.200000	4518.344788
157414	GBP	300	1788446400	1.350393	1.350400	1.350046	1.350251
157415	BTC	300	1788446400	79691.975854	79856.754002	79612.550000	79727.983641
157416	SILVER	300	1788446400	67.129824	67.183728	67.004508	67.007070
98684	SILVER	180	1786870260	65.104443	65.117718	65.095640	65.102812
99272	SILVER	180	1786870620	65.118092	65.119283	65.097901	65.110619
99076	SILVER	300	1786870500	65.111958	65.119283	65.097901	65.110619
157609	GOLD	180	1788446520	4524.499908	4525.072099	4518.200000	4518.344788
157610	GBP	180	1788446520	1.350177	1.350347	1.350046	1.350251
101591	GBP	180	1786872060	1.353316	1.353458	1.353115	1.353257
100725	GOLD	180	1786871520	4437.035304	4437.950566	4436.857261	4437.564866
100534	GOLD	300	1786871400	4437.222859	4437.950566	4436.857261	4437.564866
100727	GBP	180	1786871520	1.353153	1.353422	1.353107	1.353296
100536	GBP	300	1786871400	1.353265	1.353422	1.353107	1.353296
157611	BTC	180	1788446520	79642.562863	79856.754002	79640.778548	79727.983641
157612	SILVER	180	1788446520	67.122574	67.183728	67.004508	67.007070
139337	GOLD	180	1788435180	4477.120168	4478.116813	4476.303482	4478.000783
100731	SILVER	180	1786871520	65.118717	65.119189	65.097868	65.099802
100540	SILVER	300	1786871400	65.111922	65.120532	65.097868	65.099802
99857	GOLD	180	1786870980	4437.402925	4437.736978	4436.772090	4436.945021
139338	GBP	180	1788435180	1.349055	1.349411	1.348968	1.349378
99858	GBP	180	1786870980	1.353223	1.353396	1.353155	1.353340
139339	BTC	180	1788435180	77888.303016	77929.802153	77867.146469	77871.816280
139340	SILVER	180	1788435180	66.309140	66.350779	66.303705	66.347150
99562	GOLD	300	1786870800	4437.602851	4438.022640	4436.553609	4437.574610
99564	GBP	300	1786870800	1.353381	1.353400	1.353167	1.353188
99860	SILVER	180	1786870980	65.106446	65.120311	65.097245	65.105047
150057	GOLD	180	1788441840	4532.491142	4534.976240	4530.600000	4530.895306
99568	SILVER	300	1786870800	65.108398	65.119102	65.097245	65.102396
150157	GOLD	300	1788441900	4534.368461	4534.976240	4526.700000	4527.056820
98973	GOLD	180	1786870440	4437.201516	4437.774687	4436.902689	4437.377355
98974	GBP	180	1786870440	1.353261	1.353453	1.353181	1.353384
150058	GBP	180	1788441840	1.351165	1.351270	1.351021	1.351126
150158	GBP	300	1788441900	1.351107	1.351270	1.350820	1.351116
98976	SILVER	180	1786870440	65.100247	65.119214	65.100247	65.116175
100153	GOLD	180	1786871160	4436.949980	4437.724693	4436.835183	4437.265441
101307	SILVER	180	1786871880	65.103945	65.116083	65.098227	65.116083
100154	GBP	180	1786871160	1.353310	1.353410	1.353083	1.353387
102165	GOLD	180	1786872420	4436.487412	4437.564736	4436.444559	4437.554948
100156	SILVER	180	1786871160	65.105253	65.113490	65.098209	65.107032
100437	GOLD	180	1786871340	4437.254516	4437.873827	4437.050543	4437.072341
99561	GOLD	180	1786870800	4437.602851	4438.022640	4436.553609	4437.462616
99563	GBP	180	1786870800	1.353381	1.353400	1.353167	1.353253
101013	GOLD	180	1786871700	4437.602549	4437.658882	4436.565873	4437.254297
99269	GOLD	180	1786870620	4437.482902	4437.879427	4436.975411	4437.483236
98681	GOLD	180	1786870260	4437.436768	4437.687971	4436.786150	4437.202198
98682	GBP	180	1786870260	1.353296	1.353372	1.353153	1.353292
150059	BTC	180	1788441840	78550.295941	78580.352368	78462.320927	78480.597028
99073	GOLD	300	1786870500	4437.213895	4437.879427	4436.902689	4437.483236
99270	GBP	180	1786870620	1.353403	1.353413	1.353098	1.353354
99074	GBP	300	1786870500	1.353306	1.353453	1.353098	1.353354
150159	BTC	300	1788441900	78560.943764	78569.922303	78443.250738	78470.167913
150060	SILVER	180	1788441840	67.100288	67.187963	67.070934	67.108411
98584	SILVER	300	1786870200	65.112795	65.117718	65.095640	65.110050
150160	SILVER	300	1788441900	67.179415	67.187963	66.970000	66.972421
99567	SILVER	180	1786870800	65.108398	65.119102	65.097427	65.104407
100439	GBP	180	1786871340	1.353358	1.353394	1.353163	1.353179
101014	GOLD	300	1786871700	4437.602549	4437.991706	4436.565873	4437.242629
100053	GOLD	300	1786871100	4437.664044	4437.795416	4436.772090	4437.226996
100054	GBP	300	1786871100	1.353155	1.353410	1.353083	1.353274
101015	GBP	180	1786871700	1.353313	1.353420	1.353209	1.353339
100443	SILVER	180	1786871340	65.104964	65.125710	65.101716	65.119665
100056	SILVER	300	1786871100	65.104374	65.125710	65.098209	65.111331
101016	GBP	300	1786871700	1.353313	1.353420	1.353183	1.353249
101019	SILVER	180	1786871700	65.097215	65.118071	65.097142	65.106274
101595	SILVER	180	1786872060	65.117405	65.120325	65.094733	65.118275
101020	SILVER	300	1786871700	65.097215	65.118071	65.097142	65.099108
101494	GOLD	300	1786872000	4437.318829	4437.920966	4436.860492	4437.368504
102171	SILVER	180	1786872420	65.109387	65.119790	65.100384	65.117194
101496	GBP	300	1786872000	1.353216	1.353458	1.353115	1.353189
101883	SILVER	180	1786872240	65.118139	65.121066	65.090965	65.107918
101980	SILVER	300	1786872300	65.101914	65.121066	65.090965	65.117194
101301	GOLD	180	1786871880	4437.155592	4437.991706	4436.877319	4437.458616
101589	GOLD	180	1786872060	4437.577615	4437.920966	4436.860492	4437.572355
101303	GBP	180	1786871880	1.353323	1.353450	1.353183	1.353298
101500	SILVER	300	1786872000	65.101274	65.120325	65.094733	65.099917
102167	GBP	180	1786872420	1.353214	1.353497	1.353107	1.353392
101879	GBP	180	1786872240	1.353272	1.353443	1.353135	1.353228
101877	GOLD	180	1786872240	4437.602722	4437.874193	4436.573017	4436.573017
102455	GBP	180	1786872600	1.353378	1.353473	1.353207	1.353247
101974	GOLD	300	1786872300	4437.456841	4437.874193	4436.444559	4437.554948
101976	GBP	300	1786872300	1.353165	1.353497	1.353107	1.353392
102456	GBP	300	1786872600	1.353378	1.353525	1.353156	1.353388
102459	SILVER	180	1786872600	65.117448	65.117448	65.094299	65.115648
102460	SILVER	300	1786872600	65.117448	65.117448	65.094299	65.107956
102453	GOLD	180	1786872600	4437.605122	4437.842128	4436.716893	4437.086324
102454	GOLD	300	1786872600	4437.605122	4437.842128	4436.716893	4437.409477
104089	GOLD	180	1786873860	4437.105535	4437.884645	4436.675529	4437.588852
105257	GOLD	180	1786874580	4436.717742	4437.635399	4436.717742	4436.767890
104090	GBP	180	1786873860	1.353476	1.353476	1.353185	1.353259
104092	SILVER	180	1786873860	65.106971	65.114553	65.096448	65.106864
104381	GOLD	180	1786874040	4437.504114	4437.949648	4436.849415	4437.050711
102741	GOLD	180	1786872780	4437.051299	4437.634176	4436.755693	4437.154385
103033	GOLD	180	1786872960	4437.266851	4438.053261	4436.662414	4438.053261
102743	GBP	180	1786872780	1.353215	1.353525	1.353156	1.353387
139526	GOLD	300	1788435300	4477.196275	4481.089773	4476.675670	4480.478174
103034	GBP	180	1786872960	1.353362	1.353445	1.353168	1.353302
102747	SILVER	180	1786872780	65.117332	65.117332	65.099155	65.115555
139528	GBP	300	1788435300	1.349344	1.349470	1.349001	1.349206
139621	GOLD	180	1788435360	4477.948701	4481.089773	4477.886626	4478.826102
139530	BTC	300	1788435300	77906.518055	77912.844484	77824.511593	77899.965247
103036	SILVER	180	1786872960	65.117772	65.117772	65.101710	65.112241
139623	GBP	180	1788435360	1.349348	1.349470	1.349001	1.349207
104975	SILVER	180	1786874400	65.118083	65.122899	65.096404	65.096404
104382	GBP	180	1786874040	1.353267	1.353446	1.353212	1.353233
103509	GOLD	180	1786873500	4437.300000	4437.929290	4436.757080	4437.221046
103511	GBP	180	1786873500	1.353290	1.353411	1.353101	1.353360
103510	GOLD	300	1786873500	4437.300000	4437.929290	4436.757080	4437.742681
139532	SILVER	300	1788435300	66.318595	66.404591	66.315238	66.386818
103515	SILVER	180	1786873500	65.108000	65.119867	65.101426	65.113927
103512	GBP	300	1786873500	1.353290	1.353411	1.353101	1.353171
104677	GOLD	180	1786874220	4437.102464	4437.639067	4436.823136	4437.269921
139625	BTC	180	1788435360	77871.809086	77909.077542	77824.511593	77860.393498
104384	SILVER	180	1786874040	65.107425	65.118683	65.096108	65.118683
103325	GOLD	180	1786873140	4437.940510	4437.940510	4437.004108	4437.004108
103326	GBP	180	1786873140	1.353305	1.353454	1.353142	1.353255
103516	SILVER	300	1786873500	65.108000	65.119867	65.098149	65.098149
103328	SILVER	180	1786873140	65.111677	65.117712	65.097610	65.109347
102933	GOLD	300	1786872900	4437.521100	4438.053261	4436.662414	4437.417170
139627	SILVER	180	1788435360	66.347676	66.404591	66.328905	66.334151
102934	GBP	300	1786872900	1.353402	1.353445	1.353168	1.353334
102936	SILVER	300	1786872900	65.108034	65.117772	65.097610	65.103473
104481	GOLD	300	1786874100	4437.302459	4437.949648	4436.823136	4437.269921
150354	GBP	180	1788442020	1.351136	1.351200	1.350820	1.351116
150652	SILVER	300	1788442200	66.974659	67.075000	66.957236	67.039255
104678	GBP	180	1786874220	1.353242	1.353479	1.353210	1.353450
103797	GOLD	180	1786873680	4437.289776	4437.748835	4436.906673	4437.205988
104482	GBP	300	1786874100	1.353253	1.353479	1.353210	1.353450
103799	GBP	180	1786873680	1.353353	1.353481	1.353144	1.353456
150355	BTC	180	1788442020	78482.179301	78505.775969	78443.250738	78470.167913
150356	SILVER	180	1788442020	67.108916	67.113387	66.970000	66.972421
103485	GOLD	180	1786873320	4437.300000	4437.401535	4436.895360	4436.969046
103425	GOLD	300	1786873200	4437.443219	4437.778584	4436.895360	4436.969046
103487	GBP	180	1786873320	1.353290	1.353290	1.353145	1.353145
103426	GBP	300	1786873200	1.353353	1.353454	1.353142	1.353145
103491	SILVER	180	1786873320	65.108000	65.110195	65.106243	65.108859
103428	SILVER	300	1786873200	65.103536	65.110195	65.101825	65.108859
150645	GOLD	180	1788442200	4527.011161	4531.528016	4525.911525	4529.329241
103803	SILVER	180	1786873680	65.111550	65.119230	65.098149	65.104617
104680	SILVER	180	1786874220	65.117402	65.120326	65.094493	65.117987
150353	GOLD	180	1788442020	4530.835867	4531.093620	4526.700000	4527.056820
104484	SILVER	300	1786874100	65.096108	65.120326	65.094493	65.117987
103989	GOLD	300	1786873800	4437.612909	4437.884645	4436.675529	4437.219830
103990	GBP	300	1786873800	1.353144	1.353481	1.353144	1.353246
104970	GOLD	300	1786874400	4437.342506	4438.363824	4436.717742	4437.077380
103992	SILVER	300	1786873800	65.099040	65.114553	65.096448	65.097003
104972	GBP	300	1786874400	1.353427	1.353427	1.353140	1.353281
150647	GBP	180	1788442200	1.351129	1.351152	1.350627	1.350782
150646	GOLD	300	1788442200	4527.011161	4531.528016	4525.911525	4530.193416
150649	BTC	180	1788442200	78467.343599	78630.519168	78425.628099	78555.167659
150648	GBP	300	1788442200	1.351129	1.351152	1.350627	1.350813
105545	GOLD	180	1786874760	4436.790978	4437.726925	4436.636799	4436.768069
150651	SILVER	180	1788442200	66.974659	67.075000	66.957236	67.007932
105259	GBP	180	1786874580	1.353348	1.353383	1.353140	1.353240
104969	GOLD	180	1786874400	4437.342506	4438.363824	4436.788672	4436.788672
104976	SILVER	300	1786874400	65.118083	65.122899	65.096404	65.106139
104971	GBP	180	1786874400	1.353427	1.353427	1.353177	1.353374
105551	SILVER	180	1786874760	65.105588	65.128360	65.097317	65.127603
105452	GBP	300	1786874700	1.353286	1.353436	1.353156	1.353328
105834	GBP	180	1786874940	1.353246	1.353396	1.353140	1.353236
150650	BTC	300	1788442200	78467.343599	78675.139834	78425.628099	78641.482342
105263	SILVER	180	1786874580	65.098864	65.119300	65.098864	65.107469
105547	GBP	180	1786874760	1.353257	1.353436	1.353156	1.353266
105934	GBP	300	1786875000	1.353350	1.353461	1.353140	1.353419
105450	GOLD	300	1786874700	4437.121704	4437.726925	4436.636799	4437.185103
105456	SILVER	300	1786874700	65.104211	65.128360	65.097317	65.102401
105836	SILVER	180	1786874940	65.127283	65.127283	65.098272	65.106004
105936	SILVER	300	1786875000	65.104962	65.120801	65.098272	65.103499
105833	GOLD	180	1786874940	4436.789404	4437.749277	4436.668007	4437.267446
105933	GOLD	300	1786875000	4437.199353	4437.802315	4436.668007	4437.713949
106129	GOLD	180	1786875120	4437.144629	4437.802315	4436.815342	4437.713949
106130	GBP	180	1786875120	1.353220	1.353461	1.353189	1.353419
157901	GOLD	180	1788446700	4518.250994	4519.558429	4515.301765	4516.994524
106132	SILVER	180	1786875120	65.105800	65.118014	65.098801	65.103499
157902	GOLD	300	1788446700	4518.250994	4519.927528	4515.301765	4516.949246
157903	GBP	180	1788446700	1.350246	1.350453	1.350195	1.350301
157904	GBP	300	1788446700	1.350246	1.350855	1.350195	1.350723
157905	BTC	180	1788446700	79724.998264	79987.440000	79716.858488	79976.081832
107305	GOLD	180	1786875840	4437.075166	4437.646706	4436.664249	4437.435917
107888	GBP	300	1786876200	1.353290	1.353441	1.353153	1.353207
107306	GBP	180	1786875840	1.353240	1.353468	1.353179	1.353341
108480	SILVER	180	1786876560	65.108000	65.118305	65.098883	65.106868
107308	SILVER	180	1786875840	65.101150	65.124947	65.094497	65.105907
139915	SILVER	180	1788435540	66.332186	66.396086	66.271342	66.313074
107013	GOLD	180	1786875660	4437.215111	4437.788010	4437.009963	4437.116320
107014	GBP	180	1786875660	1.353367	1.353499	1.353162	1.353260
150941	GOLD	180	1788442380	4529.313114	4531.220696	4526.300000	4526.335919
107016	SILVER	180	1786875660	65.105140	65.119096	65.090943	65.102355
107892	SILVER	300	1786876200	65.108000	65.117184	65.098281	65.103956
106422	GOLD	300	1786875300	4437.707370	4437.765506	4436.722688	4437.221980
106424	GBP	300	1786875300	1.353418	1.353481	1.353118	1.353367
107885	GOLD	180	1786876200	4437.300000	4437.623099	4436.682111	4436.721587
150942	GBP	180	1788442380	1.350798	1.350892	1.350619	1.350734
106428	SILVER	300	1786875300	65.102423	65.118994	65.097424	65.107281
139909	GOLD	180	1788435540	4478.898271	4481.231800	4476.144468	4477.519026
107887	GBP	180	1786876200	1.353290	1.353352	1.353153	1.353185
140200	SILVER	180	1788435720	66.314622	66.355350	66.290056	66.347055
107891	SILVER	180	1786876200	65.108000	65.117184	65.100473	65.113061
140197	GOLD	180	1788435720	4477.614285	4480.600000	4477.096562	4480.142112
139911	GBP	180	1788435540	1.349193	1.349393	1.349077	1.349093
106421	GOLD	180	1786875300	4437.707370	4437.765506	4436.752351	4437.346234
140198	GBP	180	1788435720	1.349111	1.349343	1.348929	1.349028
106423	GBP	180	1786875300	1.353418	1.353481	1.353118	1.353309
139913	BTC	180	1788435540	77861.070295	77940.283795	77858.093217	77933.663214
106427	SILVER	180	1786875300	65.102423	65.118009	65.099070	65.117213
109068	SILVER	180	1786876920	65.108644	65.112714	65.096541	65.109790
107593	GOLD	180	1786876020	4437.516990	4437.880146	4436.495317	4437.637086
107397	GOLD	300	1786875900	4436.943148	4437.880146	4436.495317	4437.637086
106913	GOLD	300	1786875600	4437.147184	4437.788010	4436.664249	4436.922502
106717	GOLD	180	1786875480	4437.412591	4437.542758	4436.722688	4437.157686
107594	GBP	180	1786876020	1.353358	1.353450	1.353168	1.353207
106718	GBP	180	1786875480	1.353300	1.353424	1.353184	1.353366
106914	GBP	300	1786875600	1.353391	1.353499	1.353162	1.353326
107398	GBP	300	1786875900	1.353338	1.353468	1.353168	1.353207
106720	SILVER	180	1786875480	65.118994	65.118994	65.097424	65.105469
140012	SILVER	300	1788435600	66.386177	66.396086	66.271342	66.347055
106916	SILVER	300	1786875600	65.105276	65.119096	65.090943	65.116489
140008	GBP	300	1788435600	1.349192	1.349393	1.348929	1.349028
107596	SILVER	180	1786876020	65.106479	65.116394	65.093950	65.107965
107400	SILVER	300	1786875900	65.118930	65.124947	65.093950	65.107965
140006	GOLD	300	1788435600	4480.549406	4481.231800	4476.144468	4480.142112
140199	BTC	180	1788435720	77929.920894	77958.949212	77884.141620	77884.141620
108872	SILVER	300	1786876800	65.111281	65.115327	65.096541	65.109790
108377	GOLD	300	1786876500	4437.300000	4438.022248	4436.675038	4437.441623
108378	GBP	300	1786876500	1.353290	1.353454	1.353141	1.353268
140010	BTC	300	1788435600	77902.067829	77958.949212	77884.141620	77884.141620
108380	SILVER	300	1786876500	65.108000	65.118305	65.097640	65.113426
108181	GOLD	180	1786876380	4437.300000	4437.773653	4436.675038	4437.405508
108182	GBP	180	1786876380	1.353290	1.353454	1.353141	1.353300
108184	SILVER	180	1786876380	65.108000	65.117675	65.097640	65.113224
150943	BTC	180	1788442380	78552.806062	78675.139834	78550.730283	78651.078024
109363	SILVER	180	1786877100	65.109458	65.119478	65.096241	65.112242
107886	GOLD	300	1786876200	4437.300000	4437.773653	4436.682111	4436.991365
150944	SILVER	180	1788442380	67.009064	67.060633	66.978573	66.979117
109654	GBP	180	1786877280	1.353251	1.353475	1.353194	1.353257
109360	GBP	300	1786877100	1.353191	1.353475	1.353159	1.353395
108477	GOLD	180	1786876560	4437.300000	4438.022248	4436.919427	4437.134740
108769	GOLD	180	1786876740	4437.300000	4437.764640	4436.752584	4437.399865
108478	GBP	180	1786876560	1.353290	1.353420	1.353170	1.353215
109065	GOLD	180	1786876920	4437.438271	4438.067230	4436.863607	4437.425480
108770	GBP	180	1786876740	1.353290	1.353389	1.353196	1.353284
110242	GBP	180	1786877640	1.353284	1.353461	1.353184	1.353278
108869	GOLD	300	1786876800	4437.390888	4438.067230	4436.752584	4437.425480
109066	GBP	180	1786876920	1.353283	1.353460	1.353144	1.353182
108870	GBP	300	1786876800	1.353243	1.353460	1.353144	1.353182
108772	SILVER	180	1786876740	65.108000	65.116735	65.099345	65.109949
109357	GOLD	180	1786877100	4437.448285	4437.886379	4436.682058	4437.057984
109359	GBP	180	1786877100	1.353191	1.353431	1.353159	1.353229
109653	GOLD	180	1786877280	4436.976913	4438.003429	4436.598312	4437.129207
110244	SILVER	180	1786877640	65.101570	65.112970	65.092938	65.112550
157906	BTC	300	1788446700	79724.998264	80480.972722	79716.858488	80456.808530
157907	SILVER	180	1788446700	67.008841	67.025258	66.945603	66.971539
109364	SILVER	300	1786877100	65.109458	65.119478	65.096241	65.109145
157908	SILVER	300	1788446700	67.008841	67.058672	66.945603	67.015448
109656	SILVER	180	1786877280	65.114317	65.118044	65.098997	65.118044
109849	GOLD	300	1786877400	4437.078936	4438.095743	4436.777577	4437.297476
109358	GOLD	300	1786877100	4437.448285	4437.886379	4436.598312	4436.947068
109949	GOLD	180	1786877460	4437.106848	4438.095743	4436.777577	4437.532104
109950	GBP	180	1786877460	1.353240	1.353410	1.353118	1.353281
109952	SILVER	180	1786877460	65.117922	65.117922	65.097739	65.100940
109850	GBP	300	1786877400	1.353389	1.353461	1.353118	1.353190
109852	SILVER	300	1786877400	65.110675	65.118044	65.097739	65.109400
110241	GOLD	180	1786877640	4437.491533	4437.821743	4437.042635	4437.654736
110341	GOLD	300	1786877700	4437.398495	4437.821743	4436.904042	4437.524477
110836	SILVER	300	1786878000	65.103693	65.118180	65.095304	65.110552
112673	GOLD	180	1787015340	4487.655139	4492.508247	4487.532787	4488.800000
110829	GOLD	180	1786878000	4437.483384	4438.127986	4436.786772	4437.156046
110537	GOLD	180	1786877820	4437.710209	4437.724418	4436.904042	4437.524477
110538	GBP	180	1786877820	1.353291	1.353435	1.353173	1.353267
110342	GBP	300	1786877700	1.353196	1.353435	1.353173	1.353267
110540	SILVER	180	1786877820	65.112909	65.117379	65.101864	65.104690
110344	SILVER	300	1786877700	65.110801	65.117379	65.092938	65.104690
110831	GBP	180	1786878000	1.353262	1.353417	1.353179	1.353320
110835	SILVER	180	1786878000	65.103693	65.118180	65.095304	65.100430
111310	GOLD	300	1786878300	4437.634361	4438.032009	4436.679587	4437.501066
140489	GOLD	180	1788435900	4480.022735	4482.609935	4479.347201	4481.007519
111312	GBP	300	1786878300	1.353277	1.353434	1.353175	1.353347
151137	GOLD	300	1788442500	4530.314281	4531.220696	4524.439064	4527.799719
112290	GOLD	300	1787015100	4486.063866	4491.700000	4484.956845	4491.700000
111316	SILVER	300	1786878300	65.109248	65.117783	65.095183	65.101841
112965	GOLD	180	1787015520	4488.848856	4491.969536	4488.600000	4488.600000
112292	GBP	300	1787015100	1.354939	1.355185	1.354854	1.355179
112675	GBP	180	1787015340	1.355089	1.355361	1.355023	1.355234
140491	GBP	180	1788435900	1.349023	1.349348	1.348876	1.349099
151138	GBP	300	1788442500	1.350817	1.350920	1.350578	1.350641
111405	GOLD	180	1786878360	4438.032009	4438.032009	4436.679587	4437.884878
111407	GBP	180	1786878360	1.353330	1.353434	1.353175	1.353277
112050	GOLD	300	1787014800	4486.600000	4487.214713	4485.078102	4486.100075
140493	BTC	180	1788435900	77883.409977	77967.328322	77882.638315	77931.806418
112769	GOLD	300	1787015400	4491.757533	4492.508247	4488.008035	4488.600000
111117	GOLD	180	1786878180	4437.050618	4437.913548	4436.755647	4437.907281
111411	SILVER	180	1786878360	65.114849	65.117783	65.095183	65.106035
111119	GBP	180	1786878180	1.353301	1.353410	1.353094	1.353315
112052	GBP	300	1787014800	1.355050	1.355159	1.354901	1.354910
140490	GOLD	300	1788435900	4480.022735	4482.871681	4479.347201	4481.961778
111123	SILVER	180	1786878180	65.101258	65.117550	65.101258	65.114520
112296	SILVER	300	1787015100	66.374224	66.593987	66.361652	66.560000
140492	GBP	300	1788435900	1.349023	1.349348	1.348876	1.349215
140494	BTC	300	1788435900	77883.409977	77967.328322	77837.439020	77860.761303
140496	SILVER	300	1788435900	66.348758	66.377672	66.293977	66.331477
111981	GOLD	180	1786878720	4437.300000	4437.589251	4437.188621	4437.534446
111790	GOLD	300	1786878600	4437.430394	4437.589251	4436.871693	4437.534446
111982	GBP	180	1786878720	1.353290	1.353344	1.353211	1.353295
111792	GBP	300	1786878600	1.353323	1.353392	1.353159	1.353295
151238	GBP	180	1788442560	1.350761	1.350920	1.350578	1.350789
151239	BTC	180	1788442560	78649.949534	78754.047911	78514.017110	78745.522511
151240	SILVER	180	1788442560	66.976987	67.017152	66.937671	67.008294
111984	SILVER	180	1786878720	65.108000	65.119570	65.098992	65.107559
111796	SILVER	300	1786878600	65.103949	65.119570	65.097234	65.107559
140495	SILVER	180	1788435900	66.348758	66.377063	66.305614	66.338982
110830	GOLD	300	1786878000	4437.483384	4438.127986	4436.755647	4437.511815
112385	GOLD	180	1787015160	4487.259731	4488.396118	4484.956845	4487.700111
110832	GBP	300	1786878000	1.353262	1.353417	1.353094	1.353295
112056	SILVER	300	1787014800	66.370000	66.396650	66.356851	66.375416
151237	GOLD	180	1788442560	4526.257032	4527.550959	4524.439064	4527.330267
112049	GOLD	180	1787014800	4486.600000	4486.693514	4486.112399	4486.518999
112051	GBP	180	1787014800	1.355050	1.355159	1.355017	1.355017
112387	GBP	180	1787015160	1.355000	1.355177	1.354922	1.355117
112055	SILVER	180	1787014800	66.370000	66.372824	66.363315	66.369651
111693	GOLD	180	1786878540	4437.759621	4437.759621	4436.719408	4437.301995
151139	BTC	300	1788442500	78645.400970	78824.995974	78514.017110	78815.312252
112097	GOLD	180	1787014980	4486.617850	4487.427541	4485.078102	4487.211235
111695	GBP	180	1786878540	1.353301	1.353416	1.353159	1.353303
112099	GBP	180	1787014980	1.355036	1.355157	1.354854	1.355026
112391	SILVER	180	1787015160	66.410155	66.480000	66.399791	66.479335
111699	SILVER	180	1786878540	65.103808	65.117368	65.097234	65.103196
112103	SILVER	180	1787014980	66.369767	66.419571	66.356851	66.408090
112966	GBP	180	1787015520	1.355205	1.355457	1.355165	1.355307
112679	SILVER	180	1787015340	66.480941	66.593987	66.434551	66.440000
112770	GBP	300	1787015400	1.355150	1.355457	1.355093	1.355307
151140	SILVER	300	1788442500	67.039160	67.052163	66.937671	67.046693
158198	GBP	180	1788446880	1.350303	1.350931	1.350231	1.350735
112968	SILVER	180	1787015520	66.440140	66.635101	66.439337	66.630000
112772	SILVER	300	1787015400	66.562241	66.635101	66.434551	66.630000
113749	GOLD	300	1787016000	4487.064449	4487.977311	4484.805062	4485.500000
113264	SILVER	300	1787015700	66.629141	66.646944	66.446888	66.503580
158394	GBP	300	1788447000	1.350754	1.351703	1.350623	1.351612
158199	BTC	180	1788446880	79973.421996	80480.972722	79962.054908	80268.656742
113257	GOLD	180	1787015700	4488.704595	4493.085771	4486.900000	4489.100000
113259	GBP	180	1787015700	1.355277	1.355419	1.354918	1.355050
158200	SILVER	180	1788446880	66.969634	67.058672	66.932067	66.932067
158197	GOLD	180	1788446880	4517.070323	4519.927528	4513.523536	4513.523536
113752	SILVER	300	1787016000	66.505876	66.602288	66.472392	66.585000
113263	SILVER	180	1787015700	66.629141	66.646944	66.501828	66.570000
113554	GBP	180	1787015880	1.355067	1.355119	1.354859	1.354955
113258	GOLD	300	1787015700	4488.704595	4493.085771	4485.526185	4487.052466
113260	GBP	300	1787015700	1.355277	1.355419	1.354859	1.354947
113553	GOLD	180	1787015880	4489.089247	4489.692139	4485.526185	4486.966408
113556	SILVER	180	1787015880	66.568957	66.573860	66.446888	66.475115
113750	GBP	300	1787016000	1.354952	1.355091	1.354642	1.354940
158395	BTC	300	1788447000	80459.294531	80460.890231	80103.528642	80215.428074
113849	GOLD	180	1787016060	4487.016656	4487.977311	4485.200000	4485.262301
113850	GBP	180	1787016060	1.354963	1.355049	1.354642	1.354902
120529	GOLD	180	1787020200	4460.814219	4460.986337	4458.315675	4458.470242
158393	GOLD	300	1788447000	4516.833807	4521.846773	4513.243078	4519.337028
114236	SILVER	300	1787016300	66.583858	66.654887	66.386157	66.476608
114136	SILVER	180	1787016240	66.569657	66.654887	66.485000	66.485000
140788	SILVER	180	1788436080	66.338584	66.377672	66.293977	66.369495
117341	GOLD	180	1787018220	4466.774503	4467.402878	4461.351203	4464.749206
116186	GOLD	300	1787017500	4478.621590	4480.460584	4477.000000	4477.376377
115597	GOLD	180	1787017140	4481.525656	4482.735195	4480.644268	4481.573535
115598	GBP	180	1787017140	1.355258	1.355291	1.355015	1.355162
116188	GBP	300	1787017500	1.355002	1.355044	1.354489	1.354651
140984	SILVER	300	1788436200	66.333280	66.403020	66.308723	66.385765
116765	GOLD	180	1787017860	4477.622628	4477.698650	4472.018344	4473.285382
115600	SILVER	180	1787017140	66.590725	66.593357	66.496701	66.539178
117053	GOLD	180	1787018040	4473.416662	4473.416662	4466.526613	4466.709315
116192	SILVER	300	1787017500	66.432060	66.531443	66.421085	66.425594
115305	GOLD	180	1787016960	4477.010620	4482.266328	4476.929752	4481.627051
116767	GBP	180	1787017860	1.354843	1.354974	1.354621	1.354974
115306	GBP	180	1787016960	1.354990	1.355343	1.354970	1.355284
115308	SILVER	180	1787016960	66.354201	66.595463	66.354201	66.593135
114713	GOLD	180	1787016600	4481.968814	4482.704336	4478.900000	4479.715035
114715	GBP	180	1787016600	1.354990	1.354990	1.354705	1.354815
115009	GOLD	180	1787016780	4479.631998	4481.166529	4477.049333	4477.119470
115205	GOLD	300	1787016900	4480.329102	4482.521683	4476.929752	4482.322014
114719	SILVER	180	1787016600	66.478593	66.517776	66.384431	66.413479
115010	GBP	180	1787016780	1.354841	1.355261	1.354841	1.354994
151815	SILVER	180	1788442920	66.955820	67.040000	66.885983	66.888621
151523	GBP	180	1788442740	1.350801	1.350885	1.350294	1.350615
115206	GBP	300	1787016900	1.355119	1.355343	1.354970	1.355237
115012	SILVER	180	1787016780	66.412874	66.456070	66.353926	66.354140
117636	SILVER	300	1787018400	65.682672	65.720779	65.563596	65.691102
140981	GOLD	300	1788436200	4482.026002	4485.503123	4481.322714	4484.155542
113852	SILVER	180	1787016060	66.475331	66.602288	66.472392	66.569872
140785	GOLD	180	1788436080	4480.911667	4484.098345	4480.535027	4483.419202
140786	GBP	180	1788436080	1.349122	1.349484	1.348998	1.349484
115208	SILVER	300	1787016900	66.439087	66.595463	66.353926	66.550762
114714	GOLD	300	1787016600	4481.968814	4482.704336	4478.758024	4480.296174
114716	GBP	300	1787016600	1.354990	1.355261	1.354705	1.355111
151525	BTC	180	1788442740	78745.786493	78867.386374	78745.786493	78847.157499
140982	GBP	300	1788436200	1.349215	1.349589	1.349140	1.349332
114429	GOLD	180	1787016420	4482.971579	4483.428859	4479.159263	4481.835365
114233	GOLD	300	1787016300	4485.565550	4487.488917	4479.159263	4481.835365
114133	GOLD	180	1787016240	4485.324930	4487.488917	4483.100000	4483.100000
114430	GBP	180	1787016420	1.354725	1.354991	1.354646	1.354991
114134	GBP	180	1787016240	1.354895	1.355071	1.354648	1.354720
116481	GOLD	180	1787017680	4480.419563	4480.419563	4477.000000	4477.520134
116185	GOLD	180	1787017500	4478.621590	4480.460584	4478.157953	4480.460584
116771	SILVER	180	1787017860	66.456789	66.475862	66.296445	66.297171
114234	GBP	300	1787016300	1.354938	1.355034	1.354646	1.354991
140983	BTC	300	1788436200	77864.852791	77920.604628	77853.091099	77883.952865
140787	BTC	180	1788436080	77931.505083	77933.361181	77837.439020	77888.561521
114432	SILVER	180	1787016420	66.485724	66.558217	66.386157	66.476608
116187	GBP	180	1787017500	1.355002	1.355044	1.354627	1.354896
116482	GBP	180	1787017680	1.354873	1.354883	1.354489	1.354829
116670	GOLD	300	1787017800	4477.340725	4477.829499	4470.214863	4470.309114
151527	SILVER	180	1788442740	67.006789	67.083764	66.952759	66.953803
114720	SILVER	300	1787016600	66.478593	66.517776	66.384431	66.441284
115893	GOLD	180	1787017320	4481.542252	4481.698878	4477.832629	4478.507776
115697	GOLD	300	1787017200	4482.279879	4482.735195	4477.832629	4478.507776
115894	GBP	180	1787017320	1.355140	1.355164	1.354825	1.355003
115698	GBP	300	1787017200	1.355215	1.355276	1.354825	1.355003
151624	SILVER	300	1788442800	67.046416	67.083764	66.885983	66.888621
115896	SILVER	180	1787017320	66.540614	66.541769	66.428637	66.432927
115700	SILVER	300	1787017200	66.550755	66.560000	66.428637	66.432927
117917	GOLD	180	1787018580	4465.165772	4465.320044	4460.923698	4464.594659
151521	GOLD	180	1788442740	4527.413852	4528.150124	4522.377406	4522.377406
116484	SILVER	180	1787017680	66.520459	66.530168	66.425594	66.454348
116672	GBP	300	1787017800	1.354663	1.354974	1.354621	1.354830
116191	SILVER	180	1787017500	66.432060	66.531443	66.421085	66.521896
151809	GOLD	180	1788442920	4522.341076	4529.600000	4522.341076	4525.081520
151811	GBP	180	1788442920	1.350582	1.351083	1.350502	1.350988
151813	BTC	180	1788442920	78850.928070	78907.724486	78800.455472	78895.732350
117629	GOLD	180	1787018400	4464.667950	4465.196411	4461.718303	4465.057158
116676	SILVER	300	1787017800	66.426383	66.475862	66.205000	66.209760
117055	GBP	180	1787018040	1.354940	1.354958	1.354738	1.354818
151618	GOLD	300	1788442800	4527.793983	4529.600000	4522.341076	4525.081520
117347	SILVER	180	1787018220	65.954156	65.954156	65.572287	65.683993
117059	SILVER	180	1787018040	66.295986	66.297557	65.948025	65.951817
151620	GBP	300	1788442800	1.350618	1.351083	1.350294	1.350988
117150	GOLD	300	1787018100	4470.425288	4470.624892	4461.351203	4464.749206
117156	SILVER	300	1787018100	66.207653	66.207653	65.572287	65.683993
117919	GBP	180	1787018580	1.354646	1.354694	1.354408	1.354579
117343	GBP	180	1787018220	1.354796	1.354892	1.354536	1.354570
117152	GBP	300	1787018100	1.354837	1.354957	1.354536	1.354570
151622	BTC	300	1788442800	78819.878513	78907.724486	78746.818958	78895.732350
117631	GBP	180	1787018400	1.354541	1.354802	1.354455	1.354638
158396	SILVER	300	1788447000	67.017821	67.020739	66.903009	66.988165
117635	SILVER	180	1787018400	65.682672	65.720779	65.579297	65.712234
117630	GOLD	300	1787018400	4464.667950	4465.320044	4460.923698	4464.401178
117632	GBP	300	1787018400	1.354541	1.354802	1.354408	1.354494
118116	SILVER	300	1787018700	65.690553	65.766877	65.685571	65.759106
120530	GOLD	300	1787020200	4460.814219	4460.986337	4458.315675	4460.339701
121387	SILVER	180	1787020740	65.566385	65.571401	65.424579	65.479791
119549	GOLD	300	1787019600	4456.797042	4459.000000	4455.021965	4457.425281
119069	GOLD	180	1787019300	4458.115841	4460.086049	4457.416124	4458.850214
119550	GBP	300	1787019600	1.354387	1.354597	1.354266	1.354362
119071	GBP	180	1787019300	1.354321	1.354518	1.354292	1.354307
118781	GOLD	180	1787019120	4461.182401	4461.306624	4457.790829	4458.191179
118590	GOLD	300	1787019000	4464.860427	4464.974161	4457.790829	4458.191179
118783	GBP	180	1787019120	1.354383	1.354602	1.354305	1.354345
118592	GBP	300	1787019000	1.354610	1.354699	1.354305	1.354345
152101	BTC	180	1788443100	78900.451643	78997.286014	78837.897396	78840.751812
152098	GOLD	300	1788443100	4525.003919	4527.310851	4520.301792	4522.304296
118787	SILVER	180	1787019120	65.633217	65.650520	65.560000	65.572573
152103	SILVER	180	1788443100	66.888463	66.957419	66.836700	66.873928
118596	SILVER	300	1787019000	65.757312	65.760768	65.560000	65.572573
152100	GBP	300	1788443100	1.351017	1.351221	1.350434	1.350553
141081	GOLD	180	1788436260	4483.372654	4485.464665	4482.999097	4485.258520
141082	GBP	180	1788436260	1.349466	1.349589	1.349140	1.349350
119075	SILVER	180	1787019300	65.572868	65.636352	65.506220	65.573314
121093	GOLD	180	1787020560	4461.223298	4461.639071	4459.000000	4459.084380
119552	SILVER	300	1787019600	65.544615	65.605448	65.510000	65.552983
141083	BTC	180	1788436260	77885.145362	77920.604628	77855.710273	77889.029251
141084	SILVER	180	1788436260	66.366991	66.399230	66.335000	66.399230
120237	GOLD	180	1787020020	4458.813092	4461.339678	4458.135029	4460.712048
118205	GOLD	180	1787018760	4464.663215	4465.717966	4464.252344	4464.574781
120041	GOLD	300	1787019900	4457.370310	4461.339678	4456.504197	4460.712048
118207	GBP	180	1787018760	1.354602	1.354819	1.354512	1.354714
120238	GBP	180	1787020020	1.354230	1.354411	1.354126	1.354145
158493	GOLD	180	1788447060	4513.398049	4520.200000	4513.243078	4519.559896
120042	GBP	300	1787019900	1.354335	1.354411	1.354126	1.354145
118211	SILVER	180	1787018760	65.725663	65.766877	65.703040	65.762665
158494	GBP	180	1788447060	1.350763	1.351678	1.350723	1.351442
158495	BTC	180	1788447060	80269.567629	80271.070000	80103.528642	80213.600860
118493	GOLD	180	1787018940	4464.461758	4465.044892	4461.198747	4461.198747
158496	SILVER	180	1788447060	66.932210	67.004050	66.903009	66.990997
120240	SILVER	180	1787020020	65.575867	65.651232	65.542840	65.634541
118495	GBP	180	1787018940	1.354725	1.354770	1.354376	1.354376
119649	GOLD	180	1787019660	4457.029509	4458.048296	4455.021965	4457.093979
120044	SILVER	300	1787019900	65.551004	65.651232	65.542065	65.634541
118499	SILVER	180	1787018940	65.763595	65.765992	65.630385	65.631340
119650	GBP	180	1787019660	1.354358	1.354484	1.354266	1.354372
119652	SILVER	180	1787019660	65.555971	65.588135	65.533367	65.550539
117923	SILVER	180	1787018580	65.709705	65.753274	65.563596	65.726660
119941	GOLD	180	1787019840	4457.051757	4459.368868	4456.504197	4458.852908
118110	GOLD	300	1787018700	4464.354965	4465.717966	4464.004677	4464.754516
119942	GBP	180	1787019840	1.354402	1.354504	1.354142	1.354206
119357	GOLD	180	1787019480	4458.942486	4458.942486	4455.668593	4456.943324
118112	GBP	300	1787018700	1.354463	1.354819	1.354463	1.354644
119070	GOLD	300	1787019300	4458.115841	4460.086049	4455.668593	4456.677375
119072	GBP	300	1787019300	1.354321	1.354591	1.354292	1.354400
119359	GBP	180	1787019480	1.354334	1.354597	1.354324	1.354367
152097	GOLD	180	1788443100	4525.003919	4527.310851	4520.301792	4522.255502
119076	SILVER	300	1787019300	65.572868	65.636352	65.506220	65.545951
152102	BTC	300	1788443100	78900.451643	78997.286014	78777.501182	78814.527846
152099	GBP	180	1788443100	1.351017	1.351221	1.350660	1.350805
120809	GOLD	180	1787020380	4458.558221	4461.267999	4458.558221	4461.267999
119944	SILVER	180	1787019840	65.552880	65.605448	65.542065	65.575092
152104	SILVER	300	1788443100	66.888463	66.957419	66.830000	66.881764
119363	SILVER	180	1787019480	65.574740	65.574740	65.510000	65.558112
121095	GBP	180	1787020560	1.354174	1.354331	1.354052	1.354251
120531	GBP	180	1787020200	1.354148	1.354457	1.353910	1.354254
120535	SILVER	180	1787020200	65.636414	65.642404	65.541627	65.558421
120810	GBP	180	1787020380	1.354284	1.354418	1.354091	1.354201
158785	GOLD	180	1788447240	4519.558202	4522.454405	4519.041516	4522.415935
121484	SILVER	300	1787020800	65.565451	65.566720	65.409585	65.458120
121004	SILVER	300	1787020500	65.620965	65.630051	65.556813	65.565785
120812	SILVER	180	1787020380	65.557333	65.630051	65.555707	65.615391
121671	GBP	180	1787020920	1.354213	1.354404	1.354114	1.354253
121383	GBP	180	1787020740	1.354225	1.354327	1.354027	1.354208
121099	SILVER	180	1787020560	65.612811	65.628662	65.565000	65.567216
158786	GBP	180	1788447240	1.351459	1.351802	1.351352	1.351771
158787	BTC	180	1788447240	80214.526482	80281.619808	80193.133342	80274.325345
158788	SILVER	180	1788447240	66.991459	67.074029	66.980124	67.074029
120998	GOLD	300	1787020500	4460.286411	4461.639071	4458.794524	4459.363574
121669	GOLD	180	1787020920	4457.027005	4457.862999	4452.506938	4452.635277
121000	GBP	300	1787020500	1.354258	1.354331	1.354052	1.354179
121381	GOLD	180	1787020740	4459.018170	4459.878909	4455.872483	4457.023847
121675	SILVER	180	1787020920	65.480910	65.549542	65.409585	65.458120
121959	GBP	180	1787021100	1.354235	1.354343	1.354140	1.354312
121478	GOLD	300	1787020800	4459.314376	4459.384960	4452.506938	4452.635277
121480	GBP	300	1787020800	1.354205	1.354404	1.354027	1.354253
121958	GOLD	300	1787021100	4452.590833	4455.846946	4451.965593	4453.210465
121960	GBP	300	1787021100	1.354235	1.354492	1.354140	1.354452
121963	SILVER	180	1787021100	65.458987	65.463772	65.396859	65.428167
121964	SILVER	300	1787021100	65.458987	65.491761	65.385000	65.387502
121957	GOLD	180	1787021100	4452.590833	4455.327089	4451.965593	4455.327089
125253	GOLD	180	1787038920	4457.919476	4458.020879	4451.867425	4452.010923
123428	SILVER	300	1787022000	65.453554	65.480000	65.391131	65.407611
123129	GOLD	180	1787021820	4451.765928	4454.658071	4450.054386	4452.979413
122933	GOLD	300	1787021700	4451.258551	4454.658071	4450.054386	4452.979413
123130	GBP	180	1787021820	1.354567	1.354762	1.354462	1.354634
122934	GBP	300	1787021700	1.354577	1.354762	1.354422	1.354634
152385	GOLD	180	1788443280	4522.203474	4523.062382	4517.887938	4517.925786
123132	SILVER	180	1787021820	65.345082	65.494049	65.339816	65.455664
122936	SILVER	300	1787021700	65.348267	65.494049	65.301237	65.455664
122833	GOLD	180	1787021640	4450.669779	4451.700000	4450.058562	4451.673331
122441	GOLD	300	1787021400	4453.085247	4453.354114	4450.058562	4451.132917
159084	SILVER	180	1788447420	67.074511	67.184321	67.056813	67.105825
122442	GBP	300	1787021400	1.354450	1.354625	1.354323	1.354573
122834	GBP	180	1787021640	1.354483	1.354692	1.354422	1.354575
152578	GOLD	300	1788443400	4522.221408	4522.616975	4515.197692	4517.678354
122444	SILVER	300	1787021400	65.387302	65.387302	65.316145	65.349292
152391	SILVER	180	1788443280	66.874399	66.908530	66.828141	66.840868
141365	GOLD	180	1788436440	4485.182533	4486.400000	4483.929941	4484.965273
141367	GBP	180	1788436440	1.349319	1.349505	1.349215	1.349437
122836	SILVER	180	1787021640	65.346722	65.366473	65.301237	65.347667
141369	BTC	180	1788436440	77886.710553	77928.012969	77853.265137	77904.511691
141371	SILVER	180	1788436440	66.400605	66.403020	66.352824	66.372354
123717	GOLD	180	1787022180	4454.267734	4455.600000	4452.985426	4455.474307
123718	GBP	180	1787022180	1.354470	1.354565	1.354129	1.354322
123720	SILVER	180	1787022180	65.477097	65.477097	65.391131	65.448227
152387	GBP	180	1788443280	1.350789	1.350843	1.350320	1.350437
125256	SILVER	180	1787038920	65.321784	65.330142	65.185649	65.188821
125057	GOLD	300	1787038800	4458.887335	4459.730565	4451.867425	4452.010923
124957	GOLD	180	1787038740	4458.213179	4459.730565	4457.332482	4458.016207
123913	GOLD	300	1787022300	4454.247570	4456.542066	4453.755813	4456.526052
124960	SILVER	180	1787038740	65.378996	65.405026	65.313687	65.322629
123914	GBP	300	1787022300	1.354507	1.354551	1.354148	1.354303
122245	GOLD	180	1787021280	4455.365862	4455.846946	4450.778438	4450.778438
122541	GOLD	180	1787021460	4450.845158	4451.647007	4450.441156	4450.720443
122246	GBP	180	1787021280	1.354281	1.354625	1.354209	1.354529
124678	GOLD	300	1787038500	4458.000000	4459.046266	4456.570931	4458.842842
152580	GBP	300	1788443400	1.350568	1.351178	1.350320	1.351045
122542	GBP	180	1787021460	1.354521	1.354600	1.354323	1.354479
122248	SILVER	180	1787021280	65.427736	65.491761	65.353901	65.370574
158888	SILVER	300	1788447300	66.988342	67.184321	66.980124	67.105825
159081	GOLD	180	1788447420	4522.515537	4526.000000	4520.498036	4520.658763
125060	SILVER	300	1787038800	65.391153	65.394638	65.185649	65.188821
123916	SILVER	300	1787022300	65.405269	65.491993	65.402494	65.486614
124013	GOLD	180	1787022360	4455.577437	4456.542066	4453.804970	4456.030040
124014	GBP	180	1787022360	1.354315	1.354417	1.354148	1.354312
159082	GBP	180	1788447420	1.351760	1.352206	1.351596	1.351845
159083	BTC	180	1788447420	80272.080310	80510.765194	80255.178482	80510.255977
122544	SILVER	180	1787021460	65.372065	65.374638	65.316145	65.344395
123421	GOLD	180	1787022000	4453.072968	4454.300000	4452.116315	4454.194701
123423	GBP	180	1787022000	1.354615	1.354742	1.354433	1.354454
124016	SILVER	180	1787022360	65.448809	65.489653	65.421789	65.476491
124677	GOLD	180	1787038560	4458.000000	4458.697503	4456.570931	4458.136180
124601	GOLD	180	1787022720	4459.524130	4460.482808	4459.320811	4460.462459
124405	GOLD	300	1787022600	4456.598988	4460.482808	4456.558026	4460.462459
124602	GBP	180	1787022720	1.354321	1.354346	1.354201	1.354329
124406	GBP	300	1787022600	1.354313	1.354410	1.354200	1.354329
152389	BTC	180	1788443280	78837.891557	78936.769854	78777.501182	78929.611848
152582	BTC	300	1788443400	78818.837424	78947.106371	78749.013691	78762.728919
124958	GBP	180	1787038740	1.352814	1.353200	1.352814	1.353067
123427	SILVER	180	1787022000	65.453554	65.480000	65.396394	65.477530
124305	GOLD	180	1787022540	4456.041313	4459.676163	4455.920643	4459.562481
152584	SILVER	300	1788443400	66.881666	66.882029	66.736077	66.819815
123422	GOLD	300	1787022000	4453.072968	4454.903741	4452.116315	4454.331055
124679	GBP	180	1787038560	1.352722	1.352814	1.352544	1.352814
123424	GBP	300	1787022000	1.354615	1.354742	1.354129	1.354489
124306	GBP	180	1787022540	1.354328	1.354410	1.354185	1.354291
124604	SILVER	180	1787022720	65.568531	65.584953	65.564398	65.577405
124308	SILVER	180	1787022540	65.476748	65.573840	65.468807	65.566660
124408	SILVER	300	1787022600	65.484810	65.584953	65.472361	65.577405
124683	SILVER	180	1787038560	65.390000	65.398214	65.326208	65.378717
125254	GBP	180	1787038920	1.353046	1.353156	1.352711	1.352750
124680	GBP	300	1787038500	1.352722	1.353089	1.352544	1.353004
124684	SILVER	300	1787038500	65.390000	65.405026	65.326208	65.389647
125058	GBP	300	1787038800	1.352982	1.353200	1.352711	1.352750
158885	GOLD	300	1788447300	4519.302327	4526.000000	4519.041516	4520.658763
158886	GBP	300	1788447300	1.351607	1.352206	1.351596	1.351845
158887	BTC	300	1788447300	80214.735247	80510.765194	80210.887296	80510.255977
125833	GOLD	180	1787039280	4456.289807	4459.373978	4456.168000	4459.096178
125545	GOLD	180	1787039100	4452.098178	4456.422581	4451.698703	4456.254171
125835	GBP	180	1787039280	1.352961	1.353109	1.352830	1.353061
125547	GBP	180	1787039100	1.352772	1.353193	1.352755	1.352955
125546	GOLD	300	1787039100	4452.098178	4458.300000	4451.698703	4457.779703
125548	GBP	300	1787039100	1.352772	1.353193	1.352755	1.352902
125551	SILVER	180	1787039100	65.188930	65.267995	65.186829	65.264724
125552	SILVER	300	1787039100	65.188930	65.325170	65.186829	65.315837
125839	SILVER	180	1787039280	65.267065	65.343650	65.261483	65.342960
129354	GBP	300	1788307800	1.351056	1.351214	1.350904	1.351186
128168	SILVER	180	1787040720	65.116804	65.138815	65.039045	65.065803
129355	BTC	300	1788307800	77358.510314	77371.949960	77309.014720	77353.265313
127972	SILVER	300	1787040600	65.133889	65.138815	65.039045	65.065803
127580	SILVER	180	1787040360	65.158054	65.164866	65.108416	65.161014
126409	GOLD	180	1787039640	4456.679625	4458.754713	4456.582457	4457.801860
126121	GOLD	180	1787039460	4459.151588	4459.216059	4456.345712	4456.652554
126123	GBP	180	1787039460	1.353083	1.353179	1.352807	1.353142
126411	GBP	180	1787039640	1.353120	1.353120	1.352663	1.352759
126127	SILVER	180	1787039460	65.342011	65.343134	65.236089	65.249787
126415	SILVER	180	1787039640	65.248935	65.302075	65.244226	65.300180
152673	GOLD	180	1788443460	4518.004887	4519.557532	4516.689088	4518.419589
152675	GBP	180	1788443460	1.350446	1.351011	1.350393	1.350944
152677	BTC	180	1788443460	78928.537634	78947.106371	78790.589712	78791.990369
128754	GBP	180	1787041080	1.352638	1.352746	1.352495	1.352656
127281	GOLD	180	1787040180	4455.111717	4455.293427	4453.660811	4453.886196
126986	GOLD	300	1787040000	4456.211634	4456.732972	4453.692472	4454.313535
129345	GOLD	180	1788307740	4370.600000	4371.813622	4367.365266	4370.239399
126988	GBP	300	1787040000	1.353118	1.353143	1.352525	1.352641
126026	GOLD	300	1787039400	4457.900231	4459.373978	4456.345712	4457.078230
127282	GBP	180	1787040180	1.352764	1.352834	1.352525	1.352807
126028	GBP	300	1787039400	1.352879	1.353179	1.352797	1.352890
152679	SILVER	180	1788443460	66.841038	66.852144	66.736077	66.846640
152961	GOLD	180	1788443640	4518.438322	4518.694591	4509.853585	4510.020139
126032	SILVER	300	1787039400	65.313268	65.343650	65.236089	65.279146
126992	SILVER	300	1787040000	65.222536	65.240734	65.156509	65.173105
129347	GBP	180	1788307740	1.351114	1.351173	1.350943	1.351168
141653	GOLD	180	1788436620	4485.067517	4485.333149	4482.367527	4484.670475
129349	BTC	180	1788307740	77361.965064	77371.949960	77331.739171	77334.294493
141462	GOLD	300	1788436500	4484.053417	4486.400000	4482.367527	4484.670475
152963	GBP	180	1788443640	1.350926	1.351538	1.350926	1.351294
127284	SILVER	180	1787040180	65.200146	65.202419	65.153821	65.155617
127477	GOLD	300	1787040300	4454.445454	4454.874825	4451.700000	4452.060749
126697	GOLD	180	1787039820	4457.692500	4458.231554	4455.602723	4456.182145
126506	GOLD	300	1787039700	4457.118213	4458.754713	4455.602723	4456.182145
126699	GBP	180	1787039820	1.352748	1.353118	1.352727	1.353090
126508	GBP	300	1787039700	1.352856	1.353118	1.352663	1.353090
152965	BTC	180	1788443640	78791.034425	78791.034425	78718.819396	78737.406262
129353	GOLD	300	1788307800	4370.518619	4376.100000	4363.886810	4375.970313
126703	SILVER	180	1787039820	65.301394	65.310980	65.202400	65.221418
126512	SILVER	300	1787039700	65.277185	65.310980	65.202400	65.221418
141654	GBP	180	1788436620	1.349464	1.349675	1.349433	1.349555
129351	SILVER	180	1788307740	64.685000	64.771803	64.680361	64.733933
141464	GBP	300	1788436500	1.349307	1.349675	1.349215	1.349555
126985	GOLD	180	1787040000	4456.211634	4456.732972	4454.250893	4455.113515
126987	GBP	180	1787040000	1.353118	1.353143	1.352589	1.352768
128756	SILVER	180	1787041080	64.983825	65.001061	64.938673	64.940989
141655	BTC	180	1788436620	77901.254205	77948.813730	77881.961663	77937.287585
127478	GBP	300	1787040300	1.352635	1.352878	1.352488	1.352511
126991	SILVER	180	1787040000	65.222536	65.240734	65.185000	65.197602
128457	GOLD	180	1787040900	4450.135580	4450.369448	4445.945067	4446.705580
141466	BTC	300	1788436500	77882.364181	77948.813730	77853.265137	77937.287585
129052	SILVER	180	1787041260	64.943311	65.080605	64.940000	65.071053
127480	SILVER	300	1787040300	65.175251	65.184965	65.108416	65.135747
128459	GBP	180	1787040900	1.352714	1.352714	1.352403	1.352627
128463	SILVER	180	1787040900	65.066014	65.066420	64.961217	64.985823
128458	GOLD	300	1787040900	4450.135580	4450.369448	4445.606108	4446.600579
127869	GOLD	180	1787040540	4452.787936	4452.849579	4450.200153	4450.943844
141656	SILVER	180	1788436620	66.370503	66.381659	66.319284	66.368316
127577	GOLD	180	1787040360	4453.914085	4454.210246	4451.766284	4452.864489
127870	GBP	180	1787040540	1.352676	1.352691	1.352468	1.352468
127578	GBP	180	1787040360	1.352824	1.352878	1.352555	1.352679
141468	SILVER	300	1788436500	66.384511	66.402044	66.319284	66.368316
128165	GOLD	180	1787040720	4450.950489	4451.929831	4449.960383	4450.077989
127969	GOLD	300	1787040600	4452.048366	4452.064641	4449.960383	4450.077989
128166	GBP	180	1787040720	1.352469	1.352835	1.352391	1.352713
127970	GBP	300	1787040600	1.352484	1.352835	1.352391	1.352713
128460	GBP	300	1787040900	1.352714	1.352746	1.352403	1.352746
127872	SILVER	180	1787040540	65.162299	65.162299	65.080178	65.116642
128952	SILVER	300	1787041200	64.987234	65.080605	64.938673	65.074042
128464	SILVER	300	1787040900	65.066014	65.066420	64.961217	64.985714
152967	SILVER	180	1788443640	66.846468	66.847643	66.732870	66.732870
129049	GOLD	180	1787041260	4444.256184	4450.425010	4444.148898	4449.039359
128949	GOLD	300	1787041200	4446.604053	4450.425010	4444.018186	4449.041084
129050	GBP	180	1787041260	1.352642	1.352724	1.352356	1.352703
128950	GBP	300	1787041200	1.352722	1.352745	1.352356	1.352670
129341	GOLD	180	1787041440	4448.984014	4449.041084	4448.947331	4449.041084
129342	GBP	180	1787041440	1.352700	1.352700	1.352670	1.352670
128753	GOLD	180	1787041080	4446.572345	4447.275024	4444.018186	4444.168219
129344	SILVER	180	1787041440	65.072271	65.074219	65.072271	65.074042
129346	GOLD	300	1788307500	4370.600000	4370.644060	4370.600000	4370.644060
129348	GBP	300	1788307500	1.351114	1.351114	1.351074	1.351074
129350	BTC	300	1788307500	77361.965064	77361.965064	77360.325626	77360.325626
129352	SILVER	300	1788307500	64.685000	64.685000	64.682797	64.683731
153249	GOLD	180	1788443820	4510.150858	4510.330395	4504.237884	4505.015765
153058	GOLD	300	1788443700	4517.746606	4517.869004	4504.237884	4505.015765
153251	GBP	180	1788443820	1.351271	1.351653	1.351184	1.351465
153060	GBP	300	1788443700	1.351057	1.351653	1.351057	1.351465
153253	BTC	180	1788443820	78738.170406	78853.585038	78726.921289	78814.290438
153062	BTC	300	1788443700	78762.597662	78853.585038	78718.819396	78814.290438
153255	SILVER	180	1788443820	66.734043	66.735724	66.584425	66.655206
153064	SILVER	300	1788443700	66.821674	66.823506	66.584425	66.655206
141945	GOLD	180	1788436800	4484.756230	4487.194512	4484.173766	4487.113411
141947	GBP	180	1788436800	1.349547	1.349630	1.349263	1.349491
141949	BTC	180	1788436800	77932.862390	77935.367548	77868.123141	77903.740820
141951	SILVER	180	1788436800	66.367446	66.384054	66.317754	66.346495
129356	SILVER	300	1788307800	64.683772	64.868215	64.628859	64.859653
141946	GOLD	300	1788436800	4484.756230	4487.194512	4484.173766	4486.419520
141948	GBP	300	1788436800	1.349547	1.349741	1.349263	1.349734
141950	BTC	300	1788436800	77932.862390	77935.367548	77853.035416	77880.881179
141952	SILVER	300	1788436800	66.367446	66.384054	66.317754	66.335511
\.


--
-- Data for Name: inquiries; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.inquiries (id, user_id, title, content, reply, status, replied_by, replied_at, is_reply_read, created_at) FROM stdin;
\.


--
-- Data for Name: inquiry_templates; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.inquiry_templates (id, title, content, created_at) FROM stdin;
\.


--
-- Data for Name: login_history; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.login_history (id, user_id, username, ip, user_agent, login_at) FROM stdin;
9	c84ca9f9-1efe-4ff4-a37d-ff9c3237b279	111	45.67.97.10	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-07-07 00:57:50.210477
10	b74441c4-1858-43f0-afdc-fbfec02ce9d5	qwer123	45.67.97.205	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	2026-07-07 01:29:14.690012
25	76a18cd5-62f2-4abd-9ce7-5397c05da8bd	lauom88	119.198.125.82	Mozilla/5.0 (Linux; Android 16; SM-S931N Build/BP4A.251205.006; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/149.0.7827.164 Mobile Safari/537.36 KAKAOTALK/26.5.3 (INAPP)	2026-07-08 01:31:52.003244
27	13553385-c4b7-46c6-a476-b3c2da2dbeed	qwer1234	45.67.97.18	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	2026-07-08 04:26:37.887878
28	b74441c4-1858-43f0-afdc-fbfec02ce9d5	qwer123	45.67.97.18	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	2026-07-08 04:26:56.112327
32	39be743b-bc70-4297-abb0-cb0e56c41d2f	조경해자양구	211.234.227.71	Mozilla/5.0 (Linux; Android 16; SM-S948N Build/BP4A.251205.006; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/149.0.7827.164 Mobile Safari/537.36 KAKAOTALK/26.5.3 (INAPP)	2026-07-08 23:49:33.643554
33	39be743b-bc70-4297-abb0-cb0e56c41d2f	조경해자양구	211.234.227.71	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Mobile Safari/537.36	2026-07-08 23:51:59.533453
38	74852c63-bd9c-4a75-b98a-14f2ad7393c7	phcj	112.165.168.77	Mozilla/5.0 (Linux; Android 16; SM-S948N Build/BP4A.251205.006; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/149.0.7827.159 Mobile Safari/537.36 KAKAOTALK/26.5.3 (INAPP)	2026-07-10 04:09:36.345064
39	74852c63-bd9c-4a75-b98a-14f2ad7393c7	phcj	118.46.78.86	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36 Edg/150.0.0.0	2026-07-10 04:12:10.924882
40	b5c20bc7-20be-4e6c-8d1c-0cff218f1df8	3672	118.46.214.132	Mozilla/5.0 (Linux; Android 16; SM-S926N Build/BP2A.250605.031.A3; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/149.0.7827.160 Mobile Safari/537.36 KAKAOTALK/26.5.3 (INAPP)	2026-07-10 08:39:48.20709
41	b74441c4-1858-43f0-afdc-fbfec02ce9d5	qwer123	45.67.97.35	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	2026-07-10 08:40:43.058956
42	c84ca9f9-1efe-4ff4-a37d-ff9c3237b279	111	45.67.97.153	Mozilla/5.0 (Linux; Android 13; SM-G981B) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36	2026-07-10 08:42:01.170187
43	74852c63-bd9c-4a75-b98a-14f2ad7393c7	phcj	61.253.85.79	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36 Edg/150.0.0.0	2026-07-10 20:31:58.669115
44	74852c63-bd9c-4a75-b98a-14f2ad7393c7	phcj	61.253.85.79	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Mobile Safari/537.36	2026-07-12 06:02:26.405014
48	a37c84ff-be4e-48d9-ae99-1f6823d793ea	myg5454 	211.234.227.252	Mozilla/5.0 (Linux; Android 15; SM-G991N Build/AP3A.240905.015.A2; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/149.0.7827.159 Mobile Safari/537.36 KAKAOTALK/26.5.3 (INAPP)	2026-07-13 06:41:12.510448
49	74852c63-bd9c-4a75-b98a-14f2ad7393c7	phcj	118.46.78.86	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Mobile Safari/537.36	2026-07-13 12:00:28.706256
50	1df9f2e7-8029-4302-9cf4-3625d0378d7a	sj0924	116.122.44.160	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36	2026-07-14 01:15:36.513614
51	80271ffa-4f8d-430e-b95e-fd9a456063ae	sn0618	220.65.239.134	Mozilla/5.0 (Linux; Android 16; SM-A346N Build/BP4A.251205.006; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/149.0.7827.159 Mobile Safari/537.36 KAKAOTALK/26.5.3 (INAPP)	2026-07-14 01:26:34.780811
53	1df9f2e7-8029-4302-9cf4-3625d0378d7a	sj0924	116.122.44.160	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36	2026-07-15 00:20:42.794235
54	cab56d54-635a-48c1-bfa5-e8da83724ea7	hwan2720	106.101.69.245	Mozilla/5.0 (Linux; Android 16; SM-S928N Build/BP2A.250605.031.A3; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/150.0.7871.46 Mobile Safari/537.36 KAKAOTALK/26.5.3 (INAPP)	2026-07-15 05:05:28.335862
56	f8d50cb0-b9c3-4343-bd68-825d0ac2546b	msp1010	122.45.126.71	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148 Safari/604.1 KAKAOTALK/26.5.5 (INAPP)	2026-07-15 05:26:02.155661
57	738d9e1b-d3ba-4a3e-ae04-909b2f855b21	lauom	211.197.136.90	Mozilla/5.0 (Linux; Android 16; SM-S931N Build/BP4A.251205.006; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/149.0.7827.164 Mobile Safari/537.36 KAKAOTALK/26.5.3 (INAPP)	2026-07-15 07:34:20.823335
58	bee3ac98-a63b-4c68-a854-b69a6e74f3fc	kk123555	118.235.89.15	Mozilla/5.0 (Linux; Android 16; SM-S928N Build/BP4A.251205.006; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/150.0.7871.124 Mobile Safari/537.36 KAKAOTALK/26.5.3 (INAPP)	2026-07-20 02:14:28.51725
60	c84ca9f9-1efe-4ff4-a37d-ff9c3237b279	111	45.67.97.169	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36	2026-07-20 06:57:38.527243
61	9ee373bc-d591-4bc7-82e0-18c953b27d5c	luciferkr	121.149.78.209	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36	2026-07-21 00:32:00.402289
62	b74441c4-1858-43f0-afdc-fbfec02ce9d5	qwer123	45.67.97.215	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36	2026-07-22 01:47:01.968167
66	3007b845-7394-4cb1-81d7-7a5289591da2	ojm1199	121.140.82.26	Mozilla/5.0 (Linux; Android 16; SM-S918N Build/BP4A.251205.006; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/150.0.7871.124 Mobile Safari/537.36 KAKAOTALK/26.6.1 (INAPP)	2026-07-22 06:53:27.463544
67	3007b845-7394-4cb1-81d7-7a5289591da2	ojm1199	121.140.82.26	Mozilla/5.0 (Linux; Android 16; SM-S918N Build/BP4A.251205.006; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/150.0.7871.124 Mobile Safari/537.36 KAKAOTALK/26.6.1 (INAPP)	2026-07-22 07:20:52.648068
68	3172253b-a312-48ad-a3fd-3f7e036be9b1	Syj2394 	118.235.5.116	Mozilla/5.0 (Linux; Android 16; SM-F721N Build/BP2A.250605.031.A3; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/150.0.7871.46 Mobile Safari/537.36 KAKAOTALK/26.5.3 (INAPP)	2026-07-22 09:04:29.620724
69	b74441c4-1858-43f0-afdc-fbfec02ce9d5	qwer123	45.67.97.251	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36	2026-07-23 06:01:40.916913
70	55cd7cf5-4d59-4914-affa-f306a49ff5c2	크리스탈	211.234.200.72	Mozilla/5.0 (Linux; Android 15; SM-G996N Build/AP3A.240905.015.A2; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/150.0.7871.124 Mobile Safari/537.36 KAKAOTALK/26.6.1 (INAPP)	2026-07-23 08:25:45.57747
71	55cd7cf5-4d59-4914-affa-f306a49ff5c2	크리스탈	211.225.254.2	Mozilla/5.0 (Linux; Android 15; SM-G996N Build/AP3A.240905.015.A2; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/128.0.0.0 Whale/1.0.0.0 Crosswalk/29.128.0.29 Mobile Safari/537.36 NAVER(inapp; search; 2100; 12.22.1)	2026-07-24 00:17:27.423607
72	74852c63-bd9c-4a75-b98a-14f2ad7393c7	phcj	112.186.153.52	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36 Edg/150.0.0.0	2026-07-24 05:56:32.38488
73	74852c63-bd9c-4a75-b98a-14f2ad7393c7	phcj	112.186.153.52	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36 Edg/150.0.0.0	2026-07-24 06:03:33.127417
74	74852c63-bd9c-4a75-b98a-14f2ad7393c7	phcj	203.25.124.168	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36	2026-07-24 06:30:09.59645
75	680bfe1a-2a6d-4661-8111-c86c439f1598	fffsur	211.36.146.246	Mozilla/5.0 (Linux; Android 16; SM-F936N Build/BP2A.250605.031.A3; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/150.0.7871.124 Safari/537.36 KAKAOTALK/26.6.1 (INAPP)	2026-07-24 06:39:24.162489
76	680bfe1a-2a6d-4661-8111-c86c439f1598	fffsur	211.36.146.246	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36	2026-07-24 06:43:02.235401
77	74852c63-bd9c-4a75-b98a-14f2ad7393c7	phcj	103.125.146.76	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36	2026-07-24 07:31:47.962203
78	13e0933f-cea5-4749-8f0b-181658ee5e2b	hyeri0806	211.35.199.30	Mozilla/5.0 (Linux; Android 16; SM-S911N Build/BP4A.251205.006; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/150.0.7871.124 Mobile Safari/537.36 KAKAOTALK/26.6.1 (INAPP)	2026-07-27 01:09:53.571264
79	74852c63-bd9c-4a75-b98a-14f2ad7393c7	phcj	211.235.64.54	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Mobile Safari/537.36	2026-07-27 01:36:48.877623
80	b74441c4-1858-43f0-afdc-fbfec02ce9d5	qwer123	45.67.97.193	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36	2026-07-27 23:52:39.816827
81	f501ab5b-27c7-4682-8924-692946bf5e28	겨울비	118.235.91.144	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Mobile Safari/537.36	2026-07-29 05:08:00.646879
82	f501ab5b-27c7-4682-8924-692946bf5e28	겨울비	118.235.91.144	Mozilla/5.0 (Linux; Android 16; SM-S931N Build/BP4A.251205.006; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/150.0.7871.181 Mobile Safari/537.36 KAKAOTALK/26.6.1 (INAPP)	2026-07-30 02:57:45.75726
83	3007b845-7394-4cb1-81d7-7a5289591da2	ojm1199	211.104.178.184	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36 Edg/150.0.0.0	2026-08-01 10:40:32.034635
84	13e0933f-cea5-4749-8f0b-181658ee5e2b	hyeri0806	194.114.136.62	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36	2026-08-03 02:24:21.961621
85	b74441c4-1858-43f0-afdc-fbfec02ce9d5	qwer123	45.67.97.175	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36	2026-08-05 01:37:26.975045
86	4439d992-3b0d-43a1-becd-8ef186b3d934	jongbae109	223.39.83.57	Mozilla/5.0 (Linux; Android 16; SM-S926N Build/BP4A.251205.006; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/150.0.7871.181 Mobile Safari/537.36 KAKAOTALK/26.6.3 (INAPP)	2026-08-05 03:32:22.975973
87	12b73c7f-9f06-4e98-9617-07cb693c2f4f	senskim81	118.235.11.169	Mozilla/5.0 (iPhone; CPU iPhone OS 26_5_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.5 Mobile/15E148 Safari/605.1 NAVER(inapp; search; 2100; 12.22.10; 15PROMAX)	2026-08-05 04:38:26.677667
88	12b73c7f-9f06-4e98-9617-07cb693c2f4f	senskim81	118.235.11.169	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148 Safari/604.1 KAKAOTALK/26.6.4 (INAPP)	2026-08-05 04:54:46.436601
89	b74441c4-1858-43f0-afdc-fbfec02ce9d5	qwer123	45.67.97.37	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36	2026-08-05 06:34:57.132646
90	b74441c4-1858-43f0-afdc-fbfec02ce9d5	qwer123	45.67.97.204	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36	2026-08-05 06:49:41.931662
91	3007b845-7394-4cb1-81d7-7a5289591da2	ojm1199	45.67.97.143	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36	2026-08-06 01:41:24.352209
92	3007b845-7394-4cb1-81d7-7a5289591da2	ojm1199	211.104.178.184	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36 Edg/151.0.0.0	2026-08-06 01:56:36.904905
93	691e57e6-502e-447d-ae4e-aa275486ee4c	demo	146.70.201.223	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:153.0) Gecko/20100101 Firefox/153.0	2026-08-14 04:08:51.900948
\.


--
-- Data for Name: maintenance_symbols; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.maintenance_symbols (id, symbol, reason, started_at, created_by) FROM stdin;
\.


--
-- Data for Name: messages; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.messages (id, sender_id, receiver_id, title, content, is_read, created_at, deleted_for_user) FROM stdin;
\.


--
-- Data for Name: round_forced_directions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.round_forced_directions (id, symbol, duration, round_number, forced_direction, date_key, created_at) FROM stdin;
1	SP500	300	217	display_up	2026-07-06	2026-07-06 09:04:34.024474
2	DOW	300	217	display_up	2026-07-06	2026-07-06 09:04:43.852492
3	DXY	300	217	display_up	2026-07-06	2026-07-06 09:04:45.35551
4	SP500	300	131	display_up	2026-07-07	2026-07-07 01:51:31.772092
6	SP500	300	193	display_down	2026-07-07	2026-07-07 07:02:24.993082
7	SP500	300	194	display_down	2026-07-07	2026-07-07 07:02:27.484597
8	SP500	300	195	display_down	2026-07-07	2026-07-07 07:02:34.221096
9	SP500	300	128	display_up	2026-07-08	2026-07-08 01:35:31.951218
10	SP500	300	129	display_up	2026-07-08	2026-07-08 01:35:33.955917
11	SP500	300	193	display_down	2026-07-08	2026-07-08 06:46:17.707923
12	SP500	300	194	display_down	2026-07-08	2026-07-08 06:46:20.226631
15	SP500	300	196	display_up	2026-07-08	2026-07-08 07:11:03.393189
16	SP500	300	195	display_down	2026-07-08	2026-07-08 07:14:10.435342
17	SP500	300	201	display_down	2026-07-08	2026-07-08 07:44:43.898019
19	SP500	300	128	display_up	2026-07-09	2026-07-09 01:27:25.744336
20	SP500	300	129	display_up	2026-07-09	2026-07-09 01:27:28.165503
21	SP500	300	127	display_up	2026-07-09	2026-07-09 01:34:06.094452
22	SP500	300	159	display_up	2026-07-09	2026-07-09 04:13:20.137401
23	SP500	300	193	display_down	2026-07-09	2026-07-09 06:26:18.090183
24	SP500	300	194	display_down	2026-07-09	2026-07-09 06:26:20.270454
25	SP500	300	195	display_up	2026-07-09	2026-07-09 06:26:23.009595
26	SP500	300	196	display_down	2026-07-09	2026-07-09 06:48:07.394161
27	SP500	300	127	display_down	2026-07-10	2026-07-10 01:08:16.23829
28	SP500	300	128	display_up	2026-07-10	2026-07-10 01:08:19.55761
29	SP500	300	129	display_down	2026-07-10	2026-07-10 01:08:23.512092
30	SP500	300	163	display_down	2026-07-10	2026-07-10 04:29:53.912696
31	SP500	300	185	display_up	2026-07-10	2026-07-10 06:18:42.56462
32	SP500	300	186	display_up	2026-07-10	2026-07-10 06:18:44.679216
33	SP500	300	187	display_down	2026-07-10	2026-07-10 06:18:46.740255
34	SP500	300	193	display_up	2026-07-10	2026-07-10 06:27:11.317941
35	SP500	300	194	display_down	2026-07-10	2026-07-10 06:27:13.659097
37	SP500	300	195	display_up	2026-07-10	2026-07-10 06:27:22.865642
38	SP500	300	216	display_up	2026-07-10	2026-07-10 08:58:46.076424
40	SP500	300	128	display_down	2026-07-13	2026-07-13 00:50:06.842997
41	SP500	300	129	display_up	2026-07-13	2026-07-13 00:50:08.912075
42	SP500	300	127	display_up	2026-07-13	2026-07-13 01:32:55.321123
43	SP500	300	163	display_up	2026-07-13	2026-07-13 04:31:32.424518
44	SP500	300	164	display_down	2026-07-13	2026-07-13 04:31:34.584777
45	SP500	300	165	display_down	2026-07-13	2026-07-13 04:31:36.591691
46	SP500	300	169	display_down	2026-07-13	2026-07-13 04:55:58.779442
47	SP500	300	170	display_down	2026-07-13	2026-07-13 04:56:02.07719
48	SP500	300	171	display_down	2026-07-13	2026-07-13 04:56:04.638282
50	SP500	300	194	display_up	2026-07-13	2026-07-13 06:25:52.444789
51	SP500	300	195	display_down	2026-07-13	2026-07-13 06:25:57.248181
54	SP500	300	193	display_down	2026-07-13	2026-07-13 07:03:57.252802
55	SP500	300	127	display_down	2026-07-14	2026-07-14 00:59:26.977691
56	SP500	300	128	display_up	2026-07-14	2026-07-14 00:59:30.395601
57	SP500	300	129	display_up	2026-07-14	2026-07-14 00:59:32.46261
58	SP500	300	163	display_down	2026-07-14	2026-07-14 04:29:26.234318
59	SP500	300	164	display_down	2026-07-14	2026-07-14 04:29:28.432615
60	SP500	300	165	display_up	2026-07-14	2026-07-14 04:29:31.114533
61	SP500	300	166	display_up	2026-07-14	2026-07-14 04:29:33.198236
62	SP500	300	193	display_down	2026-07-14	2026-07-14 06:32:05.936983
63	SP500	300	194	display_down	2026-07-14	2026-07-14 06:32:10.420923
64	SP500	300	195	display_up	2026-07-14	2026-07-14 06:32:13.405193
65	SP500	300	127	display_up	2026-07-15	2026-07-15 01:04:58.215885
66	SP500	300	128	display_up	2026-07-15	2026-07-15 01:05:00.359113
67	SP500	300	129	display_down	2026-07-15	2026-07-15 01:05:03.362985
68	SP500	300	157	display_down	2026-07-15	2026-07-15 03:41:53.055108
69	SP500	300	158	display_down	2026-07-15	2026-07-15 03:41:55.396445
70	SP500	300	159	display_up	2026-07-15	2026-07-15 03:41:57.725687
71	SP500	300	163	display_down	2026-07-15	2026-07-15 04:29:29.553055
72	SP500	300	164	display_down	2026-07-15	2026-07-15 04:29:31.839048
73	SP500	300	165	display_up	2026-07-15	2026-07-15 04:29:46.895134
74	SP500	300	193	display_down	2026-07-15	2026-07-15 06:49:32.154322
75	SP500	300	194	display_up	2026-07-15	2026-07-15 06:49:34.192599
76	SP500	300	195	display_down	2026-07-15	2026-07-15 06:49:37.471724
77	SP500	300	198	display_up	2026-07-15	2026-07-15 07:29:05.622645
78	SP500	300	199	display_down	2026-07-15	2026-07-15 07:29:08.131053
79	SP500	300	127	display_down	2026-07-16	2026-07-16 00:54:23.122594
80	SP500	300	128	display_down	2026-07-16	2026-07-16 00:54:25.205988
81	SP500	300	129	display_down	2026-07-16	2026-07-16 00:54:27.224254
82	SP500	300	159	display_down	2026-07-16	2026-07-16 04:10:42.61088
83	SP500	300	162	display_down	2026-07-16	2026-07-16 04:26:42.187702
84	SP500	300	163	display_down	2026-07-16	2026-07-16 04:26:44.477273
85	SP500	300	169	display_down	2026-07-16	2026-07-16 04:42:32.652903
86	SP500	300	170	display_down	2026-07-16	2026-07-16 04:42:34.520051
87	SP500	300	171	display_down	2026-07-16	2026-07-16 04:42:36.678813
88	SP500	300	193	display_up	2026-07-16	2026-07-16 06:48:55.892307
89	SP500	300	194	display_down	2026-07-16	2026-07-16 06:48:59.451144
90	SP500	300	195	display_up	2026-07-16	2026-07-16 06:49:01.997152
91	SP500	300	127	display_down	2026-07-20	2026-07-20 01:03:45.15986
92	SP500	300	128	display_up	2026-07-20	2026-07-20 01:03:47.198063
93	SP500	300	129	display_down	2026-07-20	2026-07-20 01:03:49.694402
94	SP500	300	157	display_up	2026-07-20	2026-07-20 03:55:47.950161
95	SP500	300	158	display_up	2026-07-20	2026-07-20 03:55:50.197998
96	SP500	300	159	display_down	2026-07-20	2026-07-20 03:55:53.448568
97	SP500	300	163	display_down	2026-07-20	2026-07-20 04:26:27.222797
98	SP500	300	164	display_down	2026-07-20	2026-07-20 04:26:29.310987
99	SP500	300	165	display_down	2026-07-20	2026-07-20 04:26:31.72275
100	SP500	300	193	display_up	2026-07-20	2026-07-20 06:39:50.405624
101	SP500	300	194	display_up	2026-07-20	2026-07-20 06:39:52.719748
102	SP500	300	195	display_down	2026-07-20	2026-07-20 06:39:55.121839
103	SP500	300	127	display_down	2026-07-21	2026-07-21 00:55:52.342363
104	SP500	300	128	display_down	2026-07-21	2026-07-21 00:55:54.43247
105	SP500	300	129	display_up	2026-07-21	2026-07-21 00:55:56.567337
106	SP500	300	157	display_up	2026-07-21	2026-07-21 03:59:57.796663
107	SP500	300	158	display_down	2026-07-21	2026-07-21 03:59:59.988698
108	SP500	300	159	display_down	2026-07-21	2026-07-21 04:00:02.262367
109	SP500	300	163	display_down	2026-07-21	2026-07-21 04:28:12.471836
110	SP500	300	164	display_down	2026-07-21	2026-07-21 04:28:14.976236
111	SP500	300	165	display_up	2026-07-21	2026-07-21 04:28:17.620266
112	SP500	300	193	display_down	2026-07-21	2026-07-21 06:16:08.098896
113	SP500	300	194	display_up	2026-07-21	2026-07-21 06:16:15.313035
114	SP500	300	195	display_up	2026-07-21	2026-07-21 06:16:19.128623
115	SP500	300	127	display_up	2026-07-22	2026-07-22 00:52:40.541288
116	SP500	300	128	display_down	2026-07-22	2026-07-22 00:52:42.769617
117	SP500	300	129	display_up	2026-07-22	2026-07-22 00:52:44.931203
118	SP500	300	161	display_down	2026-07-22	2026-07-22 04:13:08.249924
119	SP500	300	162	display_down	2026-07-22	2026-07-22 04:13:18.066435
120	SP500	300	163	display_up	2026-07-22	2026-07-22 04:13:20.170581
121	SP500	300	164	display_down	2026-07-22	2026-07-22 04:31:04.743544
122	SP500	300	193	display_down	2026-07-22	2026-07-22 06:19:17.112074
123	SP500	300	194	display_down	2026-07-22	2026-07-22 06:19:22.746238
124	SP500	300	195	display_up	2026-07-22	2026-07-22 06:19:27.479454
125	SP500	300	192	display_up	2026-07-22	2026-07-22 06:54:19.998753
126	SP500	300	127	display_down	2026-07-23	2026-07-23 00:59:36.844851
127	SP500	300	128	display_up	2026-07-23	2026-07-23 00:59:39.214633
128	SP500	300	129	display_down	2026-07-23	2026-07-23 00:59:41.374623
129	SP500	300	158	display_up	2026-07-23	2026-07-23 04:07:35.592005
130	SP500	300	159	display_down	2026-07-23	2026-07-23 04:07:37.514149
131	SP500	300	163	display_down	2026-07-23	2026-07-23 04:26:57.038588
132	SP500	300	164	display_down	2026-07-23	2026-07-23 04:26:59.361892
133	SP500	300	165	display_up	2026-07-23	2026-07-23 04:27:01.438322
134	SP500	300	167	display_down	2026-07-23	2026-07-23 04:48:18.481473
135	SP500	300	168	display_down	2026-07-23	2026-07-23 04:48:20.57313
136	SP500	300	169	display_up	2026-07-23	2026-07-23 04:48:23.276376
137	SP500	300	193	display_up	2026-07-23	2026-07-23 06:22:08.427285
138	SP500	300	194	display_down	2026-07-23	2026-07-23 06:22:11.775315
139	SP500	300	195	display_down	2026-07-23	2026-07-23 06:22:14.019185
140	SP500	300	113	display_down	2026-07-24	2026-07-24 00:21:58.298535
141	SP500	300	127	display_up	2026-07-24	2026-07-24 00:49:52.35375
142	SP500	300	128	display_up	2026-07-24	2026-07-24 00:49:56.632167
143	SP500	300	129	display_down	2026-07-24	2026-07-24 00:50:00.605625
144	SP500	300	163	display_down	2026-07-24	2026-07-24 04:23:12.62129
145	SP500	300	164	display_up	2026-07-24	2026-07-24 04:23:14.687987
146	SP500	300	165	display_down	2026-07-24	2026-07-24 04:23:16.801666
147	SP500	300	181	display_up	2026-07-24	2026-07-24 05:58:49.097657
148	SP500	300	182	display_up	2026-07-24	2026-07-24 05:58:51.408305
149	SP500	300	193	display_down	2026-07-24	2026-07-24 06:20:18.119066
150	SP500	300	194	display_down	2026-07-24	2026-07-24 06:20:20.387393
151	SP500	300	195	display_down	2026-07-24	2026-07-24 06:20:22.633626
154	SP500	300	127	display_up	2026-07-27	2026-07-27 00:37:37.430478
155	SP500	300	128	display_down	2026-07-27	2026-07-27 00:37:39.650439
156	SP500	300	129	display_up	2026-07-27	2026-07-27 00:37:42.742326
157	SP500	300	160	display_up	2026-07-27	2026-07-27 04:15:25.689812
158	SP500	300	163	display_up	2026-07-27	2026-07-27 04:26:07.523174
159	SP500	300	164	display_down	2026-07-27	2026-07-27 04:26:09.428751
160	SP500	300	165	display_down	2026-07-27	2026-07-27 04:26:11.048167
161	SP500	300	193	display_down	2026-07-27	2026-07-27 06:28:55.801318
162	SP500	300	194	display_down	2026-07-27	2026-07-27 06:28:58.385067
163	SP500	300	195	display_up	2026-07-27	2026-07-27 06:29:07.700512
164	SP500	300	196	display_down	2026-07-27	2026-07-27 07:09:34.451774
165	SP500	300	204	display_down	2026-07-27	2026-07-27 07:54:46.813017
166	SP500	300	205	display_up	2026-07-27	2026-07-27 07:54:48.677674
167	SP500	300	119	display_down	2026-07-28	2026-07-28 00:47:53.216999
168	SP500	300	120	display_down	2026-07-28	2026-07-28 00:47:55.370367
169	SP500	300	121	display_down	2026-07-28	2026-07-28 00:47:57.351943
170	SP500	300	127	display_up	2026-07-28	2026-07-28 01:01:56.934385
171	SP500	300	128	display_up	2026-07-28	2026-07-28 01:01:59.946523
172	SP500	300	129	display_down	2026-07-28	2026-07-28 01:02:02.334305
173	SP500	300	122	display_up	2026-07-28	2026-07-28 01:04:26.537853
176	SP500	300	130	display_down	2026-07-28	2026-07-28 01:46:06.626514
177	SP500	300	172	display_down	2026-07-28	2026-07-28 05:03:05.337343
178	SP500	300	173	display_down	2026-07-28	2026-07-28 05:03:07.657497
179	SP500	300	174	display_up	2026-07-28	2026-07-28 05:03:09.959625
180	SP500	300	193	display_down	2026-07-28	2026-07-28 06:38:30.087471
181	SP500	300	194	display_up	2026-07-28	2026-07-28 06:38:31.955227
182	SP500	300	195	display_up	2026-07-28	2026-07-28 06:38:33.810454
183	SP500	300	121	display_down	2026-07-29	2026-07-29 00:54:04.354386
184	SP500	300	122	display_down	2026-07-29	2026-07-29 00:54:07.03432
185	SP500	300	123	display_up	2026-07-29	2026-07-29 00:54:09.56254
186	SP500	300	127	display_down	2026-07-29	2026-07-29 00:55:10.057775
187	SP500	300	128	display_up	2026-07-29	2026-07-29 00:55:11.920162
188	SP500	300	129	display_down	2026-07-29	2026-07-29 00:55:14.597065
189	SP500	300	181	display_up	2026-07-29	2026-07-29 06:02:19.923115
190	SP500	300	182	display_up	2026-07-29	2026-07-29 06:02:21.875134
191	SP500	300	183	display_down	2026-07-29	2026-07-29 06:02:23.847644
192	SP500	300	193	display_up	2026-07-29	2026-07-29 06:13:56.07887
193	SP500	300	194	display_down	2026-07-29	2026-07-29 06:13:57.911363
194	SP500	300	195	display_down	2026-07-29	2026-07-29 06:14:00.024505
195	SP500	300	121	display_down	2026-07-30	2026-07-30 00:53:08.551812
196	SP500	300	122	display_down	2026-07-30	2026-07-30 00:53:10.729565
197	SP500	300	123	display_up	2026-07-30	2026-07-30 00:53:12.906145
198	SP500	300	127	display_down	2026-07-30	2026-07-30 01:00:09.508794
199	SP500	300	128	display_down	2026-07-30	2026-07-30 01:00:14.506105
200	SP500	300	129	display_down	2026-07-30	2026-07-30 01:00:17.466288
201	SP500	300	124	display_down	2026-07-30	2026-07-30 01:07:37.303734
202	SP500	300	193	display_down	2026-07-30	2026-07-30 06:27:52.940858
203	SP500	300	194	display_up	2026-07-30	2026-07-30 06:27:55.206714
204	SP500	300	195	display_up	2026-07-30	2026-07-30 06:27:57.226167
205	SP500	300	127	display_up	2026-07-31	2026-07-31 00:51:21.798746
206	SP500	300	128	display_up	2026-07-31	2026-07-31 00:51:23.623374
207	SP500	300	129	display_down	2026-07-31	2026-07-31 00:51:25.464009
208	SP500	300	121	display_down	2026-07-31	2026-07-31 01:02:23.216549
209	SP500	300	122	display_down	2026-07-31	2026-07-31 01:02:25.475737
210	SP500	300	123	display_up	2026-07-31	2026-07-31 01:02:28.584282
211	SP500	300	163	display_down	2026-07-31	2026-07-31 04:27:24.351074
212	SP500	300	164	display_up	2026-07-31	2026-07-31 04:27:26.176433
213	SP500	300	165	display_down	2026-07-31	2026-07-31 04:27:27.801144
214	SP500	300	193	display_down	2026-07-31	2026-07-31 06:24:11.730599
215	SP500	300	194	display_down	2026-07-31	2026-07-31 06:24:14.570591
216	SP500	300	195	display_up	2026-07-31	2026-07-31 06:24:17.308076
217	SP500	300	121	display_down	2026-08-03	2026-08-03 00:49:20.712949
218	SP500	300	122	display_up	2026-08-03	2026-08-03 00:49:22.837204
219	SP500	300	123	display_down	2026-08-03	2026-08-03 00:49:25.119053
220	SP500	300	127	display_up	2026-08-03	2026-08-03 00:53:37.103312
221	SP500	300	128	display_down	2026-08-03	2026-08-03 00:53:39.797384
222	SP500	300	129	display_down	2026-08-03	2026-08-03 00:53:42.404074
223	SP500	300	157	display_down	2026-08-03	2026-08-03 03:55:09.762782
224	SP500	300	158	display_up	2026-08-03	2026-08-03 03:55:11.666623
225	SP500	300	159	display_up	2026-08-03	2026-08-03 03:55:13.777971
226	SP500	300	193	display_up	2026-08-03	2026-08-03 06:12:43.938441
227	SP500	300	194	display_up	2026-08-03	2026-08-03 06:12:45.748332
228	SP500	300	195	display_down	2026-08-03	2026-08-03 06:12:49.315121
229	SP500	300	127	display_down	2026-08-04	2026-08-04 00:47:53.314513
230	SP500	300	128	display_up	2026-08-04	2026-08-04 00:47:58.595303
231	SP500	300	129	display_down	2026-08-04	2026-08-04 00:48:05.197147
232	SP500	300	121	display_up	2026-08-04	2026-08-04 00:53:43.592809
233	SP500	300	122	display_down	2026-08-04	2026-08-04 00:53:45.52076
234	SP500	300	123	display_down	2026-08-04	2026-08-04 00:53:48.272887
235	SP500	300	124	display_down	2026-08-04	2026-08-04 01:15:48.286361
236	SP500	300	181	display_down	2026-08-04	2026-08-04 06:00:50.061712
237	SP500	300	182	display_down	2026-08-04	2026-08-04 06:00:51.952675
238	SP500	300	193	display_up	2026-08-04	2026-08-04 06:26:44.6157
239	SP500	300	194	display_down	2026-08-04	2026-08-04 06:26:46.510457
240	SP500	300	195	display_down	2026-08-04	2026-08-04 06:26:48.281624
241	SP500	300	127	display_down	2026-08-05	2026-08-05 00:48:19.92793
242	SP500	300	128	display_down	2026-08-05	2026-08-05 00:48:23.238282
243	SP500	300	129	display_up	2026-08-05	2026-08-05 00:48:28.19323
244	SP500	300	121	display_down	2026-08-05	2026-08-05 00:54:38.764946
245	SP500	300	122	display_down	2026-08-05	2026-08-05 00:54:40.864556
246	SP500	300	123	display_up	2026-08-05	2026-08-05 00:54:42.95824
247	SP500	300	193	display_up	2026-08-05	2026-08-05 06:14:28.246516
248	SP500	300	194	display_up	2026-08-05	2026-08-05 06:14:30.942955
249	SP500	300	195	display_down	2026-08-05	2026-08-05 06:14:33.136515
250	SP500	300	121	display_up	2026-08-06	2026-08-06 00:49:47.549896
252	SP500	300	126	display_up	2026-08-06	2026-08-06 00:54:55.267892
253	SP500	300	127	display_up	2026-08-06	2026-08-06 00:54:56.994722
255	SP500	300	122	display_up	2026-08-06	2026-08-06 01:07:33.915693
256	SP500	300	123	display_down	2026-08-06	2026-08-06 01:12:33.676401
257	SP500	300	124	display_down	2026-08-06	2026-08-06 01:16:15.455025
258	SP500	300	128	display_up	2026-08-06	2026-08-06 01:35:11.813556
260	SP500	300	129	display_up	2026-08-06	2026-08-06 01:41:54.62047
261	SP500	300	127	display_up	2026-08-07	2026-08-07 00:37:07.930443
262	SP500	300	128	display_down	2026-08-07	2026-08-07 00:37:12.275278
263	SP500	300	129	display_down	2026-08-07	2026-08-07 00:37:16.302095
264	SP500	300	121	display_down	2026-08-07	2026-08-07 00:49:30.338387
265	SP500	300	122	display_down	2026-08-07	2026-08-07 00:49:32.766931
266	SP500	300	123	display_up	2026-08-07	2026-08-07 00:49:35.006307
269	SP500	300	193	display_up	2026-08-07	2026-08-07 06:59:25.231419
\.


--
-- Data for Name: round_results; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.round_results (id, symbol, duration, round_number, round_date, open_price, close_price, high_price, low_price, direction, created_at) FROM stdin;
\.


--
-- Data for Name: settings; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.settings (key, value, updated_at) FROM stdin;
telegram_bot_token	8742173231:AAGOgijbX-zLU_gXzrteKEMBV6tZU-2wJk8	2026-07-07 02:41:51.217
telegram_notification_chat_id	-5543508614	2026-07-07 02:41:51.225
\.


--
-- Data for Name: transaction_requests; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.transaction_requests (id, user_id, type, amount, status, bank_name, account_holder, account_number, sender_name, admin_note, processed_by, processed_at, created_at) FROM stdin;
48	680bfe1a-2a6d-4661-8111-c86c439f1598	deposit	3000000	approved	\N	\N	\N	박덕준	\N	4207899b-f5e9-4393-9c14-0ad0db005748	2026-07-27 02:12:18.258	2026-07-27 02:10:11.461202
50	55cd7cf5-4d59-4914-affa-f306a49ff5c2	deposit	3000000	approved	\N	\N	\N	정선우	\N	4207899b-f5e9-4393-9c14-0ad0db005748	2026-07-27 07:53:47.016	2026-07-27 07:53:32.540541
51	3007b845-7394-4cb1-81d7-7a5289591da2	deposit	4850000	approved	\N	\N	\N	오재명	\N	4207899b-f5e9-4393-9c14-0ad0db005748	2026-07-27 08:28:18.522	2026-07-27 08:28:11.238334
26	a37c84ff-be4e-48d9-ae99-1f6823d793ea	withdrawal	165000	approved	\N	\N	\N	\N	\N	4207899b-f5e9-4393-9c14-0ad0db005748	2026-07-16 10:32:52.677	2026-07-15 08:19:42.220624
14	74852c63-bd9c-4a75-b98a-14f2ad7393c7	deposit	5000000	rejected	\N	\N	\N	김윤구	\N	4207899b-f5e9-4393-9c14-0ad0db005748	2026-07-10 04:14:08.37	2026-07-10 04:13:37.916697
15	74852c63-bd9c-4a75-b98a-14f2ad7393c7	deposit	5000000	approved	\N	\N	\N	김윤구	\N	4207899b-f5e9-4393-9c14-0ad0db005748	2026-07-10 04:28:15.106	2026-07-10 04:27:01.752116
16	b5c20bc7-20be-4e6c-8d1c-0cff218f1df8	deposit	5000000	approved	\N	\N	\N	김송희	\N	4207899b-f5e9-4393-9c14-0ad0db005748	2026-07-10 08:57:18.388	2026-07-10 08:57:11.382489
17	b5c20bc7-20be-4e6c-8d1c-0cff218f1df8	withdrawal	190000	approved	\N	\N	\N	\N	\N	4207899b-f5e9-4393-9c14-0ad0db005748	2026-07-10 09:34:31.606	2026-07-10 09:07:30.774857
18	74852c63-bd9c-4a75-b98a-14f2ad7393c7	deposit	3000000	approved	\N	\N	\N	김윤구	\N	4207899b-f5e9-4393-9c14-0ad0db005748	2026-07-13 03:56:51.195	2026-07-13 03:52:18.81224
19	74852c63-bd9c-4a75-b98a-14f2ad7393c7	deposit	4250000	approved	\N	\N	\N	김윤구	\N	4207899b-f5e9-4393-9c14-0ad0db005748	2026-07-13 04:25:00.489	2026-07-13 04:21:06.040989
20	74852c63-bd9c-4a75-b98a-14f2ad7393c7	deposit	2750000	approved	\N	\N	\N	김윤구	\N	4207899b-f5e9-4393-9c14-0ad0db005748	2026-07-13 04:33:10.173	2026-07-13 04:29:44.051843
21	1df9f2e7-8029-4302-9cf4-3625d0378d7a	deposit	50000	rejected	\N	\N	\N	안미란	\N	4207899b-f5e9-4393-9c14-0ad0db005748	2026-07-14 01:17:46.786	2026-07-14 01:17:11.50857
22	1df9f2e7-8029-4302-9cf4-3625d0378d7a	deposit	10000	rejected	\N	\N	\N	안미란	\N	4207899b-f5e9-4393-9c14-0ad0db005748	2026-07-14 01:23:59.541	2026-07-14 01:23:50.196741
23	80271ffa-4f8d-430e-b95e-fd9a456063ae	deposit	3000000	rejected	\N	\N	\N	오승열	\N	4207899b-f5e9-4393-9c14-0ad0db005748	2026-07-14 06:34:16.36	2026-07-14 01:42:48.223511
24	a37c84ff-be4e-48d9-ae99-1f6823d793ea	deposit	3000000	rejected	\N	\N	\N	문영길	\N	4207899b-f5e9-4393-9c14-0ad0db005748	2026-07-15 04:04:48.213	2026-07-15 03:20:31.821295
27	a37c84ff-be4e-48d9-ae99-1f6823d793ea	withdrawal	3112500	rejected	\N	\N	\N	\N	\N	4207899b-f5e9-4393-9c14-0ad0db005748	2026-07-20 05:07:15.819	2026-07-20 05:06:34.576229
25	a37c84ff-be4e-48d9-ae99-1f6823d793ea	deposit	3000000	approved	\N	\N	\N	문영길	\N	4207899b-f5e9-4393-9c14-0ad0db005748	2026-07-15 07:20:45.384	2026-07-15 07:19:33.513401
28	a37c84ff-be4e-48d9-ae99-1f6823d793ea	withdrawal	3112500	rejected	\N	\N	\N	\N	\N	4207899b-f5e9-4393-9c14-0ad0db005748	2026-07-20 05:13:38.214	2026-07-20 05:13:15.236508
30	a37c84ff-be4e-48d9-ae99-1f6823d793ea	withdrawal	3000000	rejected	\N	\N	\N	\N	\N	4207899b-f5e9-4393-9c14-0ad0db005748	2026-07-20 06:42:26.597	2026-07-20 05:38:09.382992
29	a37c84ff-be4e-48d9-ae99-1f6823d793ea	withdrawal	112500	rejected	\N	\N	\N	\N	\N	4207899b-f5e9-4393-9c14-0ad0db005748	2026-07-20 06:42:26.857	2026-07-20 05:15:07.754315
31	9ee373bc-d591-4bc7-82e0-18c953b27d5c	deposit	2000000	approved	\N	\N	\N	서정철	\N	4207899b-f5e9-4393-9c14-0ad0db005748	2026-07-21 00:44:08.19	2026-07-21 00:42:26.562241
32	a37c84ff-be4e-48d9-ae99-1f6823d793ea	withdrawal	3112500	rejected	\N	\N	\N	\N	\N	4207899b-f5e9-4393-9c14-0ad0db005748	2026-07-21 04:27:45.777	2026-07-21 03:27:18.579786
34	9ee373bc-d591-4bc7-82e0-18c953b27d5c	withdrawal	2087500	approved	\N	\N	\N	\N	\N	4207899b-f5e9-4393-9c14-0ad0db005748	2026-07-21 07:07:57.011	2026-07-21 06:18:49.038003
33	a37c84ff-be4e-48d9-ae99-1f6823d793ea	withdrawal	3112500	rejected	\N	\N	\N	\N	\N	4207899b-f5e9-4393-9c14-0ad0db005748	2026-07-21 07:07:58.034	2026-07-21 04:58:36.694659
39	3007b845-7394-4cb1-81d7-7a5289591da2	deposit	1000000	rejected	\N	\N	\N	오재명	\N	4207899b-f5e9-4393-9c14-0ad0db005748	2026-07-22 09:04:04.041	2026-07-22 07:26:48.514006
38	3007b845-7394-4cb1-81d7-7a5289591da2	deposit	1000000	rejected	\N	\N	\N	오재명	\N	4207899b-f5e9-4393-9c14-0ad0db005748	2026-07-22 09:04:04.602	2026-07-22 07:25:50.381386
37	3007b845-7394-4cb1-81d7-7a5289591da2	deposit	1000000	rejected	\N	\N	\N	오재명	\N	4207899b-f5e9-4393-9c14-0ad0db005748	2026-07-22 09:04:05.127	2026-07-22 07:25:09.621938
40	3007b845-7394-4cb1-81d7-7a5289591da2	deposit	2300000	approved	\N	\N	\N	오재명	\N	4207899b-f5e9-4393-9c14-0ad0db005748	2026-07-23 02:04:27.468	2026-07-23 01:49:07.470453
42	3007b845-7394-4cb1-81d7-7a5289591da2	deposit	2700000	approved	\N	\N	\N	오재명	\N	4207899b-f5e9-4393-9c14-0ad0db005748	2026-07-23 02:13:18.487	2026-07-23 02:12:46.834952
41	3007b845-7394-4cb1-81d7-7a5289591da2	deposit	2300000	rejected	\N	\N	\N	오재명	\N	4207899b-f5e9-4393-9c14-0ad0db005748	2026-07-23 02:13:19.768	2026-07-23 02:11:40.203469
44	55cd7cf5-4d59-4914-affa-f306a49ff5c2	deposit	3000000	approved	\N	\N	\N	정선우	\N	4207899b-f5e9-4393-9c14-0ad0db005748	2026-07-23 09:05:06.984	2026-07-23 09:04:20.846266
45	55cd7cf5-4d59-4914-affa-f306a49ff5c2	withdrawal	28500	approved	\N	\N	\N	\N	\N	4207899b-f5e9-4393-9c14-0ad0db005748	2026-07-24 01:21:16.838	2026-07-24 00:41:13.57113
47	74852c63-bd9c-4a75-b98a-14f2ad7393c7	deposit	4510000	approved	\N	\N	\N	김윤구	\N	4207899b-f5e9-4393-9c14-0ad0db005748	2026-07-24 05:16:10.782	2026-07-24 05:16:07.821417
46	74852c63-bd9c-4a75-b98a-14f2ad7393c7	withdrawal	4510000	approved	\N	\N	\N	\N	\N	4207899b-f5e9-4393-9c14-0ad0db005748	2026-07-24 05:22:33.441	2026-07-24 05:15:18.638484
53	3007b845-7394-4cb1-81d7-7a5289591da2	deposit	5000000	approved	\N	\N	\N	오재명	\N	4207899b-f5e9-4393-9c14-0ad0db005748	2026-07-28 00:30:36.978	2026-07-28 00:30:23.258859
56	55cd7cf5-4d59-4914-affa-f306a49ff5c2	withdrawal	17500	approved	\N	\N	\N	\N	\N	4207899b-f5e9-4393-9c14-0ad0db005748	2026-07-28 09:54:09.718	2026-07-28 09:33:48.476232
57	3007b845-7394-4cb1-81d7-7a5289591da2	deposit	5000000	approved	\N	\N	\N	오재명	\N	4207899b-f5e9-4393-9c14-0ad0db005748	2026-07-29 00:13:09.512	2026-07-29 00:12:58.972257
59	55cd7cf5-4d59-4914-affa-f306a49ff5c2	deposit	25000000	approved	\N	\N	\N	정선우	\N	4207899b-f5e9-4393-9c14-0ad0db005748	2026-07-29 00:57:46.717	2026-07-29 00:57:19.152782
60	55cd7cf5-4d59-4914-affa-f306a49ff5c2	withdrawal	357500	approved	\N	\N	\N	\N	\N	4207899b-f5e9-4393-9c14-0ad0db005748	2026-07-29 01:34:32.067	2026-07-29 01:12:42.622458
61	55cd7cf5-4d59-4914-affa-f306a49ff5c2	withdrawal	237500	approved	\N	\N	\N	\N	\N	4207899b-f5e9-4393-9c14-0ad0db005748	2026-07-29 01:40:31.231	2026-07-29 01:36:09.908208
62	55cd7cf5-4d59-4914-affa-f306a49ff5c2	deposit	4810000	approved	\N	\N	\N	정선우	\N	4207899b-f5e9-4393-9c14-0ad0db005748	2026-07-29 05:19:50.887	2026-07-29 05:11:36.609522
63	55cd7cf5-4d59-4914-affa-f306a49ff5c2	deposit	20190000	approved	\N	\N	\N	정선우	\N	4207899b-f5e9-4393-9c14-0ad0db005748	2026-07-29 05:56:39.733	2026-07-29 05:56:02.902211
64	55cd7cf5-4d59-4914-affa-f306a49ff5c2	withdrawal	225000	approved	\N	\N	\N	\N	\N	4207899b-f5e9-4393-9c14-0ad0db005748	2026-07-29 09:49:57.777	2026-07-29 07:15:10.90809
65	55cd7cf5-4d59-4914-affa-f306a49ff5c2	deposit	25000000	approved	\N	\N	\N	정선우	\N	4207899b-f5e9-4393-9c14-0ad0db005748	2026-07-30 01:08:32.913	2026-07-30 01:08:17.249711
66	3007b845-7394-4cb1-81d7-7a5289591da2	withdrawal	1000000	approved	\N	\N	\N	\N	\N	4207899b-f5e9-4393-9c14-0ad0db005748	2026-07-30 07:47:55.564	2026-07-30 07:44:11.265012
67	55cd7cf5-4d59-4914-affa-f306a49ff5c2	withdrawal	5225000	approved	\N	\N	\N	\N	\N	4207899b-f5e9-4393-9c14-0ad0db005748	2026-07-30 08:25:56.235	2026-07-30 07:52:12.829076
68	55cd7cf5-4d59-4914-affa-f306a49ff5c2	withdrawal	380000	approved	\N	\N	\N	\N	\N	4207899b-f5e9-4393-9c14-0ad0db005748	2026-07-31 09:24:37.163	2026-07-31 07:20:44.883374
69	3007b845-7394-4cb1-81d7-7a5289591da2	deposit	5000000	approved	\N	\N	\N	오재명	\N	4207899b-f5e9-4393-9c14-0ad0db005748	2026-08-03 01:59:13.036	2026-08-03 01:58:52.3125
71	55cd7cf5-4d59-4914-affa-f306a49ff5c2	deposit	3000000	approved	\N	\N	\N	정선우	\N	4207899b-f5e9-4393-9c14-0ad0db005748	2026-08-04 00:16:40.339	2026-08-04 00:16:04.800212
72	3007b845-7394-4cb1-81d7-7a5289591da2	deposit	5000000	approved	\N	\N	\N	오재명	\N	4207899b-f5e9-4393-9c14-0ad0db005748	2026-08-04 00:35:34.471	2026-08-04 00:35:25.674544
\.


--
-- Data for Name: user_sessions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_sessions (sid, sess, expire) FROM stdin;
1Wppe7SY-x1nRdOyxM04p7KDwJdeRg93	{"cookie":{"originalMaxAge":604800000,"expires":"2026-08-21T04:08:51.951Z","secure":false,"httpOnly":true,"path":"/","sameSite":"lax"},"userId":"691e57e6-502e-447d-ae4e-aa275486ee4c"}	2026-08-25 08:14:02
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.users (id, username, password, name, phone, bank_name, account_holder, account_number, balance, total_deposit, total_withdrawal, total_bet, total_win, role, grade, is_active, last_login_at, created_at, approval_status, birth_date, resident_number, region, branch_code, affiliate_id, last_login_ip, auto_bet_enabled, auto_bet_multiplier, is_betting_blocked, forced_bet_direction, max_execution_enabled, pending_balance_adjustment, always_pending_enabled, telegram_notify_enabled) FROM stdin;
f4a21243-eb2a-498e-bd25-46b1f19640cf	admin	admin1111	관리자	\N	\N	\N	\N	100000000	0	0	0	0	admin	브론즈	t	\N	2026-08-09 11:19:58.005784	approved	\N	\N	\N	\N	\N	\N	f	10	f	\N	t	0	f	f
76a18cd5-62f2-4abd-9ce7-5397c05da8bd	lauom88	lr1762rd//	이원재	1098070079	KB국민은행	이원재	117210953111	0	0	0	0	0	user	브론즈	t	2026-07-08 01:31:51.995	2026-07-08 01:28:11.740038	approved	630307	\N	\N	\N	\N	119.198.125.82	f	10	f	\N	t	0	f	f
680bfe1a-2a6d-4661-8111-c86c439f1598	fffsur	d2706j-2706	박덕준	1032252706	우리은행	박덕준	1002541937465 	0	3000000	0	0	0	user	브론즈	t	2026-07-24 06:43:02.228	2026-07-24 01:44:31.845979	approved	690326	\N	\N	\N	877fbaaa-35aa-4dc8-a141-2b7d2acc2cbf	211.36.146.246	f	10	f	\N	t	0	f	f
74852c63-bd9c-4a75-b98a-14f2ad7393c7	phcj	iapplecj9*	김윤구	1099921232	새마을금고	김윤구	4543100010311	0	19510000	4510000	0	0	user	브론즈	f	2026-07-27 01:36:48.872	2026-07-10 04:08:02.844156	approved	680510	\N	\N	\N	\N	211.235.64.54	f	10	f	\N	t	0	f	f
c84ca9f9-1efe-4ff4-a37d-ff9c3237b279	111	1234	111	1011111111	신한은행	4534	4354534345	22837500	0	0	0	0	user	브론즈	t	2026-07-20 06:57:38.521	2026-07-07 00:57:38.762691	approved	111111	\N	\N	\N	\N	45.67.97.169	f	10	f	\N	t	0	f	f
b5c20bc7-20be-4e6c-8d1c-0cff218f1df8	3672	3744	김송희	1029945228	신한은행	김송희	110610575738	0	5000000	190000	0	0	user	브론즈	t	2026-07-10 08:39:48.2	2026-07-10 08:39:04.798874	approved	600721	\N	\N	\N	877fbaaa-35aa-4dc8-a141-2b7d2acc2cbf	118.46.214.132	f	10	f	\N	t	0	f	f
ebe1121e-9a3b-4db5-a055-a04cd49349dd	testnotify99	test1234	알림테스트	1012345678	국민은행	알림테스트	123456789012	0	0	0	0	0	user	브론즈	t	\N	2026-04-23 01:54:17.978872	approved	\N	\N	\N	\N	\N	\N	f	10	f	\N	f	0	f	f
88aea1be-9af7-4380-abb7-abe8770f6567	pox79	791806dhr$	김재옥	1038515896	KB국민은행	김재옥	4210240925	0	0	0	0	0	user	브론즈	t	\N	2026-07-15 05:48:48.859768	approved	630510	\N	\N	\N	\N	\N	f	10	f	\N	t	0	f	f
80271ffa-4f8d-430e-b95e-fd9a456063ae	sn0618	i1041635**	오승열	1097359665	우리은행	오승열	43907082778	0	0	0	0	0	user	브론즈	t	2026-07-14 01:26:34.774	2026-07-14 01:26:12.710432	approved	540618	\N	\N	\N	877fbaaa-35aa-4dc8-a141-2b7d2acc2cbf	220.65.239.134	f	10	f	\N	t	0	f	f
39be743b-bc70-4297-abb0-cb0e56c41d2f	조경해자양구	sungsu12	김성수	1037578603	하나은행	김성수	66291092813007	0	0	0	0	0	user	브론즈	t	2026-07-08 23:51:59.528	2026-07-08 17:39:52.127364	approved	850322	\N	\N	\N	877fbaaa-35aa-4dc8-a141-2b7d2acc2cbf	211.234.227.71	f	10	f	\N	t	0	f	f
13553385-c4b7-46c6-a476-b3c2da2dbeed	qwer1234	qwer1234	김복남	1077777777	KB국민은행	김복남	77777777777777777777	0	0	0	0	0	user	브론즈	t	2026-07-08 04:26:37.882	2026-07-07 05:56:20.742671	approved	500101	\N	\N	\N	\N	45.67.97.18	f	10	f	\N	t	0	f	f
bee3ac98-a63b-4c68-a854-b69a6e74f3fc	kk123555	wndud12@@!	김주영	1041085144	신한은행	김주영	110487203222	0	0	0	0	0	user	브론즈	t	2026-07-20 02:14:28.511	2026-07-20 02:09:19.89139	approved	870602	\N	\N	\N	877fbaaa-35aa-4dc8-a141-2b7d2acc2cbf	118.235.89.15	f	10	f	\N	t	0	f	f
1df9f2e7-8029-4302-9cf4-3625d0378d7a	sj0924	sktjdwns1@	안미란	1054329592	NH농협은행	안미란	59912040174	0	0	0	0	0	user	브론즈	t	2026-07-15 00:20:42.788	2026-07-14 01:15:10.914589	approved	770404	\N	\N	\N	\N	116.122.44.160	f	10	f	\N	t	0	f	f
cab56d54-635a-48c1-bfa5-e8da83724ea7	hwan2720	hydro7763@	장기환	1089952720	토스뱅크	장기환	100140452716	0	0	0	0	0	user	브론즈	t	2026-07-15 05:05:28.33	2026-07-15 05:03:19.540477	approved	770630	\N	\N	\N	\N	106.101.69.245	f	10	f	\N	t	0	f	f
9ee373bc-d591-4bc7-82e0-18c953b27d5c	luciferkr	fpwjdcjf2@	서정철	1081813828	NH농협은행	서정철	3520934997143	0	2000000	2087500	0	0	user	브론즈	t	2026-07-21 00:32:00.395	2026-07-21 00:31:48.364286	approved	861225	\N	\N	\N	\N	121.149.78.209	f	10	f	\N	t	0	f	f
a37c84ff-be4e-48d9-ae99-1f6823d793ea	myg5454 	moon5454	문영길	1087639756	카카오뱅크	문영길	3333 13 4859047 	3112500	3000000	165000	0	0	user	브론즈	f	2026-07-13 06:41:12.503	2026-07-13 06:40:40.995705	approved	551228	\N	\N	\N	877fbaaa-35aa-4dc8-a141-2b7d2acc2cbf	211.234.227.252	f	10	f	\N	t	0	f	f
f8d50cb0-b9c3-4343-bd68-825d0ac2546b	msp1010	msp393800!	박미석	1052151010	신한은행	박미석	98206038605	0	0	0	0	0	user	브론즈	t	2026-07-15 05:26:02.149	2026-07-15 05:24:53.35054	approved	581010	\N	\N	\N	\N	122.45.126.71	f	10	f	\N	t	0	f	f
738d9e1b-d3ba-4a3e-ae04-909b2f855b21	lauom	lr1762rd	이원재	1098070079	KB국민은행	이원재	117210953111	0	0	0	0	0	user	브론즈	t	2026-07-15 07:34:20.816	2026-07-15 07:33:59.433849	approved	630307	\N	\N	\N	\N	211.197.136.90	f	10	f	\N	t	0	f	f
3172253b-a312-48ad-a3fd-3f7e036be9b1	Syj2394 	syj631108*	서영종	1086512394	케이뱅크	서영종	1002941225525	0	0	0	0	0	user	브론즈	t	2026-07-22 09:04:29.614	2026-07-22 09:03:56.229955	approved	610720	\N	\N	\N	\N	118.235.5.116	f	10	f	\N	t	0	f	f
b74441c4-1858-43f0-afdc-fbfec02ce9d5	qwer123	qwer123	김만복	1088888888	신한은행	김만복	999999999999999	5915000	0	0	0	0	user	브론즈	t	2026-08-05 06:49:41.923	2026-07-07 00:57:16.946059	approved	900101	\N	\N	\N	\N	45.67.97.204	f	10	f	\N	t	0	f	f
f501ab5b-27c7-4682-8924-692946bf5e28	겨울비	480155	모경화	1044655505	신한은행	모경화	110391479600	0	0	0	0	0	user	브론즈	t	2026-07-30 02:57:45.749	2026-07-29 05:07:29.343464	approved	710501	\N	\N	\N	\N	118.235.91.144	f	10	f	\N	t	0	f	f
13e0933f-cea5-4749-8f0b-181658ee5e2b	hyeri0806	yun99240806@	윤혜리	1099428433	NH농협은행	윤혜리	3521201250393	0	0	0	0	0	user	브론즈	t	2026-08-03 02:24:21.955	2026-07-27 01:09:34.889107	approved	790926	\N	\N	\N	877fbaaa-35aa-4dc8-a141-2b7d2acc2cbf	194.114.136.62	f	10	f	\N	t	0	f	f
3007b845-7394-4cb1-81d7-7a5289591da2	ojm1199	119900	오재명 	1052346078	KB국민은행	오재명 	57860101012342	0	29850000	1000000	0	0	user	브론즈	t	2026-08-06 01:56:36.896	2026-07-22 06:53:05.991256	approved	490610	\N	\N	\N	877fbaaa-35aa-4dc8-a141-2b7d2acc2cbf	211.104.178.184	f	0	f	\N	t	0	f	f
55cd7cf5-4d59-4914-affa-f306a49ff5c2	크리스탈	jsw448100!!	정선우 	1088297176	NH농협은행	정선우 	32102339971	111922500	84000000	6471000	0	0	user	브론즈	t	2026-07-24 00:17:27.416	2026-07-23 07:48:41.770712	approved	750828	\N	\N	\N	\N	211.225.254.2	f	10	f	\N	t	0	f	f
4439d992-3b0d-43a1-becd-8ef186b3d934	jongbae109	qkrwhdqo0.	박종배	1076746560	토스뱅크	박종배	100195670933	0	0	0	0	0	user	브론즈	t	2026-08-05 03:32:22.967	2026-08-05 03:31:51.595828	approved	910228	\N	\N	\N	877fbaaa-35aa-4dc8-a141-2b7d2acc2cbf	223.39.83.57	f	10	f	\N	t	0	f	f
12b73c7f-9f06-4e98-9617-07cb693c2f4f	senskim81	Paul292513-	김성용	1027936800	IBK기업은행	김성용	1027936800	0	0	0	0	0	user	브론즈	t	2026-08-05 04:54:46.429	2026-08-05 04:38:09.364242	approved	811021	\N	\N	\N	877fbaaa-35aa-4dc8-a141-2b7d2acc2cbf	118.235.11.169	f	10	f	\N	t	0	f	f
330907d4-43f2-4aac-9c9c-6388705995fa	Kmg	m22313607	기미경 	1062690064	NH농협은행	기미경 	3120095269431	0	0	0	0	0	user	브론즈	t	\N	2026-08-05 05:06:57.824591	approved	720250	\N	\N	\N	\N	\N	f	10	f	\N	t	0	f	f
f86800a3-aa14-4f70-877a-0749225b5f5f	ojm5959	119900	오재명 	1052346078	KB국민은행	오재명 	57860101012342	0	0	0	0	0	user	브론즈	t	\N	2026-08-06 01:42:31.384787	approved	490610	\N	\N	\N	\N	\N	f	10	f	\N	t	0	f	f
691e57e6-502e-447d-ae4e-aa275486ee4c	demo	demo123	데모 사용자	\N	\N	\N	\N	10039000	0	0	0	0	user	브론즈	t	2026-08-14 04:08:51.841	2026-08-09 11:19:58.013411	approved	\N	\N	\N	\N	\N	146.70.201.223	f	10	f	\N	t	0	f	f
2bbf726e-9087-4160-87df-2f5910473c7d	Ojm5959 	119900	오재명 	1052346078	KB국민은행	오재명 	57860101012342	0	0	0	0	0	user	브론즈	t	\N	2026-08-06 01:45:53.178859	approved	490610	\N	\N	\N	\N	\N	f	10	f	\N	t	0	f	f
\.


--
-- Name: affiliate_commissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.affiliate_commissions_id_seq', 1, false);


--
-- Name: affiliate_settlements_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.affiliate_settlements_id_seq', 1, false);


--
-- Name: announcements_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.announcements_id_seq', 1, false);


--
-- Name: bets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.bets_id_seq', 369, false);


--
-- Name: blocked_ips_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.blocked_ips_id_seq', 1, false);


--
-- Name: branches_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.branches_id_seq', 1, false);


--
-- Name: forex_candles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.forex_candles_id_seq', 159364, true);


--
-- Name: inquiries_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.inquiries_id_seq', 1, false);


--
-- Name: inquiry_templates_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.inquiry_templates_id_seq', 1, false);


--
-- Name: login_history_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.login_history_id_seq', 94, false);


--
-- Name: maintenance_symbols_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.maintenance_symbols_id_seq', 1, false);


--
-- Name: messages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.messages_id_seq', 1, false);


--
-- Name: round_forced_directions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.round_forced_directions_id_seq', 270, false);


--
-- Name: round_results_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.round_results_id_seq', 1, false);


--
-- Name: transaction_requests_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.transaction_requests_id_seq', 73, false);


--
-- Name: affiliate_commissions affiliate_commissions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.affiliate_commissions
    ADD CONSTRAINT affiliate_commissions_pkey PRIMARY KEY (id);


--
-- Name: affiliate_settlements affiliate_settlements_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.affiliate_settlements
    ADD CONSTRAINT affiliate_settlements_pkey PRIMARY KEY (id);


--
-- Name: affiliates affiliates_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.affiliates
    ADD CONSTRAINT affiliates_pkey PRIMARY KEY (id);


--
-- Name: affiliates affiliates_referral_code_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.affiliates
    ADD CONSTRAINT affiliates_referral_code_key UNIQUE (referral_code);


--
-- Name: affiliates affiliates_username_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.affiliates
    ADD CONSTRAINT affiliates_username_key UNIQUE (username);


--
-- Name: announcements announcements_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.announcements
    ADD CONSTRAINT announcements_pkey PRIMARY KEY (id);


--
-- Name: bets bets_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bets
    ADD CONSTRAINT bets_pkey PRIMARY KEY (id);


--
-- Name: blocked_ips blocked_ips_ip_address_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.blocked_ips
    ADD CONSTRAINT blocked_ips_ip_address_key UNIQUE (ip_address);


--
-- Name: blocked_ips blocked_ips_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.blocked_ips
    ADD CONSTRAINT blocked_ips_pkey PRIMARY KEY (id);


--
-- Name: branches branches_code_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.branches
    ADD CONSTRAINT branches_code_key UNIQUE (code);


--
-- Name: branches branches_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.branches
    ADD CONSTRAINT branches_pkey PRIMARY KEY (id);


--
-- Name: forex_candles forex_candles_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.forex_candles
    ADD CONSTRAINT forex_candles_pkey PRIMARY KEY (id);


--
-- Name: forex_candles forex_candles_symbol_duration_time_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.forex_candles
    ADD CONSTRAINT forex_candles_symbol_duration_time_key UNIQUE (symbol, duration, "time");


--
-- Name: inquiries inquiries_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inquiries
    ADD CONSTRAINT inquiries_pkey PRIMARY KEY (id);


--
-- Name: inquiry_templates inquiry_templates_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inquiry_templates
    ADD CONSTRAINT inquiry_templates_pkey PRIMARY KEY (id);


--
-- Name: login_history login_history_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.login_history
    ADD CONSTRAINT login_history_pkey PRIMARY KEY (id);


--
-- Name: maintenance_symbols maintenance_symbols_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.maintenance_symbols
    ADD CONSTRAINT maintenance_symbols_pkey PRIMARY KEY (id);


--
-- Name: maintenance_symbols maintenance_symbols_symbol_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.maintenance_symbols
    ADD CONSTRAINT maintenance_symbols_symbol_key UNIQUE (symbol);


--
-- Name: messages messages_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id);


--
-- Name: round_forced_directions round_forced_directions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.round_forced_directions
    ADD CONSTRAINT round_forced_directions_pkey PRIMARY KEY (id);


--
-- Name: round_results round_results_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.round_results
    ADD CONSTRAINT round_results_pkey PRIMARY KEY (id);


--
-- Name: settings settings_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.settings
    ADD CONSTRAINT settings_pkey PRIMARY KEY (key);


--
-- Name: transaction_requests transaction_requests_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.transaction_requests
    ADD CONSTRAINT transaction_requests_pkey PRIMARY KEY (id);


--
-- Name: user_sessions user_sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_sessions
    ADD CONSTRAINT user_sessions_pkey PRIMARY KEY (sid);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- Name: IDX_user_sessions_expire; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_user_sessions_expire" ON public.user_sessions USING btree (expire);


--
-- Name: bets bets_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bets
    ADD CONSTRAINT bets_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: inquiries inquiries_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inquiries
    ADD CONSTRAINT inquiries_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: login_history login_history_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.login_history
    ADD CONSTRAINT login_history_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: messages messages_receiver_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_receiver_id_fkey FOREIGN KEY (receiver_id) REFERENCES public.users(id);


--
-- Name: messages messages_sender_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_sender_id_fkey FOREIGN KEY (sender_id) REFERENCES public.users(id);


--
-- Name: transaction_requests transaction_requests_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.transaction_requests
    ADD CONSTRAINT transaction_requests_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- PostgreSQL database dump complete
--

\unrestrict 6aCTOfkf0Y221gQp5F9e5J7IJMltK99p81a3wI78DVKZ4nNDo2JSVtmochdNncy

