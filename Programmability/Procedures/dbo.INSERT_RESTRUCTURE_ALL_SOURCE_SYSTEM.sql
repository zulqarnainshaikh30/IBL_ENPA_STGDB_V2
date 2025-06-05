SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[INSERT_RESTRUCTURE_ALL_SOURCE_SYSTEM]
AS
DECLARE @TimeKey INT = (SELECT TimeKey FROM IBL_ENPA_DB_V2..SysDataMatrix WHERE CurrentStatus='C' )
DECLARE @Exec_Date DATE=(SELECT DATE FROM IBL_ENPA_DB_V2..SysDataMatrix WHERE TimeKey=@TimeKey )

BEGIN

--SELECT * INTO RESTRUCTURE_ALL_SOURCE_SYSTEM FROM MERGE_RESTRUCTURE

/*INSERT IN RESTRUCTURE_ALL_SOURCE_SYSTEM FROM  MERGE_RESTRUCTURE*/


INSERT INTO RESTRUCTURE_ALL_SOURCE_SYSTEM
			SELECT
				AS_ON_DATE
				,SOURCE
				,ENT_CIF
				,SRC_CIF
				,ACC_NO
				,RESTR_DATE
				,RESTR_TYPE
				,RESTR_AMT
				,DFV_AMT
				,TKOUT_FIN
				,LATEST_REPAY_DATE
				,BATCH_ID
				,TEN_PC_DATE
			FROM MERGE_RESTRUCTURE



/*UPDATING DATA IN RESTRUCTURE FOR CHANGED UCIC ID FROM DAILY*/

/*UPDATE C SET C.RefCustomer_CIF=B.UCIF_ID
FROM IBL_ENPA_STGDB_V2.DBO.ACCOUNT_ALL_SOURCE_SYSTEM A
INNER JOIN IBL_ENPA_STGDB_V2.dbo.CUSTAC_MERGE_DAILY B ON 
												--A.EffectiveFromTimeKey<=@TimeKey
                                                -- AND A.EffectiveToTimeKey>=@TimeKey AND 
												 B.AsONDATE=@Exec_Date
												 AND A.CustomerID=B.RefCustomerID
												 AND A.CustomerACID=B.CustomerAcID
INNER JOIN  CURDAT.AdvAcRestructureDetail C ON C.EffectiveFromTimeKey<=@TimeKey-1
                                           AND C.EffectiveToTimeKey>=@TimeKey-1
							               AND A.CustomerID=C.RefCustomerID
									       AND A.CustomerACID=C.RefSystemAcId 
										   AND A.SrcSysAlt_Key=C.SrcSysAlt_Key
WHERE ISNULL(A.UCIC_ID,'')<>ISNULL(B.UCIF_ID,'')
--AND A.SrcSysAlt_Key=@SrcSysAlt_Key
*/
END
GO