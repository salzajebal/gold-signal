--
-- PostgreSQL database dump
--

\restrict 3Umb9Ve1n9rLvSsNgVNUyCNqvjVz4KiImKyph3hxtpbbZBo7dIrvZHggjdPv0vP

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

ALTER TABLE IF EXISTS ONLY public.transaction_requests DROP CONSTRAINT IF EXISTS transaction_requests_user_id_users_id_fk;
ALTER TABLE IF EXISTS ONLY public.messages DROP CONSTRAINT IF EXISTS messages_sender_id_users_id_fk;
ALTER TABLE IF EXISTS ONLY public.messages DROP CONSTRAINT IF EXISTS messages_receiver_id_users_id_fk;
ALTER TABLE IF EXISTS ONLY public.login_history DROP CONSTRAINT IF EXISTS login_history_user_id_users_id_fk;
ALTER TABLE IF EXISTS ONLY public.inquiries DROP CONSTRAINT IF EXISTS inquiries_user_id_users_id_fk;
ALTER TABLE IF EXISTS ONLY public.bets DROP CONSTRAINT IF EXISTS bets_user_id_users_id_fk;
DROP INDEX IF EXISTS public.forex_candles_symbol_duration_time_idx;
DROP INDEX IF EXISTS public."IDX_user_sessions_expire";
ALTER TABLE IF EXISTS ONLY public.users DROP CONSTRAINT IF EXISTS users_username_unique;
ALTER TABLE IF EXISTS ONLY public.users DROP CONSTRAINT IF EXISTS users_pkey;
ALTER TABLE IF EXISTS ONLY public.user_sessions DROP CONSTRAINT IF EXISTS user_sessions_pkey;
ALTER TABLE IF EXISTS ONLY public.transaction_requests DROP CONSTRAINT IF EXISTS transaction_requests_pkey;
ALTER TABLE IF EXISTS ONLY public.settings DROP CONSTRAINT IF EXISTS settings_pkey;
ALTER TABLE IF EXISTS ONLY public.round_results DROP CONSTRAINT IF EXISTS round_results_pkey;
ALTER TABLE IF EXISTS ONLY public.round_forced_directions DROP CONSTRAINT IF EXISTS round_forced_directions_pkey;
ALTER TABLE IF EXISTS ONLY public.messages DROP CONSTRAINT IF EXISTS messages_pkey;
ALTER TABLE IF EXISTS ONLY public.maintenance_symbols DROP CONSTRAINT IF EXISTS maintenance_symbols_symbol_unique;
ALTER TABLE IF EXISTS ONLY public.maintenance_symbols DROP CONSTRAINT IF EXISTS maintenance_symbols_pkey;
ALTER TABLE IF EXISTS ONLY public.login_history DROP CONSTRAINT IF EXISTS login_history_pkey;
ALTER TABLE IF EXISTS ONLY public.inquiry_templates DROP CONSTRAINT IF EXISTS inquiry_templates_pkey;
ALTER TABLE IF EXISTS ONLY public.inquiries DROP CONSTRAINT IF EXISTS inquiries_pkey;
ALTER TABLE IF EXISTS ONLY public.forex_candles DROP CONSTRAINT IF EXISTS forex_candles_pkey;
ALTER TABLE IF EXISTS ONLY public.branches DROP CONSTRAINT IF EXISTS branches_pkey;
ALTER TABLE IF EXISTS ONLY public.branches DROP CONSTRAINT IF EXISTS branches_code_unique;
ALTER TABLE IF EXISTS ONLY public.blocked_ips DROP CONSTRAINT IF EXISTS blocked_ips_pkey;
ALTER TABLE IF EXISTS ONLY public.blocked_ips DROP CONSTRAINT IF EXISTS blocked_ips_ip_address_unique;
ALTER TABLE IF EXISTS ONLY public.bets DROP CONSTRAINT IF EXISTS bets_pkey;
ALTER TABLE IF EXISTS ONLY public.announcements DROP CONSTRAINT IF EXISTS announcements_pkey;
ALTER TABLE IF EXISTS ONLY public.affiliates DROP CONSTRAINT IF EXISTS affiliates_username_unique;
ALTER TABLE IF EXISTS ONLY public.affiliates DROP CONSTRAINT IF EXISTS affiliates_referral_code_unique;
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
-- *not* dropping schema, since initdb creates it
--
-- Name: public; Type: SCHEMA; Schema: -; Owner: -
--

-- *not* creating schema, since initdb creates it


--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA public IS '';


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
    round_number integer DEFAULT 1 NOT NULL,
    strike_price numeric(20,8) NOT NULL,
    close_price numeric(20,8),
    payout numeric(20,8),
    multiplier numeric(5,2) DEFAULT 2.00 NOT NULL,
    outcome text DEFAULT 'pending'::text NOT NULL,
    forced_outcome text,
    max_execution_applied boolean DEFAULT false NOT NULL,
    original_amount numeric(20,8),
    expires_at timestamp without time zone NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    settled_at timestamp without time zone,
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
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    is_reply_read boolean DEFAULT false NOT NULL
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
    deleted_for_user boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL
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
    birth_date text,
    resident_number text,
    region text,
    bank_name text,
    account_holder text,
    account_number text,
    balance numeric(20,0) DEFAULT '0'::numeric NOT NULL,
    total_deposit numeric(20,0) DEFAULT '0'::numeric NOT NULL,
    total_withdrawal numeric(20,0) DEFAULT '0'::numeric NOT NULL,
    total_bet numeric(20,0) DEFAULT '0'::numeric NOT NULL,
    total_win numeric(20,0) DEFAULT '0'::numeric NOT NULL,
    role text DEFAULT 'user'::text NOT NULL,
    branch_code text,
    affiliate_id character varying,
    is_active boolean DEFAULT true NOT NULL,
    approval_status text DEFAULT 'pending'::text NOT NULL,
    last_login_at timestamp without time zone,
    last_login_ip text,
    auto_bet_enabled boolean DEFAULT false NOT NULL,
    auto_bet_multiplier real DEFAULT 10 NOT NULL,
    is_betting_blocked boolean DEFAULT false NOT NULL,
    forced_bet_direction text,
    max_execution_enabled boolean DEFAULT true NOT NULL,
    pending_balance_adjustment numeric(20,0) DEFAULT '0'::numeric NOT NULL,
    grade text DEFAULT '브론즈'::text NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
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
\.


--
-- Data for Name: announcements; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.announcements (id, title, content, is_active, is_pinned, display_date, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: bets; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.bets (id, user_id, symbol, direction, amount, duration, round_number, strike_price, close_price, payout, multiplier, outcome, forced_outcome, max_execution_applied, original_amount, expires_at, created_at, settled_at, balance_before, balance_after) FROM stdin;
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
877	SP500	180	1776049560	6817.200317	6817.566148	6815.270146	6816.861158
2834	DOW	180	1776051180	47915.196299	47923.388214	47908.466890	47914.728150
878	DOW	180	1776049560	47914.910589	47925.298515	47907.580193	47917.886369
673	SP500	180	1776049380	6816.543024	6817.791236	6815.766504	6817.177885
674	DOW	180	1776049380	47918.212970	47923.827628	47912.760538	47915.973561
879	DXY	180	1776049560	99.024489	99.026624	99.007290	99.018079
675	DXY	180	1776049380	99.027999	99.033626	99.005872	99.022830
466	DOW	300	1776049200	47918.541748	47927.572594	47912.018467	47923.827628
1890	DXY	300	1776050400	99.029528	99.042659	99.016432	99.030912
468	DXY	300	1776049200	99.036203	99.042730	99.016226	99.021646
271	SP500	180	1776049020	6816.890000	6817.442268	6815.923848	6816.897363
137382	DOW	300	1781161200	49912.793071	49929.427055	49910.658570	49918.329272
273	DOW	180	1776049020	47916.570000	47923.545373	47911.143708	47916.735060
148	DOW	300	1776048900	47916.545496	47923.545373	47906.112598	47916.735060
275	DXY	180	1776049020	99.027000	99.047436	99.018111	99.035549
150	DXY	300	1776048900	99.027264	99.047436	99.013737	99.035549
137383	DXY	300	1781161200	100.001144	100.025486	99.987807	99.988664
73	SP500	180	1776048840	6817.001158	6817.669891	6815.866679	6816.990672
75	DOW	180	1776048840	47914.321482	47923.539361	47903.265319	47915.858588
77	DXY	180	1776048840	99.020253	99.032692	99.011621	99.026586
1951	SP500	180	1776050460	6817.084877	6817.587701	6815.724528	6816.722207
144853	DXY	300	1781173500	100.137364	100.162544	100.130789	100.159000
1952	DOW	180	1776050460	47917.397839	47920.933511	47905.578179	47915.064396
1953	DXY	180	1776050460	99.026322	99.042659	99.016432	99.025121
1318	SP500	180	1776049920	6816.337713	6818.371409	6815.527468	6817.257845
137381	SP500	300	1781161200	7266.279135	7268.137290	7265.643193	7267.145201
1319	DOW	180	1776049920	47920.138488	47924.201544	47904.148154	47919.024707
1172	DOW	300	1776049800	47921.572146	47926.578384	47904.148154	47919.024707
1320	DXY	180	1776049920	99.019182	99.027206	99.003056	99.021907
4	DOW	300	1776048600	47916.570000	47923.186751	47903.265319	47915.936845
1173	DXY	300	1776049800	99.022739	99.027206	98.997389	99.021907
6	DXY	300	1776048600	99.023000	99.032692	99.011621	99.026679
1	SP500	180	1776048660	6816.890000	6817.261459	6816.008098	6817.033698
3	DOW	180	1776048660	47916.570000	47923.186751	47913.959649	47915.977977
1096	SP500	180	1776049740	6817.078878	6817.725906	6815.898862	6816.133386
5	DXY	180	1776048660	99.023000	99.028463	99.020359	99.022182
463	SP500	180	1776049200	6816.672074	6818.059906	6815.420618	6816.441347
821	DOW	300	1776049500	47923.713155	47925.298515	47907.580193	47921.441959
465	DOW	180	1776049200	47918.541748	47927.572594	47912.018467	47919.664165
1097	DOW	180	1776049740	47919.398774	47926.578384	47907.774833	47918.285944
467	DXY	180	1776049200	99.036203	99.042730	99.023155	99.027555
822	DXY	300	1776049500	99.020214	99.026624	99.005499	99.021442
144851	SP500	300	1781173500	7266.755651	7268.042333	7265.258158	7266.990000
1098	DXY	180	1776049740	99.019287	99.023842	98.997389	99.016775
2616	DXY	300	1776051000	99.032978	99.041776	99.020043	99.036676
2611	SP500	180	1776051000	6817.097415	6817.387117	6815.727853	6817.029021
144852	DOW	300	1781173500	49920.694747	49929.095050	49910.421751	49918.780000
2613	DOW	180	1776051000	47919.500308	47923.958023	47907.267920	47916.188857
2170	SP500	180	1776050640	6816.627348	6817.799477	6815.794792	6816.389803
2171	DOW	180	1776050640	47915.634091	47925.092421	47909.243851	47916.663946
1753	SP500	180	1776050280	6816.890000	6817.603499	6815.254574	6817.046007
2615	DXY	180	1776051000	99.032978	99.041776	99.023075	99.028165
1755	DOW	180	1776050280	47916.570000	47921.752033	47907.996625	47917.272002
1540	DOW	300	1776050100	47917.765623	47928.272524	47909.823671	47917.914107
2172	DXY	180	1776050640	99.023285	99.041430	99.023285	99.036188
1542	DXY	300	1776050100	99.022335	99.044610	99.015014	99.027540
1757	DXY	180	1776050280	99.027000	99.044610	99.022513	99.024433
3274	SP500	180	1776051540	6816.850884	6817.960809	6815.243240	6816.798927
1537	SP500	180	1776050100	6817.075972	6817.996693	6815.913450	6817.197894
1539	DOW	180	1776050100	47917.765623	47928.272524	47909.823671	47919.429195
1541	DXY	180	1776050100	99.022335	99.041368	99.015014	99.015014
2392	SP500	180	1776050820	6816.354623	6818.087095	6816.050809	6817.353030
171691	DXY	300	1781575800	99.676299	99.697844	99.668512	99.692840
2393	DOW	180	1776050820	47915.937230	47922.287975	47907.127521	47918.292561
1888	DOW	300	1776050400	47917.240942	47922.882180	47905.578179	47920.237193
2246	DOW	300	1776050700	47922.094811	47925.092421	47907.127521	47918.292561
2982	DXY	300	1776051300	99.037276	99.041387	99.012549	99.032049
3056	DOW	180	1776051360	47916.411318	47925.796916	47910.737699	47918.956905
171689	SP500	300	1781575800	7554.385037	7555.540394	7553.170265	7553.860196
2394	DXY	180	1776050820	99.035779	99.038541	99.019939	99.031686
2247	DXY	300	1776050700	99.032326	99.041430	99.019939	99.031686
171690	DOW	300	1781575800	51672.870935	51675.516771	51662.946478	51668.967822
2835	DXY	180	1776051180	99.028738	99.041387	99.020043	99.035449
3057	DXY	180	1776051360	99.035677	99.037387	99.012549	99.025099
3275	DOW	180	1776051540	47920.349044	47922.670515	47911.635923	47915.293913
2614	DOW	300	1776051000	47919.500308	47923.958023	47907.267920	47918.778035
2833	SP500	180	1776051180	6817.073845	6817.955910	6815.319693	6816.691735
3498	DXY	180	1776051720	99.025287	99.039349	99.018505	99.031802
3055	SP500	180	1776051360	6816.828219	6818.138635	6815.982441	6816.601961
2981	DOW	300	1776051300	47918.315839	47925.796916	47910.737699	47913.433605
3276	DXY	180	1776051540	99.026307	99.038733	99.017245	99.026749
3496	SP500	180	1776051720	6816.721048	6817.402032	6815.965197	6816.873043
3497	DOW	180	1776051720	47916.673255	47924.147290	47908.647296	47916.933700
174582	DOW	300	1782115200	51561.172085	51569.623015	51550.090420	51560.012060
3350	DOW	300	1776051600	47914.579059	47924.147290	47908.647296	47916.933700
3351	DXY	300	1776051600	99.031834	99.039349	99.017245	99.031802
174583	DXY	300	1782115200	100.986005	100.989600	100.958694	100.974383
3715	SP500	180	1776051900	6816.717780	6818.290450	6815.676675	6816.538569
5027	DOW	180	1776053160	47912.326213	47928.213543	47909.484663	47917.876338
5969	DXY	180	1776055680	99.027785	99.039708	99.014800	99.027277
5028	DXY	180	1776053160	99.020482	99.021597	98.998129	99.004470
4588	SP500	180	1776052800	6817.189070	6817.988957	6816.175485	6817.636672
4590	DOW	180	1776052800	47917.131183	47921.378494	47910.568696	47917.569525
4592	DXY	180	1776052800	99.016134	99.029978	99.008917	99.019197
5884	DOW	300	1776055500	47916.570000	47923.634737	47908.736088	47914.979126
3931	SP500	180	1776052080	6816.643669	6817.701693	6815.697945	6816.401716
5467	SP500	180	1776053520	6816.260662	6817.758357	6815.938537	6816.897669
3932	DOW	180	1776052080	47911.634504	47924.135495	47910.233726	47917.327762
3933	DXY	180	1776052080	99.028804	99.041870	99.016923	99.024038
5468	DOW	180	1776053520	47919.000340	47921.888875	47910.877867	47918.815511
3718	DOW	300	1776051900	47918.500772	47924.135495	47908.384178	47917.417625
3720	DXY	300	1776051900	99.032318	99.043414	99.020167	99.034008
137560	DXY	300	1781161500	99.986290	100.019058	99.983621	100.004903
5321	DOW	300	1776053400	47919.247756	47921.888875	47909.573176	47918.815511
4372	SP500	180	1776052620	6816.640416	6817.761792	6815.900825	6817.040779
145033	DXY	300	1781173800	100.158167	100.161724	100.123441	100.131000
4153	SP500	180	1776052260	6816.207672	6818.136113	6815.864425	6815.917573
137558	SP500	300	1781161500	7267.109958	7268.734138	7265.309252	7266.715953
4154	DOW	180	1776052260	47917.727451	47924.385171	47909.322816	47922.034368
4079	DOW	300	1776052200	47918.353015	47924.385171	47909.322816	47922.034368
4155	DXY	180	1776052260	99.026159	99.028227	99.005717	99.010857
4080	DXY	300	1776052200	99.033295	99.034965	99.005717	99.010857
137559	DOW	300	1781161500	49917.916258	49930.036193	49909.714853	49920.243537
4374	DOW	180	1776052620	47917.587168	47924.861627	47913.076450	47916.047897
4333	DOW	300	1776052500	47916.570000	47924.861627	47907.310853	47916.047897
4376	DXY	180	1776052620	99.019384	99.031739	99.012869	99.017715
4335	DXY	300	1776052500	99.021000	99.033366	99.012869	99.017715
3717	DOW	180	1776051900	47918.500772	47921.981670	47908.384178	47912.863470
5469	DXY	180	1776053520	99.013625	99.028247	99.001150	99.010387
3719	DXY	180	1776051900	99.032318	99.043414	99.020167	99.029359
5322	DXY	300	1776053400	98.998106	99.028247	98.989658	99.010387
4804	SP500	180	1776052980	6817.780437	6818.058834	6815.710236	6816.321530
5245	SP500	180	1776053340	6816.455692	6818.597295	6816.126032	6816.185718
4805	DOW	180	1776052980	47916.825276	47926.424271	47907.888302	47914.235088
4806	DXY	180	1776052980	99.019442	99.023915	99.008452	99.018884
5246	DOW	180	1776053340	47917.824528	47927.037421	47909.573176	47918.492580
5247	DXY	180	1776053340	99.002877	99.018034	98.989658	99.013714
4330	SP500	180	1776052440	6816.890000	6817.671731	6816.355611	6816.826864
5686	SP500	180	1776053700	6817.077269	6817.815887	6816.250023	6817.460722
5688	DOW	180	1776053700	47918.789696	47921.732021	47908.244730	47911.064969
4332	DOW	180	1776052440	47916.570000	47918.293969	47907.310853	47918.293969
5689	DOW	300	1776053700	47918.789696	47921.732021	47908.244730	47911.064969
5690	DXY	180	1776053700	99.010118	99.024913	99.005232	99.015763
4334	DXY	180	1776052440	99.021000	99.033366	99.016988	99.019712
145213	DXY	300	1781174100	100.129882	100.152355	100.125461	100.142648
5691	DXY	300	1776053700	99.010118	99.024913	99.005232	99.015763
4952	DOW	300	1776053100	47914.941350	47928.213543	47907.888302	47917.436705
4953	DXY	300	1776053100	99.014783	99.021915	98.998129	99.000095
145031	SP500	300	1781173800	7267.017794	7267.922408	7265.151809	7266.990000
145032	DOW	300	1781173800	49918.194467	49927.351842	49910.379939	49918.780000
4591	DOW	300	1776052800	47917.131183	47923.816420	47908.164525	47913.415776
4593	DXY	300	1776052800	99.016134	99.029978	99.008452	99.013853
5886	DXY	300	1776055500	99.023000	99.039708	99.010353	99.015031
6183	DOW	180	1776055860	47910.394634	47924.900366	47910.394634	47912.057755
5026	SP500	180	1776053160	6816.217984	6818.146741	6815.993893	6816.469483
5881	SP500	180	1776055500	6816.890000	6817.916608	6816.450217	6817.916608
5883	DOW	180	1776055500	47916.570000	47920.722039	47912.520329	47914.558539
6114	DXY	300	1776055800	99.015575	99.035989	99.008171	99.020787
5885	DXY	180	1776055500	99.023000	99.033546	99.010353	99.027408
6185	DXY	180	1776055860	99.027507	99.031531	99.008171	99.019261
6615	DOW	180	1776056220	47917.018531	47918.181355	47916.415029	47917.777382
6397	SP500	180	1776056040	6816.797543	6818.799722	6815.977282	6816.742107
6472	DOW	300	1776056100	47919.663362	47925.646096	47908.459193	47917.777382
5965	SP500	180	1776055680	6818.056929	6818.056929	6816.041019	6816.923257
6628	SP500	180	1776057660	6816.780759	6818.132627	6815.895714	6817.151475
6617	DXY	180	1776056220	99.014908	99.016000	99.013240	99.015498
6474	DXY	300	1776056100	99.018373	99.024968	99.006187	99.015498
6622	SP500	180	1776057480	6816.890000	6816.890000	6816.546931	6816.546931
5967	DOW	180	1776055680	47914.828876	47923.634737	47908.736088	47912.260488
6399	DOW	180	1776056040	47910.683154	47925.646096	47908.459193	47915.524243
6849	DXY	180	1776057840	99.041910	99.045601	99.016596	99.032344
145211	SP500	300	1781174100	7266.757511	7267.953343	7265.717916	7266.764369
6181	SP500	180	1776055860	6817.041161	6817.542837	6816.251896	6816.889092
6401	DXY	180	1776056040	99.020281	99.031488	99.006187	99.014609
6112	DOW	300	1776055800	47916.200673	47924.900366	47908.941588	47918.982155
145212	DOW	300	1781174100	49918.904136	49925.289173	49904.724425	49919.427776
6629	DOW	180	1776057660	47915.070866	47925.083216	47909.415814	47914.173052
6613	SP500	180	1776056220	6816.847402	6817.173413	6816.570542	6816.570542
6624	DOW	180	1776057480	47916.570000	47916.570000	47913.912610	47914.176187
6626	DXY	180	1776057480	99.038000	99.038906	99.036437	99.037936
6630	DXY	180	1776057660	99.037001	99.051551	99.025555	99.042583
6625	DOW	300	1776057600	47916.570000	47925.083216	47906.752751	47915.732231
6848	DOW	180	1776057840	47912.870500	47923.536606	47906.752751	47917.851843
6627	DXY	300	1776057600	99.038000	99.051551	99.025555	99.036927
150510	DOW	300	1781253000	50848.750000	50848.750000	50845.592826	50845.592826
150511	DXY	300	1781253000	99.707000	99.710831	99.707000	99.708117
6847	SP500	180	1776057840	6817.042010	6817.852589	6815.957515	6817.082299
7290	DOW	180	1776058200	47914.500122	47924.675945	47912.244247	47916.561277
7291	DOW	300	1776058200	47914.500122	47924.675945	47912.244247	47916.561277
7292	DXY	180	1776058200	99.033543	99.040239	99.022368	99.038615
7293	DXY	300	1776058200	99.033543	99.040239	99.022368	99.038615
8458	SP500	180	1776061980	6817.579289	6818.240713	6815.874461	6816.705317
9544	SP500	180	1776062880	6816.767974	6817.693697	6815.807995	6816.788776
8459	DOW	180	1776061980	47920.156721	47926.310116	47908.239803	47921.025305
8460	DXY	180	1776061980	98.999103	98.999877	98.961679	98.983966
8170	SP500	180	1776061620	6816.890000	6817.922174	6815.967056	6816.811530
8172	DOW	180	1776061620	47916.570000	47923.307631	47911.942417	47911.942417
8173	DOW	300	1776061500	47916.570000	47923.307631	47911.942417	47911.942417
8174	DXY	180	1776061620	98.988000	99.003274	98.984205	99.001249
8175	DXY	300	1776061500	98.988000	99.003274	98.984205	99.001249
137740	DXY	300	1781161800	100.004726	100.010972	99.972272	99.987236
7789	SP500	180	1776060000	6816.919204	6817.459889	6816.122606	6817.316015
7791	DOW	180	1776060000	47914.549412	47924.173871	47910.403382	47921.349086
7570	SP500	180	1776059820	6816.321822	6818.365142	6815.699849	6817.066759
145393	DXY	300	1781174400	100.141169	100.154207	100.118080	100.124000
7571	DOW	180	1776059820	47919.576903	47926.053144	47906.231656	47913.964787
7424	DOW	300	1776059700	47914.768803	47926.053144	47906.231656	47913.964787
7572	DXY	180	1776059820	99.018738	99.022063	99.002511	99.009242
7425	DXY	300	1776059700	99.020933	99.022063	99.002511	99.009242
137738	SP500	300	1781161800	7266.465706	7268.414774	7265.175820	7266.942331
137739	DOW	300	1781161800	49921.557588	49928.489554	49912.309073	49920.263614
7384	DOW	300	1776059400	47916.570000	47921.320924	47910.138772	47914.862880
7386	DXY	300	1776059400	99.015000	99.020786	99.005171	99.018693
7793	DXY	180	1776060000	99.010783	99.026236	99.003494	99.020388
9962	DOW	180	1776063240	47915.492883	47925.987205	47913.345291	47921.928692
9331	DOW	300	1776062700	47917.398403	47926.454581	47902.982378	47917.321357
10185	DXY	180	1776063420	99.065656	99.073280	99.044570	99.064065
8680	SP500	180	1776062160	6816.694128	6818.429021	6816.382857	6816.964626
9112	SP500	180	1776062520	6816.683812	6817.927065	6815.702357	6816.924999
8681	DOW	180	1776062160	47922.094030	47927.850778	47909.415635	47915.833276
8682	DXY	180	1776062160	98.984893	98.999291	98.970702	98.997338
7069	SP500	180	1776058020	6817.067429	6817.689541	6815.899307	6816.929292
7070	DOW	180	1776058020	47916.376730	47924.806203	47910.861345	47916.060441
6923	DOW	300	1776057900	47914.482943	47924.806203	47909.320199	47916.060441
7071	DXY	180	1776058020	99.029895	99.046245	99.026339	99.034414
6924	DXY	300	1776057900	99.037105	99.046245	99.016596	99.034414
9114	DOW	180	1776062520	47916.081642	47924.590734	47904.809010	47918.490533
7381	SP500	180	1776059640	6816.890000	6818.099069	6815.908464	6816.591933
7383	DOW	180	1776059640	47916.570000	47923.076027	47908.679053	47920.809674
7385	DXY	180	1776059640	99.015000	99.020933	99.003728	99.017538
8971	DOW	300	1776062400	47914.705846	47924.590734	47904.809010	47918.490533
9116	DXY	180	1776062520	98.993122	99.004110	98.979069	99.002392
8973	DXY	300	1776062400	98.995844	99.004110	98.979069	99.002392
150509	SP500	300	1781253000	7394.300000	7394.527271	7393.818089	7394.527271
7288	SP500	180	1776058200	6817.188403	6817.980220	6816.172037	6816.339142
145391	SP500	300	1781174400	7266.571755	7268.315205	7265.624240	7266.990000
8011	SP500	180	1776060180	6817.240406	6817.576187	6815.768487	6816.364342
145392	DOW	300	1781174400	49920.848956	49930.796648	49911.681326	49918.780000
8012	DOW	180	1776060180	47920.398475	47921.675969	47911.114690	47919.813207
7792	DOW	300	1776060000	47914.549412	47924.173871	47910.403382	47919.813207
8013	DXY	180	1776060180	99.017982	99.030526	99.004489	99.023934
7794	DXY	300	1776060000	99.010783	99.030526	99.003494	99.023934
8236	SP500	180	1776061800	6816.926956	6817.808442	6815.919359	6817.321954
8899	SP500	180	1776062340	6816.765392	6817.451651	6815.498200	6816.612686
8238	DOW	180	1776061800	47913.669863	47925.354756	47910.953331	47919.253756
8240	DXY	180	1776061800	99.001434	99.011548	98.980991	98.998193
8239	DOW	300	1776061800	47913.669863	47926.310116	47910.953331	47913.048483
8900	DOW	180	1776062340	47917.113298	47921.157637	47909.202133	47916.384014
8901	DXY	180	1776062340	98.998016	99.002934	98.983162	98.992579
8241	DXY	300	1776061800	99.001434	99.011548	98.967225	98.969690
9328	SP500	180	1776062700	6816.656528	6817.957676	6815.105216	6816.907905
9686	DOW	300	1776063000	47918.012754	47922.919233	47905.868540	47915.396883
8606	DOW	300	1776062100	47912.977199	47927.850778	47908.239803	47915.857342
9330	DOW	180	1776062700	47917.398403	47926.454581	47902.982378	47917.112739
8607	DXY	300	1776062100	98.969284	99.002934	98.961679	98.997032
150515	SP500	300	1781253300	7394.735973	7396.396440	7392.982778	7394.480767
9333	DXY	300	1776062700	99.000609	99.029630	98.987254	99.018007
150516	DOW	300	1781253300	50846.025192	50858.312779	50831.577450	50855.689191
9545	DOW	180	1776062880	47916.497652	47924.833081	47909.902488	47917.251594
9332	DXY	180	1776062700	99.000609	99.029630	98.987254	99.023950
9762	DXY	180	1776063060	99.029827	99.056150	99.024295	99.047846
9760	SP500	180	1776063060	6816.533047	6818.810180	6816.026182	6817.222890
9961	SP500	180	1776063240	6817.352923	6818.215027	6816.016467	6816.461891
9546	DXY	180	1776062880	99.025800	99.033920	99.006634	99.028104
10184	DOW	180	1776063420	47920.839002	47925.981828	47904.321984	47916.505432
9761	DOW	180	1776063060	47917.495788	47922.919233	47905.868540	47916.401194
9963	DXY	180	1776063240	99.047742	99.064481	99.040557	99.063674
150517	DXY	300	1781253300	99.708216	99.751135	99.699290	99.744509
9687	DXY	300	1776063000	99.015951	99.060650	99.011261	99.040957
10038	DXY	300	1776063300	99.043143	99.073280	99.040557	99.064065
10183	SP500	180	1776063420	6816.267082	6817.756328	6815.258590	6816.905374
153943	DXY	300	1781259900	99.691000	99.700698	99.677990	99.677990
10037	DOW	300	1776063300	47914.615896	47925.987205	47904.321984	47916.505432
10390	SP500	180	1776063600	6816.933290	6818.296009	6815.974052	6815.975976
10392	DOW	180	1776063600	47916.596981	47923.701461	47910.662711	47920.164700
11966	DOW	300	1776065100	47916.570000	47927.749613	47908.005703	47917.546937
11967	DXY	300	1776065100	98.982000	98.995125	98.954879	98.963168
12150	DXY	300	1776065400	98.973000	98.981508	98.945794	98.956122
13409	DOW	300	1776067500	47912.084834	47923.360976	47909.945525	47917.842921
13410	DXY	300	1776067500	98.912688	98.934151	98.892592	98.910652
137920	DXY	300	1781162100	99.986718	99.991911	99.964120	99.966646
11786	DOW	300	1776064800	47916.754169	47931.361352	47908.501092	47914.807090
11787	DXY	300	1776064800	98.998925	99.003859	98.971712	98.989535
11671	SP500	180	1776064680	6817.120703	6817.798515	6815.966835	6816.800740
11673	DOW	180	1776064680	47912.344508	47923.147589	47909.052662	47917.587335
12689	DOW	300	1776066300	47918.772899	47925.236322	47907.050258	47913.910366
11675	DXY	180	1776064680	98.981806	98.992811	98.972894	98.992811
10394	DXY	180	1776063600	99.064423	99.065721	99.033570	99.039755
12690	DXY	300	1776066300	98.897153	98.923718	98.888625	98.915047
10825	SP500	180	1776063960	6816.845919	6817.751202	6815.942346	6817.331096
10827	DOW	180	1776063960	47916.100210	47928.213838	47907.348781	47918.305321
138099	DOW	300	1781162400	49920.209608	49927.508137	49909.363382	49918.526784
10829	DXY	180	1776063960	99.032789	99.039156	99.007191	99.007191
10756	DOW	300	1776063900	47914.172856	47928.213838	47907.348781	47915.332281
10758	DXY	300	1776063900	99.034859	99.051332	99.000345	99.008263
138100	DXY	300	1781162400	99.968584	99.995942	99.947954	99.967969
12329	DOW	300	1776065700	47916.959372	47925.271614	47909.206691	47918.480056
12330	DXY	300	1776065700	98.955616	98.969727	98.923438	98.932844
11023	SP500	180	1776064140	6817.238777	6817.856067	6816.166154	6817.201415
11025	DOW	180	1776064140	47917.443869	47924.748944	47912.461877	47916.620103
11027	DXY	180	1776064140	99.007241	99.010967	98.964612	98.975863
10612	SP500	180	1776063780	6816.001807	6817.995190	6815.454249	6816.965964
11455	SP500	180	1776064500	6816.723906	6818.056852	6815.841112	6817.050967
10613	DOW	180	1776063780	47921.977646	47922.959314	47910.257419	47916.406994
10614	DXY	180	1776063780	99.038798	99.053586	99.022172	99.034355
11457	DOW	180	1776064500	47913.464943	47924.691346	47911.481046	47913.540567
10393	DOW	300	1776063600	47916.596981	47923.701461	47910.257419	47914.104183
10395	DXY	300	1776063600	99.064423	99.065721	99.029756	99.034359
145572	DOW	300	1781174700	49916.867020	49928.792264	49909.016095	49918.780000
11459	DXY	180	1776064500	98.975816	98.992122	98.970795	98.979436
14661	DXY	300	1776069600	98.941856	98.957692	98.930301	98.957692
145573	DXY	300	1781174700	100.125169	100.137665	100.114960	100.129000
137918	SP500	300	1781162100	7267.193064	7268.674223	7265.265369	7267.019866
11458	DOW	300	1776064500	47913.464943	47924.691346	47909.052662	47916.570000
11460	DXY	300	1776064500	98.975816	98.998535	98.970795	98.997000
137919	DOW	300	1781162100	49920.521093	49929.248511	49911.662856	49919.771726
14294	DOW	300	1776069000	47916.166273	47924.399290	47903.010704	47918.261897
14477	DOW	300	1776069300	47917.835866	47922.583837	47909.012259	47915.858134
14478	DXY	300	1776069300	98.934337	98.955226	98.924585	98.943355
11239	SP500	180	1776064320	6817.086156	6817.963142	6815.881400	6816.780683
138098	SP500	300	1781162400	7267.122977	7268.808045	7266.084101	7266.960028
13235	DOW	300	1776067200	47915.638595	47921.716500	47907.240381	47912.896236
13236	DXY	300	1776067200	98.930904	98.940913	98.908939	98.915040
11241	DOW	180	1776064320	47916.459812	47921.497522	47903.940165	47911.808405
11098	DOW	300	1776064200	47913.680138	47923.627300	47903.940165	47911.808405
11243	DXY	180	1776064320	98.975005	98.981968	98.952507	98.973353
11100	DXY	300	1776064200	99.006290	99.008230	98.952507	98.973353
145755	DOW	300	1781175000	49919.953767	49927.693043	49909.145800	49918.780000
14295	DXY	300	1776069000	98.940779	98.957040	98.921946	98.934169
145571	SP500	300	1781174700	7266.955791	7268.610783	7266.059558	7266.990000
13580	DOW	300	1776067800	47918.973042	47925.479772	47907.191747	47913.536127
145754	SP500	300	1781175000	7267.173571	7268.298978	7265.627700	7266.990000
12872	DOW	300	1776066600	47912.131905	47925.637701	47907.095802	47916.327728
12873	DXY	300	1776066600	98.912588	98.930654	98.895818	98.923836
145756	DXY	300	1781175000	100.130426	100.144785	100.117657	100.131000
13581	DXY	300	1776067800	98.912054	98.922401	98.890644	98.921681
12149	DOW	300	1776065400	47916.570000	47925.193618	47904.717460	47915.851020
12506	DOW	300	1776066000	47917.161556	47923.486519	47906.804524	47918.764623
12507	DXY	300	1776066000	98.933794	98.933794	98.890484	98.897743
150698	SP500	300	1781253600	7394.211903	7395.321556	7393.072991	7394.205937
150699	DOW	300	1781253600	50854.251029	50857.915205	50840.428594	50848.933635
150700	DXY	300	1781253600	99.746586	99.755323	99.719588	99.731132
13055	DOW	300	1776066900	47914.504682	47922.931363	47908.041165	47914.424594
13056	DXY	300	1776066900	98.922640	98.940687	98.910013	98.932906
13928	DOW	300	1776068400	47918.091010	47925.240677	47906.980743	47919.285555
153941	SP500	300	1781259900	7394.300000	7395.021074	7393.749193	7393.749193
153942	DOW	300	1781259900	50848.750000	50858.891407	50845.378241	50850.773647
13929	DXY	300	1776068400	98.928372	98.958614	98.921768	98.951116
13745	DOW	300	1776068100	47914.223951	47924.214601	47910.112843	47917.163951
13746	DXY	300	1776068100	98.919706	98.950058	98.909276	98.927516
14111	DOW	300	1776068700	47917.581847	47924.816468	47908.899308	47917.434794
14112	DXY	300	1776068700	98.951004	98.968270	98.937462	98.942521
153995	SP500	300	1781260200	7393.757988	7395.364877	7393.087928	7394.202571
14660	DOW	300	1776069600	47916.276638	47922.969097	47908.884373	47914.848924
14841	DXY	300	1776069900	98.957253	98.965650	98.930998	98.965650
153996	DOW	300	1781260200	50848.912179	50857.053414	50838.834815	50850.479423
153997	DXY	300	1781260200	99.680094	99.744218	99.680094	99.723843
14840	DOW	300	1776069900	47914.312372	47923.078833	47907.625616	47922.332858
154178	SP500	300	1781260500	7393.943392	7395.827390	7392.989653	7395.422158
15020	DOW	300	1776070200	47923.070034	47924.449565	47909.665646	47917.048132
15021	DXY	300	1776070200	98.966579	98.986880	98.952551	98.978522
15194	DOW	300	1776070500	47917.662179	47924.791497	47909.547034	47917.269319
154179	DOW	300	1781260500	50850.414142	50856.598619	50839.848587	50849.623798
15911	DOW	300	1776071700	47917.819663	47926.612474	47907.770065	47917.754098
15912	DXY	300	1776071700	98.960875	98.995820	98.951308	98.982745
17351	DOW	300	1776074100	47917.622047	47924.519916	47908.568120	47912.000619
17352	DXY	300	1776074100	98.967878	98.986057	98.963048	98.986057
19367	DOW	300	1776130800	48218.250000	48223.746911	48207.913635	48219.852935
15554	DOW	300	1776071100	47918.413940	47925.231011	47904.617191	47916.158092
15555	DXY	300	1776071100	98.986798	98.999710	98.974043	98.976831
19368	DXY	300	1776130800	98.353000	98.361607	98.344633	98.361607
19454	DOW	300	1776131100	48220.714748	48225.501351	48207.705622	48213.437072
19455	DXY	300	1776131100	98.359277	98.368290	98.345806	98.356776
171870	DOW	300	1781576100	51669.553117	51680.633231	51661.303988	51669.575534
17180	DOW	300	1776073800	47917.532581	47927.136777	47910.205984	47918.072845
171871	DXY	300	1781576100	99.693255	99.710416	99.680628	99.698240
16454	DOW	300	1776072600	47919.015390	47924.129624	47908.117548	47916.018878
16455	DXY	300	1776072600	98.970677	98.982320	98.956166	98.972846
154180	DXY	300	1781260500	99.722617	99.782080	99.719690	99.749320
16277	DOW	300	1776072300	47913.502099	47925.018564	47905.708129	47919.960477
16278	DXY	300	1776072300	98.998917	99.001746	98.963351	98.972200
16637	DOW	300	1776072900	47916.956215	47926.396423	47905.557508	47912.764747
16638	DXY	300	1776072900	98.975112	98.994434	98.961030	98.964669
150869	SP500	300	1781253900	7394.138340	7395.593841	7392.875407	7394.363863
150870	DOW	300	1781253900	50849.668002	50857.939403	50838.561633	50847.058284
15734	DOW	300	1776071400	47916.652034	47926.918096	47903.646529	47917.196595
15735	DXY	300	1776071400	98.979007	98.993479	98.945504	98.959185
150871	DXY	300	1781253900	99.733170	99.740045	99.688122	99.706118
17181	DXY	300	1776073800	98.949333	98.971994	98.943285	98.965914
138278	SP500	300	1781162700	7266.669677	7269.068070	7265.430634	7266.990000
138279	DOW	300	1781162700	49918.761712	49925.783707	49911.232718	49918.780000
17528	DOW	300	1776074400	47911.900339	47925.630157	47908.466571	47915.857682
17529	DXY	300	1776074400	98.985905	98.995583	98.965869	98.973766
138280	DXY	300	1781162700	99.967457	99.976925	99.932251	99.948000
15195	DXY	300	1776070500	98.978561	98.990331	98.962310	98.983190
16094	DOW	300	1776072000	47917.463420	47928.636743	47908.721828	47914.339842
16095	DXY	300	1776072000	98.984983	99.003792	98.974123	98.996660
16817	DOW	300	1776073200	47912.597978	47924.546790	47905.757455	47917.039649
16818	DXY	300	1776073200	98.965695	98.975978	98.945902	98.957680
15374	DOW	300	1776070800	47918.154371	47926.731240	47909.392391	47918.419145
15375	DXY	300	1776070800	98.983073	99.004171	98.974114	98.988577
145937	SP500	300	1781175300	7266.744983	7268.643848	7265.760510	7266.990000
145938	DOW	300	1781175300	49918.891159	49928.380568	49911.981476	49918.780000
145939	DXY	300	1781175300	100.132415	100.136459	100.112609	100.128000
176672	SP500	300	1782719400	7354.123668	7355.488421	7352.919653	7353.811823
18788	DOW	300	1776076500	47921.060418	47924.918439	47900.343712	47920.390320
18789	DXY	300	1776076500	98.998458	99.003149	98.973600	98.985838
176673	DOW	300	1782719400	51879.471893	51885.297772	51864.653610	51884.844472
176674	DXY	300	1782719400	101.198846	101.216919	101.176418	101.209064
17891	DOW	300	1776075000	47917.225948	47927.190476	47905.906905	47920.091493
17892	DXY	300	1776075000	98.978003	98.993293	98.954748	98.978517
171869	SP500	300	1781576100	7553.674858	7555.244561	7552.953953	7553.190093
174581	SP500	300	1782115200	7500.048562	7502.136428	7499.131047	7500.725083
18251	DOW	300	1776075600	47920.304538	47924.619426	47905.592533	47915.121035
18252	DXY	300	1776075600	98.969265	99.000749	98.969265	98.981303
17711	DOW	300	1776074700	47917.613938	47925.447485	47908.139505	47917.692638
17712	DXY	300	1776074700	98.973194	98.982681	98.958438	98.976639
176855	SP500	300	1782719700	7353.667647	7355.452703	7351.952656	7353.957476
16997	DOW	300	1776073500	47916.327188	47925.746847	47908.629036	47917.169458
16998	DXY	300	1776073500	98.957739	98.963967	98.929348	98.950715
176856	DOW	300	1782719700	51882.884788	51889.855015	51865.291782	51874.812697
18971	DOW	300	1776076800	47921.630144	47923.862733	47910.963690	47921.974483
18972	DXY	300	1776076800	98.987447	99.000343	98.968309	98.968617
176857	DXY	300	1782719700	101.207030	101.221826	101.193861	101.206539
18068	DOW	300	1776075300	47918.311708	47924.457360	47908.836518	47919.293679
18069	DXY	300	1776075300	98.977779	98.996457	98.970719	98.970719
18431	DOW	300	1776075900	47914.199387	47922.487951	47905.895144	47919.180678
18432	DXY	300	1776075900	98.980237	99.000952	98.979535	98.992864
178119	DOW	300	1782721800	51876.110000	51888.138868	51867.476244	51880.567446
19154	DOW	300	1776077100	47920.307818	47925.371382	47905.118669	47919.270359
19155	DXY	300	1776077100	98.968197	98.979750	98.955379	98.964376
178120	DXY	300	1782721800	101.274000	101.305644	101.257336	101.285301
19337	DOW	300	1776077400	47919.948865	47923.633187	47919.948865	47923.633187
178657	DXY	300	1782722700	101.250246	101.284605	101.250246	101.272402
18605	DOW	300	1776076200	47919.933210	47924.365175	47910.032165	47919.514769
18606	DXY	300	1776076200	98.991613	99.009247	98.970141	98.996300
178118	SP500	300	1782721800	7354.020000	7354.680683	7352.966975	7354.491121
19338	DXY	300	1776077400	98.964615	98.965465	98.963936	98.963936
19977	DXY	300	1776132000	98.362227	98.388077	98.355487	98.372887
19637	DOW	300	1776131400	48212.064448	48223.909869	48208.213589	48218.328114
19638	DXY	300	1776131400	98.356353	98.367805	98.339350	98.355250
178655	SP500	300	1782722700	7354.622907	7355.569828	7352.471006	7354.135122
178656	DOW	300	1782722700	51876.550989	51884.492601	51867.469738	51869.827259
19805	DOW	300	1776131700	48216.469049	48223.420454	48205.203253	48219.722533
19806	DXY	300	1776131700	98.355251	98.377516	98.349366	98.364038
20157	DXY	300	1776132300	98.372820	98.391364	98.365865	98.382612
19976	DOW	300	1776132000	48219.877528	48222.391954	48210.055283	48219.461936
178812	DOW	300	1782799800	52182.740000	52186.257208	52173.474432	52186.257208
178813	DXY	300	1782799800	101.406000	101.419697	101.400321	101.405126
20156	DOW	300	1776132300	48218.404972	48223.791430	48210.524547	48220.383188
178811	SP500	300	1782799800	7440.430000	7441.625527	7439.274280	7440.662443
23447	DOW	300	1776215100	48538.086557	48544.633816	48525.198008	48533.226115
23448	DXY	300	1776215100	98.123841	98.123841	98.093315	98.105404
23990	DOW	300	1776216000	48539.363483	48546.967624	48526.264542	48536.537201
23991	DXY	300	1776216000	98.109361	98.113928	98.083273	98.106329
25269	DXY	300	1776218100	98.143917	98.152164	98.130200	98.139226
154362	DOW	300	1781260800	50851.233954	50856.917002	50841.280928	50850.903403
23276	DOW	300	1776214800	48535.990000	48544.473172	48529.770003	48536.211180
23277	DXY	300	1776214800	98.132000	98.145772	98.118048	98.124336
154363	DXY	300	1781260800	99.751546	99.757072	99.745171	99.748029
23810	DOW	300	1776215700	48533.994048	48548.506832	48529.927088	48538.966067
23811	DXY	300	1776215700	98.131683	98.145928	98.103034	98.107829
22739	DOW	300	1776213900	48532.513039	48544.001747	48528.740452	48535.618799
22740	DXY	300	1776213900	98.118847	98.139011	98.107798	98.139011
146120	SP500	300	1781175600	7266.710394	7268.527990	7265.848123	7266.897470
21605	DOW	300	1776134700	48220.310377	48225.088951	48207.621658	48221.688906
21606	DXY	300	1776134700	98.403971	98.413147	98.386992	98.389996
146121	DOW	300	1781175600	49917.614877	49926.267516	49906.809192	49917.386289
138458	SP500	300	1781163000	7267.194014	7269.262311	7265.536739	7266.990000
20876	DOW	300	1776133500	48216.003757	48227.784514	48211.351676	48218.393054
20877	DXY	300	1776133500	98.388169	98.399018	98.369338	98.391203
138459	DOW	300	1781163000	49920.720211	49924.128889	49912.578976	49918.780000
20336	DOW	300	1776132600	48218.736932	48224.564237	48207.272500	48218.116108
20337	DXY	300	1776132600	98.382339	98.396805	98.369361	98.379104
138460	DXY	300	1781163000	99.946186	99.964210	99.928737	99.938000
21422	DOW	300	1776134400	48215.294610	48224.239308	48208.364712	48221.778852
21423	DXY	300	1776134400	98.403641	98.419332	98.397236	98.406430
22148	DOW	300	1776135600	48220.264862	48223.986894	48210.548448	48219.699533
146122	DXY	300	1781175600	100.125592	100.132019	100.097910	100.100579
21242	DOW	300	1776134100	48219.389142	48222.998315	48209.670312	48216.914192
21243	DXY	300	1776134100	98.398589	98.410059	98.386773	98.404550
20516	DOW	300	1776132900	48218.907341	48226.417239	48212.114565	48220.236175
20517	DXY	300	1776132900	98.378896	98.383060	98.364090	98.374922
154435	DXY	300	1781261100	99.721000	99.737196	99.712196	99.727674
21788	DOW	300	1776135000	48220.110826	48224.333343	48212.107325	48218.131450
21789	DXY	300	1776135000	98.392245	98.396220	98.369748	98.388632
151049	SP500	300	1781254200	7394.072498	7395.497487	7393.114219	7394.241572
22149	DXY	300	1776135600	98.391559	98.397720	98.378336	98.393010
151050	DOW	300	1781254200	50848.004269	50857.123155	50841.389258	50844.851917
151051	DXY	300	1781254200	99.706994	99.734715	99.688174	99.715751
22922	DOW	300	1776214200	48534.312210	48540.996307	48529.041600	48535.990000
22379	DOW	300	1776213300	48536.798191	48549.260372	48529.942965	48534.260716
22380	DXY	300	1776213300	98.108036	98.122872	98.096874	98.104841
154361	SP500	300	1781260800	7395.590625	7395.590625	7393.735721	7394.247794
21968	DOW	300	1776135300	48219.497537	48225.794204	48213.359185	48218.506128
21969	DXY	300	1776135300	98.390763	98.393429	98.374431	98.390538
20696	DOW	300	1776133200	48220.626955	48224.339505	48206.851826	48215.321946
20697	DXY	300	1776133200	98.376463	98.394972	98.365123	98.386711
21059	DOW	300	1776133800	48219.656768	48227.106987	48210.697531	48218.589000
21060	DXY	300	1776133800	98.389387	98.411576	98.384023	98.398176
154927	DXY	300	1781262900	99.768000	99.770571	99.757026	99.769199
154925	SP500	300	1781262900	7394.300000	7395.036163	7393.358846	7394.407163
22271	DOW	300	1776213000	48535.990000	48543.764383	48527.729514	48535.807947
22272	DXY	300	1776213000	98.115000	98.123101	98.098684	98.107034
154433	SP500	300	1781261100	7394.300000	7395.815985	7393.242670	7394.438938
22923	DXY	300	1776214200	98.140223	98.152534	98.124013	98.135000
154434	DOW	300	1781261100	50848.750000	50858.347273	50838.560132	50849.036709
154948	DXY	300	1781263200	99.767631	99.776014	99.749950	99.759366
23105	DOW	300	1776214500	48537.090163	48545.146028	48530.854970	48535.990000
154926	DOW	300	1781262900	50848.750000	50849.850237	50843.221505	50849.392069
22559	DOW	300	1776213600	48535.969156	48544.923534	48529.308071	48529.308071
22560	DXY	300	1776213600	98.106652	98.123995	98.092466	98.118276
23106	DXY	300	1776214500	98.134947	98.141003	98.121367	98.133000
23627	DOW	300	1776215400	48534.834440	48543.666062	48529.545314	48533.268307
23628	DXY	300	1776215400	98.104432	98.149796	98.098545	98.131428
154946	SP500	300	1781263200	7394.450229	7396.157963	7392.896894	7394.371881
154947	DOW	300	1781263200	50850.563043	50861.081475	50841.864887	50850.024054
24353	DOW	300	1776216600	48533.918206	48545.093820	48527.407012	48537.781514
24354	DXY	300	1776216600	98.102436	98.141061	98.099655	98.122488
24902	DOW	300	1776217500	48529.886921	48545.260833	48525.088940	48533.672183
24173	DOW	300	1776216300	48538.314159	48548.983113	48528.697881	48534.133027
24174	DXY	300	1776216300	98.104370	98.127199	98.100463	98.104260
155126	SP500	300	1781263500	7394.505456	7395.803992	7392.986603	7394.458060
155127	DOW	300	1781263500	50850.543828	50855.999891	50838.842394	50847.140547
155128	DXY	300	1781263500	99.756919	99.761283	99.734307	99.742897
24903	DXY	300	1776217500	98.130696	98.143493	98.119060	98.137424
24536	DOW	300	1776216900	48536.245305	48543.529378	48524.867580	48538.273764
24537	DXY	300	1776216900	98.121708	98.134396	98.100526	98.120174
24719	DOW	300	1776217200	48537.504594	48543.091517	48525.391408	48531.702157
24720	DXY	300	1776217200	98.120945	98.136523	98.110602	98.131825
155414	SP500	300	1781264100	7394.300000	7394.300000	7393.606312	7393.723412
155415	DOW	300	1781264100	50848.750000	50850.689362	50847.593649	50847.593649
155416	DXY	300	1781264100	99.743000	99.747092	99.742994	99.745639
25085	DOW	300	1776217800	48532.781030	48544.269759	48525.655812	48540.465963
25086	DXY	300	1776217800	98.139813	98.145817	98.116777	98.143657
155420	SP500	300	1781264400	7393.659811	7396.115075	7392.453123	7394.368948
25268	DOW	300	1776218100	48542.125414	48543.439584	48530.987586	48533.758565
25403	DOW	300	1776219600	48535.990000	48538.291999	48527.852094	48527.852094
25404	DXY	300	1776219600	98.159000	98.169405	98.158339	98.169405
28001	DOW	300	1776238500	48540.986241	48542.798289	48527.265046	48536.376205
28002	DXY	300	1776238500	98.145811	98.168138	98.140733	98.160400
28181	DOW	300	1776238800	48534.888241	48543.459583	48529.582564	48541.912526
25760	DOW	300	1776233400	48535.990000	48543.067662	48530.257765	48539.550865
25761	DXY	300	1776233400	98.122000	98.125154	98.103163	98.116183
25418	DOW	300	1776219900	48526.863529	48542.320011	48526.863529	48541.204460
25419	DXY	300	1776219900	98.166975	98.187248	98.158633	98.172523
151229	SP500	300	1781254500	7394.352560	7395.852335	7392.467702	7394.331252
25598	DOW	300	1776220200	48542.220963	48542.946295	48527.960303	48537.393516
25599	DXY	300	1776220200	98.174400	98.188180	98.167660	98.188098
151230	DOW	300	1781254500	50844.443008	50863.881968	50841.983810	50857.016513
28182	DXY	300	1776238800	98.161245	98.174544	98.145147	98.148881
151231	DXY	300	1781254500	99.717035	99.725945	99.679773	99.717827
26093	DOW	300	1776234000	48530.497516	48544.406993	48524.711711	48533.824623
26094	DXY	300	1776234000	98.084746	98.130201	98.077575	98.123990
28437	DXY	300	1776830400	98.405345	98.410513	98.390928	98.403688
146303	SP500	300	1781175900	7267.115554	7268.682345	7265.885777	7267.074517
28310	DOW	300	1776830100	49149.380000	49153.226012	49139.469137	49146.260812
146304	DOW	300	1781175900	49915.895817	49926.319834	49910.687761	49919.755237
27005	DOW	300	1776235500	48533.881485	48544.252493	48530.067103	48530.860635
27006	DXY	300	1776235500	98.162286	98.167234	98.136526	98.153542
146305	DXY	300	1781175900	100.098949	100.120582	100.091597	100.099821
28311	DXY	300	1776830100	98.392000	98.414380	98.386202	98.405287
146486	SP500	300	1781176200	7266.956123	7267.956765	7265.722871	7266.990000
29516	DOW	300	1776832200	49147.976607	49156.599066	49140.045677	49156.355997
146487	DOW	300	1781176200	49918.894432	49927.516082	49911.608600	49918.780000
28790	DOW	300	1776831000	49151.576601	49157.184457	49141.462530	49146.928640
28791	DXY	300	1776831000	98.403368	98.406609	98.381784	98.388734
146488	DXY	300	1781176200	100.102210	100.108901	100.057125	100.067000
29517	DXY	300	1776832200	98.381373	98.401669	98.378952	98.394500
138824	SP500	300	1781163600	7267.115317	7268.076222	7265.686099	7266.990000
25910	DOW	300	1776233700	48541.376910	48543.284331	48528.864252	48528.864252
25911	DXY	300	1776233700	98.118049	98.119573	98.074712	98.085426
138825	DOW	300	1781163600	49916.601516	49931.074530	49909.961833	49918.780000
138826	DXY	300	1781163600	99.931628	99.951883	99.919928	99.945000
28973	DOW	300	1776831300	49148.345633	49159.583852	49141.648581	49147.490740
138641	SP500	300	1781163300	7266.868960	7268.211158	7265.555250	7266.829643
27371	DOW	300	1776236100	48540.764167	48544.525003	48525.148085	48539.099976
27372	DXY	300	1776236100	98.177851	98.186438	98.161550	98.172894
138642	DOW	300	1781163300	49918.941567	49927.352381	49909.890016	49917.270025
28974	DXY	300	1776831300	98.388524	98.401494	98.375664	98.388672
138643	DXY	300	1781163300	99.936813	99.944817	99.904774	99.930886
26456	DOW	300	1776234600	48528.318585	48544.383030	48525.280770	48538.843296
26457	DXY	300	1776234600	98.146001	98.157698	98.126746	98.133158
26639	DOW	300	1776234900	48539.882265	48544.387843	48525.596283	48531.759679
26640	DXY	300	1776234900	98.131159	98.143948	98.122900	98.128051
26276	DOW	300	1776234300	48533.072078	48545.255615	48528.068089	48528.766294
26277	DXY	300	1776234300	98.125756	98.153495	98.112173	98.147328
27554	DOW	300	1776236400	48537.221239	48545.621768	48528.753385	48544.575618
27555	DXY	300	1776236400	98.173727	98.188160	98.162911	98.179966
27188	DOW	300	1776235800	48529.638475	48544.896163	48529.398189	48540.754039
27189	DXY	300	1776235800	98.155855	98.183967	98.152400	98.178715
28616	DOW	300	1776830700	49146.295293	49159.234977	49138.285799	49151.778390
26822	DOW	300	1776235200	48530.084502	48544.924576	48526.458046	48535.495956
26823	DXY	300	1776235200	98.126622	98.167532	98.119327	98.163220
28617	DXY	300	1776830700	98.402407	98.413442	98.383766	98.404416
154595	SP500	300	1781261400	7394.144509	7396.538475	7393.273610	7394.342143
154596	DOW	300	1781261400	50848.325201	50855.150451	50837.458396	50846.865787
154597	DXY	300	1781261400	99.727219	99.737270	99.713428	99.729248
27737	DOW	300	1776236700	48545.956152	48545.956152	48529.052685	48532.456493
27738	DXY	300	1776236700	98.181815	98.185098	98.162624	98.178371
155311	DXY	300	1781263800	99.741326	99.755637	99.722897	99.722897
27923	DOW	300	1776238200	48535.990000	48543.070101	48529.793433	48541.064167
27924	DXY	300	1776238200	98.156000	98.163446	98.137313	98.146309
155309	SP500	300	1781263800	7394.462896	7395.239497	7393.178735	7395.239497
155310	DOW	300	1781263800	50847.584923	50855.434546	50839.177676	50849.082473
155422	DXY	300	1781264400	99.746378	99.765809	99.723198	99.752895
28436	DOW	300	1776830400	49144.587577	49157.130708	49137.897098	49146.280954
155602	DXY	300	1781264700	99.751799	99.762184	99.726824	99.735570
29664	DOW	300	1776832500	49149.380000	49154.896192	49145.531318	49146.630175
155421	DOW	300	1781264400	50845.650028	50857.710382	50840.618730	50857.710382
29665	DXY	300	1776832500	98.385000	98.394902	98.374944	98.378482
29333	DOW	300	1776831900	49147.417052	49155.970426	49137.033849	49148.011947
29334	DXY	300	1776831900	98.389798	98.398834	98.374574	98.383223
29153	DOW	300	1776831600	49145.530717	49156.346596	49140.744144	49147.923236
29154	DXY	300	1776831600	98.388294	98.403218	98.376906	98.391727
155600	SP500	300	1781264700	7394.420060	7395.905561	7392.796210	7395.242896
155601	DOW	300	1781264700	50856.780624	50858.929211	50840.774828	50848.969331
29763	DOW	300	1776832800	49147.063683	49155.829223	49137.677686	49146.147081
29764	DXY	300	1776832800	98.378766	98.400376	98.375905	98.396751
172040	SP500	300	1781576400	7553.001048	7555.845383	7552.314643	7555.061331
29946	DOW	300	1776833100	49147.871858	49160.925175	49141.315808	49150.351066
29947	DXY	300	1776833100	98.396509	98.406514	98.381786	98.391098
172041	DOW	300	1781576400	51670.745462	51678.972333	51664.411586	51672.222433
172042	DXY	300	1781576400	99.698472	99.716985	99.685627	99.703059
30129	DOW	300	1776833400	49148.558614	49157.834799	49137.700365	49139.285052
30130	DXY	300	1776833400	98.392006	98.392698	98.369542	98.377659
30312	DOW	300	1776833700	49138.337836	49158.984521	49138.337836	49153.076986
34132	DXY	300	1776841200	98.309147	98.314448	98.281604	98.296204
33780	DOW	300	1776840600	49152.413588	49157.705430	49140.580354	49148.135375
33781	DXY	300	1776840600	98.298612	98.322757	98.283104	98.312709
33486	DOW	300	1776839400	49152.201008	49155.685034	49140.202001	49147.769475
30912	DOW	300	1776834900	49149.380000	49158.203807	49142.173464	49149.398517
30913	DXY	300	1776834900	98.390000	98.397093	98.355275	98.368352
30546	DOW	300	1776834300	49149.380000	49159.569245	49141.655922	49159.569245
30547	DXY	300	1776834300	98.388000	98.403835	98.371971	98.391307
33487	DXY	300	1776839400	98.319239	98.331545	98.312087	98.322044
33132	DOW	300	1776838800	49152.324335	49156.529081	49141.432668	49147.875945
33133	DXY	300	1776838800	98.337508	98.346892	98.313013	98.313013
32679	DOW	300	1776837900	49149.307818	49158.971971	49138.783702	49147.821186
32680	DXY	300	1776837900	98.284076	98.305102	98.276553	98.298460
31953	DOW	300	1776836700	49145.354683	49154.066937	49140.130028	49144.254576
31954	DXY	300	1776836700	98.288940	98.292600	98.256317	98.282507
30313	DXY	300	1776833700	98.377320	98.386033	98.363278	98.369598
33600	DOW	300	1776840000	49149.380000	49152.287987	49147.727225	49151.168210
33601	DXY	300	1776840000	98.285000	98.285000	98.279500	98.279578
151409	SP500	300	1781254800	7394.366589	7395.502997	7392.882831	7394.123473
32859	DOW	300	1776838200	49147.703592	49156.081842	49141.121867	49146.188247
32860	DXY	300	1776838200	98.297336	98.325839	98.288110	98.318605
151410	DOW	300	1781254800	50856.924068	50862.041260	50839.503786	50848.034762
151411	DXY	300	1781254800	99.719207	99.729897	99.698526	99.724174
146669	SP500	300	1781176500	7266.929172	7268.522896	7265.166123	7266.990000
30729	DOW	300	1776834600	49159.718287	49159.718287	49137.247817	49144.662025
30730	DXY	300	1776834600	98.391219	98.401956	98.370761	98.387879
146670	DOW	300	1781176500	49917.821840	49931.635862	49910.905765	49918.780000
146671	DXY	300	1781176500	100.067719	100.094841	100.052927	100.070000
139007	SP500	300	1781163900	7266.704669	7268.031034	7266.099317	7267.080205
31413	DOW	300	1776835800	49151.167959	49159.685012	49143.257027	49154.592463
31414	DXY	300	1776835800	98.256789	98.273321	98.210086	98.273321
139008	DOW	300	1781163900	49919.623904	49930.744820	49908.483626	49917.317923
139009	DXY	300	1781163900	99.945305	99.975111	99.933338	99.967924
31593	DOW	300	1776836100	49155.976382	49159.217545	49140.545907	49142.434122
31594	DXY	300	1776836100	98.272297	98.273643	98.233919	98.258789
30426	DOW	300	1776834000	49149.380000	49157.053915	49143.647208	49152.036802
30427	DXY	300	1776834000	98.375000	98.390940	98.371673	98.387608
151592	SP500	300	1781255100	7394.201835	7395.795396	7392.620650	7394.611241
31095	DOW	300	1776835200	49149.380000	49155.865570	49140.389842	49146.853703
31096	DXY	300	1776835200	98.364000	98.379027	98.349319	98.362407
151593	DOW	300	1781255100	50846.914985	50856.352833	50839.957246	50848.496196
151594	DXY	300	1781255100	99.725945	99.739955	99.716859	99.732051
31278	DOW	300	1776835500	49149.380000	49158.060008	49141.309269	49149.393458
31279	DXY	300	1776835500	98.365000	98.373931	98.257910	98.258150
32313	DOW	300	1776837300	49149.048146	49158.834402	49134.569779	49151.410565
32314	DXY	300	1776837300	98.273548	98.289798	98.265727	98.278413
154778	SP500	300	1781261700	7394.163346	7395.408161	7393.190674	7394.158043
32136	DOW	300	1776837000	49143.701109	49159.215456	49136.517462	49150.716484
154779	DOW	300	1781261700	50844.946319	50858.328387	50838.247513	50856.142829
31773	DOW	300	1776836400	49143.783656	49158.777773	49135.003025	49145.788276
31774	DXY	300	1776836400	98.257186	98.294912	98.241959	98.288314
154780	DXY	300	1781261700	99.731475	99.731916	99.705060	99.714070
32137	DXY	300	1776837000	98.284093	98.297692	98.266220	98.274749
155780	SP500	300	1781265000	7395.158847	7395.346402	7392.764043	7394.288816
155781	DOW	300	1781265000	50848.956845	50855.320506	50841.258592	50845.440396
155782	DXY	300	1781265000	99.737427	99.738000	99.709685	99.716709
32952	DOW	300	1776838500	49147.430471	49155.581724	49141.325612	49151.146890
32953	DXY	300	1776838500	98.316731	98.350016	98.310041	98.335144
155895	DOW	300	1781266200	50848.750000	50853.600713	50838.930179	50852.813413
32496	DOW	300	1776837600	49152.496588	49157.684693	49139.284530	49148.100119
32497	DXY	300	1776837600	98.277058	98.288333	98.263590	98.285695
155896	DXY	300	1781266200	99.774000	99.788175	99.766897	99.783065
155894	SP500	300	1781266200	7394.300000	7395.607947	7393.095173	7394.120781
33306	DOW	300	1776839100	49148.200243	49158.741676	49139.469527	49153.742845
33307	DXY	300	1776839100	98.312916	98.331733	98.296004	98.318688
33603	DOW	300	1776840300	49152.823692	49157.572023	49139.657613	49150.609506
33604	DXY	300	1776840300	98.281844	98.306206	98.276366	98.297404
33957	DOW	300	1776840900	49147.145221	49157.684445	49138.781208	49156.518223
33958	DXY	300	1776840900	98.310275	98.322363	98.285667	98.309300
155939	SP500	300	1781266500	7394.273340	7395.434742	7392.827497	7394.546787
155940	DOW	300	1781266500	50853.541769	50857.237102	50841.804296	50843.210898
155941	DXY	300	1781266500	99.784509	99.816393	99.770121	99.804165
34308	DOW	300	1776841500	49146.837332	49156.278656	49142.276462	49149.380000
34309	DXY	300	1776841500	98.295402	98.310854	98.283895	98.304000
34131	DOW	300	1776841200	49158.148709	49159.716411	49140.093655	49145.118830
34665	DOW	300	1776842100	49148.777790	49160.609143	49137.714963	49147.849317
156122	SP500	300	1781266800	7394.701103	7395.903607	7393.004288	7393.887625
34482	DOW	300	1776841800	49149.233298	49156.196014	49142.075760	49147.481264
34483	DXY	300	1776841800	98.306103	98.310388	98.279244	98.294753
156123	DOW	300	1781266800	50842.523915	50855.536640	50840.025520	50843.527822
34666	DXY	300	1776842100	98.293155	98.309204	98.284280	98.299104
156124	DXY	300	1781266800	99.802135	99.814397	99.789251	99.811234
34848	DOW	300	1776842400	49149.193164	49155.593341	49141.788744	49148.794929
34849	DXY	300	1776842400	98.301202	98.315187	98.290403	98.295598
156354	DOW	300	1781267700	50848.750000	50857.427635	50842.175716	50847.256803
35031	DOW	300	1776842700	49149.706561	49156.166525	49142.837177	49150.176496
35032	DXY	300	1776842700	98.296375	98.341029	98.287812	98.322833
156355	DXY	300	1781267700	99.846000	99.866869	99.824990	99.859191
35907	DOW	300	1776844500	49149.380000	49154.534928	49142.950815	49149.380000
35908	DXY	300	1776844500	98.302000	98.310148	98.300051	98.307000
39193	DXY	300	1776911400	98.633243	98.637941	98.607048	98.626774
146854	DXY	300	1781176800	100.069859	100.070875	100.042059	100.052000
37185	DOW	300	1776849600	49149.380000	49157.316068	49140.160020	49152.423296
36807	DOW	300	1776847800	49145.907294	49157.570094	49139.793189	49151.149058
36808	DXY	300	1776847800	98.313137	98.335350	98.291698	98.309990
36486	DOW	300	1776846000	49147.626920	49163.168519	49144.481986	49148.019789
36487	DXY	300	1776846000	98.274306	98.278824	98.244090	98.250554
37186	DXY	300	1776849600	98.273000	98.284353	98.251812	98.259858
139373	SP500	300	1781164500	7267.073526	7268.331572	7265.965535	7267.054804
139374	DOW	300	1781164500	49920.311877	49926.237289	49911.256012	49919.054827
38643	DOW	300	1776910500	49487.253631	49500.894640	49482.093764	49498.970044
139190	SP500	300	1781164200	7267.014112	7268.260944	7265.119307	7266.902401
37578	DOW	300	1776908700	49490.030000	49497.920335	49483.813689	49490.030000
37579	DXY	300	1776908700	98.586000	98.606999	98.579845	98.589000
139191	DOW	300	1781164200	49918.330007	49926.449104	49909.578718	49919.244349
35214	DOW	300	1776843000	49151.204558	49158.248500	49143.354804	49148.891013
35215	DXY	300	1776843000	98.321512	98.339989	98.306305	98.324125
139192	DXY	300	1781164200	99.966542	99.983464	99.958460	99.979599
35394	DOW	300	1776843300	49148.147981	49152.175641	49146.995214	49146.995214
35395	DXY	300	1776843300	98.322288	98.323899	98.320991	98.322479
139375	DXY	300	1781164500	99.980143	99.993630	99.969653	99.985172
36669	DOW	300	1776846300	49149.615708	49161.021221	49143.407267	49145.076013
35418	DOW	300	1776843600	49149.380000	49158.395468	49140.164525	49151.810573
35419	DXY	300	1776843600	98.321000	98.341839	98.305678	98.327815
36670	DXY	300	1776846300	98.250476	98.267632	98.236081	98.245976
147035	SP500	300	1781177100	7266.967836	7268.026537	7265.523760	7266.990000
147036	DOW	300	1781177100	49917.402154	49928.431071	49907.787965	49918.780000
147037	DXY	300	1781177100	100.052089	100.075591	100.045022	100.065000
35760	DOW	300	1776844200	49147.039516	49156.019456	49143.626125	49143.626125
35761	DXY	300	1776844200	98.318091	98.328816	98.291888	98.302802
146852	SP500	300	1781176800	7267.135341	7268.319489	7265.807811	7266.990000
36333	DOW	300	1776845700	49149.380000	49160.529620	49138.209549	49148.706186
36334	DXY	300	1776845700	98.288000	98.298623	98.258492	98.275494
146853	DOW	300	1781176800	49916.926126	49927.646235	49910.753286	49918.780000
36990	DOW	300	1776848100	49151.739271	49157.769104	49140.235256	49146.492649
36991	DXY	300	1776848100	98.312152	98.315737	98.271613	98.295206
36117	DOW	300	1776845100	49148.272463	49158.358582	49141.625318	49151.315743
36118	DXY	300	1776845100	98.301592	98.302679	98.262009	98.272696
35934	DOW	300	1776844800	49149.140034	49158.504526	49140.489621	49150.153145
35935	DXY	300	1776844800	98.306079	98.315369	98.282943	98.302054
156307	DXY	300	1781267100	99.812510	99.821357	99.799944	99.812844
35580	DOW	300	1776843900	49150.337048	49157.853772	49141.819304	49148.066157
35581	DXY	300	1776843900	98.327150	98.327638	98.299504	98.315950
156305	SP500	300	1781267100	7393.672702	7395.243638	7393.672702	7394.338116
151775	SP500	300	1781255400	7394.448431	7396.342615	7393.198343	7394.930830
37500	DOW	300	1776850200	49148.601670	49155.401987	49139.715679	49153.102137
37501	DXY	300	1776850200	98.274881	98.294387	98.270115	98.276882
151776	DOW	300	1781255400	50849.473292	50856.964343	50839.384275	50845.719276
151777	DXY	300	1781255400	99.734410	99.756190	99.725189	99.737467
156306	DOW	300	1781267100	50842.080024	50856.939437	50842.080024	50848.503932
36300	DOW	300	1776845400	49151.387221	49151.781394	49148.558270	49150.963438
36301	DXY	300	1776845400	98.270369	98.271131	98.265875	98.266146
36792	DOW	300	1776847500	49149.380000	49151.250757	49145.135896	49146.885519
36793	DXY	300	1776847500	98.319000	98.324322	98.311696	98.313927
37317	DOW	300	1776849900	49151.729438	49158.572378	49142.577578	49148.471779
37318	DXY	300	1776849900	98.258147	98.296512	98.255567	98.275311
156353	SP500	300	1781267700	7394.300000	7395.676157	7393.252192	7393.702253
37917	DOW	300	1776909300	49487.367871	49499.361119	49480.952191	49486.100736
37918	DXY	300	1776909300	98.570640	98.589900	98.554709	98.573919
38100	DOW	300	1776909600	49486.890383	49497.647881	49482.108534	49489.479454
38101	DXY	300	1776909600	98.572478	98.598952	98.570568	98.598952
37737	DOW	300	1776909000	49490.543311	49499.143348	49478.622944	49486.995428
37738	DXY	300	1776909000	98.591181	98.596906	98.563778	98.571672
156857	SP500	300	1781269500	7394.300000	7395.535754	7393.225484	7394.726674
156858	DOW	300	1781269500	50848.750000	50851.413009	50840.360348	50851.413009
38644	DXY	300	1776910500	98.595161	98.619676	98.592407	98.615012
156859	DXY	300	1781269500	99.840000	99.860406	99.829357	99.838086
38466	DOW	300	1776910200	49490.242972	49497.355477	49481.213744	49485.856464
38826	DOW	300	1776910800	49500.825775	49500.825775	49483.250565	49488.201677
38467	DXY	300	1776910200	98.596338	98.614796	98.575015	98.597518
156905	SP500	300	1781269800	7394.604563	7395.527771	7393.092989	7393.632645
38283	DOW	300	1776909900	49487.973404	49500.373734	49484.220944	49489.219259
38284	DXY	300	1776909900	98.600014	98.605048	98.581977	98.595842
156906	DOW	300	1781269800	50851.101302	50856.157061	50839.438259	50850.025782
39009	DOW	300	1776911100	49489.841177	49498.443705	49483.686442	49498.443705
39556	DXY	300	1776912000	98.627748	98.651736	98.616596	98.622814
156907	DXY	300	1781269800	99.838114	99.858319	99.814000	99.820805
38827	DXY	300	1776910800	98.615671	98.634713	98.601744	98.631885
39010	DXY	300	1776911100	98.629823	98.641765	98.622342	98.631629
39192	DOW	300	1776911400	49497.288877	49498.601463	49482.050349	49489.349867
157088	SP500	300	1781270100	7393.538503	7395.809251	7392.180677	7394.112356
157089	DOW	300	1781270100	50850.133488	50853.569927	50841.639941	50851.629639
39372	DOW	300	1776911700	49489.642278	49500.198033	49482.548254	49491.536673
39373	DXY	300	1776911700	98.627565	98.634825	98.615321	98.630158
157090	DXY	300	1781270100	99.820423	99.831295	99.786263	99.813917
39555	DOW	300	1776912000	49490.812792	49499.424334	49480.886383	49491.358825
42729	DOW	300	1776919200	49483.851307	49493.725742	49481.894338	49490.683458
42546	DOW	300	1776918900	49491.355702	49502.458549	49482.376666	49485.727750
42547	DXY	300	1776918900	98.674522	98.699061	98.672316	98.686254
42366	DOW	300	1776918600	49494.808324	49498.301270	49483.912520	49491.575251
42367	DXY	300	1776918600	98.685326	98.697203	98.667656	98.676558
40962	DOW	300	1776915900	49490.030000	49495.030802	49479.330004	49485.859251
157511	SP500	300	1781271000	7394.383837	7409.240560	7393.916218	7395.032829
39735	DOW	300	1776912300	49492.563483	49503.880791	49482.718975	49492.435616
39736	DXY	300	1776912300	98.622949	98.638234	98.615977	98.622740
157512	DOW	300	1781271000	50849.396889	51188.363149	50849.396889	51109.272069
40963	DXY	300	1776915900	98.683000	98.690981	98.669559	98.685203
157271	SP500	300	1781270400	7394.141507	7394.744133	7393.476926	7394.299155
157272	DOW	300	1781270400	50852.754351	50854.322229	50842.118263	50846.721925
42129	DOW	300	1776918000	49491.860157	49498.275285	49480.664798	49487.672251
42130	DXY	300	1776918000	98.711276	98.716758	98.685820	98.688306
151958	SP500	300	1781255700	7395.125401	7395.710969	7393.288464	7393.955675
151959	DOW	300	1781255700	50846.789064	50859.800926	50839.520875	50853.205264
151960	DXY	300	1781255700	99.738756	99.758286	99.719568	99.741903
40284	DOW	300	1776913200	49492.461880	49499.191236	49479.209468	49485.584794
40285	DXY	300	1776913200	98.635884	98.672088	98.634880	98.670923
147218	SP500	300	1781177400	7267.004801	7268.114405	7266.018620	7266.812178
40467	DOW	300	1776913500	49485.880422	49485.880422	49484.702809	49484.702809
40468	DXY	300	1776913500	98.670100	98.670100	98.668302	98.668302
147219	DOW	300	1781177400	49918.202755	49924.303030	49910.016429	49911.222412
41400	DOW	300	1776916800	49488.040629	49500.803767	49482.457732	49491.209291
41401	DXY	300	1776916800	98.695675	98.704086	98.681627	98.695491
39918	DOW	300	1776912600	49493.237126	49498.071559	49479.125108	49487.436217
39919	DXY	300	1776912600	98.621011	98.641780	98.614582	98.638584
157273	DXY	300	1781270400	99.812554	99.821936	99.797273	99.817913
147220	DXY	300	1781177400	100.063284	100.083700	100.056137	100.063918
41220	DOW	300	1776916500	49491.099994	49500.953431	49484.275323	49489.392686
41221	DXY	300	1776916500	98.701007	98.710455	98.685673	98.693509
156521	SP500	300	1781268000	7393.641476	7395.524201	7393.125577	7394.719171
139556	SP500	300	1781164800	7267.276591	7267.951558	7265.417417	7267.130721
40521	DOW	300	1776914400	49490.414839	49502.723514	49478.897213	49488.480829
40522	DXY	300	1776914400	98.683828	98.707502	98.681676	98.703018
139557	DOW	300	1781164800	49918.122749	49930.413939	49913.308398	49918.692627
40704	DOW	300	1776914700	49490.258029	49496.265280	49481.958769	49486.130462
40705	DXY	300	1776914700	98.700945	98.706076	98.676206	98.692062
139558	DXY	300	1781164800	99.983959	100.005577	99.970874	99.979221
40500	DOW	300	1776914100	49490.030000	49491.552411	49486.141239	49489.931219
40501	DXY	300	1776914100	98.688000	98.691258	98.678131	98.686229
40101	DOW	300	1776912900	49486.309585	49496.132902	49481.122500	49490.981830
40102	DXY	300	1776912900	98.638268	98.652416	98.623645	98.637028
156522	DOW	300	1781268000	50848.941258	50857.763530	50842.947903	50853.226983
41763	DOW	300	1776917400	49491.267946	49496.095756	49479.084725	49484.624815
41764	DXY	300	1776917400	98.715976	98.720753	98.692814	98.707002
41040	DOW	300	1776916200	49487.330829	49500.408681	49484.495381	49491.103419
41041	DXY	300	1776916200	98.683320	98.710685	98.679056	98.702256
156523	DXY	300	1781268000	99.857865	99.867757	99.829271	99.839756
157328	SP500	300	1781270700	7394.345931	7395.412304	7392.157485	7394.221868
40887	DOW	300	1776915000	49487.821818	49498.203590	49483.273338	49495.202654
40888	DXY	300	1776915000	98.690833	98.704787	98.681764	98.686829
157329	DOW	300	1781270700	50846.217320	50858.512248	50832.888235	50847.471036
157330	DXY	300	1781270700	99.815724	99.829722	99.773000	99.773146
42312	DOW	300	1776918300	49488.668906	49495.338133	49481.700204	49495.338133
42313	DXY	300	1776918300	98.686076	98.702556	98.682890	98.686343
41580	DOW	300	1776917100	49492.178178	49499.321418	49483.609747	49490.245185
41581	DXY	300	1776917100	98.695205	98.723365	98.692270	98.714370
41946	DOW	300	1776917700	49484.685925	49498.339088	49480.375672	49490.525720
41947	DXY	300	1776917700	98.705817	98.714428	98.690939	98.711793
42730	DXY	300	1776919200	98.684250	98.690180	98.671518	98.688492
157513	DXY	300	1781271000	99.771756	99.779378	99.743095	99.757802
42816	DOW	300	1776922500	49490.030000	49491.221214	49489.054943	49490.682282
42817	DXY	300	1776922500	98.667000	98.667000	98.663319	98.666233
42822	DOW	300	1776922800	49490.294793	49501.453380	49484.040145	49486.956804
42823	DXY	300	1776922800	98.668256	98.679160	98.647713	98.661042
158254	DXY	300	1781273100	99.806000	99.807443	99.796323	99.804184
43185	DOW	300	1776923400	49493.492154	49501.404618	49479.554147	49492.000271
43186	DXY	300	1776923400	98.665045	98.674711	98.659202	98.663567
158252	SP500	300	1781273100	7411.420000	7414.318905	7411.116070	7414.014027
43909	DXY	300	1776924600	98.634174	98.636936	98.612189	98.636936
158253	DOW	300	1781273100	51042.330000	51048.560000	51039.328207	51047.173032
43365	DOW	300	1776923700	49490.593218	49498.128890	49483.305853	49489.687980
43366	DXY	300	1776923700	98.664013	98.672658	98.646121	98.647462
43005	DOW	300	1776923100	49485.916942	49497.488231	49478.802159	49492.553932
43006	DXY	300	1776923100	98.661529	98.677500	98.651889	98.664073
43545	DOW	300	1776924000	49488.700153	49502.259277	49483.465334	49486.164433
158264	SP500	300	1781273400	7414.041065	7417.228980	7399.925708	7405.780759
43546	DXY	300	1776924000	98.647994	98.655804	98.630478	98.644478
158265	DOW	300	1781273400	51047.238017	51066.120289	50941.510779	50972.583707
158266	DXY	300	1781273400	99.805632	99.810872	99.723187	99.737512
43725	DOW	300	1776924300	49485.543840	49494.624181	49481.107351	49487.617007
43726	DXY	300	1776924300	98.643771	98.647000	98.621323	98.632198
158447	SP500	300	1781273700	7405.787475	7422.463726	7405.012995	7416.514326
43908	DOW	300	1776924600	49487.703937	49497.048157	49482.556100	49490.116694
158448	DOW	300	1781273700	50970.677649	51081.937580	50968.246924	51014.433541
44088	DOW	300	1776924900	49488.238829	49500.209798	49478.908368	49492.724890
45828	DOW	300	1776930600	49490.030000	49495.242217	49480.435526	49485.246804
44811	DOW	300	1776926100	49490.692081	49501.731640	49480.213400	49491.605324
44812	DXY	300	1776926100	98.642910	98.659316	98.634370	98.647497
45829	DXY	300	1776930600	98.694000	98.701675	98.682663	98.691495
44451	DOW	300	1776925500	49490.214862	49499.751343	49480.554228	49490.039979
44452	DXY	300	1776925500	98.649725	98.666244	98.634192	98.656425
45726	DOW	300	1776927600	49489.761897	49494.841096	49480.956037	49488.801202
45727	DXY	300	1776927600	98.636646	98.648894	98.622297	98.625051
48033	DOW	300	1776934500	49489.741251	49496.868889	49481.135088	49490.305628
48034	DXY	300	1776934500	98.674039	98.679269	98.647456	98.659031
156704	SP500	300	1781268300	7394.778624	7395.152389	7392.995992	7394.819252
47133	DOW	300	1776933000	49490.065957	49496.712183	49481.056605	49487.760805
47134	DXY	300	1776933000	98.650207	98.668836	98.645444	98.658336
156705	DOW	300	1781268300	50851.508624	50855.284789	50842.895387	50846.794410
46053	DOW	300	1776931200	49491.435140	49500.753839	49484.116153	49497.373440
46054	DXY	300	1776931200	98.660497	98.677688	98.644562	98.668133
156706	DXY	300	1781268300	99.839486	99.861654	99.835916	99.844005
45360	DOW	300	1776927000	49494.348566	49500.325903	49480.512706	49490.294925
45361	DXY	300	1776927000	98.621967	98.636491	98.609114	98.626063
152141	SP500	300	1781256000	7393.873044	7395.840842	7392.973857	7393.309632
152142	DOW	300	1781256000	50852.246322	50861.657769	50836.645966	50843.091414
45177	DOW	300	1776926700	49490.646257	49499.574629	49481.567982	49492.703877
45178	DXY	300	1776926700	98.634658	98.642338	98.617537	98.623017
152143	DXY	300	1781256000	99.739948	99.747525	99.719087	99.729966
147401	SP500	300	1781177700	7266.990000	7268.633732	7265.401005	7266.990000
44631	DOW	300	1776925800	49490.449620	49498.707400	49483.300295	49489.331323
44632	DXY	300	1776925800	98.656028	98.671299	98.641807	98.642465
147402	DOW	300	1781177700	49918.780000	49926.401659	49910.646480	49918.780000
147403	DXY	300	1781177700	100.065000	100.080161	100.056968	100.064000
139739	SP500	300	1781165100	7266.866762	7268.781607	7265.141004	7266.990000
45543	DOW	300	1776927300	49491.342720	49500.035271	49482.663306	49490.452457
44089	DXY	300	1776924900	98.637149	98.640999	98.619110	98.632165
139740	DOW	300	1781165100	49917.470974	49928.286180	49908.656772	49918.780000
45544	DXY	300	1776927300	98.626964	98.635533	98.607203	98.635533
139741	DXY	300	1781165100	99.977369	100.001220	99.971893	99.991000
44994	DOW	300	1776926400	49493.331311	49498.314260	49481.424859	49491.545036
44995	DXY	300	1776926400	98.647274	98.656315	98.625361	98.635324
152324	SP500	300	1781256300	7393.283207	7396.198967	7392.614465	7394.033115
44271	DOW	300	1776925200	49493.173736	49497.957016	49481.976010	49488.559193
44272	DXY	300	1776925200	98.632407	98.653855	98.624856	98.651007
152325	DOW	300	1781256300	50841.305798	50859.045416	50836.445380	50848.453325
152326	DXY	300	1781256300	99.728891	99.731565	99.669935	99.683473
46230	DOW	300	1776931500	49497.389231	49502.634113	49481.990782	49489.920979
46231	DXY	300	1776931500	98.667649	98.676495	98.648000	98.649182
45879	DOW	300	1776930900	49486.816160	49496.658788	49480.954601	49491.609986
45880	DXY	300	1776930900	98.693304	98.700436	98.651464	98.658856
47316	DOW	300	1776933300	49488.279010	49499.896236	49480.039490	49488.925434
47317	DXY	300	1776933300	98.659679	98.670677	98.628496	98.647340
157694	SP500	300	1781271300	7394.897824	7405.691462	7394.603159	7403.880770
157695	DOW	300	1781271300	51110.665829	51132.932031	51010.515918	51031.451148
46590	DOW	300	1776932100	49490.150356	49498.106760	49482.904577	49490.093236
46591	DXY	300	1776932100	98.650998	98.659192	98.639702	98.651627
157696	DXY	300	1781271300	99.759248	99.772550	99.733489	99.742540
157876	DXY	300	1781271600	99.742668	99.755104	99.723000	99.754434
47853	DOW	300	1776934200	49490.342316	49497.701077	49483.795957	49489.157594
47854	DXY	300	1776934200	98.665955	98.679286	98.641507	98.673238
46950	DOW	300	1776932700	49494.647560	49503.569405	49482.098308	49490.929931
157874	SP500	300	1781271600	7403.686328	7405.219850	7371.779713	7371.827940
46407	DOW	300	1776931800	49491.550962	49496.698693	49483.262311	49489.922502
46408	DXY	300	1776931800	98.648068	98.670014	98.627620	98.651631
46951	DXY	300	1776932700	98.650455	98.670065	98.642680	98.648963
157875	DOW	300	1781271600	51032.913017	51034.580213	50855.569564	50887.574016
46767	DOW	300	1776932400	49491.658736	49504.651544	49479.489229	49493.861010
47673	DOW	300	1776933900	49493.195224	49499.663288	49482.050651	49491.445244
47674	DXY	300	1776933900	98.651546	98.676904	98.632251	98.663664
46768	DXY	300	1776932400	98.649474	98.662966	98.632133	98.651817
158449	DXY	300	1781273700	99.737606	99.767864	99.732105	99.746936
47493	DOW	300	1776933600	49490.459911	49501.691017	49481.089441	49494.400002
47494	DXY	300	1776933600	98.647826	98.672320	98.629299	98.653218
172225	DXY	300	1781576700	99.702630	99.723225	99.689547	99.716245
48210	DOW	300	1776934800	49490.030000	49498.860420	49483.743446	49496.290927
48211	DXY	300	1776934800	98.656000	98.664641	98.638248	98.645959
174764	SP500	300	1782115500	7500.643829	7501.291189	7499.724192	7500.580000
174765	DOW	300	1782115500	51560.483386	51570.897538	51559.266763	51564.700000
48393	DOW	300	1776935100	49490.030000	49499.160458	49484.808511	49488.652486
48394	DXY	300	1776935100	98.652000	98.655833	98.630407	98.642178
174766	DXY	300	1782115500	100.972910	100.976429	100.960000	100.974000
48759	DOW	300	1776935700	49490.030000	49499.025501	49482.014143	49488.657601
48576	DOW	300	1776935400	49490.030000	49498.455719	49480.941217	49489.905245
48577	DXY	300	1776935400	98.646000	98.688693	98.637256	98.688693
48760	DXY	300	1776935700	98.683000	98.701269	98.669817	98.694786
177038	SP500	300	1782720000	7353.843376	7356.554949	7352.809463	7354.386636
48921	DOW	300	1776936600	49490.030000	49499.682743	49481.933746	49493.861987
48922	DXY	300	1776936600	98.669000	98.691848	98.666788	98.689057
177039	DOW	300	1782720000	51875.258185	51888.567538	51861.795563	51871.069089
177040	DXY	300	1782720000	101.204816	101.260425	101.198858	101.260425
49080	DOW	300	1776936900	49494.944232	49499.771865	49481.662107	49490.599069
49081	DXY	300	1776936900	98.686798	98.709558	98.673371	98.701701
52264	DXY	300	1777270200	98.512823	98.526025	98.493202	98.511822
53542	DXY	300	1777272300	98.512948	98.516676	98.496566	98.503226
52809	DOW	300	1777271100	49225.104854	49237.600436	49223.576243	49226.513887
147586	DXY	300	1781178000	100.061680	100.062457	100.033093	100.054000
52626	DOW	300	1777270800	49226.175256	49246.309927	49224.075597	49224.075597
50133	DOW	300	1777266600	49229.908421	49237.907229	49222.392840	49229.549283
50134	DXY	300	1777266600	98.455728	98.465401	98.442092	98.454067
152508	DOW	300	1781256600	50847.604722	50859.219652	50841.493037	50852.486770
50277	DOW	300	1777266900	49229.550072	49239.953394	49222.564535	49230.650782
50278	DXY	300	1777266900	98.453729	98.465721	98.437852	98.446764
140105	SP500	300	1781165700	7267.309991	7268.320827	7265.540117	7267.222593
49833	DOW	300	1776999000	49305.526114	49318.262947	49303.866338	49310.657613
49834	DXY	300	1776999000	98.842487	98.857676	98.833991	98.851316
140106	DOW	300	1781165700	49918.087250	49925.619691	49912.082460	49918.414486
139922	SP500	300	1781165400	7267.219292	7268.328171	7265.243629	7267.091534
139923	DOW	300	1781165400	49920.720074	49927.790020	49912.116906	49919.959344
49512	DOW	300	1776998400	49309.309620	49317.560783	49300.912749	49307.462200
49513	DXY	300	1776998400	98.847473	98.855179	98.821712	98.829597
139924	DXY	300	1781165400	99.993246	100.012743	99.984861	100.004062
51540	DOW	300	1777269000	49229.695309	49238.703327	49219.944184	49236.856934
51541	DXY	300	1777269000	98.480700	98.491237	98.469789	98.477877
51360	DOW	300	1777268700	49223.444685	49242.183208	49220.735775	49230.887695
51361	DXY	300	1777268700	98.476593	98.497534	98.467470	98.481079
49380	DOW	300	1776998100	49310.320000	49316.538137	49301.689063	49309.547964
49381	DXY	300	1776998100	98.844000	98.858495	98.839487	98.848632
140107	DXY	300	1781165700	100.005323	100.016533	99.978656	100.005352
50994	DOW	300	1777268100	49230.774242	49238.792709	49222.384561	49227.584074
50454	DOW	300	1777267200	49231.050304	49237.657952	49222.107736	49235.634029
50455	DXY	300	1777267200	98.448243	98.476740	98.443764	98.465861
152509	DXY	300	1781256600	99.682688	99.703689	99.664340	99.664357
50995	DXY	300	1777268100	98.468122	98.475475	98.453284	98.466999
147767	SP500	300	1781178300	7266.897766	7268.399250	7265.657895	7266.990000
50013	DOW	300	1776999300	49312.013092	49318.073415	49303.856564	49304.981735
50014	DXY	300	1776999300	98.852069	98.866597	98.845008	98.866493
147768	DOW	300	1781178300	49917.170595	49924.972992	49906.680966	49918.780000
147769	DXY	300	1781178300	100.056130	100.070663	100.038426	100.060000
147584	SP500	300	1781178000	7267.071175	7268.934030	7265.941595	7266.990000
147585	DOW	300	1781178000	49917.195721	49926.806817	49908.029388	49918.780000
49653	DOW	300	1776998700	49308.602440	49320.063849	49301.007584	49305.082997
49654	DXY	300	1776998700	98.827838	98.855960	98.825859	98.844409
49263	DOW	300	1776937200	49490.999733	49500.502254	49478.584525	49493.195470
49264	DXY	300	1776937200	98.700206	98.701287	98.680623	98.692597
50814	DOW	300	1777267800	49234.764778	49238.266337	49220.996115	49232.446427
50815	DXY	300	1777267800	98.480003	98.484752	98.464580	98.469106
158056	DXY	300	1781271900	99.756051	99.767312	99.734814	99.743774
50118	DOW	300	1777266300	49230.710000	49230.710000	49224.546499	49228.767794
50119	DXY	300	1777266300	98.455000	98.457785	98.451186	98.456573
158054	SP500	300	1781271900	7371.828375	7377.294617	7362.427558	7365.379474
152507	SP500	300	1781256600	7394.087472	7395.584144	7392.287795	7395.013038
52080	DOW	300	1777269900	49231.622827	49239.648079	49224.921232	49234.024895
52081	DXY	300	1777269900	98.479068	98.512562	98.469145	98.512562
52627	DXY	300	1777270800	98.522583	98.536008	98.511587	98.527735
158055	DOW	300	1781271900	50889.249588	50929.996104	50827.737876	50844.963286
50634	DOW	300	1777267500	49236.142553	49239.283486	49223.353030	49233.342522
50635	DXY	300	1777267500	98.463541	98.487186	98.460307	98.477686
158631	DOW	300	1781274000	51016.434281	51039.940000	50958.737301	50971.434875
51177	DOW	300	1777268400	49227.101524	49236.678444	49222.437172	49222.703376
51178	DXY	300	1777268400	98.466849	98.481813	98.455720	98.477764
51900	DOW	300	1777269600	49230.621672	49239.285494	49222.088087	49231.178669
51901	DXY	300	1777269600	98.470547	98.492998	98.461373	98.480319
51720	DOW	300	1777269300	49236.992551	49240.072111	49221.993115	49229.185714
51721	DXY	300	1777269300	98.477959	98.480533	98.450312	98.472750
158632	DXY	300	1781274000	99.746254	99.768626	99.743883	99.752203
52810	DXY	300	1777271100	98.527577	98.552567	98.519938	98.523284
158630	SP500	300	1781274000	7416.534550	7420.610899	7406.682715	7407.534953
52446	DOW	300	1777270500	49227.145242	49237.204699	49223.353636	49226.477597
52447	DXY	300	1777270500	98.513053	98.550637	98.505632	98.521443
53175	DOW	300	1777271700	49228.602418	49243.169310	49221.195561	49227.164687
158716	DXY	300	1781274300	99.764000	99.799884	99.743703	99.799105
52263	DOW	300	1777270200	49234.033899	49241.738648	49218.883354	49228.602052
53176	DXY	300	1777271700	98.529673	98.540707	98.517414	98.527257
158714	SP500	300	1781274300	7412.730000	7413.679495	7407.898173	7410.498842
52992	DOW	300	1777271400	49227.433749	49240.035867	49218.842001	49228.076967
52993	DXY	300	1777271400	98.521326	98.538177	98.510102	98.528688
158715	DOW	300	1781274300	51031.870000	51075.811175	51020.562473	51055.570104
53358	DOW	300	1777272000	49229.003057	49238.677516	49220.236984	49233.225717
53541	DOW	300	1777272300	49231.952169	49238.888533	49223.081257	49231.803071
53359	DXY	300	1777272000	98.527950	98.536000	98.501646	98.510911
159173	SP500	300	1781276100	7434.290000	7436.240000	7432.343836	7436.109722
159174	DOW	300	1781276100	51320.190000	51329.666256	51304.880927	51323.604781
53709	DOW	300	1777272600	49231.846024	49238.986340	49223.444565	49230.641714
54066	DXY	300	1777273200	98.468648	98.478126	98.454433	98.476288
53710	DXY	300	1777272600	98.505289	98.523913	98.502221	98.506487
159175	DXY	300	1781276100	99.772000	99.778357	99.765021	99.777918
53882	DOW	300	1777272900	49232.314204	49239.040661	49217.196372	49229.283971
53883	DXY	300	1777272900	98.508647	98.521468	98.469020	98.470486
159212	SP500	300	1781276400	7436.015779	7442.133338	7429.652063	7434.018833
54065	DOW	300	1777273200	49228.560828	49238.548443	49219.010285	49227.780014
58014	DXY	300	1777339500	98.542000	98.557007	98.530762	98.537492
57878	DOW	300	1777338900	49173.292109	49187.691581	49163.207295	49181.489459
57879	DXY	300	1777338900	98.538084	98.544028	98.521477	98.531572
57338	DOW	300	1777278600	49231.181423	49241.491457	49220.861114	49233.712088
57339	DXY	300	1777278600	98.359133	98.364286	98.334088	98.335974
54245	DOW	300	1777273500	49228.282730	49239.155483	49218.968788	49233.426303
54246	DXY	300	1777273500	98.477571	98.477571	98.439324	98.447952
57155	DOW	300	1777278300	49231.721952	49243.393300	49222.020475	49230.681724
57156	DXY	300	1777278300	98.328944	98.367185	98.325399	98.356977
56243	DOW	300	1777276800	49227.355934	49241.418522	49223.456361	49230.608215
56244	DXY	300	1777276800	98.404701	98.414210	98.356607	98.375473
54788	DOW	300	1777274400	49230.614715	49238.284677	49218.403131	49228.556461
54789	DXY	300	1777274400	98.401887	98.424801	98.392777	98.412017
152867	SP500	300	1781257200	7395.037514	7395.703968	7392.760401	7393.653273
152868	DOW	300	1781257200	50843.296145	50857.334391	50836.300153	50846.383081
152869	DXY	300	1781257200	99.649394	99.668836	99.628005	99.664575
152687	SP500	300	1781256900	7395.161421	7395.903588	7392.979284	7395.090245
56426	DOW	300	1777277100	49228.938973	49235.446998	49222.091440	49230.313839
56427	DXY	300	1777277100	98.374258	98.380845	98.341000	98.343909
152688	DOW	300	1781256900	50850.882015	50858.304398	50841.478037	50841.514570
54425	DOW	300	1777273800	49233.310291	49236.865483	49223.377576	49226.998885
54426	DXY	300	1777273800	98.445703	98.451911	98.415000	98.415896
152689	DXY	300	1781256900	99.666200	99.680292	99.629845	99.647772
56060	DOW	300	1777276500	49231.280779	49242.195581	49222.843740	49229.291136
56061	DXY	300	1777276500	98.418787	98.420912	98.393832	98.403393
55334	DOW	300	1777275300	49226.070290	49240.379496	49220.717450	49226.957940
55335	DXY	300	1777275300	98.408721	98.438377	98.403738	98.429393
147950	SP500	300	1781178600	7266.915054	7268.745578	7265.755943	7266.990000
147951	DOW	300	1781178600	49918.913164	49929.654830	49907.433766	49918.780000
55517	DOW	300	1777275600	49226.106504	49239.229683	49217.887489	49233.857675
55518	DXY	300	1777275600	98.431129	98.445266	98.410113	98.414648
147952	DXY	300	1781178600	100.059409	100.071309	100.044457	100.059000
55151	DOW	300	1777275000	49229.673714	49239.396853	49221.011486	49227.175507
55152	DXY	300	1777275000	98.434779	98.442236	98.407705	98.410015
140288	SP500	300	1781166000	7267.344536	7268.252771	7265.999725	7266.832293
140289	DOW	300	1781166000	49917.340140	49927.831671	49907.674085	49919.679163
140290	DXY	300	1781166000	100.007690	100.022513	100.001298	100.015383
54605	DOW	300	1777274100	49225.668573	49239.486314	49224.047935	49228.923059
54606	DXY	300	1777274100	98.413972	98.423042	98.389446	98.402734
55700	DOW	300	1777275900	49234.170572	49238.904206	49221.045836	49224.200792
55701	DXY	300	1777275900	98.414789	98.435767	98.399587	98.406395
159395	SP500	300	1781276700	7434.113279	7440.435725	7432.661414	7437.381223
159396	DOW	300	1781276700	51335.108872	51357.910000	51319.062672	51334.716757
54968	DOW	300	1777274700	49229.045811	49239.326808	49223.762384	49230.136874
54969	DXY	300	1777274700	98.411601	98.437104	98.398116	98.434229
159397	DXY	300	1781276700	99.727850	99.752335	99.711278	99.744324
56789	DOW	300	1777277700	49234.488406	49238.812862	49222.681134	49231.525663
56790	DXY	300	1777277700	98.369086	98.369086	98.313355	98.316349
57533	DOW	300	1777338300	49164.602357	49175.123107	49155.067611	49168.256288
57534	DXY	300	1777338300	98.506595	98.519732	98.488415	98.504018
158870	SP500	300	1781274600	7410.589534	7416.454331	7404.736449	7409.891606
56609	DOW	300	1777277400	49230.404368	49240.870458	49223.146045	49232.741344
56610	DXY	300	1777277400	98.346328	98.374114	98.320466	98.367626
158871	DOW	300	1781274600	51054.661870	51093.995426	51039.427088	51066.517821
158872	DXY	300	1781274600	99.798044	99.820010	99.782710	99.791260
55880	DOW	300	1777276200	49225.423251	49240.505390	49220.904763	49233.047936
55881	DXY	300	1777276200	98.408341	98.424632	98.398764	98.419415
159213	DOW	300	1781276400	51322.760123	51391.684983	51313.416032	51336.076200
159214	DXY	300	1781276400	99.779679	99.812153	99.714700	99.729069
56972	DOW	300	1777278000	49230.655466	49239.838411	49222.967447	49233.204452
56973	DXY	300	1777278000	98.315618	98.338059	98.308035	98.330942
57701	DOW	300	1777338600	49166.883339	49175.311420	49157.936640	49171.471475
57702	DXY	300	1777338600	98.502006	98.549164	98.497530	98.536702
172224	DOW	300	1781576700	51670.642767	51675.943839	51663.533027	51669.587375
57488	DOW	300	1777338000	49167.790000	49173.231992	49162.865060	49166.222519
57489	DXY	300	1777338000	98.499000	98.516059	98.495835	98.506315
172223	SP500	300	1781576700	7554.955827	7555.663427	7552.779689	7553.533349
57940	DOW	300	1777339200	49187.765778	49187.765778	49157.947508	49169.527649
57941	DXY	300	1777339200	98.530351	98.546464	98.525160	98.529412
58089	DOW	300	1777339800	49164.050935	49176.792587	49161.353878	49169.603770
58090	DXY	300	1777339800	98.537121	98.550802	98.522942	98.545160
172406	SP500	300	1781577000	7553.687244	7555.645242	7553.233445	7554.840695
172407	DOW	300	1781577000	51670.456234	51677.341064	51664.278589	51675.579801
58450	DXY	300	1777340400	98.528649	98.550795	98.515776	98.527553
58813	DXY	300	1777341000	98.514140	98.529411	98.509574	98.529411
172408	DXY	300	1781577000	99.716806	99.723269	99.699391	99.701946
58013	DOW	300	1777339500	49167.790000	49184.061524	49161.170048	49165.645989
58449	DOW	300	1777340400	49167.774853	49175.539706	49156.276114	49166.322215
58269	DOW	300	1777340100	49169.093615	49176.843355	49158.156199	49168.334346
58270	DXY	300	1777340100	98.545484	98.555534	98.519899	98.531012
174815	SP500	300	1782716100	7354.020000	7354.892083	7353.197895	7354.110893
174816	DOW	300	1782716100	51876.110000	51880.097606	51868.618950	51879.475369
58629	DOW	300	1777340700	49168.022538	49173.376837	49158.252873	49168.046910
58630	DXY	300	1777340700	98.527259	98.534925	98.508822	98.513132
174817	DXY	300	1782716100	101.225000	101.230823	101.209432	101.210742
177222	DOW	300	1782720300	51869.875071	51888.205986	51867.160002	51875.062247
58812	DOW	300	1777341000	49168.219868	49176.813865	49159.291783	49167.797923
58939	DXY	300	1777432200	98.648000	98.657819	98.638578	98.640896
62338	DXY	300	1777534500	98.905329	98.917659	98.883463	98.894106
59562	DOW	300	1777433400	49143.843823	49147.012385	49132.390985	49137.691004
59563	DXY	300	1777433400	98.651514	98.667246	98.633554	98.644731
59202	DOW	300	1777432800	49145.571505	49148.411145	49133.052076	49144.953213
59203	DXY	300	1777432800	98.650583	98.661674	98.639892	98.654190
153047	SP500	300	1781257500	7393.731380	7395.555038	7392.844868	7394.420870
59817	DOW	300	1777530300	48858.317553	48876.101234	48855.791166	48866.744041
59818	DXY	300	1777530300	99.074768	99.077904	99.047422	99.053989
153048	DOW	300	1781257500	50846.830698	50858.640329	50842.741646	50845.860182
59784	DOW	300	1777530000	48861.810000	48868.602225	48855.104384	48858.901103
59785	DXY	300	1777530000	99.074000	99.086561	99.069526	99.072588
153049	DXY	300	1781257500	99.666634	99.673390	99.642580	99.656545
153227	SP500	300	1781257800	7394.545450	7395.742394	7393.232144	7394.665309
153228	DOW	300	1781257800	50847.606120	50856.626138	50842.783418	50852.351018
60000	DOW	300	1777530600	48865.330567	48870.376201	48854.514258	48856.298740
60001	DXY	300	1777530600	99.055478	99.065714	99.034024	99.044152
153229	DXY	300	1781257800	99.654615	99.664084	99.633479	99.656830
140651	SP500	300	1781166600	7266.690731	7268.340683	7265.523116	7266.990000
62157	DOW	300	1777534200	48860.801349	48876.177107	48850.537375	48862.737058
62158	DXY	300	1777534200	98.906615	98.932107	98.897162	98.904309
140652	DOW	300	1781166600	49920.591631	49928.241004	49909.672042	49918.780000
140653	DXY	300	1781166600	100.015293	100.040004	100.006673	100.018000
61806	DOW	300	1777533600	48855.519913	48869.819916	48854.335309	48858.544985
61807	DXY	300	1777533600	98.932933	98.934042	98.899984	98.904144
140471	SP500	300	1781166300	7266.918514	7268.145027	7265.326939	7266.967640
140472	DOW	300	1781166300	49918.095159	49928.379063	49909.572123	49918.867612
60177	DOW	300	1777530900	48855.605322	48871.140412	48853.804377	48863.113154
140473	DXY	300	1781166300	100.015300	100.036759	100.003823	100.016103
59379	DOW	300	1777433100	49146.562301	49148.264051	49130.606551	49144.422669
59380	DXY	300	1777433100	98.654399	98.662669	98.641083	98.651279
148133	SP500	300	1781178900	7267.000102	7268.946852	7265.934528	7266.990000
58938	DOW	300	1777432200	49141.930000	49147.342187	49133.610981	49141.541779
148134	DOW	300	1781178900	49917.708957	49924.123093	49910.228383	49918.780000
148135	DXY	300	1781178900	100.059286	100.078582	100.046852	100.059000
60178	DXY	300	1777530900	99.042461	99.052671	99.018752	99.023973
59742	DOW	300	1777433700	49138.168071	49149.647192	49129.643916	49145.453464
59743	DXY	300	1777433700	98.643052	98.649058	98.636986	98.642510
61083	DOW	300	1777532400	48861.695270	48869.089150	48852.580292	48861.155410
59022	DOW	300	1777432500	49141.952809	49148.028331	49133.183505	49144.871197
59023	DXY	300	1777432500	98.640361	98.659153	98.634362	98.651058
61084	DXY	300	1777532400	98.992489	99.002719	98.977714	98.981401
148316	SP500	300	1781179200	7267.144577	7268.509383	7265.050357	7266.990000
148317	DOW	300	1781179200	49917.127690	49928.044468	49911.393244	49918.780000
60537	DOW	300	1777531500	48866.349404	48870.639310	48854.959757	48862.632268
60538	DXY	300	1777531500	98.979725	99.001398	98.968588	99.000430
148318	DXY	300	1781179200	100.058947	100.074734	100.042003	100.048000
60717	DOW	300	1777531800	48863.821179	48870.954970	48851.229707	48861.735984
60718	DXY	300	1777531800	98.999721	99.027997	98.990367	99.000122
61266	DOW	300	1777532700	48859.923609	48873.876495	48852.149733	48863.437808
61267	DXY	300	1777532700	98.981316	99.006568	98.970536	98.983185
60354	DOW	300	1777531200	48862.382142	48869.487096	48852.334360	48864.994377
60355	DXY	300	1777531200	99.025343	99.033228	98.976214	98.981168
61986	DOW	300	1777533900	48856.661734	48872.169491	48854.261239	48859.367583
61987	DXY	300	1777533900	98.904845	98.915397	98.889581	98.905451
60900	DOW	300	1777532100	48863.036050	48871.591119	48853.836918	48859.949783
60901	DXY	300	1777532100	99.001853	99.011024	98.985041	98.994640
159054	DOW	300	1781274900	51066.784773	51097.890936	51057.608589	51097.739104
159055	DXY	300	1781274900	99.792237	99.797811	99.773482	99.786294
61626	DOW	300	1777533300	48861.810000	48871.503998	48852.461666	48856.937332
61627	DXY	300	1777533300	98.956000	98.967344	98.922712	98.932345
61449	DOW	300	1777533000	48861.901221	48871.770891	48853.062961	48863.021265
61450	DXY	300	1777533000	98.984457	98.990391	98.946620	98.951211
159053	SP500	300	1781274900	7409.646702	7417.817697	7409.638293	7414.937065
63049	DXY	300	1777535700	98.911119	98.941274	98.906698	98.934687
62865	DOW	300	1777535400	48863.999991	48868.316678	48857.151894	48865.303962
62866	DXY	300	1777535400	98.927533	98.932505	98.903172	98.911322
159580	DXY	300	1781277000	99.742638	99.756080	99.731020	99.732677
62505	DOW	300	1777534800	48865.894505	48870.463527	48854.052631	48861.632867
62506	DXY	300	1777534800	98.893325	98.935128	98.892054	98.927079
159578	SP500	300	1781277000	7437.148295	7438.716047	7434.651449	7437.987493
159579	DOW	300	1781277000	51332.827586	51333.471928	51305.956450	51314.929095
62337	DOW	300	1777534500	48863.631220	48867.928851	48858.488975	48865.420159
62682	DOW	300	1777535100	48860.966427	48871.133634	48850.835798	48862.405722
62683	DXY	300	1777535100	98.929334	98.951828	98.917677	98.926099
63411	DOW	300	1777536300	48856.117585	48868.519646	48851.691292	48859.770892
159632	SP500	300	1781278200	7442.540000	7443.373900	7440.020450	7440.411978
159633	DOW	300	1781278200	51320.100000	51322.112676	51293.226990	51293.226990
63048	DOW	300	1777535700	48865.232676	48869.242535	48851.053899	48861.973453
63228	DOW	300	1777536000	48860.833846	48869.917375	48854.127648	48857.742276
63229	DXY	300	1777536000	98.934723	98.948453	98.919870	98.920781
159634	DXY	300	1781278200	99.703000	99.706879	99.692601	99.694772
159699	DOW	300	1781278500	51293.530497	51351.928447	51210.733567	51254.795600
63412	DXY	300	1777536300	98.922085	98.935000	98.857937	98.875231
159698	SP500	300	1781278500	7440.331974	7445.733560	7425.682813	7430.685693
63588	DOW	300	1777536600	48859.547963	48871.248208	48853.890142	48861.830815
63589	DXY	300	1777536600	98.876972	98.878838	98.798813	98.803678
63768	DOW	300	1777536900	48863.091353	48866.969223	48851.720252	48863.499850
63769	DXY	300	1777536900	98.802345	98.807592	98.743457	98.775141
66741	DOW	300	1778054400	49298.250000	49305.061195	49289.022644	49299.283797
66742	DXY	300	1778054400	98.109000	98.121178	98.079193	98.092756
65535	DOW	300	1777870500	49497.860304	49507.584357	49490.021357	49499.400155
65536	DXY	300	1777870500	98.137186	98.143236	98.120943	98.136388
64803	DOW	300	1777869300	49499.542276	49507.608310	49491.381197	49500.681893
64804	DXY	300	1777869300	98.111127	98.123413	98.096958	98.112552
159878	SP500	300	1781278800	7430.670956	7431.435815	7421.500000	7422.415610
63951	DOW	300	1777537200	48865.174278	48873.015947	48856.229284	48861.810000
63952	DXY	300	1777537200	98.775169	98.804599	98.755403	98.801000
159700	DXY	300	1781278500	99.692909	99.716679	99.663365	99.672155
64986	DOW	300	1777869600	49502.128484	49506.644777	49491.253194	49501.884015
64987	DXY	300	1777869600	98.112950	98.126338	98.106066	98.117910
64317	DOW	300	1777537800	48864.305208	48868.970569	48857.084439	48861.556932
64318	DXY	300	1777537800	98.814157	98.827809	98.809715	98.826961
159879	DOW	300	1781278800	51254.204930	51259.762121	51208.120237	51210.063709
64629	DOW	300	1777869000	49499.993597	49506.600998	49489.356337	49501.138090
64630	DXY	300	1777869000	98.076714	98.114756	98.071311	98.112976
153407	SP500	300	1781258100	7394.407517	7395.769020	7392.918141	7394.793738
153408	DOW	300	1781258100	50851.651118	50857.124280	50840.021057	50846.764995
64380	DOW	300	1777868400	49499.270000	49503.197050	49495.002332	49499.270000
64381	DXY	300	1777868400	98.074000	98.081160	98.061130	98.077000
153409	DXY	300	1781258100	99.656885	99.679514	99.646186	99.676653
64134	DOW	300	1777537500	48860.842710	48874.276157	48851.760402	48862.642790
64135	DXY	300	1777537500	98.802502	98.832988	98.789274	98.814655
159880	DXY	300	1781278800	99.673945	99.689646	99.663524	99.684945
148499	SP500	300	1781179500	7266.984228	7268.284816	7265.888248	7266.683832
67447	DXY	300	1778055600	98.072663	98.082015	98.054224	98.063596
148500	DOW	300	1781179500	49919.330306	49926.940486	49911.211604	49917.573696
148501	DXY	300	1781179500	100.050332	100.068177	100.038202	100.056858
65169	DOW	300	1777869900	49501.200411	49510.271551	49489.566382	49493.900668
65170	DXY	300	1777869900	98.120187	98.138040	98.111898	98.127596
140831	SP500	300	1781166900	7266.807281	7268.181190	7265.344763	7266.990000
140832	DOW	300	1781166900	49920.039249	49929.163621	49911.167221	49918.780000
140833	DXY	300	1781166900	100.018087	100.046510	100.011180	100.039000
67662	DOW	300	1778119200	49910.590000	49915.480523	49905.528602	49912.639410
67663	DXY	300	1778119200	97.918000	97.934241	97.909886	97.934241
64461	DOW	300	1777868700	49500.574987	49507.537797	49492.758925	49498.466882
64462	DXY	300	1777868700	98.075321	98.095745	98.064617	98.076014
66612	DOW	300	1777872300	49497.610105	49507.828644	49492.306552	49496.810243
66613	DXY	300	1777872300	98.140990	98.145215	98.122421	98.141846
172711	DXY	300	1782111900	100.887000	100.891788	100.872787	100.884698
67626	DOW	300	1778055900	49304.260556	49304.260556	49292.876449	49298.044544
67627	DXY	300	1778055900	98.065073	98.078639	98.062777	98.074194
172589	SP500	300	1781577300	7554.745128	7555.571320	7552.789484	7554.409164
172709	SP500	300	1782111900	7500.580000	7501.417382	7499.076254	7500.678342
66246	DOW	300	1777871700	49500.507262	49507.901687	49491.292498	49496.223107
172710	DOW	300	1782111900	51564.700000	51571.013052	51557.748361	51559.753010
65352	DOW	300	1777870200	49495.541196	49508.307552	49491.317088	49498.252180
65353	DXY	300	1777870200	98.127312	98.144263	98.122341	98.135220
172590	DOW	300	1781577300	51675.292445	51681.411049	51659.654524	51672.103302
66247	DXY	300	1777871700	98.126572	98.136018	98.113266	98.124352
172591	DXY	300	1781577300	99.701532	99.716042	99.692597	99.697700
67446	DOW	300	1778055600	49302.399865	49305.796648	49292.585714	49305.793607
67083	DOW	300	1778055000	49301.180805	49305.657270	49290.743964	49295.479255
65712	DOW	300	1777870800	49498.500951	49512.203800	49486.656475	49500.188178
65713	DXY	300	1777870800	98.135833	98.142507	98.120038	98.126992
174856	DXY	300	1782716400	101.212433	101.230029	101.181564	101.205927
65892	DOW	300	1777871100	49499.285052	49508.171899	49490.421296	49499.402390
65893	DXY	300	1777871100	98.126588	98.146600	98.122134	98.125750
66075	DOW	300	1777871400	49498.124549	49504.892768	49490.539406	49501.288805
66076	DXY	300	1777871400	98.127101	98.146792	98.121702	98.124160
174854	SP500	300	1782716400	7353.975982	7355.327905	7352.745085	7354.309441
66429	DOW	300	1777872000	49497.585491	49508.973929	49491.184348	49499.558253
67084	DXY	300	1778055000	98.014708	98.064777	97.995000	98.064540
174855	DOW	300	1782716400	51877.474107	51886.521386	51868.075742	51878.624824
66430	DXY	300	1777872000	98.125252	98.144341	98.100177	98.143283
66903	DOW	300	1778054700	49298.250000	49306.906177	49287.382345	49302.693802
66904	DXY	300	1778054700	98.089000	98.092693	98.011512	98.016068
177221	SP500	300	1782720300	7354.664624	7355.926354	7352.499822	7353.784663
177223	DXY	300	1782720300	101.260933	101.261740	101.230935	101.251058
67266	DOW	300	1778055300	49295.533412	49306.017216	49287.354497	49301.668876
67267	DXY	300	1778055300	98.062278	98.082594	98.048331	98.073482
178297	DXY	300	1782722100	101.286306	101.288116	101.262559	101.263867
67722	DOW	300	1778119500	49913.527274	49922.577720	49902.102158	49910.193059
67723	DXY	300	1778119500	97.934508	97.949148	97.926345	97.943182
67899	DOW	300	1778119800	49909.600380	49918.554974	49902.783819	49914.485870
67900	DXY	300	1778119800	97.941435	97.956493	97.923432	97.950134
178296	DOW	300	1782722100	51882.490031	51885.721380	51867.855190	51875.360615
68073	DOW	300	1778120100	49915.934960	49923.165999	49900.465622	49918.529457
68074	DXY	300	1778120100	97.950183	97.977695	97.946016	97.976147
68433	DOW	300	1778120700	49907.607846	49918.528751	49901.845541	49905.082348
68250	DOW	300	1778120400	49910.590000	49920.993663	49901.778922	49909.484744
68251	DXY	300	1778120400	97.968000	97.976607	97.958427	97.959877
178868	SP500	300	1782800100	7440.446417	7441.945552	7438.693745	7440.566141
68434	DXY	300	1778120700	97.957506	97.981332	97.956859	97.974729
178869	DOW	300	1782800100	52185.074143	52193.090093	52175.486458	52184.423899
178870	DXY	300	1782800100	101.404895	101.424487	101.391526	101.400196
68610	DOW	300	1778121000	49906.189708	49916.322871	49900.503485	49900.503485
72855	DOW	300	1778477400	49607.859391	49618.272382	49600.734707	49606.175100
70950	DOW	300	1778465700	49607.935771	49614.325054	49598.454662	49609.389739
70951	DXY	300	1778465700	98.045121	98.058026	98.036460	98.058026
70404	DOW	300	1778464800	49612.071251	49618.093609	49600.832099	49611.883981
153770	SP500	300	1781258700	7394.385953	7395.153667	7393.027010	7394.300000
69801	DOW	300	1778463600	49609.160000	49617.161267	49604.055944	49612.089956
69802	DXY	300	1778463600	98.003000	98.028261	97.986384	98.026132
153771	DOW	300	1781258700	50851.443931	50856.103114	50840.980277	50848.750000
153772	DXY	300	1781258700	99.667965	99.686530	99.655839	99.660000
69723	DOW	300	1778463000	49607.516142	49616.045373	49606.271793	49607.708055
69724	DXY	300	1778463000	98.019296	98.020337	98.005386	98.005437
70405	DXY	300	1778464800	98.051492	98.068001	98.045249	98.066603
69540	DOW	300	1778462700	49607.236405	49617.787502	49602.766153	49609.014164
69541	DXY	300	1778462700	98.018451	98.030769	97.998920	98.018417
69129	DOW	300	1778461800	49609.160000	49614.935619	49601.288225	49606.678770
69130	DXY	300	1778461800	98.009000	98.012390	97.992327	97.992327
153587	SP500	300	1781258400	7395.073521	7395.843881	7392.738177	7394.272575
72856	DXY	300	1778477400	98.116529	98.125119	98.102200	98.115850
153588	DOW	300	1781258400	50845.184461	50854.237748	50841.171668	50852.440938
69858	DOW	300	1778463900	49611.286738	49618.650838	49598.995794	49610.429258
69859	DXY	300	1778463900	98.024508	98.050571	98.020607	98.045132
153589	DXY	300	1781258400	99.675546	99.709359	99.665304	99.670155
160246	DXY	300	1781279700	99.726058	99.739713	99.715428	99.738533
69357	DOW	300	1778462400	49611.140667	49617.753418	49600.043022	49605.578778
69358	DXY	300	1778462400	98.012018	98.045764	98.007319	98.019718
160244	SP500	300	1781279700	7419.481559	7421.170000	7396.680000	7397.699290
148682	SP500	300	1781179800	7266.990000	7268.215698	7265.621824	7266.990000
70221	DOW	300	1778464500	49608.318011	49616.924538	49598.376853	49613.218503
70222	DXY	300	1778464500	98.043200	98.065956	98.034856	98.050760
148683	DOW	300	1781179800	49918.780000	49928.556677	49902.918700	49918.780000
72126	DOW	300	1778476200	49610.930433	49620.837349	49602.267297	49610.208708
68611	DXY	300	1778121000	97.974623	97.989916	97.954733	97.964024
148684	DXY	300	1781179800	100.054000	100.062591	100.031575	100.051000
72127	DXY	300	1778476200	98.145302	98.151524	98.119851	98.124280
141014	SP500	300	1781167200	7266.949814	7267.864243	7265.578347	7267.020352
141015	DOW	300	1781167200	49919.985843	49926.621622	49913.541681	49917.554253
68976	DOW	300	1778121600	49910.041095	49921.003881	49901.831051	49907.846953
68977	DXY	300	1778121600	97.971985	97.978353	97.950664	97.959031
141016	DXY	300	1781167200	100.037521	100.060447	100.031555	100.035416
70584	DOW	300	1778465100	49612.746130	49615.546476	49597.560958	49604.827950
70585	DXY	300	1778465100	98.068504	98.070933	98.043426	98.058611
68793	DOW	300	1778121300	49899.185017	49918.244957	49898.901413	49911.055343
68794	DXY	300	1778121300	97.961640	97.986849	97.960320	97.970865
71946	DOW	300	1778475900	49611.818104	49618.553576	49597.246476	49610.589102
71947	DXY	300	1778475900	98.137001	98.155285	98.129137	98.145045
69177	DOW	300	1778462100	49606.544667	49619.320261	49602.510486	49609.600272
69178	DXY	300	1778462100	97.991281	98.013319	97.985241	98.013319
71763	DOW	300	1778475600	49608.877582	49617.739932	49596.572957	49612.291022
70038	DOW	300	1778464200	49609.934681	49617.309834	49601.744202	49609.124492
70039	DXY	300	1778464200	98.046096	98.057733	98.030621	98.042160
160058	SP500	300	1781279100	7422.196989	7430.857690	7420.950975	7430.857690
71220	DOW	300	1778474700	49609.070245	49614.359736	49600.676334	49607.416245
71221	DXY	300	1778474700	98.111633	98.128451	98.106401	98.127454
160059	DOW	300	1781279100	51208.416779	51263.904915	51207.057418	51263.904915
160060	DXY	300	1781279100	99.684287	99.713963	99.677859	99.691858
71100	DOW	300	1778474400	49609.160000	49615.293643	49602.401889	49608.657353
71101	DXY	300	1778474400	98.118000	98.125889	98.103012	98.113030
160121	SP500	300	1781279400	7411.710000	7424.043144	7410.635980	7419.636038
71764	DXY	300	1778475600	98.127779	98.142721	98.120564	98.136729
160122	DOW	300	1781279400	51141.240000	51216.774688	51122.324186	51186.360054
160123	DXY	300	1781279400	99.720000	99.749164	99.708733	99.728340
70767	DOW	300	1778465400	49606.483784	49619.904969	49598.877352	49608.385341
70768	DXY	300	1778465400	98.058603	98.059321	98.030266	98.044980
160245	DOW	300	1781279700	51185.767873	51200.014194	51083.517609	51085.858092
71403	DOW	300	1778475000	49606.969244	49615.873230	49599.791099	49608.842906
71404	DXY	300	1778475000	98.127162	98.143265	98.119596	98.129943
72306	DOW	300	1778476500	49608.272256	49617.216879	49596.428703	49607.845666
72307	DXY	300	1778476500	98.124547	98.137082	98.110815	98.121644
160783	DXY	300	1781281800	99.746469	99.772352	99.739888	99.762995
71583	DOW	300	1778475300	49608.631959	49622.131034	49599.654954	49609.121691
71584	DXY	300	1778475300	98.130961	98.140808	98.122679	98.129586
160610	SP500	300	1781281500	7417.870000	7423.087787	7414.420878	7418.719497
160611	DOW	300	1781281500	51137.910000	51171.469961	51120.180311	51133.507135
160612	DXY	300	1781281500	99.745000	99.756164	99.720356	99.745847
72489	DOW	300	1778476800	49608.269574	49618.554621	49602.215198	49606.934526
72490	DXY	300	1778476800	98.122252	98.132815	98.097457	98.116423
72672	DOW	300	1778477100	49606.133924	49616.880750	49601.917827	49608.317865
72673	DXY	300	1778477100	98.115851	98.125587	98.105761	98.117059
72945	DOW	300	1778577000	49704.470000	49714.082843	49694.059683	49702.147084
72946	DXY	300	1778577000	98.272000	98.276637	98.245383	98.263177
73294	DXY	300	1778577600	98.272295	98.284957	98.255813	98.272275
160781	SP500	300	1781281800	7418.868929	7423.140000	7415.720477	7422.944924
160782	DOW	300	1781281800	51133.074474	51155.379027	51122.146467	51143.633190
73110	DOW	300	1778577300	49701.788205	49715.584879	49697.203928	49700.880051
73111	DXY	300	1778577300	98.263311	98.291609	98.257203	98.271171
161064	DOW	300	1781283300	51188.730000	51190.350521	51182.875704	51190.350521
73293	DOW	300	1778577600	49702.141659	49716.261227	49698.449693	49707.168098
161065	DXY	300	1781283300	99.741000	99.745277	99.739156	99.745277
77304	DOW	300	1778652900	49763.201926	49767.977813	49749.717233	49759.052229
77305	DXY	300	1778652900	98.313558	98.356463	98.310471	98.344318
76029	DOW	300	1778650800	49759.314845	49768.134589	49752.024329	49761.421497
74010	DOW	300	1778635800	49760.560000	49763.735812	49756.526626	49760.339969
74011	DXY	300	1778635800	98.332000	98.332000	98.316000	98.324208
148867	DXY	300	1781180100	100.052534	100.061000	100.038650	100.061000
76030	DXY	300	1778650800	98.308588	98.321757	98.303168	98.310530
75318	DOW	300	1778649600	49760.376713	49769.702586	49755.435136	49761.677312
74916	DOW	300	1778637600	49753.568535	49771.665668	49752.196170	49758.780811
160961	SP500	300	1781282100	7423.001818	7423.304136	7416.187947	7416.187947
74199	DOW	300	1778636400	49758.369469	49768.700933	49753.532736	49761.769529
74200	DXY	300	1778636400	98.313627	98.328214	98.299463	98.304934
141380	SP500	300	1781167800	7267.212555	7268.478867	7266.083480	7266.933759
74917	DXY	300	1778637600	98.266083	98.285768	98.261352	98.282390
141381	DOW	300	1781167800	49920.368205	49928.397919	49905.596553	49920.767266
75319	DXY	300	1778649600	98.325059	98.329143	98.302757	98.323909
141197	SP500	300	1781167500	7267.050962	7268.279427	7264.739466	7267.112517
141198	DOW	300	1781167500	49919.196964	49928.982221	49909.101970	49919.488357
75177	DOW	300	1778649300	49760.560000	49769.335209	49753.595593	49759.396431
75178	DXY	300	1778649300	98.319000	98.330232	98.312466	98.325073
141199	DXY	300	1781167500	100.036733	100.049842	100.021742	100.038521
73473	DOW	300	1778577900	49706.392249	49713.384547	49691.746691	49706.156572
73474	DXY	300	1778577900	98.270447	98.284647	98.260040	98.276662
75099	DOW	300	1778637900	49759.444404	49766.027448	49751.018072	49762.284794
74025	DOW	300	1778636100	49759.320527	49769.611734	49753.350964	49758.978815
74026	DXY	300	1778636100	98.322993	98.333177	98.304206	98.311681
141382	DXY	300	1781167800	100.040224	100.062669	100.033649	100.047891
75100	DXY	300	1778637900	98.283958	98.295782	98.277843	98.284767
76212	DOW	300	1778651100	49762.483965	49771.211992	49751.730460	49759.986833
73656	DOW	300	1778578200	49707.094157	49712.859941	49697.599313	49704.429477
73657	DXY	300	1778578200	98.278432	98.292779	98.256907	98.264550
160424	SP500	300	1781280000	7397.768695	7406.151542	7395.103265	7403.971119
76213	DXY	300	1778651100	98.311071	98.329715	98.308230	98.317873
149048	SP500	300	1781180400	7267.212431	7268.182568	7266.166629	7266.990000
149049	DOW	300	1781180400	49917.945425	49923.998144	49907.990984	49918.780000
75501	DOW	300	1778649900	49760.906709	49766.388155	49749.028920	49758.421304
75502	DXY	300	1778649900	98.325447	98.337322	98.318703	98.331582
149050	DXY	300	1781180400	100.060910	100.100874	100.060910	100.086000
148865	SP500	300	1781180100	7266.701885	7268.386125	7265.126934	7266.990000
74550	DOW	300	1778637000	49757.128615	49771.618909	49749.366707	49759.793330
74551	DXY	300	1778637000	98.290092	98.304629	98.283120	98.293605
148866	DOW	300	1781180100	49920.775813	49930.428265	49906.511925	49918.780000
74382	DOW	300	1778636700	49761.156551	49768.896876	49752.887388	49755.542238
73839	DOW	300	1778578500	49705.068016	49715.868030	49694.415269	49704.888808
73840	DXY	300	1778578500	98.263810	98.283339	98.254374	98.273181
74383	DXY	300	1778636700	98.304030	98.317205	98.284540	98.288131
160963	DXY	300	1781282100	99.765467	99.770239	99.742392	99.754984
160962	DOW	300	1781282100	51145.399729	51148.405322	51113.548627	51119.162206
76761	DOW	300	1778652000	49761.236628	49769.081728	49754.345035	49761.779641
76762	DXY	300	1778652000	98.321195	98.338019	98.305738	98.325647
160425	DOW	300	1781280000	51084.762740	51120.021270	51037.114590	51073.965983
74733	DOW	300	1778637300	49760.528621	49772.163624	49750.931628	49753.497012
74734	DXY	300	1778637300	98.294449	98.306325	98.264000	98.264055
160426	DXY	300	1781280000	99.736610	99.745426	99.709352	99.720775
76578	DOW	300	1778651700	49760.502012	49768.114866	49750.998595	49762.160487
75849	DOW	300	1778650500	49758.300331	49767.673933	49752.758274	49760.560000
75850	DXY	300	1778650500	98.307608	98.325236	98.300739	98.309000
75681	DOW	300	1778650200	49756.949507	49768.235080	49752.277947	49757.975205
75682	DXY	300	1778650200	98.329422	98.336170	98.307835	98.307850
161063	SP500	300	1781283300	7428.320000	7428.563134	7427.489672	7428.195545
76579	DXY	300	1778651700	98.326787	98.335381	98.300291	98.319786
77124	DOW	300	1778652600	49759.900154	49768.599164	49747.898699	49762.374123
77125	DXY	300	1778652600	98.320699	98.340870	98.310186	98.314797
161075	SP500	300	1781283600	7428.131212	7432.900000	7427.605989	7432.733945
161076	DOW	300	1781283600	51192.384314	51227.465839	51181.427527	51216.441160
76395	DOW	300	1778651400	49760.450888	49768.863373	49751.077015	49762.426284
76396	DXY	300	1778651400	98.316264	98.340808	98.312000	98.328612
161077	DXY	300	1781283600	99.743270	99.755484	99.726990	99.743186
77853	DOW	300	1778653800	49761.259924	49770.504864	49743.601793	49761.187333
76944	DOW	300	1778652300	49763.030474	49770.720513	49749.992379	49761.781401
76945	DXY	300	1778652300	98.325244	98.336975	98.309421	98.319276
161258	SP500	300	1781283900	7432.783237	7441.478246	7431.759311	7435.467521
77487	DOW	300	1778653200	49758.334018	49768.505186	49749.385049	49761.206733
77488	DXY	300	1778653200	98.345442	98.377506	98.344861	98.360561
161259	DOW	300	1781283900	51218.431252	51266.834328	51201.511266	51215.812826
161260	DXY	300	1781283900	99.745296	99.751746	99.726161	99.739416
77854	DXY	300	1778653800	98.360922	98.392615	98.356086	98.379905
77670	DOW	300	1778653500	49760.298231	49770.093626	49748.596361	49761.381273
77671	DXY	300	1778653500	98.362045	98.391507	98.349129	98.361289
172769	SP500	300	1782112200	7500.917329	7501.819748	7498.561505	7500.423989
78036	DOW	300	1778654100	49761.160588	49773.244035	49750.733833	49759.814413
78037	DXY	300	1778654100	98.378294	98.386595	98.356694	98.372659
78198	DOW	300	1778823900	50063.460000	50063.769929	50057.894841	50060.435182
78199	DXY	300	1778823900	99.111000	99.117488	99.100576	99.103299
78219	DOW	300	1778824200	50059.226260	50074.836409	50054.458177	50063.127748
78220	DXY	300	1778824200	99.105378	99.124831	99.087865	99.117451
81883	DXY	300	1779152400	99.069834	99.080434	99.047527	99.078293
80400	DOW	300	1779081300	49524.080447	49534.342898	49517.591465	49524.110811
78402	DOW	300	1778824500	50064.558375	50074.503709	50056.904679	50065.709417
78403	DXY	300	1778824500	99.116012	99.206810	99.116012	99.186121
80220	DOW	300	1779081000	49519.010156	49534.455438	49515.411468	49525.537135
80221	DXY	300	1779081000	99.330898	99.348957	99.312221	99.339026
80401	DXY	300	1779081300	99.340515	99.340515	99.306433	99.329628
78942	DOW	300	1778825400	50065.687421	50075.254839	50055.253742	50057.841756
78943	DXY	300	1778825400	99.190350	99.201439	99.150389	99.163032
161555	SP500	300	1781285400	7427.260000	7428.814591	7425.301321	7426.777294
161556	DOW	300	1781285400	51212.870000	51214.831376	51200.621898	51209.791358
81519	DOW	300	1779151800	49689.561057	49697.643938	49676.009851	49691.386528
81520	DXY	300	1779151800	99.058216	99.080407	99.056167	99.063376
161557	DXY	300	1781285400	99.739000	99.745613	99.730561	99.739283
161441	SP500	300	1781284200	7435.180779	7436.298695	7431.318079	7433.317572
161442	DOW	300	1781284200	51216.837281	51222.670000	51202.380000	51217.412402
78576	DOW	300	1778824800	50063.460000	50068.585948	50047.660189	50060.950903
78577	DXY	300	1778824800	99.183000	99.189452	99.148557	99.169537
161443	DXY	300	1781284200	99.739319	99.749559	99.720704	99.733553
79506	DOW	300	1779079800	49531.149530	49536.864000	49520.071059	49527.264249
79507	DXY	300	1779079800	99.319903	99.324680	99.300328	99.310258
80040	DOW	300	1779080700	49525.045618	49535.511660	49519.336019	49520.417280
79305	DOW	300	1778826000	50065.325638	50075.213054	50058.355363	50069.093957
79306	DXY	300	1778826000	99.130305	99.150711	99.109539	99.134425
149231	SP500	300	1781180700	7266.801201	7268.502965	7265.329781	7267.048246
80041	DXY	300	1779080700	99.323338	99.337869	99.314444	99.332927
149232	DOW	300	1781180700	49919.607467	49931.508687	49905.557012	49920.629673
149233	DXY	300	1781180700	100.085366	100.101656	100.057000	100.100939
80763	DOW	300	1779081900	49515.933889	49536.577693	49514.657979	49527.081830
141563	SP500	300	1781168100	7266.649588	7268.276164	7265.161990	7266.990000
79494	DOW	300	1779079500	49526.170000	49531.229698	49526.090115	49530.298801
79495	DXY	300	1779079500	99.319000	99.327118	99.318000	99.319785
141564	DOW	300	1781168100	49922.530435	49925.396817	49910.047964	49918.780000
80764	DXY	300	1779081900	99.338245	99.352671	99.328201	99.329027
141565	DXY	300	1781168100	100.048029	100.076040	100.036708	100.069000
78759	DOW	300	1778825100	50062.001307	50071.606865	50054.352464	50067.050419
78760	DXY	300	1778825100	99.168742	99.199446	99.157127	99.190884
79674	DOW	300	1779080100	49528.602907	49534.374429	49516.528681	49532.642544
79675	DXY	300	1779080100	99.308659	99.328358	99.301808	99.319940
161792	SP500	300	1781286000	7430.077197	7433.338773	7426.833892	7429.736765
161793	DOW	300	1781286000	51224.077847	51233.943301	51199.136070	51221.456500
79125	DOW	300	1778825700	50059.782787	50073.434345	50056.560337	50064.571149
79126	DXY	300	1778825700	99.161127	99.171386	99.116948	99.132711
161794	DXY	300	1781286000	99.728508	99.749534	99.726818	99.733466
81342	DOW	300	1779151500	49683.171570	49698.640491	49678.494525	49689.413136
80580	DOW	300	1779081600	49524.775286	49535.338040	49516.461981	49516.890249
80581	DXY	300	1779081600	99.327435	99.345603	99.303364	99.335871
81343	DXY	300	1779151500	99.036331	99.059460	99.032201	99.056410
161609	SP500	300	1781285700	7427.029091	7432.121081	7426.282127	7430.150642
80946	DOW	300	1779082200	49525.842469	49533.536486	49515.729720	49523.656365
80947	DXY	300	1779082200	99.328246	99.345443	99.313144	99.320654
161610	DOW	300	1781285700	51210.639966	51237.233840	51196.099873	51224.119809
161611	DXY	300	1781285700	99.739942	99.747781	99.722615	99.730917
79857	DOW	300	1779080400	49533.741200	49540.597076	49520.253401	49526.466261
79858	DXY	300	1779080400	99.321056	99.329566	99.311544	99.321305
81129	DOW	300	1779082500	49524.457103	49533.123375	49520.236640	49527.597157
81130	DXY	300	1779082500	99.320150	99.329837	99.310899	99.317944
162071	SP500	300	1781286600	7431.301381	7432.613069	7429.208846	7431.463415
81246	DOW	300	1779151200	49686.120000	49689.244161	49679.218108	49684.265292
81247	DXY	300	1779151200	99.029000	99.040284	99.018818	99.035963
162072	DOW	300	1781286600	51230.202448	51253.454004	51220.380828	51235.668388
82327	DXY	300	1779153300	99.087000	99.090010	99.072602	99.084130
162073	DXY	300	1781286600	99.730505	99.750240	99.717481	99.729796
82248	DOW	300	1779153000	49690.620914	49693.672631	49680.396358	49686.975681
82249	DXY	300	1779153000	99.076980	99.099521	99.073333	99.077344
81699	DOW	300	1779152100	49691.216788	49697.132818	49678.695403	49689.726089
81700	DXY	300	1779152100	99.065187	99.074451	99.053786	99.070249
162254	SP500	300	1781286900	7431.219636	7431.643918	7421.925177	7425.508429
162255	DOW	300	1781286900	51236.113915	51238.121269	51179.372555	51202.021013
82438	DXY	300	1779153600	99.083019	99.086745	99.059915	99.077159
82804	DXY	300	1779154200	99.079166	99.092261	99.067300	99.081619
162256	DXY	300	1781286900	99.729918	99.748627	99.719075	99.730527
81882	DOW	300	1779152400	49689.049498	49694.479904	49678.487656	49688.136086
82065	DOW	300	1779152700	49688.042561	49691.937311	49673.466276	49691.695562
82066	DXY	300	1779152700	99.078289	99.097925	99.063077	99.075707
162543	DOW	300	1781288400	51207.190000	51213.459216	51186.347634	51213.459216
82326	DOW	300	1779153300	49686.120000	49693.420162	49674.619791	49686.027869
82437	DOW	300	1779153600	49687.854060	49694.719134	49678.641962	49685.178895
162544	DXY	300	1781288400	99.749000	99.760462	99.741123	99.750037
82620	DOW	300	1779153900	49686.090317	49694.437378	49678.143490	49682.975767
82621	DXY	300	1779153900	99.076358	99.078000	99.054517	99.077741
162542	SP500	300	1781288400	7418.600000	7419.294827	7416.472086	7419.294827
82984	DXY	300	1779154500	99.083084	99.091726	99.062772	99.068625
82803	DOW	300	1779154200	49681.551452	49693.801054	49675.270271	49686.013428
83163	DOW	300	1779154800	49687.118185	49693.621338	49677.613278	49684.571446
162623	SP500	300	1781288700	7419.371208	7425.926005	7417.799842	7424.310850
82983	DOW	300	1779154500	49687.525049	49697.325544	49679.972980	49688.103029
162624	DOW	300	1781288700	51214.212051	51235.224482	51202.380064	51224.221644
85881	DOW	300	1779265500	49364.265605	49373.800105	49357.008977	49367.088657
85882	DXY	300	1779265500	99.446969	99.460397	99.425261	99.453542
83883	DOW	300	1779156000	49686.667631	49691.584373	49676.718597	49690.963434
83884	DXY	300	1779156000	99.044762	99.057449	99.031960	99.042285
161975	SP500	300	1781286300	7429.469453	7431.664187	7429.224851	7431.410386
84816	DOW	300	1779254700	49365.500952	49371.232376	49354.225682	49368.513374
84817	DXY	300	1779254700	99.359204	99.370742	99.349420	99.355259
161976	DOW	300	1781286300	51221.786877	51233.430890	51217.436228	51228.783720
83523	DOW	300	1779155400	49688.784769	49695.283137	49676.234685	49686.171873
83524	DXY	300	1779155400	99.058043	99.071004	99.018546	99.021734
161977	DXY	300	1781286300	99.733849	99.746900	99.723912	99.731535
86454	DOW	300	1779432600	50285.660000	50296.117609	50278.475913	50285.401148
86455	DXY	300	1779432600	99.290000	99.305070	99.273443	99.273443
162439	DXY	300	1781287200	99.732039	99.744305	99.728961	99.733489
86271	DOW	300	1779432300	50285.660000	50294.097427	50278.273849	50282.726470
86272	DXY	300	1779432300	99.268000	99.290000	99.251928	99.279633
149414	SP500	300	1781181000	7267.064732	7268.052837	7265.345765	7266.990000
141746	SP500	300	1781168400	7266.917960	7268.194618	7265.710282	7266.990000
84453	DOW	300	1779254100	49365.002772	49372.907450	49353.315441	49362.110331
84454	DXY	300	1779254100	99.355619	99.360695	99.340781	99.355380
141747	DOW	300	1781168400	49920.711732	49925.587853	49910.521709	49918.780000
84249	DOW	300	1779156600	49684.857400	49695.427813	49676.287742	49678.566298
84250	DXY	300	1779156600	99.068108	99.097787	99.060226	99.088388
141748	DXY	300	1781168400	100.068885	100.106986	100.057316	100.098000
84450	DOW	300	1779253800	49363.880000	49363.880000	49363.880000	49363.880000
84451	DXY	300	1779253800	99.356000	99.356000	99.356000	99.356000
83703	DOW	300	1779155700	49684.261822	49697.344666	49670.463387	49686.551381
83704	DXY	300	1779155700	99.019389	99.051442	99.016766	99.043013
149415	DOW	300	1781181000	49921.315734	49927.971696	49909.609394	49918.780000
149416	DXY	300	1781181000	100.101771	100.194142	100.069952	100.167000
85149	DOW	300	1779264300	49361.016476	49373.633067	49353.955932	49362.792689
85150	DXY	300	1779264300	99.400899	99.424068	99.399123	99.410431
83164	DXY	300	1779154800	99.066253	99.089242	99.061700	99.081943
141929	SP500	300	1781168700	7267.006939	7268.643325	7265.507982	7266.830373
141930	DOW	300	1781168700	49916.940356	49930.682894	49912.883340	49918.032460
84978	DOW	300	1779264000	49363.880000	49375.383756	49356.429591	49361.968971
84979	DXY	300	1779264000	99.402000	99.425658	99.389494	99.402805
141931	DXY	300	1781168700	100.100488	100.104502	100.069615	100.089982
84066	DOW	300	1779156300	49689.839292	49697.128861	49676.645715	49685.117025
84067	DXY	300	1779156300	99.043565	99.077549	99.041089	99.067722
149594	SP500	300	1781181300	7267.280125	7268.215674	7265.635931	7266.990000
149595	DOW	300	1781181300	49919.528846	49927.551393	49909.589665	49918.780000
83343	DOW	300	1779155100	49686.357976	49698.243692	49677.822309	49686.925085
83344	DXY	300	1779155100	99.082026	99.085486	99.053675	99.055814
162625	DXY	300	1781288700	99.751802	99.759758	99.739552	99.749121
84633	DOW	300	1779254400	49360.379256	49376.610773	49356.096519	49365.737509
84634	DXY	300	1779254400	99.355095	99.368535	99.339575	99.360540
87787	DXY	300	1779435000	99.314391	99.327510	99.285735	99.296360
85332	DOW	300	1779264600	49362.752060	49373.251116	49354.297304	49363.429800
85333	DXY	300	1779264600	99.410284	99.427271	99.382520	99.387736
149596	DXY	300	1781181300	100.164914	100.215454	100.132000	100.132000
162437	SP500	300	1781287200	7425.647267	7428.050613	7423.051487	7424.195860
86064	DOW	300	1779265800	49368.810764	49375.961886	49357.325409	49363.691472
86065	DXY	300	1779265800	99.453926	99.473849	99.439081	99.456696
85698	DOW	300	1779265200	49360.960889	49369.369675	49355.552983	49364.647501
85699	DXY	300	1779265200	99.405571	99.459416	99.405089	99.446236
87237	DOW	300	1779434100	50286.460536	50297.061842	50275.878537	50281.150454
162438	DOW	300	1781287200	51203.389493	51223.297818	51190.092880	51208.090676
85515	DOW	300	1779264900	49365.102448	49372.484175	49354.706810	49362.050088
85516	DXY	300	1779264900	99.386243	99.411035	99.380465	99.405786
86631	DOW	300	1779432900	50284.676134	50297.246988	50275.606911	50285.645501
86632	DXY	300	1779432900	99.271792	99.289049	99.254006	99.277818
86991	DOW	300	1779433500	50287.886235	50294.369234	50274.707337	50289.114333
86811	DOW	300	1779433200	50284.842597	50296.255282	50271.144185	50287.488767
162806	SP500	300	1781289000	7424.352685	7430.329046	7424.104967	7428.360794
86812	DXY	300	1779433200	99.275764	99.293406	99.267247	99.291725
162807	DOW	300	1781289000	51223.321537	51253.987754	51209.408880	51245.092595
162808	DXY	300	1781289000	99.749738	99.763287	99.727156	99.735322
86226	DOW	300	1779432000	50285.660000	50290.398657	50279.438700	50280.847353
86227	DXY	300	1779432000	99.270000	99.278322	99.265122	99.276231
86992	DXY	300	1779433500	99.289854	99.292464	99.255574	99.261379
172770	DOW	300	1782112200	51558.986212	51577.668340	51556.213883	51562.497626
172771	DXY	300	1782112200	100.884505	100.891107	100.860424	100.884894
87108	DOW	300	1779433800	50285.660000	50295.460763	50276.608079	50286.347100
87603	DOW	300	1779434700	50288.494047	50296.449841	50279.967762	50283.332091
87420	DOW	300	1779434400	50279.569457	50293.833112	50275.363276	50287.263672
87109	DXY	300	1779433800	99.296000	99.320041	99.283950	99.301671
87238	DXY	300	1779434100	99.302995	99.320422	99.296055	99.312262
87421	DXY	300	1779434400	99.314586	99.333000	99.301743	99.327801
172952	SP500	300	1782112500	7500.586511	7501.332805	7498.904515	7501.142837
87604	DXY	300	1779434700	99.326998	99.340226	99.302733	99.316232
172953	DOW	300	1782112500	51561.394966	51572.122987	51553.531319	51565.750803
172954	DXY	300	1782112500	100.886518	100.892725	100.852978	100.882206
87786	DOW	300	1779435000	50285.026021	50293.932746	50279.401640	50282.502264
175036	DXY	300	1782716700	101.205276	101.205891	101.151002	101.161993
87966	DOW	300	1779435300	50281.511175	50294.812153	50274.856536	50284.053810
87967	DXY	300	1779435300	99.295558	99.306824	99.275724	99.282044
175034	SP500	300	1782716700	7354.327402	7355.670020	7353.196029	7354.793273
88513	DXY	300	1779436200	99.302170	99.307548	99.279722	99.291660
90153	DOW	300	1779438900	50281.481681	50294.123318	50275.948817	50283.977779
90154	DXY	300	1779438900	99.246000	99.262924	99.228573	99.247129
162991	DXY	300	1781289300	99.737179	99.748880	99.726569	99.726569
90333	DOW	300	1779439200	50285.184565	50295.151295	50275.122525	50285.490340
90334	DXY	300	1779439200	99.248120	99.271270	99.231317	99.269913
91729	DXY	300	1780383000	99.061465	99.080379	99.047733	99.066906
91608	DOW	300	1779441300	50289.141133	50290.952826	50276.031642	50285.139914
91425	DOW	300	1779441000	50286.913592	50297.000436	50274.953779	50291.059456
91426	DXY	300	1779441000	99.276738	99.289601	99.265577	99.282141
149777	SP500	300	1781181600	7266.976701	7268.729396	7265.786416	7266.990000
89970	DOW	300	1779438600	50291.503590	50292.979369	50277.332314	50283.128046
89971	DXY	300	1779438600	99.247470	99.260752	99.210525	99.246717
149778	DOW	300	1781181600	49920.629118	49929.806094	49907.966528	49918.780000
142112	SP500	300	1781169000	7267.029455	7268.635550	7266.017482	7267.199905
88692	DOW	300	1779436500	50282.429801	50292.173879	50276.078079	50285.244968
88693	DXY	300	1779436500	99.293936	99.302552	99.278042	99.289135
142113	DOW	300	1781169000	49918.904800	49932.605699	49906.958697	49917.065182
88149	DOW	300	1779435600	50283.491325	50292.793647	50276.198181	50286.155566
88150	DXY	300	1779435600	99.282276	99.307874	99.276037	99.289940
142114	DXY	300	1781169000	100.089717	100.103065	100.081681	100.089543
89421	DOW	300	1779437700	50294.272284	50295.799538	50276.777506	50284.218652
89422	DXY	300	1779437700	99.264654	99.294225	99.255922	99.284505
89238	DOW	300	1779437400	50288.549372	50295.465536	50275.160643	50292.396579
89239	DXY	300	1779437400	99.278724	99.288116	99.250221	99.265720
149779	DXY	300	1781181600	100.134333	100.202704	100.120000	100.170000
91609	DXY	300	1779441300	99.280227	99.295306	99.268446	99.281102
91725	DOW	300	1780382700	51078.880000	51078.880000	51076.682745	51077.488346
88332	DOW	300	1779435900	50287.560698	50295.435432	50278.128613	50283.320957
88333	DXY	300	1779435900	99.290326	99.303139	99.282326	99.299948
163302	DOW	300	1781292000	51223.735626	51239.515969	51211.763594	51229.669573
89055	DOW	300	1779437100	50285.789266	50291.824668	50278.848003	50287.743742
89056	DXY	300	1779437100	99.281733	99.301397	99.263016	99.278090
163301	SP500	300	1781292000	7428.956822	7429.712674	7426.585504	7427.960941
90516	DOW	300	1779439500	50286.953978	50294.003020	50279.136150	50287.630107
90517	DXY	300	1779439500	99.267973	99.299433	99.254260	99.266320
163034	SP500	300	1781291400	7426.280000	7430.137892	7426.027347	7426.027347
89604	DOW	300	1779438000	50284.668797	50294.126988	50277.889247	50282.226641
89605	DXY	300	1779438000	99.282943	99.293423	99.266294	99.286426
163035	DOW	300	1781291400	51217.560000	51238.266042	51215.911164	51227.894414
163303	DXY	300	1781292000	99.733669	99.745764	99.729036	99.742227
163118	SP500	300	1781291700	7426.103062	7428.992193	7422.527767	7428.843289
91059	DOW	300	1779440400	50284.248392	50301.972845	50278.266193	50288.160991
91060	DXY	300	1779440400	99.261451	99.272939	99.248504	99.266118
162989	SP500	300	1781289300	7428.285923	7428.790863	7428.170066	7428.388351
162990	DOW	300	1781289300	51246.727822	51248.988937	51241.610000	51243.559118
88512	DOW	300	1779436200	50284.976177	50293.233130	50276.808276	50283.007251
163119	DOW	300	1781291700	51229.517655	51235.302764	51199.136187	51221.995077
88872	DOW	300	1779436800	50284.598216	50294.819285	50276.130896	50286.634940
88873	DXY	300	1779436800	99.289790	99.298314	99.271031	99.284021
163036	DXY	300	1781291400	99.726000	99.733203	99.709412	99.721271
91242	DOW	300	1779440700	50287.315447	50294.991988	50278.076246	50288.655496
91243	DXY	300	1779440700	99.268354	99.283647	99.261920	99.274259
89787	DOW	300	1779438300	50283.788737	50292.157921	50275.045443	50290.800546
89788	DXY	300	1779438300	99.286388	99.292966	99.236993	99.247771
163120	DXY	300	1781291700	99.718837	99.741016	99.711569	99.734077
91726	DXY	300	1780382700	99.056000	99.059761	99.056000	99.059761
90879	DOW	300	1779440100	50285.436700	50292.707923	50275.080845	50284.983103
90880	DXY	300	1779440100	99.273689	99.279221	99.245028	99.260641
90699	DOW	300	1779439800	50287.681802	50295.690103	50277.723353	50286.246952
90700	DXY	300	1779439800	99.264184	99.275073	99.246924	99.273709
163526	SP500	300	1781293500	7418.030000	7424.437693	7416.685699	7422.100173
163527	DOW	300	1781293500	51166.550000	51185.058002	51146.704797	51173.638556
163528	DXY	300	1781293500	99.763000	99.773924	99.738479	99.754130
92091	DOW	300	1780383600	51078.194569	51090.367490	51070.745113	51082.612706
92092	DXY	300	1780383600	99.067648	99.088817	99.054290	99.067935
92640	DOW	300	1780384500	51080.010603	51087.146426	51067.863584	51073.508923
91908	DOW	300	1780383300	51082.959630	51090.240806	51073.062002	51078.459939
91909	DXY	300	1780383300	99.067799	99.085682	99.063296	99.069384
163676	SP500	300	1781293800	7421.829212	7424.851039	7420.088651	7424.149957
163677	DOW	300	1781293800	51173.897335	51201.536958	51162.878723	51191.225705
163678	DXY	300	1781293800	99.752513	99.780709	99.744304	99.762903
91728	DOW	300	1780383000	51078.253165	51088.250594	51071.080965	51081.395927
92641	DXY	300	1780384500	99.058514	99.090378	99.054340	99.074648
92274	DOW	300	1780383900	51081.863999	51086.398135	51068.031763	51074.735870
92275	DXY	300	1780383900	99.069305	99.078229	99.054754	99.067999
92457	DOW	300	1780384200	51074.029876	51088.665358	51070.039778	51080.940819
92458	DXY	300	1780384200	99.065605	99.083215	99.048425	99.060115
164282	SP500	300	1781295000	7432.055989	7433.083569	7430.396344	7431.978226
164283	DOW	300	1781295000	51192.948484	51213.916081	51192.852370	51203.558028
92823	DOW	300	1780384800	51072.667131	51087.287870	51067.005309	51080.352373
92824	DXY	300	1780384800	99.074545	99.091212	99.069713	99.080349
164284	DXY	300	1781295000	99.767144	99.785344	99.753210	99.777204
93006	DOW	300	1780385100	51078.475768	51088.181833	51073.917173	51083.637918
93007	DXY	300	1780385100	99.078084	99.104132	99.077814	99.097852
164465	SP500	300	1781295300	7431.460000	7432.827702	7430.207871	7432.289941
93189	DOW	300	1780385400	51083.108459	51088.794509	51067.395960	51075.418417
93190	DXY	300	1780385400	99.099290	99.108430	99.080296	99.087899
96639	DOW	300	1780638300	51560.212313	51571.747640	51549.806195	51561.086733
96640	DXY	300	1780638300	99.386914	99.402377	99.368989	99.389952
96459	DOW	300	1780638000	51564.786379	51572.554336	51555.061551	51561.668638
96099	DOW	300	1780637400	51557.278376	51573.576306	51547.894210	51561.023511
96100	DXY	300	1780637400	99.410376	99.412768	99.394550	99.402807
95187	DOW	300	1780635900	51565.644345	51571.230992	51549.409574	51557.814550
95188	DXY	300	1780635900	99.407545	99.412472	99.382718	99.402987
164039	SP500	300	1781294400	7431.331059	7432.815573	7429.842643	7431.331874
93372	DOW	300	1780385700	51073.386508	51086.858361	51071.250152	51078.086998
93373	DXY	300	1780385700	99.086912	99.108029	99.084693	99.097034
164040	DOW	300	1781294400	51202.785672	51212.890468	51194.682572	51202.842540
164041	DXY	300	1781294400	99.767438	99.780133	99.755356	99.777098
96460	DXY	300	1780638000	99.399161	99.405466	99.376216	99.385041
163859	SP500	300	1781294100	7424.224228	7431.220000	7423.881003	7431.055805
163860	DOW	300	1781294100	51189.359312	51221.481152	51175.310000	51202.916041
94272	DOW	300	1780634400	51563.018178	51571.532426	51551.524058	51557.047644
94273	DXY	300	1780634400	99.424326	99.432562	99.405514	99.419501
163861	DXY	300	1781294100	99.764790	99.782284	99.758329	99.768224
163484	SP500	300	1781292300	7427.947784	7429.901475	7427.517536	7428.458289
93921	DOW	300	1780386600	51084.633643	51084.841377	51069.831418	51079.901153
93922	DXY	300	1780386600	99.078559	99.089729	99.065935	99.079140
163485	DOW	300	1781292300	51229.023368	51229.974544	51224.395781	51227.268944
163486	DXY	300	1781292300	99.742796	99.743671	99.727691	99.727691
94455	DOW	300	1780634700	51556.727804	51570.093048	51551.318370	51556.708553
94456	DXY	300	1780634700	99.420006	99.423491	99.400757	99.412127
173135	SP500	300	1782112800	7501.332075	7502.599101	7498.861060	7500.632165
164466	DOW	300	1781295300	51202.260000	51217.023171	51194.472067	51196.383184
93555	DOW	300	1780386000	51078.483685	51087.250056	51065.230456	51080.820647
93556	DXY	300	1780386000	99.096225	99.107479	99.074333	99.092776
173136	DOW	300	1782112800	51564.455373	51570.908994	51553.255793	51568.397152
94146	DOW	300	1780634100	51561.930000	51569.212687	51556.637098	51562.706396
94147	DXY	300	1780634100	99.407000	99.429417	99.395307	99.422830
149960	SP500	300	1781181900	7266.742450	7268.489171	7265.284873	7266.990000
149961	DOW	300	1781181900	49917.037103	49928.432574	49912.125341	49918.780000
149962	DXY	300	1781181900	100.171756	100.187275	100.144275	100.155000
94104	DOW	300	1780386900	51079.012903	51080.356237	51075.417861	51075.417861
94105	DXY	300	1780386900	99.080735	99.083293	99.074574	99.079997
142295	SP500	300	1781169300	7267.201467	7268.263286	7265.985748	7267.158428
95370	DOW	300	1780636200	51557.583671	51570.449424	51553.522475	51563.880711
95371	DXY	300	1780636200	99.400570	99.417603	99.393350	99.408655
142296	DOW	300	1781169300	49917.914639	49927.392623	49907.922073	49920.234409
142297	DXY	300	1781169300	100.087237	100.115051	100.080223	100.109524
95004	DOW	300	1780635600	51560.775853	51567.211502	51551.221706	51564.634763
95005	DXY	300	1780635600	99.412210	99.417547	99.388866	99.407452
94638	DOW	300	1780635000	51556.116261	51575.212888	51551.388275	51558.102133
94639	DXY	300	1780635000	99.410818	99.415703	99.399021	99.412842
93738	DOW	300	1780386300	51080.996082	51086.496510	51069.519198	51083.771399
93739	DXY	300	1780386300	99.094504	99.100826	99.068621	99.077218
96279	DOW	300	1780637700	51562.597417	51574.290577	51552.388671	51563.744839
96280	DXY	300	1780637700	99.404139	99.416376	99.388453	99.399978
95736	DOW	300	1780636800	51564.601198	51569.291082	51555.133523	51558.895980
95737	DXY	300	1780636800	99.407534	99.420475	99.394639	99.401593
95919	DOW	300	1780637100	51557.927822	51572.745545	51553.543910	51557.940447
164467	DXY	300	1781295300	99.772000	99.789263	99.766339	99.777001
94821	DOW	300	1780635300	51556.928549	51568.494859	51551.760276	51558.902491
94822	DXY	300	1780635300	99.410881	99.420373	99.397377	99.411546
173137	DXY	300	1782112800	100.880879	100.890058	100.854842	100.869877
95553	DOW	300	1780636500	51564.134545	51571.627521	51553.506697	51566.203506
95554	DXY	300	1780636500	99.409853	99.419628	99.397118	99.407174
95920	DXY	300	1780637100	99.401311	99.422877	99.396365	99.411891
97548	DOW	300	1780639800	51561.797354	51571.792578	51554.503820	51565.679324
97731	DOW	300	1780640100	51563.955001	51570.237852	51553.369135	51559.846927
96819	DOW	300	1780638600	51561.029985	51569.120647	51552.144984	51560.957547
96820	DXY	300	1780638600	99.389699	99.404488	99.384606	99.402579
173318	SP500	300	1782113100	7500.601941	7501.604524	7499.159446	7501.036830
97732	DXY	300	1780640100	99.417074	99.431123	99.400154	99.423572
173319	DOW	300	1782113100	51566.718888	51573.297765	51557.741538	51558.645521
173320	DXY	300	1782113100	100.869646	100.887702	100.855979	100.887702
97182	DOW	300	1780639200	51563.585859	51573.487226	51554.302468	51566.091540
96999	DOW	300	1780638900	51559.099547	51574.844121	51544.770503	51565.617577
97000	DXY	300	1780638900	99.404243	99.407613	99.378084	99.386285
175035	DOW	300	1782716700	51877.406393	51886.136546	51866.357342	51867.879575
97183	DXY	300	1780639200	99.387042	99.407538	99.382816	99.393997
97549	DXY	300	1780639800	99.413801	99.429302	99.406607	99.416233
175214	SP500	300	1782717000	7354.939806	7355.823056	7352.352315	7353.153398
97365	DOW	300	1780639500	51564.959895	51573.795906	51551.796831	51562.765657
97366	DXY	300	1780639500	99.393008	99.414395	99.383139	99.412272
175215	DOW	300	1782717000	51866.022053	51883.314968	51865.465223	51881.722591
97914	DOW	300	1780640400	51561.909230	51569.202925	51549.393649	51560.049952
97915	DXY	300	1780640400	99.422516	99.429126	99.400503	99.412245
175216	DXY	300	1782717000	101.164371	101.215848	101.163972	101.203785
98097	DOW	300	1780640700	51559.807409	51574.845924	51551.886216	51557.074221
98098	DXY	300	1780640700	99.412080	99.428888	99.402625	99.416177
177403	DXY	300	1782720600	101.252315	101.256749	101.209256	101.234658
98280	DOW	300	1780641000	51559.097172	51571.215612	51550.996393	51562.548651
98281	DXY	300	1780641000	99.418458	99.422873	99.404027	99.417754
98463	DOW	300	1780641300	51563.139743	51570.942809	51553.249950	51564.439695
103386	DOW	300	1780649400	51560.316364	51573.642108	51551.864767	51558.047121
101559	DOW	300	1780646400	51559.444786	51571.189675	51552.905478	51563.758449
101199	DOW	300	1780645800	51565.583500	51570.625812	51550.011550	51562.992733
101200	DXY	300	1780645800	99.250398	99.272753	99.245764	99.265438
101560	DXY	300	1780646400	99.250299	99.269412	99.241757	99.261874
150326	SP500	300	1781182500	7266.992287	7268.134060	7265.239648	7266.257165
99195	DOW	300	1780642500	51563.249262	51571.196681	51556.322694	51562.812888
99196	DXY	300	1780642500	99.356358	99.367343	99.331462	99.352175
150327	DOW	300	1781182500	49919.108016	49925.689831	49908.352822	49923.377264
150328	DXY	300	1781182500	100.117554	100.132000	100.058800	100.087233
98829	DOW	300	1780641900	51568.845379	51569.923485	51555.114817	51560.101670
98830	DXY	300	1780641900	99.370498	99.384495	99.356259	99.367997
101019	DOW	300	1780645500	51556.448622	51572.327022	51550.008494	51564.294864
150143	SP500	300	1781182200	7266.923606	7268.144143	7265.617443	7266.990000
100293	DOW	300	1780644300	51564.636361	51575.601974	51553.558476	51566.936511
100294	DXY	300	1780644300	99.325045	99.327744	99.297965	99.323850
150144	DOW	300	1781182200	49917.795985	49925.749587	49907.360620	49918.780000
101020	DXY	300	1780645500	99.274460	99.280020	99.224339	99.250982
150145	DXY	300	1781182200	100.155424	100.170645	100.101426	100.117000
103203	DOW	300	1780649100	51560.825872	51571.520745	51553.088414	51562.174075
103204	DXY	300	1780649100	99.244474	99.250392	99.224097	99.230815
164219	SP500	300	1781294700	7431.507487	7432.373587	7430.335199	7432.281364
164220	DOW	300	1781294700	51201.933723	51213.105771	51194.835226	51194.835226
101379	DOW	300	1780646100	51564.817777	51571.755405	51554.368846	51558.028124
164221	DXY	300	1781294700	99.778170	99.784420	99.764100	99.767826
99744	DOW	300	1780643400	51563.651520	51574.173426	51555.052618	51562.957039
99745	DXY	300	1780643400	99.347063	99.360477	99.335593	99.336287
142661	SP500	300	1781169900	7267.103572	7268.496323	7265.938671	7266.990000
142662	DOW	300	1781169900	49918.161071	49925.508402	49908.741609	49918.780000
99561	DOW	300	1780643100	51567.830163	51570.278575	51553.379194	51562.975371
99562	DXY	300	1780643100	99.362742	99.363971	99.342346	99.349269
142663	DXY	300	1781169900	100.085065	100.089944	100.052579	100.066000
142478	SP500	300	1781169600	7266.893200	7268.032162	7265.438545	7266.990000
99012	DOW	300	1780642200	51559.216508	51573.544975	51552.292236	51565.088385
99013	DXY	300	1780642200	99.367860	99.374614	99.345650	99.358155
142479	DOW	300	1781169600	49921.380061	49927.324062	49911.136991	49918.780000
98464	DXY	300	1780641300	99.415913	99.426204	99.387019	99.392285
142480	DXY	300	1781169600	100.109239	100.117670	100.078863	100.083000
101380	DXY	300	1780646100	99.266958	99.273289	99.236499	99.250160
99927	DOW	300	1780643700	51562.926862	51576.640272	51554.665480	51555.389796
99928	DXY	300	1780643700	99.335693	99.351511	99.321296	99.325151
98646	DOW	300	1780641600	51563.157969	51577.182228	51550.798262	51567.885873
98647	DXY	300	1780641600	99.392271	99.403010	99.367508	99.368228
99378	DOW	300	1780642800	51562.458844	51571.782642	51554.609770	51566.073593
99379	DXY	300	1780642800	99.352735	99.374789	99.349731	99.361749
103020	DOW	300	1780648800	51562.781236	51573.253416	51554.040518	51559.642627
164648	SP500	300	1781295600	7431.460000	7433.026561	7430.147876	7431.414833
100659	DOW	300	1780644900	51565.366095	51567.136221	51549.991389	51563.999419
100660	DXY	300	1780644900	99.294737	99.312150	99.282473	99.282473
164649	DOW	300	1781295600	51202.260000	51211.306806	51195.357350	51203.128978
102105	DOW	300	1780647300	51568.370505	51574.522198	51548.484251	51561.205232
102106	DXY	300	1780647300	99.257719	99.261972	99.230540	99.240568
164650	DXY	300	1781295600	99.776000	99.785579	99.765347	99.777334
100110	DOW	300	1780644000	51554.040178	51570.651552	51550.836164	51563.128070
100111	DXY	300	1780644000	99.324893	99.343130	99.309680	99.325493
100839	DOW	300	1780645200	51563.239831	51570.416285	51554.756194	51554.756194
164790	DOW	300	1781297100	51202.260000	51214.261827	51186.731891	51195.709767
100840	DXY	300	1780645200	99.280763	99.298539	99.262338	99.272862
164791	DXY	300	1781297100	99.801000	99.812987	99.790492	99.801913
100476	DOW	300	1780644600	51566.357516	51568.446563	51553.431948	51567.160455
100477	DXY	300	1780644600	99.322681	99.326617	99.290013	99.295620
102288	DOW	300	1780647600	51561.968257	51570.321474	51553.243570	51564.900936
164789	SP500	300	1781297100	7431.460000	7433.216984	7429.710831	7432.236473
101739	DOW	300	1780646700	51564.320361	51570.547062	51554.664276	51554.999313
101740	DXY	300	1780646700	99.264327	99.279739	99.247742	99.279739
102289	DXY	300	1780647600	99.242250	99.259893	99.226424	99.230532
164966	SP500	300	1781297400	7432.072926	7432.429004	7430.051961	7430.540594
102471	DOW	300	1780647900	51564.626774	51569.725201	51552.602804	51563.847471
102472	DXY	300	1780647900	99.230764	99.242127	99.217544	99.223793
164967	DOW	300	1781297400	51195.876263	51212.113892	51191.866967	51199.518812
101922	DOW	300	1780647000	51553.108608	51570.483048	51551.917396	51566.527040
101923	DXY	300	1780647000	99.282062	99.283378	99.251189	99.259866
164968	DXY	300	1781297400	99.803497	99.813386	99.791468	99.805385
103021	DXY	300	1780648800	99.251275	99.251809	99.220666	99.243126
102654	DOW	300	1780648200	51563.549967	51567.446058	51555.401814	51556.804417
102655	DXY	300	1780648200	99.224360	99.252090	99.218890	99.231241
165284	SP500	300	1781298000	7431.460000	7432.304802	7430.110933	7432.304802
102837	DOW	300	1780648500	51558.481417	51571.646122	51554.695203	51561.032583
102838	DXY	300	1780648500	99.230337	99.250027	99.217365	99.249509
165285	DOW	300	1781298000	51202.260000	51206.978279	51194.818764	51197.529539
165286	DXY	300	1781298000	99.793000	99.806351	99.781437	99.806351
103387	DXY	300	1780649400	99.232747	99.245233	99.214502	99.243000
103569	DOW	300	1780649700	51559.531559	51567.940801	51553.774413	51557.334508
103570	DXY	300	1780649700	99.242418	99.250632	99.221637	99.247770
165744	DOW	300	1781300100	51202.260000	51203.725443	51195.133616	51201.602625
165745	DXY	300	1781300100	99.807000	99.815296	99.803763	99.809291
103752	DOW	300	1780650000	51557.344655	51568.479603	51547.993638	51563.826441
103753	DXY	300	1780650000	99.249395	99.254639	99.224705	99.241541
104665	DXY	300	1780651500	99.212969	99.219525	99.190528	99.211845
104301	DOW	300	1780650900	51563.079014	51575.016207	51551.265874	51564.954034
104302	DXY	300	1780650900	99.251109	99.256216	99.215520	99.222215
107223	DOW	300	1780655700	51560.446540	51566.986442	51559.457695	51565.516585
107224	DXY	300	1780655700	99.188785	99.196748	99.178300	99.178300
106125	DOW	300	1780653900	51561.774377	51569.570417	51550.551291	51557.466487
105942	DOW	300	1780653600	51564.568902	51573.207178	51555.022492	51561.161603
105943	DXY	300	1780653600	99.215616	99.237505	99.210690	99.219375
165778	DXY	300	1781300400	99.811544	99.816102	99.796330	99.812104
106126	DXY	300	1780653900	99.217512	99.229285	99.201518	99.210130
165410	SP500	300	1781298300	7432.154428	7433.081017	7430.229452	7431.041353
165411	DOW	300	1781298300	51198.827376	51209.311603	51195.482122	51197.515188
165412	DXY	300	1781298300	99.806976	99.824056	99.790541	99.807824
107301	DOW	300	1780661100	51561.290785	51570.521024	51552.557994	51554.757616
107302	DXY	300	1780661100	99.188393	99.209621	99.178065	99.204550
142844	SP500	300	1781170200	7266.763177	7267.851040	7265.310975	7266.990000
105759	DOW	300	1780653300	51566.881718	51574.788781	51551.489975	51564.923442
105760	DXY	300	1780653300	99.219101	99.229812	99.205180	99.217649
142845	DOW	300	1781170200	49919.884096	49929.842053	49908.654449	49918.780000
103935	DOW	300	1780650300	51562.299577	51571.006204	51554.810318	51562.332148
103936	DXY	300	1780650300	99.239298	99.258105	99.234901	99.250640
142846	DXY	300	1781170200	100.068050	100.092296	100.058995	100.075000
104484	DOW	300	1780651200	51566.365913	51586.758394	51534.883850	51567.354534
104485	DXY	300	1780651200	99.223793	99.243970	99.185468	99.211884
105210	DOW	300	1780652400	51559.682310	51574.356475	51548.087482	51558.205649
105211	DXY	300	1780652400	99.216024	99.231289	99.203538	99.216406
105027	DOW	300	1780652100	51561.707988	51571.807474	51552.280462	51559.867534
105028	DXY	300	1780652100	99.199148	99.225975	99.194022	99.216664
165743	SP500	300	1781300100	7431.460000	7433.128463	7430.389814	7430.999083
104118	DOW	300	1780650600	51561.906377	51569.881541	51552.995847	51564.387186
104119	DXY	300	1780650600	99.249474	99.271931	99.234289	99.248916
107271	DOW	300	1780660800	51561.930000	51566.290445	51558.438627	51561.441004
106308	DOW	300	1780654200	51556.085784	51573.964623	51552.416800	51562.234389
165149	SP500	300	1781297700	7430.538488	7432.924605	7429.932082	7431.623953
104844	DOW	300	1780651800	51556.532808	51570.934040	51550.958893	51563.365432
104845	DXY	300	1780651800	99.211687	99.223599	99.188115	99.198605
165150	DOW	300	1781297700	51200.809197	51207.151476	51194.482944	51199.571903
106309	DXY	300	1780654200	99.210072	99.226588	99.201981	99.217879
165151	DXY	300	1781297700	99.803350	99.813562	99.792002	99.799436
105393	DOW	300	1780652700	51559.968725	51571.485515	51553.947381	51566.237618
105394	DXY	300	1780652700	99.214926	99.232581	99.201259	99.220742
165961	DXY	300	1781300700	99.812439	99.819429	99.796461	99.810922
107272	DXY	300	1780660800	99.194000	99.197362	99.186864	99.189249
173503	DXY	300	1782113400	100.885589	100.923239	100.874277	100.922844
106857	DOW	300	1780655100	51563.288640	51572.166146	51552.025115	51562.325705
106858	DXY	300	1780655100	99.207859	99.216730	99.191541	99.192496
165959	SP500	300	1781300700	7431.624821	7433.033348	7429.814464	7431.578020
165960	DOW	300	1781300700	51198.414909	51213.239188	51194.150492	51200.187563
104664	DOW	300	1780651500	51565.418705	51570.769988	51550.662633	51555.459601
165776	SP500	300	1781300400	7431.222722	7433.005062	7430.513951	7431.368486
107040	DOW	300	1780655400	51560.957608	51580.618352	51554.315788	51560.345740
107041	DXY	300	1780655400	99.190751	99.204424	99.182265	99.187510
165777	DOW	300	1781300400	51200.565952	51217.011620	51195.927570	51197.993346
105576	DOW	300	1780653000	51566.809069	51571.241251	51551.633532	51567.296465
105577	DXY	300	1780653000	99.220226	99.234234	99.206944	99.220970
108208	DXY	300	1780673700	99.879811	99.893408	99.874548	99.878671
173501	SP500	300	1782113400	7501.091353	7502.236293	7498.342279	7500.551138
107841	DOW	300	1780673100	51383.046526	51413.863199	51369.403350	51381.409962
173502	DOW	300	1782113400	51558.276284	51572.117769	51556.006427	51562.989600
106674	DOW	300	1780654800	51565.840805	51570.510496	51547.519160	51561.996542
106491	DOW	300	1780654500	51562.170063	51573.049261	51550.396546	51564.499921
106492	DXY	300	1780654500	99.215947	99.227731	99.201363	99.204069
106675	DXY	300	1780654800	99.205110	99.218779	99.189964	99.205616
107842	DXY	300	1780673100	99.882907	99.904349	99.874323	99.895925
175582	DXY	300	1782717600	101.203917	101.230496	101.200935	101.217510
175397	SP500	300	1782717300	7353.145084	7355.204254	7352.660180	7354.070520
175398	DOW	300	1782717300	51881.143623	51887.520642	51867.126284	51868.707246
107763	DOW	300	1780672800	51381.000000	51406.634759	51368.381421	51383.388256
107764	DXY	300	1780672800	99.882000	99.893961	99.872995	99.884729
175399	DXY	300	1782717300	101.202417	101.219800	101.192486	101.205746
107484	DOW	300	1780661400	51553.383510	51570.936385	51542.592365	51561.759071
107485	DXY	300	1780661400	99.206999	99.220481	99.180155	99.206159
107667	DOW	300	1780661700	51562.646212	51573.413852	51557.502880	51563.898477
107668	DXY	300	1780661700	99.203721	99.218679	99.190871	99.210388
177401	SP500	300	1782720600	7353.713708	7355.273442	7352.789833	7353.867256
175580	SP500	300	1782717600	7354.327610	7355.758127	7352.682815	7354.462288
108024	DOW	300	1780673400	51380.451589	51409.163070	51372.904989	51380.937542
175581	DOW	300	1782717600	51869.742454	51885.861770	51864.854456	51876.310852
108207	DOW	300	1780673700	51381.423353	51383.151769	51351.541298	51362.306556
108025	DXY	300	1780673400	99.896392	99.920573	99.858065	99.881903
108256	DXY	300	1780674600	99.968000	99.982354	99.957909	99.966317
108595	DXY	300	1780675200	99.981863	99.997350	99.971243	99.983220
177402	DOW	300	1782720600	51873.000354	51885.125704	51865.476630	51867.165784
108255	DOW	300	1780674600	51270.050000	51287.315743	51264.846912	51268.666575
177581	SP500	300	1782720900	7353.953410	7355.577150	7352.558377	7353.215520
108411	DOW	300	1780674900	51268.142206	51284.493176	51243.303487	51243.303487
108412	DXY	300	1780674900	99.966372	99.994462	99.960889	99.984185
108594	DOW	300	1780675200	51241.356666	51269.523657	51236.269390	51267.321605
110937	DOW	300	1780692600	50873.911991	50875.566775	50855.566234	50864.349642
110379	DOW	300	1780690500	50867.449236	50876.829868	50858.358060	50868.443283
110380	DXY	300	1780690500	100.067231	100.111939	100.063122	100.096325
108807	DOW	300	1780683900	51095.942888	51102.466627	51045.512788	51064.265368
108808	DXY	300	1780683900	100.092306	100.102587	100.063584	100.071339
165593	SP500	300	1781298600	7431.460000	7432.423779	7430.507316	7431.394973
109434	DOW	300	1780686300	50891.873145	50922.000320	50875.681879	50884.423885
109435	DXY	300	1780686300	100.051643	100.074467	100.042179	100.068377
165594	DOW	300	1781298600	51202.260000	51210.171893	51188.897599	51202.725237
110754	DOW	300	1780692300	50862.114061	50874.620929	50861.015234	50871.963135
110755	DXY	300	1780692300	100.051749	100.076318	100.042318	100.075095
165595	DXY	300	1781298600	99.807000	99.815320	99.795701	99.810079
109251	DOW	300	1780686000	50937.842174	50944.176529	50891.415513	50892.662463
109252	DXY	300	1780686000	100.053749	100.067373	100.044380	100.052923
110562	DOW	300	1780690800	50866.531727	50875.615570	50856.837046	50867.599652
110196	DOW	300	1780690200	50868.905363	50874.838687	50858.540165	50868.305920
110197	DXY	300	1780690200	100.047309	100.072358	100.044768	100.065147
110563	DXY	300	1780690800	100.094019	100.107116	100.089346	100.098856
108987	DOW	300	1780684200	51065.939873	51092.408970	51040.609317	51064.261256
108988	DXY	300	1780684200	100.069418	100.073481	100.048600	100.059048
166142	SP500	300	1781301000	7431.640635	7432.695659	7430.107892	7431.417465
166143	DOW	300	1781301000	51199.281483	51207.086727	51195.690451	51202.641473
109911	DOW	300	1780688400	50912.949622	50917.307230	50842.407158	50885.484724
109912	DXY	300	1780688400	100.083859	100.089531	100.067835	100.081044
166144	DXY	300	1781301000	99.811802	99.822831	99.799645	99.808105
143210	SP500	300	1781170800	7266.786156	7268.699557	7265.998290	7266.822281
109188	DOW	300	1780685700	50931.030000	50949.056057	50928.039890	50938.862831
109189	DXY	300	1780685700	100.072000	100.079566	100.050848	100.052407
143211	DOW	300	1781170800	49916.331719	49925.318352	49909.388188	49920.080115
143212	DXY	300	1781170800	100.089464	100.108196	100.085498	100.103800
109167	DOW	300	1780684500	51064.669740	51067.937926	51058.331548	51059.130145
109168	DXY	300	1780684500	100.058601	100.067495	100.058601	100.060168
143027	SP500	300	1781170500	7267.262326	7268.667163	7265.955940	7266.993319
143028	DOW	300	1781170500	49920.549594	49929.616394	49913.744039	49917.395846
109680	DOW	300	1780687800	50865.330000	50872.366595	50846.295536	50872.227630
109681	DXY	300	1780687800	100.091000	100.095663	100.079996	100.084942
143029	DXY	300	1781170500	100.076360	100.097507	100.071242	100.090707
108732	DOW	300	1780683600	51092.760000	51119.943444	51084.144436	51097.765998
108733	DXY	300	1780683600	100.094000	100.101859	100.070985	100.094729
110094	DOW	300	1780688700	50884.120131	50894.593312	50859.254432	50892.346851
110095	DXY	300	1780688700	100.082316	100.092191	100.071307	100.080304
109617	DOW	300	1780686600	50883.112956	50893.560000	50879.190301	50884.559812
109618	DXY	300	1780686600	100.067306	100.075122	100.056106	100.069135
166202	SP500	300	1781302200	7431.460000	7432.617117	7429.440903	7431.836420
110938	DXY	300	1780692600	100.076173	100.085463	100.062075	100.064731
166203	DOW	300	1781302200	51202.260000	51208.964431	51197.791632	51199.666498
166204	DXY	300	1781302200	99.807000	99.819721	99.800794	99.806317
166694	SP500	300	1781304300	7431.460000	7432.743665	7430.024722	7431.195936
111558	DOW	300	1780695900	50867.034478	50875.136790	50860.239591	50865.902392
166695	DOW	300	1781304300	51202.260000	51207.407835	51193.764156	51201.675916
109728	DOW	300	1780688100	50872.648897	50916.300000	50870.828716	50911.734517
109729	DXY	300	1780688100	100.084011	100.089553	100.067545	100.083304
166696	DXY	300	1781304300	99.807000	99.814760	99.794589	99.805320
111559	DXY	300	1780695900	100.064393	100.075762	100.058733	100.067337
166838	SP500	300	1781304600	7430.940392	7433.002128	7429.791677	7431.508347
166839	DOW	300	1781304600	51200.183361	51209.517911	51192.835522	51203.927506
111378	DOW	300	1780695600	50868.501328	50875.704783	50858.267072	50865.464099
111162	DOW	300	1780695000	50866.780000	50875.789011	50863.265869	50872.116487
110175	DOW	300	1780689900	50866.780000	50874.656840	50865.286662	50867.010619
110176	DXY	300	1780689900	100.051000	100.059399	100.046867	100.049754
111163	DXY	300	1780695000	100.071000	100.075975	100.062908	100.071873
166840	DXY	300	1781304600	99.804387	99.814492	99.796803	99.805594
110667	DOW	300	1780692000	50866.780000	50872.929061	50858.388223	50862.651487
110668	DXY	300	1780692000	100.055000	100.058061	100.042820	100.052191
111379	DXY	300	1780695600	100.064161	100.079898	100.061286	100.065793
111120	DOW	300	1780692900	50864.923339	50868.414577	50861.934144	50863.961711
111121	DXY	300	1780692900	100.064029	100.073706	100.061361	100.073706
167186	SP500	300	1781306400	7431.460000	7432.949704	7429.781836	7431.595226
167187	DOW	300	1781306400	51202.260000	51207.848525	51194.989663	51202.749446
167188	DXY	300	1781306400	99.807000	99.814371	99.796598	99.796598
111195	DOW	300	1780695300	50871.478833	50883.190293	50860.220989	50867.657575
111196	DXY	300	1780695300	100.071429	100.085187	100.058562	100.065480
111654	DOW	300	1780698000	50866.780000	50870.332513	50863.296897	50863.296897
111655	DXY	300	1780698000	100.071000	100.071000	100.063912	100.069617
167309	SP500	300	1781306700	7431.531260	7432.618960	7429.769856	7431.322871
111672	DOW	300	1780698300	50862.971775	50874.685488	50858.364543	50866.362408
111673	DXY	300	1780698300	100.071289	100.085701	100.061720	100.066475
167310	DOW	300	1781306700	51201.967793	51213.310521	51190.884484	51205.743250
111855	DOW	300	1780698600	50864.451758	50876.869872	50857.761829	50865.589749
111856	DXY	300	1780698600	100.067243	100.082911	100.054956	100.071398
167311	DXY	300	1781306700	99.797623	99.817328	99.793620	99.800086
112038	DOW	300	1780698900	50865.897256	50876.630934	50861.677069	50864.151685
112039	DXY	300	1780698900	100.070123	100.080212	100.063145	100.067373
167492	SP500	300	1781307000	7431.286497	7432.756039	7430.182831	7430.894968
167493	DOW	300	1781307000	51206.533910	51213.192199	51191.214678	51206.042707
112221	DOW	300	1780699200	50864.272551	50877.640715	50858.592340	50869.127935
112222	DXY	300	1780699200	100.066730	100.081425	100.057340	100.071386
112404	DOW	300	1780699500	50868.643676	50874.302446	50858.738928	50862.925354
113140	DXY	300	1780703100	100.073764	100.087692	100.062263	100.070952
114418	DXY	300	1780708200	100.080446	100.082909	100.052939	100.070894
112779	DOW	300	1780701300	50868.697552	50875.524273	50859.317448	50865.689235
112780	DXY	300	1780701300	99.411219	99.422931	99.399970	99.410072
115797	DOW	300	1780903800	50866.780000	50867.722421	50864.796636	50865.574867
113430	DOW	300	1780704000	50866.780000	50873.405447	50860.982078	50869.401465
113431	DXY	300	1780704000	100.071000	100.075661	100.066020	100.071308
112405	DXY	300	1780699500	100.070020	100.079841	100.050545	100.077964
166490	SP500	300	1781302800	7431.703155	7432.749798	7430.111035	7431.857161
113463	DOW	300	1780704300	50870.934911	50877.126528	50856.920688	50862.331492
113464	DXY	300	1780704300	100.071894	100.080450	100.055091	100.064345
166491	DOW	300	1781302800	51195.219949	51211.939110	51191.229833	51204.741467
114384	DOW	300	1780707900	50866.780000	50873.631658	50864.097179	50870.616858
114385	DXY	300	1780707900	100.071000	100.080235	100.066038	100.078607
166492	DXY	300	1781302800	99.802360	99.816546	99.794248	99.807129
112971	DOW	300	1780702800	50866.780000	50875.800507	50858.595419	50862.598023
112972	DXY	300	1780702800	100.071000	100.081373	100.060945	100.075061
115798	DXY	300	1780903800	100.045000	100.046366	100.032253	100.032345
114777	DOW	300	1780708800	50873.491239	50876.224822	50858.695936	50868.142312
114597	DOW	300	1780708500	50862.019791	50876.465106	50857.441943	50871.628407
173683	DXY	300	1782113700	100.924355	100.938779	100.903150	100.937519
114246	DOW	300	1780706700	50867.770753	50876.173612	50857.566905	50867.082619
113643	DOW	300	1780704600	50861.662653	50876.151371	50859.009180	50868.778216
113644	DXY	300	1780704600	100.063352	100.085386	100.058084	100.071647
173681	SP500	300	1782113700	7500.773245	7501.986857	7499.364492	7501.590378
112479	DOW	300	1780700700	50866.780000	50876.153572	50859.783086	50866.578157
112480	DXY	300	1780700700	100.071000	100.077611	100.060442	100.071524
173682	DOW	300	1782113700	51562.024389	51577.895764	51556.700745	51565.659138
114247	DXY	300	1780706700	100.068539	100.086219	100.062794	100.070176
143393	SP500	300	1781171100	7266.549977	7268.081534	7265.550261	7267.199725
143394	DOW	300	1781171100	49918.604202	49928.685431	49912.362281	49919.745695
113319	DOW	300	1780703400	50868.452541	50870.995942	50861.498089	50866.053721
113320	DXY	300	1780703400	100.070894	100.079922	100.061003	100.074598
143395	DXY	300	1781171100	100.103101	100.114291	100.085000	100.091892
114598	DXY	300	1780708500	100.072451	100.078212	100.057523	100.065309
166307	SP500	300	1781302500	7431.666440	7433.028022	7430.087645	7431.651580
166308	DOW	300	1781302500	51199.222304	51210.758136	51190.706888	51197.091199
113826	DOW	300	1780704900	50867.268709	50873.146271	50857.019571	50867.636939
113827	DXY	300	1780704900	100.071390	100.081171	100.064428	100.069529
166309	DXY	300	1781302500	99.805278	99.817821	99.793667	99.803159
114778	DXY	300	1780708800	100.067170	100.079061	100.060317	100.065054
112596	DOW	300	1780701000	50866.739610	50875.229570	50859.211155	50867.071055
112597	DXY	300	1780701000	100.070109	100.078447	99.398330	99.411600
114066	DOW	300	1780706400	50863.542580	50880.070362	50859.664138	50867.735172
167021	SP500	300	1781304900	7431.769678	7432.449261	7430.085676	7431.715379
167022	DOW	300	1781304900	51204.702986	51213.629720	51192.411241	51196.290560
113139	DOW	300	1780703100	50861.522473	50876.039575	50858.282570	50867.235802
114067	DXY	300	1780706400	100.067334	100.082643	100.060513	100.068697
167023	DXY	300	1781304900	99.807324	99.818493	99.796256	99.801425
167494	DXY	300	1781307000	99.800181	99.813520	99.797641	99.813470
113898	DOW	300	1780706100	50866.780000	50876.077935	50858.174169	50863.646467
113899	DXY	300	1780706100	100.071000	100.080695	100.061940	100.067030
173862	DOW	300	1782114000	51566.020473	51573.828678	51556.096641	51569.627854
115812	DOW	300	1780904100	50866.185953	50876.220579	50860.385300	50864.741372
173861	SP500	300	1782114000	7501.575279	7501.739079	7498.985129	7501.106045
115302	DOW	300	1780711800	50866.780000	50873.232740	50857.092592	50873.232740
115303	DXY	300	1780711800	100.071000	100.081862	100.061160	100.066043
173863	DXY	300	1782114000	100.936010	100.967614	100.930787	100.961065
115152	DOW	300	1780710300	50866.350294	50876.771884	50858.232846	50862.873668
175762	DXY	300	1782717900	101.219557	101.230232	101.186164	101.209591
114840	DOW	300	1780709700	50866.780000	50873.513005	50854.319368	50867.596365
177583	DXY	300	1782720900	101.235361	101.250731	101.209778	101.246082
114417	DOW	300	1780708200	50869.180778	50875.916018	50858.055262	50863.885730
114841	DXY	300	1780709700	100.071000	100.080329	100.054815	100.069256
175760	SP500	300	1782717900	7354.302253	7355.095137	7353.103611	7353.356540
115153	DXY	300	1780710300	100.073878	100.081704	100.062495	100.068259
175761	DOW	300	1782717900	51877.323944	51882.885641	51865.965044	51873.813977
115425	DOW	300	1780712100	50874.148093	50880.357575	50860.689828	50872.943258
115426	DXY	300	1780712100	100.064055	100.085646	100.053523	100.073342
114969	DOW	300	1780710000	50866.965076	50875.509165	50859.848480	50865.154268
114970	DXY	300	1780710000	100.068968	100.082185	100.059634	100.072651
175940	SP500	300	1782718200	7353.607165	7355.205724	7352.308818	7353.926113
115608	DOW	300	1780712400	50872.879733	50876.235091	50859.819274	50865.694194
115813	DXY	300	1780904100	100.030983	100.056582	100.024183	100.048125
175941	DOW	300	1782718200	51875.520078	51884.858289	51860.607818	51876.507602
115609	DXY	300	1780712400	100.071767	100.080476	100.064096	100.071972
175942	DXY	300	1782718200	101.210369	101.219886	101.193658	101.195788
116178	DOW	300	1780904700	50871.635486	50875.096086	50858.646869	50869.560869
115995	DOW	300	1780904400	50866.624543	50878.074672	50860.736805	50870.078215
115996	DXY	300	1780904400	100.046510	100.064514	100.028141	100.042317
177582	DOW	300	1782720900	51866.705019	51888.593625	51865.945774	51874.913598
116179	DXY	300	1780904700	100.042038	100.094938	100.036092	100.087231
178295	SP500	300	1782722100	7354.338774	7355.277219	7352.616464	7353.912689
116361	DOW	300	1780905000	50867.769525	50874.535854	50857.845158	50863.164197
116362	DXY	300	1780905000	100.086530	100.088938	100.046934	100.070484
116544	DOW	300	1780905300	50863.265617	50875.391691	50856.641929	50856.642481
116545	DXY	300	1780905300	100.069900	100.080909	100.047360	100.061284
179052	DOW	300	1782800400	52183.706676	52194.095344	52168.936406	52181.235106
121468	DXY	300	1780913400	100.110095	100.131537	100.101926	100.110715
117093	DOW	300	1780906200	50874.085075	50876.514697	50853.632799	50865.419301
117094	DXY	300	1780906200	100.113944	100.129348	100.088603	100.090384
168233	SP500	300	1781309400	7431.460000	7433.212108	7429.054477	7431.976209
117459	DOW	300	1780906800	50866.434721	50884.665093	50857.961526	50862.623913
117460	DXY	300	1780906800	100.075190	100.110526	100.065262	100.102700
168234	DOW	300	1781309400	51202.260000	51216.094146	51192.396470	51200.731488
120003	DOW	300	1780911000	50870.413127	50874.420383	50857.188049	50865.034753
120004	DXY	300	1780911000	100.164869	100.177211	100.143084	100.160071
167648	SP500	300	1781307300	7431.460000	7433.316745	7429.719897	7431.938415
119088	DOW	300	1780909500	50864.277900	50875.291104	50856.828996	50868.945153
119089	DXY	300	1780909500	100.155528	100.164127	100.127238	100.139634
167649	DOW	300	1781307300	51202.260000	51208.263617	51196.833260	51204.169449
118542	DOW	300	1780908600	50862.086620	50873.999530	50858.255007	50869.174795
118543	DXY	300	1780908600	100.119220	100.154566	100.112397	100.130655
167650	DXY	300	1781307300	99.807000	99.811516	99.798958	99.803595
143576	SP500	300	1781171400	7267.056085	7268.667570	7265.811374	7266.990000
143577	DOW	300	1781171400	49917.776316	49927.931529	49912.413076	49918.780000
120735	DOW	300	1780912200	50874.161748	50875.595058	50860.800423	50867.057888
143578	DXY	300	1781171400	100.089844	100.107851	100.075198	100.083000
116727	DOW	300	1780905600	50857.212293	50876.910598	50857.212293	50864.286110
116728	DXY	300	1780905600	100.059161	100.096278	100.047035	100.088698
118002	DOW	300	1780907700	50861.187423	50873.539172	50857.551046	50862.306270
118003	DXY	300	1780907700	100.118498	100.137106	100.082279	100.085924
117276	DOW	300	1780906500	50864.485953	50873.443450	50851.647289	50865.545583
117277	DXY	300	1780906500	100.089188	100.111559	100.064023	100.072911
168235	DXY	300	1781309400	99.807000	99.816641	99.798994	99.811056
117822	DOW	300	1780907400	50865.317793	50875.984430	50853.484739	50861.349341
117823	DXY	300	1780907400	100.109893	100.135231	100.109893	100.120796
168107	SP500	300	1781309100	7431.460000	7432.888330	7430.041317	7432.888330
119637	DOW	300	1780910400	50868.677356	50878.191355	50857.987700	50870.072371
168108	DOW	300	1781309100	51202.260000	51210.003712	51193.193563	51202.023967
116910	DOW	300	1780905900	50864.391333	50877.428869	50856.558850	50873.718970
116911	DXY	300	1780905900	100.088357	100.119865	100.053581	100.113506
168109	DXY	300	1781309100	99.807000	99.816611	99.798451	99.812739
119638	DXY	300	1780910400	100.161053	100.183088	100.153595	100.170242
118182	DOW	300	1780908000	50861.176249	50875.551681	50856.716159	50863.021467
118183	DXY	300	1780908000	100.084377	100.118223	100.071400	100.111703
168567	DOW	300	1781310000	51202.260000	51208.674913	51191.843875	51198.419215
117642	DOW	300	1780907100	50864.287773	50874.893530	50856.670600	50863.955988
117643	DXY	300	1780907100	100.104720	100.128909	100.090036	100.112055
119820	DOW	300	1780910700	50871.951777	50872.977277	50858.159837	50869.477883
119821	DXY	300	1780910700	100.171128	100.171984	100.148024	100.162545
168568	DXY	300	1781310000	99.807000	99.817237	99.799379	99.805810
169309	DXY	300	1781312700	99.802740	99.818450	99.794999	99.809224
120552	DOW	300	1780911900	50870.012236	50875.604309	50856.762094	50875.604309
120553	DXY	300	1780911900	100.207192	100.216356	100.133533	100.135017
169026	DOW	300	1781312100	51202.260000	51209.550633	51193.524190	51200.572910
118362	DOW	300	1780908300	50861.209105	50875.320420	50854.342514	50861.570475
118363	DXY	300	1780908300	100.111571	100.123634	100.087416	100.118388
119271	DOW	300	1780909800	50867.100051	50874.796376	50857.231305	50867.001042
119272	DXY	300	1780909800	100.140121	100.159684	100.129199	100.130690
168566	SP500	300	1781310000	7431.460000	7432.586908	7430.440234	7430.954385
169124	SP500	300	1781312400	7431.006727	7432.764662	7429.969381	7430.807529
169025	SP500	300	1781312100	7431.460000	7432.871738	7430.771030	7430.833596
118722	DOW	300	1780908900	50867.698745	50875.931841	50862.216461	50865.971726
118723	DXY	300	1780908900	100.131453	100.150623	100.105152	100.148528
169027	DXY	300	1781312100	99.807000	99.818612	99.795463	99.801950
118905	DOW	300	1780909200	50866.057413	50879.517598	50859.807957	50865.570174
118906	DXY	300	1780909200	100.146810	100.156555	100.128668	100.153318
119454	DOW	300	1780910100	50864.994544	50871.279296	50855.043134	50868.729462
119455	DXY	300	1780910100	100.128891	100.165020	100.127587	100.160230
120736	DXY	300	1780912200	100.137405	100.184247	100.136365	100.168907
169125	DOW	300	1781312400	51199.110874	51210.640919	51193.445364	51203.105038
120369	DOW	300	1780911600	50871.621322	50871.621322	50850.818199	50869.461900
169126	DXY	300	1781312400	99.804252	99.814657	99.794674	99.804807
120186	DOW	300	1780911300	50863.333201	50878.628662	50857.407487	50870.834785
120187	DXY	300	1780911300	100.158833	100.198979	100.156998	100.191704
120370	DXY	300	1780911600	100.193347	100.218353	100.182323	100.205181
121101	DOW	300	1780912800	50870.890706	50877.842332	50861.167741	50866.933631
121102	DXY	300	1780912800	100.142083	100.158573	100.130544	100.134912
169307	SP500	300	1781312700	7430.755098	7432.433968	7430.226220	7431.474547
120918	DOW	300	1780912500	50865.683891	50874.094253	50856.600367	50869.488914
120919	DXY	300	1780912500	100.166508	100.167000	100.135868	100.143728
169308	DOW	300	1781312700	51204.019322	51214.811476	51194.931980	51195.991524
121284	DOW	300	1780913100	50865.975134	50878.277977	50858.170985	50870.560855
122017	DXY	300	1780914300	100.087686	100.110936	100.073609	100.090758
121467	DOW	300	1780913400	50872.380623	50876.766664	50854.700273	50867.778882
121285	DXY	300	1780913100	100.134822	100.142157	100.094405	100.111035
169518	DOW	300	1781319300	51202.260000	51212.370684	51197.413100	51202.260000
169519	DXY	300	1781319300	99.807000	99.814936	99.799871	99.807000
121650	DOW	300	1780913700	50866.540066	50876.386939	50855.274039	50864.827576
121651	DXY	300	1780913700	100.111062	100.137384	100.080357	100.095161
169517	SP500	300	1781319300	7431.460000	7432.535949	7430.611183	7431.460000
121833	DOW	300	1780914000	50865.446255	50875.755367	50858.357646	50863.562081
121834	DXY	300	1780914000	100.096626	100.096626	100.073547	100.088183
169598	SP500	300	1781319600	7431.485700	7432.452512	7429.883097	7431.460000
122016	DOW	300	1780914300	50863.089230	50877.327441	50853.020360	50863.600339
125037	DOW	300	1780920300	50866.780000	50872.996158	50857.039662	50866.719599
125038	DXY	300	1780920300	99.929000	99.948628	99.926186	99.938443
125530	DXY	300	1780922400	99.917000	99.935520	99.911357	99.935331
122196	DOW	300	1780914600	50862.445547	50875.916537	50854.610793	50867.245562
122197	DXY	300	1780914600	100.090952	100.105593	100.071101	100.088252
167927	SP500	300	1781307900	7431.085764	7432.806311	7429.794616	7431.651740
124926	DOW	300	1780919100	50861.333838	50878.082562	50852.710062	50869.920532
167928	DOW	300	1781307900	51206.100241	51208.227636	51194.676201	51201.864677
122736	DOW	300	1780915500	50866.641291	50878.080213	50854.144692	50870.812144
122737	DXY	300	1780915500	100.004851	100.057824	100.004544	100.055581
167929	DXY	300	1781307900	99.804382	99.818857	99.795539	99.809970
124194	DOW	300	1780917900	50867.918446	50876.058545	50859.171919	50862.916099
124195	DXY	300	1780917900	99.973217	99.973217	99.940627	99.942957
124927	DXY	300	1780919100	99.890520	99.929262	99.883970	99.911917
168416	SP500	300	1781309700	7432.029233	7432.505834	7429.871202	7431.380223
168417	DOW	300	1781309700	51201.163029	51214.951464	51196.655113	51201.326327
123279	DOW	300	1780916400	50867.376679	50872.630619	50856.025294	50866.575712
168418	DXY	300	1781309700	99.810695	99.815073	99.797020	99.805812
122376	DOW	300	1780914900	50866.793619	50878.194667	50860.411783	50863.236256
122377	DXY	300	1780914900	100.089154	100.103140	100.060173	100.082668
167744	SP500	300	1781307600	7431.975724	7432.944253	7430.502435	7430.956642
123280	DXY	300	1780916400	100.017949	100.026809	100.007839	100.010203
167745	DOW	300	1781307600	51202.634311	51212.736311	51192.657806	51205.598425
167746	DXY	300	1781307600	99.805958	99.817192	99.793124	99.803399
123462	DOW	300	1780916700	50865.820457	50879.018180	50856.699861	50869.910229
123463	DXY	300	1780916700	100.008583	100.047498	100.006060	100.019879
143942	SP500	300	1781172000	7266.770482	7268.188102	7265.479549	7266.990000
123096	DOW	300	1780916100	50869.039510	50873.235553	50858.406775	50869.098515
123097	DXY	300	1780916100	100.035757	100.040829	100.002632	100.016023
143943	DOW	300	1781172000	49917.575417	49927.558874	49910.337649	49918.780000
143944	DXY	300	1781172000	100.075463	100.088100	100.061000	100.061000
124377	DOW	300	1780918200	50864.173378	50882.854795	50859.462962	50862.994879
124378	DXY	300	1780918200	99.941891	99.943093	99.891762	99.921828
143759	SP500	300	1781171700	7267.107940	7268.407967	7265.521296	7266.990000
143760	DOW	300	1781171700	49919.716237	49928.542219	49910.340528	49918.780000
124011	DOW	300	1780917600	50866.234797	50874.311853	50853.853860	50866.008914
124012	DXY	300	1780917600	100.019917	100.025493	99.962495	99.970798
143761	DXY	300	1781171700	100.081431	100.093526	100.067438	100.073000
122556	DOW	300	1780915200	50862.059221	50872.999219	50855.139063	50865.900852
122557	DXY	300	1780915200	100.084862	100.100005	99.995995	100.004134
122916	DOW	300	1780915800	50870.737209	50876.648788	50859.514639	50869.675945
122917	DXY	300	1780915800	100.054638	100.061237	100.026317	100.034330
123645	DOW	300	1780917000	50869.495577	50875.414905	50859.280042	50862.067397
123646	DXY	300	1780917000	100.018016	100.041215	100.014491	100.025042
125277	DOW	300	1780920900	50866.393240	50872.906634	50856.739595	50864.671503
124743	DOW	300	1780918800	50867.578221	50874.285682	50857.170504	50861.146177
124744	DXY	300	1780918800	99.909931	99.914778	99.862369	99.888122
125094	DOW	300	1780920600	50865.666875	50873.541314	50857.552292	50866.907088
125095	DXY	300	1780920600	99.938657	99.942034	99.889405	99.904579
168836	SP500	300	1781310600	7431.492199	7432.655591	7430.035303	7432.145744
168837	DOW	300	1781310600	51195.949671	51212.332456	51190.417193	51206.256212
123828	DOW	300	1780917300	50861.842859	50875.392686	50852.986233	50865.774600
123829	DXY	300	1780917300	100.025997	100.035918	100.002937	100.019573
168653	SP500	300	1781310300	7430.944567	7432.789495	7430.285370	7431.209047
124560	DOW	300	1780918500	50864.542222	50879.123151	50856.577302	50868.494969
124561	DXY	300	1780918500	99.922027	99.938276	99.907000	99.910810
168654	DOW	300	1781310300	51196.547413	51212.810358	51193.784972	51195.808997
168655	DXY	300	1781310300	99.805921	99.823798	99.797044	99.800406
125278	DXY	300	1780920900	99.904233	99.918888	99.882290	99.911478
125460	DOW	300	1780921200	50865.484057	50875.081878	50861.578616	50868.149155
125461	DXY	300	1780921200	99.909770	99.928090	99.901993	99.919496
125844	DOW	300	1780923000	50866.188216	50877.231113	50858.823661	50867.396891
125845	DXY	300	1780923000	99.937082	99.938930	99.873206	99.897607
168838	DXY	300	1781310600	99.800836	99.817511	99.795817	99.799111
125661	DOW	300	1780922700	50868.605594	50875.685180	50856.354948	50868.171653
125662	DXY	300	1780922700	99.936065	99.943180	99.914773	99.937190
169599	DOW	300	1781319600	51203.352535	51212.604750	51194.381461	51202.260000
169600	DXY	300	1781319600	99.808196	99.815730	99.794725	99.807000
125529	DOW	300	1780922400	50866.780000	50877.985161	50858.664727	50867.033796
126192	DOW	300	1780925700	51120.456381	51122.805048	50966.441167	50979.898062
126375	DOW	300	1780926000	50981.782324	51023.953178	50933.086143	51023.156277
126376	DXY	300	1780926000	99.852882	99.855808	99.816671	99.839765
169781	SP500	300	1781319900	7431.443176	7432.583460	7430.325821	7431.460000
126021	DOW	300	1780925400	51035.420000	51265.528978	51035.037363	51119.149976
126022	DXY	300	1780925400	99.877000	99.885964	99.808789	99.847041
169782	DOW	300	1781319900	51202.717909	51208.780591	51192.576881	51202.260000
126193	DXY	300	1780925700	99.847819	99.862587	99.835699	99.852574
169783	DXY	300	1781319900	99.805192	99.815935	99.798843	99.807000
126558	DOW	300	1780926300	51022.565984	51072.120000	51017.632799	51041.915473
126559	DXY	300	1780926300	99.841548	99.871737	99.834031	99.845802
174043	DXY	300	1782114300	100.961338	100.990964	100.948139	100.971602
126729	DOW	300	1780927800	51040.710000	51048.937380	50993.112285	50996.623171
126730	DXY	300	1780927800	99.902000	99.934380	99.890473	99.934380
174041	SP500	300	1782114300	7500.968538	7502.255366	7499.496334	7500.900260
174042	DOW	300	1782114300	51568.009436	51572.213727	51547.913051	51565.825898
126843	DOW	300	1780928100	50995.219272	51035.743795	50973.380000	51026.095637
126844	DXY	300	1780928100	99.934498	99.953860	99.917877	99.953440
127026	DOW	300	1780928400	51027.848843	51050.780000	51014.351103	51030.406659
129187	DXY	300	1780949700	100.014427	100.026833	100.002189	100.012966
127824	DOW	300	1780935600	50982.376521	51006.624234	50944.899998	50954.601178
127825	DXY	300	1780935600	99.938800	99.957806	99.927980	99.935382
128181	DOW	300	1780937100	50932.090000	50939.366936	50928.431067	50939.040717
128182	DXY	300	1780937100	99.938000	99.948973	99.931881	99.944880
127476	DOW	300	1780929900	50989.513563	51048.275289	50984.287421	51013.118784
127477	DXY	300	1780929900	99.960116	99.985890	99.946001	99.982333
169019	SP500	300	1781310900	7432.380685	7432.534820	7431.394025	7431.433934
169020	DOW	300	1781310900	51207.568567	51207.568567	51202.260000	51204.352575
129351	DOW	300	1780950600	50786.010000	50792.190180	50778.890885	50782.650838
129352	DXY	300	1780950600	100.017000	100.023121	99.994473	100.003905
169021	DXY	300	1781310900	99.798836	99.807455	99.798836	99.807455
128988	DOW	300	1780948200	50799.575208	50805.021361	50755.593397	50777.518158
128989	DXY	300	1780948200	100.007327	100.026542	99.999072	100.022353
128643	DOW	300	1780947600	50782.990000	50827.785555	50780.028676	50797.250000
127689	DOW	300	1780935300	50989.700000	51006.757227	50981.511534	50983.072493
127690	DXY	300	1780935300	99.922000	99.947032	99.918442	99.939360
170216	SP500	300	1781323500	7431.519592	7432.239516	7430.165625	7432.060170
170217	DOW	300	1781323500	51205.369926	51214.692553	51196.568175	51203.388026
127656	DOW	300	1780930200	51014.251722	51016.410997	50998.482120	51001.465831
127657	DXY	300	1780930200	99.984400	99.985562	99.969750	99.979331
170033	SP500	300	1781323200	7431.482614	7432.779408	7430.039363	7431.772667
169964	SP500	300	1781320200	7431.585395	7432.341096	7430.587175	7430.587175
127221	DOW	300	1780929300	50998.200000	51036.603233	50995.072277	51024.068020
127222	DXY	300	1780929300	99.978000	99.987760	99.966181	99.971861
169965	DOW	300	1781320200	51201.335733	51212.420237	51198.412458	51201.843647
128644	DXY	300	1780947600	100.011000	100.018269	99.999928	100.012000
169966	DXY	300	1781320200	99.806672	99.807000	99.750000	99.754575
128217	DOW	300	1780937400	50937.377749	50944.569864	50913.979887	50927.305492
127027	DXY	300	1780928400	99.955460	99.963324	99.935538	99.956746
128218	DXY	300	1780937400	99.945362	99.966456	99.940327	99.945925
144125	SP500	300	1781172300	7266.809786	7268.166797	7265.777804	7266.735177
128007	DOW	300	1780935900	50954.578905	50988.102870	50948.420000	50948.420000
128008	DXY	300	1780935900	99.936504	99.949975	99.919896	99.938000
144126	DOW	300	1781172300	49916.930484	49930.716732	49912.300099	49917.358612
144127	DXY	300	1781172300	100.058706	100.090829	100.048564	100.072905
127296	DOW	300	1780929600	51022.414263	51045.890000	50948.693971	50990.223351
127297	DXY	300	1780929600	99.970594	99.983008	99.940760	99.958638
170034	DOW	300	1781323200	51200.894277	51210.598948	51191.754254	51206.394718
170218	DXY	300	1781323500	99.802359	99.821113	99.793760	99.813293
170009	SP500	300	1781322900	7431.460000	7432.528428	7431.183970	7431.511107
128805	DOW	300	1780947900	50797.198290	50830.939913	50784.592953	50799.950000
128806	DXY	300	1780947900	100.013039	100.020280	99.993773	100.008000
170010	DOW	300	1781322900	51202.260000	51206.266526	51198.250653	51201.192176
170011	DXY	300	1781322900	99.807000	99.813107	99.799101	99.799101
129105	DOW	300	1780949400	50786.010000	50790.209254	50775.045552	50783.661013
129106	DXY	300	1780949400	100.018000	100.027631	100.007457	100.013425
130060	DXY	300	1780952100	100.017260	100.023431	100.004867	100.013994
128400	DOW	300	1780937700	50924.280000	50924.458495	50878.309363	50887.068974
128401	DXY	300	1780937700	99.946000	99.970595	99.937657	99.954394
170035	DXY	300	1781323200	99.799170	99.817110	99.795554	99.802964
129879	DOW	300	1780951800	50787.006903	50795.364898	50775.396180	50787.433108
129880	DXY	300	1780951800	100.017578	100.024883	100.001133	100.018298
128583	DOW	300	1780938000	50888.624600	50895.244729	50840.946931	50841.830361
128584	DXY	300	1780938000	99.953985	99.953985	99.929282	99.946321
129450	DOW	300	1780950900	50784.612482	50792.696384	50779.148473	50784.039062
129451	DXY	300	1780950900	100.003782	100.017677	99.987053	100.017677
170714	SP500	300	1781324700	7431.460000	7432.807430	7429.960907	7431.390403
130239	DOW	300	1780952400	50787.452284	50791.038756	50776.955450	50791.038756
130240	DXY	300	1780952400	100.014665	100.029271	100.009534	100.029271
170715	DOW	300	1781324700	51202.260000	51210.842560	51190.397834	51204.710141
170716	DXY	300	1781324700	99.807000	99.814295	99.793137	99.803726
129816	DOW	300	1780951500	50778.860794	50790.259318	50775.621444	50786.010000
129186	DOW	300	1780949700	50783.032932	50793.487263	50778.735458	50778.735458
129633	DOW	300	1780951200	50782.631617	50795.783433	50772.869471	50779.886577
129634	DXY	300	1780951200	100.018230	100.020130	99.998451	100.011359
129817	DXY	300	1780951500	100.013374	100.028275	99.999536	100.018000
170837	SP500	300	1781325000	7431.295615	7432.506171	7430.137798	7431.196164
170838	DOW	300	1781325000	51203.203175	51209.256552	51192.139907	51200.160797
130332	DOW	300	1780956000	50786.010000	50793.614651	50779.383014	50784.904724
130333	DXY	300	1780956000	99.986000	100.000206	99.972782	99.988269
170839	DXY	300	1781325000	99.802219	99.823921	99.798136	99.805271
130059	DOW	300	1780952100	50789.267444	50791.913201	50777.588423	50787.425010
130479	DOW	300	1780956300	50785.899255	50794.959476	50776.346525	50782.010178
130480	DXY	300	1780956300	99.985818	99.994474	99.969956	99.983802
171204	DOW	300	1781329500	51202.260000	51208.371942	51201.243089	51207.807059
171205	DXY	300	1781329500	99.807000	99.814437	99.806030	99.814437
130662	DOW	300	1780956600	50782.885716	50792.099482	50776.718369	50788.598764
130663	DXY	300	1780956600	99.985127	100.010497	99.979660	99.994133
130824	DOW	300	1780957200	50786.010000	50789.294480	50781.842925	50783.598937
130825	DXY	300	1780957200	100.000000	100.004342	99.997771	99.999627
171203	SP500	300	1781329500	7431.460000	7432.639419	7431.460000	7432.639419
130842	DOW	300	1780957500	50784.618578	50795.936113	50779.523267	50783.437439
130843	DXY	300	1780957500	99.998439	100.050780	99.985629	99.998185
171212	SP500	300	1781329800	7432.735072	7432.735072	7430.328437	7431.309651
171213	DOW	300	1781329800	51206.785877	51210.771176	51192.171884	51201.710026
131025	DOW	300	1780957800	50782.781742	50795.700038	50780.243300	50784.964718
131026	DXY	300	1780957800	99.999522	100.014060	99.990842	100.001117
131389	DXY	300	1780961700	99.995879	100.013591	99.990769	99.998527
134659	DXY	300	1780987800	99.880568	99.903778	99.864522	99.895987
171020	SP500	300	1781325300	7431.385966	7432.844846	7430.174220	7431.383182
134475	DOW	300	1780987500	50787.828031	50795.343006	50777.448539	50778.878283
171021	DOW	300	1781325300	51200.631256	51210.176760	51193.341958	51204.133443
134292	DOW	300	1780987200	50791.687437	50794.736977	50780.592108	50789.196040
134293	DXY	300	1780987200	99.860128	99.883003	99.857996	99.875186
144491	SP500	300	1781172900	7266.805735	7267.766494	7265.997853	7266.990000
131790	DOW	300	1780966500	50786.010000	50792.304860	50777.366139	50792.304860
131791	DXY	300	1780966500	100.033000	100.042259	100.024530	100.024530
144492	DOW	300	1781172900	49917.533308	49930.420406	49911.176859	49918.780000
144493	DXY	300	1781172900	100.104113	100.119768	100.093786	100.105000
132189	DOW	300	1780967400	50782.194040	50790.745772	50780.004380	50788.884732
132190	DXY	300	1780967400	100.023901	100.031238	100.003966	100.015164
144308	SP500	300	1781172600	7266.900357	7268.589769	7265.971194	7266.796401
133749	DOW	300	1780986300	50784.142191	50792.653556	50777.322243	50786.034005
133750	DXY	300	1780986300	99.860935	99.865524	99.823731	99.828689
144309	DOW	300	1781172600	49917.909360	49928.863134	49910.579532	49917.411569
133209	DOW	300	1780985400	50782.324232	50792.032237	50776.790077	50786.135956
133210	DXY	300	1780985400	99.896140	99.915053	99.873885	99.880143
144310	DXY	300	1781172600	100.075384	100.119486	100.069042	100.105148
131571	DOW	300	1780962000	50787.681454	50792.651854	50778.228640	50786.566509
131572	DXY	300	1780962000	99.998546	100.012484	99.990627	99.999944
133029	DOW	300	1780985100	50786.203932	50795.224879	50776.117067	50781.384827
132282	DOW	300	1780983600	50786.010000	50786.891168	50782.573601	50786.258815
132283	DXY	300	1780983600	99.897000	99.899979	99.890035	99.890035
131208	DOW	300	1780958100	50784.557565	50792.831979	50777.856313	50787.717458
131209	DXY	300	1780958100	100.001448	100.007641	99.990029	99.998292
171022	DXY	300	1781325300	99.806703	99.815223	99.795102	99.807290
133030	DXY	300	1780985100	99.880247	99.914008	99.876644	99.898280
170396	SP500	300	1781323800	7432.340561	7433.034378	7430.343907	7430.708178
170397	DOW	300	1781323800	51202.054374	51208.284649	51193.068858	51205.365629
131298	DOW	300	1780961400	50786.010000	50792.185652	50781.098430	50786.815412
131299	DXY	300	1780961400	100.000000	100.007198	99.991771	99.997867
170398	DXY	300	1781323800	99.812286	99.820645	99.797147	99.804572
131754	DOW	300	1780962300	50787.326743	50792.300050	50785.668372	50789.737489
131755	DXY	300	1780962300	99.997836	100.006908	99.997836	100.001565
132663	DOW	300	1780984500	50781.789410	50795.875628	50774.884814	50790.637839
132664	DXY	300	1780984500	99.897925	99.907827	99.873777	99.886912
170576	SP500	300	1781324100	7430.494300	7432.605099	7429.418583	7431.187561
170577	DOW	300	1781324100	51205.862775	51208.889613	51195.936038	51202.652721
132480	DOW	300	1780984200	50783.193114	50795.204861	50775.016783	50783.812437
132481	DXY	300	1780984200	99.894038	99.902287	99.882086	99.898176
170578	DXY	300	1781324100	99.806463	99.816236	99.798940	99.804614
171395	SP500	300	1781330100	7431.160516	7433.009807	7430.541924	7432.197272
131388	DOW	300	1780961700	50784.961529	50797.523938	50775.863650	50786.104656
171214	DXY	300	1781329800	99.815892	99.817923	99.795071	99.811888
132006	DOW	300	1780967100	50787.328519	50794.968812	50774.269535	50783.895918
132007	DXY	300	1780967100	100.054110	100.060654	100.018376	100.025967
134476	DXY	300	1780987500	99.873744	99.897569	99.860930	99.881695
131823	DOW	300	1780966800	50791.403674	50793.891079	50779.166866	50786.072358
131824	DXY	300	1780966800	100.026504	100.056089	100.023455	100.055643
171396	DOW	300	1781330100	51200.205483	51209.294097	51190.680814	51209.294097
132297	DOW	300	1780983900	50784.421110	50795.022364	50780.157733	50785.001638
171397	DXY	300	1781330100	99.813692	99.822913	99.795508	99.814111
132298	DXY	300	1780983900	99.889837	99.906331	99.880662	99.891876
132846	DOW	300	1780984800	50791.065036	50796.248731	50777.148399	50786.644988
132847	DXY	300	1780984800	99.886996	99.897386	99.868707	99.879363
133569	DOW	300	1780986000	50785.172545	50796.709424	50775.793426	50785.318865
133570	DXY	300	1780986000	99.893677	99.900173	99.852904	99.858919
174223	DXY	300	1782114600	100.971515	100.992660	100.964720	100.980931
133389	DOW	300	1780985700	50785.960620	50795.144349	50777.149346	50783.535514
133390	DXY	300	1780985700	99.878049	99.894068	99.873476	99.893587
134109	DOW	300	1780986900	50792.768677	50796.000484	50779.905425	50789.911087
134110	DXY	300	1780986900	99.836625	99.875838	99.829079	99.858736
135207	DOW	300	1780988700	50785.680761	50793.643418	50778.894340	50785.281010
174221	SP500	300	1782114600	7500.721798	7501.728107	7498.856463	7500.233926
174222	DOW	300	1782114600	51566.281943	51573.670628	51554.188511	51562.706581
134841	DOW	300	1780988100	50790.727583	50796.789486	50777.345092	50794.092287
133929	DOW	300	1780986600	50787.233634	50793.645742	50776.269769	50793.645742
133930	DXY	300	1780986600	99.830196	99.848007	99.824056	99.835533
134842	DXY	300	1780988100	99.896638	99.908661	99.883407	99.905959
176123	SP500	300	1782718500	7353.859941	7355.351867	7352.679165	7353.631483
134658	DOW	300	1780987800	50780.726919	50793.571350	50772.428908	50789.198848
176124	DOW	300	1782718500	51875.850605	51883.030614	51868.181113	51873.294164
176125	DXY	300	1782718500	101.197106	101.222460	101.193713	101.213668
135208	DXY	300	1780988700	99.896365	99.918809	99.883503	99.918809
135024	DOW	300	1780988400	50792.707240	50795.637395	50776.971022	50784.626748
135025	DXY	300	1780988400	99.905898	99.911808	99.880361	99.895319
177761	SP500	300	1782721200	7353.176594	7355.657760	7352.827972	7354.486534
135390	DOW	300	1780989000	50785.591732	50793.280957	50776.181674	50784.096674
135391	DXY	300	1780989000	99.920701	99.924025	99.886864	99.910263
177762	DOW	300	1782721200	51876.214665	51888.999887	51863.613004	51871.499318
177763	DXY	300	1782721200	101.245085	101.257999	101.231919	101.247102
135573	DOW	300	1780989300	50785.946206	50793.533137	50778.760096	50785.237781
135574	DXY	300	1780989300	99.912335	99.946898	99.904778	99.926442
135756	DOW	300	1780989600	50785.630974	50791.880035	50779.260410	50782.638844
135757	DXY	300	1780989600	99.925498	99.949617	99.913980	99.949617
176489	SP500	300	1782719100	7354.006503	7355.006523	7352.446026	7354.010831
176490	DOW	300	1782719100	51878.899333	51883.584467	51869.100109	51878.547503
176491	DXY	300	1782719100	101.205097	101.217272	101.175118	101.199878
144671	SP500	300	1781173200	7267.227372	7268.059659	7265.586467	7266.990000
144672	DOW	300	1781173200	49920.220834	49925.546085	49906.768135	49918.780000
144673	DXY	300	1781173200	100.107377	100.144372	100.101401	100.137000
137357	SP500	300	1781160900	7267.143270	7267.372380	7266.144723	7266.144723
137358	DOW	300	1781160900	49918.780000	49924.799610	49912.873067	49912.873067
136857	DOW	300	1781055900	50873.984214	50881.551754	50863.662551	50875.209718
136858	DXY	300	1781055900	99.978718	99.996862	99.958879	99.975559
137359	DXY	300	1781160900	99.996000	100.004819	99.982216	100.001070
135939	DOW	300	1780989900	50783.948741	50797.002091	50779.409769	50787.770881
135940	DXY	300	1780989900	99.950241	99.963603	99.936797	99.962717
137040	DOW	300	1781056200	50874.426133	50880.349915	50865.114894	50871.441536
137041	DXY	300	1781056200	99.977899	100.001323	99.972850	99.985497
171578	SP500	300	1781330400	7432.415332	7432.415332	7431.001714	7431.228144
136674	DOW	300	1781055600	50873.752624	50884.680127	50865.365883	50875.142100
136675	DXY	300	1781055600	99.983251	100.001608	99.971393	99.977953
171579	DOW	300	1781330400	51208.078238	51208.078238	51202.260000	51205.586506
171580	DXY	300	1781330400	99.815630	99.815630	99.804721	99.804721
174401	SP500	300	1782114900	7500.035879	7502.125524	7499.392192	7500.127687
174402	DOW	300	1782114900	51562.783270	51572.723926	51555.065578	51563.199482
174403	DXY	300	1782114900	100.982729	100.994997	100.972602	100.983543
136170	DOW	300	1781054700	50872.110000	50883.451428	50862.034474	50874.438471
136171	DXY	300	1781054700	99.981000	99.982409	99.947727	99.957344
180488	SP500	300	1782803700	7440.430000	7441.554578	7440.354686	7440.365077
136491	DOW	300	1781055300	50872.936948	50879.346987	50863.096471	50872.693547
136492	DXY	300	1781055300	99.971643	99.995631	99.969746	99.982123
180320	SP500	300	1782802500	7440.887782	7441.147724	7439.171651	7440.812714
180321	DOW	300	1782802500	52177.713025	52191.236646	52172.295846	52180.853522
136122	DOW	300	1780990200	50787.536800	50793.269083	50780.317318	50788.572721
136123	DXY	300	1780990200	99.962506	99.965161	99.930477	99.932182
179594	SP500	300	1782801300	7440.610639	7442.137561	7438.736900	7440.797337
179051	SP500	300	1782800400	7440.271381	7441.355578	7439.186856	7440.797835
179053	DXY	300	1782800400	101.401354	101.418258	101.385216	101.398173
137223	DOW	300	1781056500	50870.369151	50879.733795	50863.782348	50872.903632
137224	DXY	300	1781056500	99.985716	100.001177	99.981219	99.992575
177944	SP500	300	1782721500	7354.574971	7356.004434	7352.785007	7354.061753
177945	DOW	300	1782721500	51870.879560	51882.750989	51867.841030	51880.182204
177946	DXY	300	1782721500	101.244840	101.272411	101.244840	101.272411
179595	DOW	300	1782801300	52182.974034	52191.038066	52173.724197	52183.327225
179596	DXY	300	1782801300	101.346117	101.352122	101.306073	101.326320
171605	SP500	300	1781575500	7554.290000	7555.187204	7552.950099	7554.146133
171606	DOW	300	1781575500	51671.030000	51677.626834	51659.656443	51672.365623
171607	DXY	300	1781575500	99.679000	99.690717	99.672348	99.677694
136311	DOW	300	1781055000	50873.562924	50880.056687	50864.168347	50871.111126
136312	DXY	300	1781055000	99.958258	99.981708	99.955200	99.971343
180322	DXY	300	1782802500	101.309596	101.337739	101.296630	101.316146
180137	SP500	300	1782802200	7440.192156	7441.742958	7438.990096	7440.778012
180138	DOW	300	1782802200	52181.402961	52189.446107	52170.526387	52179.235764
179417	SP500	300	1782801000	7439.960620	7442.059255	7438.569954	7440.392253
179418	DOW	300	1782801000	52182.327936	52191.679539	52171.889712	52184.175836
179419	DXY	300	1782801000	101.382917	101.388685	101.332166	101.343771
179234	SP500	300	1782800700	7440.512462	7441.966834	7439.073634	7440.173448
179235	DOW	300	1782800700	52183.063858	52192.317795	52173.582003	52182.500654
179236	DXY	300	1782800700	101.398481	101.403394	101.371918	101.381014
176306	SP500	300	1782718800	7353.473210	7355.218310	7352.292260	7354.175570
176307	DOW	300	1782718800	51871.998136	51885.045616	51869.920287	51877.121506
176308	DXY	300	1782718800	101.211770	101.213824	101.191154	101.204647
180139	DXY	300	1782802200	101.320460	101.320460	101.293320	101.311891
178475	SP500	300	1782722400	7353.931723	7355.503495	7352.711054	7354.451929
178476	DOW	300	1782722400	51876.706653	51887.958832	51863.792373	51875.256698
178477	DXY	300	1782722400	101.265212	101.269495	101.236892	101.249788
179960	SP500	300	1782801900	7440.571922	7442.232408	7439.005193	7440.111086
179961	DOW	300	1782801900	52183.096271	52192.960508	52170.743753	52182.224323
179962	DXY	300	1782801900	101.315498	101.328227	101.301055	101.322231
179777	SP500	300	1782801600	7441.037437	7441.929318	7438.352389	7440.696109
179778	DOW	300	1782801600	52182.814401	52194.614778	52174.597764	52182.033477
179779	DXY	300	1782801600	101.324944	101.342204	101.311542	101.316323
180489	DOW	300	1782803700	52182.740000	52187.595828	52178.942340	52180.335675
180490	DXY	300	1782803700	101.263000	101.272214	101.262678	101.264976
181051	DXY	300	1782804900	101.245905	101.254410	101.223805	101.239957
180695	SP500	300	1782804300	7439.824272	7442.083991	7439.427895	7440.372144
180696	DOW	300	1782804300	52180.113192	52188.970181	52171.733498	52180.063428
180697	DXY	300	1782804300	101.263856	101.279500	101.254857	101.257747
180512	SP500	300	1782804000	7440.362143	7441.847242	7438.996807	7439.564687
180513	DOW	300	1782804000	52178.769008	52190.915811	52175.362860	52182.055138
180514	DXY	300	1782804000	101.267293	101.273884	101.251870	101.263744
180873	DOW	300	1782804600	52180.745581	52189.474999	52174.718435	52187.770003
180874	DXY	300	1782804600	101.258576	101.273602	101.238129	101.248157
180872	SP500	300	1782804600	7440.482751	7441.943426	7438.849755	7441.370796
181230	DOW	300	1782805200	52183.187368	52189.941461	52173.407974	52182.958812
181049	SP500	300	1782804900	7441.434798	7441.908135	7439.111156	7440.493756
181050	DOW	300	1782804900	52189.532570	52191.430195	52172.570788	52183.412959
181231	DXY	300	1782805200	101.241332	101.264100	101.233704	101.242863
181229	SP500	300	1782805200	7440.357485	7441.827655	7439.131128	7440.450867
181406	SP500	300	1782805500	7440.375682	7441.949759	7438.753550	7440.317961
181408	DXY	300	1782805500	101.243608	101.259396	101.232635	101.256222
182123	SP500	300	1782806700	7440.771793	7442.219654	7439.357170	7440.480295
182124	DOW	300	1782806700	52179.923393	52193.551935	52174.504608	52182.188034
182125	DXY	300	1782806700	101.311719	101.331943	101.303615	101.317817
184658	SP500	300	1782810900	7440.615876	7441.437901	7439.498325	7440.599621
184659	DOW	300	1782810900	52185.587565	52192.947163	52175.615693	52180.331010
184660	DXY	300	1782810900	101.369824	101.374343	101.325548	101.337192
182657	SP500	300	1782807600	7440.351728	7441.946348	7438.915172	7440.430000
182658	DOW	300	1782807600	52181.845760	52191.778743	52173.621932	52182.740000
182659	DXY	300	1782807600	101.382070	101.386697	101.349000	101.376000
181766	SP500	300	1782806100	7441.165850	7441.536971	7439.429790	7440.883521
181767	DOW	300	1782806100	52181.987056	52194.594599	52171.935155	52178.282619
181768	DXY	300	1782806100	101.258045	101.297114	101.249010	101.295404
182480	SP500	300	1782807300	7440.403485	7441.865187	7439.265211	7440.430000
182481	DOW	300	1782807300	52184.077407	52191.288438	52170.596227	52182.740000
182482	DXY	300	1782807300	101.341305	101.389000	101.308302	101.382000
185201	SP500	300	1782811800	7439.935364	7442.140954	7439.420974	7440.906977
182840	SP500	300	1782807900	7440.326581	7441.663908	7438.494687	7440.430000
182841	DOW	300	1782807900	52182.278118	52191.500696	52172.838541	52182.740000
182842	DXY	300	1782807900	101.375312	101.395088	101.358863	101.371000
185202	DOW	300	1782811800	52184.680005	52191.238847	52172.319159	52186.319099
185203	DXY	300	1782811800	101.370068	101.373707	101.347979	101.365249
183569	SP500	300	1782809100	7440.245862	7442.140995	7439.234134	7440.430000
181949	SP500	300	1782806400	7441.160142	7441.597507	7439.190509	7440.713007
181950	DOW	300	1782806400	52176.768575	52190.750864	52174.597035	52180.048417
181951	DXY	300	1782806400	101.294561	101.328027	101.277561	101.311297
183570	DOW	300	1782809100	52184.733278	52193.183142	52173.112790	52182.740000
183571	DXY	300	1782809100	101.372251	101.423000	101.372251	101.412000
182306	SP500	300	1782807000	7440.558413	7441.393476	7438.657949	7440.469604
182307	DOW	300	1782807000	52181.648924	52192.633553	52173.634680	52182.916488
182308	DXY	300	1782807000	101.319561	101.366887	101.316824	101.342074
181407	DOW	300	1782805500	52181.964510	52188.198311	52172.170253	52188.146020
183023	SP500	300	1782808200	7440.218397	7441.745557	7438.850315	7440.430000
183024	DOW	300	1782808200	52183.049595	52190.451580	52172.912475	52182.740000
183025	DXY	300	1782808200	101.370462	101.380561	101.350607	101.363000
183386	SP500	300	1782808800	7440.406661	7442.264310	7439.476485	7440.430000
183387	DOW	300	1782808800	52183.009479	52192.177990	52175.282182	52182.740000
181589	SP500	300	1782805800	7440.541480	7441.921083	7438.932054	7441.086608
181590	DOW	300	1782805800	52189.997965	52196.160481	52173.661857	52182.955812
181591	DXY	300	1782805800	101.253877	101.275793	101.244850	101.256937
183388	DXY	300	1782808800	101.356974	101.392015	101.348109	101.374000
184838	SP500	300	1782811200	7440.347706	7441.847813	7439.254059	7440.108209
184839	DOW	300	1782811200	52181.528838	52195.559552	52171.867995	52185.367385
183752	SP500	300	1782809400	7440.429281	7441.607799	7439.060637	7440.430000
183753	DOW	300	1782809400	52180.786943	52194.603142	52170.182419	52182.740000
183754	DXY	300	1782809400	101.409688	101.427673	101.392533	101.406000
184840	DXY	300	1782811200	101.335406	101.362084	101.334471	101.355856
184112	SP500	300	1782810000	7441.119763	7442.072268	7438.962662	7441.099057
184113	DOW	300	1782810000	52188.403528	52190.137506	52171.884312	52187.556151
184114	DXY	300	1782810000	101.405942	101.420978	101.384563	101.391631
183203	SP500	300	1782808500	7440.218432	7441.497088	7439.324394	7440.430000
183204	DOW	300	1782808500	52182.522962	52189.949617	52172.860882	52182.740000
183205	DXY	300	1782808500	101.361425	101.380241	101.347918	101.357000
185021	SP500	300	1782811500	7440.142451	7441.524506	7439.043595	7440.186148
183935	SP500	300	1782809700	7440.707817	7441.708307	7438.960508	7441.214225
183936	DOW	300	1782809700	52183.895986	52195.618408	52175.735325	52186.886484
183937	DXY	300	1782809700	101.408165	101.431424	101.393675	101.408331
184475	SP500	300	1782810600	7439.323277	7442.110704	7439.019230	7440.867759
184476	DOW	300	1782810600	52180.754630	52190.340920	52174.907718	52184.637249
184477	DXY	300	1782810600	101.364979	101.387852	101.353118	101.367529
185022	DOW	300	1782811500	52184.428865	52193.248329	52174.611976	52183.831812
184292	SP500	300	1782810300	7440.853472	7441.575395	7439.127991	7439.127991
184293	DOW	300	1782810300	52188.063025	52189.853479	52174.567566	52179.990061
185023	DXY	300	1782811500	101.353939	101.368436	101.350848	101.368300
184294	DXY	300	1782810300	101.391845	101.391845	101.357248	101.364163
185384	SP500	300	1782812100	7440.900754	7442.611368	7438.493458	7439.655760
185385	DOW	300	1782812100	52185.409344	52196.524648	52175.988010	52188.008920
185386	DXY	300	1782812100	101.363669	101.376323	101.346926	101.362237
185567	SP500	300	1782812400	7439.628304	7442.132163	7439.243606	7440.527002
185568	DOW	300	1782812400	52186.718347	52190.690018	52173.850672	52183.163305
185569	DXY	300	1782812400	101.362387	101.396394	101.359121	101.392563
185750	SP500	300	1782812700	7440.513421	7441.894914	7439.195525	7439.449900
185751	DOW	300	1782812700	52183.275476	52190.659229	52176.310784	52182.910681
185752	DXY	300	1782812700	101.395043	101.399351	101.362465	101.383202
185984	SP500	300	1782869100	7499.360000	7500.880154	7497.986652	7500.209972
185985	DOW	300	1782869100	52319.200000	52326.618781	52312.607804	52320.770591
185986	DXY	300	1782869100	101.309000	101.321094	101.286377	101.289160
185933	SP500	300	1782813000	7439.537390	7441.492031	7439.241334	7440.430000
185934	DOW	300	1782813000	52183.623779	52186.855352	52176.479978	52182.740000
185935	DXY	300	1782813000	101.382476	101.395090	101.362172	101.368000
186087	DOW	300	1782869400	52321.319531	52330.548084	52308.096790	52317.189729
186088	DXY	300	1782869400	101.287645	101.304123	101.281392	101.300893
186265	DXY	300	1782869700	101.302368	101.306767	101.285094	101.299917
186086	SP500	300	1782869400	7499.963931	7500.438444	7497.682542	7499.510608
186263	SP500	300	1782869700	7499.409770	7501.026334	7497.968723	7497.968723
186264	DOW	300	1782869700	52318.177816	52326.526119	52309.758784	52318.127180
186443	SP500	300	1782870000	7497.872256	7500.805289	7497.872256	7498.378337
186444	DOW	300	1782870000	52317.423525	52324.755443	52311.785135	52323.160946
186445	DXY	300	1782870000	101.301788	101.313137	101.284395	101.300736
186626	SP500	300	1782870300	7498.333032	7501.370103	7497.740621	7499.640396
189694	DXY	300	1782875400	101.322819	101.329877	101.305727	101.309115
189509	SP500	300	1782875100	7499.129420	7500.509230	7497.940372	7499.627523
189510	DOW	300	1782875100	52319.455865	52328.753554	52309.950421	52317.758065
189511	DXY	300	1782875100	101.308753	101.334576	101.301598	101.320457
190594	DXY	300	1782876900	101.321418	101.339448	101.311804	101.323069
188072	SP500	300	1782872700	7498.931782	7500.004767	7497.333549	7499.648888
188073	DOW	300	1782872700	52320.253764	52327.402043	52310.929854	52318.008299
188074	DXY	300	1782872700	101.311681	101.314459	101.287877	101.299828
190412	SP500	300	1782876600	7498.978304	7500.572696	7497.456022	7499.502942
190055	SP500	300	1782876000	7499.334315	7500.405637	7497.853955	7499.022998
187889	SP500	300	1782872400	7498.845873	7500.490208	7498.168161	7499.043808
187890	DOW	300	1782872400	52321.543925	52326.273761	52306.762724	52321.391754
187891	DXY	300	1782872400	101.328633	101.338251	101.304617	101.312698
187706	SP500	300	1782872100	7498.178163	7500.118107	7498.147406	7499.101088
187707	DOW	300	1782872100	52327.662570	52332.775964	52306.661876	52321.131313
187708	DXY	300	1782872100	101.322197	101.337370	101.314763	101.327064
187163	SP500	300	1782871200	7499.519905	7500.369793	7498.093584	7499.784144
187164	DOW	300	1782871200	52319.111284	52329.436681	52302.144945	52324.563651
187165	DXY	300	1782871200	101.313861	101.331312	101.305973	101.327078
186627	DOW	300	1782870300	52321.895784	52330.573382	52306.729406	52322.596250
186628	DXY	300	1782870300	101.302228	101.325813	101.289863	101.299520
190056	DOW	300	1782876000	52319.921364	52328.564170	52309.226965	52321.369806
190057	DXY	300	1782876000	101.301483	101.313849	101.289927	101.298615
187529	SP500	300	1782871800	7499.228816	7500.792547	7497.948004	7498.170262
187530	DOW	300	1782871800	52320.041031	52328.299695	52313.918250	52327.252280
187531	DXY	300	1782871800	101.313610	101.324592	101.300296	101.320045
186809	SP500	300	1782870600	7499.902729	7500.654247	7497.738251	7500.138558
186810	DOW	300	1782870600	52320.701054	52328.186704	52311.222139	52320.390727
186811	DXY	300	1782870600	101.301269	101.315791	101.287342	101.304063
189143	SP500	300	1782874500	7499.584738	7500.395408	7497.898960	7499.131476
189144	DOW	300	1782874500	52320.956682	52329.741038	52311.514171	52320.349169
189145	DXY	300	1782874500	101.312860	101.322139	101.294759	101.312497
188780	SP500	300	1782873900	7499.599311	7500.607245	7498.351618	7499.481923
188781	DOW	300	1782873900	52319.990079	52325.641321	52309.829508	52319.486686
188240	SP500	300	1782873000	7499.384658	7500.211639	7498.409797	7499.427690
188241	DOW	300	1782873000	52317.782807	52327.474713	52311.178162	52317.735487
188242	DXY	300	1782873000	101.298327	101.305839	101.287042	101.300228
188782	DXY	300	1782873900	101.329254	101.333511	101.306687	101.316355
188600	SP500	300	1782873600	7499.541750	7500.419929	7498.197749	7499.568693
188601	DOW	300	1782873600	52321.155685	52327.666734	52309.238048	52318.317556
188602	DXY	300	1782873600	101.320597	101.331620	101.301966	101.328705
186986	SP500	300	1782870900	7500.425116	7500.857057	7498.362391	7499.270044
186987	DOW	300	1782870900	52319.909988	52326.735071	52310.825430	52318.279246
186988	DXY	300	1782870900	101.306162	101.320828	101.282066	101.311812
187346	SP500	300	1782871500	7499.681599	7500.279184	7498.057244	7499.272382
187347	DOW	300	1782871500	52323.502339	52331.556710	52310.477669	52320.224853
187348	DXY	300	1782871500	101.328103	101.336142	101.307594	101.315359
189326	SP500	300	1782874800	7499.063810	7500.315215	7497.599749	7499.130835
189327	DOW	300	1782874800	52321.542971	52328.944650	52308.856279	52320.867970
189328	DXY	300	1782874800	101.312384	101.322115	101.298378	101.308480
190413	DOW	300	1782876600	52320.667587	52328.272744	52309.603076	52326.124017
188420	SP500	300	1782873300	7499.230612	7500.775858	7497.835040	7499.457311
188421	DOW	300	1782873300	52319.492765	52328.098411	52306.318102	52320.605195
188422	DXY	300	1782873300	101.299221	101.324706	101.292689	101.318219
190414	DXY	300	1782876600	101.313272	101.336095	101.304238	101.322047
188960	SP500	300	1782874200	7499.374748	7501.329610	7498.311804	7499.341419
188961	DOW	300	1782874200	52319.977482	52326.758433	52304.007540	52319.985626
188962	DXY	300	1782874200	101.313867	101.333165	101.303042	101.315257
189872	SP500	300	1782875700	7499.356967	7500.459264	7497.957173	7499.398332
189873	DOW	300	1782875700	52315.471699	52326.623958	52308.503316	52320.370947
189874	DXY	300	1782875700	101.309360	101.317656	101.291143	101.301456
190773	DOW	300	1782877200	52314.928439	52330.705308	52312.678691	52316.529539
190774	DXY	300	1782877200	101.320611	101.354622	101.312887	101.353742
190238	SP500	300	1782876300	7498.888098	7500.732575	7498.194162	7499.008679
190239	DOW	300	1782876300	52320.955624	52327.382780	52312.325668	52321.852899
189692	SP500	300	1782875400	7499.676800	7500.519439	7498.196218	7499.409586
189693	DOW	300	1782875400	52318.683235	52327.522860	52309.538002	52317.408174
190240	DXY	300	1782876300	101.299452	101.326248	101.292166	101.315108
190952	SP500	300	1782877500	7499.024029	7500.686443	7497.924773	7499.372751
190953	DOW	300	1782877500	52317.908784	52330.365217	52312.558928	52321.659773
190954	DXY	300	1782877500	101.351226	101.358946	101.324048	101.332707
190592	SP500	300	1782876900	7499.233334	7500.987617	7497.924555	7500.987617
190593	DOW	300	1782876900	52325.774310	52328.539625	52308.811291	52315.421679
191314	DXY	300	1782878100	101.343520	101.364123	101.330597	101.351606
191497	DXY	300	1782878400	101.350108	101.357042	101.330735	101.333453
190772	SP500	300	1782877200	7500.801330	7501.365985	7498.524135	7499.052159
191313	DOW	300	1782878100	52320.391963	52325.645854	52309.732542	52324.737208
191312	SP500	300	1782878100	7499.818768	7500.694887	7498.176074	7500.255849
191132	SP500	300	1782877800	7499.577035	7500.476749	7498.314941	7500.088315
191133	DOW	300	1782877800	52321.441040	52329.352755	52308.018096	52318.356186
191134	DXY	300	1782877800	101.333379	101.354474	101.321665	101.342725
191677	DXY	300	1782878700	101.331683	101.358807	101.325583	101.326792
191495	SP500	300	1782878400	7500.466490	7501.102373	7498.151436	7499.821737
191496	DOW	300	1782878400	52323.775439	52330.703024	52307.397157	52325.305472
191857	DXY	300	1782879000	101.325798	101.347007	101.320048	101.327346
191675	SP500	300	1782878700	7499.770252	7500.932462	7497.602218	7497.881929
191676	DOW	300	1782878700	52325.997007	52329.558871	52310.795683	52314.494635
191855	SP500	300	1782879000	7497.792959	7500.473376	7497.603394	7500.437294
191856	DOW	300	1782879000	52316.156990	52329.050947	52307.908874	52315.131220
194027	SP500	300	1782882600	7499.360000	7500.585245	7497.414795	7499.444206
194028	DOW	300	1782882600	52319.200000	52325.610581	52309.395080	52320.877340
194029	DXY	300	1782882600	101.290000	101.300000	101.275984	101.292560
192035	SP500	300	1782879300	7500.422312	7500.626836	7498.461802	7499.186949
192036	DOW	300	1782879300	52316.160289	52327.426176	52310.372288	52320.918726
192037	DXY	300	1782879300	101.329223	101.351565	101.329223	101.341944
194210	SP500	300	1782882900	7499.360000	7500.645547	7498.103816	7500.110563
194211	DOW	300	1782882900	52319.200000	52328.853280	52310.103620	52319.865019
194212	DXY	300	1782882900	101.293000	101.303140	101.272491	101.285103
192572	SP500	300	1782880200	7498.846127	7500.292046	7497.354801	7499.339442
192573	DOW	300	1782880200	52319.319361	52329.118452	52310.065747	52322.990882
192574	DXY	300	1782880200	101.334177	101.355166	101.321207	101.339558
194754	DOW	300	1782883800	52312.452343	52327.584151	52311.010906	52318.452493
193847	SP500	300	1782882300	7499.360000	7501.336329	7497.715016	7499.945017
193848	DOW	300	1782882300	52319.200000	52330.888387	52311.146484	52316.365723
193298	SP500	300	1782881400	7499.360000	7500.563423	7498.265076	7500.017183
193121	SP500	300	1782881100	7498.567769	7500.526497	7498.479584	7499.598046
192209	SP500	300	1782879600	7498.945538	7500.163669	7497.385605	7498.472566
192210	DOW	300	1782879600	52322.418284	52334.417709	52306.583266	52318.175354
192211	DXY	300	1782879600	101.339706	101.347684	101.320051	101.328376
193122	DOW	300	1782881100	52318.400246	52330.505301	52306.123041	52317.477824
193123	DXY	300	1782881100	101.294686	101.302717	101.277335	101.296632
193299	DOW	300	1782881400	52319.200000	52327.141628	52311.047984	52324.113813
193300	DXY	300	1782881400	101.292000	101.306710	101.278662	101.301446
193849	DXY	300	1782882300	101.278000	101.293626	101.271203	101.279763
194755	DXY	300	1782883800	101.278389	101.289716	101.268978	101.281803
192938	SP500	300	1782880800	7498.432523	7500.268246	7497.988312	7498.796646
192939	DOW	300	1782880800	52314.882752	52327.822234	52309.372963	52318.731476
192940	DXY	300	1782880800	101.334590	101.334590	101.278218	101.296020
193481	SP500	300	1782881700	7499.360000	7500.121743	7498.153367	7499.089368
193482	DOW	300	1782881700	52319.200000	52332.684699	52309.380060	52332.684699
193483	DXY	300	1782881700	101.293000	101.301415	101.266433	101.283558
192389	SP500	300	1782879900	7498.212864	7500.912387	7498.210222	7498.985679
192390	DOW	300	1782879900	52319.916528	52329.497511	52310.666035	52317.411791
192391	DXY	300	1782879900	101.328337	101.345786	101.319609	101.331867
196377	DOW	300	1782886500	52318.308876	52333.185820	52312.465142	52319.346023
196378	DXY	300	1782886500	101.277916	101.317000	101.275161	101.313417
196196	SP500	300	1782886200	7499.696975	7500.955397	7498.508208	7499.980751
192755	SP500	300	1782880500	7499.438594	7500.397212	7497.701345	7498.591449
192756	DOW	300	1782880500	52322.421254	52327.754452	52310.670060	52314.754729
192757	DXY	300	1782880500	101.338365	101.345728	101.319563	101.335670
194393	SP500	300	1782883200	7499.863080	7500.815153	7498.102932	7499.772832
194394	DOW	300	1782883200	52321.098072	52328.051950	52310.701152	52323.385902
194395	DXY	300	1782883200	101.283488	101.297022	101.277027	101.285253
196197	DOW	300	1782886200	52317.423599	52330.267285	52308.922645	52318.319899
196198	DXY	300	1782886200	101.304960	101.306694	101.278482	101.279750
195473	SP500	300	1782885000	7499.661914	7500.674514	7497.746865	7499.656462
195474	DOW	300	1782885000	52322.543074	52329.337046	52309.302487	52318.988781
195475	DXY	300	1782885000	101.288309	101.293842	101.266686	101.275697
193664	SP500	300	1782882000	7499.360000	7501.063150	7498.085771	7499.792616
193665	DOW	300	1782882000	52319.200000	52327.357784	52308.645067	52325.155923
193666	DXY	300	1782882000	101.285000	101.288425	101.261000	101.261831
196013	SP500	300	1782885900	7499.944755	7500.788598	7498.056069	7499.789624
195293	SP500	300	1782884700	7499.302074	7500.404477	7497.398735	7499.454060
195294	DOW	300	1782884700	52316.591611	52327.863752	52307.697946	52321.773470
194933	SP500	300	1782884100	7499.654932	7500.324542	7498.276753	7499.433843
194934	DOW	300	1782884100	52319.910235	52324.068371	52310.514335	52322.086867
194935	DXY	300	1782884100	101.282113	101.298139	101.263653	101.282934
195295	DXY	300	1782884700	101.286046	101.299479	101.277248	101.288781
195113	SP500	300	1782884400	7499.267668	7500.323256	7498.140899	7499.489153
195114	DOW	300	1782884400	52323.201429	52331.689464	52305.542367	52315.699337
195115	DXY	300	1782884400	101.282862	101.287501	101.258980	101.286223
194573	SP500	300	1782883500	7499.611161	7501.026443	7498.047843	7499.819545
194574	DOW	300	1782883500	52322.751103	52325.209437	52307.047289	52312.239091
194575	DXY	300	1782883500	101.285641	101.300281	101.272311	101.280869
194753	SP500	300	1782883800	7499.585863	7500.707625	7498.166975	7499.368073
195653	SP500	300	1782885300	7499.534131	7500.529367	7497.781261	7498.823221
195654	DOW	300	1782885300	52317.735178	52329.478595	52308.013415	52313.674926
195655	DXY	300	1782885300	101.275030	101.292898	101.267838	101.292081
196014	DOW	300	1782885900	52320.173206	52328.244557	52309.937934	52317.375705
195833	SP500	300	1782885600	7498.651713	7500.799276	7497.591505	7500.079218
195834	DOW	300	1782885600	52315.349349	52328.070153	52311.022647	52318.717476
195835	DXY	300	1782885600	101.290105	101.296000	101.269555	101.292979
196015	DXY	300	1782885900	101.293367	101.321283	101.292910	101.302806
196733	SP500	300	1782887100	7500.550578	7500.691244	7497.789133	7498.507245
196556	SP500	300	1782886800	7500.729668	7500.729668	7498.091578	7500.276046
196376	SP500	300	1782886500	7499.806727	7500.557574	7498.069704	7500.557574
196734	DOW	300	1782887100	52321.579595	52325.123047	52312.237407	52318.894564
196735	DXY	300	1782887100	101.335052	101.337347	101.305841	101.314657
196557	DOW	300	1782886800	52319.546121	52325.598693	52309.876574	52323.535543
196558	DXY	300	1782886800	101.313720	101.338663	101.310744	101.336043
196907	SP500	300	1782887400	7498.767085	7500.482870	7498.010511	7498.770865
196908	DOW	300	1782887400	52317.343935	52332.453053	52309.420113	52318.480292
196909	DXY	300	1782887400	101.317187	101.338625	101.301097	101.323808
197090	SP500	300	1782887700	7498.518055	7500.647063	7498.055630	7499.155721
197091	DOW	300	1782887700	52318.979516	52329.784762	52307.738541	52322.979545
197092	DXY	300	1782887700	101.321409	101.336626	101.310451	101.331954
197273	SP500	300	1782888000	7499.272202	7500.653621	7497.991774	7499.356240
197274	DOW	300	1782888000	52321.826019	52329.475516	52309.637999	52324.538056
197995	DXY	300	1782889200	101.323776	101.332616	101.312422	101.314464
200196	DOW	300	1782892800	52319.344868	52331.738519	52303.964919	52319.974028
200197	DXY	300	1782892800	101.352158	101.364233	101.339126	101.347526
202742	SP500	300	1782897000	7499.731917	7500.506757	7497.830950	7499.321084
202193	SP500	300	1782896100	7499.389757	7500.770828	7497.629135	7499.277840
200555	SP500	300	1782893400	7499.496237	7501.086762	7498.080418	7499.100274
200556	DOW	300	1782893400	52320.222374	52329.246733	52305.191455	52319.179224
200557	DXY	300	1782893400	101.323187	101.350951	101.317414	101.350951
199469	SP500	300	1782891600	7499.159830	7500.786050	7498.074920	7499.490385
198533	SP500	300	1782890100	7499.593113	7500.820813	7497.886659	7499.360000
198534	DOW	300	1782890100	52319.025826	52331.146837	52303.392206	52319.200000
198535	DXY	300	1782890100	101.322113	101.350281	101.303516	101.345000
197639	SP500	300	1782888600	7499.337974	7500.580674	7498.385160	7499.873085
197640	DOW	300	1782888600	52317.546601	52329.022010	52311.038377	52318.005735
197641	DXY	300	1782888600	101.324391	101.347909	101.319183	101.339360
198353	SP500	300	1782889800	7499.325448	7500.471994	7497.191396	7499.360000
198354	DOW	300	1782889800	52319.060992	52328.171927	52313.175716	52319.200000
198355	DXY	300	1782889800	101.315146	101.347613	101.300088	101.323000
199470	DOW	300	1782891600	52319.612674	52328.564807	52307.442863	52319.973783
199471	DXY	300	1782891600	101.395954	101.400835	101.345008	101.363516
198716	SP500	300	1782890400	7499.141826	7500.504942	7497.919157	7499.360000
198717	DOW	300	1782890400	52321.282869	52328.008335	52309.529161	52319.200000
198718	DXY	300	1782890400	101.345630	101.366022	101.343387	101.361000
197822	SP500	300	1782888900	7500.078374	7500.505719	7497.598926	7499.438498
197823	DOW	300	1782888900	52316.615414	52331.519971	52310.993682	52317.295343
197824	DXY	300	1782888900	101.337874	101.344084	101.307104	101.323364
198899	SP500	300	1782890700	7499.306922	7500.508568	7497.573891	7499.659464
198173	SP500	300	1782889500	7499.600091	7500.325888	7498.099952	7499.471829
198174	DOW	300	1782889500	52320.365591	52329.226297	52311.495340	52318.997142
198175	DXY	300	1782889500	101.313220	101.329595	101.305025	101.315797
197275	DXY	300	1782888000	101.332272	101.337164	101.308159	101.325563
198900	DOW	300	1782890700	52318.917033	52326.402284	52310.263111	52319.525082
198901	DXY	300	1782890700	101.361873	101.388242	101.355524	101.375607
199286	SP500	300	1782891300	7499.150781	7501.036279	7498.191248	7498.889263
199287	DOW	300	1782891300	52317.665956	52326.655648	52309.990096	52320.280003
199288	DXY	300	1782891300	101.381895	101.405516	101.373855	101.395378
202194	DOW	300	1782896100	52324.431256	52329.547167	52310.348949	52317.907946
202010	SP500	300	1782895800	7499.043467	7500.326026	7497.968212	7499.213895
197456	SP500	300	1782888300	7499.562757	7500.927734	7498.360682	7499.502108
197457	DOW	300	1782888300	52326.356017	52327.751039	52312.312928	52317.370868
197458	DXY	300	1782888300	101.323776	101.338940	101.305500	101.324493
200735	SP500	300	1782893700	7499.250731	7501.009904	7497.956477	7499.476275
200736	DOW	300	1782893700	52320.451398	52327.082036	52310.024678	52318.488689
200737	DXY	300	1782893700	101.351647	101.353261	101.327396	101.338892
199652	SP500	300	1782891900	7499.705988	7500.971472	7498.198602	7499.082428
199653	DOW	300	1782891900	52321.913400	52327.692141	52310.541680	52321.199056
199654	DXY	300	1782891900	101.361628	101.371790	101.342056	101.348495
197993	SP500	300	1782889200	7499.195590	7500.742668	7498.312816	7499.431886
197994	DOW	300	1782889200	52316.614064	52331.751898	52310.876468	52319.290642
199103	SP500	300	1782891000	7499.398224	7500.787873	7498.222924	7499.226647
199104	DOW	300	1782891000	52320.959179	52328.857495	52310.278222	52319.296462
199105	DXY	300	1782891000	101.375734	101.387157	101.357746	101.381771
202011	DOW	300	1782895800	52322.621675	52324.143288	52311.389328	52322.482763
202012	DXY	300	1782895800	101.348953	101.351906	101.324735	101.330852
201827	SP500	300	1782895500	7499.808540	7500.444711	7498.084101	7499.301807
201828	DOW	300	1782895500	52320.259037	52328.292877	52311.868569	52320.578507
201829	DXY	300	1782895500	101.349328	101.373675	101.333205	101.349358
200015	SP500	300	1782892500	7499.100454	7500.435261	7498.205435	7499.097567
200016	DOW	300	1782892500	52321.207686	52326.532220	52313.094008	52320.701503
200017	DXY	300	1782892500	101.347073	101.366824	101.330942	101.351069
200375	SP500	300	1782893100	7499.094116	7501.564179	7497.859392	7499.199038
200376	DOW	300	1782893100	52320.580580	52326.779447	52309.830679	52318.970044
199835	SP500	300	1782892200	7499.089026	7500.709129	7497.912364	7499.281134
199836	DOW	300	1782892200	52322.405749	52326.441268	52309.825150	52321.226398
199837	DXY	300	1782892200	101.345995	101.363133	101.339912	101.345885
200377	DXY	300	1782893100	101.346248	101.356410	101.316634	101.325537
201461	SP500	300	1782894900	7499.308681	7500.841239	7498.220283	7499.176545
201462	DOW	300	1782894900	52321.796773	52327.361914	52312.188127	52320.440707
201463	DXY	300	1782894900	101.355186	101.369961	101.332866	101.356324
200915	SP500	300	1782894000	7499.540135	7500.874507	7497.939354	7499.428022
200195	SP500	300	1782892800	7498.984042	7500.685767	7497.982329	7499.378783
200916	DOW	300	1782894000	52318.875478	52327.581329	52307.590124	52318.314085
200917	DXY	300	1782894000	101.339801	101.359885	101.333325	101.349046
201095	SP500	300	1782894300	7499.608002	7500.648685	7497.311954	7499.488165
201096	DOW	300	1782894300	52319.507044	52331.061177	52310.026959	52320.341758
201097	DXY	300	1782894300	101.347525	101.348925	101.313164	101.331920
201644	SP500	300	1782895200	7499.114599	7500.423248	7497.891681	7499.609131
201645	DOW	300	1782895200	52322.031718	52328.110413	52310.941749	52318.971843
201646	DXY	300	1782895200	101.353803	101.387558	101.343058	101.351062
201278	SP500	300	1782894600	7499.494371	7500.520459	7498.084750	7499.160883
201279	DOW	300	1782894600	52320.009466	52328.500128	52312.672602	52321.042778
201280	DXY	300	1782894600	101.333209	101.367117	101.323254	101.354235
202195	DXY	300	1782896100	101.333036	101.356185	101.323868	101.346221
202376	SP500	300	1782896400	7499.365132	7500.612693	7497.710654	7499.360829
202377	DOW	300	1782896400	52319.119314	52329.032865	52308.913187	52322.631489
202378	DXY	300	1782896400	101.345982	101.352441	101.321576	101.332647
202559	SP500	300	1782896700	7499.531688	7500.738119	7498.142447	7499.780493
202560	DOW	300	1782896700	52323.033855	52329.269422	52312.838043	52322.170018
202561	DXY	300	1782896700	101.334238	101.373336	101.318194	101.362871
203103	DOW	300	1782897600	52316.179966	52326.687353	52312.455364	52321.200330
203104	DXY	300	1782897600	101.382752	101.387915	101.346466	101.347813
203470	DXY	300	1782898200	101.385369	101.397020	101.363859	101.379047
207239	DXY	300	1782978600	101.125095	101.137509	101.074361	101.096568
206871	SP500	300	1782978000	7483.420888	7485.026422	7481.676292	7482.699812
206872	DOW	300	1782978000	52304.030326	52313.589156	52296.776267	52308.515057
205773	SP500	300	1782976200	7483.416022	7485.166171	7481.573634	7483.132295
205774	DOW	300	1782976200	52307.889043	52314.483668	52297.555389	52302.047582
205775	DXY	300	1782976200	101.210130	101.247180	101.206405	101.230081
206873	DXY	300	1782978000	101.155947	101.182299	101.146623	101.173267
206505	SP500	300	1782977400	7483.120508	7484.402884	7481.866424	7483.272784
205244	SP500	300	1782975300	7482.903983	7484.433157	7482.028010	7482.595825
205245	DOW	300	1782975300	52305.996086	52313.394150	52293.384461	52304.512126
205246	DXY	300	1782975300	101.270681	101.282843	101.172827	101.175948
205061	SP500	300	1782975000	7483.018053	7484.798889	7482.390057	7483.103303
204566	SP500	300	1782900000	7499.041314	7500.015856	7498.259587	7500.015856
204567	DOW	300	1782900000	52318.072211	52324.638675	52314.651498	52318.883208
204568	DXY	300	1782900000	101.403964	101.419826	101.399982	101.418770
205062	DOW	300	1782975000	52304.710353	52315.436358	52291.879533	52307.228735
202743	DOW	300	1782897000	52320.459024	52329.865350	52310.884403	52320.410143
202744	DXY	300	1782897000	101.362379	101.382335	101.335384	101.345611
205063	DXY	300	1782975000	101.286436	101.294660	101.268876	101.272000
203285	SP500	300	1782897900	7498.988108	7500.512619	7498.019827	7499.109557
203286	DOW	300	1782897900	52323.185158	52328.553628	52309.703038	52320.958112
203287	DXY	300	1782897900	101.348270	101.391363	101.334885	101.386515
204698	SP500	300	1782974400	7482.770718	7483.949843	7481.812345	7483.021027
204017	SP500	300	1782899100	7499.160728	7500.949385	7497.508273	7499.367417
204018	DOW	300	1782899100	52319.330441	52331.187172	52310.108917	52318.193202
204019	DXY	300	1782899100	101.391577	101.404204	101.367666	101.400345
203834	SP500	300	1782898800	7499.522753	7501.020794	7497.991257	7499.451115
203835	DOW	300	1782898800	52317.717910	52330.703259	52312.091481	52318.727941
203836	DXY	300	1782898800	101.374063	101.405704	101.370045	101.391781
202922	SP500	300	1782897300	7499.138665	7500.737662	7498.166897	7499.629603
202923	DOW	300	1782897300	52321.071208	52327.785738	52311.920148	52317.338123
202924	DXY	300	1782897300	101.347756	101.383901	101.341380	101.383901
204699	DOW	300	1782974400	52302.617562	52311.712427	52294.059869	52303.915353
204700	DXY	300	1782974400	101.304680	101.309932	101.282892	101.289933
203651	SP500	300	1782898500	7499.777502	7500.213460	7498.245228	7499.611093
203652	DOW	300	1782898500	52318.687753	52328.073697	52307.486005	52319.156902
203653	DXY	300	1782898500	101.377887	101.397079	101.366165	101.373474
204590	SP500	300	1782974100	7483.230000	7485.373370	7481.112445	7482.917358
204591	DOW	300	1782974100	52305.240000	52316.124613	52296.152338	52302.918935
204592	DXY	300	1782974100	101.301000	101.316388	101.290085	101.303966
204200	SP500	300	1782899400	7499.245099	7500.444599	7497.572615	7499.772367
204201	DOW	300	1782899400	52318.094729	52332.361918	52307.108396	52322.216047
204202	DXY	300	1782899400	101.398030	101.420514	101.387270	101.398643
203102	SP500	300	1782897600	7499.720712	7500.937142	7497.990104	7499.272203
203468	SP500	300	1782898200	7499.062847	7500.896763	7498.652745	7499.703171
203469	DOW	300	1782898200	52320.569085	52327.606413	52308.319660	52319.889649
206506	DOW	300	1782977400	52301.615371	52311.791761	52296.880809	52302.975149
205593	SP500	300	1782975900	7483.113168	7484.766089	7481.812513	7483.572868
205594	DOW	300	1782975900	52299.665176	52312.289151	52296.966360	52307.243461
205595	DXY	300	1782975900	101.192793	101.212093	101.179465	101.211934
205421	SP500	300	1782975600	7482.411575	7484.702985	7481.486911	7483.061978
205422	DOW	300	1782975600	52303.214427	52314.213240	52293.948153	52300.043260
205423	DXY	300	1782975600	101.174635	101.204988	101.095952	101.192482
204383	SP500	300	1782899700	7499.873546	7500.346420	7498.126805	7499.252331
204384	DOW	300	1782899700	52323.999104	52329.914579	52310.233131	52317.416363
204385	DXY	300	1782899700	101.400019	101.414531	101.379860	101.406224
204878	SP500	300	1782974700	7482.929785	7484.846203	7481.715462	7482.990055
204879	DOW	300	1782974700	52303.400822	52317.687470	52299.096205	52305.538721
204880	DXY	300	1782974700	101.288014	101.304366	101.282210	101.288137
206322	SP500	300	1782977100	7482.765711	7484.493070	7481.941942	7483.162500
206323	DOW	300	1782977100	52305.598913	52317.026275	52296.173249	52302.962668
206324	DXY	300	1782977100	101.195879	101.221031	101.186392	101.199677
206507	DXY	300	1782977400	101.197322	101.210485	101.173606	101.183576
206139	SP500	300	1782976800	7482.669514	7484.873002	7481.723656	7483.003940
206140	DOW	300	1782976800	52311.801585	52316.783573	52293.904090	52307.304409
206141	DXY	300	1782976800	101.209144	101.217357	101.184693	101.195076
205956	SP500	300	1782976500	7483.194553	7484.577466	7481.598709	7482.774741
205957	DOW	300	1782976500	52302.973770	52313.094164	52296.909928	52310.216156
205958	DXY	300	1782976500	101.229644	101.256128	101.205000	101.208049
207054	SP500	300	1782978300	7482.744575	7483.992121	7482.041686	7483.340262
206688	SP500	300	1782977700	7483.378866	7484.351794	7481.896506	7483.317345
206689	DOW	300	1782977700	52300.900035	52317.970438	52292.565012	52305.854684
206690	DXY	300	1782977700	101.182556	101.188000	101.151113	101.153446
207055	DOW	300	1782978300	52309.772286	52315.442144	52294.146880	52306.922295
207605	DXY	300	1782979200	101.102700	101.116854	101.059153	101.059897
207238	DOW	300	1782978600	52305.632253	52314.741498	52296.391668	52300.810706
207237	SP500	300	1782978600	7483.283917	7484.618397	7481.735854	7482.772850
207056	DXY	300	1782978300	101.175669	101.194561	101.124389	101.125990
207420	SP500	300	1782978900	7482.967509	7484.180483	7482.063032	7483.337761
207421	DOW	300	1782978900	52299.122930	52318.145065	52292.912180	52302.379482
207422	DXY	300	1782978900	101.096858	101.135407	101.094230	101.100491
207785	DXY	300	1782979500	101.060083	101.092835	101.048783	101.079274
207603	SP500	300	1782979200	7483.338772	7484.568617	7481.348910	7483.068429
207604	DOW	300	1782979200	52303.802729	52313.434905	52295.525206	52310.600821
207783	SP500	300	1782979500	7483.334672	7484.592066	7481.663743	7482.760701
207784	DOW	300	1782979500	52310.708917	52313.452600	52295.218715	52302.933172
211969	DOW	300	1782986400	52306.129523	52316.773411	52297.394816	52306.471925
211785	SP500	300	1782986100	7483.570273	7484.692134	7482.223604	7483.278854
209607	SP500	300	1782982500	7483.513031	7484.711677	7481.745683	7482.887405
209608	DOW	300	1782982500	52307.944421	52314.232747	52297.308104	52305.033141
209609	DXY	300	1782982500	100.958616	100.985896	100.917082	100.927621
211786	DOW	300	1782986100	52308.422396	52313.590082	52296.170035	52304.099135
211787	DXY	300	1782986100	101.014557	101.029997	100.994441	101.009097
207963	SP500	300	1782979800	7482.793745	7484.544427	7481.715478	7483.501773
207964	DOW	300	1782979800	52301.477420	52318.569757	52297.068191	52306.547675
207965	DXY	300	1782979800	101.078944	101.081747	100.996624	101.009373
211239	SP500	300	1782985200	7482.250829	7484.338487	7481.522399	7483.253461
211240	DOW	300	1782985200	52308.020518	52316.036332	52293.634679	52310.313934
210876	SP500	300	1782984600	7483.030538	7484.319396	7482.005753	7484.262310
210147	SP500	300	1782983400	7483.158720	7484.445407	7482.170398	7483.189788
209967	SP500	300	1782983100	7482.842113	7484.974896	7481.932876	7482.982356
209968	DOW	300	1782983100	52304.830057	52316.727789	52292.833574	52306.113853
209969	DXY	300	1782983100	100.945597	100.965449	100.928352	100.933309
210148	DOW	300	1782983400	52305.329346	52316.219396	52293.738594	52305.576991
208512	SP500	300	1782980700	7484.109093	7484.454336	7481.838307	7484.163343
208513	DOW	300	1782980700	52306.049095	52313.832688	52297.563612	52304.240876
208514	DXY	300	1782980700	100.981886	100.998303	100.973622	100.987581
210149	DXY	300	1782983400	100.933304	100.985389	100.928214	100.969912
210877	DOW	300	1782984600	52311.962952	52313.244312	52293.486144	52311.282258
208146	SP500	300	1782980100	7483.333818	7484.875403	7482.158949	7482.658064
208147	DOW	300	1782980100	52307.284806	52313.740757	52297.787278	52306.365069
208148	DXY	300	1782980100	101.010976	101.021022	100.970289	100.998139
210878	DXY	300	1782984600	100.998666	101.017147	100.981253	101.000875
209787	SP500	300	1782982800	7482.776262	7484.279651	7482.010970	7482.978321
209788	DOW	300	1782982800	52306.801849	52313.810800	52287.817664	52304.487138
209789	DXY	300	1782982800	100.927321	100.963136	100.915664	100.947396
209061	SP500	300	1782981600	7482.920451	7484.304842	7482.124853	7483.340139
209062	DOW	300	1782981600	52298.306234	52316.509930	52289.036057	52304.989213
209063	DXY	300	1782981600	100.984886	101.007876	100.976833	100.988556
209244	SP500	300	1782981900	7483.356466	7485.102370	7481.903449	7483.637183
209245	DOW	300	1782981900	52305.967484	52316.023463	52299.149837	52306.338008
209246	DXY	300	1782981900	100.987886	100.990473	100.950567	100.978720
208878	SP500	300	1782981300	7483.698905	7484.892924	7481.868244	7482.876892
208879	DOW	300	1782981300	52301.994393	52312.570930	52297.815087	52300.068482
208880	DXY	300	1782981300	100.995153	101.009353	100.972014	100.983870
208329	SP500	300	1782980400	7482.690960	7485.380975	7482.025701	7484.105196
208330	DOW	300	1782980400	52304.331888	52315.317090	52295.519783	52308.136372
208331	DXY	300	1782980400	100.999433	101.001213	100.965137	100.981916
211241	DXY	300	1782985200	101.026676	101.048359	101.016479	101.030201
210510	SP500	300	1782984000	7482.528828	7484.692462	7481.844361	7483.224075
209427	SP500	300	1782982200	7483.628040	7484.915553	7481.886733	7483.591327
209428	DOW	300	1782982200	52308.401922	52313.493497	52298.987419	52306.448079
209429	DXY	300	1782982200	100.981226	100.987355	100.931678	100.960394
208695	SP500	300	1782981000	7483.971417	7484.400006	7481.931820	7483.824049
208696	DOW	300	1782981000	52303.374790	52313.666023	52295.918228	52303.224212
208697	DXY	300	1782981000	100.987612	101.000345	100.960023	100.994367
210511	DOW	300	1782984000	52307.709825	52315.250025	52291.815039	52306.470599
210512	DXY	300	1782984000	101.010929	101.037805	100.997958	101.018232
211059	SP500	300	1782984900	7484.429081	7484.738586	7481.781630	7482.470761
211060	DOW	300	1782984900	52311.679741	52316.553928	52292.066094	52306.621226
210327	SP500	300	1782983700	7483.184568	7485.018564	7482.273117	7482.374606
210328	DOW	300	1782983700	52304.946380	52319.294817	52298.047031	52306.028532
210329	DXY	300	1782983700	100.969781	101.027959	100.965020	101.012786
211061	DXY	300	1782984900	100.999861	101.043121	100.995268	101.026681
210693	SP500	300	1782984300	7483.493877	7484.508572	7482.388143	7482.961368
210694	DOW	300	1782984300	52306.580677	52314.783583	52298.092287	52310.292102
210695	DXY	300	1782984300	101.018933	101.021697	100.984585	101.001148
211419	SP500	300	1782985500	7483.203952	7484.434341	7481.158683	7482.882409
211420	DOW	300	1782985500	52310.040279	52315.724253	52297.685671	52307.001163
211421	DXY	300	1782985500	101.029984	101.032168	100.986139	101.008376
211970	DXY	300	1782986400	101.009332	101.025586	100.985574	101.017218
212152	DOW	300	1782986700	52307.423190	52320.002845	52292.665421	52305.749142
212153	DXY	300	1782986700	101.014811	101.033954	100.993271	101.029085
211602	SP500	300	1782985800	7482.701241	7484.917852	7482.079086	7483.357521
211603	DOW	300	1782985800	52306.775265	52321.847116	52295.625209	52306.824629
212517	SP500	300	1782987300	7483.497733	7484.848002	7482.053681	7483.421104
211604	DXY	300	1782985800	101.007756	101.027015	100.990282	101.014782
212518	DOW	300	1782987300	52305.333486	52313.106789	52296.029514	52301.695436
212519	DXY	300	1782987300	101.039203	101.050816	101.023602	101.040832
212700	SP500	300	1782987600	7483.284403	7484.451846	7482.108440	7482.797152
211968	SP500	300	1782986400	7483.056032	7484.736182	7481.519381	7483.158058
212701	DOW	300	1782987600	52303.690270	52312.974330	52294.991230	52309.400552
212702	DXY	300	1782987600	101.039798	101.056076	101.033137	101.050167
212151	SP500	300	1782986700	7483.403037	7484.371443	7481.904092	7482.983547
212334	SP500	300	1782987000	7483.242262	7484.369922	7481.398103	7483.490481
212335	DOW	300	1782987000	52307.646788	52315.386262	52297.031990	52306.887160
212336	DXY	300	1782987000	101.028823	101.046878	101.018749	101.037561
212883	SP500	300	1782987900	7482.920711	7485.041439	7481.982108	7482.426395
212884	DOW	300	1782987900	52308.696178	52314.470425	52297.052620	52304.538990
212885	DXY	300	1782987900	101.048804	101.069988	101.038968	101.067627
213066	SP500	300	1782988200	7482.557188	7484.294669	7481.788388	7483.412017
213067	DOW	300	1782988200	52305.774185	52311.664753	52290.562448	52305.725838
213068	DXY	300	1782988200	101.068722	101.090303	101.057861	101.086544
213249	SP500	300	1782988500	7483.554354	7484.536697	7481.908957	7483.449564
213250	DOW	300	1782988500	52306.776550	52319.676953	52294.653845	52304.186331
216537	SP500	300	1782993900	7482.812727	7484.423357	7481.738354	7483.692188
216538	DOW	300	1782993900	52306.717833	52316.128925	52296.815002	52302.009636
216539	DXY	300	1782993900	101.133508	101.159417	101.125240	101.125612
218072	DXY	300	1783303500	100.945009	100.977868	100.940108	100.969501
217887	SP500	300	1783303200	7482.886096	7484.542246	7481.842479	7483.661802
217888	DOW	300	1783303200	52899.163430	52907.795630	52887.949374	52902.214636
217632	SP500	300	1782995700	7483.346125	7484.755348	7482.434476	7483.173696
217633	DOW	300	1782995700	52305.330565	52312.479292	52301.761217	52303.455844
216720	SP500	300	1782994200	7483.730873	7485.367921	7482.106801	7483.455906
215988	SP500	300	1782993000	7483.353984	7484.867278	7481.907636	7484.207475
213981	SP500	300	1782989700	7483.303960	7484.358771	7481.416728	7483.726490
213982	DOW	300	1782989700	52306.194662	52314.113551	52297.493659	52300.154965
213983	DXY	300	1782989700	101.094671	101.096483	101.069318	101.072933
213615	SP500	300	1782989100	7483.882615	7484.968093	7482.026844	7483.378252
213616	DOW	300	1782989100	52306.552395	52313.630793	52298.081154	52310.145520
213617	DXY	300	1782989100	101.088966	101.108044	101.068864	101.101977
215989	DOW	300	1782993000	52307.604620	52312.517953	52289.217999	52306.790268
215990	DXY	300	1782993000	101.058654	101.100514	101.057749	101.093134
215079	SP500	300	1782991500	7483.488019	7484.450292	7481.916439	7482.833626
215080	DOW	300	1782991500	52302.537663	52317.537724	52292.387749	52309.045225
215081	DXY	300	1782991500	101.063005	101.068756	101.026422	101.026422
215805	SP500	300	1782992700	7482.765306	7484.951800	7481.673397	7483.104648
215806	DOW	300	1782992700	52302.091328	52316.649506	52297.827171	52306.655402
215807	DXY	300	1782992700	101.060197	101.070659	101.049663	101.057254
216721	DOW	300	1782994200	52300.727357	52321.254586	52295.679068	52302.661315
216722	DXY	300	1782994200	101.124749	101.160568	101.119943	101.134144
214530	SP500	300	1782990600	7483.587898	7484.629673	7481.758187	7483.355851
214531	DOW	300	1782990600	52310.068576	52315.068371	52297.024331	52308.067905
214532	DXY	300	1782990600	101.041244	101.081291	101.038334	101.063946
214347	SP500	300	1782990300	7481.693717	7484.671220	7481.332022	7483.695183
214348	DOW	300	1782990300	52308.514156	52313.863352	52295.560086	52308.284777
214349	DXY	300	1782990300	101.069730	101.086536	101.041215	101.042794
213798	SP500	300	1782989400	7483.662113	7484.561935	7481.927212	7483.342258
213799	DOW	300	1782989400	52311.217436	52314.881816	52295.957596	52308.099903
213800	DXY	300	1782989400	101.102972	101.106057	101.075460	101.092270
213251	DXY	300	1782988500	101.084745	101.095315	101.065616	101.079891
216354	SP500	300	1782993600	7484.151946	7484.561244	7481.747334	7482.776246
214713	SP500	300	1782990900	7483.253155	7484.371143	7481.914459	7483.229923
214714	DOW	300	1782990900	52307.480142	52313.601528	52294.312890	52301.305819
214715	DXY	300	1782990900	101.062269	101.094613	101.056195	101.068126
216355	DOW	300	1782993600	52305.380170	52316.250790	52289.016851	52308.288747
216356	DXY	300	1782993600	101.118008	101.143476	101.104147	101.133942
213432	SP500	300	1782988800	7483.590011	7484.546646	7482.120502	7483.875028
213433	DOW	300	1782988800	52302.732158	52314.959124	52298.514563	52304.696715
213434	DXY	300	1782988800	101.079454	101.105032	101.074963	101.088986
214164	SP500	300	1782990000	7483.526967	7484.456148	7481.704246	7481.704246
214165	DOW	300	1782990000	52301.241466	52315.605330	52292.089550	52307.664428
214166	DXY	300	1782990000	101.071968	101.092309	101.057167	101.068959
215442	SP500	300	1782992100	7483.028055	7484.316210	7481.536286	7482.320112
215443	DOW	300	1782992100	52298.515326	52315.558883	52295.039169	52303.490898
215444	DXY	300	1782992100	101.041244	101.053219	101.029520	101.038612
216171	SP500	300	1782993300	7484.336530	7485.078988	7482.474684	7483.967796
214896	SP500	300	1782991200	7483.065474	7484.992478	7481.521061	7483.729650
214897	DOW	300	1782991200	52303.058427	52316.630897	52295.327328	52304.326377
214898	DXY	300	1782991200	101.068159	101.075243	101.047359	101.064058
216172	DOW	300	1782993300	52307.427710	52318.194263	52297.755327	52306.027057
215262	SP500	300	1782991800	7482.534807	7484.647719	7481.722412	7483.151595
215263	DOW	300	1782991800	52307.832563	52313.164648	52299.558143	52299.558143
215264	DXY	300	1782991800	101.028097	101.048237	101.021968	101.042184
216173	DXY	300	1782993300	101.095038	101.120922	101.084618	101.119499
215622	SP500	300	1782992400	7482.258055	7484.668059	7481.354073	7483.039308
215623	DOW	300	1782992400	52301.718891	52316.186993	52298.416038	52303.073450
215624	DXY	300	1782992400	101.039704	101.059219	101.026781	101.059219
217634	DXY	300	1782995700	101.172588	101.184324	101.146458	101.152621
217449	SP500	300	1782995400	7483.208507	7484.552307	7482.145339	7483.401388
217450	DOW	300	1782995400	52305.507323	52312.579554	52290.724994	52306.800631
217451	DXY	300	1782995400	101.203838	101.204615	101.168385	101.174887
217086	SP500	300	1782994800	7483.290728	7484.852630	7481.408576	7483.248635
217087	DOW	300	1782994800	52304.573532	52314.166959	52297.977170	52300.751565
217088	DXY	300	1782994800	101.185421	101.191790	101.151001	101.176068
217695	SP500	300	1783302600	7483.240000	7483.286878	7482.071054	7482.071054
216903	SP500	300	1782994500	7483.350260	7484.295574	7482.117665	7483.166009
216904	DOW	300	1782994500	52302.015962	52316.186395	52295.809204	52302.561947
217696	DOW	300	1783302600	52900.070000	52903.700119	52897.160089	52903.700119
216905	DXY	300	1782994500	101.133131	101.183698	101.125179	101.183698
217697	DXY	300	1783302600	100.918000	100.918000	100.906101	100.906548
217266	SP500	300	1782995100	7483.095802	7484.749182	7482.046292	7482.955728
217267	DOW	300	1782995100	52300.983264	52314.383130	52296.372873	52305.408744
217268	DXY	300	1782995100	101.174818	101.207408	101.160579	101.204809
217704	SP500	300	1783302900	7482.092500	7484.386264	7481.803722	7482.648243
217705	DOW	300	1783302900	52902.167277	52908.730001	52887.809296	52898.435379
217706	DXY	300	1783302900	100.906215	100.940093	100.906215	100.938831
217889	DXY	300	1783303200	100.937628	100.964064	100.932912	100.944794
218070	SP500	300	1783303500	7483.791715	7484.388159	7482.032301	7482.730557
218071	DOW	300	1783303500	52901.413372	52908.462947	52889.953132	52898.482622
218250	SP500	300	1783303800	7482.774316	7484.463271	7481.851489	7484.463271
218251	DOW	300	1783303800	52899.406285	52909.883807	52889.737086	52894.980400
218252	DXY	300	1783303800	100.967504	100.973843	100.949344	100.958845
218433	SP500	300	1783304100	7484.321224	7484.674243	7482.326007	7483.194624
220623	SP500	300	1783323300	7483.240000	7484.486063	7481.911537	7483.467557
220152	SP500	300	1783322400	7483.369408	7484.574494	7482.220087	7483.205518
220153	DOW	300	1783322400	52893.168978	52907.405211	52887.890948	52897.698203
220154	DXY	300	1783322400	101.079222	101.094822	101.043260	101.043260
218799	SP500	300	1783304700	7482.985666	7485.088535	7481.316135	7481.505195
218800	DOW	300	1783304700	52900.135058	52909.602302	52890.355350	52905.011641
218801	DXY	300	1783304700	100.959753	100.976080	100.949974	100.959140
219969	SP500	300	1783322100	7483.676266	7485.323910	7481.981159	7483.071490
219970	DOW	300	1783322100	52901.260168	52907.779361	52889.939928	52893.530169
219324	SP500	300	1783310400	7483.240000	7484.216050	7482.432635	7483.230901
219325	DOW	300	1783310400	52900.070000	52906.041519	52888.574472	52899.838836
219326	DXY	300	1783310400	100.961000	100.972127	100.953160	100.965041
219971	DXY	300	1783322100	101.067794	101.085978	101.059328	101.080505
220624	DOW	300	1783323300	52900.070000	52909.021983	52895.355683	52901.003358
220625	DXY	300	1783323300	101.058000	101.065083	101.036635	101.048012
219786	SP500	300	1783321800	7483.076996	7484.723463	7482.173402	7483.382881
219787	DOW	300	1783321800	52894.746547	52909.050651	52886.310850	52900.463065
219788	DXY	300	1783321800	101.046564	101.107559	101.046564	101.068486
218434	DOW	300	1783304100	52896.667874	52907.900917	52891.091896	52891.233373
218435	DXY	300	1783304100	100.956912	100.982236	100.955759	100.967003
220335	SP500	300	1783322700	7482.960159	7484.452900	7482.648182	7483.470192
220336	DOW	300	1783322700	52898.907776	52910.052684	52892.172503	52903.428673
220337	DXY	300	1783322700	101.045035	101.053511	101.000855	101.031427
218982	SP500	300	1783305000	7481.593067	7484.387928	7481.335209	7482.771927
218983	DOW	300	1783305000	52903.759855	52907.695399	52893.210433	52893.238098
218984	DXY	300	1783305000	100.959647	100.964200	100.944511	100.963374
221121	SP500	300	1783324500	7483.240000	7484.379713	7481.695009	7483.959793
221122	DOW	300	1783324500	52900.070000	52909.736977	52892.498737	52899.536697
221123	DXY	300	1783324500	101.012000	101.026108	100.995031	101.008055
218616	SP500	300	1783304400	7483.089794	7484.474121	7481.634698	7483.148364
218617	DOW	300	1783304400	52891.724806	52909.251122	52891.427130	52900.144636
218618	DXY	300	1783304400	100.969495	100.977088	100.953238	100.958702
220923	SP500	300	1783323900	7483.124079	7484.463747	7481.965248	7482.420939
220924	DOW	300	1783323900	52899.105612	52913.131970	52891.176746	52901.028265
220925	DXY	300	1783323900	101.037759	101.061143	101.020275	101.024572
220743	SP500	300	1783323600	7483.261994	7484.579904	7482.011435	7482.915948
220744	DOW	300	1783323600	52899.288412	52915.203917	52888.231247	52898.126402
219165	SP500	300	1783305300	7482.930374	7485.019436	7482.642475	7483.305704
219166	DOW	300	1783305300	52893.186426	52910.607015	52888.537262	52897.741545
219167	DXY	300	1783305300	100.964928	100.976546	100.947691	100.961963
220745	DXY	300	1783323600	101.050065	101.057597	101.023226	101.036602
219600	SP500	300	1783311000	7483.338747	7484.778190	7482.054618	7482.532998
219601	DOW	300	1783311000	52895.516323	52909.493251	52889.818470	52899.908778
219602	DXY	300	1783311000	100.953547	100.962757	100.934670	100.956858
219780	SP500	300	1783311300	7482.773759	7482.773759	7482.773759	7482.773759
219781	DOW	300	1783311300	52900.814241	52900.814241	52900.814241	52900.814241
219782	DXY	300	1783311300	100.957175	100.957175	100.957175	100.957175
219420	SP500	300	1783310700	7482.931912	7484.743583	7482.004714	7483.483676
219421	DOW	300	1783310700	52900.003335	52909.009067	52893.382248	52896.248665
219422	DXY	300	1783310700	100.965790	100.969941	100.947054	100.952720
219783	SP500	300	1783321500	7483.240000	7483.240000	7482.885196	7482.885196
219784	DOW	300	1783321500	52900.070000	52900.070000	52896.478947	52896.478947
221600	DXY	300	1783325400	101.008537	101.063038	100.996306	101.031804
219785	DXY	300	1783321500	101.048000	101.048000	101.046793	101.047180
220518	SP500	300	1783323000	7483.738711	7484.664196	7482.517381	7482.889112
220519	DOW	300	1783323000	52903.096274	52909.546682	52890.418064	52890.479853
220520	DXY	300	1783323000	101.031403	101.048504	101.020353	101.047994
222138	SP500	300	1783326300	7483.240000	7484.255113	7481.477645	7482.618979
221781	SP500	300	1783325700	7482.667113	7484.835017	7481.524682	7482.703061
221782	DOW	300	1783325700	52904.619478	52908.167876	52887.029335	52898.632522
221783	DXY	300	1783325700	101.034164	101.051943	101.022878	101.043714
222139	DOW	300	1783326300	52900.070000	52907.211794	52892.776122	52899.845850
221103	SP500	300	1783324200	7482.394727	7484.083338	7482.109223	7483.592119
221104	DOW	300	1783324200	52900.515511	52905.243905	52896.682045	52896.682045
221105	DXY	300	1783324200	101.026330	101.032626	101.021238	101.025461
222310	DOW	300	1783326600	52898.948936	52913.540751	52893.139463	52901.890817
221964	SP500	300	1783326000	7482.570105	7484.744491	7481.617474	7481.813654
222492	SP500	300	1783326900	7483.214506	7484.467448	7481.961886	7483.193215
221598	SP500	300	1783325400	7483.067270	7484.560838	7482.030293	7482.532921
221599	DOW	300	1783325400	52906.158419	52913.425064	52892.353750	52903.277078
221415	SP500	300	1783325100	7482.924242	7484.595235	7481.537431	7483.140469
221416	DOW	300	1783325100	52895.998773	52910.375612	52889.981554	52906.090371
221417	DXY	300	1783325100	101.030197	101.030642	100.996629	101.009311
221247	SP500	300	1783324800	7483.240000	7484.843859	7482.222917	7482.959790
221248	DOW	300	1783324800	52900.070000	52909.740457	52892.603757	52894.017668
221249	DXY	300	1783324800	101.012000	101.044901	101.007060	101.031823
222140	DXY	300	1783326300	101.065000	101.085258	101.048861	101.079746
221965	DOW	300	1783326000	52897.495864	52910.051955	52890.253828	52890.253828
221966	DXY	300	1783326000	101.045936	101.093410	101.045936	101.065469
222309	SP500	300	1783326600	7482.915050	7485.101464	7482.135936	7483.136272
222311	DXY	300	1783326600	101.079050	101.083897	101.060707	101.079008
222493	DOW	300	1783326900	52900.434076	52905.374358	52887.744765	52903.758992
222494	DXY	300	1783326900	101.078729	101.095549	101.065863	101.070553
222675	SP500	300	1783327200	7482.957284	7484.390435	7481.446959	7483.228901
222676	DOW	300	1783327200	52902.477462	52908.624725	52888.918102	52907.444338
222677	DXY	300	1783327200	101.072699	101.088011	101.054821	101.084544
222858	SP500	300	1783327500	7483.295369	7484.807856	7482.140613	7483.388464
222859	DOW	300	1783327500	52906.290399	52908.010196	52888.757192	52902.272631
222860	DXY	300	1783327500	101.083153	101.089139	101.064188	101.083856
224679	SP500	300	1783330500	7483.347739	7485.080451	7482.024115	7484.091623
224680	DOW	300	1783330500	52905.913813	52911.836134	52888.395220	52900.740708
224681	DXY	300	1783330500	101.075053	101.099975	101.068980	101.083952
226851	SP500	300	1783334400	7483.240000	7484.281692	7482.191960	7483.949157
226852	DOW	300	1783334400	52900.070000	52906.886538	52889.398187	52892.241218
226491	SP500	300	1783333800	7484.160269	7484.595459	7482.184190	7482.453056
226492	DOW	300	1783333800	52903.614843	52913.205698	52888.930443	52890.188540
225777	SP500	300	1783332600	7482.920139	7484.359328	7482.201635	7482.991074
225778	DOW	300	1783332600	52897.584436	52909.112275	52890.362265	52901.196507
225779	DXY	300	1783332600	101.124983	101.147159	101.106357	101.130005
223041	SP500	300	1783327800	7483.139753	7484.238597	7481.990005	7483.337972
223042	DOW	300	1783327800	52902.140828	52910.837467	52891.253389	52903.718099
223043	DXY	300	1783327800	101.082348	101.097803	101.066640	101.085285
225249	SP500	300	1783331700	7482.762694	7484.830780	7482.201409	7483.197194
225250	DOW	300	1783331700	52894.191961	52907.028322	52893.266794	52893.353951
225042	SP500	300	1783331100	7482.921287	7484.401562	7481.803290	7482.984337
225043	DOW	300	1783331100	52899.373080	52908.580826	52893.962790	52898.544426
225044	DXY	300	1783331100	101.087302	101.093426	101.061196	101.074539
223590	SP500	300	1783328700	7483.560950	7484.456780	7481.796497	7483.696378
223591	DOW	300	1783328700	52898.768042	52911.932430	52891.605264	52899.287942
223592	DXY	300	1783328700	101.088038	101.093770	101.065853	101.070640
225251	DXY	300	1783331700	101.076367	101.112058	101.076367	101.100556
224316	SP500	300	1783329900	7483.730286	7484.958037	7482.066168	7484.339041
224317	DOW	300	1783329900	52897.252113	52908.361570	52891.485339	52895.767503
223224	SP500	300	1783328100	7483.532578	7484.806843	7481.791387	7484.806843
223225	DOW	300	1783328100	52903.859706	52910.150529	52891.183128	52898.631028
223226	DXY	300	1783328100	101.083506	101.108867	101.083506	101.103718
224318	DXY	300	1783329900	101.091039	101.099926	101.077599	101.091679
224136	SP500	300	1783329600	7483.540058	7484.911272	7482.179863	7483.585731
224137	DOW	300	1783329600	52900.789686	52911.225320	52892.686169	52898.620010
224138	DXY	300	1783329600	101.077553	101.108850	101.068061	101.089129
226493	DXY	300	1783333800	101.066148	101.087984	101.050896	101.056421
223953	SP500	300	1783329300	7482.225984	7484.613213	7482.098326	7483.269660
223954	DOW	300	1783329300	52900.644731	52911.350703	52889.821882	52899.444964
223955	DXY	300	1783329300	101.077921	101.086550	101.062631	101.076670
224862	SP500	300	1783330800	7483.820656	7484.542818	7482.040721	7483.142139
224863	DOW	300	1783330800	52900.305410	52909.483889	52890.916699	52899.009672
224864	DXY	300	1783330800	101.082496	101.091320	101.070130	101.085749
224496	SP500	300	1783330200	7484.594205	7484.882417	7482.182915	7483.520599
224497	DOW	300	1783330200	52894.452937	52909.721471	52886.896134	52905.369645
224498	DXY	300	1783330200	101.094030	101.099650	101.068459	101.076085
223407	SP500	300	1783328400	7485.019840	7485.291550	7481.769194	7483.793822
223408	DOW	300	1783328400	52897.387896	52911.898756	52890.359204	52900.698091
223409	DXY	300	1783328400	101.103172	101.114838	101.076232	101.086606
223770	SP500	300	1783329000	7483.562981	7484.733316	7481.967985	7482.454181
223771	DOW	300	1783329000	52901.330801	52907.359419	52891.657203	52899.518634
223772	DXY	300	1783329000	101.069153	101.095401	101.060822	101.076509
225954	SP500	300	1783332900	7483.161912	7484.934661	7481.402590	7482.990358
225955	DOW	300	1783332900	52899.820195	52909.169331	52894.649892	52900.118338
225956	DXY	300	1783332900	101.127795	101.151355	101.114465	101.122663
226853	DXY	300	1783334400	101.083000	101.092223	101.060199	101.066740
226671	SP500	300	1783334100	7482.203325	7484.963330	7482.203325	7483.340885
225603	SP500	300	1783332300	7482.466356	7484.903386	7481.609761	7483.054361
225604	DOW	300	1783332300	52892.952756	52908.720181	52892.952756	52898.701527
225605	DXY	300	1783332300	101.131575	101.135662	101.108187	101.124380
225432	SP500	300	1783332000	7483.411492	7484.427691	7481.265892	7482.671096
225433	DOW	300	1783332000	52892.035384	52908.876924	52892.010868	52892.083370
225434	DXY	300	1783332000	101.102390	101.135312	101.096468	101.130712
225177	SP500	300	1783331400	7483.240000	7483.935706	7482.617639	7482.652218
225178	DOW	300	1783331400	52900.070000	52908.490746	52893.528565	52895.853418
225179	DXY	300	1783331400	101.078000	101.087600	101.069084	101.076088
226672	DOW	300	1783334100	52890.058706	52911.210329	52890.058706	52894.152509
226673	DXY	300	1783334100	101.056781	101.091438	101.046542	101.089244
226308	SP500	300	1783333500	7483.240000	7484.410599	7481.345292	7484.072066
226309	DOW	300	1783333500	52900.070000	52912.149344	52891.690148	52903.697862
226310	DXY	300	1783333500	101.087000	101.115022	101.058738	101.067638
227036	DXY	300	1783334700	101.064000	101.076730	101.047400	101.063684
226134	SP500	300	1783333200	7482.948472	7484.629884	7481.904272	7482.439601
226135	DOW	300	1783333200	52900.451219	52907.971997	52888.871576	52897.789805
226136	DXY	300	1783333200	101.122984	101.134330	101.094698	101.102445
227583	SP500	300	1783335600	7483.240000	7484.727361	7482.121553	7483.183725
227400	SP500	300	1783335300	7483.240000	7484.716429	7482.187655	7484.120829
227217	SP500	300	1783335000	7483.240000	7484.231897	7481.738650	7482.350068
227218	DOW	300	1783335000	52900.070000	52913.699806	52889.028496	52893.585198
227034	SP500	300	1783334700	7483.240000	7484.492884	7482.160414	7483.278327
227219	DXY	300	1783335000	101.062000	101.081022	101.056270	101.081022
227035	DOW	300	1783334700	52900.070000	52911.056952	52887.811352	52899.846998
227401	DOW	300	1783335300	52900.070000	52908.343892	52889.362515	52902.707752
227402	DXY	300	1783335300	101.069000	101.080944	101.061128	101.070042
227584	DOW	300	1783335600	52900.070000	52908.567342	52891.771210	52903.158102
227585	DXY	300	1783335600	101.075000	101.087361	101.057859	101.065110
227942	DXY	300	1783336200	101.064740	101.089627	101.061024	101.088177
227757	SP500	300	1783335900	7483.424808	7484.181302	7480.980930	7483.969274
227758	DOW	300	1783335900	52905.135428	52907.378256	52888.792659	52899.145654
227759	DXY	300	1783335900	101.064398	101.076642	101.046224	101.063383
228121	DOW	300	1783336500	52896.582573	52905.595420	52889.989413	52902.453077
227940	SP500	300	1783336200	7483.811337	7483.930169	7481.955543	7483.049742
227941	DOW	300	1783336200	52897.225863	52913.503300	52893.246085	52896.267365
228120	SP500	300	1783336500	7482.912676	7484.408550	7482.231360	7483.188176
231581	DXY	300	1783342200	101.096795	101.133798	101.079022	101.117473
229935	SP500	300	1783339500	7483.901316	7484.424730	7481.592144	7482.980352
229936	DOW	300	1783339500	52889.883233	52909.727782	52889.883233	52907.284963
229937	DXY	300	1783339500	101.099334	101.116057	101.080459	101.087913
228846	SP500	300	1783337700	7482.912351	7485.074233	7481.855864	7483.388749
228847	DOW	300	1783337700	52894.780124	52908.144169	52890.208780	52903.883112
228848	DXY	300	1783337700	101.081454	101.091872	101.059116	101.062382
228480	SP500	300	1783337100	7484.358596	7484.500789	7481.713832	7483.814287
228481	DOW	300	1783337100	52906.521046	52913.215004	52886.066913	52898.584757
228482	DXY	300	1783337100	101.077431	101.103508	101.065201	101.091595
232490	DXY	300	1783343700	101.114703	101.129816	101.087404	101.087606
230850	SP500	300	1783341000	7483.409922	7484.641246	7482.185100	7483.228239
230851	DOW	300	1783341000	52897.762303	52911.938908	52891.136972	52891.858572
230852	DXY	300	1783341000	101.064067	101.099606	101.061001	101.099606
230667	SP500	300	1783340700	7484.293539	7484.376432	7482.140472	7483.257491
230668	DOW	300	1783340700	52898.376075	52907.032358	52890.521260	52898.917580
230669	DXY	300	1783340700	101.066151	101.090494	101.053009	101.064478
229389	SP500	300	1783338600	7482.542111	7484.989622	7481.805355	7483.438987
229390	DOW	300	1783338600	52902.001894	52908.604521	52889.854881	52902.057728
229391	DXY	300	1783338600	101.089804	101.102484	101.076185	101.095509
232308	SP500	300	1783343400	7482.277679	7484.663861	7481.853070	7483.425449
229209	SP500	300	1783338300	7483.878088	7484.394696	7482.272253	7482.736694
229210	DOW	300	1783338300	52904.632213	52906.932940	52892.581361	52901.249208
229211	DXY	300	1783338300	101.061818	101.102071	101.056095	101.089082
229569	SP500	300	1783338900	7483.342251	7484.361396	7481.638205	7483.523256
229570	DOW	300	1783338900	52901.671860	52910.046467	52889.642981	52900.871785
229571	DXY	300	1783338900	101.093718	101.102364	101.082650	101.095125
228663	SP500	300	1783337400	7483.938385	7485.370752	7482.015027	7483.074738
228664	DOW	300	1783337400	52897.834751	52907.093800	52893.432204	52895.373136
228665	DXY	300	1783337400	101.092051	101.096913	101.064819	101.082139
228122	DXY	300	1783336500	101.089844	101.097287	101.073559	101.088326
231216	SP500	300	1783341600	7482.901233	7484.637360	7482.243545	7483.512681
231217	DOW	300	1783341600	52901.124855	52907.441176	52891.718676	52905.633054
231218	DXY	300	1783341600	101.077814	101.091478	101.060547	101.083548
229029	SP500	300	1783338000	7483.416515	7484.753229	7482.421311	7483.877444
229030	DOW	300	1783338000	52901.807259	52910.493228	52892.570849	52904.623444
229031	DXY	300	1783338000	101.061999	101.079809	101.058821	101.063206
228300	SP500	300	1783336800	7483.084192	7484.734964	7481.863807	7484.627883
228301	DOW	300	1783336800	52903.620155	52907.786709	52891.416770	52906.111865
228302	DXY	300	1783336800	101.089531	101.091918	101.065242	101.076702
232309	DOW	300	1783343400	52896.623870	52910.151626	52891.159963	52901.128457
232310	DXY	300	1783343400	101.114736	101.131442	101.101237	101.114401
230301	SP500	300	1783340100	7483.749566	7484.812873	7482.301570	7482.618022
230302	DOW	300	1783340100	52901.414372	52911.347922	52892.746579	52905.024839
230303	DXY	300	1783340100	101.062160	101.088857	101.042575	101.088857
229752	SP500	300	1783339200	7483.624653	7484.636007	7482.010633	7483.854163
229753	DOW	300	1783339200	52902.086542	52910.846980	52890.957451	52890.957451
229754	DXY	300	1783339200	101.095539	101.123716	101.092187	101.099104
232128	SP500	300	1783343100	7483.120942	7484.621329	7481.749027	7482.519902
231033	SP500	300	1783341300	7483.452745	7484.701214	7481.645332	7482.983959
230118	SP500	300	1783339800	7483.237260	7484.717775	7481.323122	7483.719158
230119	DOW	300	1783339800	52907.001623	52910.459368	52893.254031	52902.109149
230120	DXY	300	1783339800	101.089698	101.094593	101.057000	101.061639
231034	DOW	300	1783341300	52890.879889	52908.279088	52887.363219	52900.214793
231035	DXY	300	1783341300	101.098277	101.098277	101.068721	101.077340
230484	SP500	300	1783340400	7482.766518	7484.675898	7482.053776	7484.239547
230485	DOW	300	1783340400	52906.212791	52909.039400	52890.939722	52899.156480
230486	DXY	300	1783340400	101.090301	101.110045	101.065089	101.068102
232129	DOW	300	1783343100	52898.882138	52910.174002	52891.845705	52896.734063
232130	DXY	300	1783343100	101.122113	101.137484	101.097580	101.115107
231945	SP500	300	1783342800	7483.502782	7484.318688	7481.606389	7483.002984
231762	SP500	300	1783342500	7482.773542	7484.725077	7481.988131	7483.226743
231763	DOW	300	1783342500	52905.432334	52913.418969	52892.548513	52896.900910
231764	DXY	300	1783342500	101.116166	101.134995	101.101978	101.114282
231396	SP500	300	1783341900	7483.532963	7484.035162	7482.305462	7482.974443
231397	DOW	300	1783341900	52907.598217	52908.900123	52889.854432	52904.584206
231398	DXY	300	1783341900	101.082490	101.107270	101.072052	101.096333
231946	DOW	300	1783342800	52894.941251	52910.072346	52890.676181	52900.832542
231947	DXY	300	1783342800	101.114091	101.123129	101.093829	101.123129
231579	SP500	300	1783342200	7483.107292	7484.455874	7482.075240	7482.684403
231580	DOW	300	1783342200	52905.747304	52907.110887	52889.702120	52903.681693
232848	SP500	300	1783344300	7483.225451	7484.935091	7481.976068	7484.040605
232668	SP500	300	1783344000	7483.258855	7484.287230	7482.267315	7483.130071
232669	DOW	300	1783344000	52895.468407	52910.849126	52892.566925	52897.088123
232849	DOW	300	1783344300	52896.826376	52907.718857	52890.199870	52904.680670
232850	DXY	300	1783344300	101.075363	101.082615	101.042801	101.056603
233030	DXY	300	1783344600	101.055826	101.069106	101.031670	101.037244
232488	SP500	300	1783343700	7483.153510	7484.223267	7481.372886	7483.251379
232489	DOW	300	1783343700	52900.199295	52908.656452	52890.330788	52897.109928
232670	DXY	300	1783344000	101.085637	101.099473	101.056000	101.076273
233210	DXY	300	1783344900	101.039140	101.067613	101.034008	101.051874
233028	SP500	300	1783344600	7483.746024	7521.834941	7483.465935	7521.311413
233029	DOW	300	1783344600	52905.147747	53045.868354	52903.610033	53042.523590
233208	SP500	300	1783344900	7521.114900	7521.233606	7500.944245	7506.859312
233209	DOW	300	1783344900	53040.862607	53040.862607	52852.042628	52859.507112
233388	SP500	300	1783345200	7507.005540	7512.610000	7504.532520	7511.175010
233389	DOW	300	1783345200	52858.089848	52881.135404	52808.808688	52852.378163
233390	DXY	300	1783345200	101.053540	101.062178	101.037603	101.057481
233571	SP500	300	1783345500	7511.377826	7518.073064	7510.426679	7516.849174
235413	SP500	300	1783389600	7537.464023	7538.698199	7536.027821	7538.087743
235414	DOW	300	1783389600	53047.231857	53063.850581	53045.109990	53052.435488
235415	DXY	300	1783389600	100.830716	100.847784	100.798416	100.812499
233754	SP500	300	1783345800	7516.821430	7522.819651	7510.524241	7513.062147
233755	DOW	300	1783345800	52849.784058	52873.022649	52757.768399	52757.768399
233756	DXY	300	1783345800	101.061986	101.089199	101.060309	101.081028
238425	SP500	300	1783401600	7536.911625	7538.845460	7536.225687	7536.338709
237750	SP500	300	1783393500	7537.484707	7538.064951	7535.153307	7538.064951
235770	SP500	300	1783390200	7537.032969	7538.726702	7535.975737	7537.043035
235771	DOW	300	1783390200	53051.513398	53063.969614	53045.305074	53055.124783
235772	DXY	300	1783390200	100.847463	100.847463	100.811668	100.824485
236670	SP500	300	1783391700	7538.611359	7539.056795	7536.084640	7537.987525
236671	DOW	300	1783391700	53048.711489	53067.087736	53048.176797	53049.766066
235230	SP500	300	1783389300	7537.979262	7538.612522	7536.364250	7537.695316
235231	DOW	300	1783389300	53057.653417	53067.168029	53041.959056	53046.745940
235232	DXY	300	1783389300	100.880052	100.882117	100.828264	100.829155
236672	DXY	300	1783391700	100.847316	100.864821	100.833969	100.864821
234681	SP500	300	1783388400	7536.736713	7539.126441	7536.465656	7537.968187
234682	DOW	300	1783388400	53057.293226	53069.951651	53047.008122	53060.883775
233952	SP500	300	1783387200	7537.521900	7538.901295	7536.014938	7537.088298
233953	DOW	300	1783387200	53054.462988	53063.823588	53046.399110	53059.097838
233954	DXY	300	1783387200	100.891493	100.910154	100.876128	100.889876
233572	DOW	300	1783345500	52850.279423	52887.684381	52835.509909	52850.840178
233573	DXY	300	1783345500	101.058248	101.078455	101.051654	101.064055
234683	DXY	300	1783388400	100.884677	100.884684	100.805731	100.837001
234498	SP500	300	1783388100	7538.289227	7538.879115	7536.122012	7536.636599
234499	DOW	300	1783388100	53051.331599	53066.475479	53047.549239	53056.812457
234500	DXY	300	1783388100	100.895730	100.914934	100.881316	100.883611
234315	SP500	300	1783387800	7537.867009	7538.478485	7535.689885	7538.475306
234316	DOW	300	1783387800	53056.819492	53064.243989	53044.958915	53050.707835
234317	DXY	300	1783387800	100.899214	100.913051	100.881386	100.894459
237751	DOW	300	1783393500	53056.415520	53068.285759	53048.507591	53054.083039
237752	DXY	300	1783393500	100.865883	100.871235	100.858484	100.864264
234864	SP500	300	1783388700	7537.984047	7538.649280	7536.172565	7537.410526
234865	DOW	300	1783388700	53059.281509	53065.172132	53045.385323	53055.083615
234866	DXY	300	1783388700	100.837847	100.868817	100.823465	100.863198
236304	SP500	300	1783391100	7537.124330	7538.700094	7536.099773	7537.830089
236305	DOW	300	1783391100	53062.614735	53065.967476	53046.196763	53061.401774
236306	DXY	300	1783391100	100.845885	100.852828	100.819956	100.832974
233886	SP500	300	1783386900	7537.430000	7538.355553	7536.339846	7537.480110
233887	DOW	300	1783386900	53055.910000	53061.707895	53045.175950	53054.696893
233888	DXY	300	1783386900	100.895000	100.899501	100.881365	100.892614
236487	SP500	300	1783391400	7537.644331	7538.808064	7535.880664	7538.546043
234135	SP500	300	1783387500	7537.229774	7538.586705	7536.473550	7537.667406
234136	DOW	300	1783387500	53058.358865	53064.051923	53044.670110	53055.222184
234137	DXY	300	1783387500	100.888464	100.906855	100.881707	100.898457
236488	DOW	300	1783391400	53060.911547	53065.581725	53044.659103	53050.640004
236489	DXY	300	1783391400	100.831008	100.856905	100.831008	100.846572
237813	SP500	300	1783400400	7537.430000	7538.767226	7536.319552	7537.273196
237030	SP500	300	1783392300	7537.460444	7539.202890	7536.017593	7537.667318
237031	DOW	300	1783392300	53056.010905	53066.261341	53045.135043	53055.765341
235047	SP500	300	1783389000	7537.201610	7538.794174	7536.531576	7537.960443
235048	DOW	300	1783389000	53056.368180	53063.292601	53046.133246	53057.535185
235049	DXY	300	1783389000	100.863803	100.883744	100.851021	100.879257
235950	SP500	300	1783390500	7536.866895	7538.469491	7536.144640	7537.812253
235951	DOW	300	1783390500	53055.943088	53066.659114	53039.904708	53066.183202
235952	DXY	300	1783390500	100.823172	100.846921	100.805183	100.846921
235596	SP500	300	1783389900	7537.864300	7539.043454	7536.278068	7537.168063
235597	DOW	300	1783389900	53051.439815	53064.779013	53048.437165	53051.464341
235598	DXY	300	1783389900	100.814491	100.848165	100.804000	100.846351
237032	DXY	300	1783392300	100.854773	100.860294	100.834332	100.847643
236853	SP500	300	1783392000	7538.023097	7538.342412	7536.315214	7537.542371
236133	SP500	300	1783390800	7538.054974	7539.412933	7536.208930	7537.380676
236134	DOW	300	1783390800	53064.850397	53067.955987	53046.956679	53060.922784
236135	DXY	300	1783390800	100.847051	100.858922	100.832463	100.844870
236854	DOW	300	1783392000	53050.953826	53066.030954	53047.682941	53054.703925
236855	DXY	300	1783392000	100.865346	100.870902	100.845630	100.853454
237390	SP500	300	1783392900	7537.734490	7538.925389	7536.302356	7537.489067
237391	DOW	300	1783392900	53054.315248	53068.996351	53048.048541	53056.208955
237392	DXY	300	1783392900	100.860025	100.877645	100.851382	100.866136
237877	DOW	300	1783400700	53055.631248	53065.477874	53045.862712	53059.905974
237210	SP500	300	1783392600	7537.431211	7538.644812	7535.885824	7537.711455
237211	DOW	300	1783392600	53055.068801	53062.416298	53047.292724	53054.063083
237212	DXY	300	1783392600	100.849076	100.870637	100.845433	100.858914
237570	SP500	300	1783393200	7537.442301	7538.469569	7536.087021	7537.430000
237571	DOW	300	1783393200	53057.805375	53066.219911	53045.962031	53055.910000
237572	DXY	300	1783393200	100.866459	100.875678	100.854526	100.864000
238059	SP500	300	1783401000	7537.594981	7538.623105	7535.955213	7537.695672
237814	DOW	300	1783400400	53055.910000	53060.691800	53044.522506	53054.739820
237876	SP500	300	1783400700	7537.382038	7538.689950	7535.712811	7537.522941
237815	DXY	300	1783400400	100.868000	100.883517	100.854427	100.869713
237878	DXY	300	1783400700	100.867202	100.900343	100.859376	100.886783
238060	DOW	300	1783401000	53059.555450	53067.137207	53047.512610	53059.187272
238061	DXY	300	1783401000	100.884480	100.896462	100.870834	100.882751
238242	SP500	300	1783401300	7537.817454	7539.266538	7536.222122	7537.093362
238243	DOW	300	1783401300	53059.881168	53065.651302	53046.665311	53051.383115
238244	DXY	300	1783401300	100.883950	100.900119	100.870474	100.882718
238426	DOW	300	1783401600	53050.414304	53069.575402	53045.291234	53053.532280
238427	DXY	300	1783401600	100.885156	100.910311	100.872593	100.906075
240406	DOW	300	1783417500	53053.614381	53066.106395	53048.717837	53055.786077
238599	SP500	300	1783401900	7536.491580	7538.795324	7536.163856	7536.819510
238600	DOW	300	1783401900	53055.433486	53068.676118	53048.505210	53059.296979
238601	DXY	300	1783401900	100.906270	100.917323	100.892731	100.912906
240407	DXY	300	1783417500	100.946990	100.953636	100.932781	100.947381
240589	DOW	300	1783417800	53054.125231	53066.060877	53040.554375	53050.382607
240590	DXY	300	1783417800	100.946283	100.953269	100.922350	100.947862
239682	SP500	300	1783403700	7536.768656	7539.183537	7536.377448	7537.697080
239683	DOW	300	1783403700	53055.341355	53068.333078	53043.608478	53048.234203
239684	DXY	300	1783403700	100.945618	100.953263	100.933427	100.953263
239136	SP500	300	1783402800	7538.135982	7538.890341	7535.853253	7536.767849
239137	DOW	300	1783402800	53059.391812	53067.223859	53045.903641	53067.223859
239138	DXY	300	1783402800	100.932796	100.936000	100.908340	100.911936
239853	SP500	300	1783416300	7537.430000	7537.430000	7536.787843	7537.007684
239854	DOW	300	1783416300	53055.910000	53063.896561	53055.910000	53063.491748
238770	SP500	300	1783402200	7536.521039	7538.468009	7535.885445	7537.278709
238771	DOW	300	1783402200	53060.295541	53068.555169	53047.405332	53058.362502
238772	DXY	300	1783402200	100.914723	100.948122	100.914191	100.934937
239855	DXY	300	1783416300	100.944000	100.945787	100.942282	100.945500
240952	DOW	300	1783418400	53054.081527	53063.625320	53047.851271	53062.158247
240222	SP500	300	1783417200	7537.575229	7538.386204	7535.893110	7537.551722
240223	DOW	300	1783417200	53056.922680	53068.979383	53048.101285	53053.933164
240224	DXY	300	1783417200	100.944947	100.961006	100.935775	100.948397
240953	DXY	300	1783418400	100.965921	100.984451	100.958395	100.961073
239502	SP500	300	1783403400	7537.238754	7538.666629	7536.391027	7537.055599
239503	DOW	300	1783403400	53056.333811	53067.342845	53046.379995	53053.392677
239504	DXY	300	1783403400	100.932225	100.955663	100.907604	100.946981
239859	SP500	300	1783416600	7537.075048	7538.676848	7536.312410	7538.372650
239860	DOW	300	1783416600	53061.493978	53064.505314	53047.287889	53056.250428
239861	DXY	300	1783416600	100.946050	100.964960	100.939124	100.957891
238953	SP500	300	1783402500	7537.031395	7538.892672	7535.985888	7538.194766
238954	DOW	300	1783402500	53059.515281	53063.275124	53046.464952	53059.230501
238955	DXY	300	1783402500	100.933965	100.951669	100.924597	100.933690
242041	DOW	300	1783420200	53053.816284	53063.985803	53050.670363	53056.762164
241134	SP500	300	1783418700	7537.042315	7538.842372	7536.174425	7536.693135
241135	DOW	300	1783418700	53061.278525	53068.213725	53048.116579	53054.951955
241136	DXY	300	1783418700	100.958595	100.980860	100.958595	100.973038
240771	SP500	300	1783418100	7537.909822	7538.574414	7535.796002	7537.537678
240772	DOW	300	1783418100	53049.222461	53066.956412	53046.498273	53054.140521
239319	SP500	300	1783403100	7536.516790	7538.902573	7536.392224	7537.131505
239320	DOW	300	1783403100	53066.219217	53071.117244	53047.911485	53057.254668
239321	DXY	300	1783403100	100.912268	100.934744	100.906891	100.930439
240773	DXY	300	1783418100	100.948357	100.970362	100.936939	100.967301
242042	DXY	300	1783420200	100.944862	100.961250	100.938384	100.953273
240042	SP500	300	1783416900	7538.490638	7538.713822	7535.788570	7537.710318
240043	DOW	300	1783416900	53056.053111	53063.999911	53045.295325	53057.105572
240044	DXY	300	1783416900	100.958492	100.961690	100.939603	100.944241
243503	DXY	300	1783422600	100.926979	100.946990	100.919130	100.920222
242406	SP500	300	1783420800	7537.724860	7538.600598	7536.316754	7537.177566
242407	DOW	300	1783420800	53051.838846	53063.423493	53047.380256	53048.397883
242223	SP500	300	1783420500	7537.143120	7538.647707	7536.225476	7537.531775
242224	DOW	300	1783420500	53055.552113	53063.249446	53048.429725	53053.654375
242225	DXY	300	1783420500	100.951619	100.959386	100.934356	100.947504
242408	DXY	300	1783420800	100.947844	100.957562	100.926073	100.948844
241857	SP500	300	1783419900	7537.491513	7539.278456	7535.693500	7537.118616
241858	DOW	300	1783419900	53058.263201	53065.759196	53043.290849	53052.993528
241859	DXY	300	1783419900	100.961570	100.969465	100.935810	100.944993
241314	SP500	300	1783419000	7536.851144	7539.161004	7536.509257	7537.054185
241315	DOW	300	1783419000	53056.539040	53065.701660	53046.168455	53054.851359
241316	DXY	300	1783419000	100.975174	100.998821	100.969801	100.990429
240405	SP500	300	1783417500	7537.567459	7538.731806	7536.189683	7536.842194
240588	SP500	300	1783417800	7536.945334	7538.577138	7535.696360	7537.733541
241674	SP500	300	1783419600	7536.583253	7538.591184	7536.212940	7537.485859
240951	SP500	300	1783418400	7537.553228	7538.487779	7536.298273	7537.125470
241675	DOW	300	1783419600	53051.827436	53063.889910	53045.386591	53060.071268
241494	SP500	300	1783419300	7537.161304	7538.403594	7535.968846	7536.446938
241495	DOW	300	1783419300	53052.821923	53062.288850	53047.362518	53052.857894
241496	DXY	300	1783419300	100.989584	101.003711	100.962000	100.963765
241676	DXY	300	1783419600	100.966177	100.986291	100.954049	100.961343
242589	SP500	300	1783421100	7536.931256	7538.966818	7535.945167	7536.857829
242590	DOW	300	1783421100	53050.474395	53069.526349	53046.760269	53058.652644
242591	DXY	300	1783421100	100.946873	100.957786	100.924973	100.936396
242040	SP500	300	1783420200	7537.310266	7539.303996	7536.116077	7537.187635
242952	SP500	300	1783421700	7537.071053	7538.751545	7536.404567	7537.222685
242953	DOW	300	1783421700	53058.980872	53066.048128	53049.987581	53055.518661
242772	SP500	300	1783421400	7536.704597	7538.363321	7535.310103	7537.124310
242954	DXY	300	1783421700	100.943765	100.959865	100.938199	100.959865
243135	SP500	300	1783422000	7536.942299	7538.731482	7535.897835	7537.264707
243136	DOW	300	1783422000	53054.617009	53067.761882	53048.194989	53053.579184
242773	DOW	300	1783421400	53059.924927	53064.155137	53047.134728	53058.801518
242774	DXY	300	1783421400	100.934078	100.947576	100.923141	100.942545
243137	DXY	300	1783422000	100.958195	100.960348	100.931350	100.933141
243318	SP500	300	1783422300	7537.197509	7538.977915	7535.403121	7537.301906
243319	DOW	300	1783422300	53053.693694	53066.011529	53048.039765	53058.942383
243320	DXY	300	1783422300	100.932631	100.940847	100.912660	100.925835
243682	DOW	300	1783422900	53056.839973	53064.608816	53046.133249	53056.788551
243501	SP500	300	1783422600	7537.467096	7539.100765	7536.789520	7537.889811
243502	DOW	300	1783422600	53059.610403	53064.760788	53045.572802	53055.037840
243681	SP500	300	1783422900	7537.593348	7539.137090	7536.312011	7538.035004
244101	SP500	300	1786273500	7757.640000	7758.729510	7756.077340	7757.814248
244102	DOW	300	1786273500	54036.930000	54046.481186	54026.662418	54043.991242
244103	DXY	300	1786273500	99.604000	99.611216	99.592608	99.607888
244044	SP500	300	1783423500	7537.158402	7539.018247	7536.432074	7538.026977
244045	DOW	300	1783423500	53054.785436	53061.568456	53050.086770	53053.191538
244046	DXY	300	1783423500	100.922073	100.927379	100.910751	100.916461
243683	DXY	300	1783422900	100.919214	100.934579	100.912034	100.923317
243861	SP500	300	1783423200	7537.996882	7538.582421	7536.303909	7537.231884
243862	DOW	300	1783423200	53058.741398	53064.208981	53049.702113	53055.864026
243863	DXY	300	1783423200	100.923028	100.934653	100.909414	100.919699
244230	SP500	300	1786273800	7758.080864	7759.545855	7756.525919	7758.179892
244231	DOW	300	1786273800	54042.379961	54043.804326	54026.197577	54036.056155
244232	DXY	300	1786273800	99.606584	99.612681	99.594266	99.598318
\.


--
-- Data for Name: inquiries; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.inquiries (id, user_id, title, content, reply, status, replied_by, replied_at, created_at, is_reply_read) FROM stdin;
1	ecf71ed5-10b3-4ffa-8a1b-77ba52f0b97b	테스트 문의	테스트 내용	테스트 답변	answered	admin	2026-07-01 05:32:36.342814	2026-07-01 05:32:36.342814	t
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
1	4207899b-f5e9-4393-9c14-0ad0db005748	admin	127.0.0.1	curl/8.14.1	2026-04-23 01:54:30.236975
2	ecf71ed5-10b3-4ffa-8a1b-77ba52f0b97b	demo	194.114.136.45	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:152.0) Gecko/20100101 Firefox/152.0	2026-06-29 08:23:36.924911
3	4207899b-f5e9-4393-9c14-0ad0db005748	admin	127.0.0.1	curl/8.14.1	2026-06-30 07:25:24.665523
4	4207899b-f5e9-4393-9c14-0ad0db005748	admin	127.0.0.1	curl/8.14.1	2026-06-30 07:25:38.202658
5	ecf71ed5-10b3-4ffa-8a1b-77ba52f0b97b	demo	127.0.0.1	curl/8.14.1	2026-07-01 05:33:01.13587
6	ecf71ed5-10b3-4ffa-8a1b-77ba52f0b97b	demo	127.0.0.1	curl/8.14.1	2026-07-01 06:29:18.166744
\.


--
-- Data for Name: maintenance_symbols; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.maintenance_symbols (id, symbol, reason, started_at, created_by) FROM stdin;
\.


--
-- Data for Name: messages; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.messages (id, sender_id, receiver_id, title, content, is_read, deleted_for_user, created_at) FROM stdin;
\.


--
-- Data for Name: round_forced_directions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.round_forced_directions (id, symbol, duration, round_number, forced_direction, date_key, created_at) FROM stdin;
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
\.


--
-- Data for Name: transaction_requests; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.transaction_requests (id, user_id, type, amount, status, bank_name, account_holder, account_number, sender_name, admin_note, processed_by, processed_at, created_at) FROM stdin;
\.


--
-- Data for Name: user_sessions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_sessions (sid, sess, expire) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.users (id, username, password, name, phone, birth_date, resident_number, region, bank_name, account_holder, account_number, balance, total_deposit, total_withdrawal, total_bet, total_win, role, branch_code, affiliate_id, is_active, approval_status, last_login_at, last_login_ip, auto_bet_enabled, auto_bet_multiplier, is_betting_blocked, forced_bet_direction, max_execution_enabled, pending_balance_adjustment, grade, created_at, always_pending_enabled, telegram_notify_enabled) FROM stdin;
4207899b-f5e9-4393-9c14-0ad0db005748	admin	admin123	관리자	\N	\N	\N	\N	\N	\N	\N	100000000	0	0	0	0	admin	\N	\N	t	approved	2026-06-30 07:25:38.196	127.0.0.1	f	10	f	\N	f	0	브론즈	2026-04-13 02:52:58.675283	f	f
ecf71ed5-10b3-4ffa-8a1b-77ba52f0b97b	demo	demo123	데모 사용자	\N	\N	\N	\N	\N	\N	\N	10000000	0	0	0	0	user	\N	\N	t	approved	2026-07-01 06:29:18.161	127.0.0.1	f	10	f	\N	f	0	브론즈	2026-04-13 02:52:58.686371	f	f
ebe1121e-9a3b-4db5-a055-a04cd49349dd	testnotify99	test1234	알림테스트	01012345678	\N	\N	\N	국민은행	알림테스트	123456789012	0	0	0	0	0	user	\N	\N	t	pending	\N	\N	f	10	f	\N	f	0	브론즈	2026-04-23 01:54:17.978872	f	f
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

SELECT pg_catalog.setval('public.bets_id_seq', 1, false);


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

SELECT pg_catalog.setval('public.forex_candles_id_seq', 244346, true);


--
-- Name: inquiries_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.inquiries_id_seq', 2, true);


--
-- Name: inquiry_templates_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.inquiry_templates_id_seq', 1, false);


--
-- Name: login_history_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.login_history_id_seq', 6, true);


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

SELECT pg_catalog.setval('public.round_forced_directions_id_seq', 1, false);


--
-- Name: round_results_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.round_results_id_seq', 1, false);


--
-- Name: transaction_requests_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.transaction_requests_id_seq', 1, false);


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
-- Name: affiliates affiliates_referral_code_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.affiliates
    ADD CONSTRAINT affiliates_referral_code_unique UNIQUE (referral_code);


--
-- Name: affiliates affiliates_username_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.affiliates
    ADD CONSTRAINT affiliates_username_unique UNIQUE (username);


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
-- Name: blocked_ips blocked_ips_ip_address_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.blocked_ips
    ADD CONSTRAINT blocked_ips_ip_address_unique UNIQUE (ip_address);


--
-- Name: blocked_ips blocked_ips_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.blocked_ips
    ADD CONSTRAINT blocked_ips_pkey PRIMARY KEY (id);


--
-- Name: branches branches_code_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.branches
    ADD CONSTRAINT branches_code_unique UNIQUE (code);


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
-- Name: maintenance_symbols maintenance_symbols_symbol_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.maintenance_symbols
    ADD CONSTRAINT maintenance_symbols_symbol_unique UNIQUE (symbol);


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
-- Name: users users_username_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_unique UNIQUE (username);


--
-- Name: IDX_user_sessions_expire; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_user_sessions_expire" ON public.user_sessions USING btree (expire);


--
-- Name: forex_candles_symbol_duration_time_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX forex_candles_symbol_duration_time_idx ON public.forex_candles USING btree (symbol, duration, "time");


--
-- Name: bets bets_user_id_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bets
    ADD CONSTRAINT bets_user_id_users_id_fk FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: inquiries inquiries_user_id_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inquiries
    ADD CONSTRAINT inquiries_user_id_users_id_fk FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: login_history login_history_user_id_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.login_history
    ADD CONSTRAINT login_history_user_id_users_id_fk FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: messages messages_receiver_id_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_receiver_id_users_id_fk FOREIGN KEY (receiver_id) REFERENCES public.users(id);


--
-- Name: messages messages_sender_id_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_sender_id_users_id_fk FOREIGN KEY (sender_id) REFERENCES public.users(id);


--
-- Name: transaction_requests transaction_requests_user_id_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.transaction_requests
    ADD CONSTRAINT transaction_requests_user_id_users_id_fk FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- PostgreSQL database dump complete
--

\unrestrict 3Umb9Ve1n9rLvSsNgVNUyCNqvjVz4KiImKyph3hxtpbbZBo7dIrvZHggjdPv0vP

