-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
use whumiscom
go
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE addApplication 
	-- Add the parameters for the stored procedure here
	@UserName char(32), 
	@Password char(32),
	@sqlbstr [nchar] (3) ,
       @sqyxstr[nvarchar] (100) ,
        @sqgdzy [nvarchar] (100) ,
        @xm [nvarchar] (100) ,
        @xb [nchar] (1),
        @mz [nvarchar] (100),
        @czrq [char] (8),
        @sfzhstr [char] (18),
        @yddh [char] (11),
        @dzyx [varchar] (100),
       @yzbm [char] (6),
       @txdz [nvarchar] (100),
       @xpmc [nvarchar] (100),
       @bkxx [nvarchar] (100),
        @bkyx [nvarchar] (100),
       @bkzy [nvarchar] (100),
       @rxsj [char] (4),
       @bysj [char] (4),
       @yysp [nvarchar] (100),
       @njrs [char] (5),
        @njpm [char] (5),
       @hjqk [nvarchar] (4000),
       @kylw [nvarchar] (4000),
       @grcs [nvarchar] (4000)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT OFF;

    -- Insert statements for procedure here
	INSERT INTO [xly].[dbo].[ѧ�������]([�������],[����Ժϵ],[���빥��רҵ],[����],[�Ա�],[����],[��������],[���֤��],[�ƶ��绰],[��������],[��������],[ͨѶ��ַ],[�����Ƭ·��],[����ѧУ],[����Ժϵ],[����רҵ],[������Уʱ��],[���Ʊ�ҵʱ��],[Ӣ��ˮƽ],[����רҵͬ�꼶����],[ǰ��ѧ�������ɼ��ڱ���רҵͬ�꼶������],[У�����ϻ����],[�μӿ��й����ͷ������ĵ����],[���˳���]) VALUES(
      @sqlbstr,
       @sqyxstr,
        @sqgdzy,
        @xm,
        @xb,
        @mz,
        @czrq,
        @sfzhstr,
        @yddh,
        @dzyx,
       @yzbm,
       @txdz,
       @xpmc,
       @bkxx,
        @bkyx,
       @bkzy,
       @rxsj,
       @bysj,
       @yysp,
       @njrs,
        @njpm,
       @hjqk,
       @kylw,
       @grcs)


	
GO
  