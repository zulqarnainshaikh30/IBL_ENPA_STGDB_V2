SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[INSERT_ACCOUNT_ALL_SOURCE_SYSTEM]
AS
BEGIN

DECLARE @TimeKey INT = (SELECT TimeKey FROM IBL_ENPA_DB_V2..SysDataMatrix WHERE CurrentStatus='C' )
DECLARE @Exec_Date DATE=(SELECT DATE FROM IBL_ENPA_DB_V2..SysDataMatrix WHERE TimeKey=@TimeKey )


SET DATEFORMAT DMY 
SET DATEFORMAT DMY
--TRUNCATE TABLE IBL_ENPA_STGDB_V2.[dbo].[ACCOUNT_ALL_SOURCE_SYSTEM] 

/*SELECT * FROM IBL_ENPA_STGDB_V2.DBO.ACCOUNT_ALL_SOURCE_SYSTEM
select * into ACCOUNT_ALL_SOURCE_SYSTEM FROM RBL_STGDB.[dbo].[ACCOUNT_ALL_SOURCE_SYSTEM] WHERE 1=2
ALTER TABLE ACCOUNT_ALL_SOURCE_SYSTEM ADD Funded_NonFunded_Flag VARCHAR(3)*/


/*INSERTING DATA IN ACCOUNT_ALL_SOURCE_SYSTEM FOR INCREMENTAL DATA*/
INSERT INTO ACCOUNT_ALL_SOURCE_SYSTEM (DateofData,
		SourceSystem,
		UCIC_ID,
		CustomerID,
		CustomerAcID,
		AcOpenDt,
		SchemeType,
		Scheme_ProductCode,
		AcSegmentCode,
		FacilityType,
		GLCode,
		Sector,
		PurposeofAdvance,
		IndustryCode,
		FirstDtOfDisb,
		InttRate,
		BankingArrangement,
		CurrencyCode,
		UnhedgedFCYAmount,
		BalanceOutstandingINR,
		BalanceInActualAcCurrency,
		AdvanceRecoveryAmount,
		CurQtrCredit,
		CurQtrInt,
		CurrentLimit,
		CurrentLimitDate,
		DrawingPower,
		AdhocAmt,
		AdhocDate,
		AdhocExpiryDate,
		ContiExcessDate,
		DebitSinceDate,
		DFVAmt,
		GovtGtyAmt,
		IntNotServicedDate,
		LastCreditDate,
		POSBalance,
		PrincipalOverdueAmt,
		PrincipalOverDueSinceDt,
		InterestOverdueAmt,
		InterestOverDueSinceDt,
		OthChargesOverdueAmt,
		OthChangesOverDueSinceDt,
		Review_RenewDueDt,
		LimitExpiryDate,
		StockStatementDt,
		UnAppliedInterestAmt,
		TWODate,
		TWOAmount,
		AssetClassNorm,
		ACCategory,
		SecuredStatus,
		AssetClassCode,
		NPADate,
		DBT_LOSDate,
		STDProvisionCategory,
		FraudCommitted,
		FraudDate,
		IsIBPCExposure,
		IsSecurtisedExposure,
		AcRMName_ID,
		AcTLName_ID,
		PUIMarked,
		RFAMarked,
		IsNonCoperative,
		CurrQtrSecurityValue,
		PrvQtrSecurityValue,
		CorporateUCICID,
		CorporateCustomerID,
		Liability,
		CD,
		Bucket,
		Accountstatus,
		AccountBlkCode1,
		AccountBlkCode2,
		ChargeoffY_N,
		ChargeoffType,
		ChargeoffAmount,
		ChargeoffDate,
		PrincipalOS,
		InterestOs,
		OtherChargesOS,
		ST_GSTTaxOS,
		interest_due,
		other_dues,
		penal_due,
		int_receivable,
		penal_int_receivable,
		DPD,
		Accured_Interest,
		Settlement_Flag,
		Settlement_Date,
		BranchCode,  
		IsARC_Sale,
		IsWiful,
		IsSuitFiled,
		Funded_NonFunded_Flag
		,DCCO_Date
		,PROJ_COMPLETION_DATE
		,IsTWO
		,IsOTS
		,IsFITL
		,CLOSED_DATE
		)
	SELECT 
		B.AsOnDate
		,B.SourceName
		,B.UCIF_ID
		,B.RefCustomerID
		,B.CustomerAcID
		,B.OPEN_DATE
		,B.FacilityType
		,B.ProductCode
		,B.ActSegmentCode
		,B.FacilityType
		,NULL GLCode
		,B.Sector
		,NULL PurposeofAdvance
		,NULL IndustryCode
		,NULL FirstDtOfDisb
		,NULL InttRate
		,NULL BankingArrangement
		,NULL CurrencyCode
		,NULL UnhedgedFCYAmount
		,NULL Balance
		,NULL BalanceInActualAcCurrency
		,NULL AdvanceRecoveryAmount
		,NULL CurQtrCredit
		,NULL CurQtrInt
		,B.SancLimit
		,B.SancDate
		,NULL DrawingPower
		,NULL AdhocAmt
		,NULL AdhocDate
		,NULL AdhocExpiryDate
		,B.ContiExcessDt
		,NULL DebitSinceDate
		,NULL DFV_AMT
		,B.GovGtyAmt
		,B.IntNotServicedDt
		,NULL LastCreditDate
		,NULL PrincOutStd
		,NULL PrincOverdue
		,B.PrincOverdueSinceDt
		,NULL IntOverdue
		,B.IntOverdueSinceDt
		,NULL OtherOverdue
		,NULL OthChargesOverdueAmt
		,B.ReviewDueDt
		,NULL LimitExpiryDate
		,B.StkStmtDate
		,NULL UnAppliedInterestAmt
		,B.TWO_Date
		,B.TWO_Amt
		,NULL AssetClassNorm
		,NULL ACCategory
		,B.SecuredFlag
		,B.SrcAssetClass
		,B.SrcNpaDt
		,NULL DBT_LOSDate
		,NULL STD_ASSET_CAT
		,B.IsFraud
		,B.FraudDate
		,NULL IsIBPCExposure
		,NULL IsSecurtisedExposure
		,NULL AcRMName_ID
		,NULL AcTLName_ID
		,NULL PUIMarked
		,B.IsRFA
		,B.IsNonCooperative
		,NULL CurrQtrSecurityValue
		,NULL PrvQtrSecurityValue
		,NULL CorporateUCICID
		,NULL CorporateCustomerID
		,NULL Liability
		,NULL CD
		,NULL Bucket
		,NULL Accountstatus
		,NULL AccountBlkCode1
		,NULL AccountBlkCode2
		,NULL ChargeoffY_N
		,NULL ChargeoffType
		,NULL ChargeoffAmount
		,NULL ChargeoffDate
		,NULL PrincOutStd
		,NULL InterestOs
		,NULL OtherChargesOS
		,NULL ST_GSTTaxOS
		,NULL interest_due
		,NULL other_dues
		,NULL penal_due
		,NULL int_receivable
		,NULL penal_int_receivable
		,NULL DPD
		,NULL IntAccrued
		,B.IsOTS
		,NULL Settlement_Date
		,NULL BranchCode
		,B.IsARC_Sale
		,B.IsWiful
		,B.IsSuitFiled
		,B.Funded_NonFunded_Flag
		,B.DCCO_Date
		,B.PROJ_COMPLETION_DATE
		,B.IsTWO
		,B.IsOTS
		,B.IsFITL
		,B.CLOSED_DATE
