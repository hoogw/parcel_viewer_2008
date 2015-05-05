<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<title>DB Input Form</title>

<!--#include file="../includes/Header.aspx"-->

</head>

<%
session("StartOverASP")=Request.Url.ToString
%>

<SCRIPT LANGUAGE='JavaScript' TYPE='text/javascript' src="trim.js"></script>

<SCRIPT LANGUAGE='JavaScript' TYPE='text/javascript'>
	function submitit() {

		if (trim(document.frmDB.SAfld0.value)=='' && trim(document.frmDB.SAfld1.value)=='') {
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
			
			<table width=100% cellpadding=0 cellspacing=0 border=0 ID="Table3"><tr  class=tblHdr>
			<td align=center><b>Address Search</b></font></td></tr></table>
			<br>
			<table>
				<tr>
					<td></td>
					<td><font class="SSMsg2"><font class="SSLbl1">Street Number:</font></font></td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td><input tabindex=1 type="text" name="SAfld0" size="14" value="<%=Application("DefaultAddressNum")%>" ID="Text1"></td>
				</tr>
				<tr>
					<td></td>
					<td><font class="SSMsg2"><font class="SSLbl1">Street Name:</font></font></td>
				</tr>
				<tr>
					<td></td>
					<td><input tabindex=2 type="text" name="SAfld1" size="21" value="<%=Application("DefaultAddressStreet")%>" ID="Text2"></td>
				</tr>
				<tr>
					<td></td>
					<td><br></td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td><a href='javascript:searchTips()'>Address Search Tips</a></font></td>
				</tr>
				
				<tr>
					<td colspan="2" align="center"><br>
						<input  tabindex=3 type=submit class=Btn  Value="Submit">
					</td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td></td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td style='color:red'>To search by an Address range, <a href="custom_address_range_search.aspx">click 					here</a></td>
				</tr>
<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td></td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td class="SSMsg2"><b>Note: </b>Do NOT enter Street Direction (E,W,N,S) or Street 
				Suffix (St., Ave., Blvd., etc.). A list of potential matches will be displayed.</td>
				</tr>
			</table>
			<br>
			

			<input type=hidden name=SAfld0Opr value=" LIKE ">
			<input type=hidden name=SAfld0Name value='STREET_NBR'>
			<input type=hidden name=SAfld0Type value='String'>

			<input type=hidden name=SAfld1Opr value=" LIKE ">
			<input type=hidden name=SAfld1Name value='STREET_NAM'>
			<input type=hidden name=SAfld1Type value='String'>
			<input type=hidden name=FieldCount value=1>
</form>


</body>
