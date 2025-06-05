SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[AutomateAdvancesTimeChange]
AS
BEGIN

DECLARE @Date date
SET @Date = (select distinct DateofData  from CUSTOMER_ALL_SOURCE_SYSTEM )

update [RBL_STGDB].dbo.AUTOMATE_ADVANCES set Ext_flg = 'N' where Ext_flg = 'Y'

update [RBL_STGDB].dbo.AUTOMATE_ADVANCES set Ext_flg = 'Y' where cast(date as date) = @Date

update [RBL_MISDB].dbo.AUTOMATE_ADVANCES set Ext_flg = 'N' where Ext_flg = 'Y'

update [RBL_MISDB].dbo.AUTOMATE_ADVANCES set Ext_flg = 'Y' where cast(date as date) = @Date

update [RBL_MISDB].dbo.Sysdatamatrix set Currentstatus = 'U' where Currentstatus = 'C'

update [RBL_MISDB].dbo.Sysdatamatrix set Currentstatus = 'C' where cast(MonthLastdate as date) = @Date


END

GO