FROM CUSTAC_MERGE_INCREMENTAL B 
		LEFT JOIN ACCOUNT_ALL_SOURCE_SYSTEM C
					ON C.CustomerACID=B.CustomerACID
			WHERE C.CustomerAcID IS NULL


/*UPDATING DATA IN ACCOUNT_ALL_SOURCE_SYSTEM FOR CHANGED DATA FROM DAILY*/

UPDATE A SET 
A.BalanceOutstandingINR= ISNULL(SD.BALANCE,0) ,
A.PrincipalOS= ISNULL(SD.PrincOutStd,0),
--A.Overdue=(ISNULL(SD.IntOverdue,0)+ISNULL(SD.OtherOverdue,0)+ISNULL(SD.PrincOverdue,0)),
A.Accured_Interest=ISNULL(SD.IntAccrued,0),
A.InterestOverdueAmt=ISNULL(SD.IntOverdue,0),
A.OthChargesOverdueAmt=ISNULL(SD.OtherOverdue ,0),
A.PrincipalOverdueAmt=ISNULL(SD.PrincOverdue,0),
A.UCIC_ID=ISNULL(SD.UCIF_ID,'')
--,ModifiedBy='SSIS USER',
--DateModified=GETDATE()
FROM IBL_ENPA_STGDB_V2.dbo.ACCOUNT_ALL_SOURCE_SYSTEM A
INNER JOIN IBL_ENPA_STGDB_V2.dbo.CUSTAC_MERGE_DAILY SD ON 
												--A.SrcSysAlt_Key=@SrcSysAlt_Key
                                                --  AND A.EffectiveFromTimeKey<=@TimeKey
                                                --  AND A.EffectiveToTimeKey>=@TimeKey AND 
												  ISNULL(A.UCIC_ID,'')=ISNULL(SD.UCIF_ID,'')
												  AND A.CustomerId=SD.RefCustomerID
												  AND A.CustomerACID=SD.CustomerAcID
