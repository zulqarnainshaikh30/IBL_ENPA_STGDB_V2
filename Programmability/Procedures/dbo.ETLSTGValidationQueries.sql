SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROC [dbo].[ETLSTGValidationQueries]
AS
BEGIN

Declare @ProcessDate date = (select Date from Automate_Advances where Ext_flg = 'Y')

DECLARE @SQL varchar(max)
DECLARE @Merge varchar(max)

--Account Id not in Customer Data 
-----------------------------------
IF  (select count(1) from (select distinct CustomerID from LMS_ACCOUNT_STG except select distinct CustomerID from CBS_CUSTOMER_STG)x 
		) > 0
BEGIN 

 DROP TABLE IF EXISTS #Account 
 select distinct SourceSystem,CustomerID into #Account from LMS_ACCOUNT_STG 
 where CustomerID in 
 (select distinct CustomerID  from LMS_ACCOUNT_STG except select distinct CustomerID from CBS_CUSTOMER_STG) 
 SET @Merge = (
					select STUFF((select ', ' + CustomerID from #Account B WHERE B.SourceSystem = A.SourceSystem
					FOR XML PATH('')),1,1,'') as CustomerID
					from #Account A
					group by SourceSystem
				) 
 SET @SQL = 'CustomerID from Account file '+ @Merge+ ' not available in Customer file' 

INSERT INTO  PackageErrorLogs 
(MachineName,PackageName,TaskName,ErrorCode,ErrorDescription,Date,ReportingDate)
values 
('D2K135','UTKSSourceToSTG','CBS_CUSTOMER_STG','',@SQL,GETDATE(),@ProcessDate)

RAISERROR ('CustomerId in Account files are not available in Customer Files , Please check....',16,1)

END
--Security CustomerID Available in Customer Data
--------------------------------------------------

IF (select count(1) from (select distinct Customer_ID from LMS_SECURITY_STG 
						except 
						select distinct CustomerID from CBS_CUSTOMER_STG)x 
		) > 0
BEGIN 

DROP TABLE IF EXISTS #SecCustomer 
select distinct SourceSystem,Customer_ID  as CustomerID into #SecCustomer from LMS_SECURITY_STG 
 where Customer_ID in 
					(
						select distinct Customer_ID  from LMS_SECURITY_STG
						except
						select distinct CustomerID from CBS_CUSTOMER_STG
					) 
SET @Merge = (
					select STUFF((select ', ' + CustomerID  from #SecCustomer B WHERE B.SourceSystem = A.SourceSystem
					FOR XML PATH('')),1,1,'') as CustomerID
					from #SecCustomer A
					group by SourceSystem
				)

 SET @SQL = 'CustomerID from Security Customer file '+ @Merge + ' not available in Customer file'
	
INSERT INTO  PackageErrorLogs 
(MachineName,PackageName,TaskName,ErrorCode,ErrorDescription,Date,ReportingDate)
values 
('D2K135','UTKSSourceToSTG', 'LMS_SECURITY_STG','',@SQL,GETDATE(),@ProcessDate)

RAISERROR ('CustomerId in Security Customer files are not available in Customer Files , Please check....',16,1)

END
--Security AccountID available in Account Data
----------------------------------------------- 

IF (select count(1) from (
							select distinct AccountID from LMS_SECURITY_STG 
							except 
							select distinct CustomerAcID from LMS_ACCOUNT_STG) x 
						) > 0
BEGIN 

 DROP TABLE IF EXISTS #SecAccount
 select distinct SourceSystem,AccountID into #SecAccount from LMS_SECURITY_STG 
 where AccountID in (
						select distinct AccountID from LMS_SECURITY_STG 
						except 
						select distinct CustomerAcID from LMS_ACCOUNT_STG
					)

SET @Merge = (
					select STUFF((select ', ' + AccountID from #SecAccount B WHERE B.SourceSystem = A.SourceSystem
					FOR XML PATH('')),1,1,'') as AccountID from #SecAccount A
					group by SourceSystem
				)

 SET @SQL = 'AccountID from Security Account file '+ @Merge+ ' not available in Account file'
	

INSERT INTO  PackageErrorLogs 
(MachineName,PackageName,TaskName,ErrorCode,ErrorDescription,Date,ReportingDate)
values 
('D2K135','ENBDSourceToSTG', 'LMS_SECURITY_STG','',@SQL,GETDATE(),@ProcessDate)

RAISERROR ('AccountID in Security Account files are not available in Account Files , Please check....',16,1)

END
--Transaction AccountID available in Account Data
-------------------------------------------------

IF     (select count(1) from (	select distinct AccountID from LMS_TXN_STG 
								except 
								select distinct CustomerAcID from LMS_ACCOUNT_STG)x 
		) > 0
