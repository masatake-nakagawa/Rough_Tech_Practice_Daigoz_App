--
-- PostgreSQL database dump
--

-- Dumped from database version 16.3
-- Dumped by pg_dump version 16.3

-- Started on 2025-08-28 23:22:16 JST

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 222 (class 1259 OID 16491)
-- Name: attendance; Type: TABLE; Schema: public; Owner: hogeuser
--

CREATE TABLE public.attendance (
    attendance_id integer NOT NULL,
    event_id integer NOT NULL,
    user_id integer NOT NULL,
    status character varying(10) NOT NULL,
    event_name character varying(255)
);


ALTER TABLE public.attendance OWNER TO hogeuser;

--
-- TOC entry 221 (class 1259 OID 16490)
-- Name: attendance_attendance_id_seq; Type: SEQUENCE; Schema: public; Owner: hogeuser
--

CREATE SEQUENCE public.attendance_attendance_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.attendance_attendance_id_seq OWNER TO hogeuser;

--
-- TOC entry 3633 (class 0 OID 0)
-- Dependencies: 221
-- Name: attendance_attendance_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: hogeuser
--

ALTER SEQUENCE public.attendance_attendance_id_seq OWNED BY public.attendance.attendance_id;


--
-- TOC entry 218 (class 1259 OID 16460)
-- Name: event; Type: TABLE; Schema: public; Owner: hogeuser
--

CREATE TABLE public.event (
    event_id integer NOT NULL,
    event_name character varying(255) NOT NULL,
    date_and_time timestamp without time zone,
    venue character varying(255),
    text text,
    number integer
);


ALTER TABLE public.event OWNER TO hogeuser;

--
-- TOC entry 217 (class 1259 OID 16459)
-- Name: event_event_id_seq; Type: SEQUENCE; Schema: public; Owner: hogeuser
--

CREATE SEQUENCE public.event_event_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.event_event_id_seq OWNER TO hogeuser;

--
-- TOC entry 3634 (class 0 OID 0)
-- Dependencies: 217
-- Name: event_event_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: hogeuser
--

ALTER SEQUENCE public.event_event_id_seq OWNED BY public.event.event_id;


--
-- TOC entry 215 (class 1259 OID 16426)
-- Name: role; Type: TABLE; Schema: public; Owner: hogeuser
--

CREATE TABLE public.role (
    role_id integer NOT NULL,
    role_name character varying(50)
);


ALTER TABLE public.role OWNER TO hogeuser;

--
-- TOC entry 216 (class 1259 OID 16456)
-- Name: user_info; Type: TABLE; Schema: public; Owner: hogeuser
--

CREATE TABLE public.user_info (
    user_id integer,
    login_id character varying(50),
    user_name character varying(50),
    telephone character varying(20),
    password character varying(50),
    role_id integer,
    mail character varying(255)
);


ALTER TABLE public.user_info OWNER TO hogeuser;

--
-- TOC entry 220 (class 1259 OID 16484)
-- Name: users; Type: TABLE; Schema: public; Owner: hogeuser
--

CREATE TABLE public.users (
    user_id integer NOT NULL,
    user_name character varying(50) NOT NULL,
    email character varying(100) NOT NULL,
    password character varying(100) NOT NULL
);


ALTER TABLE public.users OWNER TO hogeuser;

--
-- TOC entry 219 (class 1259 OID 16483)
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: hogeuser
--

CREATE SEQUENCE public.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_user_id_seq OWNER TO hogeuser;

--
-- TOC entry 3635 (class 0 OID 0)
-- Dependencies: 219
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: hogeuser
--

ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;


--
-- TOC entry 3463 (class 2604 OID 16494)
-- Name: attendance attendance_id; Type: DEFAULT; Schema: public; Owner: hogeuser
--

ALTER TABLE ONLY public.attendance ALTER COLUMN attendance_id SET DEFAULT nextval('public.attendance_attendance_id_seq'::regclass);


--
-- TOC entry 3461 (class 2604 OID 16463)
-- Name: event event_id; Type: DEFAULT; Schema: public; Owner: hogeuser
--

ALTER TABLE ONLY public.event ALTER COLUMN event_id SET DEFAULT nextval('public.event_event_id_seq'::regclass);


--
-- TOC entry 3462 (class 2604 OID 16487)
-- Name: users user_id; Type: DEFAULT; Schema: public; Owner: hogeuser
--

ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);


--
-- TOC entry 3626 (class 0 OID 16491)
-- Dependencies: 222
-- Data for Name: attendance; Type: TABLE DATA; Schema: public; Owner: hogeuser
--

COPY public.attendance (attendance_id, event_id, user_id, status, event_name) FROM stdin;
70	1	106	参加	大東市剣道大会
74	1	106	参加	\N
78	1	106	保留	\N
82	1	106	参加	\N
86	1	106	参加	\N
\.


--
-- TOC entry 3622 (class 0 OID 16460)
-- Dependencies: 218
-- Data for Name: event; Type: TABLE DATA; Schema: public; Owner: hogeuser
--

