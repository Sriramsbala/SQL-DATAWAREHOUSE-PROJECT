--Quality checks
--check for nulls or duplicates in primary key
-- expectation : No result
use datawarehouse
go

select prd_id,
count(*)
from silver.crm_prd_info
group by prd_id
having count(*) > 1 or prd_id IS NULL


-- check for unwanted spaces
-- expectation : No result

select prd_nm
from silver.crm_prd_info
where prd_nm != trim(prd_nm)

--check fro nulls or Negative numbers
-- expectation : No result

select prd_cost
from silver.crm_prd_info
where prd_cost<0 or prd_cost IS NULL

--Data Standardization & Consistency 

select distinct prd_line
from silver.crm_prd_info

--check for Invalid data orders

select * from silver.crm_prd_info
where prd_end_dt < prd_start_dt

select * from silver.crm_prd_info;



-- check for invalid dates

select sls_order_dt
from bronze.crm_sales_details
where sls_order_dt<=0 or LEN(sls_order_dt) != 8 ;

select * from bronze.crm_sales_details
where sls_order_dt > sls_ship_dt or sls_order_dt > sls_due_dt;

-- Bussiness rules : sales = quantity * price and not negative , zeros,nulls are not allowed!

select DISTINCT sls_quantity,
 sls_sales,
 sls_price
from bronze.crm_sales_details
where sls_price != sls_sales * sls_quantity or sls_price<=0 or sls_price IS NULL 
or sls_quantity IS NULL
or sls_sales<=0 or sls_quantity<=0 
or sls_sales IS NULL
