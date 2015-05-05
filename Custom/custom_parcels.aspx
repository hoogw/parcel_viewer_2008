<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<title>DB Input Form</title>

<!--#include file="../includes/Header.aspx"-->

</head>

<%
'Important''''''''''''''''''''''''''''''''
session("lyr")="id_parcels"
session("Fld_DB")="APN"
session("Fld_SHP")="APN"
session("Fld_DBNAMES")="ADDRESS_ID,APN,PREFIX_TYPE,PREFIX_DIR,ST_NUMBER,ST_NAME,ST_TYPE,SUFFIX_DIR,CITY,ZIP,FULL_ADDRESS,ADDR_FRACTION,UNIT_DESIGNATION,UNIT,FLOOR,BUILDING,ADDRESS_TYPE,X_COORD,Y_COORD,DATE_ENTERED,DATE_UPDATED,DATE_RETIRED,SOURCE,BUS_LIC_FLAG,SERC_REQ_FLAG,PROJECT_FLAG,PERMIT_FLAG,ZIP4_FLAG,COORD_SOURCE,"
session("ds")="Provider=SQLOLEDB.1; Initial Catalog=MasterAddressDB;Server=sql2;User Id=gis;Password=gis;pooling=false;connection timeout=120;"
session("DBTbl")="MAD"
''''''''''''''''''''''''''''''''''''''''''

session("StartOverASP")=Request.Url.ToString
%>
<script language='JavaScript' type='text/javascript'>
var undef, prefix, prefixTop
if (top.opener!=undef){prefix=top.opener.top.MapFrame; }else{if (opener==undef) {prefix=top.MapFrame;}else{prefix=opener.top.MapFrame;}}
prefixTop=top.opener.top;
</script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>

<body class="colr" leftmargin="5" onload="prefix.hideLoadingLyr();">

<form name="frmDB" action="custom_parcels_process.aspx" method=post>

<h4>
Please enter the following information</h4>
<table cellpadding=0 cellspacing=0 border=0 width=90%><tr><td width=30>&nbsp;</td><td width=120><font class=SSLbl1>APN:</font></td><td align=left width=100><select name="SAfld0Opr" style='width:75px;'><OPTION selected value=" = ">=</OPTION><option value=" < ">&lt;</option><option value=" > ">&gt;</option><option value=" <= ">&lt;=</option><option value=" >= ">&gt;=</option><option value=" LIKE ">LIKE</option></td><td align=left><input type=text name="SAfld0" style='width:150px;'></td></tr><input type=hidden name=SAfld0Name value='APN'><input type=hidden name=SAfld0Type value='String'>
</table><br><center><input type=button class=Btn onclick='submitit();' Value='Continue'><!---&nbsp;&nbsp;&nbsp;<input type=button class=Btn onclick="document.location='<%=session("StartOverASP")%>'" Value='Start Over'>---></center><br><input type=hidden name=FieldCount value=0>
</form>

<SCRIPT LANGUAGE='JavaScript' TYPE='text/javascript'>
	function submitit() {
if (document.frmDB.SAfld0.value==''  ) {
		alert ("Please fill out at least one of the search fields to proceed.");
		return;
	}
	prefixTop.HaltLYRHide=1;
	prefix.positionLoadingLyr();
	document.frmDB.submit();
	}

</script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>

</body>
