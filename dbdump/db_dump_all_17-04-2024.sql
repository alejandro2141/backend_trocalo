--
-- PostgreSQL database cluster dump
--

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

--
-- Roles
--

CREATE ROLE conmeddb_user;
ALTER ROLE conmeddb_user WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS PASSWORD 'SCRAM-SHA-256$4096:TJjjPDZFfjDFT+fplGI38Q==$NPUGiZXPLtcSLL40Uz8ukPtRltHgWsfKNveFC1F+PjA=:XqyGyMyhfulbWRTz1Kdpk7kJI77GEfU/YXe3WvF49m4=';
CREATE ROLE postgres;
ALTER ROLE postgres WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION BYPASSRLS PASSWORD 'md581b8b476018b2034ebf8cc2396b697cd';
CREATE ROLE trocalo_user;
ALTER ROLE trocalo_user WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION NOBYPASSRLS PASSWORD 'md5e09a022e12aa91ba98fcb18c571e2ade';






--
-- Databases
--

--
-- Database "template1" dump
--

\connect template1

--
-- PostgreSQL database dump
--

-- Dumped from database version 12.18 (Ubuntu 12.18-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.18 (Ubuntu 12.18-0ubuntu0.20.04.1)

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

--
-- PostgreSQL database dump complete
--

--
-- Database "conmeddb01" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 12.18 (Ubuntu 12.18-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.18 (Ubuntu 12.18-0ubuntu0.20.04.1)

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

--
-- Name: conmeddb01; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE conmeddb01 WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.UTF-8' LC_CTYPE = 'en_US.UTF-8';


ALTER DATABASE conmeddb01 OWNER TO postgres;

\connect conmeddb01

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
-- Name: appointments; Type: TABLE; Schema: public; Owner: conmeddb_user
--

CREATE TABLE public.appointments (
    appointment_id integer NOT NULL,
    appointment_date date,
    appointment_start_time time with time zone,
    appointment_specialty text,
    appointment_is_public boolean DEFAULT true,
    appointment_agenda_id bigint,
    appointment_patient_name text,
    reserve_patient_doc_id text,
    reserve_patient_age text,
    reserve_available boolean,
    reserve_patient_email text,
    reserve_patient_phone text,
    reserve_patient_insurance integer,
    end_time time with time zone,
    duration integer,
    reserve_status integer,
    blocked boolean
);


ALTER TABLE public.appointments OWNER TO conmeddb_user;

--
-- Name: appointment2_id_seq; Type: SEQUENCE; Schema: public; Owner: conmeddb_user
--

CREATE SEQUENCE public.appointment2_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.appointment2_id_seq OWNER TO conmeddb_user;

--
-- Name: appointment2_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: conmeddb_user
--

ALTER SEQUENCE public.appointment2_id_seq OWNED BY public.appointments.appointment_id;


--
-- Name: appointment2_reserve_patient_phone_seq; Type: SEQUENCE; Schema: public; Owner: conmeddb_user
--

CREATE SEQUENCE public.appointment2_reserve_patient_phone_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.appointment2_reserve_patient_phone_seq OWNER TO conmeddb_user;

--
-- Name: appointment2_reserve_patient_phone_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: conmeddb_user
--

ALTER SEQUENCE public.appointment2_reserve_patient_phone_seq OWNED BY public.appointments.reserve_patient_phone;


--
-- Name: assistant_professional; Type: TABLE; Schema: public; Owner: conmeddb_user
--

CREATE TABLE public.assistant_professional (
    id integer NOT NULL,
    assistant_id integer,
    professional_id integer
);


ALTER TABLE public.assistant_professional OWNER TO conmeddb_user;

--
-- Name: assistant_professional_id_seq; Type: SEQUENCE; Schema: public; Owner: conmeddb_user
--

CREATE SEQUENCE public.assistant_professional_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.assistant_professional_id_seq OWNER TO conmeddb_user;

--
-- Name: assistant_professional_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: conmeddb_user
--

ALTER SEQUENCE public.assistant_professional_id_seq OWNED BY public.assistant_professional.id;


--
-- Name: assistants; Type: TABLE; Schema: public; Owner: conmeddb_user
--

CREATE TABLE public.assistants (
    id integer NOT NULL,
    name text,
    document_id text,
    phone1 text,
    phone2 text,
    address1 text,
    address2 text,
    email text,
    pass text,
    country text
);


ALTER TABLE public.assistants OWNER TO conmeddb_user;

--
-- Name: assistants_id_seq; Type: SEQUENCE; Schema: public; Owner: conmeddb_user
--

CREATE SEQUENCE public.assistants_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.assistants_id_seq OWNER TO conmeddb_user;

--
-- Name: assistants_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: conmeddb_user
--

ALTER SEQUENCE public.assistants_id_seq OWNED BY public.assistants.id;


--
-- Name: bookings; Type: TABLE; Schema: public; Owner: conmeddb_user
--

CREATE TABLE public.bookings (
    booking_id bigint NOT NULL,
    booking_name text,
    booking_phone text,
    booking_email text,
    booking_doc_id text,
    booking_age integer,
    booking_insurance integer
);


ALTER TABLE public.bookings OWNER TO conmeddb_user;

--
-- Name: bookings_booking_id_seq; Type: SEQUENCE; Schema: public; Owner: conmeddb_user
--

CREATE SEQUENCE public.bookings_booking_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.bookings_booking_id_seq OWNER TO conmeddb_user;

--
-- Name: bookings_booking_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: conmeddb_user
--

ALTER SEQUENCE public.bookings_booking_id_seq OWNED BY public.bookings.booking_id;


--
-- Name: center_professional; Type: TABLE; Schema: public; Owner: conmeddb_user
--

CREATE TABLE public.center_professional (
    id integer NOT NULL,
    center_id bigint,
    professional_id bigint
);


ALTER TABLE public.center_professional OWNER TO conmeddb_user;

--
-- Name: center_professional_id_seq; Type: SEQUENCE; Schema: public; Owner: conmeddb_user
--

CREATE SEQUENCE public.center_professional_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.center_professional_id_seq OWNER TO conmeddb_user;

--
-- Name: center_professional_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: conmeddb_user
--

ALTER SEQUENCE public.center_professional_id_seq OWNED BY public.center_professional.id;


--
-- Name: centers; Type: TABLE; Schema: public; Owner: conmeddb_user
--

CREATE TABLE public.centers (
    id integer NOT NULL,
    name text,
    address text,
    phone1 text,
    phone2 text,
    verified boolean,
    status integer
);


ALTER TABLE public.centers OWNER TO conmeddb_user;

--
-- Name: centers_id_seq; Type: SEQUENCE; Schema: public; Owner: conmeddb_user
--

CREATE SEQUENCE public.centers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.centers_id_seq OWNER TO conmeddb_user;

--
-- Name: centers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: conmeddb_user
--

ALTER SEQUENCE public.centers_id_seq OWNED BY public.centers.id;


--
-- Name: professionals; Type: TABLE; Schema: public; Owner: conmeddb_user
--

CREATE TABLE public.professionals (
    id integer NOT NULL,
    name text,
    document_id text,
    phone1 text,
    phone2 text,
    address1 text,
    address2 text,
    email text,
    pass text,
    country text
);


ALTER TABLE public.professionals OWNER TO conmeddb_user;

--
-- Name: professionals_id_seq; Type: SEQUENCE; Schema: public; Owner: conmeddb_user
--

CREATE SEQUENCE public.professionals_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.professionals_id_seq OWNER TO conmeddb_user;

--
-- Name: professionals_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: conmeddb_user
--

ALTER SEQUENCE public.professionals_id_seq OWNED BY public.professionals.id;


--
-- Name: specialties; Type: TABLE; Schema: public; Owner: conmeddb_user
--

CREATE TABLE public.specialties (
    id integer NOT NULL,
    specialty_name text NOT NULL,
    specialty_description text
);


ALTER TABLE public.specialties OWNER TO conmeddb_user;

--
-- Name: specialties_id_seq; Type: SEQUENCE; Schema: public; Owner: conmeddb_user
--

CREATE SEQUENCE public.specialties_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.specialties_id_seq OWNER TO conmeddb_user;

--
-- Name: specialties_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: conmeddb_user
--

ALTER SEQUENCE public.specialties_id_seq OWNED BY public.specialties.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: conmeddb_user
--

CREATE TABLE public.users (
    id integer NOT NULL,
    username text,
    password text,
    email text,
    phone text,
    role_assistant boolean,
    user_id integer,
    user_type integer
);


ALTER TABLE public.users OWNER TO conmeddb_user;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: conmeddb_user
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO conmeddb_user;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: conmeddb_user
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: appointments appointment_id; Type: DEFAULT; Schema: public; Owner: conmeddb_user
--

ALTER TABLE ONLY public.appointments ALTER COLUMN appointment_id SET DEFAULT nextval('public.appointment2_id_seq'::regclass);


--
-- Name: assistant_professional id; Type: DEFAULT; Schema: public; Owner: conmeddb_user
--

ALTER TABLE ONLY public.assistant_professional ALTER COLUMN id SET DEFAULT nextval('public.assistant_professional_id_seq'::regclass);


--
-- Name: assistants id; Type: DEFAULT; Schema: public; Owner: conmeddb_user
--

ALTER TABLE ONLY public.assistants ALTER COLUMN id SET DEFAULT nextval('public.assistants_id_seq'::regclass);


--
-- Name: bookings booking_id; Type: DEFAULT; Schema: public; Owner: conmeddb_user
--

ALTER TABLE ONLY public.bookings ALTER COLUMN booking_id SET DEFAULT nextval('public.bookings_booking_id_seq'::regclass);


--
-- Name: center_professional id; Type: DEFAULT; Schema: public; Owner: conmeddb_user
--

ALTER TABLE ONLY public.center_professional ALTER COLUMN id SET DEFAULT nextval('public.center_professional_id_seq'::regclass);


--
-- Name: centers id; Type: DEFAULT; Schema: public; Owner: conmeddb_user
--

ALTER TABLE ONLY public.centers ALTER COLUMN id SET DEFAULT nextval('public.centers_id_seq'::regclass);


--
-- Name: professionals id; Type: DEFAULT; Schema: public; Owner: conmeddb_user
--

ALTER TABLE ONLY public.professionals ALTER COLUMN id SET DEFAULT nextval('public.professionals_id_seq'::regclass);


--
-- Name: specialties id; Type: DEFAULT; Schema: public; Owner: conmeddb_user
--

ALTER TABLE ONLY public.specialties ALTER COLUMN id SET DEFAULT nextval('public.specialties_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: conmeddb_user
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: appointments; Type: TABLE DATA; Schema: public; Owner: conmeddb_user
--

COPY public.appointments (appointment_id, appointment_date, appointment_start_time, appointment_specialty, appointment_is_public, appointment_agenda_id, appointment_patient_name, reserve_patient_doc_id, reserve_patient_age, reserve_available, reserve_patient_email, reserve_patient_phone, reserve_patient_insurance, end_time, duration, reserve_status, blocked) FROM stdin;
105	2021-04-20	00:30:00-04	Pediatria	t	77	niñogonzales apellido	303003300	\N	f	soyniñopediatria@email.com	88784744	1	01:00:00-04	30	\N	\N
107	2021-04-20	00:15:00-04	Oftalmologia	t	77	\N	\N	\N	t	\N	\N	\N	00:30:00-04	15	\N	\N
108	2021-04-20	00:30:00-04	Oftalmologia	t	77	\N	\N	\N	t	\N	\N	\N	00:45:00-04	15	\N	\N
109	2021-04-20	00:45:00-04	Oftalmologia	t	77	\N	\N	\N	t	\N	\N	\N	01:00:00-04	15	\N	\N
110	2021-04-20	01:00:00-04	Oftalmologia	t	77	\N	\N	\N	t	\N	\N	\N	01:15:00-04	15	\N	\N
111	2021-04-20	01:15:00-04	Oftalmologia	t	77	\N	\N	\N	t	\N	\N	\N	01:30:00-04	15	\N	\N
112	2021-04-20	01:30:00-04	Oftalmologia	t	77	\N	\N	\N	t	\N	\N	\N	01:45:00-04	15	\N	\N
113	2021-04-20	01:45:00-04	Oftalmologia	t	77	\N	\N	\N	t	\N	\N	\N	02:00:00-04	15	\N	\N
114	2021-04-20	02:00:00-04	Oftalmologia	t	77	\N	\N	\N	t	\N	\N	\N	02:15:00-04	15	\N	\N
106	2021-04-20	00:00:00-04	Oftalmologia	t	77	Aajsj	6667	\N	f	Hdhdhd	7666	3	00:15:00-04	15	\N	\N
104	2021-04-20	00:00:00-04	Oftalmologia	t	77	aaaaaaaaaaaaa	13333333333333333	\N	f	aaaaaaaaa@aaaaaaaaaaaa.cl	444444444444444	2	00:30:00-04	30	1	t
115	2021-04-20	02:15:00-04	Oftalmologia	t	77	Alejandeo	Eyeyeh	\N	f	Bdjddjj	7667	1	02:30:00-04	15	\N	\N
116	2021-04-21	01:00:00-04	Urologia	t	76	\N	\N	\N	t	\N	\N	\N	01:30:00-04	30	\N	\N
\.


--
-- Data for Name: assistant_professional; Type: TABLE DATA; Schema: public; Owner: conmeddb_user
--

COPY public.assistant_professional (id, assistant_id, professional_id) FROM stdin;
2	2	2
1	1	2
\.


--
-- Data for Name: assistants; Type: TABLE DATA; Schema: public; Owner: conmeddb_user
--

COPY public.assistants (id, name, document_id, phone1, phone2, address1, address2, email, pass, country) FROM stdin;
1	Rosita Asistente del Doc	13909371-3	7774729	7354333	Pasaje3, la cisterna, Santiago RM Chile		rosita	rosita	cl
2	Julia Recepcionista del doc	1399999-2	54345345	1123123	Los Manantiales 132, Renca, Santiago, RM, Chile 		julia	julia	cl
\.


--
-- Data for Name: bookings; Type: TABLE DATA; Schema: public; Owner: conmeddb_user
--

COPY public.bookings (booking_id, booking_name, booking_phone, booking_email, booking_doc_id, booking_age, booking_insurance) FROM stdin;
\.


--
-- Data for Name: center_professional; Type: TABLE DATA; Schema: public; Owner: conmeddb_user
--

COPY public.center_professional (id, center_id, professional_id) FROM stdin;
1	1	1
2	2	1
3	1	1
4	1	1
5	82	1
6	83	99
7	84	2
8	85	2
9	86	2
10	87	2
11	88	2
12	89	2
13	90	2
14	91	2
15	92	2
16	93	2
17	94	2
18	95	2
19	96	2
20	97	2
21	98	2
22	99	2
23	100	2
24	101	2
25	102	2
26	103	2
27	104	2
28	105	2
29	106	2
30	107	2
31	108	2
32	109	2
33	110	2
34	111	2
35	112	2
36	113	2
37	114	2
38	115	2
39	116	2
40	117	2
41	118	2
42	119	2
43	120	2
44	121	2
45	122	2
46	123	2
47	124	2
48	125	2
49	126	2
50	127	2
51	128	2
52	129	2
53	130	2
54	131	2
55	132	2
56	133	2
57	134	2
58	135	2
59	136	2
60	137	2
61	138	2
62	139	2
63	140	2
64	141	2
65	142	2
66	143	2
67	144	2
68	145	2
69	146	2
70	147	2
71	148	2
72	149	1
73	150	2
74	151	2
75	152	2
76	153	2
77	154	2
78	155	2
1	1	1
2	2	1
3	1	1
4	1	1
5	82	1
6	83	99
7	84	2
8	85	2
9	86	2
10	87	2
11	88	2
12	89	2
13	90	2
14	91	2
15	92	2
16	93	2
17	94	2
18	95	2
19	96	2
20	97	2
21	98	2
22	99	2
23	100	2
24	101	2
25	102	2
26	103	2
27	104	2
28	105	2
29	106	2
30	107	2
31	108	2
32	109	2
33	110	2
34	111	2
35	112	2
36	113	2
37	114	2
38	115	2
39	116	2
40	117	2
41	118	2
42	119	2
43	120	2
44	121	2
45	122	2
46	123	2
47	124	2
48	125	2
49	126	2
50	127	2
51	128	2
52	129	2
53	130	2
54	131	2
55	132	2
56	133	2
57	134	2
58	135	2
59	136	2
60	137	2
61	138	2
62	139	2
63	140	2
64	141	2
65	142	2
66	143	2
67	144	2
68	145	2
69	146	2
70	147	2
71	148	2
72	149	1
73	150	2
74	151	2
75	152	2
76	153	2
77	154	2
78	155	2
1	1	1
2	2	1
3	1	1
4	1	1
5	82	1
6	83	99
7	84	2
8	85	2
9	86	2
10	87	2
11	88	2
12	89	2
13	90	2
14	91	2
15	92	2
16	93	2
17	94	2
18	95	2
19	96	2
20	97	2
21	98	2
22	99	2
23	100	2
24	101	2
25	102	2
26	103	2
27	104	2
28	105	2
29	106	2
30	107	2
31	108	2
32	109	2
33	110	2
34	111	2
35	112	2
36	113	2
37	114	2
38	115	2
39	116	2
40	117	2
41	118	2
42	119	2
43	120	2
44	121	2
45	122	2
46	123	2
47	124	2
48	125	2
49	126	2
50	127	2
51	128	2
52	129	2
53	130	2
54	131	2
55	132	2
56	133	2
57	134	2
58	135	2
59	136	2
60	137	2
61	138	2
62	139	2
63	140	2
64	141	2
65	142	2
66	143	2
67	144	2
68	145	2
69	146	2
70	147	2
71	148	2
72	149	1
73	150	2
74	151	2
75	152	2
76	153	2
77	154	2
78	155	2
1	1	1
2	2	1
3	1	1
4	1	1
5	82	1
6	83	99
7	84	2
8	85	2
9	86	2
10	87	2
11	88	2
12	89	2
13	90	2
14	91	2
15	92	2
16	93	2
17	94	2
18	95	2
19	96	2
20	97	2
21	98	2
22	99	2
23	100	2
24	101	2
25	102	2
26	103	2
27	104	2
28	105	2
29	106	2
30	107	2
31	108	2
32	109	2
33	110	2
34	111	2
35	112	2
36	113	2
37	114	2
38	115	2
39	116	2
40	117	2
41	118	2
42	119	2
43	120	2
44	121	2
45	122	2
46	123	2
47	124	2
48	125	2
49	126	2
50	127	2
51	128	2
52	129	2
53	130	2
54	131	2
55	132	2
56	133	2
57	134	2
58	135	2
59	136	2
60	137	2
61	138	2
62	139	2
63	140	2
64	141	2
65	142	2
66	143	2
67	144	2
68	145	2
69	146	2
70	147	2
71	148	2
72	149	1
73	150	2
74	151	2
75	152	2
76	153	2
77	154	2
78	155	2
1	1	1
2	2	1
3	1	1
4	1	1
5	82	1
6	83	99
7	84	2
8	85	2
9	86	2
10	87	2
11	88	2
12	89	2
13	90	2
14	91	2
15	92	2
16	93	2
17	94	2
18	95	2
19	96	2
20	97	2
21	98	2
22	99	2
23	100	2
24	101	2
25	102	2
26	103	2
27	104	2
28	105	2
29	106	2
30	107	2
31	108	2
32	109	2
33	110	2
34	111	2
35	112	2
36	113	2
37	114	2
38	115	2
39	116	2
40	117	2
41	118	2
42	119	2
43	120	2
44	121	2
45	122	2
46	123	2
47	124	2
48	125	2
49	126	2
50	127	2
51	128	2
52	129	2
53	130	2
54	131	2
55	132	2
56	133	2
57	134	2
58	135	2
59	136	2
60	137	2
61	138	2
62	139	2
63	140	2
64	141	2
65	142	2
66	143	2
67	144	2
68	145	2
69	146	2
70	147	2
71	148	2
72	149	1
73	150	2
74	151	2
75	152	2
76	153	2
77	154	2
78	155	2
1	1	1
2	2	1
3	1	1
4	1	1
5	82	1
6	83	99
7	84	2
8	85	2
9	86	2
10	87	2
11	88	2
12	89	2
13	90	2
14	91	2
15	92	2
16	93	2
17	94	2
18	95	2
19	96	2
20	97	2
21	98	2
22	99	2
23	100	2
24	101	2
25	102	2
26	103	2
27	104	2
28	105	2
29	106	2
30	107	2
31	108	2
32	109	2
33	110	2
34	111	2
35	112	2
36	113	2
37	114	2
38	115	2
39	116	2
40	117	2
41	118	2
42	119	2
43	120	2
44	121	2
45	122	2
46	123	2
47	124	2
48	125	2
49	126	2
50	127	2
51	128	2
52	129	2
53	130	2
54	131	2
55	132	2
56	133	2
57	134	2
58	135	2
59	136	2
60	137	2
61	138	2
62	139	2
63	140	2
64	141	2
65	142	2
66	143	2
67	144	2
68	145	2
69	146	2
70	147	2
71	148	2
72	149	1
73	150	2
74	151	2
75	152	2
76	153	2
77	154	2
78	155	2
1	1	1
2	2	1
3	1	1
4	1	1
5	82	1
6	83	99
7	84	2
8	85	2
9	86	2
10	87	2
11	88	2
12	89	2
13	90	2
14	91	2
15	92	2
16	93	2
17	94	2
18	95	2
19	96	2
20	97	2
21	98	2
22	99	2
23	100	2
24	101	2
25	102	2
26	103	2
27	104	2
28	105	2
29	106	2
30	107	2
31	108	2
32	109	2
33	110	2
34	111	2
35	112	2
36	113	2
37	114	2
38	115	2
39	116	2
40	117	2
41	118	2
42	119	2
43	120	2
44	121	2
45	122	2
46	123	2
47	124	2
48	125	2
49	126	2
50	127	2
51	128	2
52	129	2
53	130	2
54	131	2
55	132	2
56	133	2
57	134	2
58	135	2
59	136	2
60	137	2
61	138	2
62	139	2
63	140	2
64	141	2
65	142	2
66	143	2
67	144	2
68	145	2
69	146	2
70	147	2
71	148	2
72	149	1
73	150	2
74	151	2
75	152	2
76	153	2
77	154	2
78	155	2
1	1	1
2	2	1
3	1	1
4	1	1
5	82	1
6	83	99
7	84	2
8	85	2
9	86	2
10	87	2
11	88	2
12	89	2
13	90	2
14	91	2
15	92	2
16	93	2
17	94	2
18	95	2
19	96	2
20	97	2
21	98	2
22	99	2
23	100	2
24	101	2
25	102	2
26	103	2
27	104	2
28	105	2
29	106	2
30	107	2
31	108	2
32	109	2
33	110	2
34	111	2
35	112	2
36	113	2
37	114	2
38	115	2
39	116	2
40	117	2
41	118	2
42	119	2
43	120	2
44	121	2
45	122	2
46	123	2
47	124	2
48	125	2
49	126	2
50	127	2
51	128	2
52	129	2
53	130	2
54	131	2
55	132	2
56	133	2
57	134	2
58	135	2
59	136	2
60	137	2
61	138	2
62	139	2
63	140	2
64	141	2
65	142	2
66	143	2
67	144	2
68	145	2
69	146	2
70	147	2
71	148	2
72	149	1
73	150	2
74	151	2
75	152	2
76	153	2
77	154	2
78	155	2
1	1	1
2	2	1
3	1	1
4	1	1
5	82	1
6	83	99
7	84	2
8	85	2
9	86	2
10	87	2
11	88	2
12	89	2
13	90	2
14	91	2
15	92	2
16	93	2
17	94	2
18	95	2
19	96	2
20	97	2
21	98	2
22	99	2
23	100	2
24	101	2
25	102	2
26	103	2
27	104	2
28	105	2
29	106	2
30	107	2
31	108	2
32	109	2
33	110	2
34	111	2
35	112	2
36	113	2
37	114	2
38	115	2
39	116	2
40	117	2
41	118	2
42	119	2
43	120	2
44	121	2
45	122	2
46	123	2
47	124	2
48	125	2
49	126	2
50	127	2
51	128	2
52	129	2
53	130	2
54	131	2
55	132	2
56	133	2
57	134	2
58	135	2
59	136	2
60	137	2
61	138	2
62	139	2
63	140	2
64	141	2
65	142	2
66	143	2
67	144	2
68	145	2
69	146	2
70	147	2
71	148	2
72	149	1
73	150	2
74	151	2
75	152	2
76	153	2
77	154	2
78	155	2
1	1	1
2	2	1
3	1	1
4	1	1
5	82	1
6	83	99
7	84	2
8	85	2
9	86	2
10	87	2
11	88	2
12	89	2
13	90	2
14	91	2
15	92	2
16	93	2
17	94	2
18	95	2
19	96	2
20	97	2
21	98	2
22	99	2
23	100	2
24	101	2
25	102	2
26	103	2
27	104	2
28	105	2
29	106	2
30	107	2
31	108	2
32	109	2
33	110	2
34	111	2
35	112	2
36	113	2
37	114	2
38	115	2
39	116	2
40	117	2
41	118	2
42	119	2
43	120	2
44	121	2
45	122	2
46	123	2
47	124	2
48	125	2
49	126	2
50	127	2
51	128	2
52	129	2
53	130	2
54	131	2
55	132	2
56	133	2
57	134	2
58	135	2
59	136	2
60	137	2
61	138	2
62	139	2
63	140	2
64	141	2
65	142	2
66	143	2
67	144	2
68	145	2
69	146	2
70	147	2
71	148	2
72	149	1
73	150	2
74	151	2
75	152	2
76	153	2
77	154	2
78	155	2
\.


--
-- Data for Name: centers; Type: TABLE DATA; Schema: public; Owner: conmeddb_user
--

COPY public.centers (id, name, address, phone1, phone2, verified, status) FROM stdin;
1	Urologos Asociados	Avenida los Dominicos 1535, Oficina 1503, Providencia Santiago Chile. 	7778787	1231231233	\N	\N
2	Centro de Salud Privado	Avenida Gran Avenida, 2361, Oficina 9123, San Miguel, RM Chile	12121221	232332323	\N	\N
83	aaaaaa	bbbbbb	33333333333333	undefined	\N	\N
84	vvvvvv	bbbbbbbbbb	999999999999999	undefined	\N	\N
85	vvvvvv	bbbbbbbbbb	999999999999999	undefined	\N	\N
86	vvvvvv	bbbbbbbbbb	999999999999999	undefined	\N	\N
87	rrrrrrrrr	ttttt	777777777777	undefined	\N	\N
88	aaaa	eeeeeee	55555	undefined	\N	\N
89	aaaa	eeeeeee	55555	undefined	\N	\N
90	palqueleenombre	avenidapalquelee	69000069	undefined	\N	\N
91	queqeno	uennaneno	00019991	undefined	\N	\N
92	wwwwwwwwwwww	eeeeeeeeeeee	999999999999	undefined	\N	\N
93	hhhhhh	oooooooooo	00000000000	undefined	\N	\N
94	estoesunnuvocentroNombre	Avenicad las condes 9876,Providencia, Santiago RM Chile	56565656	undefined	\N	\N
95	aaa	bbb	66666	undefined	\N	\N
96	null	null	null	undefined	\N	\N
97	rrr	eee	www	undefined	\N	\N
98	rrr	eee	www	undefined	\N	\N
99	rrr	eee	www	undefined	\N	\N
100	asd	asd	asd	undefined	\N	\N
101	rtrtr	rtrtrt	rtrtrt	undefined	\N	\N
102	rtrtr	rtrtrt	rtrtrt	undefined	\N	\N
103	ooo	oooo	oooooo	undefined	\N	\N
104	ooo	oooo	oooooo	undefined	\N	\N
105	ooo	oooo	oooooo	undefined	\N	\N
106	ooo	oooo	oooooo	undefined	\N	\N
107	ooo	oooo	oooooo	undefined	\N	\N
108	ooo	oooo	oooooo	undefined	\N	\N
109	ooo	oooo	oooooo	undefined	\N	\N
110	ooo	oooo	oooooo	undefined	\N	\N
111	ooo	oooo	oooooo	undefined	\N	\N
112	TTT	TTT	TTT	undefined	\N	\N
113	yyyy	yyy	yyy	undefined	\N	\N
114	iiiii	iiiiii	iiiiiiiiiiii	undefined	\N	\N
115	pppp	ppppp	pppppp	undefined	\N	\N
116	aaaaaaaa	aaaaaaaaaaa	aaaaaaaaaaa	undefined	\N	\N
117	aaaaaaaa	aaaaaaaaaaa	aaaaaaaaaaa	undefined	\N	\N
118	null	null	null	undefined	\N	\N
119	aaaa	null	null	undefined	\N	\N
120	aaaa	null	null	undefined	\N	\N
121	bbb	bbb	bbbb	undefined	\N	\N
122	null	null	null	undefined	\N	\N
123	null	null	null	undefined	\N	\N
124	null	null	null	undefined	\N	\N
125	aaa	aaa	aaa	undefined	\N	\N
126	aaa	eee	fff	undefined	\N	\N
127	tttt	aasdf	asdf	undefined	\N	\N
128	tt	tt	tt	undefined	\N	\N
129	tt	tt	tt	undefined	\N	\N
130	bbbb	bbbb	bbbb	undefined	\N	\N
131	bbbb	bbbb	bbbb	undefined	\N	\N
132	bbbb	bbbb	bbbb	undefined	\N	\N
133	bbbb	bbbb	bbbb	undefined	\N	\N
134	gggg	ggggggg	gggggggg	undefined	\N	\N
135	gggg	ggggggg	gggggggg	undefined	\N	\N
136	null	null	null	undefined	\N	\N
137	yyy	yyyy	yyyyyyyy	undefined	\N	\N
138	null	null	null	undefined	\N	\N
139	null	null	null	undefined	\N	\N
140	null	null	null	undefined	\N	\N
141	null	null	null	undefined	\N	\N
142	BBBB	BBBBBBBB	BBBBBB	undefined	\N	\N
143	AAA	AAA	AAA	undefined	\N	\N
144	ccc	ccc	cccc	undefined	\N	\N
145	aa	aaa	aaaaa	undefined	\N	\N
146	ttt	ttttt	ttttttttt	undefined	\N	\N
147	null	null	null	undefined	\N	\N
148	Centro de Salud Las carmelitas	Av Providencia 123, oficina 1212, Providencia RM Santiago Chile. 	7354333	undefined	\N	\N
149	Clinica Davila	Av Recoleta 1505, Recoleta Santiago RM,  Edificio H, Piso 6 oficina 234	121212	undefined	\N	\N
150	Cento de salud Emergencias Independencia	Avenida Independencia 1212, oficina 56623, Independencia RM. 	777765656	undefined	\N	\N
151	asdf	32423	556767	undefined	\N	\N
152	Clinica Urgencia Recoleta.	Av Recoleta 1231, oficina 213, Recoleta Santiago Chile	4324324	undefined	\N	\N
153	Consulta Privada	Tristan Cornejo 957, Independencia. 	75397200	undefined	\N	\N
154	Hogar	Virtual	77774455	undefined	\N	\N
155	Clinica davila	Recoleta 2334, edificio H	6667766	undefined	\N	\N
\.


--
-- Data for Name: professionals; Type: TABLE DATA; Schema: public; Owner: conmeddb_user
--

COPY public.professionals (id, name, document_id, phone1, phone2, address1, address2, email, pass, country) FROM stdin;
1	Dr Chapatin Gonalez Sanito SinDolor	13909371-2	7778987	123123123	MancoCapac 1670 Independencia Santiago RM. 		bbb	bbb	
2	Doggy House Medico	11111-9	345345345		Los Maitenes de Nebrasca 1212, Dpto 3030, RM Santiago Chile. 		aaa	aaa	
\.


--
-- Data for Name: specialties; Type: TABLE DATA; Schema: public; Owner: conmeddb_user
--

COPY public.specialties (id, specialty_name, specialty_description) FROM stdin;
1	oftalmologia	especialidad ocular
2	geriatria	especialidad ancianos
3	pediatria	especialidad niños
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: conmeddb_user
--

COPY public.users (id, username, password, email, phone, role_assistant, user_id, user_type) FROM stdin;
1	Rosita de los Rosales Rosas Rojas	abc	rosita@nada.cl	56 9 75397201	t	\N	\N
2	Pedro Asistente de Salud 	ppp	alejandro2141@gmail.com	56 9 7354333	f	\N	\N
3	aaa	aaa	aaa	777	\N	3	\N
4	Queen la Mujer que Cura	bbb	bbb	777888777	f	4	3
\.


--
-- Name: appointment2_id_seq; Type: SEQUENCE SET; Schema: public; Owner: conmeddb_user
--

SELECT pg_catalog.setval('public.appointment2_id_seq', 116, true);


--
-- Name: appointment2_reserve_patient_phone_seq; Type: SEQUENCE SET; Schema: public; Owner: conmeddb_user
--

SELECT pg_catalog.setval('public.appointment2_reserve_patient_phone_seq', 2, true);


--
-- Name: assistant_professional_id_seq; Type: SEQUENCE SET; Schema: public; Owner: conmeddb_user
--

SELECT pg_catalog.setval('public.assistant_professional_id_seq', 2, true);


--
-- Name: assistants_id_seq; Type: SEQUENCE SET; Schema: public; Owner: conmeddb_user
--

SELECT pg_catalog.setval('public.assistants_id_seq', 2, true);


--
-- Name: bookings_booking_id_seq; Type: SEQUENCE SET; Schema: public; Owner: conmeddb_user
--

SELECT pg_catalog.setval('public.bookings_booking_id_seq', 1, false);


--
-- Name: center_professional_id_seq; Type: SEQUENCE SET; Schema: public; Owner: conmeddb_user
--

SELECT pg_catalog.setval('public.center_professional_id_seq', 78, true);


--
-- Name: centers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: conmeddb_user
--

SELECT pg_catalog.setval('public.centers_id_seq', 155, true);


--
-- Name: professionals_id_seq; Type: SEQUENCE SET; Schema: public; Owner: conmeddb_user
--

SELECT pg_catalog.setval('public.professionals_id_seq', 2, true);


--
-- Name: specialties_id_seq; Type: SEQUENCE SET; Schema: public; Owner: conmeddb_user
--

SELECT pg_catalog.setval('public.specialties_id_seq', 3, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: conmeddb_user
--

SELECT pg_catalog.setval('public.users_id_seq', 4, true);


--
-- Name: appointments appointment2_pkey; Type: CONSTRAINT; Schema: public; Owner: conmeddb_user
--

ALTER TABLE ONLY public.appointments
    ADD CONSTRAINT appointment2_pkey PRIMARY KEY (appointment_id);


--
-- Name: assistant_professional assistant_professional_pkey; Type: CONSTRAINT; Schema: public; Owner: conmeddb_user
--

ALTER TABLE ONLY public.assistant_professional
    ADD CONSTRAINT assistant_professional_pkey PRIMARY KEY (id);


--
-- Name: assistants assistants_pkey; Type: CONSTRAINT; Schema: public; Owner: conmeddb_user
--

ALTER TABLE ONLY public.assistants
    ADD CONSTRAINT assistants_pkey PRIMARY KEY (id);


--
-- Name: centers centers_pkey; Type: CONSTRAINT; Schema: public; Owner: conmeddb_user
--

ALTER TABLE ONLY public.centers
    ADD CONSTRAINT centers_pkey PRIMARY KEY (id);


--
-- Name: professionals professionals_pkey; Type: CONSTRAINT; Schema: public; Owner: conmeddb_user
--

ALTER TABLE ONLY public.professionals
    ADD CONSTRAINT professionals_pkey PRIMARY KEY (id);


--
-- Name: specialties specialties_pkey; Type: CONSTRAINT; Schema: public; Owner: conmeddb_user
--

ALTER TABLE ONLY public.specialties
    ADD CONSTRAINT specialties_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: conmeddb_user
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: DATABASE conmeddb01; Type: ACL; Schema: -; Owner: postgres
--

GRANT ALL ON DATABASE conmeddb01 TO conmeddb_user;


--
-- PostgreSQL database dump complete
--

--
-- Database "conmeddb02" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 12.18 (Ubuntu 12.18-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.18 (Ubuntu 12.18-0ubuntu0.20.04.1)

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

--
-- Name: conmeddb02; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE conmeddb02 WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.UTF-8' LC_CTYPE = 'en_US.UTF-8';


ALTER DATABASE conmeddb02 OWNER TO postgres;

\connect conmeddb02

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
-- Name: account; Type: TABLE; Schema: public; Owner: conmeddb_user
--

CREATE TABLE public.account (
    id integer NOT NULL,
    user_id integer,
    pass character varying,
    active character(254),
    confirmation_sent_creation boolean,
    status integer,
    reset_password boolean,
    confirmation_sent_reset_password boolean
);


ALTER TABLE public.account OWNER TO conmeddb_user;

--
-- Name: account_id_seq; Type: SEQUENCE; Schema: public; Owner: conmeddb_user
--

ALTER TABLE public.account ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.account_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: appointment; Type: TABLE; Schema: public; Owner: conmeddb_user
--

CREATE TABLE public.appointment (
    id integer NOT NULL,
    date timestamp with time zone,
    end_time time with time zone,
    duration integer,
    specialty integer,
    center_id integer,
    confirmation_status integer DEFAULT 0,
    professional_id integer,
    patient_doc_id text,
    patient_name text,
    patient_email text,
    patient_phone1 text,
    patient_phone2 text,
    patient_insurance integer,
    app_available boolean,
    app_status integer,
    app_blocked integer,
    app_public boolean DEFAULT true,
    available_public_search boolean,
    specialty1 integer,
    specialty2 integer,
    specialty3 integer,
    specialty5 integer,
    specialty4 integer,
    location1 integer,
    location2 integer,
    location3 integer,
    location4 integer,
    location5 integer,
    location6 integer,
    location7 integer,
    location8 integer,
    app_type_home boolean,
    app_type_center boolean,
    app_type_remote boolean,
    patient_notification_email_reserved integer DEFAULT 0,
    specialty_reserved integer,
    patient_address text,
    patient_age integer,
    calendar_id bigint,
    start_time timestamp with time zone,
    patient_confirmation integer,
    patient_confirmation_date timestamp with time zone,
    app_price integer
);


ALTER TABLE public.appointment OWNER TO conmeddb_user;

--
-- Name: COLUMN appointment.specialty_reserved; Type: COMMENT; Schema: public; Owner: conmeddb_user
--

COMMENT ON COLUMN public.appointment.specialty_reserved IS 'The final specialty was reserved by patient';


--
-- Name: appointment_cancelled; Type: TABLE; Schema: public; Owner: conmeddb_user
--

CREATE TABLE public.appointment_cancelled (
    id integer NOT NULL,
    date timestamp with time zone,
    end_time time with time zone,
    duration integer,
    specialty integer,
    center_id integer,
    confirmation_status integer DEFAULT 0,
    professional_id integer,
    patient_doc_id text,
    patient_name text,
    patient_email text,
    patient_phone1 text,
    patient_phone2 text,
    patient_insurance integer,
    app_available boolean,
    app_status integer,
    app_blocked integer,
    app_public boolean DEFAULT true,
    available_public_search boolean,
    specialty1 integer,
    specialty2 integer,
    specialty3 integer,
    specialty5 integer,
    specialty4 integer,
    location1 integer,
    location2 integer,
    location3 integer,
    location4 integer,
    location5 integer,
    location6 integer,
    location7 integer,
    location8 integer,
    app_type_home boolean,
    app_type_center boolean,
    app_type_remote boolean,
    patient_notification_email_reserved integer DEFAULT 0,
    specialty_reserved integer,
    patient_address text,
    patient_age integer,
    calendar_id bigint,
    start_time timestamp with time zone,
    patient_confirmation integer,
    patient_confirmation_date timestamp with time zone,
    cancelled_professional boolean,
    cancelled_patient boolean,
    cancelled_date timestamp with time zone,
    cancelled_notif_sento_patient boolean
);


ALTER TABLE public.appointment_cancelled OWNER TO conmeddb_user;

--
-- Name: COLUMN appointment_cancelled.specialty_reserved; Type: COMMENT; Schema: public; Owner: conmeddb_user
--

COMMENT ON COLUMN public.appointment_cancelled.specialty_reserved IS 'The final specialty was reserved by patient';


--
-- Name: appointment_cancelled_id_seq; Type: SEQUENCE; Schema: public; Owner: conmeddb_user
--

ALTER TABLE public.appointment_cancelled ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.appointment_cancelled_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
    CYCLE
);


--
-- Name: appointment_id_seq; Type: SEQUENCE; Schema: public; Owner: conmeddb_user
--

ALTER TABLE public.appointment ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.appointment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: assistant; Type: TABLE; Schema: public; Owner: conmeddb_user
--

CREATE TABLE public.assistant (
    id integer NOT NULL,
    assistant_document_id character varying,
    assistant_name character varying,
    assistant_email character varying,
    assistant_address character varying,
    assistant_phone character varying,
    assistant_active character(254),
    assistant_deleted boolean DEFAULT false
);


ALTER TABLE public.assistant OWNER TO conmeddb_user;

--
-- Name: assistant_center; Type: TABLE; Schema: public; Owner: conmeddb_user
--

CREATE TABLE public.assistant_center (
    id integer NOT NULL,
    assistant_id integer NOT NULL,
    center_id integer NOT NULL
);


ALTER TABLE public.assistant_center OWNER TO conmeddb_user;

--
-- Name: assistant_center_id_seq; Type: SEQUENCE; Schema: public; Owner: conmeddb_user
--

ALTER TABLE public.assistant_center ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.assistant_center_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: assistant_id_seq; Type: SEQUENCE; Schema: public; Owner: conmeddb_user
--

ALTER TABLE public.assistant ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.assistant_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: assistant_professional; Type: TABLE; Schema: public; Owner: conmeddb_user
--

CREATE TABLE public.assistant_professional (
    id integer NOT NULL,
    professional_id integer NOT NULL,
    assistant_id integer
);


ALTER TABLE public.assistant_professional OWNER TO conmeddb_user;

--
-- Name: assistant_professional_id_seq; Type: SEQUENCE; Schema: public; Owner: conmeddb_user
--

ALTER TABLE public.assistant_professional ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.assistant_professional_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: booking; Type: TABLE; Schema: public; Owner: conmeddb_user
--

CREATE TABLE public.booking (
    id integer NOT NULL,
    patient_id integer,
    appointment_id integer
);


ALTER TABLE public.booking OWNER TO conmeddb_user;

--
-- Name: center; Type: TABLE; Schema: public; Owner: conmeddb_user
--

CREATE TABLE public.center (
    id integer NOT NULL,
    name character varying,
    address character varying,
    phone1 character varying,
    phone2 character varying,
    active character(254),
    country integer,
    comuna integer,
    region integer,
    center_deleted boolean DEFAULT false,
    center_color text,
    url_map text,
    type bigint,
    home_comuna1 integer,
    home_comuna2 integer,
    home_comuna3 integer,
    home_comuna4 integer,
    home_comuna5 integer,
    home_comuna6 integer,
    home_visit boolean,
    center_visit boolean,
    remote_care boolean,
    pattern integer,
    professional_id bigint,
    date timestamp with time zone
);


ALTER TABLE public.center OWNER TO conmeddb_user;

--
-- Name: center_id_seq; Type: SEQUENCE; Schema: public; Owner: conmeddb_user
--

ALTER TABLE public.center ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.center_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: center_professional_bkpEliminar; Type: TABLE; Schema: public; Owner: conmeddb_user
--

CREATE TABLE public."center_professional_bkpEliminar" (
    id integer NOT NULL,
    professional_id integer NOT NULL,
    center_id integer NOT NULL
);


ALTER TABLE public."center_professional_bkpEliminar" OWNER TO conmeddb_user;

--
-- Name: center_professional_id_seq; Type: SEQUENCE; Schema: public; Owner: conmeddb_user
--

ALTER TABLE public."center_professional_bkpEliminar" ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.center_professional_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: comuna; Type: TABLE; Schema: public; Owner: conmeddb_user
--

CREATE TABLE public.comuna (
    id integer NOT NULL,
    name text,
    description text
);


ALTER TABLE public.comuna OWNER TO conmeddb_user;

--
-- Name: comuna_id_seq; Type: SEQUENCE; Schema: public; Owner: conmeddb_user
--

ALTER TABLE public.comuna ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.comuna_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: customers_messages; Type: TABLE; Schema: public; Owner: conmeddb_user
--

CREATE TABLE public.customers_messages (
    id bigint NOT NULL,
    professional_id bigint,
    date_time timestamp with time zone DEFAULT now(),
    message text,
    animo integer,
    reply boolean
);


ALTER TABLE public.customers_messages OWNER TO conmeddb_user;

--
-- Name: customers_messages_id_seq; Type: SEQUENCE; Schema: public; Owner: conmeddb_user
--

ALTER TABLE public.customers_messages ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.customers_messages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: insurance; Type: TABLE; Schema: public; Owner: conmeddb_user
--

CREATE TABLE public.insurance (
    id integer NOT NULL,
    name character varying,
    description character varying
);


ALTER TABLE public.insurance OWNER TO conmeddb_user;

--
-- Name: insurance_id_seq; Type: SEQUENCE; Schema: public; Owner: conmeddb_user
--

ALTER TABLE public.insurance ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.insurance_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: invitation_professional; Type: TABLE; Schema: public; Owner: conmeddb_user
--

CREATE TABLE public.invitation_professional (
    id bigint NOT NULL,
    email text NOT NULL,
    reference bigint
);


ALTER TABLE public.invitation_professional OWNER TO conmeddb_user;

--
-- Name: invitation_professional_id_seq; Type: SEQUENCE; Schema: public; Owner: conmeddb_user
--

ALTER TABLE public.invitation_professional ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.invitation_professional_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
    CYCLE
);


--
-- Name: patient; Type: TABLE; Schema: public; Owner: conmeddb_user
--

CREATE TABLE public.patient (
    id integer NOT NULL,
    doc_id character varying,
    name character varying,
    email character varying,
    phone1 character varying,
    phone2 character varying,
    insurance integer
);


ALTER TABLE public.patient OWNER TO conmeddb_user;

--
-- Name: patient_recover_appointments; Type: TABLE; Schema: public; Owner: conmeddb_user
--

CREATE TABLE public.patient_recover_appointments (
    email text NOT NULL
);


ALTER TABLE public.patient_recover_appointments OWNER TO conmeddb_user;

--
-- Name: professional; Type: TABLE; Schema: public; Owner: conmeddb_user
--

CREATE TABLE public.professional (
    id integer NOT NULL,
    document_number character varying,
    name character varying,
    license_number character varying,
    email character varying NOT NULL,
    address character varying,
    phone character varying,
    active character(254),
    first_time boolean DEFAULT true,
    tutorial_start boolean DEFAULT true,
    tutorial_center boolean DEFAULT true,
    tutorial_calendar boolean DEFAULT true,
    tutorial_menu boolean DEFAULT true
);


ALTER TABLE public.professional OWNER TO conmeddb_user;

--
-- Name: professional_calendar; Type: TABLE; Schema: public; Owner: conmeddb_user
--

CREATE TABLE public.professional_calendar (
    id bigint NOT NULL,
    professional_id bigint,
    start_time time with time zone,
    end_time time with time zone,
    specialty1 integer,
    specialty2 integer,
    specialty3 integer,
    specialty4 integer,
    specialty5 integer,
    duration integer,
    time_between integer,
    monday boolean,
    tuesday boolean,
    wednesday boolean,
    thursday boolean,
    friday boolean,
    saturday boolean,
    sunday boolean,
    date_start timestamp with time zone,
    date_end timestamp with time zone,
    status integer,
    active boolean,
    center_id integer,
    color text,
    deleted_professional boolean DEFAULT false,
    date timestamp with time zone,
    price integer
);


ALTER TABLE public.professional_calendar OWNER TO conmeddb_user;

--
-- Name: professional_calendar_id_seq; Type: SEQUENCE; Schema: public; Owner: conmeddb_user
--

ALTER TABLE public.professional_calendar ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.professional_calendar_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: professional_day_locked; Type: TABLE; Schema: public; Owner: conmeddb_user
--

CREATE TABLE public.professional_day_locked (
    id bigint NOT NULL,
    professional_id bigint NOT NULL,
    date timestamp with time zone NOT NULL
);


ALTER TABLE public.professional_day_locked OWNER TO conmeddb_user;

--
-- Name: professional_day_locked_id_seq1; Type: SEQUENCE; Schema: public; Owner: conmeddb_user
--

ALTER TABLE public.professional_day_locked ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.professional_day_locked_id_seq1
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: professional_id_seq; Type: SEQUENCE; Schema: public; Owner: conmeddb_user
--

ALTER TABLE public.professional ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.professional_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
    CYCLE
);


--
-- Name: professional_recover_password; Type: TABLE; Schema: public; Owner: conmeddb_user
--

CREATE TABLE public.professional_recover_password (
    id bigint NOT NULL,
    date timestamp with time zone NOT NULL,
    email text NOT NULL,
    date_update timestamp with time zone NOT NULL
);


ALTER TABLE public.professional_recover_password OWNER TO conmeddb_user;

--
-- Name: professional_recover_password_id_seq; Type: SEQUENCE; Schema: public; Owner: conmeddb_user
--

ALTER TABLE public.professional_recover_password ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.professional_recover_password_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: professional_register; Type: TABLE; Schema: public; Owner: conmeddb_user
--

CREATE TABLE public.professional_register (
    name text,
    last_name1 text,
    last_name2 text,
    email text,
    doc_id text NOT NULL,
    passwd text,
    personal_address text,
    personal_phone text,
    confirmation_sent boolean,
    date timestamp with time zone,
    user_created boolean,
    specialty bigint
);


ALTER TABLE public.professional_register OWNER TO conmeddb_user;

--
-- Name: professional_specialty; Type: TABLE; Schema: public; Owner: conmeddb_user
--

CREATE TABLE public.professional_specialty (
    id bigint NOT NULL,
    professional_id bigint NOT NULL,
    specialty_id bigint NOT NULL
);


ALTER TABLE public.professional_specialty OWNER TO conmeddb_user;

--
-- Name: professional_specialty_id_seq; Type: SEQUENCE; Schema: public; Owner: conmeddb_user
--

ALTER TABLE public.professional_specialty ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.professional_specialty_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: public_comments; Type: TABLE; Schema: public; Owner: conmeddb_user
--

CREATE TABLE public.public_comments (
    id bigint NOT NULL,
    message text NOT NULL,
    date timestamp with time zone,
    email text,
    animo integer
);


ALTER TABLE public.public_comments OWNER TO conmeddb_user;

--
-- Name: public_comments_id_seq; Type: SEQUENCE; Schema: public; Owner: conmeddb_user
--

ALTER TABLE public.public_comments ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.public_comments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: request_app_confirm; Type: TABLE; Schema: public; Owner: conmeddb_user
--

CREATE TABLE public.request_app_confirm (
    id bigint NOT NULL,
    email text NOT NULL,
    app_id bigint
);


ALTER TABLE public.request_app_confirm OWNER TO conmeddb_user;

--
-- Name: requestAppConfirmation_id_seq; Type: SEQUENCE; Schema: public; Owner: conmeddb_user
--

ALTER TABLE public.request_app_confirm ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."requestAppConfirmation_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
    CYCLE
);


--
-- Name: send_calendar_patient; Type: TABLE; Schema: public; Owner: conmeddb_user
--

CREATE TABLE public.send_calendar_patient (
    id bigint NOT NULL,
    email text NOT NULL,
    calendar_id text NOT NULL
);


ALTER TABLE public.send_calendar_patient OWNER TO conmeddb_user;

--
-- Name: send_calendar_patient_id_seq; Type: SEQUENCE; Schema: public; Owner: conmeddb_user
--

ALTER TABLE public.send_calendar_patient ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.send_calendar_patient_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
    CYCLE
);


