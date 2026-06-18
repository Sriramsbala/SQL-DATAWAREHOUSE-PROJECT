select cid,
CASE WHEN CID LIKE 'NAS%' then SUBSTRING(cid,4,len(cid))
else cid
end as cid from bronze.erp_CUST_AZ12
where
CASE WHEN CID LIKE 'NAS%' then SUBSTRING(cid,4,len(cid))
else cid
end NOT IN (select distinct cst_key from bronze.crm_cust_info)
