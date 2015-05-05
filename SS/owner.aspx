<%@ Page CodeBehind="owner.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="dotNETViewer.owner" %>
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
'	The purpose of this page is to provide the HTML interface to facilitate an owner searching mechanism.  As mentioned in the 
'	VB page, this page sets the stage for searching.  The actual search functionality itself is handled by search_all.aspx.  
'	Because of this code reuse, we set the stage here in a general sense. The two variables of interest here are:
'
'		FN1 - This is the actual field names from the shape file for owner name.  We use this value as the form variable name.
'
'************************************************************************************************************************************
%>
<%
On Error Resume Next
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<TITLE>Owner Input Form</TITLE>
	<!--#include file="../includes/header.aspx"-->
		</HEAD>
	<%if aok=true then%>
	<script language='JavaScript' type='text/javascript'>
	function sendOwner() {
		//Let's validate that the user has actually typed in SOME input.  
		if (document.frmOwner.<%=FN1%>.value==''  ) {
			alert ("Please enter an owner name to continue.");
			document.frmOwner.<%=FN1%>.focus();
			return;
		}

		//Setting HaltLYRHide to 1 forces the loading GIF to always stay on.
		top.HaltLYRHide=1;
		top.MapFrame.positionLoadingLyr();

		document.frmOwner.onsubmit="";

		//Let the main processor form know that the user has not clicked on the map to get to this search.
		var objMC=top.MapFrame.findObj("MapClickedX")
		objMC.value="";

		//the action URL is dynamically created in the VB file
		document.frmOwner.action= <%=JS%>
		document.frmOwner.submit();
	}

	function searchTips() {
		//Direct the window location to the tips page.
		document.location = "owner_tips.aspx";
	}
	</script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>
	<%end if%>
	<BODY leftmargin="5" onload="top.MapFrame.hideLoadingLyr()">
		<FORM name="frmOwner" onsubmit="sendOwner();" method="post">
		
			<%if aok=true then%>
			<FONT class="SSHdr1">Please enter the following information</FONT><br>
			<br>
			Owner:
			<br>
			<input type="text" name="<%=FN1%>" size="24" value="<%=Application("DefaultOwner")%>">&nbsp;<FONT class="SSMsg2"><a href='javascript:searchTips()'>Search 
					Tips</a></FONT><br>
			<br>
				<input type=submit class=Btn value="Submit">
			<br>
			<FONT size="-1"><b>Note: </b>Enter the owner last name (or the first few letters). 
				If you wish to be more specific, enter the last name followed by a space, then 
				the first name or first initial. A list of potential matches will be displayed.</FONT>
			<%=Information%>

			<%else%>
				<%=Information%>
				<%response.end%>
			<%end if%>

		</FORM>
	</BODY>
</HTML>
