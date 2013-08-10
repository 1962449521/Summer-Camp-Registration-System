<%@ WebHandler Language="C#" Class="ftu" %>

using System;
using System.Web;
using System.Web.SessionState;
using System.IO;
using System.Text;

public class ftu : IHttpHandler, System.Web.SessionState.IRequiresSessionState 
{

    public void ProcessRequest(HttpContext context)
    {
        context.Response.Clear();
        //context.Response.ContentType = "text/plain";
        context.Response.ContentType = "text/html";//这里一定要html
        HttpFileCollection postedFile = context.Request.Files;
        string rtmsg="{\"status\" : \"error\",\"msg\": \"相片不符合要求！\"}";
        try
        {
            if (postedFile != null && postedFile.Count > 0)
            {


                //文件格式判别
                int seat = postedFile[0].FileName.LastIndexOf(".");
                String extension = postedFile[0].FileName.Substring(seat).ToLower();
                String[] allowed = { ".jpg" };//, ".gif", ".png", ".bmp", ".jpeg", ".txt", ".doc", ".xls", ".rar", ".zip" };
                int checktype = 0;
                for (int i = 0; i < allowed.Length; i++)
                {
                    if (!(allowed[i] != extension))
                    { checktype = 1; break; }

                }

                //判断文件真实内容//判断文件大小
                if (checktype == 1 //文件格式判别
                    && (postedFile[0].ContentType.Contains("jpg")
                        || postedFile[0].ContentType.Contains("gif")
                        || postedFile[0].ContentType.Contains("png")
                        || postedFile[0].ContentType.Contains("jpeg"))
                     && (postedFile[0].ContentLength <= 1024 * 1024))
                //判断文件尺寸
                {
                    System.Drawing.Image img = 
                        System.Drawing.Image.FromStream(postedFile[0].InputStream);
                    int height = img.Height;
                    int width = img.Width;
                    
                    if (height == 160 && width == 120)
                    {

                        rtmsg = "{\"status\" : \"success\",\"msg\": \"上传成功！\"}";                        
                        context.Session["imag"] = img.Clone();  
                           System.IO.Stream MyStream;   
                           // Initialize the stream.
                           MyStream = postedFile[0].InputStream; 
                           context.Session["stream"] = MyStream;// Encoding.ASCII.GetString(input); 
                       img.Dispose();////////////////////////////////////////////////////////////
                    }
                }
            }
            context.Response.Write(rtmsg);
        }


        catch (Exception ex)
        {
            context.Response.Write("{\"status\" : \"error\",\"msg\": \"" + ex.Message + "\"}");
        }
        finally
        {
           //postedFile[0].InputStream.Close();/////////////////////////
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

 

