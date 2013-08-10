using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

using System.Data;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Text;
using System.Web.Security;

public partial class applyinfo : System.Web.UI.Page
{
    protected  static string sqzt = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["xm"] != null && Session["xm"].ToString() != ""
                && Session["sfzh"] != null && Session["sfzh"].ToString() != ""
                && Session["yx"] != null && Session["yx"].ToString() != "")
            {


                String imageadd = ConfigurationManager.ConnectionStrings["photoAddress"].ToString() + Session["sfzh"].ToString() + ".jpg";
           
                if (File.Exists(imageadd))
                {
                    FileStream fs = new FileStream(imageadd,FileMode.Open,FileAccess.Read);
                    byte[] imgsource = new byte[fs.Length];
                    fs.Read(imgsource, 0, imgsource.Length);
                    fs.Close();
                    fs = null;
                    MemoryStream ms = new MemoryStream(imgsource);
                    Session["imag"] = System.Drawing.Image.FromStream(ms);
                }
               //     Session["imag"] = System.Drawing.Image.FromFile(imageadd);
                //FileStream myFs = new FileStream(imageadd, FileMode.Open);
                
                 String xm = Session["xm"].ToString();
                 String sfzhstr = Session["sfzh"].ToString();
                String yx = Session["yx"].ToString();

                string procedureName = "selectApplication"; //存储过程名称
                SqlParameter[] sqlParameters = 
                    {
                        new SqlParameter("keyxm",xm), 
                        new SqlParameter("keysfzhstr",sfzhstr ),
                        new SqlParameter("keysqyxstr", yx),
                    };
                String strConnection = ConfigurationManager.ConnectionStrings["SQLServerConn"].ToString();
                SqlConnection con = new SqlConnection(strConnection);
                int result = 0;
                DataSet ds = new DataSet();
                try
                {
                    con.Open();
                    SqlCommand com = new SqlCommand(procedureName, con);
                    com.CommandType = CommandType.StoredProcedure;
                    com.Parameters.AddRange(sqlParameters);
                    SqlDataAdapter da = new SqlDataAdapter(com);
                    result = da.Fill(ds);
                }
                catch (Exception Error)
                {
                    throw Error;
                }
                finally
                {
                    con.Close();
                }
                if (result == 1)
                {
                    DataRow dr = ds.Tables[0].Rows[0];

                    sqlb.SelectedValue = dr[0].ToString().Trim();
                    DropDownList1.SelectedValue = dr[1].ToString().Trim();
                    ListItem it = new ListItem(dr[2].ToString().Trim(), dr[2].ToString().Trim());
                    DropDownList2.Items.Insert(0, it);
                    it = new ListItem("重新选择院系以刷新专业", "重新选择院系以刷新专业");
                    DropDownList2.Items.Insert(1, it);
                    txtzy.Value = dr[2].ToString().Trim();
                    tb_name.Text = dr[3].ToString().Trim();
                    rbl_xb.SelectedValue = dr[4].ToString().Trim() == "男" ? "1" : "2";
                    DropDownList3.SelectedValue = dr[5].ToString().Trim();
                    tb_csrq.Value = dr[6].ToString().Trim();
                    sfzh.Text = dr[7].ToString().Trim();
                    tb_yddh.Text = dr[8].ToString().Trim();
                    tb_dzyx.Text = dr[9].ToString().Trim();
                    tb_yzbm.Text = dr[10].ToString().Trim();
                    tb_txdz.Text = dr[11].ToString().Trim();
                    lblMessage.Text = "上传成功！";

                    xxxTextBox1.Text = dr[13].ToString().Trim();
                    tb_bkyx.Text = dr[14].ToString().Trim();
                    tb_bkzy.Text = dr[15].ToString().Trim();
                    Slider1.Value = dr[16].ToString().Trim();
                    Slider2.Value = dr[17].ToString().Trim();
                    tb_yysp.Text = dr[18].ToString().Trim();
                    tb_bkrs.Text = dr[19].ToString().Trim();
                    tb_njpm.Text = dr[20].ToString().Trim();
                    tb_hjqk.Text = dr[21].ToString().Trim();
                    Tb_kylw.Text = dr[22].ToString().Trim();
                    tb_grcs.Text = dr[23].ToString().Trim();
                    sqzt = dr[24].ToString().Trim(); 
                }
            }
            if (sqzt != "未审核" && sqzt != "院系审核不通过")
            {
                foreach (Control cr in Form1.Controls)
                {
                    DisableAllControl(cr);
                }
                tb_hjqk.Enabled = true;
                Tb_kylw.Enabled = true;
                tb_grcs.Enabled = true;
                tb_hjqk.ReadOnly = true;
                Tb_kylw.ReadOnly = true;
                tb_grcs.ReadOnly = true;
                //save.Enabled = true;
                //submit.Enabled = true;
            }
            if (sqzt =="等待确认")
                confirm.Enabled = true;
            else
                confirm.Enabled = false;
           
        }
       
        
    }

    protected void  DisableAllControl(Control c)
    {
        if (c is WebControl)
        {
            ((WebControl)c).Enabled = false;
        }
        if (c is HtmlControl)
        {
            ((HtmlControl)c).Disabled = true;
        }
        if (c.HasControls()&&c.Visible)DisableAllControl(c);
        
    } 


    protected void Button1_Click(object sender, EventArgs e)//bao cun
    {
        if (Page.IsValid && Session["imag"] != null && Session["imag"].ToString() != "" &&(sqzt == "未审核" || sqzt == "院系审核不通过"))
        {
            String sqlbstr = sqlb.SelectedValue;
            String sqyxstr = DropDownList1.SelectedValue;
            String sqgdzy = txtzy.Value;
            String xm = tb_name.Text.Trim();
            String xb = rbl_xb.SelectedValue == "1" ? "男" : "女";
            String mz = DropDownList3.SelectedValue;
            String czrq = tb_csrq.Value.Trim();
            String sfzhstr = sfzh.Text.Trim();
            String yddh = tb_yddh.Text.Trim();
            String dzyx = tb_dzyx.Text.Trim();
            String yzbm = tb_yzbm.Text.Trim();
            String txdz = tb_txdz.Text.Trim();
            String xpmc = sfzhstr + ".jpg";// Session["filenName"].ToString();
            String bkxx = xxxTextBox1.Text.Trim();
            String bkyx = tb_bkyx.Text.Trim();
            String bkzy = tb_bkzy.Text.Trim();
            String rxsj = Slider1.Value.Trim();
            String bysj = Slider2.Value.Trim();
            String yysp = tb_yysp.Text.Trim();
            String njrs = tb_bkrs.Text.Trim();
            String njpm = tb_njpm.Text;
            String hjqk = tb_hjqk.Text;
            String kylw = Tb_kylw.Text;
            String grcs = tb_grcs.Text;

            String photoadd = ConfigurationManager.ConnectionStrings["photoAddress"].ToString() + sfzhstr + ".jpg";
            
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

            string procedureName = "saveApplication"; //存储过程名称
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
            

            new SqlParameter("keyxm", Session["xm"].ToString()),
            new SqlParameter("keysfzhstr", Session["sfzh"].ToString()),
            new SqlParameter("keysqyxstr", Session["yx"].ToString())

             
            };

            String strConnection = ConfigurationManager.ConnectionStrings["SQLServerConn"].ToString();
            SqlConnection con = new SqlConnection(strConnection);
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
                Page.ClientScript.RegisterStartupScript(Page.GetType(), "", "<script language=javascript>alert('数据保存失败');window.location = 'applyinfo.aspx';</script>");
            else
            {
               
                Session["xm"] = xm;
                Session["sfzh"] = sfzhstr;
                Session["yx"] = sqyxstr;
                Page.ClientScript.RegisterStartupScript(Page.GetType(), "", "<script language=javascript>alert('数据保存成功');window.location = 'applyinfo.aspx';</script>");
            }
        }

    }

    protected void Button2_Click(object sender, EventArgs e)//ti jiao
    {
        if (Page.IsValid && Session["imag"] != null && Session["imag"].ToString() != "" &&(sqzt == "未审核" || sqzt == "院系审核不通过"))
        {
            String sqlbstr = sqlb.SelectedValue;
            String sqyxstr = DropDownList1.SelectedValue;
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
            String xpmc = sfzhstr + ".jpg";// Session["filenName"].ToString();
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

            String photoadd = ConfigurationManager.ConnectionStrings["photoAddress"].ToString() + sfzhstr + ".jpg";
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

            string procedureName = "submitApplication"; //存储过程名称
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
            

            new SqlParameter("keyxm", Session["xm"].ToString()),
            new SqlParameter("keysfzhstr", Session["sfzh"].ToString()),
            new SqlParameter("keysqyxstr", Session["yx"].ToString())
            };

            String strConnection = ConfigurationManager.ConnectionStrings["SQLServerConn"].ToString();
            SqlConnection con = new SqlConnection(strConnection);
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
                Page.ClientScript.RegisterStartupScript(Page.GetType(), "", "<script language=javascript>alert('数据提交失败');window.location = 'applyinfo.aspx'</script>");
            else
            {               
                Session["xm"] = xm;
                Session["sfzh"] = sfzhstr;
                Session["yx"] = sqyxstr;
                Page.ClientScript.RegisterStartupScript(Page.GetType(), "", "<script language=javascript>alert('数据提交成功');window.location = 'applyinfo.aspx'</script>");
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

    protected void Button3_Click(object sender, EventArgs e)
    {
        if (sqzt == "等待确认")
        {
            String strConnection = ConfigurationManager.ConnectionStrings["SQLServerConn"].ToString();
            SqlConnection con = new SqlConnection(strConnection);
            String name = Session["xm"].ToString().Trim();
            String id = Session["sfzh"].ToString().Trim();
            String yx = Session["yx"].ToString().Trim();

            String cmdstr = "Update [SummerCamp].[dbo].[学生申请表] set [申请状态] = '确认完成' where " +
                        " [姓名]='" + name + "' and [身份证号]='" + id + "' and [申请院系]= '" + yx + "'";
            SqlCommand cmd = con.CreateCommand();
            cmd.CommandText = cmdstr;
            con.Open();
            int result = cmd.ExecuteNonQuery();
            con.Close();

            if (result < 1)
                Page.ClientScript.RegisterStartupScript(Page.GetType(), "", "<script language=javascript>alert('确认资格失败');window.location = 'applyinfo.aspx'</script>");
            else
            {                
                Page.ClientScript.RegisterStartupScript(Page.GetType(), "", "<script language=javascript>alert('确认资格成功');window.location = 'applyinfo.aspx'</script>");
            }
        }
    }
}