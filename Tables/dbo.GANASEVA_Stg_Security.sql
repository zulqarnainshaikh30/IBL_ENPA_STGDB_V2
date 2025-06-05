CREATE TABLE [dbo].[GANASEVA_Stg_Security] (
  [AS_ON_DATE] [date] NULL,
  [SOURCE] [varchar](20) NULL,
  [COLL_ID] [varchar](50) NULL,
  [ENT_CIF] [varchar](50) NULL,
  [SRC_CIF] [varchar](50) NULL,
  [COLL_TYPE] [varchar](100) NULL,
  [COLL_EXPRY_DATE] [date] NULL,
  [COLL_AMT] [decimal](18, 2) NULL,
  [ACC_NO] [varchar](50) NULL,
  [COLL_VAL_DATE] [date] NULL,
  [BatchID] [varchar](100) NULL,
  [COLL_DELINK_DATE] [date] NULL
)
ON [PRIMARY]
GO