COPY public.event (event_id, event_name, date_and_time, venue, text, number) FROM stdin;
1	大東市剣道大会	2024-09-08 09:00:00	大東市民体育館	毎年夏恒例の大東市の剣道大会が開催されます	30
2	稽古	2024-09-14 18:00:00	リージョンセンター	稽古です。	20
3	東大阪市剣道大会	2024-09-15 09:00:00	東大阪アリーナ	東大阪市の大会です。（個人戦のみ）	8
4	稽古	2024-09-21 18:00:00	リージョンセンター	稽古です。（お楽しみ会予定）	20
5	稽古	2024-09-28 18:00:00	リージョンセンター	稽古です。	20
6	全国大会	2024-10-28 09:00:00	日本武道館	全国大会です。	3
\.


--
-- TOC entry 3619 (class 0 OID 16426)
-- Dependencies: 215
-- Data for Name: role; Type: TABLE DATA; Schema: public; Owner: hogeuser
--

COPY public.role (role_id, role_name) FROM stdin;
1	管理者
2	会員
\.


--
-- TOC entry 3620 (class 0 OID 16456)
-- Dependencies: 216
-- Data for Name: user_info; Type: TABLE DATA; Schema: public; Owner: hogeuser
--

COPY public.user_info (user_id, login_id, user_name, telephone, password, role_id, mail) FROM stdin;
106	nakagawa	中川	00000000000	aaaaa	1	nakagawa@example.com
107	kamei	亀井	00000000000	aaaaa	1	kamei@example.com
108	yoshida	吉田	00000000000	aaaaa	2	yoshida@example.com
109	mure	牟禮	00000000000	aaaaa	2	mure@example.com
110	iguchi	井口	00000000000	aaaaa	2	iguchi@example.com
111	nakayama	中山	00000000000	aaaaa	2	nakayama@example.com
112	tsuneyoshi	恒吉	00000000000	aaaaa	2	tsuneyoshi@example.com
113	nakamura	中村	00000000000	aaaaa	2	nakamura@example.com
114	miyoshi	三好	00000000000	aaaaa	2	miyoshi@example.com
115	sato	佐藤	00000000000	aaaaa	2	sato@example.com
\.


--
-- TOC entry 3624 (class 0 OID 16484)
-- Dependencies: 220
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: hogeuser
--

COPY public.users (user_id, user_name, email, password) FROM stdin;
\.


--
-- TOC entry 3636 (class 0 OID 0)
-- Dependencies: 221
-- Name: attendance_attendance_id_seq; Type: SEQUENCE SET; Schema: public; Owner: hogeuser
--

SELECT pg_catalog.setval('public.attendance_attendance_id_seq', 86, true);


--
-- TOC entry 3637 (class 0 OID 0)
-- Dependencies: 217
-- Name: event_event_id_seq; Type: SEQUENCE SET; Schema: public; Owner: hogeuser
--

SELECT pg_catalog.setval('public.event_event_id_seq', 10, true);


--
-- TOC entry 3638 (class 0 OID 0)
-- Dependencies: 219
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: hogeuser
--

SELECT pg_catalog.setval('public.users_user_id_seq', 1, false);


--
-- TOC entry 3473 (class 2606 OID 16496)
-- Name: attendance attendance_pkey; Type: CONSTRAINT; Schema: public; Owner: hogeuser
--

ALTER TABLE ONLY public.attendance
    ADD CONSTRAINT attendance_pkey PRIMARY KEY (attendance_id);


--
-- TOC entry 3469 (class 2606 OID 16467)
-- Name: event event_pkey; Type: CONSTRAINT; Schema: public; Owner: hogeuser
--

ALTER TABLE ONLY public.event
    ADD CONSTRAINT event_pkey PRIMARY KEY (event_id);


--
-- TOC entry 3465 (class 2606 OID 16430)
-- Name: role role_pkey; Type: CONSTRAINT; Schema: public; Owner: hogeuser
--

ALTER TABLE ONLY public.role
    ADD CONSTRAINT role_pkey PRIMARY KEY (role_id);


--
-- TOC entry 3467 (class 2606 OID 16509)
-- Name: user_info user_info_user_id_unique; Type: CONSTRAINT; Schema: public; Owner: hogeuser
--

ALTER TABLE ONLY public.user_info
    ADD CONSTRAINT user_info_user_id_unique UNIQUE (user_id);


--
-- TOC entry 3471 (class 2606 OID 16489)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: hogeuser
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- TOC entry 3474 (class 2606 OID 24653)
-- Name: attendance attendance_event_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: hogeuser
--

ALTER TABLE ONLY public.attendance
    ADD CONSTRAINT attendance_event_id_fkey FOREIGN KEY (event_id) REFERENCES public.event(event_id);


--
-- TOC entry 3475 (class 2606 OID 16510)
-- Name: attendance attendance_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: hogeuser
--

ALTER TABLE ONLY public.attendance
    ADD CONSTRAINT attendance_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.user_info(user_id);


--
-- TOC entry 3632 (class 0 OID 0)
-- Dependencies: 5
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: pg_database_owner
--

GRANT ALL ON SCHEMA public TO hogeuser;


-- Completed on 2025-08-28 23:22:17 JST

--
-- PostgreSQL database dump complete
--

