CREATE TABLE [dbo].[BuyoutDetails_stg] (
  [Entity_Key] [int] IDENTITY,
  [SlNo] [varchar](50) NULL,
  [ReferenceNo] [varchar](50) NULL,
  [MainCustomer] [varchar](100) NULL,
  [PoolName] [varchar](100) NULL,
  [Category] [varchar](50) NULL,
  [BuyoutPartyLoanNo] [varchar](50) NULL,
  [CustomerName] [varchar](100) NULL,
  [PAN] [varchar](50) NULL,
  [AadharNo] [varchar](50) NULL,
  [PrincipalOutstanding] [varchar](50) NULL,
  [InterestReceivable] [varchar](50) NULL,
  [Charges] [varchar](50) NULL,
  [AccuredInterest] [varchar](50) NULL,
  [DPD] [varchar](50) NULL,
  [AssetClass] [varchar](50) NULL,
  [InterestOverdue] [varchar](50) NULL,
  [NPADate] [varchar](50) NULL,
  [SecurityValue] [varchar](50) NULL
)
ON [PRIMARY]
GO