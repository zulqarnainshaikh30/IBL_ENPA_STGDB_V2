CREATE TABLE [dbo].[TXN_ALL_SOURCE_SYSTEM_BKP] (
  [DateofData] [date] NULL,
  [SourceSystem] [varchar](30) NULL,
  [AccountID] [varchar](30) NULL,
  [TxnDate] [date] NULL,
  [TxnID] [varchar](30) NULL,
  [TxnType] [varchar](30) NULL,
  [TxnSubType] [varchar](30) NULL,
  [TxnCurrency] [varchar](30) NULL,
  [TxnAmountinCurrency] [decimal](16, 2) NULL,
  [TxnAmountINR] [decimal](16, 2) NULL,
  [TxnParticulars] [varchar](200) NULL
)
ON [PRIMARY]
GO