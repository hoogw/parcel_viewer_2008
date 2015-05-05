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
session("lyr")="11"
session("Fld_DB")="APN"
session("Fld_SHP")="APN"
session("Fld_Disp")="0,1,2,3,"
session("ds")="Provider=SQLOLEDB.1;" & Application("dbSource")
session("DBTbl")="Parcels"
''''''''''''''''''''''''''''''''''''''''''

session("StartOverASP")=Request.Url.ToString

dim intTTLLength
intTTLLength=10

%>


<script language="Javascript">
	function submititAddy() {

		if (document.frmDB.SAfld0.value=='') {
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
		document.frmDB.action= '../Custom/custom_address_search_process.aspx' //?CS=1&StreetName=' + document.frmDB.StreetName.value + '&ds=Initial+Catalog%3dGIS%3bData+Source%3dPWASQL%3bUser+Id%3dgisuser%3bPassword%3dgisuser'
		document.frmDB.submit();
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

		top.MapFrame.clearBufUrl(1);

		document.frmDBO.action= '../Custom/custom_owner_search_process.aspx'
		document.frmDBO.submit();
	}

	function searchTipsOwner() {
		document.location = "../SS/owner_tips.aspx";
	}	

	function sendAPN(apnBook,apnPage,apnParcel,apn2Book,apn2Page,apn2Parcel) {
		var Value1=apnBook+apnPage+apnParcel; //+apnSubParcel;
		var Value2=apn2Book+apn2Page+apn2Parcel; //+apn2SubParcel;

//		if (Value1.length<<%=intTTLLength%>) {
//			alert("Please verify that all of the required fields are completed for the first APN.");
//			return;
//		}

		top.HaltLYRHide=1;
		top.MapFrame.positionLoadingLyr();

		document.frmAPN.onsubmit="";
		
		var objMC=top.MapFrame.findObj("MapClickedX")
		objMC.value="";

		top.MapFrame.clearBufUrl(1);

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

		top.MapFrame.clearBufUrl(1);

		document.frmIntersection.action="../SS/intersection_process.aspx?s1=" + document.frmIntersection.s1.value + "&s2=" + document.frmIntersection.s2.value;

		top.HaltLYRHide=1;
		top.MapFrame.positionLoadingLyr();
		document.frmIntersection.submit();

	}
	
</script>

			<table width=100% cellpadding=0 cellspacing=0 border=0><tr bgcolor="#010066"><td align=center><font color="white"><b>Address Search</b></font></td></tr></table>
			<form name="frmDB" onsubmit="submititAddy();" method=post>
			<table>
				<tr>
					<td width="100%"><font class="SSLbl1">Enter Street Number and Street Name:</font></td>
				</tr>
				<tr>
					<td><input type="text" name="SAfld0" size="36" value="<%=Application("DefaultAddressNum")%>" ID="Text1"></td>
				</tr>
				<tr>
					<td colspan="2" align="left"><font class="SSMsg2"><a href='javascript:searchTipsAddy()'>Address 
								Search Tips</a></font></td>
				</tr>
			</table>
<center><input type=submit class=Btn Value="Search"></center>
			<br>
			
			<font class="SSMsg2"><b>Note: </b>Do NOT enter Street Direction (E,W,N,S) or Street 
				Suffix (St., Ave., Blvd., etc.). A list of potential matches will be displayed.</font>

			<input type=hidden name=SAfld0Opr value=" LIKE ">
			<input type=hidden name=SAfld0Name value='Site_addre'>
			<input type=hidden name=SAfld0Type value='String'>
			<input type=hidden name=FieldCount value=0>
</form>

			<hr>

			<table width=100% cellpadding=0 cellspacing=0 border=0><tr bgcolor="#010066"><td align=center><font color="white"><b>Owner Search</b></font></td></tr></table>
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
			<input type=hidden name=SAfld0Name value='Owner'>
			<input type=hidden name=SAfld0Type value='String'>
			<input type=hidden name=FieldCount value=0>
</form>

			<hr>
			<table width=100% cellpadding=0 cellspacing=0 border=0><tr bgcolor="#010066"><td align=center><font color="white"><b>APN Search</b></font></td></tr></table>
			<form name="frmAPN" onsubmit="sendAPN(frmAPN.apnBook.value,frmAPN.apnPage.value,frmAPN.apnParcel.value,frmAPN.apn2Book.value,frmAPN.apn2Page.value,frmAPN.apn2Parcel.value,frmAPN.apn2SubParcel.value)" method=post>
<FONT class=SSLbl1>Assessor Parcel Number:</FONT><BR>

				<%
				dim methAPNSearch = CInt(Trim(Application("methAPNSearch")))

			    if methAPNSearch=2 then
			    %>
				<font class="SSMsg2">From:</font><br>
				<%end if%>
				<%on error resume next%>
				<%if Application("APNPiece1") > 0 and Application("APNPieces")>=1 then%>
				<input type="text" name="apnBook" size="
				<% 
					if (Application("APNPiece1")>1) then 
						response.write (Application("APNPiece1")-1) 
					else 
						response.write ("1") 
					end if
				%>
				" value="" maxlength="<%=Application("APNPiece1")%>" onkeyup="smartfocus(this,apnPage,<%=Application("APNPiece1")%>);" >
				<%else%>
				<input type="hidden" name="apnBook" value="">
				<%end if%>
				<%if Application("APNPiece2") > 0 and Application("APNPieces")>=2 then%>
				--<input type="text" name="apnPage" size="
				<% 
					if (Application("APNPiece2")>1) then 
						response.write (Application("APNPiece2")-1) 
					else 
						response.write ("1") 
					end if
				%>
				" value="" maxlength="<%=Application("APNPiece2")%>" onkeyup="smartfocus(this,apnParcel,<%=Application("APNPiece2")%>);" >
				<%else%>
				<input type="hidden" name="apnPage" value="">
				<%end if%>
				<%if Application("APNPiece3") > 0 and Application("APNPieces")>=3 then%>
				--<input type="text" name="apnParcel" size="
				<% 
					if (Application("APNPiece3")>1) then 
						response.write (Application("APNPiece3")-1) 
					else 
						response.write ("1") 
					end if
				%>
				" value="" maxlength="<%=Application("APNPiece3")%>" onkeyup="smartfocus(this,apnSubParcel,<%=Application("APNPiece2")%>);">
				<%else%>
				<input type="hidden" name="apnParcel" value="">
  <%end if%>
  <br>
  <font class="SSMsg2">To: (optional)</font><br>
					<%if Application("APNPiece1") > 0 and Application("APNPieces")>=1 then%>
					<input type="text" name="apn2Book" size="<% 
					if (Application("APNPiece1")>1) then 
						response.write (Application("APNPiece1")-1) 
					else 
						response.write ("1") 
					end if%>
					" value="" maxlength="<%=Application("APNPiece1")%>" onkeyup="smartfocus(this,apn2Page,<%=Application("APNPiece1")%>);" >
					<%else%>
					<input type="hidden" name="apn2Book" value="">
					<%end if%>
					<%if Application("APNPiece2") > 0 and Application("APNPieces")>=2 then%>
					--<input type="text" name="apn2Page" size="
					<% 
						if (Application("APNPiece2")>1) then 
							response.write (Application("APNPiece2")-1) 
						else 
							response.write ("1") 
						end if
					%>
					" value="" maxlength="<%=Application("APNPiece2")%>" onkeyup="smartfocus(this,apn2Parcel,<%=Application("APNPiece2")%>);" >
					<%else%>
					<input type="hidden" name="apn2Page" value="">
					<%end if%>
					<%if Application("APNPiece3") > 0 and Application("APNPieces")>=3 then%>
					--<input type="text" name="apn2Parcel" size="
					<% 
						if (Application("APNPiece3")>1) then 
							response.write (Application("APNPiece3")-1) 
						else 
							response.write ("1") 
						end if
					%>
					" value="" maxlength="<%=Application("APNPiece3")%>" onkeyup="smartfocus(this,apn2SubParcel,<%=Application("APNPiece2")%>);" >
					<%else%>
					<input type="hidden" name="apn2Parcel" value="">
  <%end if%>
  <br>
  <a href='javascript:searchTipsAPN()'>APN Search Tips</a><br>
				<br><center><input type=submit class=Btn  Value="Search"></center><br>

			<input type=hidden name=SAfld0>
			<input type=hidden name=SAfld0Name value='APN'>

			<input type=hidden name=SAfld1>
			<input type=hidden name=SAfld1Name value='APN'>
</form>

<hr>
			<table width=100% cellpadding=0 cellspacing=0 border=0><tr bgcolor="#010066"><td align=center><font color="white"><b>Intersection Search</b></font></td></tr></table>
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
