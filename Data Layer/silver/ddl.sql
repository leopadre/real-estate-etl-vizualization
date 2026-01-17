--
-- Name: one_big_table; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.one_big_table (
    id integer NOT NULL,
    brokered_by real,
    status text,
    price real,
    bed integer,
    bath integer,
    acre_lot real,
    city text,
    state text,
    zip_code text,
    house_size real,
    prev_sold_date date,
    price_per_sqft double precision,
    price_per_acre double precision,
    rooms integer
);

ALTER TABLE public.one_big_table OWNER TO postgres;

CREATE SEQUENCE public.one_big_table_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER TABLE public.one_big_table_id_seq OWNER TO postgres;

ALTER SEQUENCE public.one_big_table_id_seq OWNED BY public.one_big_table.id;

ALTER TABLE ONLY public.one_big_table ALTER COLUMN id SET DEFAULT nextval('public.one_big_table_id_seq'::regclass);

ALTER TABLE ONLY public.one_big_table
    ADD CONSTRAINT one_big_table_pkey PRIMARY KEY (id);