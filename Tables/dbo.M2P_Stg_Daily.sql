CREATE TABLE [dbo].[M2P_Stg_Daily] (
  [AsOnDate] [date] NULL,
  [UCIF_ID] [nvarchar](50) NULL,
  [RefCustomerID] [nvarchar](50) NULL,
  [ SOURCE ] [nvarchar](50) NULL,
  [CustomerAcID] [nvarchar](50) NULL,
  [Balance] [decimal](16, 2) NULL,
  [PrincOutStd] [decimal](16, 2) NULL,
  [IntOverdue] [decimal](16, 2) NULL,
  [IntAccrued] [decimal](16, 2) NULL,
  [OtherOverdue] [decimal](16, 2) NULL,
  [PrincOverdue] [decimal](16, 2) NULL,
  [ GENRN_TIME_STAMP ] [nvarchar](50) NULL,
  [BatchID] [nvarchar](100) NULL
)
ON [PRIMARY]
GO