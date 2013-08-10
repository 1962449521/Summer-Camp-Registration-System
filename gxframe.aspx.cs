using System;
using System.Collections.Generic;

using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.OleDb;
using System.Configuration;

public partial class gxframe : System.Web.UI.Page
{

    protected void Page_Load(object sender, EventArgs e)
    {
        #region 生成分页数据源objPds
        String provincename="";
        String keysr="";
//         String connectionString = "Provider=Microsoft.Jet.OleDb.4.0;Data Source=";
//         connectionString += @"K:\xly\app_data\Database111.mdb";
        String connectionString = ConfigurationManager.ConnectionStrings["AccessConn"].ToString();
        OleDbConnection con = new OleDbConnection(connectionString);
        DataSet ds = new DataSet();
        String str = "SELECT [universityname] FROM [高等院校表]";
        
        if (Request.QueryString["Province"] != null && Request.QueryString["Province"] !="")
        {
            provincename = Request.QueryString["Province"];
            str = str + " where provincename = '" + provincename + "'";
        }
        if (Request.QueryString["Key"] != null && Request.QueryString["Key"] != "")
        {
            keysr = Request.QueryString["Key"];
            if (provincename != "") str = str + " and universityname like '%" + keysr + "%'";
        }
            
        OleDbCommand command = con.CreateCommand();
        command.CommandText = str;
        OleDbDataAdapter dataadapter = new OleDbDataAdapter();
        dataadapter.SelectCommand = command;
        con.Open();
        int num = dataadapter.Fill(ds);
        con.Close();
        

          

        PagedDataSource objPds = new PagedDataSource();//实例化一个可翻页数据源
        objPds.DataSource = ds.Tables[0].DefaultView;//DefaultView是把这个表视图化变成视图，可变可不变。
        objPds.AllowPaging = true;//允许翻页
        objPds.PageSize = 36;//单页显示数为36项
        int CurPage; 
        #endregion

        //当前页面从Page查询参数获取  
        if (Request.QueryString["Page"] != null)   
            CurPage=Convert.ToInt32(Request.QueryString["Page"]);  
        else   
            CurPage=1;   
        objPds.CurrentPageIndex = CurPage-1;   
        lblCurrentPage.Text = "Page: " + CurPage.ToString(); 


        if (!objPds.IsFirstPage) 
            lnkPrev.NavigateUrl =
                Request.CurrentExecutionFilePath + "?Province=" + provincename + "&Key=" + keysr + "&Page=" + Convert.ToString(CurPage - 1); 
        if (!objPds.IsLastPage) 
            lnkNext.NavigateUrl =
                Request.CurrentExecutionFilePath + "?Province=" + provincename + "&Key=" + keysr + "&Page=" + Convert.ToString(CurPage + 1);
        //把PagedDataSource 对象赋给Repeater控件 
        DataList1.DataSource = objPds;
        DataList1.DataBind(); 

//         #region 根据Session["bt"]和Session["curpage"]实现公告区翻页
//         //Session["bt"]监视两个Linkbutton是上翻触发还是下翻触发，
//         //Session["curpage"]监视当前页的页码，两个变量共同提供参数实现页码定位
//         if (Session["bt"] != null && Session["bt"].ToString() == "up" && Convert.ToInt32(Session["curpage"]) != 0)
//             objPds.CurrentPageIndex = Convert.ToInt32(Session["curpage"]) - 1;//若上翻触发并当前页不是第0页，则实现翻页
//         else if (Session["bt"] != null && Session["bt"].ToString() == "down" && Convert.ToInt32(Session["curpage"]) < Math.Ceiling(tt1 / 4.0) - 1)
//             objPds.CurrentPageIndex = Convert.ToInt32(Session["curpage"]) + 1;//若下翻触发并当前页不是总最后一页
//         else
//         {
//             if (Session["curpage"] == null) objPds.CurrentPageIndex = 0;
//             else objPds.CurrentPageIndex = Convert.ToInt32(Session["curpage"]);
//         }
//         #endregion
//         #region 绑定数据源，复位session bt&curpage
//         lbltotal.Text = (Math.Ceiling(tt1 / 4.0)).ToString();//得到总页数，以每页4项为准  
//         lblcur.Text = (objPds.CurrentPageIndex + 1).ToString();
//         Session["curpage"] = objPds.CurrentPageIndex.ToString();
//         Session["bt"] = null;
// 
//         DataList_Download.DataSource = SqlDataSource_Download;
//         DataList_Download.DataBind();
//         GridView_MessageBoard.Attributes.Add("style", "word-break:break-all;word-wrap:break-word");
// 
//         DataList_SystemNews.DataSource = objPds;
//         DataList_SystemNews.DataBind();
        

    }

}