-- Table: silver.one_big_table

-- DROP TABLE IF EXISTS silver.one_big_table;

CREATE TABLE IF NOT EXISTS silver.one_big_table
(
    id integer NOT NULL DEFAULT nextval('silver.one_big_table_id_seq'::regclass),
    brokered_by real,
    status text COLLATE pg_catalog."default",
    price real,
    bed integer,
    bath integer,
    acre_lot real,
    street real,
    city text COLLATE pg_catalog."default",
    state text COLLATE pg_catalog."default",
    zip_code text COLLATE pg_catalog."default",
    house_size real,
    prev_sold_date date,
    price_per_sqft double precision,
    price_per_acre double precision,
    rooms integer,
    CONSTRAINT one_big_table_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS silver.one_big_table
    OWNER to postgres;