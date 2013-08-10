<%@ WebHandler Language="C#" Class="Handler" %>

using System;
using System.Web;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.SessionState;

public class Handler : IHttpHandler, IReadOnlySessionState
{
    
    public void ProcessRequest (HttpContext context) {
        if (context.Session["yx"] != null && context.Session["yx"].ToString() != "")
        {
            String msg;
            String yx = context.Session["yx"].ToString().Trim();
            String what = context.Request.Params["what"];
            String cmdstr = "update SummerCamp.dbo.[培养单位用户] set [ifopen]=(case ifopen when '1' then   '0' else	'1' end) where ACADEMICNAME='" + yx + "';";
            

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
                msg=what+"失败";
            else
                msg = what+"成功"; 
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