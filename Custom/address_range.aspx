<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<title>DB Input Form</title>

<!--#include file="../includes/Header.aspx"-->

</head>

<%
session("StartOverASP")=Request.Url.ToString
%>


<SCRIPT LANGUAGE='JavaScript' TYPE='text/javascript'>
	function submitit() {
			if (document.frmDB.SAfld0.value=='' && document.frmDB.SAfld1.value=='' && document.frmDB.SAfld2.value=='') {
			alert ("Please fill out at least one of the search fields to proceed.");
			document.frmDB.SAfld0.focus();
			return;
		}
		top.HaltLYRHide=1;
		top.MapFrame.positionLoadingLyr();

		document.frmDB.onsubmit="";

		var objMC=top.MapFrame.findObj("MapClickedX")
		objMC.value="";

		

		document.frmDB.action= '../Custom/custom_address_search_process.aspx' //?CS=1&Num1=' + document.frmDB.StreetNumber.value + '&StreetName=' + document.frmDB.StreetName.value + '&ds=Initial+Catalog%3dGIS%3bData+Source%3dPWASQL%3bUser+Id%3dgisuser%3bPassword%3dgisuser'
		document.frmDB.submit();
	}

	function searchTips() {
		document.location = "address_tips.aspx";
	}	
</script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>

	<BODY class="colr" LEFTMARGIN="2" TOPMARGIN="0" RIGHTMARGIN="0" onload="top.MapFrame.hideLoadingLyr()">
			<form name="frmDB" onsubmit="submitit();" method=post>

			<font class="SSHdr1">Please enter the following information</font><br>
			<br>
			<table>
				<tr>
					<td width="40%"><font class="SSLbl1">Start Number:</font></td>
					<td width="60%"><font class="SSLbl1">End Number:</font></td>
				</tr>
				<tr>
					<td><input type="text" name="SAfld0" size="15" value="" ID="Text1"></td>
					<td><input type="text" name="SAfld1" size="24" value="" ID="Text2"></td>
				</tr>
				<tr>
					<td colspan=2><font class="SSLbl1">Street Name:</font></td>
				</tr>
				<tr>
					<td colspan=2><input type="text" name="SAfld2" size="25" value="" ID="Text1"></td>
				</tr>
				<tr>
					<td colspan="2" align="left"><font class="SSMsg2"><a href='javascript:searchTips()'>Address 
								Search Tips</a></font></td>
				</tr>
				<tr>
					<td colspan="2" align="center"><br>
						<input type=image src="../images/<%=Application("ColourScheme")%>b_submit.gif" alt="Submit" border=0></a>
					</td>
				</tr>
			</table>
			<br>

			<input type=hidden name=SAfld0Opr value=" LIKE ">
			<input type=hidden name=SAfld0Name value='STREET_NBR'>
			<input type=hidden name=SAfld0Type value='String'>

			<input type=hidden name=SAfld1Opr value=" LIKE ">
			<input type=hidden name=SAfld1Name value='STREET_NBR'>
			<input type=hidden name=SAfld1Type value='String'>

			<input type=hidden name=SAfld2Opr value=" LIKE ">
			<input type=hidden name=SAfld2Name value='STREET_NAM'>
			<input type=hidden name=SAfld2Type value='String'>

			<input type=hidden name=FieldCount value=1>
</form>


</body>
