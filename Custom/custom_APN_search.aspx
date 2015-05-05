<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<title>DB Input Form</title>

<!--#include file="../includes/Header.aspx"-->

</head>

<%
session("StartOverASP")=Request.Url.ToString

dim intTTLLength
intTTLLength=9
Dim Saccounty as string
Saccounty = "SacCounty"
%>


<SCRIPT LANGUAGE='JavaScript' TYPE='text/javascript'>

	function sendAPN(apn1,apn2) {
//		var Value1=apnBook+apnPage+apnParcel+apnSubParcel;
//		var Value2=apn2Book+apn2Page+apn2Parcel+apn2SubParcel;
		var Value1=apn1;
		var Value2=apn2;

		if (Value1.length<1) {
			alert("Please enter a value for APN search field.");
			return false;
		}

		if (Value1.length<4) {
			alert("You must enter at least 4 characters to perform a search.");
			return false;
		}

		top.HaltLYRHide=1;
		top.MapFrame.positionLoadingLyr();

		document.frmAPN.onsubmit="";
		
		var objMC=top.MapFrame.findObj("MapClickedX")
		objMC.value="";

//		top.MapFrame.clearBufUrl(1);

		document.frmAPN.SAfld0.value=Value1;
		if (Value2 != '0000') {
			document.frmAPN.SAfld1.value=Value2;
		}
		
		document.frmAPN.action= '../Custom/custom_APN_search_process.aspx'
		document.frmAPN.submit();
	}
	
	function searchTips() {
		document.location = "parcel_id_tips.aspx";
	}	

	

	function smartfocus (curr,nxt,v) {

		if (curr.value.length>(v-1)) {
			nxt.focus();
		}
	}
</script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>

	<BODY class="colr" LEFTMARGIN="2" TOPMARGIN="0" RIGHTMARGIN="0" onload="top.MapFrame.hideLoadingLyr()">
			
			<table width=100% cellpadding=0 cellspacing=0 border=0 ID="Table3"><tr  class=tblHdr>
			<td align=center><b>APN Search</b></font></td></tr></table>
			<form name="frmAPN" onsubmit="sendAPN(frmAPN.apn1.value,frmAPN.apn2.value)" method=post ID="Form2">
			
			<table>
			<tr>
			<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
			<td><FONT class=SSLbl1>Assessor Parcel Number:</FONT></td>
			</tr>
			<tr>
			<td></td>
			<td><input type=text width=50 name=apn1 value="" ID="Text3"></td>
			</tr>
			<tr>
				<td></td>
				<td><font class="SSMsg2">To: (optional)</font></td>
			</tr>
			<tr>
				<td></td>
				<td><input type=text width=50 name=apn2 value="" ID="Text4"></td>
			</tr>
			<tr>
				<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
				<td><br></td>
			</tr>
			<tr>
				<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
				<td><a href='javascript:searchTips()'>APN Search Tips</a></font></td>
			</tr>
			<tr>
				<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
				<td><br></td>
			</tr>
			 
			<tr>
				<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
				<td><center><input type=submit class=Btn  Value="Search" ID="Submit2" 

NAME="Submit2"></center></td>
			</tr>
			 <br>

			<input type=hidden name=SAfld0 ID="Hidden8">
			<input type=hidden name=SAfld0Opr value=" LIKE " ID="Hidden9">
			<input type=hidden name=SAfld0Name value='APN' ID="Hidden10">

			<input type=hidden name=SAfld1 ID="Hidden11">
			<input type=hidden name=SAfld1Opr value=" LIKE " ID="Hidden12">
			<input type=hidden name=SAfld1Name value='APN' ID="Hidden13">
</form>

</body>
