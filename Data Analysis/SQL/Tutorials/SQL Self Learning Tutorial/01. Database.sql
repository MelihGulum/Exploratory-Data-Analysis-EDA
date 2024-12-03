/*
	Database Operations
	    CREATE DB, SELECT DB, DROP DB, RENAME DB, BACKUP DB, RESTORE DB FROM BACKUP
*/

--------------------------------------------------------------------------------------------------------------------------
-- Create Database
--------------------------------------------------------------------------------------------------------------------------
CREATE DATABASE TestDB;


--------------------------------------------------------------------------------------------------------------------------
-- Select Database
--------------------------------------------------------------------------------------------------------------------------
USE TestDB;


--------------------------------------------------------------------------------------------------------------------------
-- Show all stored databases
--------------------------------------------------------------------------------------------------------------------------
EXEC sp_databases; -- with stored procedure

SELECT *
FROM master.sys.databases;


--------------------------------------------------------------------------------------------------------------------------
/* Drop Database
    The database name can't be drop while currently using.
    USE [another_database_name]
*/
--------------------------------------------------------------------------------------------------------------------------
DROP DATABASE IF EXISTS TestDB; -- Drop single database

DROP DATABASE IF EXISTS [database_name], [database_name2]; -- Drop multiple database


--------------------------------------------------------------------------------------------------------------------------
/* Rename Database
    The database name can't be changed while other users are accessing the database.
    USE [another_database_name]
*/
--------------------------------------------------------------------------------------------------------------------------
ALTER DATABASE TestDB MODIFY NAME = DemoDB;


--------------------------------------------------------------------------------------------------------------------------
/* Backup Database
    There are three types of database backups available. These are:
        Full Backup
        Differential Backup
        Transaction Log (T-log) backup
*/
--------------------------------------------------------------------------------------------------------------------------
-- Full Backup
BACKUP DATABASE TestDB
TO DISK = 'C:\BACKUP\TestDB_v1.bak';

-- Differential Backup
BACKUP DATABASE TestDB
TO DISK = 'C:\BACKUP\TestDB_v2.bak' 
   WITH DIFFERENTIAL;

/* Transaction Log (T-log) backup
   Error 4208 Solution: The simple recovery model doesn’t support log backups. Switch to Full recovery
     ALTER DATABASE TestDB 
     SET RECOVERY FULL;
*/
BACKUP LOG TestDB
TO DISK = 'C:\BACKUP\TestDB_v3.trn';


--------------------------------------------------------------------------------------------------------------------------
-- Restore Database From Backup
--------------------------------------------------------------------------------------------------------------------------
USE master
RESTORE DATABASE TestDB
FROM DISK = 'C:\BACKUP\TestDB_v1.bak'
WITH REPLACE;
