<%@ Page Language="C#" AutoEventWireup="true" CodeFile="applyinfo.aspx.cs" Inherits="applyinfo" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>武汉大学优秀大学生夏令营</title>

<script src="../jquery-1.4.2.min.js" type="text/javascript"> </script>  
<script type="text/javascript" src="../jquery.ajaxfileupload.js"></script>


<script type="text/javascript">
    var $$ = function (id) { return "string" == typeof id ? document.getElementById(id) : id; };
    //文件上传ajax
    function upload() {
        //        debugger;
        $.ajaxFileUpload(
        {
            url: '../ftu.ashx',
            secureuri: false,
            fileElementId: 'fup', //上传控件ID  
            dataType: 'json',
            success: function (data, status) {

                if (data.status == "success") {
                    $("#lblMessage").css("color", "black");
                    $("#lblMessage").html(data.msg);
                    $("#Image1").attr("src", "../imageshow.aspx?date=" + new Date());
                }
                else {
                    $("#lblMessage").css("color", "red");
                    $("#lblMessage").html(data.msg);
                }
            },
            error: function (data, status, e) {
                alert(e);   //就是在这弹出“语法错误”  
            }
        });
    }

    //dropdownlist AJAX
    var gettt = function (xy) {
        var xxy = $.trim(xy);
        $.ajax({
            type: "POST",
            url: "../Handler.ashx",
            data: { "xy": xxy },
            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
            beforeSend: function () { },
            success: function (msg) {
                $("#zy").html(msg);

            },
            error: function () { alert("网络繁忙，请稍后再试。"); },
            complete: function () { }
        });
    };
    //日历
    var gMonths = new Array("一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "十一月", "十二月");
    var WeekDay = new Array("日", "一", "二", "三", "四", "五", "六");
    var strToday = "今天";
    var strYear = "年";
    var strMonth = "月";
    var strDay = "日";
    var splitChar = "";
    var startYear = 1980;
    var endYear = 2016;
    var dayTdHeight = 12;
    var dayTdTextSize = 12;
    var gcNotCurMonth = "#E0E0E0";
    var gcRestDay = "#FF0000";
    var gcWorkDay = "#444444";
    var gcMouseOver = "#79D0FF";
    var gcMouseOut = "#F4F4F4";
    var gcToday = "#444444";
    var gcTodayMouseOver = "#6699FF";
    var gcTodayMouseOut = "#79D0FF";
    var gdCtrl = new Object();
    var goSelectTag = new Array();
    var gdCurDate = new Date();
    var giYear = gdCurDate.getFullYear();
    var giMonth = gdCurDate.getMonth() + 1;
    var giDay = gdCurDate.getDate();
    function monster() { var elements = new Array(); for (var i = 0; i < arguments.length; i++) { var element = arguments[i]; if (typeof (arguments[i]) == 'string') { element = document.getElementById(arguments[i]); } if (arguments.length == 1) { return element; } elements.Push(element); } return elements; }
    Array.prototype.Push = function () { var startLength = this.length; for (var i = 0; i < arguments.length; i++) { this[startLength + i] = arguments[i]; } return this.length; }
    String.prototype.HexToDec = function () { return parseInt(this, 16); }
    String.prototype.cleanBlank = function () { return this.isEmpty() ? "" : this.replace(/\s/g, ""); }
    function checkColor() { var color_tmp = (arguments[0] + "").replace(/\s/g, "").toUpperCase(); var model_tmp1 = arguments[1].toUpperCase(); var model_tmp2 = "rgb(" + arguments[1].substring(1, 3).HexToDec() + "," + arguments[1].substring(1, 3).HexToDec() + "," + arguments[1].substring(5).HexToDec() + ")"; model_tmp2 = model_tmp2.toUpperCase(); if (color_tmp == model_tmp1 || color_tmp == model_tmp2) { return true; } return false; }
    function monsterV() { return monster(arguments[0]).value; }
    function fPopCalendar(evt, popCtrl, dateCtrl, startyear, endyear) {
        this.startYear = startyear || 1980;
        this.endYear = endyear || 2016; evt.cancelBubble = true; gdCtrl = dateCtrl; fSetYearMon(giYear, giMonth); var point = fGetXY(popCtrl); with (monster("calendardiv").style) { left = point.x + "px"; top = (point.y + popCtrl.offsetHeight + 1) + "px"; visibility = 'visible'; zindex = '99'; position = 'absolute'; } monster("calendardiv").focus();
    }
    function fSetDate(iYear, iMonth, iDay) { var iMonthNew = new String(iMonth); var iDayNew = new String(iDay); if (iMonthNew.length < 2) { iMonthNew = "0" + iMonthNew; } if (iDayNew.length < 2) { iDayNew = "0" + iDayNew; } gdCtrl.value = iYear + splitChar + iMonthNew + splitChar + iDayNew; fHideCalendar(); }
    function fHideCalendar() { monster("calendardiv").style.visibility = "hidden"; for (var i = 0; i < goSelectTag.length; i++) { goSelectTag[i].style.visibility = "visible"; } goSelectTag.length = 0; }
    function fSetSelected() { var iOffset = 0; var iYear = parseInt(monster("tbSelYear").value); var iMonth = parseInt(monster("tbSelMonth").value); var aCell = monster("cellText" + arguments[0]); aCell.bgColor = gcMouseOut; with (aCell) { var iDay = parseInt(innerHTML); if (checkColor(style.color, gcNotCurMonth)) { iOffset = (innerHTML > 10) ? -1 : 1; } iMonth += iOffset; if (iMonth < 1) { iYear--; iMonth = 12; } else if (iMonth > 12) { iYear++; iMonth = 1; } } fSetDate(iYear, iMonth, iDay); }
    function Point(iX, iY) { this.x = iX; this.y = iY; }
    function fBuildCal(iYear, iMonth) { var aMonth = new Array(); for (var i = 1; i < 7; i++) { aMonth[i] = new Array(i); } var dCalDate = new Date(iYear, iMonth - 1, 1); var iDayOfFirst = dCalDate.getDay(); var iDaysInMonth = new Date(iYear, iMonth, 0).getDate(); var iOffsetLast = new Date(iYear, iMonth - 1, 0).getDate() - iDayOfFirst + 1; var iDate = 1; var iNext = 1; for (var d = 0; d < 7; d++) { aMonth[1][d] = (d < iDayOfFirst) ? (iOffsetLast + d) * (-1) : iDate++; } for (var w = 2; w < 7; w++) { for (var d = 0; d < 7; d++) { aMonth[w][d] = (iDate <= iDaysInMonth) ? iDate++ : (iNext++) * (-1); } } return aMonth; }
    function fDrawCal(iYear, iMonth, iCellHeight, iDateTextSize) { var colorTD = " bgcolor='" + gcMouseOut + "' bordercolor='" + gcMouseOut + "'"; var styleTD = " valign='middle' align='center' style='height:" + iCellHeight + "px;font-weight:bolder;font-size:" + iDateTextSize + "px;"; var dateCal = ""; dateCal += "<tr>"; for (var i = 0; i < 7; i++) { dateCal += "<td" + colorTD + styleTD + "color:#990099'>" + WeekDay[i] + "</td>"; } dateCal += "</tr>"; for (var w = 1; w < 7; w++) { dateCal += "<tr>"; for (var d = 0; d < 7; d++) { var tmpid = w + "" + d; dateCal += "<td" + styleTD + "cursor:pointer;' onclick='fSetSelected(" + tmpid + ")'>"; dateCal += "<span id='cellText" + tmpid + "'></span>"; dateCal += "</td>"; } dateCal += "</tr>"; } return dateCal; }
    function fUpdateCal(iYear, iMonth) { var myMonth = fBuildCal(iYear, iMonth); var i = 0; for (var w = 1; w < 7; w++) { for (var d = 0; d < 7; d++) { with (monster("cellText" + w + "" + d)) { parentNode.bgColor = gcMouseOut; parentNode.borderColor = gcMouseOut; parentNode.onmouseover = function () { this.bgColor = gcMouseOver; }; parentNode.onmouseout = function () { this.bgColor = gcMouseOut; }; if (myMonth[w][d] < 0) { style.color = gcNotCurMonth; innerHTML = Math.abs(myMonth[w][d]); } else { style.color = ((d == 0) || (d == 6)) ? gcRestDay : gcWorkDay; innerHTML = myMonth[w][d]; if (iYear == giYear && iMonth == giMonth && myMonth[w][d] == giDay) { style.color = gcToday; parentNode.bgColor = gcTodayMouseOut; parentNode.onmouseover = function () { this.bgColor = gcTodayMouseOver; }; parentNode.onmouseout = function () { this.bgColor = gcTodayMouseOut; }; } } } } } }
    function fSetYearMon(iYear, iMon) { monster("tbSelMonth").options[iMon - 1].selected = true; for (var i = 0; i < monster("tbSelYear").length; i++) { if (monster("tbSelYear").options[i].value == iYear) { monster("tbSelYear").options[i].selected = true; } } fUpdateCal(iYear, iMon); }
    function fPrevMonth() { var iMon = monster("tbSelMonth").value; var iYear = monster("tbSelYear").value; if (--iMon < 1) { iMon = 12; iYear--; } fSetYearMon(iYear, iMon); }
    function fNextMonth() { var iMon = monster("tbSelMonth").value; var iYear = monster("tbSelYear").value; if (++iMon > 12) { iMon = 1; iYear++; } fSetYearMon(iYear, iMon); }
    function fGetXY(aTag) { var oTmp = aTag; var pt = new Point(0, 0); do { pt.x += oTmp.offsetLeft; pt.y += oTmp.offsetTop; oTmp = oTmp.offsetParent; } while (oTmp != null && oTmp.tagName.toUpperCase() != "BODY" && oTmp.tagName.toUpperCase() != "HTML"); return pt; }
    function getDateDiv(startyear, endyear, divname) {
        this.startYear = startyear || 1980; var divname = "calendardiv" || divname;
        this.endYear = endyear || 2017; var noSelectForIE = ""; var noSelectForFireFox = ""; if (document.all) { noSelectForIE = "onselectstart='return false;'"; } else { noSelectForFireFox = "-moz-user-select:none;"; } var dateDiv = ""; dateDiv += "<div id='" + divname + "' onclick='event.cancelBubble=true' " + noSelectForIE + " style='" + noSelectForFireFox + "position:absolute;z-index:99;visibility:hidden;border:1px solid #999999;'>"; dateDiv += "<table border='0' bgcolor='#E0E0E0' cellpadding='1' cellspacing='1' >"; dateDiv += "<tr>"; dateDiv += "<td><input type='button' id='PrevMonth' value='<' style='height:20px;width:20px;font-weight:bolder;' onclick='fPrevMonth()'>"; dateDiv += "</td><td><select id='tbSelYear' style='border:1px solid;' onchange='fUpdateCal(monsterV(\"tbSelYear\"),monsterV(\"tbSelMonth\"))'>"; for (var i = startYear; i < endYear; i++) { dateDiv += "<option value='" + i + "'>" + i + strYear + "</option>"; } dateDiv += "</select></td><td>"; dateDiv += "<select id='tbSelMonth' style='border:1px solid;' onchange='fUpdateCal(monsterV(\"tbSelYear\"),monsterV(\"tbSelMonth\"))'>"; for (var i = 0; i < 12; i++) { dateDiv += "<option value='" + (i + 1) + "'>" + gMonths[i] + "</option>"; } dateDiv += "</select></td><td>"; dateDiv += "<input type='button' id='NextMonth' value='>' style='height:20px;width:20px;font-weight:bolder;' onclick='fNextMonth()'>"; dateDiv += "</td>"; dateDiv += "</tr><tr>"; dateDiv += "<td align='center' colspan='4'>"; dateDiv += "<div style='background-color:#cccccc'><table width='100%' border='0' cellpadding='3' cellspacing='1'>"; dateDiv += fDrawCal(giYear, giMonth, dayTdHeight, dayTdTextSize); dateDiv += "</table></div>"; dateDiv += "</td>"; dateDiv += "</tr><tr><td align='center' colspan='4' nowrap>"; dateDiv += "<span style='cursor:pointer;font-weight:bolder;' onclick='fSetDate(giYear,giMonth,giDay)' onmouseover='this.style.color=\"" + gcMouseOver + "\"' onmouseout='this.style.color=\"#000000\"'>" + strToday + ":" + giYear + strYear + giMonth + strMonth + giDay + strDay + "</span>"; dateDiv += "</tr></tr>"; dateDiv += "</table></div>"; return dateDiv;
    }
    with (document) { onclick = fHideCalendar; write(getDateDiv()); }
</script>  

    <style type="text/css">
        body{color:#333; font:normal 12px/22px "宋体",Verdana,Arial,Helvetica,sans-serif;}
        .midBox{position:absolute;left:50%; width:950px; background:#fff url(img/applyinfo_Top.jpg) center 10px no-repeat;margin:0px 0 0 -475px; padding:90px 10px 10px 10px;}
        .cnt{width:910px; background:url(../img/search_Bottom.jpg) bottom no-repeat;padding:6px 20px 20px;}
        .bbsInput_short{width:164px;}
        .xselect{width:170px;}
        
        html,body,p,ul,li,form,img,h1, h2, h3, h4, h5, h6,input,select,fieldset{margin:0;padding:0;}
        body{color:#333; font:normal 12px/22px "宋体",Verdana,Arial,Helvetica,sans-serif;}
    input,select,option{font-size:12px;}
     #Panel1{
          border-bottom:#2d91ce 1px solid;
          border-left:#2d91ce 1px solid;
          padding:10px 0 10px 0;        
         margin:-237px 0 0 -474px;        
         width:948px;  height:475px;      
         background:#ebf5fd;
         border-top:#2d91ce 1px solid;
         border-right:#2d91ce 1px solid; display:none;        
         position:absolute; top:50%; left:50%; z-index:100000;}
     .commonBG_repeat
     { margin: 0 auto;width:930px; height:475px; background:url(../img/commonRepeat.jpg) repeat-y ;}
     .commonBG_bottom
     {
         margin: 0 auto;
         width: 930px; height:475px;
         background: url(../img/commonBtm.jpg) no-repeat 50% bottom;         
     }
     .commonBG_top
     {
        position:relative;
        margin:0 auto; 
        padding: 50px 0 20px 0; 
        width:930px;height:405px;
        background:url(../img/commonTop.jpg) no-repeat 50% top;
     }
    .common_title{width:450px;height:30px;position:absolute;left:30px;top:12px;text-align:left;}   
    .searchOther{width:350px;height:22px;position:absolute;top:18px;right:30px;text-align:right;overflow:hidden;color:#0068A3;}
    .searchSch{width:350px;height:22px;text-align:left;}
    .searchSch select,.searchSch input{vertical-align:middle;}
    .schMainTop{  margin: 0 auto;width:910px; height:10px;line-height:10px;font-size:10px;background:url(../img/schtop.jpg) no-repeat;}
    .schMainRepeat{ height:384px; width:900px;background:url(../img/schrepeat.jpg) repeat-y; clear:both;margin:0 auto;padding:0 5px;}
   .schMainBottom{ width:910px; height:10px;line-height:10px;font-size:10px;background:url(../img/schbottom.jpg) no-repeat; clear:both;margin:0 auto;}
   .leftMap{ width:410px; margin:10px auto; float:left; display:inline;}
   .rightSchList{ width:480px;margin-left:10px;float:left; display:inline;}
    .rightSchList h2{font-size:12px; color:#0068A3; height:27px; line-height:27px;text-align:center;}
    .xschlist{width:450px;height:355px;margin:0 auto;clear:both; overflow:hidden;}
    .xframe{ width:450px; padding:0; margin:0; height:360px;}
    td,TD{padding:0;border:0; margin:0;}
    area{cursor:pointer;}  
    
    #Slider2{float:left; display:inline;}
    #Slider2_BoundControl{float:left; display:inline;}   
    
    .button{margin-top: 10px; margin-bottom: 10px;padding:2px 12px 2px 12px; margin-left:20px;}
    
    #status{position:absolute; top:30px; left:450px;}
    </style>     

</head>
<body>
   <asp:Panel ID="Panel1" runat="server" >
        <div class=" commonBG_repeat">
           <div class="commonBG_bottom">
                <div class="commonBG_top">
                    <div class="common_title"><img src="../img/schTitle.jpg" alt=""  /></div>
                    <div class="searchOther">
                    <script type="text/javascript" language="javascript">
                        String.prototype.strip = function () {
                            return this.replace(/^\s+/, '').replace(/\s+$/, '');
                        }

                        function checkit() {
                            // var schform = document.getElementById("schform");
                            //  if (!schform) {
                            //      return false;
                            // }
                            var ssdmValue = $("select[name='ssdm']").attr("value").strip();
                            var ssdmstr = $("select[name='ssdm'] option[value=" + ssdmValue + "]").html();
                            var yxmcValue = $("input[name='yxmc']").attr("value").strip();
                            if (yxmcValue == "输入学校名称关键字") {
                                $("input[name='yxmc']").attr("value", "");
                                yxmcValue = "";
                            }
                            if (ssdmValue == '00') {
                                if ((yxmcValue == "") || (yxmcValue.length == 1)) {
                                    window.alert("请选择院校所在省市,或输入学校名称关键字");
                                    return false;
                                } else if ((yxmcValue == "大学") || (yxmcValue == "学院")) {
                                    window.alert("学校名称关键字过于简单");
                                }
                                return true;
                            }
                            var urlstr = "../gxframe.aspx?Province=" + (ssdmValue != "00" ? ssdmstr : "") + "&Key=" + yxmcValue + "&Page=1";
                            $('#idframe').attr('src', urlstr);
                            return true;
                        }

                        function init_data_info(str, tStr, o) {
                            if (!o) {
                                return;
                            } else {
                                if (o.value.strip() == str.strip()) {
                                    o.value = tStr;
                                }
                            }
                        }
</script>
                    <div class="searchSch">搜索院校：<select name="ssdm">
<option value="00">院校所在省市</option>
<option value="11">北京市</option>
<option value="12">天津市</option>
<option value="13">河北省</option>
<option value="14">山西省</option>
<option value="15">内蒙古自治区</option>
<option value="21">辽宁省</option>
<option value="22">吉林省</option>
<option value="23">黑龙江省</option>
<option value="31">上海市</option>
<option value="32">江苏省</option>
<option value="33">浙江省</option>
<option value="34">安徽省</option>
<option value="35">福建省</option>
<option value="36">江西省</option>
<option value="37">山东省</option>
<option value="41">河南省</option>
<option value="42">湖北省</option>
<option value="43">湖南省</option>
<option value="44">广东省</option>
<option value="45">广西壮族自治区</option>
<option value="46">海南省</option>
<option value="50">重庆市</option>
<option value="51">四川省</option>
<option value="52">贵州省</option>
<option value="53">云南省</option>
<option value="54">西藏自治区</option>
<option value="61">陕西省</option>
<option value="62">甘肃省</option>
<option value="63">青海省</option>
<option value="64">宁夏回族自治区</option>
<option value="65">新疆维吾尔自治区</option>
<option value="81">香港特别行政区</option>
</select> 
<input name="yxmc" type="text" size="17" maxlength="20" value="输入学校名称关键字" class="search_input" onmouseover="javascript:init_data_info('输入学校名称关键字','', this)" onfocus="this.select();" onmouseout="javascript:init_data_info('', '输入学校名称关键字', this)" /> 
    <input id="Button1" type="button" value="搜索" class="button-sch"  onclick = "checkit();"/>

</div>
                    </div>
                    <div class="schMainTop"></div>
                    <div class="schMainRepeat">
                        <div class="leftMap"><img src="../img/map.gif" width="395" height="364" border="0" usemap="#Map"  alt = "" /></div>
                       <div class="rightSchList">
                            <h2>院校信息列表</h2>
                            <div class = "xschlist">
                                <iframe id = "idframe" src ="../gxframe.aspx" class = "xframe" frameborder="0" scrolling="no"></iframe>
                            </div>
                        </div>
                       
                       
                       
                        <map name="Map" id = "Map">
                          <area shape="rect" coords="328,72,373,88" href = "javascript:void(0)" onclick = "  $('#idframe').attr('src','../gxframe.aspx?Province=黑龙江省&Page=1')" alt="黑龙江" />
                          <area shape="rect" coords="331,102,365,117" href = "javascript:void(0)" onclick = "  $('#idframe').attr('src','../gxframe.aspx?Province=吉林省&Page=1')" alt="吉林" />
                          <area shape="rect" coords="314,121,348,135" href = "javascript:void(0)" onclick = "  $('#idframe').attr('src','../gxframe.aspx?Province=辽宁省&Page=1')" alt="辽宁" />
                          <area shape="rect" coords="308,138,344,153" href = "javascript:void(0)" onclick = "  $('#idframe').attr('src','../gxframe.aspx?Province=天津市&Page=1')" alt="天津" />
                          <area shape="rect" coords="276,125,310,139" href = "javascript:void(0)" onclick = "  $('#idframe').attr('src','../gxframe.aspx?Province=北京市&Page=1')" alt="北京" />
                          <area shape="rect" coords="78,110,113,124" href = "javascript:void(0)" onclick = "  $('#idframe').attr('src','../gxframe.aspx?Province=新疆维吾尔自治区&Page=1')" alt="新疆" />
                          <area shape="rect" coords="72,191,107,206" href = "javascript:void(0)" onclick = "  $('#idframe').attr('src','../gxframe.aspx?Province=西藏自治区&Page=1')" alt="西藏" />
                          <area shape="rect" coords="134,163,169,179" href = "javascript:void(0)" onclick = "  $('#idframe').attr('src','../gxframe.aspx?Province=青海省&Page=1')" alt="青海" />
                          <area shape="rect" coords="161,259,197,275" href = "javascript:void(0)" onclick = "  $('#idframe').attr('src','../gxframe.aspx?Province=云南省&Page=1')" alt="云南" />
                          <area shape="rect" coords="203,303,239,320" href = "javascript:void(0)" onclick = "  $('#idframe').attr('src','../gxframe.aspx?Province=海南省&Page=1')" alt="海南" />
                          <area shape="rect" coords="168,204,203,219" href = "javascript:void(0)" onclick = "  $('#idframe').attr('src','../gxframe.aspx?Province=四川省&Page=1')" alt="四川" />
                          <area shape="rect" coords="155,135,191,151" href = "javascript:void(0)" onclick = "  $('#idframe').attr('src','../gxframe.aspx?Province=甘肃省&Page=1')" alt="甘肃" />
                          <area shape="rect" coords="212,132,258,148" href = "javascript:void(0)" onclick = "  $('#idframe').attr('src','../gxframe.aspx?Province=内蒙古自治区&Page=1')" alt="内蒙古" />
                          <area shape="rect" coords="200,159,236,174" href = "javascript:void(0)" onclick = "  $('#idframe').attr('src','../gxframe.aspx?Province=宁夏回族自治区&Page=1')" alt="宁夏" />
                          <area shape="rect" coords="217,182,252,197" href = "javascript:void(0)" onclick = "  $('#idframe').attr('src','../gxframe.aspx?Province=陕西省&Page=1')" alt="陕西" />
                          <area shape="rect" coords="204,218,240,233" href = "javascript:void(0)" onclick = "  $('#idframe').attr('src','../gxframe.aspx?Province=重庆市&Page=1')" alt="重庆" />
                          <area shape="rect" coords="201,244,237,260" href = "javascript:void(0)" onclick = "  $('#idframe').attr('src','../gxframe.aspx?Province=贵州省&Page=1')" alt="贵州" />
                          <area shape="rect" coords="217,265,253,280" href = "javascript:void(0)" onclick = "  $('#idframe').attr('src','../gxframe.aspx?Province=广西壮族自治区&Page=1')" alt="广西" />
                          <area shape="rect" coords="258,262,292,276" href = "javascript:void(0)" onclick = "  $('#idframe').attr('src','../gxframe.aspx?Province=广东省&Page=1')" alt="广东" />
                          <area shape="rect" coords="237,235,271,249" href = "javascript:void(0)" onclick = "  $('#idframe').attr('src','../gxframe.aspx?Province=湖南省&Page=1')" alt="湖南" />
                          <area shape="rect" coords="244,206,280,221" href = "javascript:void(0)" onclick = "  $('#idframe').attr('src','../gxframe.aspx?Province=湖北省&Page=1')" alt="湖北" />
                          <area shape="rect" coords="273,229,307,243" href = "javascript:void(0)" onclick = "  $('#idframe').attr('src','../gxframe.aspx?Province=江西省&Page=1')" alt="江西" />
                          <area shape="rect" coords="292,248,328,263" href = "javascript:void(0)" onclick = "  $('#idframe').attr('src','../gxframe.aspx?Province=福建省&Page=1')" alt="福建" />
                          <area shape="rect" coords="309,222,343,238" href = "javascript:void(0)" onclick = "  $('#idframe').attr('src','../gxframe.aspx?Province=浙江省&Page=1')" alt="浙江" />
                          <area shape="rect" coords="280,202,315,216" href = "javascript:void(0)" onclick = "  $('#idframe').attr('src','../gxframe.aspx?Province=安徽省&Page=1')" alt="安徽" />
                          <area shape="rect" coords="254,185,289,200" href = "javascript:void(0)" onclick = "  $('#idframe').attr('src','../gxframe.aspx?Province=河南省&Page=1')" alt="河南" />
                          <area shape="rect" coords="244,158,279,174" href = "javascript:void(0)" onclick = "  $('#idframe').attr('src','../gxframe.aspx?Province=山西省&Page=1')" alt="山西" />
                          <area shape="rect" coords="270,143,306,158" href = "javascript:void(0)" onclick = "  $('#idframe').attr('src','../gxframe.aspx?Province=河北省&Page=1')" alt="河北" />
                          <area shape="rect" coords="284,164,320,180" href = "javascript:void(0)" onclick = "  $('#idframe').attr('src','../gxframe.aspx?Province=山东省&Page=1')" alt="山东" />
                          <area shape="rect" coords="295,183,330,198" href = "javascript:void(0)" onclick = "  $('#idframe').attr('src','../gxframe.aspx?Province=江苏省&Page=1')" alt="江苏" />
                          <area shape="rect" coords="318,202,354,218" href = "javascript:void(0)" onclick = "  $('#idframe').attr('src','../gxframe.aspx?Province=上海市&Page=1')" alt="上海" />
                        </map>
                    </div>
                    <div class="schMainBottom"></div>
                </div>
           </div>
         </div>
        </asp:Panel>



<div class="midBox">
    <div id = "status">
    <div id ="up"><table><tr><td width="52px" align="center"> <asp:label id = "step1"  runat="Server" Text="提交审核" /></td>
                   <td width="110px" align="center"> <asp:label id = "step2" runat="Server" Text="院系审核" /></td>
                    <td width="87px" align="center"> <asp:label id = "step3" runat="Server" Text="研究生院审核" /></td>
                    <td width="170px" align="center"> <asp:label id = "step4" runat="Server" Text="确认资格" /></td>
                    <td width="52px" align="center"> <asp:label id = "step5" runat="Server" Text="确认完成" /></td></tr></table></div>
    <div id = "bar"><img id = "stepimg" src = "img/status1.png"  alt = "bar" style="padding-left: 27px" /></div>
      <form id="Form1" runat="Server" method="post" >     
    <div id = "explain" style="text-align: center">
        <asp:HyperLink ID="explainalert" href = "javascript:void(0)" runat="server">说明解释</asp:HyperLink>
        
        
        </div>
    </div>
<div class="cnt">

    <table width="100%"  border="0" cellpadding="0" cellspacing="1" bgcolor="#E1E1E1">
    <tr bgcolor="#FFFFFF"><td> 
    <br />
    <h4 style="padding-left: 20px; font-size: 12px; color: #333;">以下是为您保存的注册信息，仅当未提交审核前或院系审核不通过时可以修改。另外，只有提交审核后院系才会开始审核。</h4>

    
    </td></tr>
          <tr bgcolor="#FFFFFF"> 
            <td valign="top" align="center" style="height: 600px">
            <!--  <span align="center" style="color:#666666;font-size:14px;font-weight:600"><br />用户注册 ---&gt; 填写用户信息</span> -->
            <br />
            
            
             <table width="80%"  border="0" cellpadding="4" cellspacing="1" bgcolor="#E1E1E1">
             <tr bgcolor="#ffffff" style="height: 37px"> 
                  <td width="30%"  align="right"><font color="#ff0000">*</font>申请类别：</td>
                  <td align="left" width="70%" style="padding-left: 10px">
                      <asp:RadioButtonList ID="sqlb" runat="server"  
                          RepeatDirection="Horizontal"  RepeatLayout="Flow">
                        <asp:ListItem Value="直博生">&nbsp;</asp:ListItem> 
                        <asp:ListItem Value="推免生">&nbsp;</asp:ListItem> 
                        <asp:ListItem Value="统考生"></asp:ListItem> 
                      </asp:RadioButtonList>
                      <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="!!!" 
                      Display="Static" ControlToValidate="sqlb"></asp:RequiredFieldValidator>
             </td></tr>   
             <tr bgcolor="#f7f7f7" style="height: 37px"> 
                  <td width="30%" align="right"><font color="#ff0000">*</font>申请院系：</td>
                  <td align="left" width="70%" style="padding-left: 10px"> 
                      
                                        
                      <asp:DropDownList ID="DropDownList1" runat="server" 
                          DataSourceID="AccessDataSource1" DataTextField="ACADEMICNAME" 
                          DataValueField="ACADEMICNAME" ondatabound="DropDownList1_DataBound"
                          onchange = "gettt(this.options[this.selectedIndex].value)" 
                          AutoPostBack="false"  CssClass="xselect">
                      </asp:DropDownList>
                      <asp:AccessDataSource ID="AccessDataSource1" runat="server" 
            DataFile="~/app_data/Database111.mdb" 
            SelectCommand="SELECT [ACADEMICNAME] FROM [培养单位表_武汉大学]"></asp:AccessDataSource>      
                      <asp:CompareValidator ID="CompareValidator1" runat="server" ErrorMessage="!!!" ValueToCompare="请选择院系" Operator="NotEqual" ControlToValidate="DropDownList1" Display="Static"></asp:CompareValidator>
            
             </td></tr>
             <tr bgcolor="#ffffff" style="height: 37px"> 
                  <td width="30%" align="right"><font color="#ff0000">*</font>申请攻读专业：</td>
                  <td align="left" width="70%" style="padding-left: 10px">
                  <span id ="zy" >
                      <asp:DropDownList ID="DropDownList2" runat="server" class ="xselect">
                      </asp:DropDownList>               
                   
                  </span>
                      <input id="txtzy" type="hidden" runat = "server" />
                     </td></tr>
             
             
             <tr bgcolor="#f7f7f7" style="height: 37px"> 
                  <td width="30%" align="right"><font color="#ff0000">*</font>姓&nbsp;&nbsp;&nbsp;&nbsp;名：</td>
                  <td align="left" width="70%" style="padding-left: 10px">
                      <asp:TextBox ID="tb_name" runat="server" CssClass="bbsInput_short" MaxLength="8"></asp:TextBox>
                      <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="!!!" ControlToValidate="tb_name"></asp:RequiredFieldValidator>
                      <asp:RegularExpressionValidator ID="RegularExpressionValidator6" runat="server" ErrorMessage="只能输入简体汉字" ValidationExpression="^[\u4E00-\u9FA5]{1,8}$" ControlToValidate="tb_name"></asp:RegularExpressionValidator>
             </td></tr>

             <tr bgcolor="#ffffff" style="height: 37px"> 
                  <td width="30%" align="right"><font color="#ff0000">*</font>性&nbsp;&nbsp;&nbsp;&nbsp;别：</td>
                  <td align="left" width="70%" style="padding-left: 10px">
                    <asp:RadioButtonList ID="rbl_xb" runat="server"  
                          RepeatDirection="Horizontal"  RepeatLayout="Flow">
                        <asp:ListItem Value="1" Text="男"></asp:ListItem> 
                        <asp:ListItem Value="2" Text="女"></asp:ListItem>                         
                      </asp:RadioButtonList>
                      <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="!!!" 
                      Display="Static" ControlToValidate="rbl_xb"></asp:RequiredFieldValidator>
             </td></tr>

             <tr bgcolor="#f7f7f7" style="height: 37px"> 
                  <td width="30%" align="right"><font color="#ff0000">*</font>民&nbsp;&nbsp;&nbsp;&nbsp;族：</td>
                  <td align="left" width="70%" style="padding-left: 10px">
                  <asp:DropDownList ID="DropDownList3" runat="server" 
                          DataSourceID="AccessDataSource3" DataTextField="NATIONNAME" 
                          DataValueField="NATIONNAME" ondatabound="DropDownList3_DataBound"
                           CssClass="xselect">
                      </asp:DropDownList>
                      <asp:AccessDataSource ID="AccessDataSource3" runat="server" 
            DataFile="~/app_data/Database111.mdb" 
            SelectCommand="SELECT [NATIONNAME] FROM [民族表]"></asp:AccessDataSource>      
              
             
             </td></tr>

             <tr bgcolor="#ffffff" style="height: 37px"> 
                  <td width="30%" align="right"><font color="#ff0000">*</font>出生日期：</td>
                  <td align="left" width="70%" style="padding-left: 10px">
                     
                       <input id="tb_csrq" type="text" onclick="fPopCalendar(event,this,this,1980,2000)" readonly = "readonly"
            onfocus="this.select()"  name="tb_csrq" runat="Server" class="bbsInput_short" />
                 <asp:RequiredFieldValidator ID="RequiredFieldValidator14" runat="server" ErrorMessage="!!!" ControlToValidate="tb_csrq"></asp:RequiredFieldValidator> 
             </td></tr>
            
             <tr bgcolor="#f7f7f7" style="height: 37px"> 
                  <td width="30%" align="right"><font color="#ff0000">*</font>身份证号：</td>
                  <td align="left" width="70%" style="padding-left: 10px">
                      <asp:TextBox ID="sfzh" CssClass = "bbsInput_short" runat="server" MaxLength="18"></asp:TextBox>
                      <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                          ErrorMessage="!!!" ControlToValidate="sfzh"></asp:RequiredFieldValidator>
                      <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" 
                          ErrorMessage="身份证号不正确" 
                          ValidationExpression="\d{17}[\d|X]" ControlToValidate="sfzh" 
                          Display="Static"></asp:RegularExpressionValidator>
             </td></tr>

             <tr bgcolor="#ffffff" style="height: 37px"> 
                  <td width="30%" align="right"><font color="#ff0000">*</font>移动电话：</td>
                  <td align="left" width="70%" style="padding-left: 10px">
                         <asp:TextBox ID="tb_yddh" CssClass = "bbsInput_short" runat="server" MaxLength="11"></asp:TextBox>
                      <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" 
                          ErrorMessage="!!!" ControlToValidate="tb_yddh"></asp:RequiredFieldValidator>
                      <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" 
                          ErrorMessage="移动电话号码不正确" 
                          ValidationExpression="^1\d{10}$" ControlToValidate="tb_yddh" 
                          Display="Static"></asp:RegularExpressionValidator>
             </td></tr>

             <tr bgcolor="#f7f7f7" style="height: 37px"> 
                  <td width="30%" align="right"><font color="#ff0000">*</font>电子邮箱：</td>
                  <td align="left" width="70%" style="padding-left: 10px">
                        <asp:TextBox ID="tb_dzyx" CssClass = "bbsInput_short" runat="server" MaxLength="30"></asp:TextBox>
                      <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" 
                          ErrorMessage="!!!" ControlToValidate="tb_dzyx"></asp:RequiredFieldValidator>
                      <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" 
                          ErrorMessage="邮箱地址不正确" 
                          ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ControlToValidate="tb_dzyx" 
                          Display="Static"></asp:RegularExpressionValidator>
             </td></tr>

             <tr bgcolor="#ffffff" style="height: 37px"> 
                  <td width="30%" align="right"><font color="#ff0000">*</font>邮政编码：</td>
                  <td align="left" width="70%" style="padding-left: 10px">
                        <asp:TextBox ID="tb_yzbm" CssClass = "bbsInput_short" runat="server" MaxLength="6"></asp:TextBox>
                      <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" 
                          ErrorMessage="!!!" ControlToValidate="tb_yzbm"></asp:RequiredFieldValidator>
                      <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" 
                          ErrorMessage="邮箱编码不正确" 
                          ValidationExpression="\d{6}" ControlToValidate="tb_yzbm" 
                          Display="Static"></asp:RegularExpressionValidator>
             </td></tr>

             <tr bgcolor="#f7f7f7" style="height: 37px"> 
                  <td width="30%" align="right"><font color="#ff0000">*</font>通讯地址：</td>
                  <td align="left" width="70%" style="padding-left: 10px">
                        <asp:TextBox ID="tb_txdz"  runat="server" Width="300px" MaxLength="80"></asp:TextBox>
                      <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" 
                          ErrorMessage="!!!" ControlToValidate="tb_txdz"></asp:RequiredFieldValidator>
                      
             </td></tr>

             <tr bgcolor="#ffffff" style="height: 37px"> 
                  <td width="30%" align="right"><font color="#ff0000">*</font>近三个月免冠相片：</td>
                  <td align="left" width="70%" style="padding-left: 10px">
                    
                     <asp:FileUpload ID="fup" runat="server"  onchange = "checkType()"/>
                     <input id="Button4" type="button" value="上传" onclick="upload()" runat = "server"/> <br />
                    <asp:Label ID="lblMessage" runat="server" Text="相片应为高160像素、宽120像素.jpg图片" ForeColor="Red" Font-Bold="True"></asp:Label>
                      <asp:Image ID="Image1"  runat="server" AlternateText = "您的照片" />
    <script type="text/javascript">
        $("#Image1").attr("src", "../imageshow.aspx?" + new Date());
    </script>
                       <script type ="text/javascript">

                           /**
                           * 检查上传文件类型是否在规定范围内
                           */
                           function checkType() {

                               //得到上传文件的值  
                               var fileName = document.getElementById("fup").value;
                               if (fileName == "") { alert("请选择文件"); return false; }
                               //返回String对象中子字符串最后出现的位置.  
                               var seat = fileName.lastIndexOf(".");

                               //返回位于String对象中指定位置的子字符串并转换为小写.  
                               var extension = fileName.substring(seat).toLowerCase();

                               //判断允许上传的文件格式  
                               //if(extension!=".jpg"&&extension!=".jpeg"&&extension!=".gif"&&extension!=".png"&&extension!=".bmp"){  
                               //alert("不支持"+extension+"文件的上传!");  
                               //return false;  
                               //}else{  
                               //return true;  
                               //}

                               var allowed = [".jpg"]; //, ".gif", ".png", ".bmp", ".jpeg"];
                               for (var i = 0; i < allowed.length; i++) {
                                   if (!(allowed[i] != extension)) {

                                       return true;
                                   }
                               }
                               var file = $("#fup");
                               file.after(file.clone().val(""));
                               file.remove();
                               alert("不支持" + extension + "格式");
                               return false;
                           }
                           function checkType2() {
                               var c = checkType();
                               if (c == true) {

                                   return true;
                               }
                               return false;
                           }
                       </script>   
             </td></tr>

             <tr bgcolor="#f7f7f7" style="height: 37px"> 
                  <td width="30%" align="right"><font color="#ff0000">*</font>本科学校：</td>
                  <td align="left" width="70%" style="padding-left: 10px">
                  <asp:TextBox ID="xxxTextBox1" runat="server" 
                          CssClass="bbsInput_short" CausesValidation="True" onfocus = "this.blur();"></asp:TextBox>
                      <input id="Button2" type="button" value="本科学校已撤销" onclick = "  $('#xxxTextBox1').attr('value','本科学校已撤销')"  runat = "server"/>
                      <input id="Button3" type="button" value="境外教育机构"  onclick = "  $('#xxxTextBox1').attr('value','境外教育机构')" runat = "server"/>
                 <asp:RequiredFieldValidator ID="RequiredFieldValidator15" runat="server" 
                          ErrorMessage="!!!" ControlToValidate="xxxTextBox1"></asp:RequiredFieldValidator> 
             </td></tr>

             

            
             
             <tr bgcolor="#ffffff" style="height: 37px"> 
                  <td width="30%" align="right"><font color="#ff0000">*</font>本科院系：</td>
                  <td align="left" width="70%" style="padding-left: 10px">
                        <asp:TextBox ID="tb_bkyx" runat="server"  CssClass="bbsInput_short" MaxLength="30"></asp:TextBox>
                      <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ErrorMessage="!!!" ControlToValidate="tb_bkyx"></asp:RequiredFieldValidator>
             </td></tr>
            
             <tr bgcolor="#f7f7f7" style="height: 37px"> 
                  <td width="30%" align="right"><font color="#ff0000">*</font>本科专业：</td>
                  <td align="left" width="70%" style="padding-left: 10px">
                          <asp:TextBox ID="tb_bkzy" runat="server"  CssClass="bbsInput_short" MaxLength="30"></asp:TextBox>
                      <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" ErrorMessage="!!!" ControlToValidate="tb_bkzy"></asp:RequiredFieldValidator>
             
             </td></tr>
             
              <tr bgcolor="#ffffff" style="height: 37px"> 
                  <td width="30%" align="right"><font color="#ff0000">*</font>本科入校时间：</td>
                  <td align="left" width="70%" style="padding-left: 10px">
                     <input id="Slider1" type="text" onclick="
                    
                     fPopCalendar(event,this,this,2002,2012)" readonly = "readonly"
            onfocus="this.select()"  name="Slider1" runat="Server" class="bbsInput_short" />
                      <asp:RequiredFieldValidator ID="RequiredFieldValidator17" runat="server" ErrorMessage="!!!" ControlToValidate="Slider1"></asp:RequiredFieldValidator>
              </td></tr>
             <tr bgcolor="#f7f7f7" style="height: 37px"> 
                  <td width="30%" align="right"><font color="#ff0000">*</font>本科毕业时间：</td>
                  <td align="left" width="70%" style="padding-left: 10px">
                    <input id="Slider2" type="text" onclick="fPopCalendar(event,this,this,2006,2016)" readonly = "readonly"
            onfocus="this.select()"  name="Slider2" runat="Server" class="bbsInput_short" />  
            <asp:RequiredFieldValidator ID="RequiredFieldValidator16" runat="server" ErrorMessage="!!!" ControlToValidate="Slider2"></asp:RequiredFieldValidator>
            
             </td></tr>
             

             <tr bgcolor="#ffffff" style="height: 37px"> 
                  <td width="30%" align="right"><font color="#ff0000">*</font>英语水平：</td>
                  <td align="left" width="70%" style="padding-left: 10px">
                           <asp:TextBox ID="tb_yysp" runat="server"  CssClass="bbsInput_short" MaxLength="30"></asp:TextBox>
                      <asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" ErrorMessage="!!!" ControlToValidate="tb_yysp"></asp:RequiredFieldValidator>
            

             </td></tr>

             <tr bgcolor="#f7f7f7" style="height: 37px"> 
                  <td width="30%" align="right"><font color="#ff0000">*</font>本科同年级人数：</td>
                  <td align="left" width="70%" style="padding-left: 10px">
                          <asp:TextBox ID="tb_bkrs" CssClass = "bbsInput_short" runat="server" 
                              MaxLength="5"></asp:TextBox>
                      <asp:RequiredFieldValidator ID="RequiredFieldValidator12" runat="server" 
                          ErrorMessage="!!!" ControlToValidate="tb_bkrs"></asp:RequiredFieldValidator>
                      <asp:RegularExpressionValidator ID="RegularExpressionValidator5" runat="server" 
                          ErrorMessage="格式不正确" 
                          ValidationExpression="\b[1-9]\d{0,4}$" ControlToValidate="tb_bkrs" 
                          Display="Static" BorderStyle="None"></asp:RegularExpressionValidator>
             
             </td></tr>

             <tr bgcolor="#ffffff" style="height: 37px"> 
                  <td width="30%" align="right"><font color="#ff0000">*</font>本科专业同年级排名：</td>
                  <td align="left" width="70%" style="padding-left: 10px">
                    <asp:TextBox ID="tb_njpm" CssClass = "bbsInput_short" runat="server" 
                              MaxLength="5"></asp:TextBox>
                      <asp:RequiredFieldValidator ID="RequiredFieldValidator13" runat="server" 
                          ErrorMessage="!!!" ControlToValidate="tb_njpm"></asp:RequiredFieldValidator>
                      <asp:RegularExpressionValidator ID="RegularExpressionValidator7" runat="server" 
                          ErrorMessage="格式不正确" 
                          ValidationExpression="\b[1-9]\d{0,4}$" ControlToValidate="tb_njpm" 
                          Display="Static" BorderStyle="None"></asp:RegularExpressionValidator>
             
             
             
             </td></tr>

             <tr bgcolor="#f7f7f7" style="height: 37px"> 
                  <td width="30%" align="right"><font color="#ff0000">&nbsp;</font>校级以上获奖情况：</td>
                  <td align="left" width="70%" style="padding: 10px">
                      <asp:TextBox ID="tb_hjqk" runat="server" TextMode="MultiLine" Height="100px" Width="500px"></asp:TextBox>
             </td></tr>

             <tr bgcolor="#ffffff" style="height: 37px"> 
                  <td width="30%" align="right"><font color="#ff0000">&nbsp;</font>参加科研、发表论文情况：</td>
                  <td align="left" width="70%" style="padding: 10px">
                      <asp:TextBox ID="Tb_kylw" runat="server" TextMode="MultiLine" Height="100px" Width="500px"></asp:TextBox>

             </td></tr>

             <tr bgcolor="#f7f7f7" style="height: 37px"> 
                  <td width="30%" align="right"><font color="#ff0000">*</font>个人陈述：</td>
                  <td align="left" width="70%" style="padding: 10px">
                      <asp:TextBox ID="tb_grcs" runat="server" TextMode="MultiLine" Height="100px" Width="500px"></asp:TextBox>
                     <asp:RequiredFieldValidator ID="RequiredFieldValidator18" runat="server" 
                          ErrorMessage="!!!" ControlToValidate="tb_grcs"></asp:RequiredFieldValidator>
                     
             </td></tr>

             <tr><td></td></tr></table>
             <!-- <input id="Submit1" type="submit" value="提&nbsp;&nbsp;交"  onclick = "return lastcheck();" /> !-->
                 <asp:Button ID="save"  Text="保存修改" 
                 
                 OnClientClick="return lastcheck();" onclick="Button1_Click" runat = "server" 
                     CssClass="button" />&nbsp;&nbsp;
                     <asp:Button ID="submit"  Text="提交申请至院系审核" 
                 
                 OnClientClick="return lastcheck();" onclick="Button2_Click" runat = "server" 
                     CssClass="button" />
                     <asp:Button ID="confirm"  Text="确认参营"  onclick="Button3_Click" runat = "server" 
                     CssClass="button" />
                     <asp:Button ID="export"  Text="个人信息导出WORD"  runat = "server"   CssClass="button"
            onclick="export_Click" />
             
             
         
             
            

        </td></tr>
    </table>

</div></form>
    <script type="text/javascript">
        var sqztstr = "<%=sqzt%>";
        var btgyystr0 = "<%=btgyy%>";
        var btgyystr1 = "javascript:alert('院系拒绝了个人的申请信息，具体原因:" + btgyystr0 + "')";
        var btgyystr2 = "javascript:alert('研究生院拒绝了个人的申请信息，具体原因:" + btgyystr0 + "')";
        switch (sqztstr) {
            case "未审核": $("#stepimg").attr("src", "img/status1.png");
                $("#explainalert").attr("href", "javascript:alert('个人信息已经注册成功，尚未提交至所申请院系进行审核')"); break;
            case "院系审核中": $("#stepimg").attr("src", "img/status2.png"); $("#step2").html("院系审核");
                $("#explainalert").attr("href", "javascript:alert('院系正对个人申请信息进行审核，尚未产生审核结果')"); break;
            case "院系审核不通过": $("#stepimg").attr("src", "img/status3.png"); 
            $("#explainalert").attr("href", btgyystr1); 
                        $("#step3").html("院系审核不通过"); $("#step3").css({ "color": "red" }); break;
        case "研究生院审核中": $("#stepimg").attr("src", "img/status3.png");
            $("#step3").html("研究生院审核"); $("#step3").css({ "color": "#333" });
            $("#explainalert").attr("href", "javascript:alert('个人申请信息通过了院系审核，研究生院正对个人申请信息进行第二次审核，尚未产生审核结果')"); break;
        case "研究生院审核不通过": $("#stepimg").attr("src", "img/status4.png");
            $("#step4").html("研究生院审核不通过"); $("#step4").css({ "color": "red" });
            $("#explainalert").attr("href",btgyystr2 ); break;
        case "等待确认": $("#stepimg").attr("src", "img/status4.png");
            $("#step4").html("等待确认"); $("#step4").css({ "color": "#333" });
            $("#explainalert").attr("href", "javascript:alert('个人申请信息通过了研究生院审核，等待学生最后确认参加夏令营')"); break;
        case "确认完成": $("#stepimg").attr("src", "img/status5.png");
            $("#explainalert").attr("href", "javascript:alert('个人网上报名流程结束')"); break;
            default: break;
        }



        function getScrollTop() {
            var scrollPos;
            if (window.pageYOffset) {
                scrollPos = window.pageYOffset;
            }
            else if (document.compatMode && document.compatMode != 'BackCompat')
            { scrollPos = document.documentElement.scrollTop; }
            else if (document.body) { scrollPos = document.body.scrollTop; }
            return scrollPos;
        }
        function GT(o) { T = o.offsetTop; if (o.offsetParent != null) T += GT(o.offsetParent); return T; }

        $("input[type=radio]").css("padding-left", "10px");
        $("#xxxTextBox1").click(function () {
            var top = screen.availHeight / 2;
            var top2 = getScrollTop();
            top = top + top2;
            $("#Panel1").css("top", top);


            $("#Panel1").slideDown("slow");
        });
        //PHONE CHECK
        function iseven(sex) {
            if (sex % 2 == 1) return 1;
            else return 2;
        }
        function ismobilephone(s) {
            var field13 = /^13\d{9}$/g; //以13开头的11位号码
            var field15 = /^15[0,1,2,3,5,6,7,8,9]\d{8}$/g; //以15开头的11位号码
            var field18 = /^18[0,2,3,5,6,7,8,9]\d{8}$/g; //以18开头的11位号码
            var field14 = /^14[7]\d{8}$/g;  //以14开头的11位号码

            if ((field13.test(s)) || (field15.test(s)) || (field18.test(s)) || (field14.test(s))) {
                return true;
            }
            else {
                return false;
            }
        }
        // ID VALIDATION
        var issfz = function (str, gender, birthday) {
            if (str.length != 15 && str.length != 18)
                return 0;   //0：身份证位数不对，应为15或18位！
            if (str.length == 15) { //如果为15位
                var sex = str.substr(14, 1); //获取性别
                var year = str.substr(6, 2); //出生年
                var month = str.substr(8, 2); //出生月
                var day = str.substr(10, 2); //出生日
                var bir = year + month + day; //出生日期

                if (month < 0 || month > 12 || day < 0 || day > 31) {//日，月格式不符
                    return 2;
                }
                if ((iseven(sex)) != gender) {//与性别不一致
                    return 4;
                }
                if (bir != birthday.substr(2, 6)) {//与生日不一致
                    return 5;
                }
            }
            else { //为18位
                str1 = str.substring(0, 17);

                var sex = str.substr(16, 1); //获取性别
                var year = str.substr(6, 4); //出生年
                var month = str.substr(10, 2); //出生月
                var day = str.substr(12, 2); //出生日
                var bir = year + month + day; //出生日期
                if (month < 1 || month > 12 || day < 1 || day > 31) {//日，月格式不符
                    return 2;
                }
                var ch = str.substring(17, 18);
                if ((ch < "0" || ch > "9") && ch != "X") {
                    return 3;
                }
                if ((iseven(sex)) != gender) {//与性别不一致
                    return 4;
                }
                if (bir != birthday) {//与生日不一致
                    return 5;
                }
                //计算校验位
                var idcard_array = new Array();
                idcard_array = str.split("");
                S = (parseInt(idcard_array[0]) + parseInt(idcard_array[10])) * 7
      + (parseInt(idcard_array[1]) + parseInt(idcard_array[11])) * 9
      + (parseInt(idcard_array[2]) + parseInt(idcard_array[12])) * 10
      + (parseInt(idcard_array[3]) + parseInt(idcard_array[13])) * 5
      + (parseInt(idcard_array[4]) + parseInt(idcard_array[14])) * 8
      + (parseInt(idcard_array[5]) + parseInt(idcard_array[15])) * 4
      + (parseInt(idcard_array[6]) + parseInt(idcard_array[16])) * 2
      + parseInt(idcard_array[7]) * 1
      + parseInt(idcard_array[8]) * 6
      + parseInt(idcard_array[9]) * 3;
                Y = S % 11;
                M = "F";
                JYM = "10X98765432";
                M = JYM.substr(Y, 1); //判断校验位
                if (M != idcard_array[17]) {
                    return 6; //检测ID的校验位，最后一位填写错误
                }
            }
            return 7; //填写正确
        };
        ////////////////////////L A S T C H E C K//////////////////////////////////////////
        var lastcheck = function () {
            //申请类别
            var sqlblist = sqlb.getElementsByTagName("INPUT");
            var sqlbtag = 0;
            for (var i = 0; i < sqlblist.length; i++) {
                if (sqlblist[i].checked) {
                    sqlbtag = 1;
                }
            }
            if (sqlbtag == 0) {
                alert("申请类别未选");
                return false;
            }
            //申请院系
            var sqxy = $$("DropDownList1").options[$$("DropDownList1").selectedIndex].value
            if (sqxy == "请选择院系") {
                alert("申请院系未选");
                return false;
            }
            //申请攻读专业
            var sqzy = $("#txtzy").attr("value");
            if (sqzy == "" || sqzy == "请选择专业") {
                alert("申请攻读专业未选");
                return false;
            }
            //姓名
            var xm = $.trim($("#tb_name").attr("value"));
            if (xm == "") {
                alert("姓名未填");
                return false;
            }
            else {
                var field = /^[\u4E00-\u9FA5]{1,8}$/g;
                if (!field.test(xm)) {
                    alert("姓名只能是少于八个字的简体汉字");
                    return false;
                }
            }
            //性别
            var vRbtid = $$("rbl_xb");
            var vRbtidList = vRbtid.getElementsByTagName("INPUT");
            var xbtag = 0;
            for (var i = 0; i < vRbtidList.length; i++) {
                if (vRbtidList[i].checked) {
                    xbtag = 1;
                }
            }
            if (xbtag == 0) {
                alert("性别未选");
                return false;
            }
            //民族
            var sqxy = $$("DropDownList3").options[$$("DropDownList3").selectedIndex].value
            if (sqxy == "请选择民族") {
                alert("民族未选");
                return false;
            }
            //出生日期
            var csrq = $.trim($("#tb_csrq").attr("value"));
            if (csrq == "") {
                alert("出生日期未选");
                return false;
            }
            //身份证验证
            var str, gender, birthday;
            str = $.trim($("#sfzh").attr("value"));
            if (str == "") {
                alert("身份证号未填");
                return false;
            }
            var sfzfield = /^\d{17}[\d|X]$/g;
            if (!sfzfield.test(str)) {
                alert("身份证号只能是18位数字或者17位数字加大写X");
                return false;
            }


            birthday = $("#tb_csrq").attr("value");

            var vRbtid = $$("rbl_xb");
            var vRbtidList = vRbtid.getElementsByTagName("INPUT");
            for (var i = 0; i < vRbtidList.length; i++) {
                if (vRbtidList[i].checked) {
                    gender = vRbtidList[i].value;
                }
            }
            var idcheck = issfz(str, gender, birthday);
            if (idcheck != 7) {
                if (idcheck == 3 || idcheck == 6) alert("身份证号末位错误，x请大写");
                else alert("身份证号与其它信息不相符"); return false;
            }
            //电话号码验证
            var phonenum = $.trim($("#tb_yddh").attr("value"));
            if (phonenum == "") {
                alert("电话号码未填");
                return false;
            }
            var phonecheck = ismobilephone(phonenum);
            if (phonecheck == false) { alert("手机号不正确"); return false; }
            //电子邮箱
            var mailstr = $.trim($("#tb_dzyx").attr("value"));
            var mailfield = /^\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/g;
            if (mailstr == "") {
                alert("电子邮箱未填");
                return false;
            }
            if (!mailfield.test(mailstr)) {
                alert("电子邮箱格式不正确");
                return false;
            }
            //邮政编码
            var yzbm = $.trim($("#tb_yzbm").attr("value"));
            var yzbmfield = /^\d{6}$/g;
            if (yzbm == "") {
                alert("邮政编码未填");
                return false;
            }
            if (!yzbmfield.test(yzbm)) {
                alert("邮政编码不正确");
                return false;
            }
            //通讯地址
            var txdz = $.trim($("#tb_txdz").attr("value"));
            if (txdz == "") {
                alert("通讯地址未填");
                return false;
            }
            //相片验证
            var photo = $("#lblMessage").html();
            if (photo != "上传成功！") { alert("相片未成功上传"); return false; }
            //本科学校
            var bkxy = $.trim($("#xxxTextBox1").attr("value"));
            if (bkxy == "") {
                alert("本科学校未选");
                return false;
            }
            //本科院系
            var bkyx = $.trim($("#tb_bkyx").attr("value"));
            if (bkyx == "") {
                alert("本科学校未填");
                return false;
            }
            //本科专业
            var bkzy = $.trim($("#tb_bkzy").attr("value"));
            if (bkzy == "") {
                alert("本科学校专业未填");
                return false;
            }
            //本科入校时间
            var rxsj = $.trim($("#Slider1").attr("value"));
            if (rxsj == "") {
                alert("本科入校时间未选");
                return false;
            }
            //本科毕业时间
            var bysj = $.trim($("#Slider2").attr("value"));
            if (bysj == "") {
                alert("本科毕业时间未选");
                return false;
            }
            //英语水平
            var yysp = $.trim($("#tb_yysp").attr("value"));
            if (yysp == "") {
                alert("英语水平未填");
                return false;
            }
            //本科同年级人数
            var njrs = $.trim($("#tb_bkrs").attr("value"));
            var njrsfield = /^\b[1-9]\d{0,4}$/g;
            if (njrs == "") {
                alert("本科同年级人数未填");
                return false;
            }
            if (!njrsfield.test(njrs)) {
                alert("年级人数为5位内非0开头整数");
                return false;
            }
            //本科排名
            var bkpm = $.trim($("#tb_njpm").attr("value"));
            var bkpmfield = /^\b[1-9]\d{0,4}$/g;
            if (bkpm == "") {
                alert("本科排名未填");
                return false;
            }
            if (!bkpmfield.test(bkpm)) {
                alert("本科排名为5位内非0开头整数");
                return false;
            }
            //个人陈述tb_grcs
            var grcs = $.trim($("#tb_grcs").attr("value"));
            if (grcs == "") {
                alert("个人陈述未填");
                return false;
            }
            if (grcs.length < 1000) {
                alert("个人陈述不能少于1000字");
                return false;
            }
            if (grcs.length > 2000) {
                alert("个人陈述不能多于2000字");
                return false;
            }

            return true;
        };
    </script>
</div>
    
   
</body>
</html>
