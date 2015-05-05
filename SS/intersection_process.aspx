<%@ Page Language="vb" AutoEventWireup="false" Codebehind="intersection_process.aspx.vb" Inherits="dotNETViewer.intersection_process" %>
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
'************************************************************************************************************************************
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<%
On Error Resume Next
%>
		<script language='JavaScript' type='text/javascript'>
	function GoIntersection (x,y,n) {
		//This function fires off when a user selects an interesection to ZOOM to.  The variables coming in to this
		//function are the x,y coordinates OF the actual intersection, and the name (n) of the intersection pair.
		
		//top.HaltLYRHide=1;
		top.MapFrame.positionLoadingLyr();
		
		//Set our main processor's form variables according to an intersection search.
		var frmIx = top.MapFrame.findObj("IntersectionX"); var frmIy = top.MapFrame.findObj("IntersectionY"); var frmIn = top.MapFrame.findObj("IntersectionName"); var frmMF = top.MapFrame.findObj("MapFunction"); var frmSSUrl = top.MapFrame.findObj("SSUrl"); var frmcurrTool = top.MapFrame.findObj("currTool");
		frmIx.value=x; frmIy.value=y; frmIn.value=n; frmMF.value=3; frmcurrTool.value=2;
		
		// Javascript to parse Zips of Intersection name value
		var temp = new Array();
		var Inter_1;
		var Inter_2;

		temp = n.split('+');

		var val_len = temp[0].length
		val_len = (val_len - 7)

		Inter_1 = temp[0].substring(0,val_len);

		var val_len = temp[1].length
 		val_len = (val_len - 7)
		
		Inter_2 = temp[1].substring(0,val_len);
	
		frmIn.value = Inter_1 + ' and ' + Inter_2 
		
		//frmSSUrl.value='<%=SSUrl%>';
		frmSSUrl.value="";
		top.MapFrame.RefreshMap();
	}
		</script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>
		<!--#include file="../includes/header.aspx"-->
	</HEAD>
	<BODY onload="top.HaltLYRHide=0; top.MapFrame.hideLoadingLyr();" >
	<table width=100% cellpadding=0 cellspacing=0 border=0 ID="Table3"><tr class=tblHdr>
			<td align=center><b>Intersection Search Results</b></font></td></tr></table><br><br>
	<table width=100% cellpadding=0 cellspacing=0 border=0 ID="Table3">
		<tr >
			<td align=center><%response.write (Information)%></font></td>
		</tr>	
        </table><br><br>
		

	</BODY>
</HTML>