BEGIN 

 DROP TABLE IF EXISTS #SecTxn
 select distinct SourceSystem,AccountID
 into #SecTxn
 from LMS_TXN_STG 
 where AccountID in (
						select distinct AccountID from LMS_TXN_STG 
						except 
						select distinct CustomerAcID from LMS_ACCOUNT_STG
					)

SET @Merge = (
					select STUFF((select ', ' + AccountID from #SecTxn B WHERE B.SourceSystem = A.SourceSystem
					FOR XML PATH('')),1,1,'') as AccountID from #SecTxn A
					group by SourceSystem
				)

 SET @SQL = 'AccountID from Transaction file '+ @Merge+ ' not available in Account file'
	

INSERT INTO  PackageErrorLogs 
(MachineName,PackageName,TaskName,ErrorCode,ErrorDescription,Date,ReportingDate)
values 
('D2K135','ENBDSourceToSTG', 'FINACLE_Transaction_STG','',@SQL,GETDATE(),@ProcessDate)

RAISERROR ('AccountID in Transaction files are not available in Account Files , Please check....',16,1)

END


--Basic IssuerID available in Issuer Data
-----------------------------------------

--IF     (select count(1) from (select distinct IssuerID from CALYPSO_INVBASIC_STG 
--		except select distinct IssuerID from CALYPSO_INVISSUER_STG)x 
--		) > 0
--BEGIN 

-- DROP TABLE IF EXISTS #Basic 
-- select distinct SourceSystem,IssuerID 
-- into #Basic 
-- from CALYPSO_INVBASIC_STG where IssuerID in (
-- select distinct IssuerID from CALYPSO_INVBASIC_STG 
--		except select distinct IssuerID from CALYPSO_INVISSUER_STG
--)

--SET @Merge = (
--					select STUFF((select ', ' + IssuerID 
--					from #Basic B
--					WHERE B.SourceSystem = A.SourceSystem
--					FOR XML PATH('')),1,1,'') as IssuerID
--					from #Basic A
--					group by SourceSystem
--				)

-- SET @SQL = 'IssuerID from Investment Basic file '+ @Merge
--	+ ' not available in Investment Issuer file'
	

--	INSERT INTO  PackageErrorLogs (MachineName
--,PackageName
--,TaskName
--,ErrorCode
--,ErrorDescription
--,Date
--,ReportingDate)
--values ('D2K135','ENBDSourceToSTG', 'CALYPSO_INVBASIC_STG','',@SQL,GETDATE(),@ProcessDate)

--RAISERROR ('IssuerID in Calypso Basic files are not available in Calypso Issuer Files , Please check....',16,1)

--END
----------------------------------Financial IssuerID available in Issuer Data-------

--IF     (select count(1) from (select distinct IssuerID from CALYPSO_INVFinancial_STG 
--		except select distinct IssuerID from CALYPSO_INVISSUER_STG)x 
--		) > 0
--BEGIN 

-- DROP TABLE IF EXISTS #Financial 
-- select distinct SourceSystem,IssuerID 
-- into #Financial 
-- from CALYPSO_INVFinancial_STG where IssuerID in (
-- select distinct IssuerID from CALYPSO_INVFinancial_STG 
--		except select distinct IssuerID from CALYPSO_INVISSUER_STG
--)

--SET @Merge = (
--					select STUFF((select ', ' + IssuerID 
--					from #Financial B
--					WHERE B.SourceSystem = A.SourceSystem
--					FOR XML PATH('')),1,1,'') as IssuerID
--					from #Financial A
--					group by SourceSystem
--				)

-- SET @SQL = 'IssuerID from Investment Financial file '+ @Merge
--	+ ' not available in Investment Issuer file'
	

--	INSERT INTO  PackageErrorLogs (MachineName
--,PackageName
--,TaskName
--,ErrorCode
--,ErrorDescription
--,Date
--,ReportingDate)
--values ('D2K135','ENBDSourceToSTG', 'CALYPSO_INVFinancial_STG','',@SQL,GETDATE(),@ProcessDate)

--RAISERROR ('IssuerID in Calypso Financial files are not available in Calypso Issuer Files , Please check....',16,1)

--END
----------------------------------Financial InvID available in Basic data------------

--IF     (select count(1) from (select distinct InvID from CALYPSO_INVFinancial_STG 
--		except select distinct InvID from CALYPSO_INVBASIC_STG)x 
--		) > 0
--BEGIN 

-- DROP TABLE IF EXISTS #InvFinancial 
-- select distinct SourceSystem,InvID 
-- into #InvFinancial 
-- from CALYPSO_INVFinancial_STG where InvID in (
-- select distinct InvID from CALYPSO_INVFinancial_STG 
--		except select distinct InvID from CALYPSO_INVBASIC_STG
--)

