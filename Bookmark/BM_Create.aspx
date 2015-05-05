<%@ Page Language="vb" AutoEventWireup="false" validateRequest="false" Codebehind="BM_Create.aspx.vb" Inherits="dotNETViewer.BM_Create"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<TITLE>Bookmark Creation</TITLE>
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
'	The purpose of this page is to provide the HTML interface to allow a user to create a new bookmark.  The appropriate variables
'	are presented to the user to create a new bookmark: username, bookmark name, expiration date, and bookmark type (public or private).
'
'	Validation variables (named with prefix of val) exist so .NET will check to see that required variables actually do have input.
'
'	The public boolean variable "Create" will be true if a successful addition to the database took place.  A message is presented to
'   the user, and a button to go back to the main screen is also presented.  If it is false, then we're at the beginning of the 
'	process - so display all the form variables.
'
'************************************************************************************************************************************


%>
		<!--#include file="../includes/header.aspx"-->
	</HEAD>
	<BODY onload="try {document.BMForm.UserName.focus();} catch(e){};">
		<%if Create=false then%>
		<FORM id="BMForm" name="BMForm" runat="server">
			<asp:ValidationSummary id="ValSummary" HeaderText="<b>The following errors were found</b>:" ShowSummary="True"
				DisplayMode="List" Runat="server" />
			<TABLE width="100%" cellpadding="3" cellspacing="0" border="0">
				<TR>
					<TD colspan="2" align="center"><FONT class="sshdr1">Create a Bookmark</FONT><br>
						<hr>
					</TD>
				</TR>
				<TR valign="top">
					<TD><FONT class="ssmsg2">UserName</FONT></TD>
					<TD><asp:TextBox cssclass="HTMLFrmObjects" ID="UserName" Runat="server" MaxLength="20" Width="100"></asp:TextBox></TD>
				</TR>
				<TR valign="top">
					<TD><FONT class="ssmsg2">Bookmark Name</FONT></TD>
					<TD><asp:TextBox cssclass="HTMLFrmObjects" ID="BMName" Runat="server" MaxLength="20" Width="100"></asp:TextBox></TD>
				</TR>
				<TR valign="top">
					<TD><FONT class="ssmsg2">Expiration</FONT></TD>
					<TD>
						<asp:DropDownList cssclass="HTMLFrmObjects" ID="ExpYear" Runat="server" AutoPostBack="True" Visible="True"></asp:DropDownList>
						<asp:Calendar ID="ExpDate" TitleFormat="Month" TitleStyle-ForeColor="#FFFFFF" DayStyle-BackColor="#eeeeee"
							BorderWidth="2" TitleStyle-BorderWidth="2" OtherMonthDayStyle-BackColor="#808080" SelectedDayStyle-BackColor="#990000"
							TodayDayStyle-ForeColor="#000000" ShowGridLines="true" BackColor="#ffffff" BorderColor="#000000"
							TitleStyle-Font-Bold="True" DayStyle-Font-Size="9px" DayStyle-BorderColor="#aaaaaa" DayHeaderStyle-Font-Size="9px"
							NextPrevStyle-ForeColor="#ffffff" NextPrevStyle-Font-Size="10px" DayHeaderStyle-BackColor="#aaaaaa"
							TitleStyle-BackColor="#777777" Width="100px" Height="100px" Runat="server" Visible="True"></asp:Calendar>
					</TD>
				</TR>
				<TR>
					<TD>&nbsp;</TD>
					<TD><asp:RadioButton ID="BMPub" GroupName="BMPubPriv" Text="Public" Runat="server"></asp:RadioButton>&nbsp;
						<asp:RadioButton ID="BMPriv" GroupName="BMPubPriv" Text="Private" Checked="True" Runat="server"></asp:RadioButton></TD>
				</TR>
				<TR>
					<TD>&nbsp;</TD>
					<TD align="left"><asp:RadioButton ID="Radiobutton3" onclick="document.BMForm.BMName.value='Default';" GroupName="BMPubPriv"
							Text="Default" Runat="server"></asp:RadioButton></TD>
				</TR>
				<TR>
					<TD colspan="2"><hr>
					</TD>
				</TR>
			</TABLE>
			<TABLE width="100%" cellpadding="6" cellspacing="0" border="0">
				<TR bgcolor="#bbbbbb">
					<TD align="center"><input class="Btn" type="submit" value="Submit">&nbsp;<input class="Btn" type="button" id="back" name="back" value="Back" onclick="document.location='BM_Main.aspx';"></TD>
				</TR>
			</TABLE>
			<asp:RequiredFieldValidator id="valUserName" ControlToValidate="UserName" ErrorMessage=" - UserName is a required field."
				EnableClientScript="true" Display="None" Runat="server" />
			<asp:RequiredFieldValidator id="valBookmarkName" ControlToValidate="BMName" ErrorMessage=" - Bookmark Name is a required field."
				EnableClientScript="true" Display="None" Runat="server" />
		</FORM>
		<%else%>
		<%=Information%>
		<br>
		<br>
		<CENTER><input type="button" class="Btn" onclick="document.location='BM_Main.aspx'" value='Start Over'></CENTER>
		<%end if%>
	</BODY>
</HTML>