--
-- Name: send_email_patient_cancel_appointment; Type: TABLE; Schema: public; Owner: conmeddb_user
--

CREATE TABLE public.send_email_patient_cancel_appointment (
    id bigint NOT NULL,
    app_id bigint NOT NULL,
    date timestamp with time zone,
    end_time timestamp with time zone,
    duration integer,
    specialty integer,
    center_id integer,
    confirmation_status integer,
    professional_id integer,
    patient_doc_id text,
    patient_name text,
    patient_email text,
    patient_phone1 text,
    patient_phone2 text,
    patient_insurance integer,
    app_status integer,
    specialty1 integer,
    specialty2 integer,
    specialty3 integer,
    specialty4 integer,
    location1 integer,
    location2 integer,
    location3 integer,
    location4 integer,
    location5 integer,
    location6 integer,
    location7 integer,
    location8 integer,
    app_type_home boolean,
    app_type_center boolean,
    app_type_remote boolean,
    patient_notification_email_reserved integer,
    specialty_reserved integer,
    patient_address text,
    patient_age integer,
    calendar_id bigint,
    start_time timestamp with time zone
);


ALTER TABLE public.send_email_patient_cancel_appointment OWNER TO conmeddb_user;

--
-- Name: send_email_patient_cancel_appointment_id_seq; Type: SEQUENCE; Schema: public; Owner: conmeddb_user
--

