<%@ WebHandler Language="C#" Class="sh" %>

using System;
using System.Web;
using System.Web.Services;
using System.Web.SessionState;
using System.Data.SqlClient;
using System.Configuration;

public class sh : IHttpHandler, IReadOnlySessionState
{

    public void ProcessRequest(HttpContext context)
    {
        String shjg = context.Request.Params["shjg"];
        String btgly = context.Request.Params["btgly"];
        String msg = "";

        String shzt = context.Session["shzt"] == null ? "" : context.Session["shzt"].ToString().Trim();
        if (shzt == "")
        {
            msg = "请先选择需审核的学生"; context.Response.ContentType = "text/plain";
            context.Response.Write(msg); return;
        }
        
        if (context.Session["yx"] != null && context.Session["yx"].ToString() != ""
            && context.Session["bkyx"] != null && context.Session["bkyx"].ToString() != ""
            && context.Session["xm"] != null && context.Session["xm"].ToString() != ""
            && context.Session["id"] != null && context.Session["id"].ToString() != ""
            )
        {
            String yx = context.Session["yx"].ToString().Trim();
            String bkyx = context.Session["bkyx"].ToString().Trim();
            String xm = context.Session["xm"].ToString().Trim();
            String id = context.Session["id"].ToString().Trim();
            String cmdstr="" ;
            if (yx == "研究生院")
            {
               if(shjg=="院系审核不通过")
                   shjg="研究生院审核不通过";                
                else if(shjg=="研究生院审核中")
                   shjg="等待确认";

            }

            if (yx == "研究生院" && shzt != "研究生院审核中")
            {
                msg = "审核状态：" + shzt + ";你没有修改该审核状态的权限"; context.Response.ContentType = "text/plain";
                context.Response.Write(msg); return;
            }
            if (yx != "" && yx != "研究生院" && shzt != "院系审核中")
            {
                msg = "审核状态：" + shzt + ";你没有修改该审核状态的权限"; context.Response.ContentType = "text/plain";
                context.Response.Write(msg); return;
            }
            
             cmdstr = "update SummerCamp.dbo.[学生申请表] set [申请状态] = '" + shjg +
                "',[不通过原因]='" + btgly + 
                "' where [姓名]='"+xm+
                "' and [申请院系]='"+bkyx
                +"' and [身份证号]='"+id+"'";
           


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
                msg = "审核失败";
            else
                msg = "审核成功";
            context.Response.ContentType = "text/plain";
            context.Response.Write(msg);

        }

    }



    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}