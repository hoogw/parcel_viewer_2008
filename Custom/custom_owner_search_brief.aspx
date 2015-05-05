<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<title>DB Input Form</title>

<!--#include file="../includes/header.aspx"-->

</head>

<%
'Important''''''''''''''''''''''''''''''''
session("Fld_SHP")="APN"
session("Fld_Disp")="0,1,2,3,"
'session("ds")="Provider=SQLOLEDB.1;" & Application("dbSource")
session("ds")="Provider=SQLOLEDB.1; Initial Catalog=ParcelAttributeDB;Server=sql2;User Id=gis;Password=gis;pooling=false;connection timeout=120;"
session("DBTbl")="Parcels"
''''''''''''''''''''''''''''''''''''''''''
%>


<SCRIPT LANGUAGE='JavaScript' TYPE='text/javascript' src="trim.js"></script>
<SCRIPT LANGUAGE='JavaScript' TYPE='text/javascript'>
	function submitit() {
			if (trim(document.frmDB.SAfld0.value)=='') {
			alert ("Please fill out at least one of the search fields to proceed.");
			document.frmDB.SAfld0.focus();
			return;
		}
		top.HaltLYRHide=1;
		top.MapFrame.positionLoadingLyr();

		document.frmDB.onsubmit="";

		var objMC=top.MapFrame.findObj("MapClickedX")
		objMC.value="";

		document.frmDB.action= 'custom_owner_search_process.aspx?a=1'
		document.frmDB.target="PDetails";
		document.frmDB.submit();
	}

	function searchTips() {
		document.location = "owner_tips.aspx";
	}	
</script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>

	<BODY class="colr" LEFTMARGIN="2" TOPMARGIN="0" RIGHTMARGIN="0" onload="top.MapFrame.hideLoadingLyr()">
			<form name="frmDB" onsubmit="submitit();" method=post>
			<table>
				<tr>
					<td width="35%"><font class="SSLbl1">Owner</font></td>
					<td width="55%"><font class="SSLbl1">&nbsp;</font></td>
					<td width="10%">&nbsp;</td>
				</tr>
				<tr>
					<td colspan=2><input tabindex=1 type="text" name="SAfld0" size="40" value="<%=session("o")%>" ID="Text1"></td>
					<td align=left><input tabindex=2 type=submit class=Btn  Value="Submit"></td>
				</tr>
			</table>
			<br>
			<font class="SSMsg2">Note: Enter the owner last name (or the first few letters). If you wish to be more specific, enter the last name followed by a space, then the first name or first initial. A list of potential matches will be displayed. </font><br>
			<br>
			<input type=hidden name=SAfld0Opr value=" LIKE ">
			<input type=hidden name=SAfld0Name value='[owner]'>
			<input type=hidden name=SAfld0Type value='String'>
</form>


</body>
