<%@ Page Language="vb" AutoEventWireup="false" Codebehind="admin_intro.aspx.vb" Inherits="dotNETViewer.Admin_intro" %>
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
'	The purpose of this page is to display a nice menu to the user.  If the logged-in user has permissions to view personal data, then
'	The "Project Contacts" option displays.  If the user is a Super User, then the "Account Manager," "Application Tables," and
'	"Project Results" options display.
'
'************************************************************************************************************************************
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%
On Error Resume Next
%>
<HTML>
	<HEAD>
		<TITLE>Admin!</TITLE>
		<!--#include file="../includes/header.aspx"-->
	</HEAD>
	<BODY>
		<CENTER>
			<%
			
			Dim SU=false
			if CStr(trim(session("SuperUser"))) = "1" then
				SU=true
			end if

		    %>
			<br>
			<CENTER><FONT class="SSHdr1">Project Coordination<br>Account Administration</FONT></CENTER>
			<br>
			<br>
			<FONT class="SSRow1">Please choose which section you'd like to administer:</FONT><br>
			<br>
			<TABLE cellpadding="1" cellspacing="1" border="0">
				<TR valign="top">
					<TD>
						<% if Session("ViewPersonalData") = "1" or trim(ucase(Session("ViewPersonalData"))) = "TRUE" then%>
						<LI>
							<a href="admin_pc.aspx">Project Contacts</a>
							<br>
							<br>
							<%end if%>
						<LI>
							<a href="../Projects/proj_search.aspx?a=1">Coordinate Projects</a>
							<br>
							<br>
							<%if SU then%>
						<LI>
							<a href="admin_users.aspx">Account Manager</a>
							<br>
							<br>
						<LI>
							<a href="admin_lookup.aspx">Application Tables</a>
							<br>
							<br>
						<LI>
							<a href="admin_proj.aspx">Project Results</a>
							<%end if%>
						</li>
					</TD>
				</TR>
			</TABLE>
		</CENTER>
	</BODY>
</HTML>
