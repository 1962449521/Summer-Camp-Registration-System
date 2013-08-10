<%@ WebHandler Language="C#" Class="xgmm" %>

using System;
using System.Web;
using System.Web.Services;
using System.Web.SessionState;
using System.Data.SqlClient;
using System.Configuration;

public class xgmm : IHttpHandler, IReadOnlySessionState
{
    
    public void ProcessRequest (HttpContext context) {
        String xmm = context.Request.Params["xmm"];
        String msg="";

        if (context.Session["yx"] != null && context.Session["yx"].ToString() != "")
        {
            String yx = context.Session["yx"].ToString();

            String cmdstr = "update SummerCamp.dbo.[培养单位用户] set psw = '"+xmm+"' where ACADEMICNAME='" + yx + "';";
            

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
                msg="密码修改失败";
            else
                msg = "密码修改成功"; 
            context.Response.ContentType = "text/plain";
            context.Response.Write(msg);
        
        };
            
        }     
     
   
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}