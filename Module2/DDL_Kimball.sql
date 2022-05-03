CREATE SCHEMA IF NOT EXISTS module2;



-- ************************************** calendar_dim

CREATE TABLE IF NOT EXISTS module2.calendar_dim
(
 order_date date NOT NULL,
 ship_date  date NOT NULL,
 year       int NOT NULL,
 quarter    varchar(5) NOT NULL,
 month      int NOT NULL,
 week       int NOT NULL,
 week_day   int NOT NULL,
 CONSTRAINT PK_5 PRIMARY KEY ( order_date, ship_date )
);

-- ************************************** customer_dim

CREATE TABLE IF NOT EXISTS module2.customer_dim
(
 customer_id   varchar(10) NOT NULL,
 customer_name varchar(22) NOT NULL,
 CONSTRAINT PK_68 PRIMARY KEY ( customer_id )
);

-- ************************************** geography_dim

CREATE TABLE IF NOT EXISTS module2.geography_dim
(
 geo_id         serial NOT NULL,
 country        varchar(13) NOT NULL,
 region         varchar(10) NOT NULL,
 "state"          varchar(11) NOT NULL,
 city           varchar(17) NOT NULL,
 postal_code    varchar(20) NOT NULL,
 person_manager varchar(17) NOT NULL,
 CONSTRAINT PK_25 PRIMARY KEY ( geo_id )
);



-- ************************************** product_dim

CREATE TABLE IF NOT EXISTS module2.product_dim
(
 product_id   varchar(15) NOT NULL,
 category     varchar(15) NOT NULL,
 subcategory  varchar(11) NOT NULL,
 segment      varchar(11) NOT NULL,
 product_name varchar(130) NOT NULL,
 CONSTRAINT PK_59 PRIMARY KEY ( product_id )
);

-- ************************************** shipping_dim

CREATE TABLE IF NOT EXISTS module2.shipping_dim
(
 ship_id   serial NOT NULL,
 ship_mode varchar(15) NOT NULL,
 CONSTRAINT PK_70 PRIMARY KEY ( ship_id )
);


-- ************************************** sales_fact

CREATE TABLE IF NOT EXISTS module2.sales_fact
(
 row_id      serial NOT NULL,
 order_id    varchar(25) NOT NULL,
 sales       numeric(9,4) NOT NULL,
 quantity    int4range NOT NULL,
 discount    numeric(4,2) NOT NULL,
 profit      numeric(21,16) NOT NULL,
 returned    varchar(5) NOT NULL,
 product_id  varchar(15) NOT NULL,
 ship_id     serial NOT NULL,
 customer_id varchar(10) NOT NULL,
 geo_id      serial NOT NULL,
 order_date  date NOT NULL,
 ship_date   date NOT NULL,
 CONSTRAINT PK_13 PRIMARY KEY ( row_id ),
 CONSTRAINT FK_20 FOREIGN KEY ( order_date, ship_date ) REFERENCES module2.calendar_dim ( order_date, ship_date ),
 CONSTRAINT FK_54 FOREIGN KEY ( geo_id ) REFERENCES module2.geography_dim ( geo_id ),
 CONSTRAINT FK_71 FOREIGN KEY ( customer_id ) REFERENCES module2.customer_dim ( customer_id ),
 CONSTRAINT FK_74 FOREIGN KEY ( ship_id ) REFERENCES module2.shipping_dim ( ship_id ),
 CONSTRAINT FK_77 FOREIGN KEY ( product_id ) REFERENCES module2.product_dim ( product_id )
);

CREATE INDEX FK_22 ON module2.sales_fact
(
 order_date,
 ship_date
);

CREATE INDEX FK_56 ON module2.sales_fact
(
 geo_id
);

CREATE INDEX FK_73 ON module2.sales_fact
(
 customer_id
);

CREATE INDEX FK_76 ON module2.sales_fact
(
 ship_id
);

CREATE INDEX FK_79 ON module2.sales_fact
(
 product_id
);