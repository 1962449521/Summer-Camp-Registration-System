<%@ Page Language="C#" AutoEventWireup="true" CodeFile="gxframe.aspx.cs" Inherits="gxframe" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta http-equiv="content-type" content="text/html; charset=gb2312" />
    <script type="text/javascript" src="jquery-1.4.2.min.js"></script>

    <style type="text/css">
        body{color:#333; font:normal 12px/22px "宋体",Verdana,Arial,Helvetica,sans-serif;}
     td,TD{padding:0;border:0; margin:0; height:24px;}
     .item{cursor:pointer;width:130px;float:left;display:inline; border:0;height:24px;line-height:21px;margin:0 ;overflow:hidden;}
    .DataList1{width: 450px; }
    .schlist{width:450px;padding:10px 0;height:280px;border-top:1px solid #0068a3;border-bottom:1px solid #0068a3;margin:0 auto;margin-bottom:10px;clear:both;}
    .txt { text-align:center;}
    </style>
    <script language="javascript" type="text/javascript">
        
        var a = function (b) {
            $('#xxxTextBox1', window.parent.document).attr('value', b);
            $('#tb_bkxx', window.parent.document).attr('value', b);
            $('#Panel1', window.parent.document).slideUp("slow");
        };
    </script>

</head>
<body>
    <form runat = "server">
    <div class="schlist" >
        
        <asp:DataList ID="DataList1" CssClass = "DataList1"  runat="server"  
            RepeatColumns="3">
        <ItemTemplate>
            
            <asp:Label CssClass ="item" ID="universitynameLabel" runat="server" 
                Text='<%# Eval("universityname") %>' BorderStyle="None" 
                 onclick = "
                 var b = $(this).html();
                 a(b);"
                
                />
            
        </ItemTemplate>
        </asp:DataList>
        <asp:AccessDataSource ID="AccessDataSource1" runat="server" 
            DataFile="~/app_data/Database111.mdb" 
            SelectCommand="SELECT [universityname] FROM [高等院校表]"></asp:AccessDataSource>
        
    </div>
    <div  style = "margin: 0 auto; width:500px; font-size: 12px;">
            <asp:HyperLink ID="lnkPrev" runat="server">上页</asp:HyperLink>            
            <asp:TextBox ID="lblCurrentPage"  runat="server" ReadOnly="True" Width="60px" 
                CssClass="txt"></asp:TextBox>
            <asp:HyperLink ID="lnkNext" runat="server">下页</asp:HyperLink>
        <input id="Button1" type="button" value="关闭该面板" style="margin-left: 5px" onclick="$('#Panel1', window.parent.document).slideUp('slow');"  />          
         </div>
    </form>
</body>
</html>
