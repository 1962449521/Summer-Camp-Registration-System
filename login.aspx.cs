using System;
using System.Collections.Generic;

using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using System.Web.Security;

public partial class login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Page.IsPostBack) 
        {
            Page.Validate();
            if(Page.IsValid)
            {
            String name = txt_name.Value;
            String id = txt_id.Value;
            String yx = DropDownList1.SelectedValue;
            String yz = txt_valid.Value;
            if(Session["CheckNum"]==null ||yz != Session["CheckNum"].ToString())
            {
                Page.ClientScript.RegisterStartupScript
                    (Page.GetType(), "",
                    "<script language=javascript>alert('验证码输入错误')</script>");	
            }
            else
            {
                String strConnection = ConfigurationManager.ConnectionStrings["SQLServerConn"].ToString();
                SqlConnection con = new SqlConnection(strConnection);
                int result = 0;

                string procedureName = "adminValid"; //存储过程名称

                SqlParameter[] sqlParameters = 
                {
                    new SqlParameter("name",name), 
                    new SqlParameter("id",id ),
                    new SqlParameter("yx", yx),        
                };

                try
                {
                    con.Open();
                    SqlCommand com = new SqlCommand(procedureName, con);
                    com.CommandType = CommandType.StoredProcedure;
                    com.Parameters.AddRange(sqlParameters);
                    //result = com.ExecuteNonQuery();
                    result = Convert.ToInt32(com.ExecuteScalar());
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
                Page.ClientScript.RegisterStartupScript(Page.GetType(), "", "<script language=javascript>alert('登录失败，请核实信息')</script>");		
	                else
                {
                   
                        Session["xm"] = name;
                        Session["sfzh"] = id;
                        Session["yx"] = yx;
                        Response.Redirect("user/applyinfo.aspx");
                   
                    }	
                }
            }
        }       
    }
}
        
 