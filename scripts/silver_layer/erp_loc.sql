INSERT INTO silver.erp_loc_a101(
cid,
cntry)
select replace(cid,'-','') as cid,
case when TRIM(CNTRY) = 'DE' then 'Germany'
when trim(cntry) IN ('US','USA') then 'United States'
WHEN  trim(cntry) = ' ' or cntry IS NULL then 'n/a'
else TRIM(cntry)
end as cntry
from bronze.erp_LOC_A101
