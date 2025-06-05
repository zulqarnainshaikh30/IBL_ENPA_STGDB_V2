SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[SourceSystemCountCheck]
AS
BEGIN

select REPLACE(DataTemplates,'TXN','TRANSACTION')DataTemplates,SRC_Count as SourceCount, STG_Count as StagingCount
from (
		select 
		(CASE WHEN TableName like '%01%' then 'FINACLE ' + REPLACE(TABLENAME,'_SOURCESYSTEM01_STG','')
		 WHEN TableName like '%02%' then 'INDUS ' +REPLACE(TABLENAME,'_SOURCESYSTEM02_STG','')
		WHEN TableName like '%03%' then 'ECBF ' +REPLACE(TABLENAME,'_SOURCESYSTEM03_STG','')
		 WHEN TableName like '%04%' then'MIFIN ' + REPLACE(TABLENAME,'_SOURCESYSTEM04_STG','')
		 WHEN TableName like '%05%' then'GANASEVA ' +  REPLACE(TABLENAME,'_SOURCESYSTEM05_STG','')
		 WHEN TableName like '%06%' then'VisionPlus ' +REPLACE(TABLENAME,'_SOURCESYSTEM06_STG','')
		else TableName END) DataTemplates
		,SRC_Count,STG_COUNT from table_Audit where EXT_Date = '07/20/2021' 
		and SRC_Count > 0 
)x
where DataTemplates not like '%_STG%'
order by DataTemplates


-------------------------------------------Only Source Count
select REPLACE(DataTemplates,'TXN','TRANSACTION')DataTemplates,SRC_Count as SourceCount
from (
		select 
		(CASE WHEN TableName like '%01%' then 'FINACLE ' + REPLACE(TABLENAME,'_SOURCESYSTEM01_STG','')
		 WHEN TableName like '%02%' then 'INDUS ' +REPLACE(TABLENAME,'_SOURCESYSTEM02_STG','')
		WHEN TableName like '%03%' then 'ECBF ' +REPLACE(TABLENAME,'_SOURCESYSTEM03_STG','')
		 WHEN TableName like '%04%' then'MIFIN ' + REPLACE(TABLENAME,'_SOURCESYSTEM04_STG','')
		 WHEN TableName like '%05%' then'GANASEVA ' +  REPLACE(TABLENAME,'_SOURCESYSTEM05_STG','')
		 WHEN TableName like '%06%' then'VisionPlus ' +REPLACE(TABLENAME,'_SOURCESYSTEM06_STG','')
		else TableName END) DataTemplates
		,SRC_Count,STG_COUNT from table_Audit where EXT_Date = '07/20/2021' 
		and SRC_Count > 0 
)x
where DataTemplates not like '%_STG%'
order by DataTemplates

select SourceSystem,CustomerID,UCIC_ID
from CUSTOMER_ALL_SOURCE_SYSTEM 
where UCIC_ID is NULL

END

GO