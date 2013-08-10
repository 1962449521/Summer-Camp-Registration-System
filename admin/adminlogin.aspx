<%@ Page Language="C#" AutoEventWireup="true" CodeFile="adminlogin.aspx.cs" Inherits="admin_adminlogin" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
    #DropDownList1{ margin-top:15px; margin-left:5px;}
     body{color:#333; font:normal 12px/22px "宋体",Verdana,Arial,Helvetica,sans-serif;}
     
    </style>
</head>
<body style="background-image: url('body_bg4.gif'); background-repeat: repeat">
    <form id="form1" runat="server">
    <div id = "biggest" style="border: 4px solid #FFFFFF; background-position: center center; width: 1000px; height: 700px; position:absolute; top:50%; left:50%; margin-left:-500px; margin-top:-350px; background-image: url('loginbg.jpg');">
    <div id = "center" style="background-color: #FFFFFF;  width: 1000px; height: 50px;position:absolute; top:304px; left:50%; margin-left:-500px; ">
     <span style = "margin-left:100px;">培养单位名称：</span>
     <asp:DropDownList ID="DropDownList1" runat="server"  TabIndex="3"  
                          DataSourceID="SqlDataSource1" DataTextField="ACADEMICNAME" 
                          DataValueField="ACADEMICNAME" 
                           Width="200px">
                      </asp:DropDownList>
            
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:SQLServerConn %>" 
            ProviderName="System.Data.SqlClient" 
            SelectCommand="SELECT [ACADEMICNAME] FROM [培养单位用户]"></asp:SqlDataSource>
    
        <span style = "margin-left:50px;">密码：</span>
        <asp:TextBox ID="psw" runat="server" TextMode="Password"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="" ControlToValidate = "psw"></asp:RequiredFieldValidator>
        <span style = "font-size:10px;" >初始密码“888888”</span>
        <asp:Button ID="Button1" runat="server" style = "margin-left:50px;" 
            Text="登    录" onclick="Button1_Click" />
    </div>
    </div>
    </form>
</body>
</html>
