<%
On Error Resume Next
%>
<html>
	<head>
		<title>Search Main</title></head>
	<!--#include file="../includes/header.aspx"-->
	<BODY class="colr" style="margin-top:3px;margin-left:4px" onload="top.MapFrame.hideLoadingLyr()">
<%
'Important''''''''''''''''''''''''''''''''
session("lyr")="2"
session("Fld_DB")="APN"
session("Fld_SHP")="APN"
session("Fld_Disp")="0,1,2,3,"
session("ds")="Provider=SQLOLEDB.1;" & Application("dbSource")
session("DBTbl")="FullFares"
''''''''''''''''''''''''''''''''''''''''''

session("StartOverASP")=Request.Url.ToString

dim intTTLLength
intTTLLength=10

%>


<script language="Javascript">

	function starthelp(plat){
	var targeturl="http://srv6/parcelview/custom/help.htm"
	newwin=window.open("","","scrollbars,resizable=yes")
	if (document.all){
	newwin.moveTo(0,0)
	newwin.resizeTo(screen.width - 100,screen.height - 100)
	}
	newwin.location=targeturl
	}
	function submititAddy() {

		if (document.frmDB.SAfld0.value==''&&document.frmDB.SAfld1.value=='') {
			alert ("Please fill out at least one of the search fields to proceed.");
			document.frmDB.SAfld0.focus();
			return;
		}
		top.HaltLYRHide=1;
		top.MapFrame.positionLoadingLyr();

		document.frmDB.onsubmit="";

		var objMC=top.MapFrame.findObj("MapClickedX")
		objMC.value="";

//		top.MapFrame.clearBufUrl(1);
		document.frmDB.action= '../Custom/custom_address_search_process.aspx' //?CS=1&StreetName=' + document.frmDB.StreetName.value + '&ds=Initial+Catalog%3dGIS%3bData+Source%3dPWASQL%3bUser+Id%3dgisuser%3bPassword%3dgisuser'
		document.frmDB.submit();
	}

	function searchTipsAddy() {
		document.location = "../SS/address_tips.aspx";
	}
	function submititAddyPNT() {
	//alert ("Test 1");
		if (document.frmDBADP.SAfld0.value==''&&document.frmDBADP.SAfld1.value==''&&document.frmDBADP.SAfld2.value=='') {
			alert ("Please fill out at least one of the search fields to proceed.");
			document.frmDBADP.SAfld0.focus();
			return;
		}
	//alert ("Test 2");
		top.HaltLYRHide=1;
		top.MapFrame.positionLoadingLyr();

		document.frmDBADP.onsubmit="";

		var objMC=top.MapFrame.findObj("MapClickedX")
		objMC.value="";

//		top.MapFrame.clearBufUrl(1);
		document.frmDBADP.action= '../Custom/custom_addressPNT_search_process.aspx' //?CS=1&StreetName=' + document.frmDB.StreetName.value + '&ds=Initial+Catalog%3dGIS%3bData+Source%3dPWASQL%3bUser+Id%3dgisuser%3bPassword%3dgisuser'
		document.frmDBADP.submit();
	}

	function searchTipsAddy() {
		document.location = "../SS/address_tips.aspx";
	}	
	
	function submititOwner() {
			if (document.frmDBO.SAfld0.value=='') {
			alert ("Please fill out at least one of the search fields to proceed.");
			document.frmDBO.SAfld0.focus();
			return;
		}
		top.HaltLYRHide=1;
		top.MapFrame.positionLoadingLyr();

		document.frmDBO.onsubmit="";

		var objMC=top.MapFrame.findObj("MapClickedX")
		objMC.value="";

//		top.MapFrame.clearBufUrl(1);

		document.frmDBO.action= '../Custom/custom_owner_search_process.aspx'
		document.frmDBO.submit();
	}

	function searchTipsOwner() {
		document.location = "../SS/owner_tips.aspx";
	}	

