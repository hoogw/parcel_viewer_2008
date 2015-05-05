<%@ Page Language="vb" AutoEventWireup="false" Codebehind="intersection.aspx.vb" Inherits="dotNETViewer.intersection" %>
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
'	The purpose of this page is to provide the HTML interface to facilitate an intersection searching mechanism.
'
'************************************************************************************************************************************
%>
<%
On Error Resume Next
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<script language='JavaScript' type='text/javascript'>
		function sendQuery() {
			//Submitting the form - let's make sure they entered in TWO streets before moving on.
			//if (document.frmIntersection.s1.value=="" || document.frmIntersection.s2.value=="") {
			//	alert ("Please enter both street names");
			//	return;
			//}

			document.frmIntersection.onsubmit="";

			//Let the main processor form know that the user has not clicked on the map to get to this search.
			var objMC=top.MapFrame.findObj("MapClickedX")
			objMC.value="";

			document.frmIntersection.action="intersection_process.aspx?s1=" + document.frmIntersection.s1.value + 

"&s2=" + document.frmIntersection.s2.value;

			//Setting HaltLYRHide to 1 forces the loading GIF to always stay on.
			top.HaltLYRHide=1;
			top.MapFrame.positionLoadingLyr();
			document.frmIntersection.submit();

		}
		</script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>
	<!--#include file="../includes/header.aspx"-->
	</HEAD>
	<BODY class="colr" LEFTMARGIN="2" TOPMARGIN="0" RIGHTMARGIN="0" onload="top.MapFrame.hideLoadingLyr(); try 

{document.frmIntersection.s1.focus();} catch(e){};">
		<FORM name="frmIntersection" onsubmit="sendQuery();">
			
<table width=100% cellpadding=0 cellspacing=0 border=0 ID="Table3"><tr class=tblHdr>
			<td align=center><b>Intersection Search</b></font></td></tr></table>
			<br>
			<br>
			<TABLE WIDTH="100%" CELLSPACING="2">
			<tr>
				<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
				<td><font class="SSMsg2">Street/Number:</font></td>
			</tr>
			<tr>
				<td></td>
				<td><INPUT type="text" length="10" name="s1"></td>
			</tr>
			<tr>
				<td></td>
				<td><font class="SSMsg2">Cross Street:</font></td>
			</tr>
			<tr>
				<td></td>
				<td><INPUT type="text" length="10" name="s2"></td>
			</tr>
			<tr>
				<td></td>
				<td><br><br></td>
			</tr>

			<TR valign="top">
				<TD colspan="2" align="center">
					<input type=submit class=Btn value="Submit">
				</TD>
			</TR>
			<tr>
				<td></td>
				<td><br><br></td>
			</tr>
			<tr>
				<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
				<td class="SSMsg2"><b>Note: </b>Do NOT enter Street Direction (E,W,N,S) or Street 
				Suffix (St., Ave., Blvd., etc.). A list of potential matches will be displayed.</td>
			</tr>
			</TABLE>
			
		</FORM>
	</BODY>
</HTML>