WHERE (ISNULL(A.BalanceOutstandingINR,0) <> ISNULL(SD.BALANCE,0) 
   OR ISNULL(A.PrincipalOS,0) <> ISNULL(SD.PrincOutStd,0)
   --OR ISNULL(A.Overdue,0)<>(ISNULL(SD.IntOverdue,0)+ISNULL(SD.OtherOverdue,0)+ISNULL(SD.PrincOverdue,0))
   OR ISNULL(A.Accured_Interest,0)<>ISNULL(SD.IntAccrued,0)
   OR ISNULL(A.InterestOverdueAmt,0)<>ISNULL(SD.IntOverdue,0)
   OR ISNULL(A.OthChargesOverdueAmt ,0)<>ISNULL(SD.OtherOverdue ,0)
   OR ISNULL(A.PrincipalOverdueAmt,0)<>ISNULL(SD.PrincOverdue,0)
   OR ISNULL(A.UCIC_ID,'')<>ISNULL(SD.UCIF_ID,''))
AND SD.AsOnDate=@Exec_Date


/*UPDATING DATA IN ACCOUNT_ALL_SOURCE_SYSTEM FOR CHANGED CUSTOMER ID FROM INCREMENTAL*/

UPDATE A SET A.CustomerId=B.RefCustomerID
FROM IBL_ENPA_STGDB_V2.DBO.ACCOUNT_ALL_SOURCE_SYSTEM A
INNER JOIN IBL_ENPA_STGDB_V2.dbo.CUSTAC_MERGE_INCREMENTAL B ON 
												  A.CustomerACID=B.CustomerAcID
WHERE ISNULL(B.SRC_CIF_UPDATED,'N')='Y'
--AND SrcSysAlt_Key=@SrcSysAlt_Key


/*UPDATING DATA IN SECURITY FOR CHANGED CUSTOMER ID FROM DAILY */



/*UPDATING DATA IN ACCOUNT_ALL_SOURCE_SYSTEM FOR CHANGED UCIC ID FROM DAILY*/

UPDATE A SET A.UCIC_ID=B.UCIF_ID
FROM IBL_ENPA_STGDB_V2.DBO.ACCOUNT_ALL_SOURCE_SYSTEM A
INNER JOIN IBL_ENPA_STGDB_V2.dbo.CUSTAC_MERGE_DAILY B ON 
												 A.CustomerID=B.RefCustomerID
												 AND A.CustomerACID=B.CustomerAcID
WHERE ISNULL(A.UCIC_ID,'')<>ISNULL(B.UCIF_ID,'')
--AND SrcSysAlt_Key=@SrcSysAlt_Key

/* DROP TABLE IBL_ENPA_DB_V2.DBO.CLOSED_ACCOUNT_ALL_SOURCE_SYSTEM
SELECT * INTO IBL_ENPA_DB_V2.DBO.CLOSED_ACCOUNT_ALL_SOURCE_SYSTEM FROM IBL_ENPA_STGDB_V2.DBO.ACCOUNT_ALL_SOURCE_SYSTEM*/

