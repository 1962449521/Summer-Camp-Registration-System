<%@ Page Language="C#" AutoEventWireup="true" CodeFile="verify.aspx.cs" Inherits="admin_verify" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
    body{color:#333; font:normal 12px/22px "宋体",Verdana,Arial,Helvetica,sans-serif;}        
    #biggest{min-width:1000px; position:absolute; left:50%; margin-left:-500px;}
    #left{float:left; width:200px; background:#c1e4df; text-align:center;}
    #right{float:left;width:800px;  padding:0;}
    .button{font:normal 12px/22px "宋体",Verdana,Arial,Helvetica,sans-serif;
             width:100px;display:block;margin-top: 10px; margin-bottom: 10px;
             padding:0px 2px 0px 2px;  height:30px;}
    #rightbottom{position: fixed; bottom:3px; right:15px; z-index:10000;}
    #leftbottom{position: fixed; bottom:3px; left:15px; z-index:10000;width:120px;}
    
    .pay_list_con{margin-left:0px;float:left; width:100%; padding-left:0px;  border-bottom:2px solid #C2DDA7; padding-bottom:0px; margin-bottom:0px;}
    .pay_list_con li{ border-left: 1px solid #C2DDA7;
            border-right: 1px solid #C2DDA7;
            border-top: 1px solid #C2DDA7;
            float:left; background-color:#F4F4F4;line-height:26px;overflow-Y:hidden; position:relative;top:5px;white-space:nowrap;
            border-bottom-style: none;
            border-bottom-color: inherit;
            border-bottom-width: medium;
            margin-left: 2px;
            margin-right: 2px;
            margin-top: auto;
        }
    *html .pay_list_con li{top:3px;}
    .pay_list_con .focus{  height:28px; border:2px solid #C2DDA7;border-bottom:none;position:relative; top:2px; z-index:2; color:#009900; font-weight:bold; background:url(ico_btn.gif) no-repeat center bottom; background-color:#FFFFFF;}
    .pay_list_con li a{color:#666666; display:block;min-width:30px;width:auto !important;*!width:30px; padding:0 5px; height:24px; text-decoration:none;}
    .hidebutton{ position:fixed; top:-100px;}
    #sh{position: fixed; left:50%; top:50%; margin-left:-300px; margin-top:-205px; z-index:10000;}
    .cell_xm{width:45px; text-align:center;}
    .cell_sqyx{text-align:center; width:53px; text-align:left;}
    .cell_sfzh{width:96px; text-align:center;}
    .ctable{width:196px; font-size:10px; }
    .crow{height:20px;}
    
    .pay_list_con2{margin-left:0px;float:left; width:100%; padding-left:0px;  border-bottom:2px solid #C2DDA7; padding-bottom:0px; margin-bottom:0px;}
    .pay_list_con2 li{ border-left: 1px solid #C2DDA7;
            border-right: 1px solid #C2DDA7;
            border-top: 1px solid #C2DDA7;
            float:left; background-color:#F4F4F4;line-height:26px;overflow-Y:hidden; position:relative;top:5px;white-space:nowrap;
            border-bottom-style: none;
            border-bottom-color: inherit;
            border-bottom-width: medium;
            margin-left: 2px;
            margin-right: 2px;
            margin-top: auto;
        }
     *html .pay_list_con2 li{top:3px;}
    .pay_list_con2 .focus{  height:28px; border:2px solid #C2DDA7;border-bottom:none;position:relative; top:2px; z-index:2; color:#009900; font-weight:bold; background:url(ico_btn.gif) no-repeat center bottom; background-color:#FFFFFF;}
    .pay_list_con2 li a{color:#666666; display:block;min-width:30px;width:auto !important;*!width:30px; padding:0 5px; height:24px; text-decoration:none;}
    
    </style>  
    <script type="text/javascript">
        var $$ = function (id) { return "string" == typeof id ? document.getElementById(id) : id; };

        var close22 = function () {
            var what = "";
            what = $$("Button4").value;
            $.ajax({
                type: "POST",
                url: "Handler.ashx",
                data: { "what": what },
                contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                beforeSend: function () { },
                success: function (msg) {
                    if ($("#Button4").attr("value") == "关闭报名") {
                        $("#Button4").attr("value", "开放报名"); /////////////////////////////////
                    }
                    else $("#Button4").attr("value", "关闭报名");

                    alert(msg);

                },
                error: function () { alert("网络繁忙，请稍后再试。"); },
                complete: function () { }
            });

        };
        var xgmm = function () {
            var a = $.trim($("#xmm").attr("value"));
            var b = $.trim($("#xmmqr").attr("value"));
            if (a == "" || b == "" || a != b) {
                alert("新密码未输入、未确认，或两次输入不相等");
            }
            else {
                var reg = /^[\w]{6,12}$/;
                if (!a.match(reg))
                { alert("密码为6-12位数字/字母/下划线!"); }
                else {
                    $.ajax({
                        type: "POST",
                        url: "xgmm.ashx",
                        data: { "xmm": a },
                        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                        beforeSend: function () { },
                        success: function (msg) {
                            alert(msg);
                        },
                        error: function () { alert("网络繁忙，请稍后再试。"); },
                        complete: function () { }
                    });
                }
            }
            $("#xmm").attr("value", "");
            $("#xmmqr").attr("value", "");
            $("#xgmmdiv").slideUp();

        };

        var tjshjg = function () {

            var list = $("#rbl_sh input");
            var shjg = "";
            var c1 = list[0].checked;
            var c2 = list[1].checked;
            if (list[1].checked) shjg = "院系审核不通过";
            else if (list[0].checked) shjg = "研究生院审核中";
            var btgly = $.trim($$("ly").value);
            if (shjg == "") alert("请选择通过或不通过");
            else if (c2 && btgly == "") alert("请填写不通过理由");
            else {
                $.ajax({
                    type: "POST",
                    url: "sh.ashx",
                    data: { "shjg": shjg, "btgly": btgly },
                    contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                    beforeSend: function () { },
                    success: function (msg) {
                        if (c1) {
                            $$('li_2').click();
                           
                    }
                        else if (c2) {
                            $$('li_3').click();
                            
                       } 
                        alert(msg);

                    },
                    error: function () { alert("网络繁忙，请稍后再试。"); },
                    complete: function () { }
                });
                
                $('#sh').slideUp();

            }

        };
    </script>
    <script src="../jquery-1.4.2.min.js" type="text/javascript"> </script>  
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>

    <div id = "xgmmdiv"
        style="
        border: 2px solid #0099FF; 
        width: 600px; 
        background-color: #FFFFFF;
        padding-left:5px;
        height:30px;
        padding-top:3px;
        display:none;
        position:fixed; 
        left:50%;
        margin-left:-300px;
        bottom:10px;
        z-index:1000;
        
        "
    >
    新密码：<input id="xmm" type="password"  style = "width:153px; height:20px" runat="Server"/>
    新密码确认：<input id="xmmqr" type="password" style = "width:153px; height:20px" />
        <input id="Button5" type="button" value="确认修改" onclick ="xgmm();"  />
        <a href = "javascript:void(0) " onclick = "$('#xgmmdiv').slideUp();">关闭面板</a>
    </div>


    <div id = "sh" style="
        border: 2px solid #0099FF; 
        width: 610px; 
        background-color: #FFFFFF;
        padding-left:5px;
        height:430px;
        padding-top:3px;
        display:none;
        "><div style = "position:absolute; height:430px;width: 610px; ">
        <asp:RadioButtonList ID="rbl_sh" runat="server"  
                          RepeatDirection="Horizontal"  RepeatLayout="Flow">
                        <asp:ListItem Value="1"  Text="审核通过" onclick = "document.getElementById('ly').value = '';document.getElementById('ly').disabled = true; "></asp:ListItem> 
                        <asp:ListItem Value="2"   Text="审核不通过" onclick = "document.getElementById('ly').disabled = false; "></asp:ListItem>                         
                      </asp:RadioButtonList>
           <hr />
           审核不通过的理由说明：<br />
        <asp:TextBox ID="ly" runat="server" TextMode="MultiLine" Width="580px" Height="300px"></asp:TextBox>
        <br />
        <script type="text/javascript">
       document.getElementById('ly').disabled = true;
        </script>
         <input id="Button6" type="button" value="提交审核结果" style = "margin-left:260px; display:inline;" class="button" onclick ="tjshjg();"  />
            
        <span onclick = "$('#sh').slideUp()" style="cursor: pointer">关闭该面板</span> 
        </div>        
    </div>
    

    <div id = "leftbottom" align="center">
        <div style="border-bottom-style: solid; border-bottom-width: 1px; border-bottom-color: #006699">当前：
        <asp:Label ID="lb" runat="server" Text="待审核" Width="62px"></asp:Label>
        </div>       
        <div  style="border-bottom-style: solid; border-bottom-width: 1px; border-bottom-color: #006699">985：211：其他<br />
         
         <asp:UpdatePanel ID="UpdatePanel1" runat="server" 
      ChildrenAsTriggers="False" RenderMode="Inline" 
      UpdateMode="Conditional"><ContentTemplate>
         <asp:Label ID="ratio" runat="server" Text="50:50:50"></asp:Label>
         </ContentTemplate>
          <Triggers>
              <asp:AsyncPostBackTrigger ControlID="wsh" />
              <asp:AsyncPostBackTrigger ControlID="shbtg" />
              <asp:AsyncPostBackTrigger ControlID="shtg" />
          </Triggers>
        </asp:UpdatePanel> 
        </div> 
        <asp:Button ID="Button1"  Text="导出EXCEL"  runat = "server"  CssClass="button" 
            onclick="Button1_Click" />
        
        <input id="Button4"   type="button"  value="关闭报名"  class="button" onclick ="close22();" runat="Server"/>        
        <input id="Button3"   type="button"  value="修改用户密码"  class="button" onclick ="$('#xgmmdiv').slideDown();" />
            
        <asp:Button ID="zx"  Text="注销用户"  runat = "server"  CssClass="button" 
            onclick="zx_Click" />
            <hr />
              <asp:Button ID="cexiao" runat="server" Text="撤消审核结果" CssClass="button" 
            onclick="cexiao_Click" />
             <asp:UpdatePanel ID="UpdatePanel2" runat="server" 
      ChildrenAsTriggers="False" RenderMode="Inline" 
      UpdateMode="Conditional"><ContentTemplate>
         <input  id = "confirm" type="button" value="审核该条" onclick  = "$('#sh').slideDown()" class= "button"  runat="Server"/>
         </ContentTemplate>
          <Triggers>
              <asp:AsyncPostBackTrigger ControlID="wsh" />
              <asp:AsyncPostBackTrigger ControlID="shbtg" />
              <asp:AsyncPostBackTrigger ControlID="shtg" />
          </Triggers>
        </asp:UpdatePanel> 

        
             <input  id = "print" type="button" value="直接打印"  class= "button" onclick="return print_onclick()" /> 
        <input  id = "backtotop" type="button" value="回到顶部" 
        onclick  = "$('html,body').animate({scrollTop: '0px'}, 800);" class= "button" />
        
    </div>
     <asp:Button ID="wsh" runat="server" Text="Button" onclick="Button3_Click" CssClass = "hidebutton" />
     <asp:Button ID="shbtg" runat="server" Text="Button" onclick="shbtg_Click" CssClass = "hidebutton"/>
     <asp:Button ID="shtg" runat="server" Text="Button" onclick="shtg_Click"  CssClass = "hidebutton"/>
    
  
    <div id = "biggest">
    <div id = "left" >
        <asp:Image ID="Image1" runat="server"  width = "196px" height = "196px"  ImageUrl="yx.jpg" BorderColor="White" BorderStyle="Solid" BorderWidth="2" />        
        <asp:Label   width = "196px" style="margin: 0px 0px 5px 0px; line-height: 20px; height: 20px; background-color: #000000; color: #FFFFFF" align="center"
         ID="yydw" runat="server" Text=""></asp:Label>
   
   <script type="text/javascript">
        function check(obj) {
            $(".pay_list_con li").attr("class", "");
            $(obj).attr("class", "focus");
        
        }
        function xmcz() {
            var key = $$("ckkey").value;

            $("#DataList1>tbody>tr").each(function () {
                
                if (($(this).html()).indexOf(key) == -1)
                    $(this).remove();


            });
            
        }
   </script>
        列表信息包含（切换栏目更新）：<input id="ckkey" type="text" /><input id="Button2" type="button" value="筛选" onclick="xmcz();" />
             <ul class="pay_list_con">
        	    <li id="li_1"  class="focus" onclick = "check(this);$$('wsh').click();$('#lb').html('待审核')"><a href="javascript:void(0); ">待审核</a></li>
                <li id="li_2"  onclick = "check(this);$$('shtg').click();$('#lb').html('审核通过')"><a href="javascript:void(0);" >审核通过</a></li>
			    <li id="li_3"  onclick = "check(this);$$('shbtg').click();$('#lb').html('审核不通过')"><a href="javascript:void(0);" >审核不通过</a></li>  
            	</ul>
    <div style="clear:both;background-color: #FFFFFF; width: 196px; min-height:200px;height:420px; overflow-y:scroll; overflow-x:hidden; border:2px solid #C2DDA7;border-top:none;">
    
      <asp:UpdatePanel runat="server" 
      ChildrenAsTriggers="False" RenderMode="Inline" 
      UpdateMode="Conditional"><ContentTemplate>
     <asp:DataList ID="DataList1" CssClass = "DataList1"  runat="server" 
            DataSourceID="SqlDataSource1" >
            <ItemTemplate>
                  <div id="rcd1"  style = "border-bottom:1px dashed  gray; cursor:pointer; "
                                        onmouseover = "this.style.backgroundColor = '#fda9c3'" 
                                        onmouseout =  "this.style.backgroundColor = ''"
                                        onclick = "$$('win').src='confirminfo.aspx?xm=<%# Eval("[姓名]") %>&id=<%# Eval("[身份证号]") %>&yx=<%# Eval("[申请院系]") %>'; "
                                        title = "<%# Eval("[申请院系]") %>">
                             <asp:Table ID="Table5"   CssClass = "  ctable" runat="server"  >

                                <asp:TableRow  CssClass = " crow "  >
                                    <asp:TableCell   CssClass = " cell_xm"> 
                                            <asp:Label runat="server" id="lb_name" 
                                                            Text=<%# Eval("[姓名]") %> />
                                    </asp:TableCell><asp:TableCell   CssClass = " cell_sfzh">
                                        <asp:Label runat="server" id="lb_id" 
                                                            Text=<%# Eval("[身份证号]") %> />                                    
                                   </asp:TableCell><asp:TableCell  CssClass = " cell_sqyx">
                                       <asp:Label runat="server" id="lb_yx2" 
                                                            Text= <%# ((String)DataBinder.Eval(Container.DataItem, "[申请院系]")).Substring(0, 3) %> />
                                       <asp:Label ID="lb_yx" style="width:0px;height:0px;margin:0px;padding:0px;display:block;overflow:hidden;" runat="server" Text=<%# Eval("[申请院系]") %>></asp:Label>
                                    <!-- <%# ((String)DataBinder.Eval(Container.DataItem, "[申请院系]")).Substring(0, 3) +".." %> --></asp:TableCell></asp:TableRow></asp:Table></div></ItemTemplate></asp:DataList></ContentTemplate><Triggers>
              <asp:AsyncPostBackTrigger ControlID="wsh" />
              <asp:AsyncPostBackTrigger ControlID="shbtg" />
              <asp:AsyncPostBackTrigger ControlID="shtg" />
          </Triggers>
        </asp:UpdatePanel> 
        </div>

        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:SQLServerConn %>" 
            ProviderName="System.Data.SqlClient" 
            ></asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
            ConnectionString="<%$ ConnectionStrings:SQLServerConn %>" 
            ProviderName="System.Data.SqlClient" 
            ></asp:SqlDataSource>
         <asp:SqlDataSource ID="SqlDataSource3" runat="server" 
            ConnectionString="<%$ ConnectionStrings:SQLServerConn %>" 
            ProviderName="System.Data.SqlClient" 
            ></asp:SqlDataSource>



<asp:Panel ID="Panel1" runat="server">
<asp:Label   width = "196px" style="margin: 0px 0px 5px 0px; line-height: 20px; height: 20px; background-color: #000000; color: #FFFFFF" align="center"
         ID="Label1" runat="server" Text="院系审核情况"></asp:Label><script type="text/javascript">
                  function check2(obj) {
                      $(".pay_list_con2 li").attr("class", "");
                      $(obj).attr("class", "focus");

                  }

   </script>选择院系 <asp:DropDownList ID="DropDownList1" runat="server" 
                          DataSourceID="AccessDataSource1" DataTextField="ACADEMICNAME" 
                          DataValueField="ACADEMICNAME"                            
                          AutoPostBack="false" Width="180px">
                      </asp:DropDownList>
                      <asp:AccessDataSource ID="AccessDataSource1" runat="server" 
            DataFile="~/app_data/Database111.mdb" 
            SelectCommand="SELECT * FROM pydwb2 order by ACADEMICID"></asp:AccessDataSource>
    <br />
    
        
       
    选择状态类别 <select id="Select1"   style="width: 180px" runat="Server">
            <option>未审核</option>
            <option>院系审核中</option>
            <option>院系审核不通过</option>
        </select> <br /><asp:Button ID="yxck" runat="server" onclick="yxck_Click"
        Text="查    看"  style = "margin-top:10px;margin-bottom:10px;"/>
        <br />985-211-其他： <asp:UpdatePanel ID="UpdatePanel5" runat="server" 
      ChildrenAsTriggers="False" RenderMode="Inline" 
      UpdateMode="Conditional">
       <ContentTemplate>
    
         <asp:Label ID="ratio2" runat="server" Text=""></asp:Label></ContentTemplate><Triggers>
              <asp:AsyncPostBackTrigger ControlID="yxck" />              
          </Triggers>
        </asp:UpdatePanel> 
       

    <div style="clear:both;background-color: #FFFFFF; width: 196px; min-height:200px;height:420px; overflow-y:scroll; overflow-x:hidden; border:2px solid #C2DDA7;border-top:none;">
    
      <asp:UpdatePanel ID="UpdatePanel4" runat="server" 
      ChildrenAsTriggers="False" RenderMode="Inline" 
      UpdateMode="Conditional"><ContentTemplate>
     <asp:DataList ID="DataList2" CssClass = "DataList1"  runat="server" 
            DataSourceID="SqlDataSource12" >
            <ItemTemplate>
                  <div id="rcd2"  style = "border-bottom:1px dashed  gray; cursor:pointer; "
                                        onmouseover = "this.style.backgroundColor = '#fda9c3'" 
                                        onmouseout =  "this.style.backgroundColor = ''"
                                        onclick = "$$('win').src='confirminfo.aspx?xm=<%# Eval("[姓名]") %>&id=<%# Eval("[身份证号]") %>&yx=<%# Eval("[申请院系]") %>'; "
                                        title = "<%# Eval("[申请院系]") %>">
                             <asp:Table ID="Table5"   CssClass = "  ctable" runat="server"  >

                                <asp:TableRow  CssClass = " crow "  >
                                    <asp:TableCell   CssClass = " cell_xm"> 
                                            <asp:Label runat="server" id="lb_name" 
                                                            Text=<%# Eval("[姓名]") %> />
                                    </asp:TableCell><asp:TableCell   CssClass = " cell_sfzh">
                                        <asp:Label runat="server" id="lb_id" 
                                                            Text=<%# Eval("[身份证号]") %> />                                    
                                   </asp:TableCell><asp:TableCell  CssClass = " cell_sqyx">
                                        <asp:Label runat="server" id="lb_yx2" 
                                                            Text= <%# ((String)DataBinder.Eval(Container.DataItem, "[申请院系]")).Substring(0, 3) %> />
                                       <asp:Label ID="lb_yx" style="width:0px;height:0px;margin:0px;padding:0px;display:block;overflow:hidden;" runat="server" Text=<%# Eval("[申请院系]") %>></asp:Label>
                                    <!-- <%# ((String)DataBinder.Eval(Container.DataItem, "[申请院系]")).Substring(0, 3) +".." %> --></asp:TableCell></asp:TableRow></asp:Table></div></ItemTemplate></asp:DataList></ContentTemplate><Triggers>
              <asp:AsyncPostBackTrigger ControlID="yxck" />              
          </Triggers>
        </asp:UpdatePanel> 
       
         <asp:SqlDataSource ID="SqlDataSource12" runat="server" 
            ConnectionString="<%$ ConnectionStrings:SQLServerConn %>" 
            ProviderName="System.Data.SqlClient" 
            ></asp:SqlDataSource>
        </div>
         </asp:Panel>
    </div>



    


    <script type="text/javascript">
            function setheight(obj) {
                var win = obj;
                if (document.getElementById) {
                    if (win && !window.opera) {
                        if (win.contentDocument && win.contentDocument.body.offsetHeight) {
                            win.height = win.contentDocument.body.offsetHeight;
                        }
                        else if (win.Document && win.Document.body.scrollHeight) {
                        win.height = win.Document.body.scrollHeight;
                        }
                    }
                }
            }
            function print_onclick() {
                 if (window.frames['win'] == null) {
                   
                    document.getElementById('win').focus();
                    document.getElementById('win').contentWindow.print();
                 }
               else {
                     
                   if (document.all) { //IE 
                       win.document.execCommand('print');
                   } else {
                       document.getElementById('win').focus();
                       document.getElementById('win').contentWindow.print();
//                        document.frames("win").window.focus();
//                       window.print();
                    }
                   
                 }
            }

        </script>
    <div id = "right">

    <asp:UpdatePanel ID="UpdatePanel3" runat="server" 
      ChildrenAsTriggers="False" RenderMode="Inline" 
      UpdateMode="Conditional"><ContentTemplate>
          <iframe  width = "800px" scrolling="no" frameborder="0" style = "padding:0;margin:0; background:White"
             id = "win" name = "win"  runat="server"></iframe>
         </ContentTemplate>
          <Triggers>
              <asp:AsyncPostBackTrigger ControlID="wsh" />
              <asp:AsyncPostBackTrigger ControlID="shbtg" />
              <asp:AsyncPostBackTrigger ControlID="shtg" />
          </Triggers>
        </asp:UpdatePanel> 
       
        
    </div>
    </div>
    </form>
</body>
</html>
