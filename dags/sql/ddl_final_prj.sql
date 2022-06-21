DROP TABLE IF EXISTS dim_case;
create table dim_case
(
    status_id     serial primary key,
    status_name   varchar(255),
    status_detail varchar(255)
);

DROP TABLE IF EXISTS dim_province;
create table dim_province
(
    province_id   int,
    province_name varchar(255)
);

DROP TABLE IF EXISTS dim_district;
create table dim_district
(
    district_id   int,
    province_id   int,
    district_name varchar(255)
);

DROP TABLE IF EXISTS fact_province_district_dly;
create table fact_province_district_dly
(
    pk_id       serial primary key,
    province_id int,
    district_id int,
    tanggal     date,
    case_id     int,
    total       bigint
);

DROP TABLE IF EXISTS fact_province_dly;
create table fact_province_dly
(
    pk_id       serial primary key,
    tanggal     date,
    province_id int,
    case_id     int,
    total       bigint
);

DROP TABLE IF EXISTS fact_province_mth;
create table fact_province_mth
(
    pk_id       serial primary key,
    province_id int,
    month       int,
    case_id     int,
    total       bigint
);

DROP TABLE IF EXISTS fact_province_year;
create table fact_province_year
(
    pk_id       serial primary key,
    province_id int,
    year        int,
    case_id     int,
    total       bigint
);

DROP TABLE IF EXISTS fact_district_dly;
create table fact_district_dly
(
    pk_id       serial primary key,
    tanggal     date,
    district_id int,
    case_id     int,
    total       bigint
);

DROP TABLE IF EXISTS fact_district_mth;
create table fact_district_mth
(
    pk_id       serial primary key,
    district_id int,
    month       int,
    case_id     int,
    total       bigint
);

DROP TABLE IF EXISTS fact_district_year;
create table fact_district_year
(
    pk_id       serial primary key,
    district_id int,
    year        int,
    case_id     int,
    total       bigint
);
