SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[INSERT_STG_DAILY_ALLSOURCE]
AS
BEGIN

/*TRUNCATION OF PREVIOUD DAY DATA FOR ALL_SOURCE_STG_DAILY*/

TRUNCATE TABLE [IBL_ENPA_STGDB_V2].DBO.CUSTAC_MERGE_DAILY

--SELECT * INTO CUSTAC_MERGE_DAILY FROM ALL_SOURCE_STG_DAILY
--DROP TABLE ALL_SOURCE_STG_DAILY
/*INSERTING STG DAILY FROM ALL SOURCE SYSTEM*/

INSERT INTO [IBL_ENPA_STGDB_V2].DBO.CUSTAC_MERGE_DAILY (AsOnDate,	Source,	UCIF_ID,	RefCustomerID,	CustomerAcID,	Balance,	PrincOutStd,	IntOverdue,	IntAccrued,	OtherOverdue,	PrincOverdue,	BATCH_ID)
SELECT AsOnDate,	Source,	UCIF_ID,	RefCustomerID,	CustomerAcID,	Balance,	PrincOutStd,	IntOverdue,	IntAccrued,	OtherOverdue,	PrincOverdue,	BATCH_ID FROM Calypso_Stg_Daily
UNION All
SELECT AsOnDate,	Source,	UCIF_ID,	RefCustomerID,	CustomerAcID,	Balance,	PrincOutStd,	IntOverdue,	IntAccrued,	OtherOverdue,	PrincOverdue,	BATCH_ID FROM Ecbf_Stg_Daily
UNION ALL
SELECT AsOnDate,	Source,	UCIF_ID,	RefCustomerID,	CustomerAcID,	Balance,	PrincOutStd,	IntOverdue,	IntAccrued,	OtherOverdue,	PrincOverdue,	BatchID FROM FINACLE_Stg_Daily
UNION ALL
SELECT AsOnDate,	Source,	UCIF_ID,	RefCustomerID,	CustomerAcID,	Balance,	PrincOutStd,	IntOverdue,	IntAccrued,	OtherOverdue,	PrincOverdue,	BatchID FROM Ganaseva_Stg_Daily
UNION ALL
SELECT AsOnDate,	[ SOURCE ],	UCIF_ID,	RefCustomerID,	CustomerAcID,	Balance,	PrincOutStd,	IntOverdue,	IntAccrued,	OtherOverdue,	PrincOverdue,	BatchID FROM M2P_Stg_Daily
UNION ALL
SELECT AsOnDate,	Source,	UCIF_ID,	RefCustomerID,	CustomerAcID,	Balance,	PrincOutStd,	IntOverdue,	IntAccrued,	OtherOverdue,	PrincOverdue,	BATCH_ID FROM Prolendz_Stg_Daily
UNION ALL
SELECT AsOnDate,	Source,	UCIF_ID,	RefCustomerID,	CustomerAcID,	Balance,	PrincOutStd,	IntOverdue,	IntAccrued,	OtherOverdue,	PrincOverdue,	BATCH_ID FROM PTSmart_Stg_Daily
UNION ALL
SELECT AsOnDate,	Source,	UCIF_ID,	RefCustomerID,	CustomerAcID,	Balance,	PrincOutStd,	IntOverdue,	IntAccrued,	OtherOverdue,	PrincOverdue,	BATCHID FROM Securitize_Stg_Daily
UNION ALL
SELECT AsOnDate,	Source,	UCIF_ID,	RefCustomerID,	CustomerAcID,	Balance,	PrincOutStd,	IntOverdue,	IntAccrued,	OtherOverdue,	PrincOverdue,	BATCH_ID FROM Tradepro_Stg_Daily
UNION ALL
SELECT AsOnDate,	Source,	UCIF_ID,	RefCustomerID,	CustomerAcID,	Balance,	PrincOutStd,	IntOverdue,	IntAccrued,	OtherOverdue,	PrincOverdue,	BATCH_ID FROM Veefin_Stg_Daily
UNION ALL
SELECT AsOnDate,	Source,	UCIF_ID,	RefCustomerID,	CustomerAcID,	Balance,	PrincOutStd,	IntOverdue,	IntAccrued,	OtherOverdue,	PrincOverdue,	BATCH_ID FROM VisionPlus_Stg_Daily

END
GO