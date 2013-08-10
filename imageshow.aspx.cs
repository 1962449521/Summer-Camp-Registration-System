using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Drawing.Imaging;

public partial class imageshow : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["imag"] != null && Session["imag"].ToString() != "")
        {
            System.Drawing.Image curphoto = (System.Drawing.Image)Session["imag"];
            curphoto.Save(Response.OutputStream, ImageFormat.Jpeg);
        }

    }
}