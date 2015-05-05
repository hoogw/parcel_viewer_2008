<%@ Page Language="vb" AutoEventWireup="false" Codebehind="default.aspx.vb" Inherits="dotNETViewer._default"%>
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
'	This page redirects to a custom page named searchmain.aspx.
'
'
'************************************************************************************************************************************
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
  <HEAD>
    <TITLE></TITLE>
	<!--#include file="../includes/header.aspx"-->
  </HEAD>
  <BODY onload="top.MapFrame.hideLoadingLyr()">

	<%response.redirect ("../custom/searchmain.aspx")%>
  </BODY>
</HTML>
