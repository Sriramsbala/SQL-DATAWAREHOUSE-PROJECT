

--select * from bronze.crm_prd_info;

INSERT INTO silver.crm_prd_info(
prd_id,
cat_id,
    prd_key,
    prd_nm ,
    prd_cost ,
    prd_line ,
    prd_start_dt,
    prd_end_dt)
select prd_id,
replace(SUBSTRING(prd_key,1,5),'-','_')as cat_id,
SUBSTRING(prd_key,7,len(prd_key)) as prd_key,
prd_nm,
ISNULL (prd_cost,0) as prd_cost,
CASE WHEN UPPER(TRIM(prd_line)) = 'M' then 'Mountain'
when UPPER(TRIM(prd_line)) = 'R'  then 'Road'
when UPPER(TRIM(prd_line)) = 'S' then 'Other Sales'
when UPPER(TRIM(prd_line)) = 'T' then 'Touring'
else 'n/a'
end as prd_line,
cast(prd_start_dt as date) as prd_start_dt,
cast(DATEADD(                                   -- This is Data Enrichment adding new value for data analysis 
        DAY,
        -1,
        LEAD(prd_start_dt) OVER (
            PARTITION BY prd_key
            ORDER BY prd_start_dt
        ))as date) as prd_end_dt

from bronze.crm_prd_info
--where replace(SUBSTRING(prd_key,1,5),'-','_') NOT IN
--(select distinct id from bronze.erp_PX_CAT_G1V2);