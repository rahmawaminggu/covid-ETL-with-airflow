truncate table fact_district_year;
INSERT INTO fact_district_year (district_id, year, case_id, total)
SELECT
       district_id,
       left(month::varchar, 4)::int as year,
       case_id,
       sum(total)
FROM fact_district_mth
GROUP BY district_id, year, case_id;
