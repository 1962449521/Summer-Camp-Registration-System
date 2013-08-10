using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.IO;
using System.Data.SqlClient;
using System.Data;
using System.Data.OleDb;

// public class info
// {
//     public String str0;
//     public String str1;
//     public String str2;
//     public String str3;
//     public String str4;
//     public String str5;
//     public String str6;
//     public String str7;
//     public String str8;
//     public String str9;
//     public String str10;
//     public String str11;
//     public String str12;
//     public String str13;
//     public String str14;
//     public String str15;
//     public String str16;
//     public String str17;
//     public String str18;
//     public String str19;
//     public String str20;
//     public String str21;
//     public String str22;
//     public String str23;
// }
public partial class admin_confirminfo : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (true)
        {
            String xm = "";
            if (Request.QueryString["xm"] != null && Request.QueryString["xm"].ToString().Trim() != "")
                xm = Request.QueryString["xm"].ToString().Trim();
            
            String id = "";
            if (Request.QueryString["id"] != null && Request.QueryString["id"].ToString().Trim() != "")
                id = Request.QueryString["id"].ToString().Trim();
            String yx="";//= Session["yx"]!=null?Session["yx"].ToString():"";
            
            if (Request.QueryString["yx"] != null && Request.QueryString["yx"].ToString().Trim() != "")
                yx = Request.QueryString["yx"].ToString().Trim();
            if (xm == "") return;///////////////////////////////////////
            Session["xm"] = xm; Session["id"] = id; Session["bkyx"]=yx;
            String imageadd = ConfigurationManager.ConnectionStrings["photoAddress"].ToString() + id + ".jpg";

            if (File.Exists(imageadd))
            {
                FileStream fs = new FileStream(imageadd, FileMode.Open, FileAccess.Read);
                byte[] imgsource = new byte[fs.Length];
                fs.Read(imgsource, 0, imgsource.Length);
                fs.Close();
                fs = null;
                MemoryStream ms = new MemoryStream(imgsource);
                Session["imag"] = System.Drawing.Image.FromStream(ms);
            }
            //     Session["imag"] = System.Drawing.Image.FromFile(imageadd);
           


            string procedureName = "selectApplication"; //存储过程名称
            SqlParameter[] sqlParameters = 
                    {
                        new SqlParameter("keyxm",xm), 
                        new SqlParameter("keysfzhstr",id ),
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
                info myinfo = new info();
                DataRow dr = ds.Tables[0].Rows[0];

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

                Session["shzt"] = dr[24].ToString().Trim();



                sqlb.Text = dr[0].ToString().Trim();
                sqyx.Text = dr[1].ToString().Trim();
                gdzy.Text = dr[2].ToString().Trim();
                lbxm.Text = dr[3].ToString().Trim();
                xb.Text = dr[4].ToString().Trim();
                mz.Text = dr[5].ToString().Trim();
                csrq.Text = dr[6].ToString().Trim();
                sfzh.Text = dr[7].ToString().Trim();
                sjhm.Text = dr[8].ToString().Trim();
                dzyx.Text = dr[9].ToString().Trim();
                txdz_yb.Text = dr[11].ToString().Trim() + "&nbsp;&nbsp;" + dr[10].ToString().Trim();
                rxsj.Text = dr[16].ToString().Trim();
                bysj.Text = dr[17].ToString().Trim();
                xxyx.Text = dr[13].ToString().Trim() + "&nbsp;&nbsp;" + dr[14].ToString().Trim();
                zy.Text = dr[15].ToString().Trim();
                yysp.Text = dr[18].ToString().Trim();
                njrs.Text = dr[19].ToString().Trim();
                njpm.Text = dr[20].ToString().Trim();
                hjqk.Text = dr[21].ToString().Trim().Replace("\r", "<br>").Replace(" ", "&nbsp;");

                kylw.Text = dr[22].ToString().Trim().Replace("\r", "<br>").Replace(" ", "&nbsp;");

                grcs.Text = dr[23].ToString().Trim().Replace("\r", "<br>").Replace(" ", "&nbsp;");


            
            String connectionString = ConfigurationManager.ConnectionStrings["AccessConn"].ToString();
            OleDbConnection con2 = new OleDbConnection(connectionString);
            //String sltcmdstr = "SELECT ACADEMICNAME from [培养单位表_武汉大学] ";
            String sltcmdstr = "SELECT if211,if985 from [高等院校表] where universityname='"
                     + dr[13].ToString().Trim() + "';";
            OleDbDataAdapter adp = new OleDbDataAdapter(sltcmdstr, con2);
            DataTable dt = new DataTable();
            con.Open();
            int resultnum = adp.Fill(dt);
            con.Close();
            String txt = "";
            if (resultnum>0&&dt.Rows[0][1] != null && dt.Rows[0][1].ToString().Trim() == "1")
                txt = "985";
            else if (resultnum > 0 && dt.Rows[0][0] != null && dt.Rows[0][0].ToString().Trim() == "1")
                txt = "211";
            else
                txt= "其它";
             myinfo.str21 = txt;
             bklb.Text = txt;
             Session["info"] = myinfo;
            }
        }
    }
}