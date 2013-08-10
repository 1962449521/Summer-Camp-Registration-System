using System;
using System.Collections.Generic;

using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using System.Web.Security;

public partial class admin_adminlogin : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        

    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        if ( Page.IsValid)
        {

            String yx = DropDownList1.SelectedValue.Trim();
            String mm = psw.Text.Trim();
            String strConnection = ConfigurationManager.ConnectionStrings["SQLServerConn"].ToString();
            SqlConnection con = new SqlConnection(strConnection);
            int result = 0;

            String cmdstr = "SELECT Count(*)  FROM [SummerCamp].[dbo].[培养单位用户] where " +
                " [ACADEMICNAME]='" + yx + "' and [psw]='" + mm + "'";
            SqlCommand cmd = con.CreateCommand();
            cmd.CommandText = cmdstr;
            con.Open();
            result = Convert.ToInt32(cmd.ExecuteScalar());
            con.Close();
            if (result < 1)
                Page.ClientScript.RegisterStartupScript(Page.GetType(), "", "<script language=javascript>alert('登录失败，请核实信息')</script>");
            else
            {
                Session["yx"] = yx;
                Session["bkyx"] = yx;
                Response.Redirect("verify.aspx");
            }

        }
    }
}