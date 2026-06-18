USE DataWarehouse; 
GO

INSERT INTO silver.crm_cust_info(
cst_id,
cst_key,
cst_firstname,
cst_lastname,
cst_marital_status,
cst_gndr,cst_create_date)
select cst_id,cst_key,TRIM(cst_firstname) AS cst_firstname,TRIM(cst_lastname) as cst_lastname,

CASE WHEN cst_marital_status = 'S' THEN 'Single'
 WHEN cst_marital_status = 'M' THEN 'Married'
 ELSE 'n/a'
 END cst_marital_status,
CASE WHEN cst_gndr = 'F' THEN 'Female'
 WHEN cst_gndr = 'M' THEN 'Male'
 ELSE 'n/a'
 END cst_gndr,cst_create_date from(
select * , ROW_number() OVER ( partition by cst_id Order by cst_create_date Desc) as flag from bronze.crm_cust_info
) t WHERE flag = 1 and cst_id IS NOT NULL;

