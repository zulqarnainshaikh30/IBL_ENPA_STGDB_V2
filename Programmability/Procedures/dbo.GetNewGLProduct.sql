SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROC [dbo].[GetNewGLProduct]
AS 
BEGIN
/****
Purpose:- Identify new GL-Product combination and insert it into DimGLProduct master with all other required details.
Created by:- Pranay
Date Created:- 2021-06-30
********/

DECLARE @Cnt INT,@COUNTER INT=1, @GLProductAlt_KeyMax INT,@GLCode varchar(20),@ProductCode varchar(10)
,@ProductName varchar(200) ,@GLName varchar(200),@GLType varchar(10),@GLSta varchar(10),@GLGroup varchar(10)
,@AssetClass varchar(20),@AssetClassGrp varchar(4),@FacilityType varchar(10),@FacilitySubType varchar(10),@SrcSysModule varchar(10)

DROP TABLE IF EXISTS NewGLProduct
SELECT ROW_NUMBER()OVER(ORDER BY (SELECT 1)) RN,* INTO NewGLProduct FROM
(
	SELECT DISTINCT GLCode AS GLCode,Scheme_ProductCode AS ProductCode FROM ENBD_STGDB.[dbo].FINACLE_ACCOUNT_STG
	EXCEPT
	SELECT DISTINCT  GLCode,ProductCode FROM ENBD_MISDB.dbo.DimGLProduct
) A
 --select * FROM NewGLProduct
SELECT @Cnt=COUNT(1) FROM NewGLProduct

    WHILE (@Cnt>=@COUNTER)

		BEGIN
				SELECT @GLProductAlt_KeyMax=MAX(GLProductAlt_Key)+1 FROM ENBD_MISDB.dbo.DimGLProduct

				SELECT @GLCode=GLCode,@ProductCode=ProductCode FROM NewGLProduct WHERE RN=@COUNTER
				
				SELECT @SrcSysModule= SchemeType
						,@AssetClassGrp=CASE  WHEN  SchemeType IN('LAA','CLA')THEN 'TLDL' 
											  WHEN  SchemeType IN('ODA','PCA','SBA','CAA')THEN 'CCOD'
											  WHEN  SchemeType IN('FBA')THEN 'BILL' END

						,@FacilityType=CASE   WHEN  SchemeType IN('LAA','CLA')THEN 'TL' 
											  WHEN  SchemeType IN('ODA')THEN 'OD'
											  WHEN  SchemeType IN('PCA')THEN 'PC'
											  WHEN  SchemeType IN('FBA')THEN 'BP' END 

				 FROM ENBD_STGDB.dbo.FINACLE_ACCOUNT_STG WHERE Scheme_ProductCode=@ProductCode 

				SELECT @GLName=MAX(GLName) FROM ENBD_MISDB.DBO.DimGL WHERE  GLCode=@GLCode

				SELECT @ProductName=Max(ProductName) FROM ENBD_MISDB.DBO.DimProduct WHERE  ProductCode=@ProductCode

				SELECT @GLType =Max(GLType), @GLSta=Max(GLSta), @GLGroup=MAX(GLGroup), @AssetClass=Max(AssetClass)
					   FROM ENBD_MISDB.dbo.DimGLProduct  WHERE  GLCode=@GLCode
				
				SELECT @FacilitySubType=Max(FacilitySubType) FROM ENBD_MISDB.dbo.DimGLProduct WHERE  ProductCode=@ProductCode
				
				--SELECT @GLProductAlt_KeyMax GLProductAlt_KeyMax,@GLCode AS GLCode,@ProductCode AS ProductCode
				--	  ,@GLName AS GLName,  @ProductName AS ProductName, @FacilitySubType AS FacilitySubType, @SrcSysModule AS SrcSysModule, @AssetClassGrp AS AssetClassGrp
				--	  ,@FacilityType AS FacilityType,@AssetClass AS AssetClass
				--PRINT @COUNTER
				--PRINT @GLProductAlt_KeyMax
				
				INSERT INTO ENBD_MISDB.DBO.DimGLProduct 
				(
					 [GLProduct_Key], [GLProductAlt_Key], [GLCode], [GLName], [ProductCode], [ProductName], 
					 [EffectiveFromTimeKey], [EffectiveToTimeKey], [CreatedBy], [DateCreated], 
					 [GLType],[GLSta],[GLGroup],[AssetClass],[AssetClassGrp],[FacilityType],[FacilitySubType],[SrcSysModule]
				)VALUES
				(
					@GLProductAlt_KeyMax,@GLProductAlt_KeyMax,@GLCode,@GLName,@ProductCode,@ProductName,
					1400,49999,'SSIS-USER',GETDATE(),@GLType,@GLSta,@GLGroup,@AssetClass,@AssetClassGrp,
					@FacilityType,@FacilitySubType,@SrcSysModule
				) 


				SET @COUNTER=@COUNTER+1

		END 
END
GO