CREATE TABLE [dbo].[Securitize_Stg_Restructure] (
  [AS_ON_DATE] [date] NULL,
  [SOURCE] [nvarchar](20) NULL,
  [ENT_CIF] [nvarchar](50) NULL,
  [SRC_CIF] [nvarchar](50) NULL,
  [ACC_NO] [nvarchar](50) NULL,
  [RESTR_DATE] [date] NULL,
  [RESTR_TYPE] [nvarchar](50) NULL,
  [RESTR_AMT] [decimal](18, 2) NULL,
  [DFV_AMT] [decimal](18, 2) NULL,
  [TKOUT_FIN] [decimal](18, 2) NULL,
  [LATEST_REPAY_DATE] [date] NULL,
  [BatchID] [varchar](100) NULL,
  [TEN_PC_DATE] [date] NULL
)
ON [PRIMARY]
GO