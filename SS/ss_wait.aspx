<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
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
'	The purpose of this page is to provide the HTML interface to display a "please wait" page.  While the user sees a this message,
'	the window can be directed to the correct page for processing.  The key here is to let the user see something - even if it's
'	a page that says "please wait."
'
'************************************************************************************************************************************
%>
<HTML><HEAD><TITLE>One moment...</TITLE>
<!--#include file="../includes/header.aspx"-->
</HEAD>
<script language='JavaScript' type='text/javascript'>
	if (top.MapFrame) {
		//If the MapFrame frame exists, show the loading layer
		top.MapFrame.positionLoadingLyr();
	}
	
	function doit() {
		//after the page loads, send the current document to the URL mentioned in the top level variable top.MapFrame.url.
		//document.location=decodeURIComponent('<%=Request("url")%>');
		if (top.MapFrame) {
			if (top.MapFrame.url!='') {	document.location=top.MapFrame.url; }
		}
	}	
</script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>

<BODY onload="javascript:doit();">
	<FONT class="SSHdr1"><br>Please wait...<br><br>The Page is Loading...</FONT>	
</BODY>
</HTML>
