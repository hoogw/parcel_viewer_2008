<%@ Page Language="vb" AutoEventWireup="false" Codebehind="admin_login.aspx.vb" Inherits="dotNETViewer.Admin_login" %>
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
'	The purpose of this page is to provide the HTML interface to allow a user to log-in or log-out as a project admin.
'
'	Two javascript functions exist allowing the "Project" tab on the main application interface to either be hidden, or shown.
'	Another javascript function (login) is the action for the log-in button.  It simply hides the Project tab graphic, and directs
'	the browser window to admin_login.aspx with a variable telling the page that we're logging in.
'
'************************************************************************************************************************************
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%
On Error Resume Next
%>
<HTML>
	<HEAD>
		<TITLE>Admin</TITLE>
		<!--#include file="../includes/header.aspx"-->
	</HEAD>
	<script language='JavaScript' type='text/javascript'>
		function showit() {	var objm_projects=opener.top.MapFrame.findObj('m_projects',opener.top.MapFrame.document); if (objm_projects!=null){objm_projects.style.visibility='visible';} }
		function hideit() { var objm_projects=opener.top.MapFrame.findObj('m_projects',opener.top.MapFrame.document); if (objm_projects!=null){objm_projects.style.visibility='hidden';} }
		function login()  { hideit(); document.location="admin_login.aspx?a=li"; }
	</script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>
	<BODY onload="opener.top.MapFrame.hideLoadingLyr();">
		<%=Information%>
	</BODY>
</HTML>
