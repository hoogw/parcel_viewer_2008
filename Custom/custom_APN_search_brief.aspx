<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<title>DB Input Form</title>

<!--#include file="../includes/header.aspx"-->

</head>

<%
session("StartOverASP")=Request.Url.ToString

dim intTTLLength
intTTLLength=14
%>


<SCRIPT LANGUAGE='JavaScript' TYPE='text/javascript'>

	function sendAPN(apnBook,apnPage,apnParcel,apnSubParcel,apn2Book,apn2Page,apn2Parcel,apn2SubParcel) {
		var Value1=apnBook+apnPage+apnParcel+apnSubParcel;
		var Value2=apn2Book+apn2Page+apn2Parcel+apn2SubParcel;

		if (Value1.length<<%=intTTLLength%>) {
			alert("Please verify that all of the required fields are completed for the first APN.");
			return;
		}

		top.HaltLYRHide=1;
		top.MapFrame.positionLoadingLyr();

		//document.frmAPN.onsubmit="";
		
		var objMC=top.MapFrame.findObj("MapClickedX")
		objMC.value="";

		document.frmAPN.SAfld0.value=Value1;
		if (Value2 != '0000') {
			document.frmAPN.SAfld1.value=Value2;
		}
		
		document.frmAPN.action='custom_APN_search_process.aspx?a=1'
		document.frmAPN.target="PDetails";
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
			<form name="frmAPN" onsubmit="sendAPN(frmAPN.apnBook.value,frmAPN.apnPage.value,frmAPN.apnParcel.value,frmAPN.apnSubParcel.value,frmAPN.apn2Book.value,frmAPN.apn2Page.value,frmAPN.apn2Parcel.value,frmAPN.apn2SubParcel.value)" method=post>

			<font class="SSMsg2">APN:</font><br>
			<%on error resume next%>
			<table cellpadding=0 cellspacing=0 border=0>
			<tr>
			<td>
			<input tabindex=1 type="text" name="apnBook" size="3" value="<%=mid(session("apn"),1,3)%>" maxlength="3" onkeyup="smartfocus(this,apnPage,3);" >
			--<input tabindex=2 type="text" name="apnPage" size="4" value="<%=mid(session("apn"),4,4)%>" maxlength="4" onkeyup="smartfocus(this,apnParcel,4);" >
			--<input tabindex=4 type="text" name="apnParcel" size="3" value="<%=mid(session("apn"),8,3)%>" maxlength="3" onkeyup="smartfocus(this,apnSubParcel,3);" >
			--<input tabindex=6 type="text" name="apnSubParcel" size="4" maxlength="4" value="<%=mid(session("apn"),11)%>">
			</td><td>&nbsp;</td><td><input tabindex=16 type=submit class=Btn  Value="Submit"></td>
			</tr>
			</table>

			<input type=hidden name="apn2Book" value="">
			<input type=hidden name="apn2Page" value="">
			<input type=hidden name="apn2Parcel" value="">
			<input type=hidden name="apn2SubParcel" value="">

			

			<input type=hidden name=SAfld0>
			<input type=hidden name=SAfld0Name value='APN'>

			<input type=hidden name=SAfld1>
			<input type=hidden name=SAfld1Name value='APN'>
</form>
</body>
