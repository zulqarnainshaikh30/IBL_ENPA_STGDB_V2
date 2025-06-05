CREATE TABLE [dbo].[Tradepro_Stg_Daily] (
  [AsOnDate] [date] NOT NULL,
  [Source] [varchar](20) NULL,
  [UCIF_ID] [varchar](20) NULL,
  [RefCustomerID] [varchar](20) NULL,
  [CustomerAcID] [varchar](20) NULL,
  [Balance] [decimal](16, 2) NULL,
  [PrincOutStd] [decimal](16, 2) NULL,
  [IntOverdue] [decimal](16, 2) NULL,
  [IntAccrued] [decimal](16, 2) NULL,
  [OtherOverdue] [decimal](16, 2) NULL,
  [PrincOverdue] [decimal](16, 2) NULL,
  [BATCH_ID] [varchar](100) NULL
)
ON [PRIMARY]
GO