<%@ Page CodeBehind="parcel_id_brief_process.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="dotNETViewer.parcel_id_brief_process" %>
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
'	The purpose of this page is to provide the HTML interface to display brief parcel details.  All of the HTML code is generated in the
'	.VB file with response.write statements
'
'************************************************************************************************************************************
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<TITLE>Identify Brief Results</TITLE>
		<%
On Error Resume Next
response.expires=-7
%>
		<!--#include file="../includes/header.aspx"-->
	</HEAD>
	<BODY onload="top.MapFrame.hideLoadingLyr()">
		<!--- GeopriseVariables.txt file variable PIData --->
		<!--- 0 - don't display anything (parcel details page will be blank --->
		<!--- 1 - Display only shape file data --->
		<!--- 2 - Display only customer's custom ASP file --->
	</BODY>
</HTML>
