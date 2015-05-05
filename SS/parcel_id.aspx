<%@ Page Language="vb" AutoEventWireup="false" Codebehind="parcel_id.aspx.vb" Inherits="dotNETViewer.parcel_id" %>
<%
'************************************************************************************************************************************
'	ASPX PAGE
'
'	This ASPX page serves as the presentation layer while the VB page serves as the code page.  In some cases, I utilize a public 
'	variable named INFORMATION to dynamically generate HTML which is then displayed on the presentation layer (ASPX page).  Simply 
'   including the value of this public variable will effectively include that dynamically generated HTML code at run-time. The 
'   purpose of this page is to display formatted information to the user.  This ASPX page is dynamically generated with 
'   each page request.  Take note that not all portions of the HTML code will be displayed with each page request due to various
'   conditions.  Please see the special notes section for more explanation (if applicable).
'
'	SPECIAL NOTES regarding this ASPX page:
'	
'	Inclusion of the header.aspx file (located in the includes filder) allows the user of a common 'header' for all ASPX files.
'	By including this file, a common CSS can be shared and 'included' throughout all ASPX pages.
'	
'	hideLoadingLyr() - In the body's onload clause, this javascript function is executed.  This function resides in nav.js and the
'	purpose of this function is to hide the layer which houses the loading image.
'
'************************************************************************************************************************************
%>
<%
On Error Resume Next
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<TITLE>APN Input Form</TITLE>
	<!--#include file="../includes/header.aspx"-->
	</HEAD>
	<!--- GeopriseVariables.txt file variable methAPNSearch --->
	<!--- 0 - don't display anything (parcel details page will be blank --->
	<!--- 1 - Search the shape file --->
	<!--- 2 - Search using the customer's custom ASP file --->
	<%
	Dim methAPNSearch = CInt(Trim(Application("methAPNSearch")))
	%>
	<script language='JavaScript' type='text/javascript'>
		function searchTips() {
			//Redirect the window location to the parcel id tips page.
			document.location = "parcel_id_tips.aspx";
		}

		function sendAPN(apnBook,apnPage,apnParcel,apnSubParcel,apn2Book,apn2Page,apn2Parcel,apn2SubParcel) {
			//Submitting our form, let's verify that the APN(s) the user entered are actually valid.
			//The .NET public variable intTTLLength is calcualted at run-time to dynamically determine
			//the valid length of a parcel number.
			var Value1=apnBook+apnPage+apnParcel+apnSubParcel;
			var Value2=apn2Book+apn2Page+apn2Parcel+apn2SubParcel;

			if (Value1.length<<%=intTTLLength%>) {
				alert("Please verify that all of the required fields are completed for the first APN.");
				return;
			}

			//Show the loading layer
			top.MapFrame.positionLoadingLyr();

			document.frmAPN.onsubmit="";
			
			//Let the main processor form know that the user has not clicked on the map to get to this search.
			var objMC=top.MapFrame.findObj("MapClickedX")
			objMC.value="";

			document.location = "parcel_id_process.aspx?apn=" + Value1 + "&apn2=" + Value2;
		}
		
		function smartfocus (curr,nxt,v) {
			//This cool function will advance the cursor to the next designated textbox once a specific character length has been
			//reached in a 'prior' textbox.
			if (curr.value.length>(v-1)) {
				nxt.focus();
			}
		}

	</script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>
	<BODY class="colr" leftmargin="5" onload="top.MapFrame.hideLoadingLyr()">
		<FORM name="frmAPN" action="javascript:sendAPN(frmAPN.apnBook.value,frmAPN.apnPage.value,frmAPN.apnParcel.value,frmAPN.apnSubParcel.value,frmAPN.apn2Book.value,frmAPN.apn2Page.value,frmAPN.apn2Parcel.value,frmAPN.apn2SubParcel.value)" method="post">
			<FONT class="SSHdr2">Please enter the following information</FONT>
			<br>
			<br>
			<FONT class="SSMsg2"><FONT color="#0000ff">Assessor Parcel Number:</FONT><br>
				<br>
			    <%if methAPNSearch=2 then%>
				<FONT class="SSMsg2">From:</FONT><br>
				<%end if%>
				<%On Error Resume Next%>
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
					<FONT class="SSMsg2">To: (optional)</FONT><br>
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
					" value="" maxlength="<%=Application("APNPiece4")%>"></h1>
					<%else%>
					<input type="hidden" name="apn2SubParcel" value="">
					<%end if%>
				<%else%>
					<input type=hidden name="apn2Book" value="">
					<input type=hidden name="apn2Page" value="">
					<input type=hidden name="apn2Parcel" value="">
					<input type=hidden name="apn2SubParcel" value="">
				<%end if%>
				<FONT class="SSMsg2"><a href='javascript:searchTips()'>APN Search Tips</a></FONT><br>
				<DIV align="center"><CENTER><P>
					<input type=submit class=Btn value="Submit">
				</P>
					</CENTER>
				</DIV></DIV>
		</FORM>
		</FONT>
	</BODY>
</HTML>
