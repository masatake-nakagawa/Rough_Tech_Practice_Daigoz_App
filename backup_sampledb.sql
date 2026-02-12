-- 1. 古いデータを削除
DROP TABLE IF EXISTS public.attendance CASCADE;
DROP TABLE IF EXISTS public.event CASCADE;
DROP TABLE IF EXISTS public.user_info CASCADE;
DROP TABLE IF EXISTS public.role CASCADE;
DROP TABLE IF EXISTS public.users CASCADE;

-- 2. テーブル作成（SERIAL型を使って自動的にシーケンスを作成します）
CREATE TABLE public.role (
    role_id integer PRIMARY KEY,
    role_name character varying(50)
);

CREATE TABLE public.user_info (
    user_id integer PRIMARY KEY,
    login_id character varying(50),
    user_name character varying(50),
    telephone character varying(20),
    password character varying(50),
    role_id integer REFERENCES public.role(role_id),
    mail character varying(255)
);

CREATE TABLE public.event (
    event_id SERIAL PRIMARY KEY, -- SERIALにすることでシーケンスが自動作成されます
    event_name character varying(255) NOT NULL,
    date_and_time timestamp without time zone,
    venue character varying(255),
    text text,
    number integer
);

CREATE TABLE public.attendance (
    attendance_id SERIAL PRIMARY KEY,
    event_id integer REFERENCES public.event(event_id),
    user_id integer REFERENCES public.user_info(user_id),
    status character varying(10) NOT NULL,
    event_name character varying(255)
);

-- 3. データの挿入
INSERT INTO public.role VALUES (1, '管理者'), (2, '会員');

INSERT INTO public.user_info VALUES 
(106, 'nakagawa', '中川', '00000000000', 'aaaaa', 1, 'nakagawa@example.com'),
(107, 'kamei', '亀井', '00000000000', 'aaaaa', 1, 'kamei@example.com'),
(108, 'yoshida', '吉田', '00000000000', 'aaaaa', 2, 'yoshida@example.com'),
(115, 'sato', '佐藤', '00000000000', 'aaaaa', 2, 'sato@example.com');

INSERT INTO public.event (event_id, event_name, date_and_time, venue, text, number) VALUES 
(1, '大東市剣道大会', '2024-09-08 09:00:00', '大東市民体育館', '大会説明', 30),
(2, '稽古', '2024-09-14 18:00:00', 'リージョンセンター', '稽古です', 20);

INSERT INTO public.attendance (attendance_id, event_id, user_id, status, event_name) VALUES 
(70, 1, 106, '参加', '大東市剣道大会');

-- 4. シーケンスの同期（SERIALによって自動作成された名前を指定）
SELECT pg_catalog.setval('public.event_event_id_seq', 10, true);
SELECT pg_catalog.setval('public.attendance_attendance_id_seq', 86, true);