--SET @Merge = (
--					select STUFF((select ', ' + InvID 
--					from #InvFinancial B
--					WHERE B.SourceSystem = A.SourceSystem
--					FOR XML PATH('')),1,1,'') as InvID
--					from #InvFinancial A
--					group by SourceSystem
--				)

-- SET @SQL = 'InvID from Investment Financial file '+ @Merge
--	+ ' not available in Investment Basic file'
	

--	INSERT INTO  PackageErrorLogs (MachineName
--,PackageName
--,TaskName
--,ErrorCode
--,ErrorDescription
--,Date
--,ReportingDate)
--values ('D2K135','ENBDSourceToSTG', 'CALYPSO_INVFinancial_STG','',@SQL,GETDATE(),@ProcessDate)

--RAISERROR ('InvID in Calypso Financial files are not available in Calypso Basic Files , Please check....',16,1)

--END
---------------------------Mandatory Check-----------

IF     (select count(1) from CBS_CUSTOMER_STG where ISNULL(CustomerID,'') = ''
		) > 0
BEGIN 


 DROP TABLE IF EXISTS #CustomerMand 
 select distinct SourceSystem,CustomerID 
 into #CustomerMand
 from CBS_CUSTOMER_STG where ISNULL(CustomerID,'') = ''

--SET @Merge = (
--					select STUFF((select ', ' + CustomerID 
--					from #CustomerMand B
--					WHERE B.SourceSystem = A.SourceSystem
--					FOR XML PATH('')),1,1,'') as CustomerID
--					from #CustomerMand A
--					group by SourceSystem
--				)

 SET @SQL = 'CustomerID from Finacle Customer file should be Mandatory'
	

	INSERT INTO  PackageErrorLogs (MachineName
,PackageName
,TaskName
,ErrorCode
,ErrorDescription
,Date
,ReportingDate)
values ('D2K135','ENBDSourceToSTG', 'CBS_CUSTOMER_STG','',@SQL,GETDATE(),@ProcessDate)

RAISERROR ('CustomerID in Finacle Customer files should be mandatory , Please check....',16,1)

END

--------------------------CustomerName 

IF     (select count(1) from CBS_CUSTOMER_STG where ISNULL(CustomerName,'') = ''
		) > 0
BEGIN 


 DROP TABLE IF EXISTS #CustomerNameMand 
 select distinct SourceSystem,CustomerID 
 into #CustomerNameMand
 from CBS_CUSTOMER_STG where ISNULL(CustomerName,'') = ''

SET @Merge = (
					select STUFF((select ', ' + CustomerID 
					from #CustomerNameMand B
					WHERE B.SourceSystem = A.SourceSystem
					FOR XML PATH('')),1,1,'') as CustomerID
					from #CustomerNameMand A
					group by SourceSystem
				)

 SET @SQL = 'CustomerName from Finacle Customer file '+ @Merge
	+ ' should be Mandatory'
	

	INSERT INTO  PackageErrorLogs (MachineName
,PackageName
,TaskName
,ErrorCode
,ErrorDescription
,Date
,ReportingDate)
values ('D2K135','ENBDSourceToSTG', 'CBS_CUSTOMER_STG','',@SQL,GETDATE(),@ProcessDate)

RAISERROR ('CustomerName in Finacle Customer files should be mandatory , Please check....',16,1)

END
---------------------------------------------CustomerACID

IF     (select count(1) from LMS_ACCOUNT_STG where ISNULL(CustomerAcID,'') = ''
		) > 0
BEGIN 


 DROP TABLE IF EXISTS #CustomerACIDMand 
 select distinct SourceSystem,CustomerAcID 
 into #CustomerACIDMand
 from LMS_ACCOUNT_STG where ISNULL(CustomerAcID,'') = ''

--SET @Merge = (
--					select STUFF((select ', ' + CustomerAcID 
--					from #CustomerACIDMand B
--					WHERE B.SourceSystem = A.SourceSystem
--					FOR XML PATH('')),1,1,'') as CustomerAcID
--					from #CustomerACIDMand A
--					group by SourceSystem
--				)

 SET @SQL = 'CustomerAcID from Finacle Account file should be Mandatory'
	

	INSERT INTO  PackageErrorLogs (MachineName
,PackageName
,TaskName
,ErrorCode
,ErrorDescription
,Date
,ReportingDate)
values ('D2K135','ENBDSourceToSTG', 'LMS_ACCOUNT_STG','',@SQL,GETDATE(),@ProcessDate)

RAISERROR ('CustomerAcID in Finacle Account files should be mandatory , Please check....',16,1)

END
---------------------------------------------GLCode

IF     (select count(1) from LMS_ACCOUNT_STG where ISNULL(GLCode,'') = ''
		) > 0
