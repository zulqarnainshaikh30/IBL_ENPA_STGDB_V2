CREATE TABLE [dbo].[PTSmart_Stg_Coborrower] (
  [Generation_Timestamp] [datetime] NULL,
  [Batch_Id] [nvarchar](50) NULL,
  [Asondate] [varchar](12) NULL,
  [SourceSystemName_primaryaccount] [nvarchar](40) NULL,
  [NCIFID_primaryaccount] [nvarchar](40) NULL,
  [CustomerID_primaryaccount] [nvarchar](40) NULL,
  [CustomerAcID_primaryaccount] [nvarchar](40) NULL,
  [NCIFID_COBORROWER] [nvarchar](40) NULL
)
ON [PRIMARY]
GO