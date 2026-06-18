select prd_id,COUNT(*) from bronze.crm_prd_info
group by prd_id
HAVING COUNT(*) > 1 OR prd_id IS NULL

