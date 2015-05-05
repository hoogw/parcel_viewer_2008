<%@ Page Language="vb" AutoEventWireup="false" Codebehind="admin_lookup.aspx.vb" Inherits="dotNETViewer.Admin_lookup" %>
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
'	The purpose of this file is to display a main menu to the user.
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
	<BODY>
		<CENTER>
			<br>
			<CENTER><FONT class="SSHdr1">Project Coordination<br>Look-Up Table Administration</FONT></CENTER>
			<br>
			<br>
			<FONT class="SSRow1">Please choose which Look-Up Table to administer:</FONT><br>
			<br>
			<TABLE cellpadding="1" cellspacing="1" border="0">
				<TR>
					<TD>
						<LI>
							<a href="admin_l_owner.aspx">Project_Owner</a></li><br>
						<br>
						<LI>
							<a href="admin_l_status.aspx">Project_Status</a></li><br>
						<br>
						<LI>
							<a href="admin_l_conttype.aspx">Project_Contact_Types</a></li><br>
						<br>
						<LI>
							<a href="admin_l_division.aspx">Project_Divisions</a></li><br>
						<br>
						<LI>
							<a href="admin_l_ptypes.aspx">Project_Type</a></li><br>
					</TD>
				</TR>
			</TABLE>
			<br>
			<input type=button class=Btn onclick='document.location="../Admin/admin_intro.aspx"' value="Main Menu">
		</CENTER>
	</BODY>
</HTML>
