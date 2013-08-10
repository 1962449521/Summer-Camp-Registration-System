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
using Microsoft.Office.Interop.Word;

public partial class applyinfo : System.Web.UI.Page
{
    protected string sqzt="";
    protected  string btgyy = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        sqzt = Session["cursqzt"] == null ? "" : Session["cursqzt"].ToString();
        btgyy = Session["curbtgyy"] == null ? "" : Session["curbtgyy"].ToString();
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
                    Session["cursqzt"]=sqzt = dr[24].ToString().Trim();
                    Session["curbtgyy"]=btgyy = (dr[25]!=null?(dr[25].ToString().Trim()):"");


                    info myinfo = new info();      
                    myinfo.str0 = dr[0].ToString().Trim();
                    myinfo.str1 = dr[1].ToString().Trim();
                    myinfo.str2 = dr[2].ToString().Trim();
                    myinfo.str3 = dr[3].ToString().Trim();
                    myinfo.str4 = dr[4].ToString().Trim();
                    myinfo.str5 = dr[5].ToString().Trim();
                    myinfo.str6 = dr[6].ToString().Trim();
                    myinfo.str7 = dr[7].ToString().Trim();
                    myinfo.str8 = dr[8].ToString().Trim();
                    myinfo.str9 = dr[9].ToString().Trim();
                    myinfo.str10 = dr[11].ToString().Trim() + "    " + dr[10].ToString().Trim();
                    myinfo.str11 = dr[16].ToString().Trim();
                    myinfo.str12 = dr[17].ToString().Trim();
                    myinfo.str13 = dr[13].ToString().Trim() + "    " + dr[14].ToString().Trim();
                    myinfo.str14 = dr[15].ToString().Trim();
                    myinfo.str15 = dr[18].ToString().Trim();
                    myinfo.str16 = dr[19].ToString().Trim();
                    myinfo.str17 = dr[20].ToString().Trim();
                    myinfo.str18 = dr[21].ToString().Trim();
                    myinfo.str19 = dr[22].ToString().Trim();
                    myinfo.str20 = dr[23].ToString().Trim();


                    Session["info"] = myinfo;
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

                export.Enabled = true;
                explainalert.Enabled = true;
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
            String sqyxstr = DropDownList1.SelectedValue.ToString().Trim();
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

    protected void export_Click(object sender, EventArgs e)
    {
        info cur = new info();

        if (Session["info"] != null && Session["info"].ToString() != "")
        {
            cur = (info)Session["info"];

            ExWordValue exWordValue = new ExWordValue();
            List<string> strMarks = new List<string>();
            strMarks.Add("sqlb2");
            strMarks.Add("sqxy2");
            strMarks.Add("xm2");
            strMarks.Add("gdzy2");
            
            strMarks.Add("bkpm");
            strMarks.Add("bkrs");
            strMarks.Add("bysj");
            strMarks.Add("csrq");
            strMarks.Add("dzyx");
            strMarks.Add("gdzy");
            strMarks.Add("grcs");
            strMarks.Add("hjqk");
            strMarks.Add("kyqk");
            strMarks.Add("mz");
            strMarks.Add("rxsj");
            strMarks.Add("sfzh");
            strMarks.Add("sjhm");
            strMarks.Add("sqlb");
            strMarks.Add("sqxy");
            strMarks.Add("txdz");
            strMarks.Add("xb");
            strMarks.Add("xm");
            strMarks.Add("xxyx");
            strMarks.Add("yysp");
            strMarks.Add("zy");

            exWordValue.ItemValue = strMarks;
            AgentInfoEntity agentInfoEntity = new AgentInfoEntity();

            
            agentInfoEntity.Bkpm = cur.str17;
            agentInfoEntity.Bkrs = cur.str16;
            agentInfoEntity.Bysj = cur.str12;
            agentInfoEntity.Csrq = cur.str6;
            agentInfoEntity.Dzyx = cur.str9;
            agentInfoEntity.Gdzy = cur.str2;
            agentInfoEntity.Grcs = cur.str20;
            agentInfoEntity.Hjqk = cur.str18;
            agentInfoEntity.Kyqk = cur.str19;
            agentInfoEntity.Mz = cur.str5;
            agentInfoEntity.Rxsj = cur.str11;
            agentInfoEntity.Sfzh = cur.str7;
            agentInfoEntity.Sjhm = cur.str8;
            agentInfoEntity.Sqlb = cur.str0;
            agentInfoEntity.Sqxy = cur.str1;
            agentInfoEntity.Txdz = cur.str10;
            agentInfoEntity.Xb = cur.str4;
            agentInfoEntity.Xm = cur.str3;
            agentInfoEntity.Xxyx = cur.str13;
            agentInfoEntity.Yysp = cur.str15;
            agentInfoEntity.Zy = cur.str14;

            agentInfoEntity.Sqlb2 = agentInfoEntity.Sqlb;
            agentInfoEntity.Sqxy2 = agentInfoEntity.Sqxy;
            agentInfoEntity.Xm2 = agentInfoEntity.Xm;
            agentInfoEntity.Gdzy2 = agentInfoEntity.Gdzy;

            ExportWordForTemplete("2013a.doc", agentInfoEntity.Sfzh + ".doc", exWordValue, agentInfoEntity, agentInfoEntity.Sfzh);
        }
    }

