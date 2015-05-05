<%@ Page %>
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
'	The purpose of this page is to provide the HTML interface to search on vacant addresses.  This search page does NOT utilize
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
		<TITLE>Vacant Parcel Search Input Form</TITLE>
	<!--#include file="../includes/header.aspx"-->
		</HEAD>
	<script language='JavaScript' type='text/javascript'>
	function sendAddress(Value2) {
		//Direct the results of this page to a custom page: address_vacant_process.aspx
		top.MapFrame.positionLoadingLyr();
		document.location = "address_vacant_process.aspx?stname=" + Value2;
	}	
	function searchTips() {
		//Direct the window to a page on address searching tips
		document.location = "address_tips.aspx";
	}	
	</script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>
	<BODY leftmargin="5" onload="top.MapFrame.hideLoadingLyr()">
		<FORM name="frmAddress" action="javascript:sendAddress(frmAddress.stname.value)" method="post">
			<FONT class="SSHdr1">Please enter the following information</FONT><br>
			<br>
			<FONT class="SSLbl1">Vacant Parcel Search - Street Name:</FONT><br>
			<input type="text" name="stname" size="24" value="Goethe"><br>
			<br>
			<input type="submit" value="Find Addresses" name="submit"><br>
			<br>
			<br>
			<FONT class="SSMsg2"><a href="address.aspx">Click Here</a> to return to the 
				standard address search.<br>
				<br>
			</FONT><FONT class="SSMsg2"><b>Note: </b>Do NOT enter Street Direction (E,W,N,S) or 
				Street Suffix (St., Ave., Blvd., etc.). A list of potential matches will be 
				displayed.</FONT>
		</FORM>
	</BODY>
</HTML>