BEGIN 


 DROP TABLE IF EXISTS #GLCodeMand 
 select distinct SourceSystem,CustomerACID 
 into #GLCodeMand
 from LMS_ACCOUNT_STG where ISNULL(GLCode,'') = ''

SET @Merge = (
					select STUFF((select ', ' + CustomerACID 
					from #GLCodeMand B
					WHERE B.SourceSystem = A.SourceSystem
					FOR XML PATH('')),1,1,'') as CustomerACID
					from #GLCodeMand A
					group by SourceSystem
				)

 SET @SQL = 'GLCode from Finacle Account file '+ @Merge
	+ ' should be Mandatory'
	

	INSERT INTO  PackageErrorLogs (MachineName
,PackageName
,TaskName
,ErrorCode
,ErrorDescription
,Date
,ReportingDate)
values ('D2K135','ENBDSourceToSTG', 'LMS_ACCOUNT_STG','',@SQL,GETDATE(),@ProcessDate)

RAISERROR ('GLCode in Finacle Account files should be mandatory , Please check....',16,1)

END
----------------------------------------------Scheme ProductCode

IF     (select count(1) from LMS_ACCOUNT_STG where ISNULL(Scheme_ProductCode,'') = ''
		) > 0
BEGIN 


 DROP TABLE IF EXISTS #Scheme_ProductCodeMand 
 select distinct SourceSystem,CustomerACID 
 into #Scheme_ProductCodeMand
 from LMS_ACCOUNT_STG where ISNULL(Scheme_ProductCode,'') = ''

SET @Merge = (
					select STUFF((select ', ' + CustomerACID 
					from #Scheme_ProductCodeMand B
					WHERE B.SourceSystem = A.SourceSystem
					FOR XML PATH('')),1,1,'') as CustomerACID
					from #Scheme_ProductCodeMand A
					group by SourceSystem
				)

 SET @SQL = 'Scheme_ProductCode from Finacle Account file '+ @Merge
	+ ' should be Mandatory'
	

	INSERT INTO  PackageErrorLogs (MachineName
,PackageName
,TaskName
,ErrorCode
,ErrorDescription
,Date
,ReportingDate)
values ('D2K135','ENBDSourceToSTG', 'LMS_ACCOUNT_STG','',@SQL,GETDATE(),@ProcessDate)

RAISERROR ('Scheme_ProductCode in Finacle Account files should be mandatory , Please check....',16,1)

END
---------------------------------------------NPADate mandatory-----------

IF     (select count(1) from (
select distinct CustomerAcID from LMS_ACCOUNT_STG where  AssetclassCode = '002' and ISNULL(NPADate,'') = '' )x 
		) > 0
BEGIN 

 DROP TABLE IF EXISTS #NPADateMandatory
 select distinct SourceSystem,CustomerAcID 
 into #NPADateMandatory 
 from LMS_ACCOUNT_STG where CustomerAcID in (
 select distinct CustomerAcID from LMS_ACCOUNT_STG where  AssetclassCode = '002' and ISNULL(NPADate,'') = '' 
)

SET @Merge = (
					select STUFF((select ', ' + CustomerAcID 
					from #NPADateMandatory B
					WHERE B.SourceSystem = A.SourceSystem
					FOR XML PATH('')),1,1,'') as CustomerAcID
					from #NPADateMandatory A
					group by SourceSystem
				)

 SET @SQL = 'NPA Account ID from Account file '+ @Merge
	+ ' should have NPA Date Mandatory'
	

	INSERT INTO  PackageErrorLogs (MachineName
,PackageName
,TaskName
,ErrorCode
,ErrorDescription
,Date
,ReportingDate)
values ('D2K135','ENBDSourceToSTG', 'LMS_ACCOUNT_STG','',@SQL,GETDATE(),@ProcessDate)

RAISERROR ('NPA Account ID from Account files should have NPA Date Mandatory , Please check....',16,1)

END



-----------------------------------------------------Txn ID

IF     (select count(1) from FINACLE_TXN_STG where ISNULL(TxnID,'') = ''
		) > 0
BEGIN 


 DROP TABLE IF EXISTS #TxnIDMand 
 select distinct SourceSystem,TxnID 
 into #TxnIDMand
 from FINACLE_TXN_STG where ISNULL(TxnID,'') = ''

SET @Merge = (
					select STUFF((select ', ' + TxnID 
					from #TxnIDMand B
					WHERE B.SourceSystem = A.SourceSystem
					FOR XML PATH('')),1,1,'') as TxnID
					from #TxnIDMand A
					group by SourceSystem
				)

 SET @SQL = 'TxnID from Finacle Transaction file '+ @Merge
	+ ' should be Mandatory'
	

	INSERT INTO  PackageErrorLogs (MachineName
,PackageName
,TaskName
,ErrorCode
,ErrorDescription
,Date
,ReportingDate)
values ('D2K135','ENBDSourceToSTG', 'FINACLE_TXN_STG','',@SQL,GETDATE(),@ProcessDate)

