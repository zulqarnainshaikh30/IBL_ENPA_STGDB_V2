CREATE TABLE [dbo].[CUSTAC_MERGE_DAILY] (
  [AsOnDate] [date] NULL,
  [Source] [nvarchar](50) NULL,
  [UCIF_ID] [nvarchar](50) NULL,
  [RefCustomerID] [nvarchar](50) NULL,
  [CustomerAcID] [nvarchar](50) NULL,
  [Balance] [decimal](16, 2) NULL,
  [PrincOutStd] [decimal](16, 2) NULL,
  [IntOverdue] [decimal](16, 2) NULL,
  [IntAccrued] [decimal](16, 2) NULL,
  [OtherOverdue] [decimal](16, 2) NULL,
  [PrincOverdue] [decimal](16, 2) NULL,
  [BATCH_ID] [nvarchar](100) NULL
)
ON [PRIMARY]
GO