truncate table fact_province_mth;

INSERT INTO fact_province_mth (province_id, month, case_id, total)
SELECT
       province_id,
       to_char(tanggal, 'YYYYMM')::int as month,
       case_id,
       sum(total) as total
FROM fact_province_dly
GROUP BY province_id, month, case_id;
