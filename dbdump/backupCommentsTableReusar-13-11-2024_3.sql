--
-- PostgreSQL database dump
--

-- Dumped from database version 12.20 (Ubuntu 12.20-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.20 (Ubuntu 12.20-0ubuntu0.20.04.1)

-- Started on 2024-11-13 18:21:46 -03

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
-- TOC entry 218 (class 1259 OID 33542)
-- Name: user_reset_password; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_reset_password (
    id bigint NOT NULL,
    email text,
    status integer,
    user_id bigint,
    sent boolean DEFAULT false,
    "timestamp" timestamp with time zone,
    sent_attempt integer
);


ALTER TABLE public.user_reset_password OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 33545)
-- Name: user_reset_password_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.user_reset_password ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.user_reset_password_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
    CYCLE
);


--
-- TOC entry 2882 (class 2606 OID 33555)
-- Name: user_reset_password user_reset_password_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_reset_password
    ADD CONSTRAINT user_reset_password_pkey PRIMARY KEY (id);


--
-- TOC entry 3014 (class 0 OID 0)
-- Dependencies: 218
-- Name: TABLE user_reset_password; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.user_reset_password TO trocalo_user WITH GRANT OPTION;


-- Completed on 2024-11-13 18:21:46 -03

--
-- PostgreSQL database dump complete
--

