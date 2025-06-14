﻿CREATE TABLE [dbo].[SYNERGY_ACCOUNT_STG] (
  [DateofData] [date] NULL,
  [SourceSystem] [varchar](30) NULL,
  [BranchCode] [varchar](10) NULL,
  [CustomerID] [varchar](30) NULL,
  [CustomerAcID] [varchar](30) NULL,
  [AcOpenDt] [date] NULL,
  [SchemeType] [varchar](30) NULL,
  [Scheme_ProductCode] [varchar](30) NULL,
  [AcSegmentCode] [varchar](30) NULL,
  [FacilityType] [varchar](10) NULL,
  [GLCode] [varchar](30) NULL,
  [Sector] [varchar](50) NULL,
  [PurposeofAdvance] [varchar](100) NULL,
  [IndustryCode] [varchar](10) NULL,
  [FirstDtOfDisb] [date] NULL,
  [InttRate] [decimal](4, 2) NULL,
  [CurrencyCode] [varchar](10) NULL,
  [BalanceOutstandingINR] [decimal](16, 2) NULL,
  [BalanceInActualAcCurrency] [decimal](16, 2) NULL,
  [CurrentLimit] [decimal](16) NULL,
  [CurrentLimitDate] [date] NULL,
  [DrawingPower] [decimal](16) NULL,
  [AdhocAmt] [decimal](16) NULL,
  [AdhocDate] [date] NULL,
  [AdhocExpiryDate] [date] NULL,
  [ContiExcessDate] [date] NULL,
  [DebitSinceDate] [date] NULL,
  [GovtGtyAmt] [decimal](16, 2) NULL,
  [POSBalance] [decimal](16, 2) NULL,
  [PrincipalOverdueAmt] [decimal](16, 2) NULL,
  [PrincipalOverDueSinceDt] [date] NULL,
  [InterestOverdueAmt] [decimal](16, 2) NULL,
  [PenalInterestOverdueAmt] [decimal](16, 2) NULL,
  [InterestOverDueSinceDt] [date] NULL,
  [OthChargesOverdueAmt] [decimal](16, 2) NULL,
  [OthChangesOverDueSinceDt] [date] NULL,
  [Review_RenewDueDt] [date] NULL,
  [LimitExpiryDate] [date] NULL,
  [StockStatementDt] [date] NULL,
  [UnAppliedInterestAmt] [decimal](16, 2) NULL,
  [PenalUnAppliedInterestAmt] [decimal](16, 2) NULL,
  [AssetClassNorm] [varchar](10) NULL,
  [ACCategory] [tinyint] NULL,
  [SecuredStatus] [varchar](20) NULL,
  [AssetClassCode] [varchar](10) NULL,
  [NPADate] [date] NULL,
  [DBT_LOSDate] [date] NULL,
  [FraudDate] [date] NULL,
  [RFAMarked] [varchar](20) NULL,
  [DFVAmt] [decimal](16, 2) NULL,
  [IntNotServicedDate] [date] NULL,
  [LastCreditDate] [date] NULL,
  [TWODate] [date] NULL,
  [TWOAmount] [decimal](16, 2) NULL,
  [STDProvisionCategory] [varchar](20) NULL,
  [FraudCommitted] [varchar](20) NULL,
  [IsIBPCExposure] [varchar](20) NULL,
  [IsSecurtisedExposure] [varchar](20) NULL,
  [PUIMarked] [varchar](20) NULL,
  [IsNonCoperative] [varchar](20) NULL,
  [interest_due] [decimal](18, 2) NULL,
  [penal_due] [decimal](18, 2) NULL,
  [AccountClosedFlag] [varchar](20) NULL,
  [AccountClosedDate] [date] NULL,
  [Country] [varchar](50) NULL,
  [PenalInterestOverDueSinceDt] [date] NULL,
  [SubAssetClassCode] [varchar](10) NULL,
  [WilfullDefaulter] [char](1) NULL,
  [STDProvCategory] [varchar](30) NULL,
  [RestructureType] [varchar](20) NULL,
  [InterestSuspense] [decimal](16, 2) NULL,
  [PreEMI] [decimal](16, 2) NULL,
  [ValueDatedFlag] [char](1) NULL,
  [ValueDate] [date] NULL
)
ON [PRIMARY]
GO