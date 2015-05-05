<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<title>DB Input Form</title>

<!--#include file="../includes/header.aspx"-->

</head>

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

		//document.frmDB.onsubmit="";

		var objMC=top.MapFrame.findObj("MapClickedX")
		objMC.value="";

		document.frmDB.action= 'custom_address_search_process.aspx?a=1'
		document.frmDB.target="PDetails";
		document.frmDB.submit();
	}

	function searchTips() {
		document.location = "address_tips.aspx";
	}	
</script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>

	<BODY class="colr" LEFTMARGIN="2" TOPMARGIN="0" RIGHTMARGIN="0" onload="top.MapFrame.hideLoadingLyr()">
			<form name="frmDB" onsubmit="submitit();" method=post>

			<table>
				<tr>
					<td width="35%"><font class="SSLbl1">Street Number:</font></td>
					<td width="55%"><font class="SSLbl1">Street Name:</font></td>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td><input tabindex=1 type="text" name="SAfld0" size="13" value="<%=session("n1")%>" ID="Text1"></td>
					<td><input tabindex=2 type="text" name="SAfld1" size="19" value="<%=session("n2")%>" ID="Text2"></td>
					<td><input  tabindex=3 type=submit class=Btn  Value="Submit"></td>
				</tr>
			</table>
			<input type=hidden name=SAfld0Opr value=" LIKE ">
			<input type=hidden name=SAfld0Name value='ST_NUMBER'>
			<input type=hidden name=SAfld0Type value='String'>

			<input type=hidden name=SAfld1Opr value=" LIKE ">
			<input type=hidden name=SAfld1Name value='ST_NAME'>
			<input type=hidden name=SAfld1Type value='String'>
			<input type=hidden name=FieldCount value=1>
</form>
</body>
