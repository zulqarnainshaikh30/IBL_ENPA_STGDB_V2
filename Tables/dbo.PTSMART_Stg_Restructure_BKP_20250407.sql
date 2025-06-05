CREATE TABLE [dbo].[PTSMART_Stg_Restructure_BKP_20250407] (
  [AS_ON_DATE] [date] NULL,
  [SOURCE] [varchar](20) NULL,
  [ENT_CIF] [varchar](50) NULL,
  [SRC_CIF] [varchar](50) NULL,
  [ACC_NO] [varchar](50) NULL,
  [RESTR_DATE] [date] NULL,
  [RESTR_TYPE] [varchar](50) NULL,
  [RESTR_AMT] [decimal](18, 2) NULL,
  [DFV_AMT] [decimal](18, 2) NULL,
  [TKOUT_FIN] [decimal](18, 2) NULL,
  [LATEST_REPAY_DATE] [date] NULL,
  [BATCH_ID] [varchar](100) NULL,
  [TEN_PC_DATE] [date] NULL
)
ON [PRIMARY]
GO