RAISERROR ('TxnID in Finacle Transaction files should be mandatory , Please check....',16,1)

END
----------------------------------------------------Txn Date

IF     (select count(1) from FINACLE_TXN_STG where ISNULL(TxnDate,'') = ''
		) > 0
BEGIN 


 DROP TABLE IF EXISTS #TxnDateMand 
 select distinct SourceSystem,TxnID 
 into #TxnDateMand
 from FINACLE_TXN_STG where ISNULL(TxnDate,'') = ''

SET @Merge = (
					select STUFF((select ', ' + TxnID 
					from #TxnDateMand B
					WHERE B.SourceSystem = A.SourceSystem
					FOR XML PATH('')),1,1,'') as TxnID
					from #TxnDateMand A
					group by SourceSystem
				)

 SET @SQL = 'TxnDate from Finacle Transaction file '+ @Merge
	+ ' should be Mandatory'
	

	INSERT INTO  PackageErrorLogs (MachineName
,PackageName
,TaskName
,ErrorCode
,ErrorDescription
,Date
,ReportingDate)
values ('D2K135','ENBDSourceToSTG', 'FINACLE_TXN_STG','',@SQL,GETDATE(),@ProcessDate)

RAISERROR ('TxnDate in Finacle Transaction files should be mandatory , Please check....',16,1)

END

---------------------------------------------------Txn AccountID

IF     (select count(1) from FINACLE_TXN_STG where ISNULL(AccountID,'') = ''
		) > 0
BEGIN 


 DROP TABLE IF EXISTS #AccountTxnMand 
 select distinct SourceSystem,TxnID 
 into #AccountTxnMand
 from FINACLE_TXN_STG where ISNULL(AccountID,'') = ''

SET @Merge = (
					select STUFF((select ', ' + TxnID 
					from #AccountTxnMand B
					WHERE B.SourceSystem = A.SourceSystem
					FOR XML PATH('')),1,1,'') as TxnID
					from #AccountTxnMand A
					group by SourceSystem
				)

 SET @SQL = 'AccountID from Finacle Transaction file '+ @Merge
	+ ' should be Mandatory'
	

	INSERT INTO  PackageErrorLogs (MachineName
,PackageName
,TaskName
,ErrorCode
,ErrorDescription
,Date
,ReportingDate)
values ('D2K135','ENBDSourceToSTG', 'FINACLE_TXN_STG','',@SQL,GETDATE(),@ProcessDate)

RAISERROR ('AccountID in Finacle Transaction files should be mandatory , Please check....',16,1)

END
--=======================================================================Calypso=================


-------------------------------------------------------------IssuerID

--IF     (select count(1) from CALYPSO_INVISSUER_STG where ISNULL(IssuerID,'') = ''
--		) > 0
--BEGIN 


-- DROP TABLE IF EXISTS #IssuerIDMand 
-- select distinct SourceSystem,IssuerID 
-- into #IssuerIDMand
-- from CALYPSO_INVISSUER_STG where ISNULL(IssuerID,'') = ''

----SET @Merge = (
----					select STUFF((select ', ' + IssuerID 
----					from #IssuerIDMand B
----					WHERE B.SourceSystem = A.SourceSystem
----					FOR XML PATH('')),1,1,'') as IssuerID
----					from #IssuerIDMand A
----					group by SourceSystem
----				)

-- SET @SQL = 'IssuerID from Calypso Issuer file should be Mandatory'
	

--	INSERT INTO  PackageErrorLogs (MachineName
--,PackageName
--,TaskName
--,ErrorCode
--,ErrorDescription
--,Date
--,ReportingDate)
--values ('D2K135','ENBDSourceToSTG', 'CALYPSO_INVISSUER_STG','',@SQL,GETDATE(),@ProcessDate)

--RAISERROR ('IssuerID in Calypso IssuerID files should be mandatory , Please check....',16,1)

--END

------------------------------------------------------------UCIC_ID


--IF     (select count(1) from CALYPSO_INVISSUER_STG where ISNULL(UCIC_ID,'') = ''
--		) > 0
--BEGIN 


-- DROP TABLE IF EXISTS #UCIC_IDMand 
-- select distinct SourceSystem,IssuerID 
-- into #UCIC_IDMand
-- from CALYPSO_INVISSUER_STG where ISNULL(UCIC_ID,'') = ''

--SET @Merge = (
--					select STUFF((select ', ' + IssuerID 
--					from #UCIC_IDMand B
--					WHERE B.SourceSystem = A.SourceSystem
--					FOR XML PATH('')),1,1,'') as IssuerID
--					from #UCIC_IDMand A
--					group by SourceSystem
--				)

