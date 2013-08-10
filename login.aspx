<%@ Page Language="C#" AutoEventWireup="true" CodeFile="login.aspx.cs" Inherits="login" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>武汉大学优秀大学生夏令营</title>
    <script type="text/javascript" src="jquery-1.4.2.min.js"></script>
    <script type="text/javascript">    
  
     //屏幕最大化
        window.moveTo(0, 0);
        if (document.all) {
            top.window.resizeTo(screen.availWidth, screen.availHeight);
        }
        else if (document.layers || document.getElementById) {
            if (top.window.outerHeight < screen.availHeight || top.window.outerWidth < screen.availWidth) {
                top.window.outerHeight = screen.availHeight;
                top.window.outerWidth = screen.availWidth;
            }
        } </script>
    <style type="text/css">
        body{ text-align:center;background:  white url('img/body_bg.gif') repeat;font-family: "宋体","黑体";
              font-size:14px;	text-decoration: none;}
        #biggestcontainer{height:700px; width:1000px; position:absolute; top:50%; left:50%; margin:-350px 0 0 -500px;
                          background: url(img/xlyloginbg2.jpg);border:4px solid #c9f5f4;}
        #login{position:absolute;top:619px;left:379px;height:61px; width:227px; background:url(img/bta1.jpg);cursor:pointer;}
       
        #name,#id,#yx,#valid{position:absolute; top:578px; }
        #name{left:110px;} #name,#txt_name{width:75px;}
        #id{left:292px;} #id,#txt_id{width:130px;}
        #yx{left:520px; margin:0; padding:0; text-align:left;width:254px; top:578px;}
        #valid{left:820px;width:98px;top:576px;}
        .ainput{ border: 0px;border-bottom:solid 1px #3a75c1;background: white;  }
        #reg{position:absolute; left:620px; top:638px; cursor:pointer;}
        #validators{position:absolute; bottom:10px; left:10px;}
        #notice{position:absolute; left:65px; top:610px;text-align:left;font-weight:bold;}
        
    </style>
</head>
<body>
   <form id="form1" runat="server"> 
    <div id = "biggestcontainer" >
        <div id = "name"  >
        <input id ="txt_name"  runat = "server" tabindex = "1"  class= "ainput" 
        name="txt_userName" type= "text"/>
        
        </div>
        <div id = "id">
        <input id ="txt_id" tabindex = "2"  class= "ainput" name="txt_id" type= "text" runat = "server"/>
        
        
        </div>
        <div id = "yx">
            <asp:DropDownList ID="DropDownList1" runat="server"  TabIndex="3" 
                          DataSourceID="AccessDataSource1" DataTextField="ACADEMICNAME" 
                          DataValueField="ACADEMICNAME" 
                          CssClass="ainput" Width="200px">
                      </asp:DropDownList>
            
            <asp:AccessDataSource ID="AccessDataSource1" runat="server" 
            DataFile="~/app_data/Database111.mdb" 
            SelectCommand="SELECT [ACADEMICNAME] FROM [培养单位表_武汉大学]"></asp:AccessDataSource>   
        </div>
        <div id = "valid">
            <input id ="txt_valid" tabindex = "4"  class= "ainput" name="txt_valid" type="text" style="width: 40px" runat = "server"/>
        
            <img id="img_valid" src="validGen.ashx" title="看不清？点击更换图片" style = "cursor:pointer"alt = ""/></div>
            <script type="text/javascript">
                $("#img_valid").click(function () {//刷新验证图片
                    this.src = "validGen.ashx?time=" + new Date();
                });
            </script>        
       <div id = "notice" style="color: #FF0000">
         重要提示：注册之前，请仔细阅读武汉大学研究<br />
         生院官方网站上发布的夏令营报名系统开通公告<br />
         (<a href="http://gs.whu.edu.cn/newscenter/readnews.asp?NewsID=6455">http://gs.whu.edu.cn/newscenter/readne<br />ws.asp?NewsID=6455</a>)，不要向未参与本次夏令<br />
         营活动的院系提交申请。
       </div>
        <div id = "login" tabindex = "5"></div>
        <div id = "reg" tabindex = "6" style="color: #796363">还未注册？请点这里</div>
        <div id = "validators">
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="姓名未填" ControlToValidate="txt_name"></asp:RequiredFieldValidator>
        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="姓名只能是简体中文" ValidationExpression="^[\u4E00-\u9FA5]{1,8}$" ControlToValidate="txt_name"></asp:RegularExpressionValidator>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="身份证号未填" ControlToValidate="txt_id"></asp:RequiredFieldValidator>
        <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ErrorMessage="身份证格式不正确" ValidationExpression="\d{17}[\d|X|x]" ControlToValidate="txt_id"></asp:RegularExpressionValidator>
        <span style="width: 380px; display: inline-block;"></span>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="验证码未填" ControlToValidate="txt_valid"></asp:RequiredFieldValidator>

        </div>
    </div></form>
    <script type="text/javascript">
        $("#login").hover(
            function () {
                $(this).css({ background: "url(img/bta2.jpg)" })
            },
            function () {
                $(this).css({ background: "url(img/bta1.jpg)" })
            });
        $("#reg").hover(
            function () {
                $(this).css({ color: "red" })
            },
         function () {
             $(this).css({ color: "#796363" })
         });
         $("#login").bind("click",
           function () {
               form1.submit();
           }
       );
            $("#reg").bind("click", 
           function () {
              window.open("register.aspx","_self");
            }
       );
    </script>
    
</body>
</html>
