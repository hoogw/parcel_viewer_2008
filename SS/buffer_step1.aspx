<%@ Page Language="vb" AutoEventWireup="false" Codebehind="buffer_step1.aspx.vb" Inherits="dotNETViewer.buffer_step1"%>
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
'	The purpose of this page is to provide the HTML interface to the first step of buffering.  In this step, the user simply selects
'	which layer they wish to start buffering ON, and if they wish to buffer by line, polygon, or rectangle box.  Most of the 
'	processing is handled by the VB page and is stuffed into a public variable named Content.
'
'************************************************************************************************************************************
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<TITLE>buffer_step1</TITLE> 
		<!--#include file="../includes/header.aspx"-->
	</HEAD>
	<script language='JavaScript' type='text/javascript'>
		function ResumeBuffer() {
			//This button allows a person to resume their buffer task after doing a pan/zoom.
			//You need to set the 'current tool' back to buffering and specify the TYPE of buffering
			//This is used only with line or polygon selection.
			if (document.bufferselection.BufferSelectionType[0].checked==true) {
				top.MapFrame.setBuffType("line_poly",24); 
				top.MapFrame.SetCurrTool(24,2)
			}
			//if (document.bufferselection.BufferSelectionType[1].checked==true) {
			//	top.MapFrame.setBuffType("polygon",25); 
			//	top.MapFrame.SetCurrTool(25,2)
			//}
		}
		function Instr() { 
			top.fwinURL[0]="SS/buffer_instructions.aspx"; 
			var objTMP=top.MapFrame.findObj("iFramecontactinfoLayer",top.MapFrame.document); 
			top.MapFrame.ChangeiFrameURL(objTMP,"","yes",1); 
		}

		function B(t,g) { 
			var objBuffType=top.MapFrame.findObj('BuffType'); 
			if (top.MapFrame.XyCount==0 && objBuffType.value=='line_poly') {
				alert ("Please select at least one point to continue.");
				return
			}
			var objMF=top.MapFrame.findObj('MapFunction'); 
			objMF.value=t; 
			crntTool=t; 
			if (g) {
				top.MapFrame.SSAction(8,"Buffer Area");
			} else {
				top.MapFrame.RefreshMap();
			}
		}

	</script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>
	<BODY onload="top.bufferselectionDOC=document.bufferselection; top.bufferextract='1';">

			<table width=100% cellpadding=0 cellspacing=0 border=0 ID="Table3"><tr  class=tblHdr>
			<td align=center><b>Buffer STEP 1</b></font></td></tr></table><br>
		<table cellpadding=0 cellspacing=0 border=0 width=100%>
        <tr><td align=center><a href='javascript:Instr();'>Instructions</a></td></tr>
		</table>
		<hr color=black style='height:1px'>
		<table cellpadding=0 cellspacing=0 border=0 width=100%>
        	<tr>
		<td align=center></td>
		<td align=center><%=Content%></td>
		<td >&nbsp;</td>
		</tr>
		</table>
		
	</BODY>
</HTML>