-- SET @SQL = 'UCIC_ID from Calypso Issuer file '+ @Merge
--	+ ' should be Mandatory'
	

--	INSERT INTO  PackageErrorLogs (MachineName
--,PackageName
--,TaskName
--,ErrorCode
--,ErrorDescription
--,Date
--,ReportingDate)
--values ('D2K135','ENBDSourceToSTG', 'CALYPSO_INVISSUER_STG','',@SQL,GETDATE(),@ProcessDate)

--RAISERROR ('UCIC_ID in Calypso IssuerID files should be mandatory , Please check....',16,1)

--END
-------------------------------------------------------------Ref_Cust-----------

--IF     (select count(1) from CALYPSO_INVISSUER_STG where ISNULL(Ref_Txn_Sys_Cust_ID,'') = ''
--		) > 0
--BEGIN 


-- DROP TABLE IF EXISTS #Ref_Txn_Sys_Cust_IDMand 
-- select distinct SourceSystem,IssuerID 
-- into #Ref_Txn_Sys_Cust_IDMand
-- from CALYPSO_INVISSUER_STG where ISNULL(Ref_Txn_Sys_Cust_ID,'') = ''

--SET @Merge = (
--					select STUFF((select ', ' + IssuerID 
--					from #Ref_Txn_Sys_Cust_IDMand B
--					WHERE B.SourceSystem = A.SourceSystem
--					FOR XML PATH('')),1,1,'') as IssuerID
--					from #Ref_Txn_Sys_Cust_IDMand A
--					group by SourceSystem
--				)

-- SET @SQL = 'Ref_Txn_Sys_Cust_ID from Calypso Issuer file '+ @Merge
--	+ ' should be Mandatory'
	

--	INSERT INTO  PackageErrorLogs (MachineName
--,PackageName
--,TaskName
--,ErrorCode
--,ErrorDescription
--,Date
--,ReportingDate)
--values ('D2K135','ENBDSourceToSTG', 'CALYPSO_INVISSUER_STG','',@SQL,GETDATE(),@ProcessDate)

--RAISERROR ('Ref_Txn_Sys_Cust_ID in Calypso Issuer files should be mandatory , Please check....',16,1)

--END


------------------------------------------------------------------Basic InviD---

--IF     (select count(1) from CALYPSO_INVBASIC_STG where ISNULL(InvID,'') = ''
--		) > 0
--BEGIN 


-- DROP TABLE IF EXISTS #InvIDMand 
-- select distinct SourceSystem,InvID 
-- into #InvIDMand
-- from CALYPSO_INVBASIC_STG where ISNULL(InvID,'') = ''

----SET @Merge = (
----					select STUFF((select ', ' + InvID 
----					from #InvIDMand B
----					WHERE B.SourceSystem = A.SourceSystem
----					FOR XML PATH('')),1,1,'') as InvID
----					from #InvIDMand A
----					group by SourceSystem
----				)

-- SET @SQL = 'InvID from Calypso Basic file should be Mandatory'
	

--	INSERT INTO  PackageErrorLogs (MachineName
--,PackageName
--,TaskName
--,ErrorCode
--,ErrorDescription
--,Date
--,ReportingDate)
--values ('D2K135','ENBDSourceToSTG', 'CALYPSO_INVBASIC_STG','',@SQL,GETDATE(),@ProcessDate)

--RAISERROR ('InvID in Calypso Basic files should be mandatory , Please check....',16,1)

--END


----------------------------------------------------------------Basic Issuerid

--IF     (select count(1) from CALYPSO_INVBASIC_STG where ISNULL(IssuerID,'') = ''
--		) > 0
--BEGIN 


-- DROP TABLE IF EXISTS #IssuerBasicMand 
-- select distinct SourceSystem,InvID 
-- into #IssuerBasicMand
-- from CALYPSO_INVBASIC_STG where ISNULL(IssuerID,'') = ''

--SET @Merge = (
--					select STUFF((select ', ' + InvID 
--					from #IssuerBasicMand B
--					WHERE B.SourceSystem = A.SourceSystem
--					FOR XML PATH('')),1,1,'') as InvID
--					from #IssuerBasicMand A
--					group by SourceSystem
--				)

-- SET @SQL = 'IssuerID from Calypso Basic file '+ @Merge
--	+ ' should be Mandatory'
	

--	INSERT INTO  PackageErrorLogs (MachineName
--,PackageName
--,TaskName
--,ErrorCode
--,ErrorDescription
--,Date
--,ReportingDate)
--values ('D2K135','ENBDSourceToSTG', 'CALYPSO_INVBASIC_STG','',@SQL,GETDATE(),@ProcessDate)

--RAISERROR ('IssuerID in Calypso Basic files should be mandatory , Please check....',16,1)

