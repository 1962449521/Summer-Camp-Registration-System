<%@ Page Language="C#" AutoEventWireup="true" CodeFile="confirminfo.aspx.cs" Inherits="admin_confirminfo" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script type="text/javascript" src="../jquery-1.4.2.min.js"></script>
    <style type="text/css">
        body{color:#333; font:normal 12px/22px "宋体",Verdana,Arial,Helvetica,sans-serif;}        
        #outer{width:780px;}
        span{color:balck; font-weight:bold;}
        tr,td{text-align:center;}
       
        
    </style>
</head>
<body>
    <div id = "outer">
    <table width="100%"  border="0" cellpadding="0" cellspacing="0" bgcolor="#E1E1E1">
        
        <tr style = "background-position: left center; height: 40px; background-image: url('xszl.jpg'); background-repeat: no-repeat;">
        <td style ="border:0"></td></tr>

        <tr><td style ="border:0" >
        <table width="100%" style="border:1px solid black" cellpadding="0" cellspacing="0">
    	<tr bgcolor="#fffffff" style="height: 37px">
            <td style="border-right:1px solid black">985/211/其它</td>
            <td style="border-right:1px solid black"><asp:Label id = "bklb" runat="Server" Text = ""></asp:Label></td>
    		<td style="border-right:1px solid black">申请类别</td>
            <td style="border-right:1px solid black"><asp:Label id = "sqlb" runat="Server" Text = ""></asp:Label></td>
            <td style="border-right:1px solid black">申请院系</td>
            <td style="border-right:1px solid black"><asp:Label id = "sqyx" runat="Server" Text = ""></asp:Label></td>
            <td style="border-right:1px solid black">申请攻读专业</td>
            <td><asp:Label  id = "gdzy" runat="Server" Text = ""></asp:Label></td>
    	</tr>
        </table></td></tr>

        <tr style = "height: 3px"><td style ="border:0"></td></tr>

         <tr><td style ="border:0">
         <table style="border:1px solid black" width="100%" border="0" cellpadding="0" cellspacing="0">
    	<tr bgcolor="#f7f7f7" >
            <td style="border-right:1px solid black;border-bottom:1px solid black" >姓名</td>
            <td style="border-right:1px solid black;border-bottom:1px solid black"><asp:Label id = "lbxm" runat="Server" Text = ""></asp:Label></td>
           <td style="border-right:1px solid black;border-bottom:1px solid black">性别</td>
            <td style="border-right:1px solid black;border-bottom:1px solid black"><asp:Label id = "xb" runat="Server" Text = ""></asp:Label></td>
            <td style="border-right:1px solid black;border-bottom:1px solid black">民族</td>
            <td style="border-right:1px solid black;border-bottom:1px solid black"><asp:Label id = "mz" runat="Server" Text = ""></asp:Label></td>
            <td style="border-right:1px solid black;border-bottom:1px solid black">出生日期</td>
            <td style="border-right:1px solid black;border-bottom:1px solid black"><asp:Label id = "csrq" runat="Server" Text = ""></asp:Label></td>
            <td  rowspan = "4" height="160px" width="120px">            
            <img id="Image1" Height="160" Width="120" runat="server" alt = "学生照片" />
            <script type="text/javascript">
                $("#Image1").attr("src", "../imageshow.aspx?date=" + new Date()); 
            </script>
    </td> 
        
        </tr>
        <tr bgcolor="#f7f7f7" >
            <td  colspan = "2" rowspan = "2" style="border-right:1px solid black;border-bottom:1px solid black">身份证号</td>
            <td  colspan = "2" rowspan = "2" style="border-right:1px solid black;border-bottom:1px solid black">
                <asp:Label id = "sfzh" runat="Server" Text = ""></asp:Label></td>
            <td colspan = "2" style="border-right:1px solid black;border-bottom:1px solid black">手机号码</td>
            <td colspan = "2" style="border-right:1px solid black;border-bottom:1px solid black"><asp:Label id = "sjhm" runat="Server" Text = ""></asp:Label></td>
          </tr>
        <tr bgcolor="#f7f7f7" >
            <td colspan = "2" style="border-right:1px solid black;border-bottom:1px solid black">电子邮箱</td>
            <td colspan = "2" style="border-right:1px solid black;border-bottom:1px solid black"><asp:Label id = "dzyx" runat="Server" Text = ""></asp:Label></td>
        </tr>
        <tr bgcolor="#f7f7f7" >
            <td colspan = "2" style="border-right:1px solid black;">通讯地址及邮编</td>
            <td colspan = "6" style="border-right:1px solid black;"><asp:Label id = "txdz_yb" runat="Server" Text = ""></asp:Label></td>
        </tr>
        </table></td></tr>

        <tr style = "height: 3px"><td></td></tr>

        <tr><td><table width="100%" border="0" cellpadding="0" cellspacing="0">
    	<tr bgcolor="#ffffff" style="height: 37px" >
            <td style="border-right:1px solid black;border-bottom:1px solid black;border-top:1px solid black;border-left:1px solid black">入学时间</td>
            <td style="border-right:1px solid black;border-bottom:1px solid black;border-top:1px solid black"><asp:Label id = "rxsj" runat="Server" Text = ""></asp:Label></td>
           <td style="border-right:1px solid black;border-bottom:1px solid black;border-top:1px solid black">毕业时间</td>
            <td style="border-right:1px solid black;border-bottom:1px solid black;border-top:1px solid black"><asp:Label id = "bysj" runat="Server" Text = ""></asp:Label></td>
          </tr>
          <tr bgcolor="#ffffff" style="height: 37px" >
            <td style="border-right:1px solid black;border-bottom:1px solid black;border-left:1px solid black">所在学校、院系</td>
            <td style="border-right:1px solid black;border-bottom:1px solid black"><asp:Label id = "xxyx" runat="Server" Text = ""></asp:Label></td>
           <td style="border-right:1px solid black;border-bottom:1px solid black">专&nbsp;&nbsp;&nbsp;&nbsp;业</td>
            <td style="border-right:1px solid black;border-bottom:1px solid black"><asp:Label id = "zy" runat="Server" Text = ""></asp:Label></td>
          </tr>
          <tr bgcolor="#ffffff" style="height: 37px" >
            <td style="border-right:1px solid black;border-bottom:1px solid black;border-left:1px solid black">英语水平</td>
            <td colspan = "3" style="border-right:1px solid black;border-bottom:1px solid black"><asp:Label id = "yysp" runat="Server" Text = ""></asp:Label></td>
            </tr>
        </table></td></tr>

        <tr><td><table width="100%" border="0" cellpadding="0" cellspacing="0">
    	<tr bgcolor="#f7f7f7" style="height: 37px">
            <td style="border-right:1px solid black;border-bottom:1px solid black;border-left:1px solid black">本科专业同年级人数</td>
            <td style="border-right:1px solid black;border-bottom:1px solid black;"><asp:Label id = "njrs" runat="Server" Text = ""></asp:Label></td>
          <td style="border-right:1px solid black;border-bottom:1px solid black;">前五学期总评成绩在所学本科专业同年级的排名</td>
            <td style="border-right:1px solid black;border-bottom:1px solid black;"><asp:Label id = "njpm" runat="Server" Text = ""></asp:Label></td>
        </tr>
        </table></td></tr>

        <tr style = "height: 3px"><td></td></tr>

         <tr><td><table width="100%" border="0" cellpadding="0" cellspacing="0">
    	<tr bgcolor="#ffffff"  >
            <td  style="padding: 10px; text-align: left;border:1px solid black;">
                <div style="margin-left: 300px">
                    校级以上获奖情况</div>
                <asp:Label id = "hjqk" runat="Server" Text = "<br /><br /><br /><br /><br /><br /><br /><br />" /></td>
            </td>
         </td></tr>        
        </table></td></tr>

        <tr style = "height: 3px"><td></td></tr>

        <tr><td><table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr bgcolor="#f7f7f7" >
            <td style="padding: 10px; text-align: left;border:1px solid black;">
            <div style="margin-left:300px; " >参加科研工作、发表论文等情况</div>
            
            <asp:Label id = "kylw" runat="Server" Text = "<br /><br /><br /><br /><br /><br /><br /><br />" /></td>
       
            </td>
        </tr></table></td></tr>

        <tr style = "height: 3px"><td></td></tr>

        <tr><td><table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr bgcolor="#ffffff"  >
            <td  style="padding: 10px; text-align: left;border:1px solid black;">
            <div style="margin-left:330px">个人陈述</div>
            
            <asp:Label id = "grcs" runat="Server" Text = "<br /><br /><br /><br /><br /><br /><br /><br />" /></td>
       
            </td>
        </tr></table></td></tr>


        <tr><td><table width="100%" border="0" cellpadding="0" cellspacing="0">
    	<tr bgcolor="#ffffff" >
            <td></td>
        </tr>
        </table></td></tr>
    </table>
    
        </div>

       

    
</body>
</html>
