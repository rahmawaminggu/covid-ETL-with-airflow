truncate table fact_district_mth;

INSERT INTO fact_district_mth (district_id, month, case_id, total)
SELECT district_id, to_char(tanggal, 'YYYYMM')::int as month, case_id, sum(total) as total
FROM fact_district_dly
GROUP BY district_id, month, case_id;
