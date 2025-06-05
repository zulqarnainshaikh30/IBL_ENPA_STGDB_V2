CREATE TABLE [dbo].[SYNERGY_SECURITY_STG] (
  [DateofData] [date] NULL,
  [SourceSystem] [varchar](30) NULL,
  [Customer_ID] [varchar](20) NULL,
  [AccountID] [varchar](30) NULL,
  [Security_ID] [varchar](32) NULL,
  [SecurityType] [varchar](32) NULL,
  [SecurityCode] [varchar](10) NULL,
  [Charge_Type_Code] [varchar](1) NULL,
  [SecurityValue] [decimal](16, 2) NULL,
  [Valuation_Source] [varchar](1) NULL,
  [Valuationdate] [date] NULL,
  [ValuationExpiryDate] [date] NULL
)
ON [PRIMARY]
GO