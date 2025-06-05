CREATE TABLE [dbo].[PACKAGE_AUDIT] (
  [Execution_date] [date] NULL,
  [DataBaseName] [nvarchar](30) NULL,
  [PackageName] [nvarchar](100) NOT NULL,
  [SourceName] [nvarchar](100) NOT NULL,
  [ExecutionStartTime] [smalldatetime] NULL,
  [ExecutionEndTime] [smalldatetime] NULL,
  [TimeDuration_Min] [int] NULL,
  [ExecutionStatus] [nvarchar](10) NOT NULL,
  [Tablename] [varchar](100) NULL
)
ON [PRIMARY]
GO