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
	INSERT INTO [xly].[dbo].[学生申请表]([申请类别],[申请院系],[申请攻读专业],[姓名],[性别],[民族],[出生日期],[身份证号],[移动电话],[电子邮箱],[邮政编码],[通讯地址],[免冠照片路径],[本科学校],[本科院系],[本科专业],[本科入校时间],[本科毕业时间],[英语水平],[本科专业同年级人数],[前五学期总评成绩在本科专业同年级的排名],[校级以上获奖情况],[参加科研工作和发表论文等情况],[个人陈述]) VALUES(
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
  