--
-- PostgreSQL database dump
--

-- Dumped from database version 13.5
-- Dumped by pg_dump version 13.5

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
-- Name: reservations; Type: TABLE; Schema: public; Owner: weilyuwang
--

CREATE TABLE public.reservations (
    id integer NOT NULL,
    first_name character varying(255) DEFAULT ''::character varying NOT NULL,
    last_name character varying(255) DEFAULT ''::character varying NOT NULL,
    email character varying(255) NOT NULL,
    phone character varying(255) DEFAULT ''::character varying NOT NULL,
    start_date date NOT NULL,
    end_date date NOT NULL,
    room_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.reservations OWNER TO weilyuwang;

--
-- Name: reservations_id_seq; Type: SEQUENCE; Schema: public; Owner: weilyuwang
--

CREATE SEQUENCE public.reservations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.reservations_id_seq OWNER TO weilyuwang;

--
-- Name: reservations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: weilyuwang
--

ALTER SEQUENCE public.reservations_id_seq OWNED BY public.reservations.id;


--
-- Name: restrictions; Type: TABLE; Schema: public; Owner: weilyuwang
--

CREATE TABLE public.restrictions (
    id integer NOT NULL,
    restriction_name character varying(255) DEFAULT ''::character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.restrictions OWNER TO weilyuwang;

--
-- Name: restrictions_id_seq; Type: SEQUENCE; Schema: public; Owner: weilyuwang
--

CREATE SEQUENCE public.restrictions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.restrictions_id_seq OWNER TO weilyuwang;

--
-- Name: restrictions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: weilyuwang
--

ALTER SEQUENCE public.restrictions_id_seq OWNED BY public.restrictions.id;


--
-- Name: room_restrictions; Type: TABLE; Schema: public; Owner: weilyuwang
--

CREATE TABLE public.room_restrictions (
    id integer NOT NULL,
    start_date date NOT NULL,
    end_date date NOT NULL,
    room_id integer NOT NULL,
    reservation_id integer NOT NULL,
    restriction_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.room_restrictions OWNER TO weilyuwang;

--
-- Name: room_restrictions_id_seq; Type: SEQUENCE; Schema: public; Owner: weilyuwang
--

CREATE SEQUENCE public.room_restrictions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.room_restrictions_id_seq OWNER TO weilyuwang;

--
-- Name: room_restrictions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: weilyuwang
--

ALTER SEQUENCE public.room_restrictions_id_seq OWNED BY public.room_restrictions.id;


--
-- Name: rooms; Type: TABLE; Schema: public; Owner: weilyuwang
--

CREATE TABLE public.rooms (
    id integer NOT NULL,
    room_name character varying(255) DEFAULT ''::character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.rooms OWNER TO weilyuwang;

--
-- Name: rooms_id_seq; Type: SEQUENCE; Schema: public; Owner: weilyuwang
--

CREATE SEQUENCE public.rooms_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.rooms_id_seq OWNER TO weilyuwang;

--
-- Name: rooms_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: weilyuwang
--

ALTER SEQUENCE public.rooms_id_seq OWNED BY public.rooms.id;


--
-- Name: schema_migration; Type: TABLE; Schema: public; Owner: weilyuwang
--

CREATE TABLE public.schema_migration (
    version character varying(14) NOT NULL
);


ALTER TABLE public.schema_migration OWNER TO weilyuwang;

--
-- Name: users; Type: TABLE; Schema: public; Owner: weilyuwang
--

CREATE TABLE public.users (
    id integer NOT NULL,
    first_name character varying(255) DEFAULT ''::character varying NOT NULL,
    last_name character varying(255) DEFAULT ''::character varying NOT NULL,
    email character varying(255) NOT NULL,
    password character varying(60) NOT NULL,
    access_level integer DEFAULT 1 NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.users OWNER TO weilyuwang;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: weilyuwang
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO weilyuwang;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: weilyuwang
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: reservations id; Type: DEFAULT; Schema: public; Owner: weilyuwang
--

ALTER TABLE ONLY public.reservations ALTER COLUMN id SET DEFAULT nextval('public.reservations_id_seq'::regclass);


--
-- Name: restrictions id; Type: DEFAULT; Schema: public; Owner: weilyuwang
--

ALTER TABLE ONLY public.restrictions ALTER COLUMN id SET DEFAULT nextval('public.restrictions_id_seq'::regclass);


--
-- Name: room_restrictions id; Type: DEFAULT; Schema: public; Owner: weilyuwang
--

ALTER TABLE ONLY public.room_restrictions ALTER COLUMN id SET DEFAULT nextval('public.room_restrictions_id_seq'::regclass);


--
-- Name: rooms id; Type: DEFAULT; Schema: public; Owner: weilyuwang
--

ALTER TABLE ONLY public.rooms ALTER COLUMN id SET DEFAULT nextval('public.rooms_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: weilyuwang
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: reservations reservations_pkey; Type: CONSTRAINT; Schema: public; Owner: weilyuwang
--

ALTER TABLE ONLY public.reservations
    ADD CONSTRAINT reservations_pkey PRIMARY KEY (id);


--
-- Name: restrictions restrictions_pkey; Type: CONSTRAINT; Schema: public; Owner: weilyuwang
--

ALTER TABLE ONLY public.restrictions
    ADD CONSTRAINT restrictions_pkey PRIMARY KEY (id);


--
-- Name: room_restrictions room_restrictions_pkey; Type: CONSTRAINT; Schema: public; Owner: weilyuwang
--

ALTER TABLE ONLY public.room_restrictions
    ADD CONSTRAINT room_restrictions_pkey PRIMARY KEY (id);


--
-- Name: rooms rooms_pkey; Type: CONSTRAINT; Schema: public; Owner: weilyuwang
--

ALTER TABLE ONLY public.rooms
    ADD CONSTRAINT rooms_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: weilyuwang
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: schema_migration_version_idx; Type: INDEX; Schema: public; Owner: weilyuwang
--

CREATE UNIQUE INDEX schema_migration_version_idx ON public.schema_migration USING btree (version);


--
-- PostgreSQL database dump complete
--