    public class AgentInfoEntity
    {
        /// <summary>
        /// 标题
        /// </summary>
        private string sqlb2;

        public string Sqlb2
        {
            get { return sqlb2; }
            set { sqlb2 = value; }
        }
        private string sqxy2;

        public string Sqxy2
        {
            get { return sqxy2; }
            set { sqxy2 = value; }
        }
        private string xm2;

        public string Xm2
        {
            get { return xm2; }
            set { xm2 = value; }
        }
        private string gdzy2;

        public string Gdzy2
        {
            get { return gdzy2; }
            set { gdzy2 = value; }
        }
        
        private string bkpm;

        public string Bkpm
        {
            get { return bkpm; }
            set { bkpm = value; }
        }
        private string bkrs;

        public string Bkrs
        {
            get { return bkrs; }
            set { bkrs = value; }
        }
        private string bysj;

        public string Bysj
        {
            get { return bysj; }
            set { bysj = value; }
        }
        private string csrq;

        public string Csrq
        {
            get { return csrq; }
            set { csrq = value; }
        }
        private string dzyx;

        public string Dzyx
        {
            get { return dzyx; }
            set { dzyx = value; }
        }
        private string gdzy;

        public string Gdzy
        {
            get { return gdzy; }
            set { gdzy = value; }
        }
        private string grcs;

        public string Grcs
        {
            get { return grcs; }
            set { grcs = value; }
        }
        private string hjqk;

        public string Hjqk
        {
            get { return hjqk; }
            set { hjqk = value; }
        }
        private string kyqk;

        public string Kyqk
        {
            get { return kyqk; }
            set { kyqk = value; }
        }
        private string mz;

        public string Mz
        {
            get { return mz; }
            set { mz = value; }
        }
        private string rxsj;

        public string Rxsj
        {
            get { return rxsj; }
            set { rxsj = value; }
        }
        private string sfzh;

        public string Sfzh
        {
            get { return sfzh; }
            set { sfzh = value; }
        }
        private string sjhm;

        public string Sjhm
        {
            get { return sjhm; }
            set { sjhm = value; }
        }
        private string sqlb;

        public string Sqlb
        {
            get { return sqlb; }
            set { sqlb = value; }
        }
        private string sqxy;

        public string Sqxy
        {
            get { return sqxy; }
            set { sqxy = value; }
        }
        private string txdz;

        public string Txdz
        {
            get { return txdz; }
            set { txdz = value; }
        }
        private string xb;

        public string Xb
        {
            get { return xb; }
            set { xb = value; }
        }
        private string xm;

        public string Xm
        {
            get { return xm; }
            set { xm = value; }
        }
        private string xxyx;

        public string Xxyx
        {
            get { return xxyx; }
            set { xxyx = value; }
        }
        private string yysp;

        public string Yysp
        {
            get { return yysp; }
            set { yysp = value; }
        }
        private string zy;

        public string Zy
        {
            get { return zy; }
            set { zy = value; }
        }



       
    }

    public class ExWordValue
    {
        /// <summary>
        /// 书签集合
        /// </summary>
        private List<string> itemValue;

        public List<string> ItemValue
        {
            get { return itemValue; }
            set { itemValue = value; }
        }
    }


