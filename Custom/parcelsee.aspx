<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<title>DB Input Form</title>

<!--#include file="../includes/Header.aspx"-->

</head>

<%
session("StartOverASP")=Request.Url.ToString
%>

<body class="colr" leftmargin="5" onload="top.MapFrame.hideLoadingLyr();">

<form name="frmDB" action="parcelsee_process.aspx" method=post>

<h4>
Please enter the following information</h4>
<table cellpadding=0 cellspacing=0 border=0 width=90%><tr><td width=30>&nbsp;</td><td width=120><font class=SSLbl1>CNTYAP_NBR:</font></td><td align=left width=100><select name="SAfld0Opr" style='width:75px;'><OPTION selected value=" = ">=</OPTION><option value=" < ">&lt;</option><option value=" > ">&gt;</option><option value=" <= ">&lt;=</option><option value=" >= ">&gt;=</option><option value=" LIKE ">LIKE</option></td><td align=left><input type=text name="SAfld0" style='width:150px;'></td></tr><input type=hidden name=SAfld0Name value='CNTYAP_NBR'><input type=hidden name=SAfld0Type value='String'>
<tr><td width=30>&nbsp;</td><td width=120><font class=SSLbl1>EE_FLAG:</font></td><td align=left width=100><select name="SAfld1Opr" style='width:75px;'><OPTION selected value=" = ">=</OPTION><option value=" < ">&lt;</option><option value=" > ">&gt;</option><option value=" <= ">&lt;=</option><option value=" >= ">&gt;=</option><option value=" LIKE ">LIKE</option></td><td align=left><input type=text name="SAfld1" style='width:150px;'></td></tr><input type=hidden name=SAfld1Name value='EE_FLAG'><input type=hidden name=SAfld1Type value='String'>
</table><br><center><a href='javascript:submitit();'><img src='../images/1b_continue.gif' border=0></a><!---&nbsp;&nbsp;&nbsp;<a href='<%=session("StartOverASP")%>'><img src='../images/1b_startover.gif' border=0></a>---></center><br><input type=hidden name=FieldCount value=1>
</form>

<SCRIPT LANGUAGE='JavaScript' TYPE='text/javascript'>
	function submitit() {
if (document.frmDB.SAfld0.value=='' && document.frmDB.SAfld1.value==''  ) {
		alert ("Please fill out at least one of the search fields to proceed.");
		return;
	}
	top.HaltLYRHide=1;
	top.MapFrame.positionLoadingLyr();
	document.frmDB.submit();
	}

</script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>

</body>
