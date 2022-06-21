truncate table fact_district_dly;
INSERT INTO fact_district_dly (tanggal, district_id, case_id, total)
SELECT
       tanggal,
       district_id,
       case_id,
       sum(total) as total
FROM fact_province_district_dly
GROUP BY tanggal, district_id, case_id;