ALTER TABLE public.send_email_patient_cancel_appointment ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.send_email_patient_cancel_appointment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
    CYCLE
);


--
-- Name: session; Type: TABLE; Schema: public; Owner: conmeddb_user
--

CREATE TABLE public.session (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    expiration_time integer,
    status integer,
    name text,
    last_login timestamp with time zone,
    last_activity_time timestamp with time zone,
    user_type integer,
    first_time boolean,
    tutorial_start boolean,
    tutorial_center boolean,
    tutorial_calendar boolean,
    tutorial_menu boolean
);


ALTER TABLE public.session OWNER TO conmeddb_user;

--
-- Name: session_id_seq; Type: SEQUENCE; Schema: public; Owner: conmeddb_user
--

CREATE SEQUENCE public.session_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.session_id_seq OWNER TO conmeddb_user;

--
-- Name: session_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: conmeddb_user
--

ALTER SEQUENCE public.session_id_seq OWNED BY public.session.id;


--
-- Name: specialty; Type: TABLE; Schema: public; Owner: conmeddb_user
--

CREATE TABLE public.specialty (
    id integer NOT NULL,
    name character varying,
    description character varying
);


ALTER TABLE public.specialty OWNER TO conmeddb_user;

--
-- Name: specialty_id_seq; Type: SEQUENCE; Schema: public; Owner: conmeddb_user
--