INSERT INTO IBL_ENPA_DB_V2.DBO.CLOSED_ACCOUNT_ALL_SOURCE_SYSTEM(
										DateofData
										,SourceSystem
										,BranchCode
										,UCIC_ID
										,CustomerID
										,CustomerAcID
										,AcOpenDt
										,SchemeType
										,Scheme_ProductCode
										,AcSegmentCode
										,FacilityType
										,GLCode
										,Sector
										,PurposeofAdvance
										,IndustryCode
										,FirstDtOfDisb
										,InttRate
										,BankingArrangement
										,CurrencyCode
										,UnhedgedFCYAmount
										,BalanceOutstandingINR
										,BalanceInActualAcCurrency
										,AdvanceRecoveryAmount
										,CurQtrCredit
										,CurQtrInt
										,CurrentLimit
										,CurrentLimitDate
										,DrawingPower
										,AdhocAmt
										,AdhocDate
										,AdhocExpiryDate
										,ContiExcessDate
										,DebitSinceDate
										,DFVAmt
										,GovtGtyAmt
										,IntNotServicedDate
										,LastCreditDate
										,POSBalance
										,PrincipalOverdueAmt
										,PrincipalOverDueSinceDt
										,InterestOverdueAmt
										,InterestOverDueSinceDt
										,OthChargesOverdueAmt
										,OthChangesOverDueSinceDt
										,Review_RenewDueDt
										,LimitExpiryDate
										,StockStatementDt
										,UnAppliedInterestAmt
										,TWODate
										,TWOAmount
										,AssetClassNorm
										,ACCategory
										,SecuredStatus
										,AssetClassCode
										,NPADate
										,DBT_LOSDate
										,STDProvisionCategory
										,FraudCommitted
										,FraudDate
										,IsIBPCExposure
										,IsSecurtisedExposure
										,AcRMName_ID
										,AcTLName_ID
										,PUIMarked
										,RFAMarked
										,IsNonCoperative
										,CurrQtrSecurityValue
										,PrvQtrSecurityValue
										,CorporateUCICID
										,CorporateCustomerID
										,Liability
										,CD
										,Bucket
										,Accountstatus
										,AccountBlkCode1
										,AccountBlkCode2
										,ChargeoffY_N
										,ChargeoffType
										,ChargeoffAmount
										,ChargeoffDate
										,PrincipalOS
										,InterestOs
										,OtherChargesOS
										,ST_GSTTaxOS
										,interest_due
										,other_dues
										,penal_due
										,int_receivable
										,penal_int_receivable
										,DPD
										,Accured_Interest
										,Settlement_Flag
										,Settlement_Date
										,IsARC_Sale
										,IsWiful
										,IsSuitFiled
										,Funded_NonFunded_Flag
										,DCCO_Date
										,PROJ_COMPLETION_DATE
										,IsTWO
										,IsOTS
										,IsFITL
										,CLOSED_DATE
									)
