<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<title>DB Input Form</title>

<!--#include file="../includes/Header.aspx"-->

</head>

<%
session("StartOverASP")=Request.Url.ToString
%>

<script language='JavaScript' type='text/javascript'>
var undef, prefix
if (top.opener!=undef){prefix=top.opener.top.MapFrame;}else{if (opener==undef) {prefix=top.MapFrame;}else{prefix=opener.top.MapFrame;}}
</script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>

<SCRIPT LANGUAGE='JavaScript' TYPE='text/javascript' src="trim.js"></script>
<SCRIPT LANGUAGE='JavaScript' TYPE='text/javascript'>
	function submitit() {
			if (trim(document.frmDB.SAfld0.value)=='') {
			alert ("Please fill out at least one of the search fields to proceed.");
			document.frmDB.SAfld0.focus();
			return;
		}
		top.HaltLYRHide=1;
		prefix.positionLoadingLyr();

		document.frmDB.onsubmit="";

		var objMC=prefix.findObj("MapClickedX")
		objMC.value="";

		

		document.frmDB.action= '../Custom/custom_owner_search_process.aspx' //?CS=1&Num1=' + document.frmDB.StreetNumber.value + '&StreetName=' + document.frmDB.StreetName.value + '&ds=Initial+Catalog%3dGIS%3bData+Source%3dPWASQL%3bUser+Id%3dgisuser%3bPassword%3dgisuser'
		document.frmDB.submit();
	}

	function searchTips() {
		document.location = "owner_tips.aspx";
	}	
</script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>

	<BODY class="colr" LEFTMARGIN="2" TOPMARGIN="0" RIGHTMARGIN="0" onload="prefix.hideLoadingLyr()">
			<form name="frmDB" onsubmit="submitit();" method=post>

<table width=100% cellpadding=0 cellspacing=0 border=0 ID="Table3"><tr class=tblHdr>
			<td align=center><b>Owner Search</b></font></td></tr></table>
<br><bR>
			<table>
				<tr>
					<td></td>
					<td><font class="SSMsg2"><font class="SSLbl1">Owner Name</font></font></td>
				</tr>
                                 <tr>
					<td></td>
					<td><font class="SSMsg2"><input tabindex=1 type="text" name="SAfld0" size="35" value="<%=Application("DefaultOwner")%>" ID="Text1"></td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;</td>
					<td></td>
				</tr>
				<tr>
					<td></td>
					<td><font class="SSMsg2"><a 					href='javascript:searchTips()'>Owner 
								Search Tips</a></font></td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;</td>
					<td></td>
				</tr>
				<tr>
					<td colspan="2" align="center"><br>
						<input tabindex=2 type=submit class=Btn  Value="Submit">
					</td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;</td>
					<td></td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td class="SSMsg2"><b>Note: </b>Do NOT enter Street Direction (E,W,N,S) or Street 
				Suffix (St., Ave., Blvd., etc.). A list of potential matches will be displayed.</td>
				</tr>
			</table>
			<br>
			
			<br>
			<input type=hidden name=SAfld0Opr value=" LIKE ">
			<input type=hidden name=SAfld0Name value='[owner]'>
			<input type=hidden name=SAfld0Type value='String'>
</form>


</body>