    /// <summary>
    /// 替换内容并导出
    /// </summary>
    /// <param name="templetePathandName">模板路径</param>
    /// <param name="saasPathandFile">保存路径</param>
    /// <param name="eword">书签类</param>
    /// <param name="agentinfo">数据实体类</param>
    /// <returns></returns>
    public void ExportWordForTemplete(string templetePathandName, string saasPathandFile, ExWordValue eword, AgentInfoEntity agentinfo, String id)
    {
        //生成WORD程序对象和WORD文档对象 
        string p_TemplatePath = templetePathandName; //例如"/templete.doc";
        string p_SavePath = saasPathandFile;
        Application appWord = new Application();
        Document doc = new Document();



        object oMissing = System.Reflection.Missing.Value;//这是一个疑问

        //打开模板文档，并指定doc的文档类型 
        object filename = "";
        try
        {
            object objTemplate = Server.MapPath(p_TemplatePath);
            object objDocType = WdDocumentType.wdTypeDocument;
            object objFalse = false, objTrue = true;
            doc = (Document)appWord.Documents.Add(ref objTemplate, ref objFalse, ref objDocType, ref objTrue);
            //获取模板中所有的书签 
            Bookmarks odf = doc.Bookmarks;
            //循环所有的书签，并给书签赋值 
            for (int oIndex = 0; oIndex < eword.ItemValue.Count; oIndex++)
            {
                object obDD_Name = eword.ItemValue[oIndex];
                doc.Bookmarks.get_Item(ref obDD_Name).Range.Text = getProperties(agentinfo, (string)obDD_Name);
                //p_TestReportTable.Rows[0][testTablevalues[oIndex]].ToString();//此处Range也是WORD中很重要的一个对象，就是当前操作参数所在的区域 
            }
            object bm = "tplr";
            doc.Bookmarks.get_Item(ref bm).Select();
            String imageadd = ConfigurationManager.ConnectionStrings["photoAddress"].ToString() + id + ".jpg";
            appWord.Selection.InlineShapes.AddPicture(imageadd,
                ref oMissing, ref oMissing, ref oMissing);

            // 生成word，将当前的文档对象另存为指定的路径，然后关闭doc对象。关闭应用程序 
            filename = Server.MapPath(saasPathandFile);
            object miss = System.Reflection.Missing.Value;
            doc.SaveAs(ref filename, ref miss, ref miss, ref miss, ref miss, ref miss, ref miss, ref miss, ref miss, ref miss, ref miss, ref miss, ref miss, ref miss, ref miss, ref miss);
            object missingValue = Type.Missing;
            object doNotSaveChanges = WdSaveOptions.wdDoNotSaveChanges;
            doc.Close(ref doNotSaveChanges, ref missingValue, ref missingValue);
            appWord.Application.Quit(ref miss, ref miss, ref miss);
            doc = null;
            appWord = null;

        }
        catch (System.Threading.ThreadAbortException ex)
        {
            object miss = System.Reflection.Missing.Value;
            object missingValue = Type.Missing;
            object doNotSaveChanges = WdSaveOptions.wdDoNotSaveChanges;
            doc.Close(ref doNotSaveChanges, ref missingValue, ref missingValue);
            appWord.Application.Quit(ref miss, ref miss, ref miss);
        }

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

    /// <summary>
    /// 根据实体取得属性的值。
    /// </summary>
    /// <param name="ainfo"></param>
    /// <param name="key"></param>
    /// <returns></returns>
    public string getProperties(AgentInfoEntity ainfo, string key)
    {
        string tStr = string.Empty;
        if (ainfo == null)
        {
            return tStr;
        }
        System.Reflection.PropertyInfo[] properties = ainfo.GetType().GetProperties(System.Reflection.BindingFlags.Instance | System.Reflection.BindingFlags.Public);

        if (properties.Length <= 0)
        {
            return tStr;
        }
        foreach (System.Reflection.PropertyInfo item in properties)
        {
            string name = item.Name;
            object value = item.GetValue(ainfo, null);
            if (item.PropertyType.IsValueType || item.PropertyType.Name.StartsWith("String"))
            {
                //tStr += string.Format("{0}:{1},", name, value);
                if (name.ToLower() == key)
                {
                    tStr = (string)value;
                    break;
                }
            }
        }
        return tStr;
    }


}