<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<title>DB Input Form</title>

<!--#include file="../includes/Header.aspx"-->

</head>

<%
'Important''''''''''''''''''''''''''''''''
session("lyr")="id_permits"
session("Fld_DB")="PERMIT_NUMBER"
session("Fld_SHP")="PERMITNUMB"
session("Fld_DBNAMES")="APPLICATION_NUMBER,PERMIT_NUMBER,PROJECT,APN,PERMIT_STATUS,TOTAL_FEE,VALUATION,APPLICATION_DATE,ISSUED_DATE,FINALED_DATE,WORK_TYPE,WORK_DESCRIPTION,RES_COMM,ADDRESS_ID,PREFIX_TYPE,PREFIX_DIR,ST_NUMBER,ST_NAME,ST_TYPE,SUFFIX_DIR,CITY,ZIP,FULL_ADDRESS,ADDR_FRACTION,UNIT_DESIGNATION,UNIT,FLOOR,BUILDING,"
session("ds")="Provider=SQLOLEDB.1;Initial Catalog=PermitSQL;Server=sql2;User Id=gis;Password=gis;pooling=false;connection timeout=120;"
session("DBTbl")="PermitSQL"
''''''''''''''''''''''''''''''''''''''''''

session("StartOverASP")=Request.Url.ToString
%>
<script language='JavaScript' type='text/javascript'>
var undef, prefix, prefixTop
if (top.opener!=undef){prefix=top.opener.top.MapFrame; }else{if (opener==undef) {prefix=top.MapFrame;}else{prefix=opener.top.MapFrame;}}
prefixTop=top;
</script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>

<body class="colr" leftmargin="5" onload="prefix.hideLoadingLyr();">

<form name="frmDB" action="custom_permits_process.aspx" method=post target=_new>

<font class='sshdr1'>
Please enter the following information</font><br><br>
<table cellpadding=0 cellspacing=0 border=0 width=90%>
<tr><td width=30>&nbsp;</td><td width=120><font class=SSLbl1>Permit #:</font></td><td align=left width=100><select name="SAfld0Opr" style='width:75px;'><OPTION selected value=" = ">=</OPTION><option value=" < ">&lt;</option><option value=" > ">&gt;</option><option value=" <= ">&lt;=</option><option value=" >= ">&gt;=</option><option value=" LIKE ">LIKE</option></td><td align=left><input type=text name="SAfld0" style='width:100px;'></td></tr>
<input type=hidden name=SAfld0Name value='PERMIT_NUMBER'><input type=hidden name=SAfld0Type value='String'>
<tr><td width=30>&nbsp;</td><td width=120><font class=SSLbl1>Type:</font></td><td align=left width=100><select name="SAfld1Opr" style='width:75px;'><OPTION selected value=" = ">=</OPTION><option value=" < ">&lt;</option><option value=" > ">&gt;</option><option value=" <= ">&lt;=</option><option value=" >= ">&gt;=</option><option value=" LIKE ">LIKE</option></td><td align=left><input type=text name="SAfld1" style='width:100px;'></td></tr>
<input type=hidden name=SAfld1Name value='WORK_DESCRIPTION'><input type=hidden name=SAfld1Type value='String'>

<tr><td width=30>&nbsp;</td><td width=120><font class=SSLbl1>Date:</font></td><td align=left width=100><select name="SAfld2Opr" style='width:75px;'><OPTION selected value=" = ">=</OPTION><option value=" < ">&lt;</option><option value=" > ">&gt;</option><option value=" <= ">&lt;=</option><option value=" >= ">&gt;=</option><option value=" LIKE ">LIKE</option></td><td align=left><input type=text name="SAfld2" style='width:100px;'></td></tr>
<input type=hidden name=SAfld2Name value='ISSUED_DATE'><input type=hidden name=SAfld2Type value='String'>
<tr><td width=30>&nbsp;</td><td width=120><font class=SSLbl1>Status:</font></td><td align=left width=100><select name="SAfld3Opr" style='width:75px;'><OPTION selected value=" = ">=</OPTION><option value=" < ">&lt;</option><option value=" > ">&gt;</option><option value=" <= ">&lt;=</option><option value=" >= ">&gt;=</option><option value=" LIKE ">LIKE</option></td><td align=left><input type=text name="SAfld3" style='width:100px;'></td></tr>
<input type=hidden name=SAfld3Name value='PERMIT_STATUS'><input type=hidden name=SAfld3Type value='String'>

</table><br><center><input type=button class=Btn onclick='submitit();' Value='Continue'><!---&nbsp;&nbsp;&nbsp;<input type=button class=Btn onclick="document.location='<%=session("StartOverASP")%>'" Value='Start Over'>---></center><br><input type=hidden name=FieldCount value=1>
<input type=hidden name=SA value=1>
</form>

<SCRIPT LANGUAGE='JavaScript' TYPE='text/javascript'>
	function submitit() {
if (document.frmDB.SAfld0.value=='' && document.frmDB.SAfld1.value==''  ) {
		alert ("Please fill out at least one of the search fields to proceed.");
		return;
	}
	prefixTop.HaltLYRHide=1;
	prefix.positionLoadingLyr();
	document.frmDB.submit();
	}

</script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>

</body>
