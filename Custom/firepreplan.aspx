<html>
<head>
<title>DB Input Form</title>

<!--#include file="../includes/Header.aspx"-->

</head>

<%
'Important''''''''''''''''''''''''''''''''
session("lyr")="2"
session("Fld_DB")="APN"
session("Fld_SHP")="APN"
session("Fld_DBNAMES")="APN,APNLINK,FIRST,SECOND,LAST,ADDR_NUMBE,ADDRESSPRP,POLICE_DIS,ZIPCODE,CITYPROP,STATEPROP,OWNERNAME1,OWNERNAME2,PREPLAN,PREPLAN_1,PREPLAN_2,PREPLAN_3,"
session("ds")="Provider=SQLOLEDB.1;Initial Catalog=costamesa;Server=actgis6;User Id=costamesa;Password=CostaMesa"
session("DBTbl")="fire"
''''''''''''''''''''''''''''''''''''''''''

session("StartOverASP")=Request.Url.ToString
%>

<body class="colr" leftmargin="5" onload="top.MapFrame.hideLoadingLyr();">

<form name="frmDB" action="firepreplan_process.aspx" method=post>

<h4>
Please enter the following information</h4>
<table cellpadding=0 cellspacing=0 border=0 width=90%><tr><td width=30>&nbsp;</td><td width=120><font class=SSLbl1>ADDRESSPRP:</font></td><td align=left width=100><select name="SAfld0Opr" style='width:75px;'><OPTION selected value=" = ">=</OPTION><option value=" < ">&lt;</option><option value=" > ">&gt;</option><option value=" <= ">&lt;=</option><option value=" >= ">&gt;=</option><option value=" LIKE ">LIKE</option></td><td align=left><input type=text name="SAfld0" style='width:150px;'></td></tr><input type=hidden name=SAfld0Name value='ADDRESSPRP'><input type=hidden name=SAfld0Type value='String'>
<tr><td width=30>&nbsp;</td><td width=120><font class=SSLbl1>POLICE_DIS:</font></td><td align=left width=100><select name="SAfld1Opr" style='width:75px;'><OPTION selected value=" = ">=</OPTION><option value=" < ">&lt;</option><option value=" > ">&gt;</option><option value=" <= ">&lt;=</option><option value=" >= ">&gt;=</option><option value=" LIKE ">LIKE</option></td><td align=left><input type=text name="SAfld1" style='width:150px;'></td></tr><input type=hidden name=SAfld1Name value='POLICE_DIS'><input type=hidden name=SAfld1Type value='String'>
<tr><td width=30>&nbsp;</td><td width=120><font class=SSLbl1>ZIPCODE:</font></td><td align=left width=100><select name="SAfld2Opr" style='width:75px;'><OPTION selected value=" = ">=</OPTION><option value=" < ">&lt;</option><option value=" > ">&gt;</option><option value=" <= ">&lt;=</option><option value=" >= ">&gt;=</option><option value=" LIKE ">LIKE</option></td><td align=left><input type=text name="SAfld2" style='width:150px;'></td></tr><input type=hidden name=SAfld2Name value='ZIPCODE'><input type=hidden name=SAfld2Type value='String'>
<tr><td width=30>&nbsp;</td><td width=120><font class=SSLbl1>OWNERNAME1:</font></td><td align=left width=100><select name="SAfld3Opr" style='width:75px;'><OPTION selected value=" = ">=</OPTION><option value=" < ">&lt;</option><option value=" > ">&gt;</option><option value=" <= ">&lt;=</option><option value=" >= ">&gt;=</option><option value=" LIKE ">LIKE</option></td><td align=left><input type=text name="SAfld3" style='width:150px;'></td></tr><input type=hidden name=SAfld3Name value='OWNERNAME1'><input type=hidden name=SAfld3Type value='String'>
<tr><td width=30>&nbsp;</td><td width=120><font class=SSLbl1>PREPLAN:</font></td><td align=left width=100><select name="SAfld4Opr" style='width:75px;'><OPTION selected value=" = ">=</OPTION><option value=" < ">&lt;</option><option value=" > ">&gt;</option><option value=" <= ">&lt;=</option><option value=" >= ">&gt;=</option><option value=" LIKE ">LIKE</option></td><td align=left><input type=text name="SAfld4" style='width:150px;'></td></tr><input type=hidden name=SAfld4Name value='PREPLAN'><input type=hidden name=SAfld4Type value='String'>
<tr><td width=30>&nbsp;</td><td width=120><font class=SSLbl1>PREPLAN_1:</font></td><td align=left width=100><select name="SAfld5Opr" style='width:75px;'><OPTION selected value=" = ">=</OPTION><option value=" < ">&lt;</option><option value=" > ">&gt;</option><option value=" <= ">&lt;=</option><option value=" >= ">&gt;=</option><option value=" LIKE ">LIKE</option></td><td align=left><input type=text name="SAfld5" style='width:150px;'></td></tr><input type=hidden name=SAfld5Name value='PREPLAN_1'><input type=hidden name=SAfld5Type value='String'>
<tr><td width=30>&nbsp;</td><td width=120><font class=SSLbl1>PREPLAN_2:</font></td><td align=left width=100><select name="SAfld6Opr" style='width:75px;'><OPTION selected value=" = ">=</OPTION><option value=" < ">&lt;</option><option value=" > ">&gt;</option><option value=" <= ">&lt;=</option><option value=" >= ">&gt;=</option><option value=" LIKE ">LIKE</option></td><td align=left><input type=text name="SAfld6" style='width:150px;'></td></tr><input type=hidden name=SAfld6Name value='PREPLAN_2'><input type=hidden name=SAfld6Type value='String'>
<tr><td width=30>&nbsp;</td><td width=120><font class=SSLbl1>PREPLAN_3:</font></td><td align=left width=100><select name="SAfld7Opr" style='width:75px;'><OPTION selected value=" = ">=</OPTION><option value=" < ">&lt;</option><option value=" > ">&gt;</option><option value=" <= ">&lt;=</option><option value=" >= ">&gt;=</option><option value=" LIKE ">LIKE</option></td><td align=left><input type=text name="SAfld7" style='width:150px;'></td></tr><input type=hidden name=SAfld7Name value='PREPLAN_3'><input type=hidden name=SAfld7Type value='String'>
</table><br><center><input type=button class=Btn onclick='submitit();' Value='Continue'><!---&nbsp;&nbsp;&nbsp;<input type=button class=Btn onclick="document.location='<%=session("StartOverASP")%>'" Value='Start Over'>---></center><br><input type=hidden name=FieldCount value=7>
</form>

<script language="Javascript">
	function submitit() {
if (document.frmDB.SAfld0.value=='' && document.frmDB.SAfld1.value=='' && document.frmDB.SAfld2.value=='' && document.frmDB.SAfld3.value=='' && document.frmDB.SAfld4.value=='' && document.frmDB.SAfld5.value=='' && document.frmDB.SAfld6.value=='' && document.frmDB.SAfld7.value==''  ) {
		alert ("Please fill out at least one of the search fields to proceed.");
		return;
	}
	top.HaltLYRHide=1;
	top.MapFrame.positionLoadingLyr();
	document.frmDB.submit();
	}

</script>

</body>
