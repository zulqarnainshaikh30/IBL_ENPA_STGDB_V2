CREATE TABLE [dbo].[Securitize_Stg_Daily] (
  [AsOnDate] [date] NOT NULL,
  [Source] [nvarchar](20) NULL,
  [UCIF_ID] [nvarchar](20) NULL,
  [RefCustomerID] [nvarchar](20) NULL,
  [CustomerAcID] [nvarchar](20) NULL,
  [Balance] [decimal](16, 2) NULL,
  [PrincOutStd] [decimal](16, 2) NULL,
  [IntOverdue] [decimal](16, 2) NULL,
  [IntAccrued] [decimal](16, 2) NULL,
  [OtherOverdue] [decimal](16, 2) NULL,
  [PrincOverdue] [decimal](16, 2) NULL,
  [BatchID] [varchar](100) NULL
)
ON [PRIMARY]
GO