<%@ WebHandler Language="C#" Class="Handler" %>

using System;
using System.Web;
using System.Drawing;
using System.Drawing.Imaging;
using System.Web.SessionState;

public class Handler : IHttpHandler,IRequiresSessionState {
    
    public void ProcessRequest (HttpContext context) {
        //context.Response.ContentType = "text/plain";
        //context.Response.Write("Hello World");
        Bitmap NewBmp = new Bitmap(36,16,PixelFormat.Format32bppArgb);
        Graphics g = Graphics.FromImage(NewBmp);
        g.FillRectangle(new SolidBrush(Color.White),new Rectangle(0,0,36,20));
        Font textFont = new Font("GB2312", 10);
        Rectangle rectangle = new Rectangle(0,0,36,20);
        string ThisNum = Convert.ToString(GetNum());
        context.Session["CheckNum"] = ThisNum;
        g.FillRectangle(new SolidBrush(Color.BurlyWood),rectangle);
        g.DrawString(ThisNum,textFont,new SolidBrush(Color.Blue),rectangle);
        NewBmp.Save(context.Response.OutputStream,ImageFormat.Jpeg); 
    }
    public bool IsReusable {
        get {
            return false;
        }
    }
    public int GetNum() {
        int GiveNum;
        Random MyNum = new Random();
        GiveNum = MyNum.Next(8999) + 1000;
        return GiveNum;
    }
}