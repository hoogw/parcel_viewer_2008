<html>
<head>
<title>DB Input Form</title>

<!--#include file="../includes/Header.aspx"-->

</head>

<%
'Important''''''''''''''''''''''''''''''''
session("lyr")="10"
session("Fld_DB")="APN"
session("Fld_SHP")="PARCEL"
session("Fld_DBNAMES")="landusecategory,buildingseqnum,unitseqnum,"
session("ds")="Provider=SQLOLEDB.1; Initial Catalog=Madera;Data Source=localhost;User Id=Madera;Password=Madera"
session("DBTbl")="Parcels"
''''''''''''''''''''''''''''''''''''''''''

session("StartOverASP")=Request.Url.ToString
%>

<body class="colr" leftmargin="5" onload="top.MapFrame.hideLoadingLyr();">

<form name="frmDB" action="test_process.aspx" method=post>

<h4>
Please enter the following information</h4>
<table cellpadding=0 cellspacing=0 border=0 width=90%><tr><td width=30>&nbsp;</td><td width=120><font class=SSLbl1>APN:</font></td><td align=left width=100><select name="SAfld0Opr" style='width:75px;'><OPTION selected value=" = ">=</OPTION><option value=" < ">&lt;</option><option value=" > ">&gt;</option><option value=" <= ">&lt;=</option><option value=" >= ">&gt;=</option><option value=" LIKE ">LIKE</option></td><td align=left><input type=text name="SAfld0" style='width:150px;'></td></tr><input type=hidden name=SAfld0Name value='APN'><input type=hidden name=SAfld0Type value='String'>
<tr><td width=30>&nbsp;</td><td width=120><font class=SSLbl1>landusecategory:</font></td><td align=left width=100><select name="SAfld1Opr" style='width:75px;'><OPTION selected value=" = ">=</OPTION><option value=" < ">&lt;</option><option value=" > ">&gt;</option><option value=" <= ">&lt;=</option><option value=" >= ">&gt;=</option><option value=" LIKE ">LIKE</option></td><td align=left><input type=text name="SAfld1" style='width:150px;'></td></tr><input type=hidden name=SAfld1Name value='landusecategory'><input type=hidden name=SAfld1Type value='String'>
<tr><td width=30>&nbsp;</td><td width=120><font class=SSLbl1>Status:</font></td><td align=left width=100><select name="SAfld2Opr" style='width:75px;'><OPTION selected value=" = ">=</OPTION><option value=" < ">&lt;</option><option value=" > ">&gt;</option><option value=" <= ">&lt;=</option><option value=" >= ">&gt;=</option><option value=" LIKE ">LIKE</option></td><td align=left><input type=text name="SAfld2" style='width:150px;'></td></tr><input type=hidden name=SAfld2Name value='Status'><input type=hidden name=SAfld2Type value='String'>
</table><br><center><input type=button class=Btn onclick='submitit();' Value='Continue'><!---&nbsp;&nbsp;&nbsp;<input type=button class=Btn onclick="document.location='<%=session("StartOverASP")%>'" Value='Start Over'>---></center><br><input type=hidden name=FieldCount value=2>
</form>

<script language="Javascript">
	function submitit() {
if (document.frmDB.SAfld0.value=='' && document.frmDB.SAfld1.value=='' && document.frmDB.SAfld2.value==''  ) {
		alert ("Please fill out at least one of the search fields to proceed.");
		return;
	}
	top.HaltLYRHide=1;
	top.MapFrame.positionLoadingLyr();
	document.frmDB.submit();
	}

</script>

</body>
