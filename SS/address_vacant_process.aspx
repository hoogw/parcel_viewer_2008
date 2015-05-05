<%@ Page CodeBehind="address_vacant_process.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="dotNETViewer.address_vacant_process" %>
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
'	The purpose of this page is to provide the HTML interface to allow a user to search for vacant addresses;
'
'************************************************************************************************************************************
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<TITLE>Vacant Parcel Search - Address Results</TITLE>
		<%
On Error Resume Next
%>
		<% response.expires = -7 %>
		<script language='JavaScript' type='text/javascript'>
	function sendValue(Value1) {
		//This function allows the user to click on an APN and it will trigger the main processing page (pv_process) to 
		//display the parcel details for the selected parce.  Other things which must happen are: display the loading
		//layer, clear out the buffer window (asthetics), and call SSRefreshMap - this javascript function actually
		//starts the zoom-to-parcel and display results process.
		top.MapFrame.positionLoadingLyr();
		top.MapFrame.url="";
		var url="parcel_details.aspx?APN=" + Value1
		top.MapFrame.SSRefreshMap(Value1,url);
	}
		</script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>
		<!--#include file="../includes/header.aspx"-->
	</HEAD>
	<BODY onload="<%=AfterLoad%>">
		<%=Information%>
	</BODY>
</HTML>