SELECT A.DateofData
			,A.SourceSystem
			,A.BranchCode
			,A.UCIC_ID
			,A.CustomerID
			,A.CustomerAcID
			,A.AcOpenDt
			,A.SchemeType
			,A.Scheme_ProductCode
			,A.AcSegmentCode
			,A.FacilityType
			,A.GLCode
			,A.Sector
			,A.PurposeofAdvance
			,A.IndustryCode
			,A.FirstDtOfDisb
			,A.InttRate
			,A.BankingArrangement
			,A.CurrencyCode
			,A.UnhedgedFCYAmount
			,A.BalanceOutstandingINR
			,A.BalanceInActualAcCurrency
			,A.AdvanceRecoveryAmount
			,A.CurQtrCredit
			,A.CurQtrInt
			,A.CurrentLimit
			,A.CurrentLimitDate
			,A.DrawingPower
			,A.AdhocAmt
			,A.AdhocDate
			,A.AdhocExpiryDate
			,A.ContiExcessDate
			,A.DebitSinceDate
			,A.DFVAmt
			,A.GovtGtyAmt
			,A.IntNotServicedDate
			,A.LastCreditDate
			,A.POSBalance
			,A.PrincipalOverdueAmt
			,A.PrincipalOverDueSinceDt
			,A.InterestOverdueAmt
			,A.InterestOverDueSinceDt
			,A.OthChargesOverdueAmt
			,A.OthChangesOverDueSinceDt
			,A.Review_RenewDueDt
			,A.LimitExpiryDate
			,A.StockStatementDt
			,A.UnAppliedInterestAmt
			,A.TWODate
			,A.TWOAmount
			,A.AssetClassNorm
			,A.ACCategory
			,CASE WHEN A.SecuredStatus = 'Y' THEN 'S' ELSE 'U' END SecuredStatus
			,A.AssetClassCode
			,A.NPADate
			,A.DBT_LOSDate
			,A.STDProvisionCategory
			,A.FraudCommitted
			,A.FraudDate
			,A.IsIBPCExposure
			,A.IsSecurtisedExposure
			,A.AcRMName_ID
			,A.AcTLName_ID
			,A.PUIMarked
			,A.RFAMarked
			,A.IsNonCoperative
			,A.CurrQtrSecurityValue
			,A.PrvQtrSecurityValue
			,A.CorporateUCICID
			,A.CorporateCustomerID
			,A.Liability
			,A.CD
			,A.Bucket
			,A.Accountstatus
			,A.AccountBlkCode1
			,A.AccountBlkCode2
			,A.ChargeoffY_N
			,A.ChargeoffType
			,A.ChargeoffAmount
			,A.ChargeoffDate
			,A.PrincipalOS
			,A.InterestOs
			,A.OtherChargesOS
			,A.ST_GSTTaxOS
			,A.interest_due
			,A.other_dues
			,A.penal_due
			,A.int_receivable
			,A.penal_int_receivable
			,A.DPD
			,A.Accured_Interest
			,A.Settlement_Flag
			,A.Settlement_Date
			,A.IsARC_Sale
			,A.IsWiful
			,A.IsSuitFiled
			,A.Funded_NonFunded_Flag
			,PSD.DCCO_Date
			,PSD.PROJ_COMPLETION_DATE
			,PSD.IsTWO
			,PSD.IsOTS
			,PSD.IsFITL
			,PSD.CLOSED_DATE
FROM IBL_ENPA_STGDB_V2.DBO.ACCOUNT_ALL_SOURCE_SYSTEM A
INNER JOIN IBL_ENPA_STGDB_V2.dbo.CUSTAC_MERGE_INCREMENTAL PSD ON 
                                ISNULL(A.UCIC_ID,'')=ISNULL(PSD.UCIF_ID,'')
								AND A.CustomerId=PSD.RefCustomerID
								AND A.CustomerACID=PSD.CustomerAcID
WHERE PSD.CLOSED_DATE IS NOT NULL




/*DELETING EXPIRED RECORDS FROM ACCOUNT_ALL_SOURCE_SYSTEM*/
DELETE A
FROM IBL_ENPA_STGDB_V2.DBO.ACCOUNT_ALL_SOURCE_SYSTEM A
INNER JOIN IBL_ENPA_STGDB_V2.dbo.CUSTAC_MERGE_INCREMENTAL PSD ON 
                                    ISNULL(A.UCIC_ID,'')=ISNULL(PSD.UCIF_ID,'')
									AND A.CustomerId=PSD.RefCustomerID
									AND A.CustomerACID=PSD.CustomerAcID
WHERE PSD.CLOSED_DATE IS NOT NULL



/*UPDATING DFV AMOUNT FROM ALL SOURCE STG RESTRUCTURE TABLE*/
UPDATE A 
	SET A.DFVAmt=D.DFV_AMT
	FROM ACCOUNT_ALL_SOURCE_SYSTEM A INNER JOIN MERGE_RESTRUCTURE D ON A.CustomerAcID=D.ACC_NO

/*UPDATING DFV AMOUNT FROM ALL SOURCE STG PROVISION TABLE*/
UPDATE A 
	SET A.STDProvisionCategory=E.STD_ASSET_CAT
	FROM ACCOUNT_ALL_SOURCE_SYSTEM A INNER JOIN MERGE_STD_PROVISION E ON A.CustomerAcID=E.ACC_NO


--INNER JOIN ALL_SOURCE_STG_SECURITY C ON A.UCIF_ID=C.SRC_CIF
--INNER JOIN MERGE_RESTRUCTURE D ON A.CustomerAcID=D.ACC_NO
--INNER JOIN MERGE_STD_PROVISION E ON A.CustomerAcID=A.CustomerAcID
--INNER JOIN ALL_SOURCE_STG_COBORROWER F
END

GO