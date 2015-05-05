<%@ Page Language="vb" AutoEventWireup="false" Codebehind="BM_Delete.aspx.vb" Inherits="dotNETViewer.BM_Delete"%>
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
'	The purpose of this page is to provide the HTML interface to allow a user to delete a bookmark.  A drop down box with bookmark
'	names is presented.  Upon selecting a bookmark and clicking on the submit button, the page is submitted to itself, by which
'	with the ACN variable set to 1, the VB code will know to execute a deletion on the selected bookmark.
'
'************************************************************************************************************************************
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<TITLE>Bookmark Deletion</TITLE> 
		<!--#include file="../includes/header.aspx"-->
	</HEAD>
	
	<script language='JavaScript' type='text/javascript'>
		function DeleteBM() {
			//Check to see if a bookmark has been selected.  If it has, then proceed with submitting the form.  The form will submit
			//back to BM_Delete.aspx - which will handle the deletion - only if the action variable ACN is set to 1.
		
			if (document.BMForm.BM.selectedIndex==0) {
				alert ("Please select a Bookmark to delete from the drop down list.");
				return;
			}
			document.BMForm.ACN.value=1;
			document.BMForm.submit();
		}
		
		function LookupPrivateBM() {
			//This function submits the page to itself so that we can look up a private bookmark.
			
			document.BMForm.ACN.value=0;
			document.BMForm.submit();
		}
		
	</script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>
	<BODY>

		<FORM id="BMForm" name="BMForm" runat="server">
		<input type=hidden name=ACN id=ACN value="">
		
			<TABLE width=100% cellpadding="3" cellspacing="0" border="0">
				<TR>
					<TD colspan="2" align="center"><FONT class="sshdr1">Delete a Bookmark</FONT><br><hr></TD>
				</TR>

				<TR>
					<TD><FONT class="ssmsg2">&nbsp;</FONT></TD>
					<TD><asp:TextBox cssclass=HTMLFrmObjects ID="BMUserID" Runat="server" MaxLength="20" Width="100"></asp:TextBox>&nbsp;<input type="button" class=Btn id="LookUP" value="Look Up" onclick="LookupPrivateBM();"></TD>
				</TR>
				<TR>
					<TD>&nbsp;</TD>
					<TD><asp:DropDownList cssclass=HTMLFrmObjects  ID="BM" Visible="True" AutoPostBack="false" Runat="server" Width="150"></asp:DropDownList></TD>
				</TR>
				<TR>
					<TD colspan="2"><hr></TD>
				</TR>
			</TABLE>

			<TABLE width=100% cellpadding="6" cellspacing="0" border="0">
				<TR bgcolor=#bbbbbb>
					<TD align=center colspan=2><input type="button" class=Btn value="Delete" onclick="DeleteBM();">&nbsp;<input type=button class=Btn id=back name=back value=Back onclick="document.location='BM_Main.aspx';"></TD>
				</TR>
			</TABLE>
		</FORM>
	</BODY>
</HTML>