--END

---------------------------------------------------------------------Basic Instr Type

--IF     (select count(1) from CALYPSO_INVBASIC_STG where ISNULL(InstrName,'') = ''
--		) > 0
--BEGIN 


-- DROP TABLE IF EXISTS #InstrNameMand 
-- select distinct SourceSystem,InvID 
-- into #InstrNameMand
-- from CALYPSO_INVBASIC_STG where ISNULL(InstrName,'') = ''

--SET @Merge = (
--					select STUFF((select ', ' + InvID 
--					from #InstrNameMand B
--					WHERE B.SourceSystem = A.SourceSystem
--					FOR XML PATH('')),1,1,'') as InvID
--					from #InstrNameMand A
--					group by SourceSystem
--				)

-- SET @SQL = 'InstrName from Calypso Basic file '+ @Merge
--	+ ' should be Mandatory'
	

--	INSERT INTO  PackageErrorLogs (MachineName
--,PackageName
--,TaskName
--,ErrorCode
--,ErrorDescription
--,Date
--,ReportingDate)
--values ('D2K135','ENBDSourceToSTG', 'CALYPSO_INVBASIC_STG','',@SQL,GETDATE(),@ProcessDate)

--RAISERROR ('InstrName in Calypso Basic files should be mandatory , Please check....',16,1)

--END

---------------------------------------------------------------------------Basic Currency

--IF     (select count(1) from CALYPSO_INVBASIC_STG where ISNULL(CurrencyCode,'') = ''
--		) > 0
--BEGIN 


-- DROP TABLE IF EXISTS #CurrencyCodeMand 
-- select distinct SourceSystem,InvID 
-- into #CurrencyCodeMand
-- from CALYPSO_INVBASIC_STG where ISNULL(CurrencyCode,'') = ''

--SET @Merge = (
--					select STUFF((select ', ' + InvID 
--					from #CurrencyCodeMand B
--					WHERE B.SourceSystem = A.SourceSystem
--					FOR XML PATH('')),1,1,'') as InvID
--					from #CurrencyCodeMand A
--					group by SourceSystem
--				)

-- SET @SQL = 'CurrencyCode from Calypso Basic file '+ @Merge
--	+ ' should be Mandatory'
	

--	INSERT INTO  PackageErrorLogs (MachineName
--,PackageName
--,TaskName
--,ErrorCode
--,ErrorDescription
--,Date
--,ReportingDate)
--values ('D2K135','ENBDSourceToSTG', 'CALYPSO_INVBASIC_STG','',@SQL,GETDATE(),@ProcessDate)

--RAISERROR ('CurrencyCode in Calypso Basic files should be mandatory , Please check....',16,1)

--END


-------------------------------------------------------------InvID Financial----

--IF     (select count(1) from CALYPSO_INVFINANCIAL_STG where ISNULL(InvID,'') = ''
--		) > 0
--BEGIN 


-- DROP TABLE IF EXISTS #InvIDFinancialMand 
-- select distinct SourceSystem,InvID 
-- into #InvIDFinancialMand
-- from CALYPSO_INVFINANCIAL_STG where ISNULL(InvID,'') = ''

----SET @Merge = (
----					select STUFF((select ', ' + InvID 
----					from #InvIDMand B
----					WHERE B.SourceSystem = A.SourceSystem
----					FOR XML PATH('')),1,1,'') as InvID
----					from #InvIDMand A
----					group by SourceSystem
----				)

-- SET @SQL = 'InvID from Calypso Financial file should be Mandatory'
	

--	INSERT INTO  PackageErrorLogs (MachineName
--,PackageName
--,TaskName
--,ErrorCode
--,ErrorDescription
--,Date
--,ReportingDate)
--values ('D2K135','ENBDSourceToSTG', 'CALYPSO_INVFINANCIAL_STG','',@SQL,GETDATE(),@ProcessDate)

--RAISERROR ('InvID in Calypso Financial files should be mandatory , Please check....',16,1)

--END
-----------------------------------------------------------IssuerID Financial

--IF     (select count(1) from CALYPSO_INVFINANCIAL_STG where ISNULL(IssuerID,'') = ''
--		) > 0
--BEGIN 


-- DROP TABLE IF EXISTS #IssuerFinancialMand 
-- select distinct SourceSystem,InvID 
-- into #IssuerFinancialMand
-- from CALYPSO_INVFINANCIAL_STG where ISNULL(IssuerID,'') = ''

--SET @Merge = (
--					select STUFF((select ', ' + InvID 
--					from #IssuerFinancialMand B
--					WHERE B.SourceSystem = A.SourceSystem
--					FOR XML PATH('')),1,1,'') as InvID
--					from #IssuerFinancialMand A
--					group by SourceSystem
--				)

