SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
--select * from UTKS_MISDB.[dbo].[DimBranch]
 
CREATE PROCEDURE [dbo].[BranchAddition] 
AS
BEGIN

DECLARE @TIMEKEY INT=(SELECT TIMEKEY FROM [UTKS_MISDB].dbo.Automate_Advances WHERE EXT_FLG='Y')
DECLARE @Counter INt =1 
Declare @FinalCounter Int = (select Count(*) from ( select  distinct  BranchCode from LMS_ACCOUNT_STG
							 except
							 select distinct BranchCode from UTKS_MISDB.dbo.DimBranch) A) 
WHILE ( @Counter <= @FinalCounter) 

BEGIN 
Declare @Branchcode varchar(20) = (
      select top 1 * 
      from 
		(   select  distinct  BranchCode from LMS_ACCOUNT_STG 
			except
			select distinct BranchCode from UTKS_MISDB.dbo.DimBranch
		) A )  
Declare @BranchName varchar(100)=''

IF (isnull(@BranchName,'') ='')
Begin
 Set @BranchName=@Branchcode
END

--Select @Branchcode
--Select @BranchName
 
INSERT INTO UTKS_MISDB.dbo.DimBranch 
(
BranchAlt_key,
Branchcode,
BranchName, 
EffectiveFromTimeKey,
EffectiveToTimeKey
) 
select  
max(BranchAlt_key)+1,
@Branchcode, 
@BranchName,
1,
49999 
from UTKS_MISDB.dbo.DimBranch 

SET @Counter = @Counter +1

END

END
GO