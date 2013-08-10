using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Text;
using System.Web.Security;

public partial class register : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

        }
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        if (Page.IsValid && Session["imag"] != null && Session["imag"].ToString() != "")
        {
            String sqlbstr = sqlb.SelectedValue;
            String sqyxstr = DropDownList1.SelectedValue.ToString().Trim();
            String sqgdzy = txtzy.Value;
            String xm = tb_name.Text.Trim();
            String xb = rbl_xb.SelectedValue == "1" ? "男" : "女";
            String mz = DropDownList3.SelectedValue;
            String czrq = tb_csrq.Value;
            String sfzhstr = sfzh.Text;
            String yddh = tb_yddh.Text;
            String dzyx = tb_dzyx.Text;
            String yzbm = tb_yzbm.Text;
            String txdz = tb_txdz.Text;
            String xpmc = sfzhstr+".jpg";// Session["filenName"].ToString();
            String bkxx = xxxTextBox1.Text;
            String bkyx = tb_bkyx.Text;
            String bkzy = tb_bkzy.Text;
            String rxsj = Slider1.Value;
            String bysj = Slider2.Value;
            String yysp = tb_yysp.Text;
            String njrs = tb_bkrs.Text;
            String njpm = tb_njpm.Text;
            String hjqk = tb_hjqk.Text;
            String kylw = Tb_kylw.Text;
            String grcs = tb_grcs.Text;

            String strConnection = ConfigurationManager.ConnectionStrings["SQLServerConn"].ToString();
            SqlConnection con = new SqlConnection(strConnection);
            String cmdstr = "select ifopen from SummerCamp.dbo.[培养单位用户] where ACADEMICNAME='" + sqyxstr + "'";
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

            if (ifopen != "1")
            {
                Page.ClientScript.RegisterStartupScript(Page.GetType(), "", "<script language=javascript>alert('该学院网上报名时间已过，目前不再接收新的申请')</script>");
                return;
            }

            String photoadd = ConfigurationManager.ConnectionStrings["photoAddress"].ToString() + sfzhstr +".jpg";
            if (Session["stream"] != null && Session["stream"].ToString() != "")
            {
                 if (File.Exists(photoadd))  
                   File.Delete(photoadd);

                 Stream ms = (Stream)Session["stream"];
                 System.Drawing.Image myimage = System.Drawing.Image.FromStream(ms);
                 FileStream myFs = new FileStream(photoadd, FileMode.Create);

                 myimage.Save(myFs, System.Drawing.Imaging.ImageFormat.Jpeg);
                 myFs.Close();
                 myFs = null;
                

            }

	    string procedureName = "addApplication"; //存储过程名称
            SqlParameter[] sqlParameters = 
            {
            new SqlParameter("sqlbstr",sqlbstr), 
            new SqlParameter("sqyxstr",sqyxstr ),
            new SqlParameter("sqgdzy", sqgdzy),
            new SqlParameter("xm", xm),
            new SqlParameter("xb", xb),
            new SqlParameter("mz", mz),
            new SqlParameter("czrq", czrq),
            new SqlParameter("sfzhstr", sfzhstr),
            new SqlParameter("yddh", yddh),
            new SqlParameter("dzyx", dzyx),
            new SqlParameter("yzbm", yzbm),
            new SqlParameter("txdz", txdz),
            new SqlParameter("xpmc", xpmc),
            new SqlParameter("bkxx", bkxx),
            new SqlParameter("bkyx", bkyx),
            new SqlParameter("bkzy", bkzy),
            new SqlParameter("rxsj", rxsj),
            new SqlParameter("bysj", bysj),
            new SqlParameter("yysp", yysp),
            new SqlParameter("njrs", njrs),
            new SqlParameter("njpm", njpm),
            new SqlParameter("hjqk", hjqk),
            new SqlParameter("kylw", kylw),
            new SqlParameter("grcs", grcs),
            };

	   
	    int result = 0;
             try 
            {  
                con.Open();  
                SqlCommand com = new SqlCommand(procedureName, con); 
                com.CommandType = CommandType.StoredProcedure; 
                com.Parameters.AddRange(sqlParameters); 
                result = com.ExecuteNonQuery(); 
            }  
            catch (Exception Error) 
            {  
                throw Error; 
            }  
            finally 
            {  
                con.Close();
                Session["stream"] = "";
               
            }



//              String cmdstr = "INSERT INTO [xly].[dbo].[学生申请表]([申请类别],[申请院系],[申请攻读专业],[姓名],[性别],[民族],[出生日期]"
//            + " ,[身份证号],[移动电话],[电子邮箱],[邮政编码],[通讯地址],[免冠照片路径],[本科学校],[本科院系],[本科专业],[本科入校时间]"
//            + ",[本科毕业时间],[英语水平],[本科专业同年级人数],[前五学期总评成绩在本科专业同年级的排名],[校级以上获奖情况],[参加科研工作和发表论文等情况],[个人陈述])"
//      + " VALUES('" + sqlbstr + "','"
//          + sqyxstr + "','"
//          + sqgdzy + "','"
//          + xm + "','"
//          + xb + "','"
//          + mz + "','"
//          + czrq + "','"
//          + sfzhstr + "','"
//          + yddh + "','"
//          + dzyx + "','"
//          + yzbm + "','"
//          + txdz + "','"
//          + xpmc + "','"
//          + bkxx + "','"
//          + bkyx + "','"
//          + bkzy + "','"
//          + rxsj + "','"
//          + bysj + "','"
//          + yysp + "','"
//          + njrs + "','"
//          + njpm + "','"
//          + hjqk + "','"
//          + kylw + "','"
//          + grcs + "')";
// 
// 
//             String strConnection = ConfigurationManager.ConnectionStrings["SQLServerConn"].ToString();
// 
//             SqlConnection con = new SqlConnection(strConnection);
//             SqlCommand cmd = con.CreateCommand();
//             cmd.CommandText = cmdstr;
//             con.Open();
//             int result = cmd.ExecuteNonQuery();
//             con.Close();
             if (result < 1)
                 Page.ClientScript.RegisterStartupScript(Page.GetType(), "", "<script language=javascript>alert('用户注册失败')</script>");
             else
             {
                 FormsAuthentication.SetAuthCookie(xm, true);
                 Session["xm"] = xm;
                 Session["sfzh"] = sfzhstr;
                 Session["yx"] = sqyxstr;  
                 Page.ClientScript.RegisterStartupScript(Page.GetType(), "", "<script language=javascript>alert('用户注册成功');window.location = 'user/applyinfo.aspx'</script>");
             }
        }

    }


    protected void DropDownList1_DataBound(object sender, EventArgs e)
    {
        ListItem it = new ListItem("请选择院系", "请选择院系");
        DropDownList1.Items.Insert(0, it);
    }
    protected void DropDownList3_DataBound(object sender, EventArgs e)
    {
        ListItem it = new ListItem("请选择民族", "请选择民族");
        DropDownList3.Items.Insert(0, it);
    }  
    
}