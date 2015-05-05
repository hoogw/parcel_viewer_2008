<%@ Page Language="vb" AutoEventWireup="false" Codebehind="extract_userdefined.aspx.vb" Inherits="dotNETViewer.extract_userdefined"%><%
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
'	The purpose of this page is to provide the HTML interface to the first step of feature extracting.  
'
'************************************************************************************************************************************
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<TITLE>extract_step1</TITLE> 
		<!--#include file="../includes/header.aspx"-->
	</HEAD>
	<script language='JavaScript' type='text/javascript'>
		function Resumeextract() {
			//This button allows a person to resume their extract task after doing a pan/zoom.
			//You need to set the 'current tool' back to extracting and specify the TYPE of extracting
			//This is used only with line or polygon selection.
			if (document.extractselection.extractSelectionType[0].checked==true) {
				top.MapFrame.setBuffType("line_poly",24); 
				top.MapFrame.SetCurrTool(24,2)
			}
			//if (document.extractselection.extractSelectionType[1].checked==true) {
			//	top.MapFrame.setBuffType("polygon",25); 
			//	top.MapFrame.SetCurrTool(25,2)
			//}
		}

		function B(t,g) { 
			var objBuffType=top.MapFrame.findObj('BuffType'); 
			
			<%if Trim(Request("s"))="" then%>
			if (top.MapFrame.XyCount<2 && objBuffType.value=='line_poly') {
				alert ("Please select at least two points to continue.");
				return
			}
			<%end if%>
			var objMF=top.MapFrame.findObj('MapFunction'); 
			objMF.value=t; 
			crntTool=t; 
			if (g) {
				if (objBuffType.value=='line_poly') {
					var objPts=top.MapFrame.findObj('dwg_bf_Points');
					document.extractselection.aryPts.value=objPts.value;
				}
				document.extractselection.action='extract_predefined.aspx';
				top.HaltLYRHide=1;
				top.MapFrame.positionLoadingLyr();
				document.extractselection.submit();
			} else {
				top.HaltLYRHide=1;
				top.MapFrame.positionLoadingLyr();
				top.MapFrame.RefreshMap();
			}
		}
	</script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>
	<BODY onload="top.bufferextract='2'; <%if Trim(Request("s"))="" then%>top.MapFrame.setBuffType('line_poly',24); top.MapFrame.SetCurrTool(24,2); <%end if%> top.HaltLYRHide=0; top.MapFrame.hideLoadingLyr(); top.EXS1Frm=this.document; top.MapFrame.clearMeasureVar(); ">
		<table cellpadding=0 cellspacing=0 border=0 width=100%><tr><TD align="center" bgcolor="#bbbbbb"><b>Feature Extraction Step 1</b></td></tr>
		</table>
		<hr color=black>
		<%=Content%>
	</BODY>
	
</HTML>
