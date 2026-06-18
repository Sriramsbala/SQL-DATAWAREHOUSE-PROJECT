-- check for NULL or Duplicates
--Expectation : not expected


select cst_id,COUNT(*) from silver.crm_cust_info
group by cst_id
HAVING COUNT(*) > 1 OR cst_id IS NULL
;

--Data Standardization & consistency

select cst_gndr
from silver.crm_cust_info
where cst_gndr IS NOT NULL

select cst_marital_status
from silver.crm_cust_info
where cst_marital_status IS NOT NULL


--check for unwanted spaces

select cst_firstname
from silver.crm_cust_info
where cst_firstname != TRIM(cst_firstname)