-- SET @SQL = 'IssuerID from Calypso Financial file '+ @Merge
--	+ ' should be Mandatory'
	

--	INSERT INTO  PackageErrorLogs (MachineName
--,PackageName
--,TaskName
--,ErrorCode
--,ErrorDescription
--,Date
--,ReportingDate)
--values ('D2K135','ENBDSourceToSTG', 'CALYPSO_INVFINANCIAL_STG','',@SQL,GETDATE(),@ProcessDate)

--RAISERROR ('IssuerID in Calypso Financial files should be mandatory , Please check....',16,1)

--END
-----------------------------------------------------------Derivative Derivative RefNo-----

--IF     (select count(1) from CALYPSO_DERVCANCEL_STG where ISNULL(DerivativeRefNo,'') = ''
--		) > 0
--BEGIN 


-- DROP TABLE IF EXISTS #DerDerivativeRefNoMand 
-- select distinct SourceSystem,DerivativeRefNo 
-- into #DerDerivativeRefNoMand
-- from CALYPSO_DERVCANCEL_STG where ISNULL(DerivativeRefNo,'') = ''

----SET @Merge = (
----					select STUFF((select ', ' + DerivativeRefNo 
----					from #DerDerivativeRefNoMand B
----					WHERE B.SourceSystem = A.SourceSystem
----					FOR XML PATH('')),1,1,'') as InvID
----					from #DerDerivativeRefNoMand A
----					group by SourceSystem
----				)

-- SET @SQL = 'DerivativeRefNo from Calypso Derivative file should be Mandatory'
	

--	INSERT INTO  PackageErrorLogs (MachineName
--,PackageName
--,TaskName
--,ErrorCode
--,ErrorDescription
--,Date
--,ReportingDate)
--values ('D2K135','ENBDSourceToSTG', 'CALYPSO_DERVCANCEL_STG','',@SQL,GETDATE(),@ProcessDate)

--RAISERROR ('DerivativeRefNo in Calypso Derivative files should be mandatory , Please check....',16,1)

--END

-----------------------------------------------------------Derivative UCIC--

--IF     (select count(1) from CALYPSO_DERVCANCEL_STG where ISNULL(UCIC_ID,'') = ''
--		) > 0
--BEGIN 


-- DROP TABLE IF EXISTS #DerUCICMand 
-- select distinct SourceSystem,DerivativeRefNo 
-- into #DerUCICMand
-- from CALYPSO_DERVCANCEL_STG where ISNULL(UCIC_ID,'') = ''

--SET @Merge = (
--					select STUFF((select ', ' + DerivativeRefNo 
--					from #DerUCICMand B
--					WHERE B.SourceSystem = A.SourceSystem
--					FOR XML PATH('')),1,1,'') as DerivativeRefNo
--					from #DerUCICMand A
--					group by SourceSystem
--				)

-- SET @SQL = 'UCIC_ID from Calypso Derivative file '+ @Merge
--	+ ' should be Mandatory'
	

--	INSERT INTO  PackageErrorLogs (MachineName
--,PackageName
--,TaskName
--,ErrorCode
--,ErrorDescription
--,Date
--,ReportingDate)
--values ('D2K135','ENBDSourceToSTG', 'CALYPSO_DERVCANCEL_STG','',@SQL,GETDATE(),@ProcessDate)

--RAISERROR ('UCIC_ID in Calypso Derivative files should be mandatory , Please check....',16,1)

--END

------------------------------------------------------------Derivative CustID

--IF     (select count(1) from CALYPSO_DERVCANCEL_STG where ISNULL(CustID,'') = ''
--		) > 0
--BEGIN 


-- DROP TABLE IF EXISTS #DerCustIDMand 
-- select distinct SourceSystem,DerivativeRefNo 
-- into #DerCustIDMand
-- from CALYPSO_DERVCANCEL_STG where ISNULL(CustID,'') = ''

--SET @Merge = (
--					select STUFF((select ', ' + DerivativeRefNo 
--					from #DerCustIDMand B
--					WHERE B.SourceSystem = A.SourceSystem
--					FOR XML PATH('')),1,1,'') as DerivativeRefNo
--					from #DerCustIDMand A
--					group by SourceSystem
--				)

-- SET @SQL = 'CustID from Calypso Derivative file '+ @Merge
--	+ ' should be Mandatory'
	

--	INSERT INTO  PackageErrorLogs (MachineName
--,PackageName
--,TaskName
--,ErrorCode
--,ErrorDescription
--,Date
--,ReportingDate)
--values ('D2K135','ENBDSourceToSTG', 'CALYPSO_DERVCANCEL_STG','',@SQL,GETDATE(),@ProcessDate)

--RAISERROR ('CustID in Calypso Derivative files should be mandatory , Please check....',16,1)

--END


END




GO