<%@ Page Language="vb" AutoEventWireup="false" Codebehind="parcel_id_detail_process.aspx.vb" Inherits="dotNETViewer.parcel_id_detail_process" %>
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
'	The purpose of this page is to provide the HTML interface to display parcel details.  This page will only be used if we are
'	displaying parcel details via the shape file.  As you can see, the public variable "Information" is solely used for processing.
'	This means that 99.9% of the HTML code comes from the VB page which is calling functions, etc. to generate the HTML code.
'
'************************************************************************************************************************************
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<TITLE></TITLE>
		<%
On Error Resume Next
%>
	</HEAD>
	<BODY onload="top.MapFrame.url=''; top.MapFrame.hideLoadingLyr()">
		<%=Information%>
	</BODY>
</HTML>
