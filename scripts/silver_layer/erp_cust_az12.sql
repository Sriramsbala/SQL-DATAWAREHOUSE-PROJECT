
use datawarehouse
go

INSERT INTO silver.erp_CUST_AZ12(
cid,Bdate,gen)

select CASE WHEN CID LIKE 'NAS%' then SUBSTRING(cid,4,len(cid))
else cid
end as cid,
case when bdate>getdate() THEN NULL
else bdate
end as Bdate,
case  when UPPER(TRIM(gen)) IN  ('F','Female') THEN 'Female'
when  UPPER(TRIM(gen)) IN  ('M','Male') THEN 'Male'
else 'n/a'
end as gen
from bronze.erp_CUST_AZ12;