<!--#include file="AspCms_AdminGroupFun.asp" -->
<%CheckAdmin("AspCms_AdminGroupList.asp")%>
<%getAdminGroup%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3c.org/TR/1999/REC-html401-19991224/loose.dtd">
<HTML xmlns="http://www.w3.org/1999/xhtml"><HEAD><TITLE></TITLE>
<META http-equiv=Content-Type content="text/html; charset=utf-8">
<LINK href="../../images/style.css" type=text/css rel=stylesheet>
<script type="text/javascript" src="../../js/jquery.min.js"></script>
<script type="text/javascript" src="../../js/jquery.tinyTips.js"></script>
<script type="text/javascript">
		$(document).ready(function() {
			$('a.tTip').tinyTips('title');
			$('a.imgTip').tinyTips('title');
			$('img.tTip').tinyTips('title');
			$('h1.tagline').tinyTips('tinyTips are totally awesome!');
		});
		</script>
<link rel="stylesheet" type="text/css" media="screen" href="../../css/tinyTips.css" />
</HEAD>
<BODY>
<FORM name="form" action="?action=editg" method="post" >
<DIV class=formzone>
<DIV class=namezone>编辑管理员组</DIV>
<DIV class=tablezone>
<DIV class=noticediv id=notice></DIV>
<TABLE cellSpacing=0 cellPadding=2 width="100%" align=center border=0>
  <TBODY>
  <TR>
    <TD align=middle width=100 height=30>组名称</TD>
    <TD height=30><INPUT class="input" style="FONT-SIZE: 12px; WIDTH: 300px" maxLength="200" name="GroupName" value="<%=GroupName%>"/> <FONT color=#ff0000>*</FONT>  <img src="../../images/help.gif" class="tTip" title="权限组的分类名称"></TD>
  </TR>
  <TR>
    <TD align=middle width=100 height=30>组描述</TD>
    <TD height=30><TEXTAREA class="textarea" style="FONT-SIZE: 12px; WIDTH: 450px" name="GroupDesc" rows="3"><%=GroupDesc%></TEXTAREA> 
</TD>
</TR>
  <TR>
    <TD align=middle width=100 height=30>组状态</TD>
    <TD height=30><INPUT class="checkbox" type="checkbox" name="GroupStatus" <% if GroupStatus=1 then echo"checked=""checked"""%> value="1"/></TD></TR>
  <TR>
    <TD align=middle width=100 height=30>组权限值</TD>
    <TD height=30><input class="input" size="11"  name="GroupMark" value="<%=GroupMark%>"/>    
    </TD></TR>
  <TR>
    <TD align=middle width=100 height=30>排序</TD>
    <TD height=30><input class="input" size=11 name="GroupOrder" value="<%=GroupOrder%>"/></TD></TR>
  <TR>
    <TD align=middle height=30>组权限</TD>
    <TD height=30>
<%
dim rs,subrs
set rs=conn.exec("select MenuID, MenuName, (select Count(*) from {prefix}Menu as b where MenuStatus=1 and b.ParentID=a.MenuID ) from {prefix}Menu as a where MenuStatus=1 and ParentID=0 order by MenuOrder","r1")

do while not rs.eof 
	echo "<INPUT class=""checkbox"" type=""checkbox"" "&groupMenuChecked(GroupMenu, rs(0))&"  name=""GroupMenu"" value="""&rs(0)&"""/><strong>"&rs(1)& vbcrlf
	echo "</strong><br/>"& vbcrlf
'	echo rs(0)&""& rs(1)&"<Br>&nbsp;&nbsp;"
	set subrs=conn.exec("select MenuID, MenuName from {prefix}Menu where MenuStatus=1 and ParentID="&rs(0)&" order by MenuOrder","r1")
		do while not subrs.eof
			'echo subrs(0)&""& subrs(1)&"  "
			echo "<INPUT class=""checkbox"" type=""checkbox"" "&groupMenuChecked(GroupMenu, subrs(0))&" name=""GroupMenu"" value="""&subrs(0)&"""/>"&subrs(1)& vbcrlf		
			subrs.moveNext
		loop	
	rs.moveNext
	echo "<br/>"& vbcrlf
loop


%>
     <img src="../../images/help.gif" class="tTip" title="该管理组所具有的管理权限，属于该管理组的管理员可管理以上被勾选的选项">
    </TD></TR></TBODY></TABLE>
</DIV>
<DIV class=adminsubmit>
<input type="hidden" size="11"  name="GroupID" value="<%=GroupID%>"/>    
<INPUT class="button" type="submit" value="修改" />
<INPUT class="button" type="button" value="返回" onClick="history.go(-1)"/> 
<INPUT onClick="location.href='<%=getPageName()%>?id=<%=GroupID%>'" type="button" value="刷新" class="button" /> 
</DIV></DIV></FORM>
</BODY></HTML>