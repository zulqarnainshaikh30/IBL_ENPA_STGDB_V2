CREATE TABLE [dbo].[FINACLE_Stg_Security] (
  [AS_ON_DATE] [date] NULL,
  [SOURCE] [nvarchar](20) NULL,
  [COLL_ID] [nvarchar](50) NULL,
  [ENT_CIF] [nvarchar](50) NULL,
  [SRC_CIF] [nvarchar](50) NULL,
  [COLL_TYPE] [nvarchar](100) NULL,
  [COLL_EXPRY_DATE] [date] NULL,
  [COLL_AMT] [decimal](18, 2) NULL,
  [ACC_NO] [nvarchar](50) NULL,
  [COLL_VAL_DATE] [date] NULL,
  [BatchID] [varchar](100) NULL,
  [COLL_DELINK_DATE] [date] NULL
)
ON [PRIMARY]
GO