
INSERT INTO silver.crm_sales_details(
sls_ord_num,
sls_prd_key,
sls_cust_id,
sls_order_dt,
sls_ship_dt,
sls_due_dt,
sls_quantity,
sls_sales,sls_price)

select 
sls_ord_num,
sls_prd_key,
sls_cust_id,
case when sls_order_dt = 0 or len(sls_order_dt) != 8 then null
else CAST(CAST(sls_order_dt as varchar) as date) 
end as sls_order_date,
case when sls_ship_dt = 0 or len(sls_ship_dt) != 8 then null
else CAST(CAST(sls_ship_dt as varchar) as date) 
end as sls_ship_dt,
case when sls_due_dt = 0 or len(sls_due_dt) != 8 then null
else CAST(CAST(sls_due_dt as varchar) as date) 
end as sls_due_dt,
sls_quantity,
case when sls_sales IS NULL or sls_sales<=0 or sls_sales != sls_quantity * ABS(sls_price)
then sls_quantity * abs(sls_price)
else sls_sales
end as sls_sales,
case when sls_price IS NULL or sls_price <=0
then sls_sales/NULLIF(sls_quantity,0)
else sls_price
end as sls_price

from bronze.crm_sales_details
