<%@ Page CodeBehind="address.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="dotNETViewer.address" %>
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
'	The purpose of this page is to provide the HTML interface to facilitate an address searching mechanism.  As mentioned in the 
'	VB page, this page sets the stage for searching.  The actual search functionality itself is handled by search_all.aspx.  
'	Because of this code reuse, we set the stage here in a general sense. The two variables of interest here are:
'
'		FN1 and FN2 - these are the actual field names from the shape file for street number and street name.  We use these
'					  values as the form variable names.
'
'************************************************************************************************************************************
%>
<%
On Error Resume Next
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<TITLE>Address Input Form</TITLE>
	<!--#include file="../includes/header.aspx"-->
		</HEAD>
	<%if aok=true then%>
	<script language='JavaScript' type='text/javascript'>
	function sendAddress() {
		//Submitting the form - let's make sure the user has entered at least one field before moving on.
		if (document.frmAddress.<%=FN1%>.value=='' && document.frmAddress.<%=FN2%>.value=='' ) {
			alert ("Please complete at least one field to continue.");
			document.frmAddress.<%=FN1%>.focus();
			return;
		}

		//Setting HaltLYRHide to 1 forces the loading GIF to always stay on.
		top.HaltLYRHide=1;
		top.MapFrame.positionLoadingLyr();

		document.frmAddress.onsubmit="";

		//Let the main processor form know that the user has not clicked on the map to get to this search.
		var objMC=top.MapFrame.findObj("MapClickedX")
		objMC.value="";

		//the action URL is dynamically created in the VB file
		document.frmAddress.action= <%=JS%>
		document.frmAddress.submit();
	}
	function searchTips() {
		//Direct the window location to the tips page.
		document.location = "address_tips.aspx";
	}	
	</script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>
	<%end if%>
	<BODY class="colr" LEFTMARGIN="2" TOPMARGIN="0" RIGHTMARGIN="0" onload="top.MapFrame.hideLoadingLyr()">
		<FORM name="frmAddress" onsubmit="sendAddress();" method="post">
			<%if aok=true then%>
			<FONT class="SSHdr1">Please enter the following information</FONT><br>
			<br>
			<TABLE>
				<TR>
					<TD width="40%"><FONT class="SSLbl1">Street Number:</FONT></TD>
					<TD width="60%"><FONT class="SSLbl1">Street Name:</FONT></TD>
				</TR>
				<TR>
					<TD><input type="text" name="<%=FN1%>" size="15" value="<%=Application("DefaultAddressNum")%>" ID="Text1"></TD>
					<TD><input type="text" name="<%=FN2%>" size="24" value="<%=Application("DefaultAddressStreet")%>" ID="Text2"></TD>
				</TR>
				<TR>
					<TD colspan="2" align="left"><FONT class="SSMsg2"><a href='javascript:searchTips()'>Address 
								Search Tips</a></FONT></TD>
				</TR>
				<TR>
					<TD colspan="2" align="center"><br>
						<input type=submit class=Btn value="Submit">
					</TD>
				</TR>
			</TABLE>
			<br>
			<%else%>
			<%=Information%>
			<%response.end%>
			<%end if%>
			<!---
			<FONT class="SSMsg2" color="red">To search by Vacant Parcels, <a href="address_vacant.aspx">
					click here</a>.</FONT><br>
			<br>
			--->
			<%if Application("ClientName") = "SacCounty" then%>
			<FONT class="SSMsg2" color="red">To search by an Address range, <a href="address_range.aspx">
					click here</a>.</FONT><br>
			<br>
			<FONT class="SSMsg2" color="red">If you are unsure of the spelling of a particular 
				street, <a href="address_dyn.aspx">click here</a>.</FONT><br>
			<br>

			<%end if%>
			<FONT class="SSMsg2"><b>Note: </b>Do NOT enter Street Direction (E,W,N,S) or Street 
				Suffix (St., Ave., Blvd., etc.). A list of potential matches will be displayed.</FONT>

			<%=Information%>

		</FORM>
	</BODY>