ALTER TABLE public.specialty ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.specialty_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: session id; Type: DEFAULT; Schema: public; Owner: conmeddb_user
--

ALTER TABLE ONLY public.session ALTER COLUMN id SET DEFAULT nextval('public.session_id_seq'::regclass);


--
-- Data for Name: account; Type: TABLE DATA; Schema: public; Owner: conmeddb_user
--

COPY public.account (id, user_id, pass, active, confirmation_sent_creation, status, reset_password, confirmation_sent_reset_password) FROM stdin;
1	1	1234	true                                                                                                                                                                                                                                                          	t	\N	\N	\N
\.


--
-- Data for Name: appointment; Type: TABLE DATA; Schema: public; Owner: conmeddb_user
--

COPY public.appointment (id, date, end_time, duration, specialty, center_id, confirmation_status, professional_id, patient_doc_id, patient_name, patient_email, patient_phone1, patient_phone2, patient_insurance, app_available, app_status, app_blocked, app_public, available_public_search, specialty1, specialty2, specialty3, specialty5, specialty4, location1, location2, location3, location4, location5, location6, location7, location8, app_type_home, app_type_center, app_type_remote, patient_notification_email_reserved, specialty_reserved, patient_address, patient_age, calendar_id, start_time, patient_confirmation, patient_confirmation_date, app_price) FROM stdin;
\.


--
-- Data for Name: appointment_cancelled; Type: TABLE DATA; Schema: public; Owner: conmeddb_user
--

