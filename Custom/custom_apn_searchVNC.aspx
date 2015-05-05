<html>
<head>
<title>DB Input Form</title>

<!--#include file="../includes/Header.aspx"-->

</head>

<%
'Important''''''''''''''''''''''''''''''''
session("lyr")="6"
session("Fld_DB")="CNTYAP_NBR"
session("Fld_SHP")="APN"
session("Fld_Disp")="0,1,2,3,"
session("ds")="Provider=SQLOLEDB.1;" & Application("dbSource")
session("DBTbl")="ParcelsEE"
''''''''''''''''''''''''''''''''''''''''''

session("StartOverASP")=Request.Url.ToString

dim intTTLLength
intTTLLength=14
%>


<script language="Javascript">

	function sendAPN(apnBook,apnPage,apnParcel,apnSubParcel,apn2Book,apn2Page,apn2Parcel,apn2SubParcel) {
		var Value1=apnBook+apnPage+apnParcel+apnSubParcel;
		var Value2=apn2Book+apn2Page+apn2Parcel+apn2SubParcel;

		if (Value1.length<<%=intTTLLength%>) {
			alert("Please verify that all of the required fields are completed for the first APN.");
			return;
		}

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
	

	function searchTips() {
		document.location = "parcel_id_tips.aspx";
	}	

	function smartfocus (curr,nxt,v) {

		if (curr.value.length>(v-1)) {
			nxt.focus();
		}
	}
</script>

	<BODY class="colr" LEFTMARGIN="2" TOPMARGIN="0" RIGHTMARGIN="0" onload="top.MapFrame.hideLoadingLyr()">
			<form name="frmAPN" onsubmit="sendAPN(frmAPN.apnBook.value,frmAPN.apnPage.value,frmAPN.apnParcel.value,frmAPN.apnSubParcel.value,frmAPN.apn2Book.value,frmAPN.apn2Page.value,frmAPN.apn2Parcel.value,frmAPN.apn2SubParcel.value)" method=post>

			<font class="SSHdr1">Please enter the following information</font><br>
			<br>
<FONT class=SSHdr2>Assessor Parcel Number:</FONT><BR>

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
				" value="" maxlength="<%=Application("APNPiece3")%>" onkeyup="smartfocus(this,apnSubParcel,<%=Application("APNPiece3")%>);" >
				<%else%>
				<input type="hidden" name="apnParcel" value="">
				<%end if%>
				<%if Application("APNPiece4") > 0 and Application("APNPieces")>=4 then%>
				--<input type="text" name="apnSubParcel" size="
				<% 
					if (Application("APNPiece4")>1) then 
						response.write (Application("APNPiece4")-1) 
					else 
						response.write ("1") 
					end if
				%>
				" maxlength="<%=Application("APNPiece4")%>" value="<%if Application("ClientName")="SacCounty" then%>0000<%end if%>"><br>
				<%else%>
				<input type="hidden" name="apnSubParcel" value="">
				<%end if%>
				<%
			    if methAPNSearch=2 then
					%>
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
					" value="" maxlength="<%=Application("APNPiece3")%>" onkeyup="smartfocus(this,apn2SubParcel,<%=Application("APNPiece3")%>);" >
					<%else%>
					<input type="hidden" name="apn2Parcel" value="">
					<%end if%>
					<%if Application("APNPiece4") > 0 and Application("APNPieces")>=4 then%>
					--<input type="text" name="apn2SubParcel" size="
					<% 
						if (Application("APNPiece4")>1) then 
							response.write (Application("APNPiece4")-1) 
						else 
							response.write ("1") 
						end if
					%>
					" maxlength="<%=Application("APNPiece4")%>" value="<%if Application("ClientName")="SacCounty" then%>0000<%end if%>"></h1>
					<%else%>
					<input type="hidden" name="apn2SubParcel" value="">
					<%end if%>
				<%else%>
					<input type=hidden name="apn2Book" value="">
					<input type=hidden name="apn2Page" value="">
					<input type=hidden name="apn2Parcel" value="">
					<input type=hidden name="apn2SubParcel" value="">
				<%end if%>

				<a href='javascript:searchTips()'>APN Search Tips</a></font><br>
				<br><center><input type=image src="../images/<%=Application("ColourScheme")%>b_submit.gif" alt="Submit" border=0></a></center><br>

			<input type=hidden name=SAfld0>
			<input type=hidden name=SAfld0Name value='CNTYAP_NBR'>

			<input type=hidden name=SAfld1>
			<input type=hidden name=SAfld1Name value='CNTYAP_NBR'>
</form>
</body>
