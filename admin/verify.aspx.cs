using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.Office.Interop.Word;
using System.IO;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;

public partial class admin_verify : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
       
        
       // Image1.ImageUrl = "yjsy.jpg";
//           if (Session["shzt"] == null || Session["shzt"].ToString() == "")
//         {
//             confirm.Disabled = true;
//             cexiao.Enabled = false;
//         }
        win.Attributes.Add("onload", "setheight(this)");
        if (Session["yx"] == null || Session["yx"].ToString() == "")
            Response.Redirect("adminlogin.aspx");//如果未登录，回到登录页
        else if (Session["yx"].ToString().Trim() == "研究生院")
        {
            Image1.ImageUrl = "yjsy.jpg";//研究生院用户,切换LOG图片
            Button4.Visible = false;//隐藏报名按钮
        }
        else cexiao.Visible=false;//普通用户，隐藏撤销按钮

//          if (Session["yx"].ToString().Trim() == "研究生院"
//               && (Session["shzt"]!=null&&
//               (Session["shzt"].ToString().Trim() == "研究生院审核中"
//               || Session["shzt"].ToString().Trim() == "院系审核不通过")))
//          {
//              cexiao.Enabled = true;//研究生院用户，且当前用户的申请状态符合
//          }
//          else cexiao.Enabled = false;


        yydw.Text = Session["yx"] != null ? Session["yx"].ToString() : "";

        if (Session["yx"].ToString().Trim() == "研究生院")
        {
            SqlDataSource1.SelectCommand = "SELECT [姓名], [身份证号], [申请院系] FROM [学生申请表] where [申请状态] = '研究生院审核中';";
            SqlDataSource2.SelectCommand = "SELECT [姓名], [身份证号], [申请院系] FROM [学生申请表] where [申请状态] = '等待确认' or  [申请状态] = '确认完成';";
            SqlDataSource3.SelectCommand = "SELECT [姓名], [身份证号], [申请院系] FROM [学生申请表] where [申请状态] = '研究生院审核不通过';";
        }
        else
        {
            SqlDataSource1.SelectCommand = "SELECT [姓名], [身份证号], [申请院系] FROM [学生申请表] where [申请状态] = '院系审核中' and [申请院系] = '" + (Session["yx"] != null ? Session["yx"].ToString() : "") + "';";
            SqlDataSource2.SelectCommand = "SELECT [姓名], [身份证号], [申请院系] FROM [学生申请表] where [申请状态] <> '院系审核中' and [申请状态] <> '院系审核不通过' and [申请状态] <>'未审核' and [申请院系] = '" + (Session["yx"] != null ? Session["yx"].ToString() : "") + "';";
            SqlDataSource3.SelectCommand = "SELECT [姓名], [身份证号], [申请院系] FROM [学生申请表] where [申请状态] = '院系审核不通过' and [申请院系] = '" + (Session["yx"] != null ? Session["yx"].ToString() : "") + "';";
            Panel1.Visible = false;
        }

        if (!Page.IsPostBack)
        {
            String strConnection = ConfigurationManager.ConnectionStrings["SQLServerConn"].ToString();
            SqlConnection con = new SqlConnection(strConnection);

            String cmdstr = "select ifopen from SummerCamp.dbo.[培养单位用户] where ACADEMICNAME='" + Session["yx"].ToString().Trim() + "'";
            SqlCommand cmd = con.CreateCommand();
            cmd.CommandText = cmdstr;
            String ifopen;
            try
            {
                con.Open();
                ifopen = cmd.ExecuteScalar().ToString();
            }
            catch (Exception Error)
            {
                throw Error;
            }
            finally
            {
                con.Close();
            }

            if (ifopen == "1") { Button4.Value = "关闭报名"; }
            else { Button4.Value = "开放报名"; }


            DataList1.DataSourceID = "SqlDataSource1"; DataList1.DataBind();  //////////////////////////////////
        datalist1_bound();
            
            
        int num985, num211, numall, numqt;
        
        DataSet ds = new DataSet();
        try
        {
            con.Open();
            SqlCommand com = con.CreateCommand();
            String curyx2 = Session["bkyx"]!=null?Session["bkyx"].ToString():"";
            String curyx = curyx2.Trim();
            String cmdstr1, cmdstr2, cmdstr3;
            if (Session["yx"].ToString().Trim() == "研究生院")
            {
                cmdstr1 =
           "select count(*) from SummerCamp.[dbo].[学生申请表] a,SummerCamp.[dbo].高等院校表 b where  a.[申请状态] = '研究生院审核中' and a.[本科学校] = b.universityname and b.if985 = '1'";
                cmdstr2 = "select count(*) from SummerCamp.[dbo].[学生申请表] a,SummerCamp.[dbo].高等院校表 b where   a.[申请状态] = '研究生院审核中' and a.[本科学校] = b.universityname and b.if985 is null and b.if211 = '1'";
                cmdstr3 = "select count(*) from SummerCamp.[dbo].[学生申请表] a,SummerCamp.[dbo].高等院校表 b  where   a.[申请状态] = '研究生院审核中'  and a.[本科学校] = b.universityname and b.if211 is null and b.if985 is null ";

            }
            else
            {

                cmdstr1 =
             "select count(*) from SummerCamp.[dbo].[学生申请表] a,SummerCamp.[dbo].高等院校表 b where  a.[申请院系] = '"
             + curyx + "' and a.[申请状态] = '院系审核中' and a.[本科学校] = b.universityname and b.if985 = '1'";
                cmdstr2 = "select count(*) from SummerCamp.[dbo].[学生申请表] a,SummerCamp.[dbo].高等院校表 b where  a.[申请院系] = '"
            + curyx + "' and a.[申请状态] = '院系审核中' and a.[本科学校] = b.universityname and b.if985 is null and b.if211 = '1'";
                cmdstr3 = "select count(*) from SummerCamp.[dbo].[学生申请表] a,SummerCamp.[dbo].高等院校表 b  where  a.[申请院系] = '"
           + curyx + "' and a.[申请状态] = '院系审核中'  and a.[本科学校] = b.universityname and b.if211 is null and b.if985 is null ";
            }
            com.CommandText = cmdstr1;
            num985 = Convert.ToInt32(com.ExecuteScalar());
            com.CommandText = cmdstr2;
            num211 = Convert.ToInt32(com.ExecuteScalar());
            com.CommandText = cmdstr3;
            numqt = Convert.ToInt32(com.ExecuteScalar());
            
        }
        catch (Exception Error)
        {
            throw Error;
        }
        finally
        {
            con.Close();
        }
       
        ratio.Text = num985.ToString() + ":" + num211.ToString() + ":" + numqt.ToString();
        }
    }

   private void datalist1_bound()
    {
       String xm ="";
            String id = "";
            String yx = "";
            String strUrl = "";
       
       if (DataList1.Items.Count > 0)
        {
             xm = ((Label)DataList1.Items[0].FindControl("lb_name")).Text;
             id = ((Label)DataList1.Items[0].FindControl("lb_id")).Text;
             yx = ((Label)DataList1.Items[0].FindControl("lb_yx")).Text;
            strUrl = "confirminfo.aspx?xm=" + xm + "&id=" + id + "&yx=" + yx;
            win.Attributes.Add("src", strUrl);
       }
       else if(Session["xm"]!=null &&Session["xm"].ToString()!=""
           &&Session["id"]!=null &&Session["id"].ToString()!=""
           &&Session["bkyx"]!=null &&Session["bkyx"].ToString()!="")
           {xm=Session["xm"].ToString().Trim();
                id = Session["id"].ToString().Trim();
                yx=Session["bkyx"].ToString().Trim();
           strUrl = "confirminfo.aspx?xm=" + xm + "&id=" + id + "&yx=" + yx;
            win.Attributes.Add("src", strUrl);
           }

//             if (win.Attributes["src"] == null || win.Attributes["src"].ToString().Trim() == "")
//             {
               
//             }
//             else
//                 win.Attributes["src"] = strUrl;
            
        
    }
    protected void yxck_Click(object sender, EventArgs e)
    {
        String yx = DropDownList1.SelectedValue.ToString().Trim();
        String yxpb = "='"+yx+"'";
        if (yx == "所有院系") yxpb = "Like '%'";
        String lb = Select1.Items[Select1.SelectedIndex].ToString().Trim();
        //数据绑定
        SqlDataSource12.SelectCommand = "SELECT [姓名], [身份证号], [申请院系] FROM [学生申请表] where [申请状态] = '"+lb+"' and [申请院系] " +yxpb+ ";";
        DataList2.DataBind();


        //比例
        int num985, num211, numall, numqt;
        String strConnection = ConfigurationManager.ConnectionStrings["SQLServerConn"].ToString();
        SqlConnection con = new SqlConnection(strConnection);
        DataSet ds = new DataSet();
        try
        {
            con.Open();
            SqlCommand com = con.CreateCommand();
            
            String cmdstr1, cmdstr2, cmdstr3;
           
                cmdstr1 =
             "select count(*) from SummerCamp.[dbo].[学生申请表] a,SummerCamp.[dbo].高等院校表 b where  a.[申请院系] "
             + yxpb+ " and a.[申请状态] = '"+lb+"' and a.[本科学校] = b.universityname and b.if985 = '1'";
                cmdstr2 = "select count(*) from SummerCamp.[dbo].[学生申请表] a,SummerCamp.[dbo].高等院校表 b where  a.[申请院系] "
            + yxpb + " and a.[申请状态] = '"+lb+"' and a.[本科学校] = b.universityname and b.if985 is null and b.if211 = '1'";
                cmdstr3 = "select count(*) from SummerCamp.[dbo].[学生申请表] a,SummerCamp.[dbo].高等院校表 b  where  a.[申请院系] "
           + yxpb + " and a.[申请状态] = '" + lb+ "'  and a.[本科学校] = b.universityname and b.if211 is null and b.if985 is null ";
            
            com.CommandText = cmdstr1;
            num985 = Convert.ToInt32(com.ExecuteScalar());
            com.CommandText = cmdstr2;
            num211 = Convert.ToInt32(com.ExecuteScalar());
            com.CommandText = cmdstr3;
            numqt = Convert.ToInt32(com.ExecuteScalar());

        }
        catch (Exception Error)
        {
            throw Error;
        }
        finally
        {
            con.Close();
        }

        ratio2.Text = num985.ToString() + ":" + num211.ToString() + ":" + numqt.ToString();

    }
    protected void Button3_Click(object sender, EventArgs e)
    {
        DataList1.DataSourceID = "SqlDataSource1";
        DataList1.DataBind(); datalist1_bound();
        confirm.Disabled = false;
        int num985,num211,numall,numqt;
        String strConnection = ConfigurationManager.ConnectionStrings["SQLServerConn"].ToString();
        SqlConnection con = new SqlConnection(strConnection);        
        DataSet ds = new DataSet();
        try
        {
            con.Open();
            SqlCommand com = con.CreateCommand();
            String curyx2 = Session["bkyx"]!=null?Session["bkyx"].ToString():"";
            String curyx = curyx2.Trim();
            String cmdstr1, cmdstr2, cmdstr3;
            if (Session["yx"].ToString().Trim() == "研究生院")
            {
                cmdstr1 =
         "select count(*) from SummerCamp.[dbo].[学生申请表] a,SummerCamp.[dbo].高等院校表 b where   a.[申请状态] = '研究生院审核中' and a.[本科学校] = b.universityname and b.if985 = '1'";
                cmdstr2 = "select count(*) from SummerCamp.[dbo].[学生申请表] a,SummerCamp.[dbo].高等院校表 b where   a.[申请状态] = '研究生院审核中' and a.[本科学校] = b.universityname and b.if985 is null and b.if211 = '1'";
                cmdstr3 = "select count(*) from SummerCamp.[dbo].[学生申请表] a,SummerCamp.[dbo].高等院校表 b  where   a.[申请状态] = '研究生院审核中'  and a.[本科学校] = b.universityname and b.if211 is null and b.if985 is null ";
            }
            else
            {
                cmdstr1 =
             "select count(*) from SummerCamp.[dbo].[学生申请表] a,SummerCamp.[dbo].高等院校表 b where  a.[申请院系] = '"
             + curyx + "' and a.[申请状态] = '院系审核中' and a.[本科学校] = b.universityname and b.if985 = '1'";
                cmdstr2 = "select count(*) from SummerCamp.[dbo].[学生申请表] a,SummerCamp.[dbo].高等院校表 b where  a.[申请院系] = '"
            + curyx + "' and a.[申请状态] = '院系审核中' and a.[本科学校] = b.universityname and b.if985 is null and b.if211 = '1'";
                cmdstr3 = "select count(*) from SummerCamp.[dbo].[学生申请表] a,SummerCamp.[dbo].高等院校表 b  where  a.[申请院系] = '"
           + curyx + "' and a.[申请状态] = '院系审核中'  and a.[本科学校] = b.universityname and b.if211 is null and b.if985 is null ";
            }
                com.CommandText = cmdstr1;
            num985 = Convert.ToInt32(com.ExecuteScalar());
            com.CommandText = cmdstr2;
            num211 = Convert.ToInt32(com.ExecuteScalar());
            com.CommandText = cmdstr3;
            numqt = Convert.ToInt32(com.ExecuteScalar());
                    
        }
        catch (Exception Error)
        {
            throw Error;
        }
        finally
        {
            con.Close();
        }
       
        ratio.Text = num985.ToString() + ":" + num211.ToString() + ":" + numqt.ToString();
    }
    protected void shbtg_Click(object sender, EventArgs e)
    {
        DataList1.DataSourceID = "SqlDataSource3";
        DataList1.DataBind(); datalist1_bound();
       confirm.Disabled = true;

        int num985, num211, numall, numqt;
        String strConnection = ConfigurationManager.ConnectionStrings["SQLServerConn"].ToString();
        SqlConnection con = new SqlConnection(strConnection);
        DataSet ds = new DataSet();
        try
        {
            con.Open();
            SqlCommand com = con.CreateCommand();
            String curyx2 = Session["bkyx"]!=null?Session["bkyx"].ToString():"";
            String curyx = curyx2.Trim();
             String cmdstr1, cmdstr2, cmdstr3;
             if (Session["yx"].ToString().Trim() == "研究生院")
             {
                 cmdstr1 =
           "select count(*) from SummerCamp.[dbo].[学生申请表] a,SummerCamp.[dbo].高等院校表 b where   a.[申请状态] = '研究生院审核不通过' and a.[本科学校] = b.universityname and b.if985 = '1'";
                 cmdstr2 = "select count(*) from SummerCamp.[dbo].[学生申请表] a,SummerCamp.[dbo].高等院校表 b where   a.[申请状态] = '研究生院审核不通过' and a.[本科学校] = b.universityname and b.if985 is null and b.if211 = '1'";
                 cmdstr3 = "select count(*) from SummerCamp.[dbo].[学生申请表] a,SummerCamp.[dbo].高等院校表 b where   a.[申请状态] = '研究生院审核不通过' and a.[本科学校] = b.universityname  and b.if211 is null and b.if985 is null ";
             }
             else
             {
                 cmdstr1 =
             "select count(*) from SummerCamp.[dbo].[学生申请表] a,SummerCamp.[dbo].高等院校表 b where  a.[申请院系] = '"
             + curyx + "' and a.[申请状态] = '院系审核不通过' and a.[本科学校] = b.universityname and b.if985 = '1'";
                 cmdstr2 = "select count(*) from SummerCamp.[dbo].[学生申请表] a,SummerCamp.[dbo].高等院校表 b where  a.[申请院系] = '"
             + curyx + "' and a.[申请状态] = '院系审核不通过' and a.[本科学校] = b.universityname and b.if985 is null and b.if211 = '1'";
                 cmdstr3 = "select count(*) from SummerCamp.[dbo].[学生申请表] a,SummerCamp.[dbo].高等院校表 b where  a.[申请院系] = '"
            + curyx + "' and a.[申请状态] = '院系审核不通过' and a.[本科学校] = b.universityname  and b.if211 is null and b.if985 is null ";
             }
            com.CommandText = cmdstr1;
            num985 = Convert.ToInt32(com.ExecuteScalar());
            com.CommandText = cmdstr2;
            num211 = Convert.ToInt32(com.ExecuteScalar());
            com.CommandText = cmdstr3;
            numqt = Convert.ToInt32(com.ExecuteScalar());
           
        }
        catch (Exception Error)
        {
            throw Error;
        }
        finally
        {
            con.Close();
        }
      
        ratio.Text = num985.ToString() + ":" + num211.ToString() + ":" + numqt.ToString();
    }
    protected void shtg_Click(object sender, EventArgs e)
    {
        DataList1.DataSourceID = "SqlDataSource2";
        DataList1.DataBind(); datalist1_bound();
        confirm.Disabled=true;

        int num985, num211, numall, numqt;
        String strConnection = ConfigurationManager.ConnectionStrings["SQLServerConn"].ToString();
        SqlConnection con = new SqlConnection(strConnection);
        DataSet ds = new DataSet();
        try
        {
            con.Open();
            SqlCommand com = con.CreateCommand();
            String curyx2 = Session["bkyx"]!=null?Session["bkyx"].ToString():"";
            String curyx = curyx2.Trim();

              String cmdstr1, cmdstr2, cmdstr3;
              if (Session["yx"].ToString().Trim() == "研究生院")
              {
                  cmdstr1 =
             "select count(*) from SummerCamp.[dbo].[学生申请表] a,SummerCamp.[dbo].高等院校表 b where   (a.[申请状态] = '等待确认' or  a.[申请状态] = '确认完成')  and a.[本科学校] = b.universityname and b.if985 = '1'";
                  cmdstr2 = "select count(*) from SummerCamp.[dbo].[学生申请表] a,SummerCamp.[dbo].高等院校表 b where   (a.[申请状态] = '等待确认' or  a.[申请状态] = '确认完成') and a.[本科学校] = b.universityname and b.if985 is null and b.if211 = '1'";
                  cmdstr3 = "select count(*) from SummerCamp.[dbo].[学生申请表] a,SummerCamp.[dbo].高等院校表 b where   (a.[申请状态] = '等待确认' or  a.[申请状态] = '确认完成') and a.[本科学校] = b.universityname  and a.[本科学校] = b.universityname and b.if211 is null and b.if985 is null ";
              }
              else
              {

                  cmdstr1 =
              "select count(*) from SummerCamp.[dbo].[学生申请表] a,SummerCamp.[dbo].高等院校表 b where  a.[申请院系] = '"
              + curyx + "' and a.[申请状态] <> '院系审核中' and a.[申请状态] <> '院系审核不通过' and a.[申请状态] <>'未审核'  and a.[本科学校] = b.universityname and b.if985 = '1'";
                  cmdstr2 = "select count(*) from SummerCamp.[dbo].[学生申请表] a,SummerCamp.[dbo].高等院校表 b where  a.[申请院系] = '"
              + curyx + "' and a.[申请状态] <> '院系审核中' and a.[申请状态] <> '院系审核不通过' and a.[申请状态] <>'未审核' and a.[本科学校] = b.universityname and b.if985 is null and b.if211 = '1'";
                  cmdstr3 = "select count(*) from SummerCamp.[dbo].[学生申请表] a,SummerCamp.[dbo].高等院校表 b where  a.[申请院系] = '"
             + curyx + "' and a.[申请状态] <> '院系审核中' and a.[申请状态] <> '院系审核不通过' and a.[申请状态] <>'未审核' and a.[本科学校] = b.universityname  and a.[本科学校] = b.universityname and b.if211 is null and b.if985 is null ";
              }
            com.CommandText = cmdstr1;
            num985 = Convert.ToInt32(com.ExecuteScalar());
            com.CommandText = cmdstr2;
            num211 = Convert.ToInt32(com.ExecuteScalar());
            com.CommandText = cmdstr3;
            numqt = Convert.ToInt32(com.ExecuteScalar());
            
        }
        catch (Exception Error)
        {
            throw Error;
        }
        finally
        {
            con.Close();
        }
       
        ratio.Text = num985.ToString() + ":" + num211.ToString() + ":" + numqt.ToString();
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        String strConnection = ConfigurationManager.ConnectionStrings["SQLServerConn"].ToString();
        SqlConnection con = new SqlConnection(strConnection);
        DataSet ds = new DataSet();
        String curyx2 = Session["yx"] != null ? Session["yx"].ToString() : "";
        String curyx = curyx2.Trim();
        try
        {
            con.Open();
            SqlCommand com = con.CreateCommand();String cmdstr;
            if (Session["yx"].ToString().Trim() == "研究生院")
            {
                cmdstr =
             "SELECT a.[申请类别],a.[申请院系],a.[申请攻读专业],a.[姓名],a.[性别],a.[民族],a.[出生日期],a.[身份证号],a.[移动电话],a.[电子邮箱],a.[邮政编码],a.[通讯地址],a.[本科学校],a.[本科院系],a.[本科专业],a.[本科入校时间],a.[本科毕业时间],a.[英语水平],a.[本科专业同年级人数],a.[前五学期总评成绩在本科专业同年级的排名],a.[校级以上获奖情况],a.[参加科研工作和发表论文等情况],a.[申请状态],a.[不通过原因], b.if985 [本科院校是否985],b.if211 [本科院校是否211] from SummerCamp.[dbo].[学生申请表] a,SummerCamp.[dbo].高等院校表 b where a.[本科学校] = b.universityname ";
            }
            else
            {
                cmdstr =
             "SELECT a.[申请类别],a.[申请院系],a.[申请攻读专业],a.[姓名],a.[性别],a.[民族],a.[出生日期],a.[身份证号],a.[移动电话],a.[电子邮箱],a.[邮政编码],a.[通讯地址],a.[本科学校],a.[本科院系],a.[本科专业],a.[本科入校时间],a.[本科毕业时间],a.[英语水平],a.[本科专业同年级人数],a.[前五学期总评成绩在本科专业同年级的排名],a.[校级以上获奖情况],a.[参加科研工作和发表论文等情况],a.[申请状态],a.[不通过原因], b.if985 [本科院校是否985],b.if211 [本科院校是否211] from SummerCamp.[dbo].[学生申请表] a,SummerCamp.[dbo].高等院校表 b where  a.[申请院系] = '"
             + curyx + "' and   a.[本科学校] = b.universityname ";
            }
            com.CommandText = cmdstr;
            SqlDataAdapter sa = new SqlDataAdapter(com);
            sa.Fill(ds);           
        }
        catch (Exception Error)
        {
            throw Error;
        }
        finally
        {
            con.Close();
        }
        String filename = HttpUtility.UrlEncode(curyx, System.Text.Encoding.UTF8).ToString() +".xls";
        CreateExcel2(ds,"1", filename);
        //导出
        string file = filename.ToString();
        FileInfo fi = new FileInfo(file);
        Response.Clear();
        Response.ClearHeaders();
        Response.Buffer = false;
        //Response.AppendHeader("Content-Disposition","attachment;filename=" +HttpUtility.UrlEncode(Path.GetFileName(destFileName),System.Text.Encoding.Default));
        Response.AppendHeader("Content-Disposition", "attachment;filename=" + HttpUtility.UrlEncode(Path.GetFileName(file), System.Text.Encoding.UTF8));
        Response.AppendHeader("Content-Length", fi.Length.ToString());
        Response.ContentType = "application/octet-stream";
        Response.WriteFile(file);
        Response.Flush();
        Response.End();
    }

    public void CreateExcel2(DataSet ds, string typeid, string FileName)
    {
        HttpResponse resp;
        resp = Page.Response;
        resp.ContentEncoding = System.Text.Encoding.GetEncoding("GB2312");
        resp.AppendHeader("Content-Disposition", "attachment;filename=" + FileName);
        resp.Charset = "UTF-8";
        //HttpContext.Current.Response.ContentEncoding =System.Text.Encoding.Default;
        resp.ContentType = "application/ms-excel";//image/JPEG;text/HTML;image/GIF;vnd.ms-excel
        string colHeaders = "", ls_item = "";
        int i = 0;


        //定义表对象与行对像，同时用DataSet对其值进行初始化
        System.Data.DataTable dt = ds.Tables[0];
        DataRow[] myRow = dt.Select("");
        // typeid=="1"时导出为EXCEL格式文件；typeid=="2"时导出为XML格式文件
        if (typeid == "1")
        {

            //取得数据表各列标题，各标题之间以\t分割，最后一个列标题后加回车符
            colHeaders += "<table cellspacing=\"0\" cellpadding=\"5\" rules=\"all\" border=\"1\">  <tr style=\"font-weight: bold; white-space: nowrap;\">";
            for (i = 0; i < dt.Columns.Count - 1; i++)
                //colHeaders+=dt.Columns[i].Caption.ToString()+"\t";
                colHeaders += "<td>" + dt.Columns[i].Caption.ToString() + "</td>";
            //colHeaders +=dt.Columns[i].Caption.ToString() +"\n"; 
            colHeaders += "<td>" + dt.Columns[i].Caption.ToString() + "</td></tr>";
            //向HTTP输出流中写入取得的数据信息
            resp.Write(colHeaders);
            //逐行处理数据  
            foreach (DataRow row in myRow)
            {
                ls_item += "<tr>";
                //在当前行中，逐列获得数据，数据之间以\t分割，结束时加回车符\n
                for (i = 0; i < dt.Columns.Count - 1; i++)
                    //ls_item +=row[i].ToString().Replace("\t","") + "\t";   
                    ls_item += "<td style=\"vnd.ms-excel.numberformat:@\">" + row[i].ToString().Replace("\t", "").Replace("\"", "＂").Replace("\r\n", "<br style='mso-data-placement:same-cell;'/>") + "</td>";
                ls_item += "<td>" + row[i].ToString().Replace("\t", "").Replace("\"", "＂").Replace("\r\n", "<br style='mso-data-placement:same-cell;'/>") + "</td></tr>";
                //当前行数据写入HTTP输出流，并且置空ls_item以便下行数据    
                resp.Write(ls_item);
                ls_item = "";
            }
        }
        else
        {
            if (typeid == "2")
            {
                //从DataSet中直接导出XML数据并且写到HTTP输出流中
                resp.Write(ds.GetXml());
            }
        }
        //写缓冲区中的数据到HTTP头文件中
        resp.End();


    }
    public void CreateExcel(DataSet ds, string FileName)
    {
        HttpResponse resp;
        resp = Page.Response;
        resp.ContentEncoding = System.Text.Encoding.GetEncoding("GB2312");
        resp.AppendHeader("Content-Disposition", "attachment;filename=" + FileName);
        string colHeaders = "", ls_item = "";

        //定义表对象与行对象，同时用DataSet对其值进行初始化
        System.Data.DataTable dt = ds.Tables[0];
        DataRow[] myRow = dt.Select();//可以类似dt.Select("id>10")之形式达到数据筛选目的
        int i = 0;
        int cl = dt.Columns.Count;


        //取得数据表各列标题，各标题之间以\t分割，最后一个列标题后加回车符
        for (i = 0; i < cl; i++)
        {
            if (i == (cl - 1))//最后一列，加\n
            {
                colHeaders += dt.Columns[i].Caption.ToString() + "\n";
            }
            else
            {
                colHeaders += dt.Columns[i].Caption.ToString() + "\t";
            }

        }
        resp.Write(colHeaders);
        //向HTTP输出流中写入取得的数据信息

        //逐行处理数据  
        foreach (DataRow row in myRow)
        {
            //当前行数据写入HTTP输出流，并且置空ls_item以便下行数据    
            for (i = 0; i < cl; i++)
            {
                if (i==7)
                {
                    ls_item += "TEXT(" + row[i].ToString().Replace("\"", "＂") +  ",0)" + "\t";
                    //ls_item += "ID:" + row[i].ToString().Replace("\"", "＂") + "\t";
                }
                else if (i == (cl - 1))//最后一列，加\n
                {
                    //ls_item += row[i].ToString().Replace("\"", "＂").Replace("\r\n", " ").Replace("\n", " ") + "\n";
                    ls_item += "\"" + row[i].ToString() .Replace("\"","＂")+ "\"" + "\n";
                   
                }
                else
                {
                    //ls_item += row[i].ToString().Replace("\"", "＂").Replace("\r\n", "＂").Replace("\n", " ") + "\t";
                   ls_item += "\"" + row[i].ToString().Replace("\"", "＂") + "\"" + "\t";
                }

            }
            resp.Write(ls_item);
            ls_item = "";

        }
        resp.End();
    }


    protected void zx_Click(object sender, EventArgs e)
    {
        Session["yx"] = "";
        Session["yx"] = null;
        Session["xm"] = ""; Session["id"] = ""; Session["bkyx"] = "";
        Session["imag"] = ""; Session["shzt"] = ""; Session["info"] = "";
        Session["xm"] = null; Session["id"] = null; Session["bkyx"] = null;
        Session["imag"] = null; Session["shzt"] = null; Session["info"] = null;
        Response.Redirect("adminlogin.aspx");
    }
    protected void Button3_Click1(object sender, EventArgs e)
    {
        if (Session["yx"] == null || Session["yx"].ToString() == "")
        {
            String what = Button4.Value;
            String yx = Session["yx"].ToString().Trim();


            String cmdstr = "update SummerCamp.dbo.[培养单位用户] set ifopen = '' where ACADEMICNAME='" + yx + "';";

            String strConnection = ConfigurationManager.ConnectionStrings["SQLServerConn"].ToString();
            SqlConnection con = new SqlConnection(strConnection);
            SqlCommand cmd = con.CreateCommand();
            cmd.CommandText = cmdstr;
            int result = 0;

            try
            {
                con.Open();

                result = cmd.ExecuteNonQuery();
            }
            catch (Exception Error)
            {
                throw Error;
            }
            finally
            {
                con.Close();
            }

            if (result < 1)
                Page.ClientScript.RegisterStartupScript(Page.GetType(), "", "<script language=javascript>alert('"+what+"成功')</script>");		
	                else
                Page.ClientScript.RegisterStartupScript(Page.GetType(), "", "<script language=javascript>alert('" + what + "失败')</script>");		

        
        
        }
    }
    protected void cexiao_Click(object sender, EventArgs e)
    {
        if (Session["yx"] != null && Session["yx"].ToString() == "研究生院"
            && Session["xm"] != null && Session["xm"].ToString() != ""
            && Session["id"] != null && Session["id"].ToString() != "")
        {
            String yx = Session["yx"].ToString();
            String sqyx = Session["bkyx"].ToString();
            String xm = Session["xm"].ToString();
            String id = Session["id"].ToString();
            String shzt = Session["shzt"] == null ? "" : Session["shzt"].ToString().Trim();
            if (shzt!="研究生院审核中"&&shzt!="院系审核不通过"&&shzt!="等待确认"&&shzt!="研究生院审核不通过")
            {
                Page.ClientScript.RegisterStartupScript(Page.GetType(), "", "<script language=javascript>alert('对当前状态："+shzt+"---无撤销权限')</script>");
                return;
            }

            String cmdstr = "update SummerCamp.dbo.[学生申请表] set [申请状态] = '院系审核中' where [姓名]='" + xm +
                "' and [申请院系]='" + sqyx
                + "' and [身份证号]='" + id + "'";

            String strConnection = ConfigurationManager.ConnectionStrings["SQLServerConn"].ToString();
            SqlConnection con = new SqlConnection(strConnection);
            SqlCommand cmd = con.CreateCommand();
            cmd.CommandText = cmdstr;
            int result = 0;

            try
            {
                con.Open();

                result = cmd.ExecuteNonQuery();
                cmd.CommandText = "update SummerCamp.dbo.[学生申请表] set [申请状态] =replace([申请状态],' ','')  where [姓名]='" + xm +
                "' and [申请院系]='" + sqyx
                + "' and [身份证号]='" + id + "'";
                cmd.ExecuteNonQuery();
            }
            catch (Exception Error)
            {
                throw Error;
            }
            finally
            {
                con.Close();
            }

            if (result < 1)
                Page.ClientScript.RegisterStartupScript(Page.GetType(), "", "<script language=javascript>alert('撤销审核至院系审核中失败')</script>");
            else
            {
                DataList1.DataBind(); 
                 String yx2 = DropDownList1.SelectedValue.ToString().Trim();
        String lb = Select1.Items[Select1.SelectedIndex].ToString().Trim();
        //数据绑定
        SqlDataSource12.SelectCommand = "SELECT [姓名], [身份证号], [申请院系] FROM [学生申请表] where [申请状态] = '"+lb+"' and [申请院系] = '" +yx2+ "';";
        DataList2.DataBind();
        Page.ClientScript.RegisterStartupScript(Page.GetType(), "", "<script language=javascript> $$('li_1').click(); $$('yxck').click();alert('撤销审核至院系审核中成功')</script>");
            }



        }
    }
}