COPY public.appointment_cancelled (id, date, end_time, duration, specialty, center_id, confirmation_status, professional_id, patient_doc_id, patient_name, patient_email, patient_phone1, patient_phone2, patient_insurance, app_available, app_status, app_blocked, app_public, available_public_search, specialty1, specialty2, specialty3, specialty5, specialty4, location1, location2, location3, location4, location5, location6, location7, location8, app_type_home, app_type_center, app_type_remote, patient_notification_email_reserved, specialty_reserved, patient_address, patient_age, calendar_id, start_time, patient_confirmation, patient_confirmation_date, cancelled_professional, cancelled_patient, cancelled_date, cancelled_notif_sento_patient) FROM stdin;
\.


--
-- Data for Name: assistant; Type: TABLE DATA; Schema: public; Owner: conmeddb_user
--

COPY public.assistant (id, assistant_document_id, assistant_name, assistant_email, assistant_address, assistant_phone, assistant_active, assistant_deleted) FROM stdin;
29	13909312	Rosita Parson	Llalala@nadq.cl	\N	6734949	false                                                                                                                                                                                                                                                         	t
42	111111111-9	Juana La Asistente	nada@nada.cl	\N	444444	false                                                                                                                                                                                                                                                         	t
43	12231-9	Señora Delfina Secretaria	delfina@nada.cl	\N	4445556	1                                                                                                                                                                                                                                                             	\N
44	12231-9	Señora Delfina Secretaria	delfina@nada.cl	\N	4445556	1                                                                                                                                                                                                                                                             	\N
45	12231-9	Señora Delfina Secretaria	delfina@nada.cl	\N	4445556	1                                                                                                                                                                                                                                                             	f
46	139093712	Dellia Rosales del Rio	delia@nada.cl	\N	888999000	false                                                                                                                                                                                                                                                         	t
47	33333333	Rosita Le Mansh	nada@nadanada.cl	\N	33333	false                                                                                                                                                                                                                                                         	t
48	1111-1	Rosita Del Rosario Gutierrez	Rositanada@email.com	\N	66789393	1                                                                                                                                                                                                                                                             	f
\.


--
-- Data for Name: assistant_center; Type: TABLE DATA; Schema: public; Owner: conmeddb_user
--

COPY public.assistant_center (id, assistant_id, center_id) FROM stdin;
\.


--
-- Data for Name: assistant_professional; Type: TABLE DATA; Schema: public; Owner: conmeddb_user
--

COPY public.assistant_professional (id, professional_id, assistant_id) FROM stdin;
27	1	29
40	1	42
41	1	43
42	1	44
43	1	45
44	1	46
45	1	47
46	1	48
\.


--
-- Data for Name: booking; Type: TABLE DATA; Schema: public; Owner: conmeddb_user
--

COPY public.booking (id, patient_id, appointment_id) FROM stdin;
\.


--
-- Data for Name: center; Type: TABLE DATA; Schema: public; Owner: conmeddb_user
--

COPY public.center (id, name, address, phone1, phone2, active, country, comuna, region, center_deleted, center_color, url_map, type, home_comuna1, home_comuna2, home_comuna3, home_comuna4, home_comuna5, home_comuna6, home_visit, center_visit, remote_care, pattern, professional_id, date) FROM stdin;
1	nueva consulta pruebas	micasa	123123123	123123123	\N	\N	1401	\N	f	#FFE6EE	\N	\N	\N	\N	\N	\N	\N	\N	f	t	f	\N	1	2023-10-18 18:23:44.477-03
\.


--
-- Data for Name: center_professional_bkpEliminar; Type: TABLE DATA; Schema: public; Owner: conmeddb_user
--

COPY public."center_professional_bkpEliminar" (id, professional_id, center_id) FROM stdin;
182	1	181
183	2	182
184	1	186
\.


--
-- Data for Name: comuna; Type: TABLE DATA; Schema: public; Owner: conmeddb_user
--

COPY public.comuna (id, name, description) FROM stdin;
1401	Algarrobo	\N
1402	Alhue	\N
1403	Alto Biobio	\N
1404	Alto Del Carmen	\N
1405	Alto Hospicio	\N
1406	Ancud	\N
1407	Andacollo	\N
1408	Angol	\N
1409	Antofagasta	\N
1410	Antuco	\N
1411	Arauco	\N
1412	Arica	\N
1413	Aysen	\N
1414	Buin	\N
1415	Bulnes	\N
1416	Cabildo	\N
1417	Cabo De Hornos	\N
1418	Cabrero	\N
1419	Calama	\N
1420	Calbuco	\N
1421	Caldera	\N
1422	Calera De Tango	\N
1423	Calle Larga	\N
1424	Camarones	\N
1425	Camina	\N
1426	Canela	\N
1427	Canete	\N
1428	Carahue	\N
1429	Cartagena	\N
1430	Casablanca	\N
1431	Castro	\N
1432	Catemu	\N
1433	Cauquenes	\N
1434	Cerrillos	\N
1435	Cerro Navia	\N
1436	Chaiten	\N
1437	Chanaral	\N
1438	Chanco	\N
1439	Chepica	\N
1440	Chiguayante	\N
1441	Chile Chico	\N
1442	Chillan	\N
1443	Chillan Viejo	\N
1444	Chimbarongo	\N
1445	Cholchol	\N
1446	Chonchi	\N
1447	Cisnes	\N
1448	Cobquecura	\N
1449	Cochamo	\N
1450	Cochrane	\N
1451	Codegua	\N
1452	Coelemu	\N
1453	Coihueco	\N
1454	Coinco	\N
1455	Colbun	\N
1456	Colchane	\N
1457	Colina	\N
1458	Collipulli	\N
1459	Coltauco	\N
1460	Combarbala	\N
1461	Concepcion	\N
1462	Conchali	\N
1463	Concon	\N
1464	Constitucion	\N
1465	Contulmo	\N
1466	Copiapo	\N
1467	Coquimbo	\N
1468	Coronel	\N
1469	Corral	\N
1470	Coyhaique	\N
1471	Cunco	\N
1472	Curacautin	\N
1473	Curacavi	\N
1474	Curaco De Velez	\N
1475	Curanilahue	\N
1476	Curarrehue	\N
1477	Curepto	\N
1478	Curico	\N
1479	Dalcahue	\N
1480	Diego De Almagro	\N
1481	Donihue	\N
1482	El Bosque	\N
1483	El Carmen	\N
1484	El Monte	\N
1485	El Quisco	\N
1486	El Tabo	\N
1487	Empedrado	\N
1488	Ercilla	\N
1489	Estacion Central	\N
1490	Florida	\N
1491	Freire	\N
1492	Freirina	\N
1493	Fresia	\N
1494	Frutillar	\N
1495	Futaleufu	\N
1496	Futrono	\N
1497	Galvarino	\N
1498	General Lagos	\N
1499	Gorbea	\N
1500	Graneros	\N
1501	Guaitecas	\N
1502	Hijuelas	\N
1503	Hualaihue	\N
1504	Hualane	\N
1505	Hualpen	\N
1506	Hualqui	\N
1507	Huara	\N
1508	Huasco	\N
1509	Huechuraba	\N
1510	Illapel	\N
1511	Independencia	\N
1512	Iquique	\N
1513	Isla De Maipo	\N
1514	Isla De Pascua	\N
1515	Juan Fernandez	\N
1516	La Calera	\N
1517	La Cisterna	\N
1518	La Cruz	\N
1519	La Estrella	\N
1520	La Florida	\N
1521	La Granja	\N
1522	La Higuera	\N
1523	La Ligua	\N
1524	La Pintana	\N
1525	La Reina	\N
1526	La Serena	\N
1527	La Union	\N
1528	Lago Ranco	\N
1529	Lago Verde	\N
1530	Laguna Blanca	\N
1531	Laja	\N
1532	Lampa	\N
1533	Lanco	\N
1534	Las Cabras	\N
1535	Las Condes	\N
1536	Lautaro	\N
1537	Lebu	\N
1538	Licanten	\N
1539	Limache	\N
1540	Linares	\N
1541	Litueche	\N
1542	Llanquihue	\N
1543	Llay-Llay	\N
1544	Lo Barnechea	\N
1545	Lo Espejo	\N
1546	Lo Prado	\N
1547	Lolol	\N
1548	Loncoche	\N
1549	Longavi	\N
1550	Lonquimayv	\N
1551	Los Alamos	\N
1552	Los Andes	\N
1553	Los Angeles	\N
1554	Los Lagos	\N
1555	Los Muermos	\N
1556	Los Sauces	\N
1557	Los Vilos	\N
1558	Lota	\N
1559	Lumaco	\N
1560	Machali	\N
1561	Macul	\N
1562	Mafil	\N
1563	Maipu	\N
1564	Malloa	\N
1565	Marchigue	\N
1566	Maria Elena	\N
1567	Maria Pinto	\N
1568	Mariquina	\N
1569	Maule	\N
1570	Maullin	\N
1571	Mejillones	\N
1572	Melipeuco	\N
1573	Melipilla	\N
1574	Molina	\N
1575	Monte Patria	\N
1576	Mulchen	\N
1577	Nacimiento	\N
1578	Nancagua	\N
1579	Natales	\N
1580	Navidad	\N
1581	Negrete	\N
1582	Ninhue	\N
1583	Niquen	\N
1584	Nogales	\N
1585	Nueva Imperial	\N
1586	Nunoa	\N
1587	Ohiggins	\N
1588	Olivar	\N
1589	Ollague	\N
1590	Olmue	\N
1591	Osorno	\N
1592	Ovalle	\N
1593	Padre Hurtado	\N
1594	Padre Las Casas	\N
1595	Paihuano	\N
1596	Paillaco	\N
1597	Paine	\N
1598	Palena	\N
1599	Palmilla	\N
1600	Panguipulli	\N
1601	Panquehue	\N
1602	Papudo	\N
1603	Paredones	\N
1604	Parral	\N
1605	Pedro Aguirre Cerda	\N
1606	Pelarco	\N
1607	Pelluhue	\N
1608	Pemuco	\N
1609	Penaflor	\N
1610	Penalolen	\N
1611	Pencahue	\N
1612	Penco	\N
1613	Peralillo	\N
1614	Perquenco	\N
1615	Petorca	\N
1616	Peumo	\N
1617	Pica	\N
1618	Pichidegua	\N
1619	Pichilemu	\N
1620	Pinto	\N
1621	Pirque	\N
1622	Pitrufquen	\N
1623	Placilla	\N
1624	Portezuelo	\N
1625	Porvenir	\N
1626	Pozo Almonte	\N
1627	Primavera	\N
1628	Providencia	\N
1629	Puchuncavi	\N
1630	Pucon	\N
1631	Pudahuel	\N
1632	Puente Alto	\N
1633	Puerto Montt	\N
1634	Puerto Octay	\N
1635	Puerto Varas	\N
1636	Pumanque	\N
1637	Punitaqui	\N
1638	Punta Arenas	\N
1639	Puqueldon	\N
1640	Puren	\N
1641	Purranque	\N
1642	Putaendo	\N
1643	Putre	\N
1644	Puyehue	\N
1645	Queilen	\N
1646	Quellon	\N
1647	Quemchi	\N
1648	Quilaco	\N
1649	Quilicura	\N
1650	Quilleco	\N
1651	Quillon	\N
1652	Quillota	\N
1653	Quilpue	\N
1654	Quinchao	\N
1655	Quinta De Tilcoco	\N
1656	Quinta Normal	\N
1657	Quintero	\N
1658	Quirihue	\N
1659	Rancagua	\N
1660	Ranquil	\N
1661	Rauco	\N
1662	Recoleta	\N
1663	Renaico	\N
1664	Renca	\N
1665	Rengo	\N
1666	Requinoa	\N
1667	Retiro	\N
1668	Rinconada	\N
1669	Rio Bueno	\N
1670	Rio Claro	\N
1671	Rio Hurtado	\N
1672	Rio Ibanez	\N
1673	Rio Negro	\N
1674	Rio Verde	\N
1675	Romeral	\N
1676	Saavedra	\N
1677	Sagrada Familia	\N
1678	Salamanca	\N
1679	San Antonio	\N
1680	San Bernardo	\N
1681	San Carlos	\N
1682	San Clemente	\N
1683	San Esteban	\N
1684	San Fabian	\N
1685	San Felipe	\N
1686	San Fernando	\N
1687	San Francisco De Mostazal	\N
1688	San Gregorio	\N
1689	San Ignacio	\N
1690	San Javier	\N
1691	San Joaquin	\N
1692	San Jose De Maipo	\N
1693	San Juan De La Costa	\N
1694	San Miguel	\N
1695	San Nicolas	\N
1696	San Pablo	\N
1697	San Pedro	\N
1698	San Pedro De Atacama	\N
1699	San Pedro De La Paz	\N
1700	San Rafael	\N
1701	San Ramon	\N
1702	San Rosendo	\N
1703	San Vicente	\N
1704	Santa Barbara	\N
1705	Santa Cruz	\N
1706	Santa Juana	\N
1707	Santa Maria	\N
1708	Santiago	\N
1709	Santiago Oeste	\N
1710	Santiago Sur	\N
1711	Santo Domingo	\N
1712	Sierra Gorda	\N
1713	Talagante	\N
1714	Talca	\N
1715	Talcahuano	\N
1716	Taltal	\N
1717	Temuco	\N
1718	Teno	\N
1719	Teodoro Schmidt	\N
1720	Tierra Amarilla	\N
1721	Til-Til	\N
1722	Timaukel	\N
1723	Tirua	\N
1724	Tocopilla	\N
1725	Tolten	\N
1726	Tome	\N
1727	Torres Del Paine	\N
1728	Tortel	\N
1729	Traiguen	\N
1730	Trehuaco	\N
1731	Tucapel	\N
1732	Valdivia	\N
1733	Vallenar	\N
1734	Valparaiso	\N
1735	Vichuquen	\N
1736	Victoria	\N
1737	Vicuna	\N
1738	Vilcun	\N
1739	Villa Alegre	\N
1740	Villa Alemana	\N
1741	Villarrica	\N
1742	Vina Del Mar	\N
1743	Vitacura	\N
1744	Yerbas Buenas	\N
1745	Yumbel	\N
1746	Yungay	\N
1747	Zapallar	\N
\.


