<%@ Page CodeBehind="address_range.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="dotNETViewer.address_range" %>
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
'	The purpose of this page is to provide the HTML interface to search on a range of addresses.  This search page does NOT utilize
'	the search_all.aspx page - it has its own custom processing page.
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
	<script language='JavaScript' type='text/javascript'>
	function sendAddress(n1,n2,s1) {

		//Submitting the form - let's make sure the user has entered the required data before moving on.
		if (document.frmAddress.N1.value=='' || document.frmAddress.N2.value=='' || document.frmAddress.SName.value=='') {
			alert ("Please enter a valid range to continue.");
			document.frmAddress.N1.focus();
			return;
		}

		//Setting HaltLYRHide to 1 forces the loading GIF to always stay on.
		top.HaltLYRHide=1;
		top.MapFrame.positionLoadingLyr();

		document.frmAddress.onsubmit="";

		//Let the main processor form know that the user has not clicked on the map to get to this search.
		var objMC=top.MapFrame.findObj("MapClickedX")
		objMC.value="";

		//Submitting the form.  Remember to pass along the datasource, too!
		document.frmAddress.action="../Custom/custom_srch_address.asp?Num1=" + n1 + "&Num2=" + n2 + "&StreetName=" + s1 + "&ds=<%=Server.UrlEncode(Application("dbSource"))%>";
		document.frmAddress.submit();
	}
	function searchTips() {
		//Direct the window location to the tips page.
		document.location = "address_tips.aspx";
	}	
	</script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>

	<BODY class="colr" LEFTMARGIN="2" TOPMARGIN="0" RIGHTMARGIN="0" onload="top.MapFrame.hideLoadingLyr()">
		<FORM name="frmAddress" onsubmit="sendAddress(document.frmAddress.N1.value,document.frmAddress.N2.value,document.frmAddress.SName.value);" method="post">
			<FONT class="SSHdr1">Please enter the following information</FONT><br>
			<br>
			<TABLE>
				<TR>
					<TD width="40%"><FONT class="SSLbl1">Street Number Start:</FONT></TD>
					<TD><input type="text" name="N1" size="15" value="" ID="Text1"></TD>
				</TR>
				<TR>
					<TD width="40%"><FONT class="SSLbl1">Street Number End:</FONT></TD>
					<TD><input type="text" name="N2" size="15" value="" ID="Text1"></TD>
				</TR>
				<TR>
					<TD width="40%"><FONT class="SSLbl1">Street Name:</FONT></TD>
					<TD><input type="text" name="SName" size="15" value="" ID="Text1"></TD>
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
			<FONT class="SSMsg2"><b>Note: </b>Do NOT enter Street Direction (E,W,N,S) or Street 
				Suffix (St., Ave., Blvd., etc.). A list of potential matches will be displayed.</FONT>

		</FORM>
	</BODY>
