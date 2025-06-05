SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[ProductAddition]
AS
BEGIN

        DECLARE @TIMEKEY INT=(SELECT TIMEKEY FROM [IBL_ENPA_DB_V2].dbo.Automate_Advances WHERE EXT_FLG='Y')
		DECLARE @Counter INt
		SET @Counter = 1
		Declare @FinalCounter Int = (select Count(*) from ( select  distinct  Scheme_ProductCode 
									from ACCOUNT_ALL_SOURCE_SYSTEM
									except
									select distinct productcode from IBL_ENPA_DB_V2.dbo.DimProduct	)
								A)

		WHILE ( @Counter <= @FinalCounter
									) 
									BEGIN

Declare @Productcode varchar(20) = (
      select top 1 * 
      from 
		(   select  distinct  Scheme_ProductCode from ACCOUNT_ALL_SOURCE_SYSTEM
			except
			select distinct productcode from IBL_ENPA_DB_V2.dbo.DimProduct
		) A )

		DECLARE @SecuredStatus varchar(30) = (select distinct (CASE WHEN SecuredStatus = 'U' 
		THEN 'UNSECURED' ELSE 'SECURED' END) from ACCOUNT_ALL_SOURCE_SYSTEM where Scheme_ProductCode = @Productcode)

		DECLARE @ProductGroup varchar(30) = (	select distinct SchemeType 
												from ACCOUNT_ALL_SOURCE_SYSTEM 
												where Scheme_ProductCode = @Productcode)

-------------------------------------------------------------------------------------------------------------
Declare @SourceAlt_Key int=(select  distinct top 1 SourceAlt_Key from ACCOUNT_ALL_SOURCE_SYSTEM a
							inner join      IBL_ENPA_DB_V2..DIMSOURCEDB b
							on              a.SourceSystem=b.SourceName
							where           Scheme_ProductCode = @Productcode)

Declare @ProductName varchar(100)=''

IF (isnull(@ProductName,'') ='')
Begin
 Set @ProductName=@Productcode
END


Declare @SchemeType varchar(200)=(select  distinct top 1 SchemeType from ACCOUNT_ALL_SOURCE_SYSTEM a
							      where           Scheme_ProductCode = @Productcode)

Declare @FacilityType varchar(100)=(select  distinct top 1 (CASE WHEN FacilityType = 'LN' THEN 'TL' ELSE FacilityType END) from ACCOUNT_ALL_SOURCE_SYSTEM a
							      where           Scheme_ProductCode = @Productcode)

--Declare @NPA_Norms varchar(100)=(select  distinct top 1 isnull(AssetClassNorm,'90') from ACCOUNT_ALL_SOURCE_SYSTEM a
--							      where           Scheme_ProductCode = @Productcode)

--Declare @Agrischeme varchar(100)=(select  case when @NPA_Norms='365.000000' then 'Y' else 'N' end
--								  from    ACCOUNT_ALL_SOURCE_SYSTEM a
--							      where           Scheme_ProductCode = @Productcode)
--------------------------------------------------------------------------------------------------------------------
		INSERT INTO IBL_ENPA_DB_V2.dbo.DimProduct (ProductAlt_Key,ProductCode,ProductName,
		ProductGroup,ProductSubGroup,EffectiveFromTimeKey,EffectiveToTimeKey,CreatedBy,DateCreated,SourceAlt_Key,
		SchemeType,FacilityType)--,NPANorms,Agrischeme)
select max(ProductAlt_key)+1,@Productcode,@ProductName,@ProductGroup,@SecuredStatus,@TIMEKEY,49999,'D2K',GETDATE()
      ,@SourceAlt_Key,@SchemeType,@FacilityType--,@NPA_Norms,@Agrischeme
from IBL_ENPA_DB_V2.dbo.DimProduct 

SET @Counter = @Counter +1

END

END
GO