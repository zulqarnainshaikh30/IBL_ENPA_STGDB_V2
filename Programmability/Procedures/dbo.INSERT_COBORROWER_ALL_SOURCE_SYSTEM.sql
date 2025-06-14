﻿SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[INSERT_COBORROWER_ALL_SOURCE_SYSTEM]
AS
BEGIN

--SELECT * INTO COBORROWER_ALL_SOURCE_SYSTEM FROM MERGE_COBORROWER

/*INSERT IN STD_PROVISION_ALL_SOURCE_SYSTEM FROM  MERGE_STD_PROVISION*/

INSERT INTO COBORROWER_ALL_SOURCE_SYSTEM(
										AS_ON_DATE
										,ENT_CIF
										,SOURCE
										,SRC_CIF
										,ACC_NO
										,COBO_ENT_CIF
									)
		SELECT 
			AS_ON_DATE
			,ENT_CIF
			,SOURCE
			,SRC_CIF
			,ACC_NO
			,COBO_ENT_CIF
		FROM MERGE_COBORROWER

END
GO