--
-- Data for Name: customers_messages; Type: TABLE DATA; Schema: public; Owner: conmeddb_user
--

COPY public.customers_messages (id, professional_id, date_time, message, animo, reply) FROM stdin;
1	1	2023-10-18 18:21:32.559543-03	Mejorar Tutorial de inicio	0	\N
2	1	2023-10-18 18:24:01.299271-03	ERROR AL CREAR CONSULTA	0	\N
3	1	2023-10-18 18:37:17.52543-03	AGREGAR NOMBRE DEL PROFESIONAL EN EL RESULTADO	3	\N
\.


--
-- Data for Name: insurance; Type: TABLE DATA; Schema: public; Owner: conmeddb_user
--

COPY public.insurance (id, name, description) FROM stdin;
40	Rio Blanco	\N
41	San Lorenzo	\N
42	Vida Tres	\N
33	Colmena Golden Cross	\N
34	Consalud	\N
35	Cruz blanca	\N
36	Cruz del Norte	\N
37	Nueva Masvida	\N
38	Fundacion	\N
39	Fusat	\N
30	Particular	\N
31	Banmedica	\N
32	Chuquicamata	\N
29	Fonasa	\N
\.


--
-- Data for Name: invitation_professional; Type: TABLE DATA; Schema: public; Owner: conmeddb_user
--

COPY public.invitation_professional (id, email, reference) FROM stdin;
\.


--
-- Data for Name: patient; Type: TABLE DATA; Schema: public; Owner: conmeddb_user
--

COPY public.patient (id, doc_id, name, email, phone1, phone2, insurance) FROM stdin;
\.


--
-- Data for Name: patient_recover_appointments; Type: TABLE DATA; Schema: public; Owner: conmeddb_user
--

COPY public.patient_recover_appointments (email) FROM stdin;
\.


--
-- Data for Name: professional; Type: TABLE DATA; Schema: public; Owner: conmeddb_user
--

COPY public.professional (id, document_number, name, license_number, email, address, phone, active, first_time, tutorial_start, tutorial_center, tutorial_calendar, tutorial_menu) FROM stdin;
1	13909371-2	juan alejandro morales miranda 	No Set	alejandro2141@gmail.com	mi casa 957	975397200	false                                                                                                                                                                                                                                                         	t	f	t	t	t
\.


--
-- Data for Name: professional_calendar; Type: TABLE DATA; Schema: public; Owner: conmeddb_user
--

COPY public.professional_calendar (id, professional_id, start_time, end_time, specialty1, specialty2, specialty3, specialty4, specialty5, duration, time_between, monday, tuesday, wednesday, thursday, friday, saturday, sunday, date_start, date_end, status, active, center_id, color, deleted_professional, date, price) FROM stdin;
1	1	10:00:00-03	21:00:00-03	200	\N	\N	\N	\N	30	20	t	t	t	t	t	f	f	2023-10-18 00:00:00-03	2023-10-25 23:59:59.997-03	1	t	1	#4ebeef	f	2023-10-18 18:26:07.382-03	33990
2	1	01:00:00-03	14:00:00-03	200	\N	\N	\N	\N	40	50	t	t	t	t	t	f	t	2023-10-20 00:00:00-03	2024-05-09 23:59:59.997-04	1	t	1	#FF4244	f	2023-10-20 11:11:17.015-03	29990
\.


--
-- Data for Name: professional_day_locked; Type: TABLE DATA; Schema: public; Owner: conmeddb_user
--

COPY public.professional_day_locked (id, professional_id, date) FROM stdin;
\.


--
-- Data for Name: professional_recover_password; Type: TABLE DATA; Schema: public; Owner: conmeddb_user
--

COPY public.professional_recover_password (id, date, email, date_update) FROM stdin;
\.


--
-- Data for Name: professional_register; Type: TABLE DATA; Schema: public; Owner: conmeddb_user
--

COPY public.professional_register (name, last_name1, last_name2, email, doc_id, passwd, personal_address, personal_phone, confirmation_sent, date, user_created, specialty) FROM stdin;
juan alejandro morales miranda	morales	miranda	alejandro2141@gmail.com	13909371-2	1234	mi casa 957	975397200	t	2023-10-18 18:16:16.255475-03	t	200
\.


--
-- Data for Name: professional_specialty; Type: TABLE DATA; Schema: public; Owner: conmeddb_user
--

COPY public.professional_specialty (id, professional_id, specialty_id) FROM stdin;
1	1	200
\.


--
-- Data for Name: public_comments; Type: TABLE DATA; Schema: public; Owner: conmeddb_user
--

COPY public.public_comments (id, message, date, email, animo) FROM stdin;
\.


--
-- Data for Name: request_app_confirm; Type: TABLE DATA; Schema: public; Owner: conmeddb_user
--

COPY public.request_app_confirm (id, email, app_id) FROM stdin;
\.


--
-- Data for Name: send_calendar_patient; Type: TABLE DATA; Schema: public; Owner: conmeddb_user
--

COPY public.send_calendar_patient (id, email, calendar_id) FROM stdin;
\.


--
-- Data for Name: send_email_patient_cancel_appointment; Type: TABLE DATA; Schema: public; Owner: conmeddb_user
--

COPY public.send_email_patient_cancel_appointment (id, app_id, date, end_time, duration, specialty, center_id, confirmation_status, professional_id, patient_doc_id, patient_name, patient_email, patient_phone1, patient_phone2, patient_insurance, app_status, specialty1, specialty2, specialty3, specialty4, location1, location2, location3, location4, location5, location6, location7, location8, app_type_home, app_type_center, app_type_remote, patient_notification_email_reserved, specialty_reserved, patient_address, patient_age, calendar_id, start_time) FROM stdin;
\.


--
-- Data for Name: session; Type: TABLE DATA; Schema: public; Owner: conmeddb_user
--

COPY public.session (id, user_id, expiration_time, status, name, last_login, last_activity_time, user_type, first_time, tutorial_start, tutorial_center, tutorial_calendar, tutorial_menu) FROM stdin;
1	1	\N	\N	juan alejandro morales miranda  morales miranda 	2023-10-18 18:20:59.428975-03	2023-10-18 18:20:59.428975-03	1	t	t	t	t	t
2	1	\N	\N	juan alejandro morales miranda 	2023-10-20 11:10:00.817678-03	2023-10-20 11:10:00.817678-03	1	t	f	t	t	t
3	1	\N	\N	juan alejandro morales miranda 	2024-03-04 09:05:01.036727-03	2024-03-04 09:05:01.036727-03	1	t	f	t	t	t
\.


--
-- Data for Name: specialty; Type: TABLE DATA; Schema: public; Owner: conmeddb_user
--

COPY public.specialty (id, name, description) FROM stdin;
100	Kinesiología	\N
200	Psicología	\N
400	Nutrición	\N
500	Terapia Ocupacional	\N
700	Enfermería	\N
800	Masoterapia	\N
300	Fono audiología	\N
600	Psico pedagogia	\N
\.


--
-- Name: account_id_seq; Type: SEQUENCE SET; Schema: public; Owner: conmeddb_user
--

SELECT pg_catalog.setval('public.account_id_seq', 1, true);


--
-- Name: appointment_cancelled_id_seq; Type: SEQUENCE SET; Schema: public; Owner: conmeddb_user
--

SELECT pg_catalog.setval('public.appointment_cancelled_id_seq', 1, false);


--
-- Name: appointment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: conmeddb_user
--

SELECT pg_catalog.setval('public.appointment_id_seq', 1, false);


--
-- Name: assistant_center_id_seq; Type: SEQUENCE SET; Schema: public; Owner: conmeddb_user
--

SELECT pg_catalog.setval('public.assistant_center_id_seq', 1, false);


--
-- Name: assistant_id_seq; Type: SEQUENCE SET; Schema: public; Owner: conmeddb_user
--

SELECT pg_catalog.setval('public.assistant_id_seq', 48, true);


--
-- Name: assistant_professional_id_seq; Type: SEQUENCE SET; Schema: public; Owner: conmeddb_user
--

SELECT pg_catalog.setval('public.assistant_professional_id_seq', 46, true);


--
-- Name: center_id_seq; Type: SEQUENCE SET; Schema: public; Owner: conmeddb_user
--

SELECT pg_catalog.setval('public.center_id_seq', 1, true);


--
-- Name: center_professional_id_seq; Type: SEQUENCE SET; Schema: public; Owner: conmeddb_user
--

SELECT pg_catalog.setval('public.center_professional_id_seq', 1, false);


--
-- Name: comuna_id_seq; Type: SEQUENCE SET; Schema: public; Owner: conmeddb_user
--

SELECT pg_catalog.setval('public.comuna_id_seq', 1747, true);


--
-- Name: customers_messages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: conmeddb_user
--

SELECT pg_catalog.setval('public.customers_messages_id_seq', 3, true);


--
-- Name: insurance_id_seq; Type: SEQUENCE SET; Schema: public; Owner: conmeddb_user
--

SELECT pg_catalog.setval('public.insurance_id_seq', 14, true);


--
-- Name: invitation_professional_id_seq; Type: SEQUENCE SET; Schema: public; Owner: conmeddb_user
--

SELECT pg_catalog.setval('public.invitation_professional_id_seq', 2, true);


--
-- Name: professional_calendar_id_seq; Type: SEQUENCE SET; Schema: public; Owner: conmeddb_user
--

SELECT pg_catalog.setval('public.professional_calendar_id_seq', 2, true);


--
-- Name: professional_day_locked_id_seq1; Type: SEQUENCE SET; Schema: public; Owner: conmeddb_user
--

SELECT pg_catalog.setval('public.professional_day_locked_id_seq1', 1, false);


--
-- Name: professional_id_seq; Type: SEQUENCE SET; Schema: public; Owner: conmeddb_user
--

SELECT pg_catalog.setval('public.professional_id_seq', 1, true);


--
-- Name: professional_recover_password_id_seq; Type: SEQUENCE SET; Schema: public; Owner: conmeddb_user
--

SELECT pg_catalog.setval('public.professional_recover_password_id_seq', 1, false);


--
-- Name: professional_specialty_id_seq; Type: SEQUENCE SET; Schema: public; Owner: conmeddb_user
--

SELECT pg_catalog.setval('public.professional_specialty_id_seq', 1, true);


--
-- Name: public_comments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: conmeddb_user
--

SELECT pg_catalog.setval('public.public_comments_id_seq', 1, false);


--
-- Name: requestAppConfirmation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: conmeddb_user
--

SELECT pg_catalog.setval('public."requestAppConfirmation_id_seq"', 1, false);


--
-- Name: send_calendar_patient_id_seq; Type: SEQUENCE SET; Schema: public; Owner: conmeddb_user
--

SELECT pg_catalog.setval('public.send_calendar_patient_id_seq', 1, false);


--
-- Name: send_email_patient_cancel_appointment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: conmeddb_user
--

SELECT pg_catalog.setval('public.send_email_patient_cancel_appointment_id_seq', 1, false);


--
-- Name: session_id_seq; Type: SEQUENCE SET; Schema: public; Owner: conmeddb_user
--

SELECT pg_catalog.setval('public.session_id_seq', 3, true);


--
-- Name: specialty_id_seq; Type: SEQUENCE SET; Schema: public; Owner: conmeddb_user
--

SELECT pg_catalog.setval('public.specialty_id_seq', 153, true);


--
-- Name: account account_id; Type: CONSTRAINT; Schema: public; Owner: conmeddb_user
--

ALTER TABLE ONLY public.account
    ADD CONSTRAINT account_id PRIMARY KEY (id);


--
-- Name: appointment_cancelled appointment_cancelled_pkey; Type: CONSTRAINT; Schema: public; Owner: conmeddb_user
--

ALTER TABLE ONLY public.appointment_cancelled
    ADD CONSTRAINT appointment_cancelled_pkey PRIMARY KEY (id);


--
-- Name: appointment appointment_id; Type: CONSTRAINT; Schema: public; Owner: conmeddb_user
--

ALTER TABLE ONLY public.appointment
    ADD CONSTRAINT appointment_id PRIMARY KEY (id);


--
-- Name: assistant assistant_id; Type: CONSTRAINT; Schema: public; Owner: conmeddb_user
--

ALTER TABLE ONLY public.assistant
    ADD CONSTRAINT assistant_id PRIMARY KEY (id);


--
-- Name: assistant_professional assistant_professional_id; Type: CONSTRAINT; Schema: public; Owner: conmeddb_user
--

ALTER TABLE ONLY public.assistant_professional
    ADD CONSTRAINT assistant_professional_id PRIMARY KEY (id);


--
-- Name: booking booking_id; Type: CONSTRAINT; Schema: public; Owner: conmeddb_user
--

ALTER TABLE ONLY public.booking
    ADD CONSTRAINT booking_id PRIMARY KEY (id);


--
-- Name: comuna comuna_pkey; Type: CONSTRAINT; Schema: public; Owner: conmeddb_user
--

ALTER TABLE ONLY public.comuna
    ADD CONSTRAINT comuna_pkey PRIMARY KEY (id);


--
-- Name: professional_day_locked constraints_uniq_id_date; Type: CONSTRAINT; Schema: public; Owner: conmeddb_user
--

ALTER TABLE ONLY public.professional_day_locked
    ADD CONSTRAINT constraints_uniq_id_date UNIQUE (professional_id, date);


--
-- Name: customers_messages customers_messages_pkey; Type: CONSTRAINT; Schema: public; Owner: conmeddb_user
--

ALTER TABLE ONLY public.customers_messages
    ADD CONSTRAINT customers_messages_pkey PRIMARY KEY (id);


--
-- Name: professional_register email professional register must be unique; Type: CONSTRAINT; Schema: public; Owner: conmeddb_user
--

ALTER TABLE ONLY public.professional_register
    ADD CONSTRAINT "email professional register must be unique" UNIQUE (email);


--
-- Name: center id; Type: CONSTRAINT; Schema: public; Owner: conmeddb_user
--

ALTER TABLE ONLY public.center
    ADD CONSTRAINT id PRIMARY KEY (id);


--
-- Name: insurance insurance_id; Type: CONSTRAINT; Schema: public; Owner: conmeddb_user
--

