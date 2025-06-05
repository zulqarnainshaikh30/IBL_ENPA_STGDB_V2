CREATE TABLE [dbo].[TXN_SAMPLE] (
  [DateofData] [date] NOT NULL,
  [SourceSystem] [varchar](50) NOT NULL,
  [AccountID] [varchar](50) NOT NULL,
  [TxnDate] [date] NOT NULL,
  [ValueDate] [date] NULL,
  [TxnID] [varchar](max) NULL,
  [TxnType] [varchar](50) NULL,
  [TxnNature] [varchar](50) NULL,
  [TxnSubType] [varchar](50) NULL,
  [TxnCurrency] [varchar](50) NULL,
  [TxnAmountinCurrency] [varchar](50) NULL,
  [TxnAmountINR] [decimal](18, 2) NULL,
  [TxnParticulars] [nvarchar](100) NULL
)
ON [PRIMARY]
TEXTIMAGE_ON [PRIMARY]
GO