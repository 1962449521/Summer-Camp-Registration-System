<%@ WebHandler Language="C#" Class="Handler" %>

using System;
using System.Data;
using System.Web;
using System.Web.Services;
using System.Text;
using System.Data.OleDb;
using System.Configuration;

[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
public class Handler : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        String xy = context.Request.Params["xy"];

        //String connectionString = "Provider=Microsoft.Jet.OleDb.4.0;Data Source=";
        //connectionString += @"F:\xly\WebSite2\app_data\Database111.mdb";
        String connectionString = ConfigurationManager.ConnectionStrings["AccessConn"].ToString();
        OleDbConnection con = new OleDbConnection(connectionString);
        //String sltcmdstr = "SELECT ACADEMICNAME from [培养单位表_武汉大学] ";
        String sltcmdstr = "SELECT subjectname from [专业表_武汉大学] a,[培养单位表_武汉大学] b where b.ACADEMICNAME='"
                 + xy + "' and b.ACADEMICID=a.academicid;";
        OleDbDataAdapter adp = new OleDbDataAdapter(sltcmdstr, con);
        DataTable dt = new DataTable();
        con.Open();
        adp.Fill(dt);
        con.Close();
        StringBuilder sb = new StringBuilder();
        sb.Append("<select id=\"DropDownList2\" class =\"xselect\" runat=\"Server\" onclick = \"$('#txtzy').attr('value',this.options[this.selectedIndex].value)\"><option value = \"请选择专业\">请选择专业");

        foreach (DataRow row in dt.Rows)
        {

            sb.Append("<option value=\"");
            sb.Append(row["subjectname"].ToString());
            sb.Append("\">");
            sb.Append(row["subjectname"].ToString());
            sb.Append("</option>");
        }


        sb.Append("</select>");
        
        
        
        
             
        context.Response.ContentType = "text/plain";
        context.Response.Write(sb);
        
        
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}