ALTER TABLE ONLY public.insurance
    ADD CONSTRAINT insurance_id PRIMARY KEY (id);


--
-- Name: invitation_professional invitation_professional_pkey; Type: CONSTRAINT; Schema: public; Owner: conmeddb_user
--

ALTER TABLE ONLY public.invitation_professional
    ADD CONSTRAINT invitation_professional_pkey PRIMARY KEY (id);


--
-- Name: patient patient_id; Type: CONSTRAINT; Schema: public; Owner: conmeddb_user
--

ALTER TABLE ONLY public.patient
    ADD CONSTRAINT patient_id PRIMARY KEY (id);


--
-- Name: professional professional email must be unique; Type: CONSTRAINT; Schema: public; Owner: conmeddb_user
--

ALTER TABLE ONLY public.professional
    ADD CONSTRAINT "professional email must be unique" UNIQUE (email);


--
-- Name: professional_calendar professional_calendar_pkey; Type: CONSTRAINT; Schema: public; Owner: conmeddb_user
--

ALTER TABLE ONLY public.professional_calendar
    ADD CONSTRAINT professional_calendar_pkey PRIMARY KEY (id);


--
-- Name: professional_day_locked professional_day_locked_pkey; Type: CONSTRAINT; Schema: public; Owner: conmeddb_user
--

ALTER TABLE ONLY public.professional_day_locked
    ADD CONSTRAINT professional_day_locked_pkey PRIMARY KEY (id);


--
-- Name: professional professional_id; Type: CONSTRAINT; Schema: public; Owner: conmeddb_user
--

ALTER TABLE ONLY public.professional
    ADD CONSTRAINT professional_id PRIMARY KEY (id);


--
-- Name: professional_recover_password professional_recover_password_pkey; Type: CONSTRAINT; Schema: public; Owner: conmeddb_user
--

ALTER TABLE ONLY public.professional_recover_password
    ADD CONSTRAINT professional_recover_password_pkey PRIMARY KEY (id);


--
-- Name: professional_register professional_register_pkey; Type: CONSTRAINT; Schema: public; Owner: conmeddb_user
--

ALTER TABLE ONLY public.professional_register
    ADD CONSTRAINT professional_register_pkey PRIMARY KEY (doc_id);


--
-- Name: professional_specialty professional_specialty_pkey; Type: CONSTRAINT; Schema: public; Owner: conmeddb_user
--

ALTER TABLE ONLY public.professional_specialty
    ADD CONSTRAINT professional_specialty_pkey PRIMARY KEY (id);


--
-- Name: public_comments public_comments_pkey; Type: CONSTRAINT; Schema: public; Owner: conmeddb_user
--

ALTER TABLE ONLY public.public_comments
    ADD CONSTRAINT public_comments_pkey PRIMARY KEY (id);


--
-- Name: patient_recover_appointments recover_appointments_request_pkey; Type: CONSTRAINT; Schema: public; Owner: conmeddb_user
--

ALTER TABLE ONLY public.patient_recover_appointments
    ADD CONSTRAINT recover_appointments_request_pkey PRIMARY KEY (email);


--
-- Name: request_app_confirm requestAppConfirmation_pkey; Type: CONSTRAINT; Schema: public; Owner: conmeddb_user
--

ALTER TABLE ONLY public.request_app_confirm
    ADD CONSTRAINT "requestAppConfirmation_pkey" PRIMARY KEY (id);


--
-- Name: send_calendar_patient send_calendar_patient_pkey; Type: CONSTRAINT; Schema: public; Owner: conmeddb_user
--

ALTER TABLE ONLY public.send_calendar_patient
    ADD CONSTRAINT send_calendar_patient_pkey PRIMARY KEY (id);


--
-- Name: send_email_patient_cancel_appointment send_email_patient_cancel_appointment_pkey; Type: CONSTRAINT; Schema: public; Owner: conmeddb_user
--

ALTER TABLE ONLY public.send_email_patient_cancel_appointment
    ADD CONSTRAINT send_email_patient_cancel_appointment_pkey PRIMARY KEY (id);


--
-- Name: session session_pkey; Type: CONSTRAINT; Schema: public; Owner: conmeddb_user
--

ALTER TABLE ONLY public.session
    ADD CONSTRAINT session_pkey PRIMARY KEY (id);


--
-- Name: specialty specialty_id; Type: CONSTRAINT; Schema: public; Owner: conmeddb_user
--

ALTER TABLE ONLY public.specialty
    ADD CONSTRAINT specialty_id PRIMARY KEY (id);


--
-- Name: fki_center_id_FK; Type: INDEX; Schema: public; Owner: conmeddb_user
--

CREATE INDEX "fki_center_id_FK" ON public."center_professional_bkpEliminar" USING btree (center_id);


--
-- Name: assistant_professional assistant_id_FK; Type: FK CONSTRAINT; Schema: public; Owner: conmeddb_user
--

ALTER TABLE ONLY public.assistant_professional
    ADD CONSTRAINT "assistant_id_FK" FOREIGN KEY (assistant_id) REFERENCES public.assistant(id) ON DELETE CASCADE NOT VALID;


--
-- Name: professional_specialty professional_id; Type: FK CONSTRAINT; Schema: public; Owner: conmeddb_user
--

ALTER TABLE ONLY public.professional_specialty
    ADD CONSTRAINT professional_id FOREIGN KEY (professional_id) REFERENCES public.professional(id) NOT VALID;


--
-- Name: professional_specialty specialty_id; Type: FK CONSTRAINT; Schema: public; Owner: conmeddb_user
--

ALTER TABLE ONLY public.professional_specialty
    ADD CONSTRAINT specialty_id FOREIGN KEY (specialty_id) REFERENCES public.specialty(id) NOT VALID;


--
-- PostgreSQL database dump complete
--

--
-- Database "postgres" dump
--

\connect postgres

--
-- PostgreSQL database dump
--

