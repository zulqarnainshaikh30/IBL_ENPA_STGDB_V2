CREATE TABLE [dbo].[CUSTOMER_ALL_SOURCE_SYSTEM_BKP_20250407] (
  [DateOfData] [date] NULL,
  [SourceSystem] [varchar](30) NULL,
  [UCIC_ID] [varchar](30) NULL,
  [CustomerID] [varchar](30) NULL,
  [CustomerName] [varchar](100) NULL,
  [Constitution] [varchar](100) NULL,
  [Gender] [varchar](20) NULL,
  [SegmentCode] [varchar](30) NULL,
  [PANNO] [varchar](12) NULL,
  [PrevQtrRV] [decimal](16, 2) NULL,
  [CurrQtrRV] [decimal](16, 2) NULL,
  [AssetClass] [varchar](20) NULL,
  [NPADate] [date] NULL,
  [DBT_LOS_Date] [date] NULL,
  [AlwaysNPA] [tinyint] NULL
)
ON [PRIMARY]
GO