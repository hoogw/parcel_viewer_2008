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

<form name="frmDB" action="service_request_process.aspx" method=post target=_new>

<font class='SSHdr2'>
Please enter the following information</font><br><br>
<table cellpadding=0 cellspacing=0 border=0 width=90%><tr><td width=30>&nbsp;</td><td width=120><font class=SSLbl1>Service Request #:</font></td><td align=left width=100><select name="SAfld0Opr" style='width:75px;'><OPTION value=" = ">=</OPTION><option value=" < ">&lt;</option><option value=" > ">&gt;</option><option value=" <= ">&lt;=</option><option value=" >= ">&gt;=</option><option value=" LIKE " selected>LIKE</option></td><td align=left><input type=text name="SAfld0" style='width:100px;'></td></tr><input type=hidden name=SAfld0Name value='RequestID'><input type=hidden name=SAfld0Type value='String'>
</table><br><center><input type=button class=Btn onclick='submitit();' Value='Continue'><!---&nbsp;&nbsp;&nbsp;<input type=button class=Btn onclick="document.location='<%=session("StartOverASP")%>'" Value='Start Over'>---></center><br><input type=hidden name=FieldCount value=1>
</form>

<SCRIPT LANGUAGE='JavaScript' TYPE='text/javascript'>
	function submitit() {
if (document.frmDB.SAfld0.value==''  ) {
		alert ("Please fill out at least one of the search fields to proceed.");
		return;
	}
	top.HaltLYRHide=1;
	top.MapFrame.positionLoadingLyr();
	document.frmDB.submit();
	}

</script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>

</body>
