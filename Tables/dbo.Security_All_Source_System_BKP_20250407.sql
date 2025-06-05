CREATE TABLE [dbo].[Security_All_Source_System_BKP_20250407] (
  [DateofData] [date] NULL,
  [SourceSystem] [varchar](30) NULL,
  [AccountID] [varchar](30) NULL,
  [CollateralID] [varchar](30) NULL,
  [SecurityCode] [varchar](10) NULL,
  [SecurityValue] [decimal](16, 2) NULL,
  [Valuationdate] [datetime] NULL,
  [SecurityChargeStatus] [varchar](10) NULL,
  [ValuationExpiryDate] [date] NULL,
  [CustomerID] [varchar](30) NULL,
  [CaratValue] [int] NULL,
  [GoldWeightNetGms] [decimal](18, 2) NULL,
  [Security_ID] [varchar](100) NULL,
  [Charge_Type_Code] [varchar](20) NULL,
  [Valuation_Source] [varchar](20) NULL,
  [Collateral_Type] [varchar](100) NULL,
  [COLL_DELINK_DATE] [date] NULL,
  [SRC_CIF] [varchar](50) NULL
)
ON [PRIMARY]
GO