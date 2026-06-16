CREATE OR ALTER PROCEDURE bronze.load_bronze as
BEGIN
DECLARE @start_time DATETIME,@end_time DATETIME
BEGIN try
set @start_time = GETDATE();
    print'+++++++++++++++++++++++++++++++'
    PRINT 'Loading Bronze layer'
    print'+++++++++++++++++++++++++++++++'
    print 'Loading CRM Table'
   

    
    TRUNCATE TABLE bronze.crm_cust_info;
    BULK INSERT bronze.crm_cust_info
    FROM 'C:\Users\srira\Downloads\sql-data-warehouse\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
    WITH (
        FIRSTROW = 2,
        FIELDTERMINATOR = ',',
        ROWTERMINATOR = '\n',
        TABLOCK
    );
    

    TRUNCATE TABLE bronze.crm_prd_info;

    BULK INSERT bronze.crm_prd_info
    FROM 'C:\Users\srira\Downloads\sql-data-warehouse\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
    WITH (
        FIRSTROW = 2,
        FIELDTERMINATOR = ',',
        ROWTERMINATOR = '\n',
        TABLOCK
    );

    TRUNCATE TABLE bronze.crm_sales_details;

    BULK INSERT bronze.crm_sales_details
    FROM 'C:\Users\srira\Downloads\sql-data-warehouse\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
    WITH (
        FIRSTROW = 2,
        FIELDTERMINATOR = ',',
        ROWTERMINATOR = '\n',
        TABLOCK
    );
    print 'Loading ERP Table'
    TRUNCATE TABLE bronze.erp_CUST_AZ12;

    BULK INSERT bronze.erp_CUST_AZ12
    FROM 'C:\Users\srira\Downloads\sql-data-warehouse\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
    WITH (
        FIRSTROW = 2,
        FIELDTERMINATOR = ',',
        ROWTERMINATOR = '\n',
        TABLOCK
    );

    TRUNCATE TABLE bronze.erp_LOC_A101;

    BULK INSERT bronze.erp_LOC_A101
    FROM 'C:\Users\srira\Downloads\sql-data-warehouse\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
    WITH (
        FIRSTROW = 2,
        FIELDTERMINATOR = ',',
        ROWTERMINATOR = '\n',
        TABLOCK
    );

    TRUNCATE TABLE bronze.erp_PX_CAT_G1V2;

    BULK INSERT bronze.erp_PX_CAT_G1V2
    FROM 'C:\Users\srira\Downloads\sql-data-warehouse\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
    WITH (
        FIRSTROW = 2,
        FIELDTERMINATOR = ',',
        ROWTERMINATOR = '\n',
        TABLOCK
    );

    set @end_time = GETDATE();

    print'>> load Duration:' + CAST( DATEDIFF(second,@start_time,@end_time)as NVARCHAR) + 'seconds'
    
END TRY 
BEGIN CATCH
print ' ++++++++++++++++++++++++++++++++++++++++++++++'
print 'ERROR Message' + ERROR_MESSAGE() + CAST(ERROR_NUMBER() as NVARCHAR);

END CATCH

END