-- Dumped from database version 12.18 (Ubuntu 12.18-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.18 (Ubuntu 12.18-0ubuntu0.20.04.1)

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

--
-- PostgreSQL database dump complete
--

--
-- Database "trocalodb" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 12.18 (Ubuntu 12.18-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.18 (Ubuntu 12.18-0ubuntu0.20.04.1)

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

--
-- Name: trocalodb; Type: DATABASE; Schema: -; Owner: trocalo_user
--

CREATE DATABASE trocalodb WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.UTF-8' LC_CTYPE = 'en_US.UTF-8';


ALTER DATABASE trocalodb OWNER TO trocalo_user;

\connect trocalodb

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
-- Name: comment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.comment (
    id bigint NOT NULL,
    user_id bigint,
    "timestamp" timestamp with time zone,
    comment text,
    feeling integer,
    user_name text,
    reply boolean DEFAULT false,
    fixed boolean DEFAULT false
);


ALTER TABLE public.comment OWNER TO postgres;

--
-- Name: comment_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.comment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.comment_id_seq OWNER TO postgres;

--
-- Name: comment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.comment_id_seq OWNED BY public.comment.id;


--
-- Name: proposal; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.proposal (
    id bigint NOT NULL,
    updated timestamp with time zone,
    user_id_creator bigint,
    user_id_destination bigint,
    amount bigint,
    status bigint,
    loop_number integer,
    user_id_source bigint,
    source_object1 bigint,
    source_object2 bigint,
    source_object3 bigint,
    source_object4 bigint,
    source_object5 bigint,
    dest_object1 bigint,
    dest_object2 bigint,
    dest_object3 bigint,
    dest_object4 bigint,
    dest_object5 bigint,
    source_owner_name text,
    title text,
    dest_owner_name text,
    negotiation_loop integer DEFAULT 0,
    creator_name text,
    proposal_days integer DEFAULT 30,
    date_acceptance timestamp with time zone,
    "timestamp" timestamp with time zone,
    notification_new_proposal_source boolean DEFAULT false,
    notification_new_proposal_destination boolean DEFAULT false,
    notification_accepted_proposal_source boolean DEFAULT false,
    notification_accepted_proposal_destination boolean DEFAULT false,
    notification_intransfer_proposal_destination boolean,
    notification_intransfer_proposal_source boolean,
    notification_rejected_proposal_source boolean,
    notification_rejected_proposal_destination boolean
);


ALTER TABLE public.proposal OWNER TO postgres;

--
-- Name: proposal_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.proposal_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.proposal_id_seq OWNER TO postgres;

--
-- Name: proposal_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.proposal_id_seq OWNED BY public.proposal.id;


--
-- Name: session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.session (
    id bigint NOT NULL,
    creation_date timestamp with time zone,
    user_id bigint,
    user_name text,
    exp_date timestamp with time zone,
    token text,
    token_exp_date timestamp with time zone,
    last_login timestamp with time zone
);


ALTER TABLE public.session OWNER TO postgres;

--
-- Name: session_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.session_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.session_id_seq OWNER TO postgres;

--
-- Name: session_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.session_id_seq OWNED BY public.session.id;


--
-- Name: user_creation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_creation (
    id bigint NOT NULL,
    names text,
    last_name1 text,
    last_name2 text,
    email text,
    phone text,
    passwd text,
    address_street_name text,
    address_street_apartment bigint,
    status bigint,
    cdate timestamp with time zone,
    created boolean,
    address_street_number bigint,
    id_number text,
    address_reference text,
    address_location_zone text
);


ALTER TABLE public.user_creation OWNER TO postgres;

--
-- Name: userCreationRequest_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."userCreationRequest_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."userCreationRequest_id_seq" OWNER TO postgres;

--
-- Name: userCreationRequest_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."userCreationRequest_id_seq" OWNED BY public.user_creation.id;


--
-- Name: user_created; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_created (
    id bigint NOT NULL,
    names text,
    last_name1 text,
    last_name2 text,
    email text,
    phone text,
    passwd text,
    address_street_name text,
    address_street_apartment bigint,
    address_street_number bigint,
    address_reference text,
    "timestamp" timestamp with time zone,
    status bigint,
    active boolean,
    user_confirmed boolean,
    id_number text,
    address_location_zone text,
    register_confirmation_sent boolean DEFAULT false
);


ALTER TABLE public.user_created OWNER TO postgres;

--
-- Name: user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_id_seq OWNER TO postgres;

--
-- Name: user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_id_seq OWNED BY public.user_created.id;


--
-- Name: user_object; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_object (
    id bigint NOT NULL,
    title text,
    description text,
    alternative1 text,
    alternative2 text,
    alternative3 text,
    others boolean,
    owner_id bigint,
    "timestamp" timestamp with time zone,
    img_ref1 text,
    img_ref2 text,
    img_ref3 text,
    img_ref4 text,
    img_ref5 text,
    owner_name text,
    owner_email text,
    deleted_by_owner boolean,
    deleted_by_owner_timestamp timestamp with time zone,
    category1 integer,
    category2 integer,
    category3 integer,
    blocked_due_proposal_accepted boolean,
    proposal_id_accepted bigint
);


ALTER TABLE public.user_object OWNER TO postgres;

--
-- Name: user_object_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_object_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_object_id_seq OWNER TO postgres;

--
-- Name: user_object_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_object_id_seq OWNED BY public.user_object.id;


--
-- Name: comment id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comment ALTER COLUMN id SET DEFAULT nextval('public.comment_id_seq'::regclass);


--
-- Name: proposal id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.proposal ALTER COLUMN id SET DEFAULT nextval('public.proposal_id_seq'::regclass);


--
-- Name: session id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.session ALTER COLUMN id SET DEFAULT nextval('public.session_id_seq'::regclass);


--
-- Name: user_created id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_created ALTER COLUMN id SET DEFAULT nextval('public.user_id_seq'::regclass);


--
-- Name: user_creation id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_creation ALTER COLUMN id SET DEFAULT nextval('public."userCreationRequest_id_seq"'::regclass);


--
-- Name: user_object id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_object ALTER COLUMN id SET DEFAULT nextval('public.user_object_id_seq'::regclass);


--
-- Data for Name: comment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.comment (id, user_id, "timestamp", comment, feeling, user_name, reply, fixed) FROM stdin;
10	6	2024-01-09 18:59:51.04-03	aaaaaaaaaaeeeeeeerrrrrrrrrrr	3	Juan Alejandro 	f	t
11	6	2024-01-09 19:07:38.345-03	aaaaaaa	1	Juan Alejandro 	f	t
12	6	2024-01-09 19:08:10.024-03	eeeeee	3	Juan Alejandro 	f	t
27	6	2024-01-15 19:04:46.121-03	Mejorar estas opciones, no se entiende. 	3	Juan Alejandro 	f	t
16	6	2024-01-09 19:17:25.191-03	Mensaje enviannnnnnnnnnnnnnnnndo...	3	Juan Alejandro 	f	t
9	6	2024-01-09 18:47:17.34-03	aaaaaaaaaaaaaaaaaa	3	Juan Alejandro 	f	t
28	6	2024-01-15 19:06:57.93-03	Al Aceptar el objeto debe quedar como inactivo. 	1	Juan Alejandro 	f	t
13	6	2024-01-09 19:08:21.585-03	gggggggggggggg	2	Juan Alejandro 	f	t
29	6	2024-01-15 19:08:52.154-03	No debe permitir ofertar por tu mismo objeto	2	Juan Alejandro 	f	t
30	6	2024-01-15 19:13:31.585-03	Completar el Rechazadas Canceladas  details	3	Juan Alejandro 	f	t
31	6	2024-01-15 19:14:14.337-03	debe listar los comentarios desde mas nuevos a mas antiguos	2	Juan Alejandro 	f	t
14	6	2024-01-09 19:17:01.574-03	xxxxxxxxxxxxxxxxxxxxxxxxxxx	1	Juan Alejandro 	f	t
15	6	2024-01-09 19:17:17.595-03	bbbbbbbbbbbbbbbbbbbb	2	Juan Alejandro 	f	t
17	6	2024-01-12 13:15:44.819-03	Login sin datos genera un error	1	Juan Alejandro 	f	t
18	6	2024-01-12 13:16:14.54-03	Enviar mensaje mas simple sin transicicion de gracias	1	Juan Alejandro 	f	t
19	6	2024-01-15 11:39:06.615-03	Pantalla principal no funcionan los filtros  de iconos	1	Juan Alejandro 	f	t
20	6	2024-01-15 11:58:56.61-03	Producto alternativas aparecen en Null	1	Juan Alejandro 	f	t
21	6	2024-01-15 12:00:02.809-03	Crear propuesta,  dias de propuesta debe ir de mayor a menor, partiendo en 30 	2	Juan Alejandro 	f	t
22	6	2024-01-15 12:00:44.18-03	En resumen propuesta antes de enviar no muestra que puse 5 dias. 	1	Juan Alejandro 	f	t
23	6	2024-01-15 12:01:55.161-03	Marcar un Nueva pruesta resaltada con alguna cosa.  en la lista de enviados 	3	Juan Alejandro 	f	t
24	6	2024-01-15 12:17:46.142-03	Nombre de usuario en un rincon superior 	2	Juan Alejandro 	f	t
25	6	2024-01-15 12:20:49.061-03	Propuesta recivida detalles  debe mostrar tiempo restante en base al timestamp	3	Juan Alejandro 	f	t
26	6	2024-01-15 12:22:39.725-03	Propuestas recibidas debe listar desde el mas nuevo al mas antiguo hacia abajo. 	2	Juan Alejandro 	f	t
32	6	2024-01-16 14:09:36.643-03	Al crear una propuesta, haces dos click en un objeto y lo agrega dos veces	3	Juan Alejandro 	f	t
33	6	2024-01-16 16:47:25.214-03	asfdasfdasdf	1	Juan Alejandro 	f	t
34	6	2024-01-16 16:48:36.541-03	fffffffffffaaaaaaa	1	Juan Alejandro 	f	t
35	6	2024-01-16 16:49:41.456-03	test	1	Juan Alejandro 	f	t
36	6	2024-01-16 18:11:59.425-03	Listar los productos en vista publica de mas nuevos a mas antiguos	3	Juan Alejandro 	f	t
37	6	2024-01-16 18:47:14.779-03	En crear propuesta,  seleccione de tu inventario, debe seleccionar almenos un objeto para ofrecer,	2	Juan Alejandro 	f	t
38	6	2024-01-16 19:18:30.775-03	Busqueda por texto en mi inventario no funciona	2	Juan Alejandro 	f	t
39	6	2024-01-17 11:44:40.753-03	Cuando enviamos una propuesta, retornamos a enviadas pero no esta subrallado en enviadas, parece q	3	Juan Alejandro 	f	t
40	6	2024-01-17 18:34:58.914-03	DE PREferencia lo cambiari a por... luego aparece vacio. algo raro, algo esta fallando	1	Juan Alejandro 	f	t
41	6	2024-01-17 18:36:16.019-03	seleccion de categorias se ve mal con circunferencia, deberia solo subrayar y con algun color a eval	3	Juan Alejandro 	f	t
42	6	2024-01-19 11:51:56.941-03	aparece este objeto te pertenece en la busqueda publica para todos los objetos sin estar logeado	1	Juan Alejandro 	f	t
54	2	2024-01-30 11:17:05.861-03	Propuestas recibidas debe ordenar de nuevos a mas antiguas, ya tiene un marcador de nuevos	1	userNameTest2	f	f
55	2	2024-01-30 11:18:21.421-03	Imagen de productos debe ser mas grande,  o permitir mayo tamaño para ver imagen	1	userNameTest2	f	f
43	6	2024-01-19 16:24:17.249-03	Enviadas  Tiempo restante cuando vemos el detalle no se muestra correcta	3	Juan Alejandro 	f	t
57	2	2024-01-30 12:19:38.206-03	En el fondo se siguen viendo elcontenido anterior 	2	userNameTest2	f	t
56	2	2024-01-30 12:19:36.542-03	En el fondo se siguen viendo elcontenido anterior 	2	userNameTest2	f	t
50	2	2024-01-30 11:08:09.589-03	la funcionalidad de contra oferta al parecer dea al usuario creador como el que debe pagar 	2	userNameTest2	f	t
49	2	2024-01-30 11:06:03.182-03	Object DEtails pertenece a Usuario mas abajo y menos relevante que el objeto mismo	3	userNameTest2	f	t
47	2	2024-01-30 11:03:09.053-03	Poner una subdivicison  por categorias en la pagina principal 	3	userNameTest2	f	t
48	2	2024-01-30 11:03:41.829-03	Poner el resto de categorias iconos, 	2	userNameTest2	f	t
53	2	2024-01-30 11:15:23.861-03	Al enviar deberia cerrar este  cuadro para no permitir el re envio	1	userNameTest2	f	t
45	6	2024-01-25 17:14:13.398-03	Titulo de productos con Mayuscula auto formateada	1	Juan Alejandro 	f	t
44	6	2024-01-25 17:08:54.7-03	Mejorar el formulario de Registro	3	Juan Alejandro 	f	t
58	6	2024-02-02 19:19:03.663-03	Prueba para cerrar cuadro mensajes 	3	Juan	f	t
59	6	2024-02-02 19:30:35.255-03	asdf	1	Juan	f	t
60	6	2024-02-02 19:30:55.861-03	asdf	1	Juan	f	t
61	6	2024-02-02 19:30:57.738-03	asdf	1	Juan	f	t
62	6	2024-02-02 19:31:45.245-03	asdf	2	Juan	f	t
63	6	2024-02-02 19:32:59.325-03	asfd	2	Juan	f	t
64	6	2024-02-02 19:36:28.261-03	asdf	1	Juan	f	t
65	6	2024-02-02 19:48:05.515-03	debe validar formulario ingreso nuevo objeto	2	Juan	f	t
68	6	2024-03-04 15:47:48.746-03	Login falla cuando ponemos un password erroneo\n	1	Juan	f	t
67	6	2024-03-04 11:54:28.666-03	Cuando no encuentra debe poner 0 resultados para tu busqueda, no te desanimes	2	Juan	f	t
69	6	2024-03-04 17:45:08.389-03	Selecciona de tu inventario para intecarmbiar, se ve de fondo los otros objectos\n	1	Juan	f	t
46	2	2024-01-30 11:02:23.727-03	Limitar la cantidad de productos de la pantalla principal	1	userNameTest2	f	t
52	2	2024-01-30 11:14:58.189-03	Nuevas Propuestas recibidas deberia marcar las nuevas	1	userNameTest2	f	t
51	2	2024-01-30 11:09:29.717-03	agregar envio de correos a ambas partes cuando se hace uan oferta o se concreta con los detalles	1	userNameTest2	f	t
66	6	2024-02-02 19:58:32.107-03	mas vistos, incluir en la pantalla principal	2	Juan	f	f
70	6	2024-03-13 18:39:52.178-03	buscar al presionar enter para simplificar	1	Juan	f	t
72	6	2024-03-13 18:54:14.624-03	spinner agregar	1	Juan	f	f
75	7	2024-03-14 17:37:22.909-03	Tu inventario esta vacio, debes agregar un objeto para comenzar a intercambiar	3	Matilde	f	f
76	6	2024-03-14 17:51:44.468-03	categoria cuando ingresamos objeto debe ser mas ancho	3	Juan	f	f
81	7	2024-03-14 18:07:08.825-03	Si tengo una propuesta de cambio enviada y aceptada, deberia aparecer algun indicador en  pag princi	1	Matilde	f	f
73	6	2024-03-14 16:41:48.971-03	Seleccionar de mi inventario, cuando son muchos ya ni se ven al final porquel o tapa el boto de sigu	1	Juan	f	t
84	7	2024-03-15 10:39:33.858-03	No debe permitir seleccionar objeto que esta con candado	1	Matilde	f	t
85	7	2024-03-15 10:41:31.481-03	Cuando cierro inventario en medio de una propuesta, este deberia dejar al usuario en el producto det	1	Matilde	f	t
87	7	2024-03-15 10:43:38.689-03	El precio de retiro y despacho debe aparecer cuando vemos el producto. 	2	Matilde	f	t
77	7	2024-03-14 17:54:38.453-03	No queda el Cambiaria por 	1	Matilde	f	t
91	7	2024-03-18 15:20:36.18-03	Propuestas recibidas, debe aparecer la ultima al top de la lista	1	Matilde	f	f
93	7	2024-03-19 19:28:58.682-03	Debe ser mas clara la diferencia entre ENviado y recibidos 	3	Matilde	f	f
71	6	2024-03-13 18:53:48.8-03	Click en Reusar debe hacer algo 	1	Juan	f	t
74	6	2024-03-14 17:26:17.375-03	He cancelado una oferta pero NO se ve en finalizadas	1	Juan	f	t
78	6	2024-03-14 17:57:28.331-03	Cuando aceptaste propuesta, dice le avisaremos a Kakito. 	2	Juan	f	t
79	6	2024-03-14 18:03:37.217-03	Tiempo Propuesta Restante para que Kakito_123 pague     29 deberia cambiar a algo mas formal	1	Juan	f	t
80	7	2024-03-14 18:06:28.108-03	Intercambio aceptado, deberia y que debo pagar, debe aparecer al inicio de Enviados y en color amari	2	Matilde	f	t
82	6	2024-03-15 10:36:09.673-03	Candado objetos ya estan en propuestas debe aparecer sobre la imagen	1	Juan	f	t
83	6	2024-03-15 10:37:29.728-03	En el resumen de la oferta, cuando click en mas, se elimiann todos 	1	Juan	f	t
86	7	2024-03-15 10:42:51.49-03	Revise su propuesta antes de enviar debe ser mas clara 	1	Matilde	f	t
88	7	2024-03-15 10:47:22.586-03	Todas las propuestas canceladas deberia aparecer al final	2	Matilde	f	t
89	7	2024-03-15 10:47:58.36-03	En propuesta de intercambio enviada, deberia aparecer el precio de despacho y retiro	3	Matilde	f	t
95	7	2024-03-29 19:53:46.964-03	Poner fotito del producto en enviados y recibidos	2	Matilde	f	t
92	6	2024-03-18 16:27:59.427-03	Cuando veo mi oferta, hago click en el objeto del ofertante y el mio me muestra si quiero hacer ofer	2	Juan	f	t
94	6	2024-03-20 10:30:45.114-03	Boton de guardar objeto, debe poder hacer click en toda la palabra	3	Juan	f	t
90	7	2024-03-15 10:49:45.229-03	Click en objeto debe mostrar un zoom de la imagen	1	Matilde	f	t
96	8	2024-04-09 15:23:29.311-04	Crear nuevo objeto boton de Crear debe ser completo	3	Juan	f	t
\.


--
-- Data for Name: proposal; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.proposal (id, updated, user_id_creator, user_id_destination, amount, status, loop_number, user_id_source, source_object1, source_object2, source_object3, source_object4, source_object5, dest_object1, dest_object2, dest_object3, dest_object4, dest_object5, source_owner_name, title, dest_owner_name, negotiation_loop, creator_name, proposal_days, date_acceptance, "timestamp", notification_new_proposal_source, notification_new_proposal_destination, notification_accepted_proposal_source, notification_accepted_proposal_destination, notification_intransfer_proposal_destination, notification_intransfer_proposal_source, notification_rejected_proposal_source, notification_rejected_proposal_destination) FROM stdin;
\.


--
-- Data for Name: session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.session (id, creation_date, user_id, user_name, exp_date, token, token_exp_date, last_login) FROM stdin;
\.


--
-- Data for Name: user_created; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_created (id, names, last_name1, last_name2, email, phone, passwd, address_street_name, address_street_apartment, address_street_number, address_reference, "timestamp", status, active, user_confirmed, id_number, address_location_zone, register_confirmation_sent) FROM stdin;
\.


--
-- Data for Name: user_creation; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_creation (id, names, last_name1, last_name2, email, phone, passwd, address_street_name, address_street_apartment, status, cdate, created, address_street_number, id_number, address_reference, address_location_zone) FROM stdin;
\.


--
-- Data for Name: user_object; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_object (id, title, description, alternative1, alternative2, alternative3, others, owner_id, "timestamp", img_ref1, img_ref2, img_ref3, img_ref4, img_ref5, owner_name, owner_email, deleted_by_owner, deleted_by_owner_timestamp, category1, category2, category3, blocked_due_proposal_accepted, proposal_id_accepted) FROM stdin;
\.


--
-- Name: comment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.comment_id_seq', 96, true);


--
-- Name: proposal_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.proposal_id_seq', 97, true);


--
-- Name: session_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.session_id_seq', 346, true);


--
-- Name: userCreationRequest_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."userCreationRequest_id_seq"', 24, true);


--
-- Name: user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_id_seq', 9, true);


--
-- Name: user_object_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_object_id_seq', 79, true);


--
-- Name: comment comment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comment
    ADD CONSTRAINT comment_pkey PRIMARY KEY (id);


--
-- Name: proposal proposal_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.proposal
    ADD CONSTRAINT proposal_pkey PRIMARY KEY (id);


--
-- Name: session session_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.session
    ADD CONSTRAINT session_pkey PRIMARY KEY (id);


--
-- Name: user_creation userCreationRequest_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_creation
    ADD CONSTRAINT "userCreationRequest_pkey" PRIMARY KEY (id);


--
-- Name: user_object user_object_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_object
    ADD CONSTRAINT user_object_pkey PRIMARY KEY (id);


--
-- Name: user_created user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_created
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);


--
-- Name: DATABASE trocalodb; Type: ACL; Schema: -; Owner: trocalo_user
--

REVOKE CONNECT,TEMPORARY ON DATABASE trocalodb FROM PUBLIC;
REVOKE ALL ON DATABASE trocalodb FROM trocalo_user;
GRANT ALL ON DATABASE trocalodb TO PUBLIC;


--
-- Name: TABLE comment; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.comment TO trocalo_user WITH GRANT OPTION;


--
-- Name: TABLE proposal; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.proposal TO trocalo_user WITH GRANT OPTION;


--
-- Name: TABLE session; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.session TO trocalo_user WITH GRANT OPTION;


--
-- Name: TABLE user_creation; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.user_creation TO trocalo_user WITH GRANT OPTION;


--
-- Name: TABLE user_object; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.user_object TO trocalo_user WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: -; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres GRANT ALL ON TABLES  TO trocalo_user WITH GRANT OPTION;


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database cluster dump complete
--

