truncate table fact_province_district_dly;

INSERT INTO fact_province_district_dly (province_id, district_id, tanggal, case_id, total)
WITH ds as (
    SELECT kode_prov::int      as province_id,
           kode_kab::int       as district_id,
           tanggal::date       as tanggal,
           status_id           as case_id,
           sum(case
                   when dc.status_detail in ('suspect_discarded') then coalesce(stg.suspect_discarded, 0)
                   when dc.status_detail in ('suspect_meninggal') then coalesce(stg.suspect_meninggal, 0)
                   when dc.status_detail in ('suspect_discarded') then coalesce(stg.suspect_discarded, 0)
                   when dc.status_detail in ('probable_diisolasi') then coalesce(stg.probable_diisolasi, 0)
                   when dc.status_detail in ('probable_discarded') then coalesce(stg.probable_discarded, 0)
                   when dc.status_detail in ('probable_meninggal') then coalesce(stg.probable_meninggal, 0)
                   when dc.status_detail in ('confirmation_sembuh') then coalesce(stg.confirmation_sembuh, 0)
                   when dc.status_detail in ('confirmation_meninggal') then coalesce(stg.confirmation_meninggal, 0)
                   when dc.status_detail in ('closecontact_dikarantina') then coalesce(stg.closecontact_dikarantina, 0)
                   when dc.status_detail in ('closecontact_discarded') then coalesce(stg.closecontact_discarded, 0)
                   when dc.status_detail in ('closecontact_meninggal') then coalesce(stg.closecontact_meninggal, 0)
                   else 0 end) as total
    FROM stg_covid_data stg,
         dim_case dc
    GROUP BY province_id, district_id, tanggal, case_id
)
SELECT province_id, district_id, tanggal, case_id, total
FROM ds
WHERE total > 0;
