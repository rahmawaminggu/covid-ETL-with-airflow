truncate table fact_province_year;
INSERT INTO fact_province_year (province_id, year, case_id, total)
SELECT
    province_id,
    left(month::varchar, 4)::int as year ,
    case_id,
    sum(total) as total
FROM fact_province_mth
GROUP BY
    province_id,
    year,
    case_id;
