<%@ Page Language="vb" AutoEventWireup="false" Codebehind="extract_instructions.aspx.vb" Inherits="dotNETViewer.extract_instructions"%>
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
'	The purpose of this page is to provide the HTML interface to display instructions pertaining to buffering.
'
'************************************************************************************************************************************
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<TITLE>buffer_instructions</TITLE> 
		<!--#include file="../includes/header.aspx"-->
	</HEAD>
	<BODY>
		<U>
			<P><FONT class="ssmsg1">EXTRACT INSTRUCTIONS</FONT><BR>
		</U>
		</P><U></U> <FONT class="ssmsg2">
		<OL>
<LI>Select Jurisdiction</li>
<LI>Select Start Date</li>
<LI>Select End Date</li>
<LI>Select Status</li>
<LI>Click the 'Continue' button to facilitate the extract process.</li>
			</ol>
		</FONT>

	</BODY>
</HTML>
