truncate table dim_case;

insert into dim_case (status_name, status_detail)
with stg as (
select distinct unnest(array['suspect_meninggal','suspect_discarded','suspect_diisolasi','closecontact_dikarantina','closecontact_discarded','closecontact_meninggal'
							,'probable_diisolasi','probable_discarded','probable_meninggal','confirmation_sembuh','confirmation_meninggal']) as status_detail
from stg_covid_data
) select case
	when stg.status_detail like 'suspect%' then 'suspect'
	when stg.status_detail like 'closecontact%' then 'closecontact'
	when stg.status_detail like 'probable%' then 'probable'
	when stg.status_detail like 'confirmation%' then 'confirmation'
end as status_name,
	stg.status_detail
from stg
order by stg.status_detail