//	function sendAPN(apnBook,apnPage,apnParcel,apnSubParcel,apn2Book,apn2Page,apn2Parcel,apn2SubParcel) {
	function sendAPN(apn1,apn2) {
//		var Value1=apnBook+apnPage+apnParcel+apnSubParcel;
//		var Value2=apn2Book+apn2Page+apn2Parcel+apn2SubParcel;
		var Value1=apn1;
		var Value2=apn2;


//		if (Value1.length<11111111) {
//			alert("Please verify that all of the required fields are completed for the first APN.");
//			return;
//		}

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
	
	function searchTipsAPN() {
		document.location = "../SS/parcel_id_tips.aspx";
	}	

	function smartfocus (curr,nxt,v) {

		if (curr.value.length>(v-1)) {
			nxt.focus();
		}
	}	

	function sendQuery() {
		if (document.frmIntersection.s1.value=="" || document.frmIntersection.s2.value=="") {
			alert ("Please enter both street names");
			return;
		}

		document.frmIntersection.onsubmit="";

		var objMC=top.MapFrame.findObj("MapClickedX")
		objMC.value="";

//		top.MapFrame.clearBufUrl(1);

		document.frmIntersection.action="../SS/intersection_process.aspx?s1=" + document.frmIntersection.s1.value + "&s2=" + document.frmIntersection.s2.value;

		top.HaltLYRHide=1;
		top.MapFrame.positionLoadingLyr();
		document.frmIntersection.submit();

	}
	
</script>
			<table width=100% cellpadding=0 cellspacing=0 border=0><tr bgcolor="maroon"><td align=center><font color="white"><b>How Do I use This Application?</b></font></td></tr></table>
				<tr>
					<td align="center"><font class="SSMsg2"><a href=javascript:starthelp('start')>Click here for a quick start</a></font></td>
				</tr>
			<table width=100% cellpadding=0 cellspacing=0 border=0><tr class=tblhdr><td align=center><b>Address Point Search</b></font></td></tr></table>
			<form name="frmDBADP" onsubmit="submititAddyPNT();" method=post>
			<table>				<tr>
					<td width="40%"><font class="SSLbl1">Street Number:</font></td>
					<td width="60%"><font class="SSLbl1">Street Name:</font></td>
				</tr>

				<tr>
					<td><input type="text" name="SAfld0" size="14" ID="Text1"></td>
					<td><input type="text" name="SAfld1" size="21" ID="Text2"></td>
				</tr>
				<tr>
					<td width="70%"><font class="SSLbl1">Jurisdiction:</font></td>
					<td><input type="text" name="SAfld2" size="14" ID="Text3"></td>
				</tr>
				<tr>
					<td colspan="2" align="left"><font class="SSMsg2"><a href='javascript:searchTipsAddy()'>Address 
								Search Tips</a></font></td>
				</tr>
			</table>
<BR>
<center><input type=submit class=Btn Value="Search"></center>
			<br>
			
			<font class="SSMsg2"><b>Note: </b>Do NOT enter Street Suffix
						(St., Ave., Blvd., etc.). A list of
						potential matches will be displayed.</font>

			<input type=hidden name=SAfld0Opr value=" LIKE ">
			<input type=hidden name=SAfld0Name value='ADD_NUMBER'>
			<input type=hidden name=SAfld0Type value='String'>
			<input type=hidden name=SAfld1Opr value=" LIKE ">
			<input type=hidden name=SAfld1Name value='NAME'>
			<input type=hidden name=SAfld1Type value='String'>
			<input type=hidden name=SAfld2Opr value=" LIKE ">
			<input type=hidden name=SAfld2Name value='LOCALITY'>
			<input type=hidden name=SAfld2Type value='String'>
			<input type=hidden name=FieldCount value=2>
</form>
			<table width=100% cellpadding=0 cellspacing=0 border=0><tr class=tblhdr><td align=center><b>Address Search</b></font></td></tr></table>
			<form name="frmDB" onsubmit="submititAddy();" method=post>
			<table>				<tr>
					<td width="40%"><font class="SSLbl1">Street Number:</font></td>
					<td width="60%"><font class="SSLbl1">Street Name:</font></td>
				</tr>
				<tr>
					<td><input type="text" name="SAfld0" size="14" value="<%=Application("DefaultAddressNum")%>" ID="Text1"></td>
					<td><input type="text" name="SAfld1" size="21" value="<%=Application("DefaultAddressStreet")%>" ID="Text2"></td>
				</tr>
				<tr>
					<td colspan="2" align="left"><font class="SSMsg2"><a href='javascript:searchTipsAddy()'>Address 
								Search Tips</a></font></td>
				</tr>
			</table>
<BR>
<center><input type=submit class=Btn Value="Search"></center>
			<br>
			
			<font class="SSMsg2"><b>Note: </b>Do NOT enter Street Suffix
						(St., Ave., Blvd., etc.). A list of
						potential matches will be displayed.</font>

			<input type=hidden name=SAfld0Opr value=" LIKE ">
			<input type=hidden name=SAfld0Name value='SITUS_House_No_House_Alpha'>
			<input type=hidden name=SAfld0Type value='String'>
			<input type=hidden name=SAfld1Opr value=" LIKE ">
			<input type=hidden name=SAfld1Name value='SITUS_Direction_Street_Suffix'>
			<input type=hidden name=SAfld1Type value='String'>
			<input type=hidden name=FieldCount value=1>
</form>
<!-- No Owner Search Necessary -->
			<hr>

			<table width=100% cellpadding=0 cellspacing=0 border=0><tr class=tblhdr><td align=center><b>Owner Search</b></font></td></tr></table>
			<form name="frmDBO" onsubmit="submititOwner();" method=post>
			<table>
				<tr>
					<td width="40%"><font class="SSLbl1">Owner Name:</font></td>
					<td width="60%"><font class="SSLbl1">&nbsp;</font></td>
				</tr>
				<tr>
					<td colspan=2><input type="text" name="SAfld0" size="21" value='' ID="Text1"></td>
				</tr>
				<tr>
					<td colspan="2" align="left"><font class="SSMsg2"><a href='javascript:searchTipsOwner()'>Owner
								Search Tips</a></font></td>
				</tr>
			</table>
<center><input type=submit class=Btn Value="Search"></center>
			<br>
			
			<input type=hidden name=SAfld0Opr value=" LIKE ">
			<input type=hidden name=SAfld0Name value='Owner_Name__First_Name_First_'>
			<input type=hidden name=SAfld0Type value='String'>
			<input type=hidden name=FieldCount value=0>
</form>
			<hr>

<hr>
			<table width=100% cellpadding=0 cellspacing=0 border=0><tr class=tblhdr><td align=center><b>APN Search</b></font></td></tr></table>
			<form name="frmAPN" onsubmit="sendAPN(frmAPN.apn1.value,frmAPN.apn2.value)" method=post>
<FONT class=SSLbl1>Assessor Parcel Number:</FONT><BR>

<input type=text width=50 name=apn1 value="<%=session("Search_APN1")%>"><br>
<font class="SSMsg2">To: (optional)</font><br>
<input type=text width=50 name=apn2 value="<%=session("Search_APN2")%>"><br>

				<br><a href='javascript:searchTipsAPN()'>APN Search Tips</a></font><br>
				<br><center><input type=submit class=Btn  Value="Search"></center><br>

			<input type=hidden name=SAfld0>
			<input type=hidden name=SAfld0Opr value=" LIKE ">
			<input type=hidden name=SAfld0Name value='APNLink2'>

			<input type=hidden name=SAfld1>
			<input type=hidden name=SAfld1Opr value=" LIKE ">
			<input type=hidden name=SAfld1Name value='APNLink2'>
</form>
<hr>
			<table width=100% cellpadding=0 cellspacing=0 border=0><tr class=tblhdr><td align=center><font color="white"><b>Intersection Search</b></font></td></tr></table>
		<FORM name="frmIntersection" onsubmit="sendQuery();">
			<TABLE WIDTH="100%" CELLSPACING="2">
				<TR valign="top">
					<TD width="120"><FONT class="SSMsg2"><B>Street:</B></FONT></TD>
					<TD width="120"><FONT class="SSMsg2"><B>Cross Street:</B></FONT></TD>
				</TR>
				<TR valign="top">
					<TD><INPUT type="text" size="15" name="s1"></TD>
					<TD><INPUT type="text" size="15" name="s2"><br>
						<br>
					</TD>
				</TR>
			</table>
<center><input type=submit class=Btn Value="Search"></center>

			<BR>
			<FONT class="SSMsg2"><B>Note: </B>Do NOT enter Street Direction (E,W,N,S) or Street 
				Suffix (St., Ave., Blvd., etc.). A list of potential matches will be displayed.</FONT>

			<input type=hidden name=SAfld0Opr value=" LIKE ">
			<input type=hidden name=SAfld0Name value='SITUS_NR'>
			<input type=hidden name=SAfld0Type value='String'>

			<input type=hidden name=SAfld1Opr value=" LIKE ">
			<input type=hidden name=SAfld1Name value='SITUS_STRE'>
			<input type=hidden name=SAfld1Type value='String'>
			<input type=hidden name=FieldCount value=1>
</form>


	</BODY>
