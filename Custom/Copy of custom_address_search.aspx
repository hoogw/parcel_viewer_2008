<html>
<head>
<title>DB Input Form</title>

<!--#include file="../includes/Header.aspx"-->

</head>

<%
'Important''''''''''''''''''''''''''''''''
session("lyr")="13"
session("Fld_DB")="APN"
session("Fld_SHP")="APN"
session("Fld_Disp")="0,1,2,3,"
session("ds")="Provider=SQLOLEDB.1;" & Application("dbSource")
session("DBTbl")="Parcels"
''''''''''''''''''''''''''''''''''''''''''

session("StartOverASP")=Request.Url.ToString
%>


<script language="Javascript">
	function submitit() {
			if (document.frmDB.SAfld0.value=='' && document.frmDB.SAfld1.value=='') {
			alert ("Please fill out at least one of the search fields to proceed.");
			document.frmDB.SAfld0.focus();
			return;
		}
		top.HaltLYRHide=1;
		top.MapFrame.positionLoadingLyr();

		document.frmDB.onsubmit="";

		var objMC=top.MapFrame.findObj("MapClickedX")
		objMC.value="";

		top.MapFrame.clearBufUrl(1);

		document.frmDB.action= '../Custom/custom_address_search_process.aspx' //?CS=1&Num1=' + document.frmDB.StreetNumber.value + '&StreetName=' + document.frmDB.StreetName.value + '&ds=Initial+Catalog%3dGIS%3bData+Source%3dPWASQL%3bUser+Id%3dgisuser%3bPassword%3dgisuser'
		document.frmDB.submit();
	}

	function searchTips() {
		document.location = "address_tips.aspx";
	}	
</script>

	<BODY class="colr" LEFTMARGIN="2" TOPMARGIN="0" RIGHTMARGIN="0" onload="top.MapFrame.hideLoadingLyr()">
			<form name="frmDB" onsubmit="submitit();" method=post>

			<font class="SSHdr1">Please enter the following information</font><br>
			<br>
			<table>
				<tr>
					<td width="40%"><font class="SSLbl1">Street Number:</font></td>
					<td width="60%"><font class="SSLbl1">Street Name:</font></td>
				</tr>
				<tr>
					<td><input type="text" name="SAfld0" size="14" value="<%=Application("DefaultAddressNum")%>" ID="Text1"></td>
					<td><input type="text" name="SAfld1" size="21" value="<%=Application("DefaultAddressStreet")%>" ID="Text2"></td>
				</tr>
				<tr>
					<td colspan="2" align="left"><font class="SSMsg2"><a href='javascript:searchTips()'>Address 
								Search Tips</a></font></td>
				</tr>
				<tr>
					<td colspan="2" align="center"><br>
						<input type=submit class=Btn  Value="Submit">
					</td>
				</tr>
			</table>
			<br>
<!---
			<font class="SSMsg2" color="red">To search by an Address range, <a href="custom_address_range_search.aspx">click here</a>.</font><br>
--->
			<br>
			<!---
			<font class="SSMsg2" color="red">If you are unsure of the spelling of a particular 
				street, <a href="address_dyn.aspx">click here</a>.</font><br>
			--->
			<br>

			
			<font class="SSMsg2"><b>Note: </b>Do NOT enter Street Direction (E,W,N,S) or Street 
				Suffix (St., Ave., Blvd., etc.). A list of potential matches will be displayed.</font>

			<input type=hidden name=SAfld0Opr value=" LIKE ">
			<input type=hidden name=SAfld0Name value='S_HouseNum'>
			<input type=hidden name=SAfld0Type value='String'>

			<input type=hidden name=SAfld1Opr value=" LIKE ">
			<input type=hidden name=SAfld1Name value='S_NAME'>
			<input type=hidden name=SAfld1Type value='String'>
			<input type=hidden name=FieldCount value=1>
</form>


</body>
