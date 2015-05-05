<%@ Page Language="vb" AutoEventWireup="false" Codebehind="admin_users.aspx.vb" Inherits="dotNETViewer.Admin_users" %>
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
'	The purpose of this page is to provide the HTML interface to administer the project admin users (add, edit, delete, and view).
'	These options are also the possible page actions (ACN variable).  Depending on which action the user is performing, specific
'	blocks of HTML will (or will not) appear.
'		ADD -		Display all text boxes and labels
'		EDIT -		Display all text boxes and labels. Also display the 'deleted' checkbox.
'		DELETE -	Display all text boxes (READ ONLY) and labels
'		VIEW -		Display only the ViewRecords .NET control.  Thus we have .NET generate the nice HTML table for us.
'	Form variable .NET validators (named with previx val) are utlized to make sure appropriate information is captured.
'	Should any issues arise, the variable valSummary will display error messages to the user.
'
'************************************************************************************************************************************
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<TITLE>Admin</TITLE>
		<%
		On Error Resume Next
		%>
		<!--#include file="../includes/header.aspx"-->
	</HEAD>
	<BODY>
		<FORM id="adminForm" name="adminForm" runat="server">
			<CENTER>
				<%=Information%>
				<%if ACN <> "View" then%>
				<TABLE cellpadding="2" cellspacing="1">
					<%if ACN = "Add" or ACN = "Edit" OR ACN="Delete" then%>
					<asp:ValidationSummary id="ValSummary" HeaderText="<b>The following errors were found</b>:" ShowSummary="True"
						DisplayMode="List" Runat="server" /><br>
					<TR valign="top">
						<TD width="45%"><asp:Label ID="PersonSelectionLabel" visible="False" Runat="server">Select a Person:</asp:Label></TD>
						<TD width="55%"><asp:DropDownList cssclass="HTMLFrmObjects" ID="PersonSelection" Visible="False" AutoPostBack="True"
								Runat="server" Width="200"></asp:DropDownList></TD>
					</TR>
					<TR valign="top">
						<TD>UserName:&nbsp;</TD>
						<TD><asp:TextBox cssclass="HTMLFrmObjects" ID="UserName" Runat="server" MaxLength="50" Width="200"></asp:TextBox></TD>
					</TR>
					<TR valign="top">
						<TD>Password:&nbsp;</TD>
						<TD><asp:TextBox cssclass="HTMLFrmObjects" ID="Password" Runat="server" MaxLength="50" Width="200"></asp:TextBox></TD>
					</TR>
					<TR valign="top">
						<TD>Email:&nbsp;</TD>
						<TD><asp:TextBox cssclass="HTMLFrmObjects" ID="Email" Runat="server" MaxLength="80" Width="200"></asp:TextBox></TD>
					</TR>
					<TR valign="top">
						<TD>Owner:&nbsp;</TD>
						<TD><asp:ListBox cssclass="HTMLFrmObjects" ID="Owner" Rows="4" SelectionMode="Multiple" AutoPostBack="False"
								Runat="server" Width="200"></asp:ListBox></TD>
					</TR>
					<TR valign="top">
						<TD>Division:&nbsp;</TD>
						<TD><asp:ListBox cssclass="HTMLFrmObjects" ID="Division" Rows="4" SelectionMode="Multiple" AutoPostBack="False"
								Runat="server" Width="200"></asp:ListBox></TD>
					</TR>
					<TR valign="top">
						<TD>Project Type:&nbsp;</TD>
						<TD><asp:ListBox cssclass="HTMLFrmObjects" ID="ProjectType" Rows="4" SelectionMode="Multiple" AutoPostBack="False"
								Runat="server" Width="200"></asp:ListBox></TD>
					</TR>
					<TR valign="top">
						<TD>Notification:&nbsp;</TD>
						<TD><asp:CheckBox ID="Notification" Runat="server"></asp:CheckBox></TD>
					</TR>
					<TR valign="top">
						<TD>Super User:&nbsp;</TD>
						<TD><asp:CheckBox ID="SuperUser" Runat="server"></asp:CheckBox></TD>
					</TR>
					<TR valign="top">
						<TD>View Personal Data:&nbsp;</TD>
						<TD><asp:CheckBox ID="ViewPersonalData" Runat="server"></asp:CheckBox></TD>
					</TR>
					<%if ACN = "Edit" then %>
					<TR valign="top">
						<TD width="45%">Deleted:&nbsp;</TD>
						<TD width="55%"><asp:CheckBox ID="Deleted" Runat="server"></asp:CheckBox></TD>
					</TR>
					<%end if%>
					<TR valign="top">
						<TD colspan="2" align="center"><br>
							<asp:Button Runat="server" cssclass=Btn ID="SubmitButton" OnClick="SubmitButton_Click"></asp:Button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Button Runat="server" cssclass=Btn ID="Cancel" Text="Cancel" CausesValidation="False" OnClick="Cancel_Click"></asp:Button></TD>
					</TR>
					<%if ACN = "Edit" OR ACN = "Delete"%>
					<asp:RequiredFieldValidator id="valPersonSelection" ControlToValidate="PersonSelection" ErrorMessage=" - You must select a person from the drop down box."
						EnableClientScript="true" Display="None" Runat="server" />
					<%end if
				if ACN = "Add" or ACN = "Edit" then%>
					<asp:RequiredFieldValidator id="valUserName" ControlToValidate="UserName" ErrorMessage=" - UserName is a required field."
						EnableClientScript="true" Display="None" Runat="server" />
					<asp:RequiredFieldValidator id="valPassword" ControlToValidate="Password" ErrorMessage=" - Password is a required field."
						EnableClientScript="true" Display="None" Runat="server" />
					<asp:RegularExpressionValidator ID="valEmailAddress" ControlToValidate="Email" ValidationExpression=".*@.*\..*"
						ErrorMessage=" - Email address is invalid." Display="None" EnableClientScript="true" Runat="server" />
					<asp:RequiredFieldValidator id="valOwner" ControlToValidate="Owner" ErrorMessage=" - You must select at least one Owner."
						EnableClientScript="true" Display="None" Runat="server" />
					<asp:RequiredFieldValidator id="valDivision" ControlToValidate="Division" ErrorMessage=" - You must select at least one Division."
						EnableClientScript="true" Display="None" Runat="server" />
					<asp:RequiredFieldValidator id="valProjectType" ControlToValidate="ProjectType" ErrorMessage=" - You must select at least one Project Type."
						EnableClientScript="true" Display="None" Runat="server" />
					<%end if%>
					<%end if%>
				</TABLE>
				<%else%>
				<CENTER>
					<asp:DataGrid ID="ViewRecords" AllowSorting="True" OnSortCommand="Sort_Grid" CellPadding="2" CellSpacing="2"
						HeaderStyle-BackColor="DimGray" HeaderStyle-BorderColor="black" HeaderStyle-Font-Bold="True"
						HeaderStyle-ForeColor="white" HeaderStyle-Height="18px" GridLines="Vertical" ItemStyle-BackColor="LightGrey"
						AlternatingItemStyle-BackColor="white" BorderStyle="Inset" BorderWidth="3px" runat="server"></asp:DataGrid>
					<br>
				</CENTER>
				<%end if%>
				<%=TailText%>
			</CENTER>
		</FORM>
	</BODY>
</HTML>
