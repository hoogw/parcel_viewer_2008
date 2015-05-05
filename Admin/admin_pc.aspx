<%@ Page Language="vb" AutoEventWireup="false" Codebehind="admin_pc.aspx.vb" Inherits="dotNETViewer.Admin_pc" %>
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
'	The purpose of this page is to provide the HTML interface to administer the project contacts (add, edit, delete, reassign, and view).
'	These options are also the possible page actions (ACN variable).  Depending on which action the user is performing, specific
'	blocks of HTML will (or will not) appear.
'		ADD -		Display all text boxes and labels
'		EDIT -		Display all text boxes and labels. Also display the 'deleted' checkbox.
'		DELETE -	Display all text boxes (READ ONLY) and labels
'		REASSIGN-	Display all text boxes and labels related to reassignment.
'		VIEW -		Display only the ViewRecords .NET control.  Thus we have .NET generate the nice HTML table for us.
'	Form variable .NET validators (named with previx val) are utlized to make sure appropriate information is captured.
'	Should any issues arise, the variable valSummary will display error messages to the user.
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
		<FORM id="adminForm" name="adminForm" runat="server">
			<CENTER>
				<%=Information%>
				<%if ACN <> "View" then%>
				<TABLE cellpadding="2" cellspacing="1">
					<asp:ValidationSummary id="ValSummary" HeaderText="<b>The following errors were found</b>:" ShowSummary="True" DisplayMode="List" Runat="server" /><br>
					<%if ACN = "Add" or ACN = "Edit" OR acn="Delete" then%>
					<TR valign="top">
						<TD width="45%"><asp:Label ID="PersonSelectionLabel" visible="False" Runat="server">Select a Person:</asp:Label></TD>
						<TD width="55%"><asp:DropDownList cssclass=HTMLFrmObjects  ID="PersonSelection" Visible="False" AutoPostBack="True" Runat="server" style="width:200px;"></asp:DropDownList></TD>
					</TR>
					<TR valign="top">
						<TD colspan="2">&nbsp;</TD>
					</TR>
					<TR valign="top">
						<TD width="45%">Contact Type:</TD>
						<TD width="55%"><asp:DropDownList cssclass=HTMLFrmObjects  ID="contactType" AutoPostBack="False" Runat="server" style="width:200px;"></asp:DropDownList></TD>
					</TR>
					<TR valign="top">
						<TD>First Name:&nbsp;</TD>
						<TD><asp:TextBox cssclass=HTMLFrmObjects ID="FirstName" Runat="server" style="width:200px" MaxLength="30"></asp:TextBox></TD>
					</TR>
					<TR valign="top">
						<TD>Last Name:&nbsp;</TD>
						<TD><asp:TextBox cssclass=HTMLFrmObjects ID="LastName" Runat="server" style="width:200px" MaxLength="30"></asp:TextBox></TD>
					</TR>
					<TR valign="top">
						<TD>Email:&nbsp;</TD>
						<TD><asp:TextBox cssclass=HTMLFrmObjects ID="Email" Runat="server" style="width:200px" MaxLength="100"></asp:TextBox></TD>
					</TR>
					<TR valign="top">
						<TD>Office Phone (###-###-####):&nbsp;</TD>
						<TD><asp:TextBox cssclass=HTMLFrmObjects ID="OfficePhone" Runat="server" style="width:200px" MaxLength="30"></asp:TextBox></TD>
					</TR>
					<TR valign="top">
						<TD>Mobile Phone (###-###-####):&nbsp;</TD>
						<TD><asp:TextBox cssclass=HTMLFrmObjects ID="MobilePhone" Runat="server" style="width:200px" MaxLength="30"></asp:TextBox></TD>
					</TR>
					<TR valign="top">
						<TD>Pager Phone (###-###-####):&nbsp;</TD>
						<TD><asp:TextBox cssclass=HTMLFrmObjects ID="PagerPhone" Runat="server" style="width:200px" MaxLength="30"></asp:TextBox></TD>
					</TR>
					<TR valign="top">
						<TD>Home Phone (###-###-####):&nbsp;</TD>
						<TD><asp:TextBox cssclass=HTMLFrmObjects ID="HomePhone" Runat="server" style="width:200px" MaxLength="30"></asp:TextBox></TD>
					</TR>
<!---
					<TR valign="top">
						<TD>Owner:&nbsp;</TD>
						<TD><asp:DropDownList cssclass=HTMLFrmObjects  ID="Owner" AutoPostBack="True" Runat="server" style="width:200px;"></asp:DropDownList></TD>
					</TR>
--->
					<TR valign="top">
						<TD>Division:&nbsp;</TD>
						<TD><asp:DropDownList cssclass=HTMLFrmObjects  ID="Division" AutoPostBack="False" Runat="server" style="width:200px;"></asp:DropDownList></TD>
					</TR>
					<%end if%>
					<%if ACN = "Reassign" then %>
					<asp:RequiredFieldValidator id="valcontactTypeReassign" ControlToValidate="contactTypeReassign" ErrorMessage=" - You must select a Contact Type." EnableClientScript="true" Display="None" Runat="server" />
					<asp:RequiredFieldValidator id="valFromUID" ControlToValidate="FromUID" ErrorMessage=" - You must select the Old Contact Name." EnableClientScript="true" Display="None" Runat="server" />
					<asp:RequiredFieldValidator id="valToUID" ControlToValidate="ToUID" ErrorMessage=" - You must select the New Contact Name." EnableClientScript="true" Display="None" Runat="server" />
					<TR valign="top">
						<TD colspan="2">This feature will allow you to assign one person's projects to 
							another.
							<br>
							Simply select the old contact name and select the new contact name of
							<br>
							the person who will receive the projects.</TD>
					</TR>
					<TR valign="top">
						<TD width="45%">Contact Type:</TD>
						<TD width="55%"><asp:DropDownList cssclass=HTMLFrmObjects  ID="contactTypeReassign" AutoPostBack="True" Runat="server" style="width:200px;"></asp:DropDownList></TD>
					</TR>
					<TR valign="top">
						<TD width="45%">Old Contact Name:&nbsp;</TD>
						<TD width="55%"><asp:DropDownList cssclass=HTMLFrmObjects  ID="FromUID" visible="True" AutoPostBack="False" Runat="server" style="width:200px;"></asp:DropDownList></TD>
					</TR>
					<TR valign="top">
						<TD width="45%">New Contact Name:&nbsp;</TD>
						<TD width="55%"><asp:DropDownList cssclass=HTMLFrmObjects  ID="ToUID" visible="True" AutoPostBack="False" Runat="server" style="width:200px;"></asp:DropDownList></TD>
					</TR>
					<%end if%>
					<%if ACN = "Edit" then %>
					<TR valign="top">
						<TD width="45%">Deleted:&nbsp;</TD>
						<TD width="55%"><asp:CheckBox ID="Deleted" Runat="server"></asp:CheckBox></TD>
					</TR>
					<%end if%>
					<%if ACN = "Add" or ACN = "Edit" OR ACN="Delete" or ACN="Reassign" then%>
					<TR valign="top">
						<TD colspan="2" align="center"><br>
							<asp:Button Runat="server" CssClass=Btn ID="SubmitButton" OnClick="SubmitButton_Click"></asp:Button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Button Runat="server" cssclass=Btn ID="Cancel" Text="Cancel" CausesValidation="False" OnClick="Cancel_Click"></asp:Button></TD>
					</TR>
					<%end if
				
				if ACN = "Edit"  or ACN = "Delete"%>
					<asp:RequiredFieldValidator id="valPersonSelection" ControlToValidate="PersonSelection" ErrorMessage=" - You must select a person from the drop down box." EnableClientScript="true" Display="None" Runat="server" />
					<%end if
				if ACN = "Add" or ACN = "Edit" then%>
					<asp:RequiredFieldValidator id="valcontactType" ControlToValidate="contactType" ErrorMessage=" - You must select a Contact Type." EnableClientScript="true" Display="None" Runat="server" />
					<asp:RequiredFieldValidator id="valFirstName" ControlToValidate="FirstName" ErrorMessage=" - First Name is a required field." EnableClientScript="true" Display="None" Runat="server" />
					<asp:RequiredFieldValidator id="valLastName" ControlToValidate="LastName" ErrorMessage=" - Last Name is a required field." EnableClientScript="true" Display="None" Runat="server" />
					<asp:RequiredFieldValidator id="valOfficePhone" ControlToValidate="OfficePhone" ErrorMessage=" - Office Phone is a required field." EnableClientScript="true" Display="None" Runat="server" />
					<!---   revPhone.ValidationExpression = "((\\(\\d{3}\\) ?)|(\\d{3}-))?\\d{3}-\\d{4}";--->
					<asp:RequiredFieldValidator id="valOwner" ControlToValidate="Owner" ErrorMessage=" - You must select at least one Owner." EnableClientScript="true" Display="None" Runat="server" />
					<asp:RequiredFieldValidator id="valDivision" ControlToValidate="Division" ErrorMessage=" - You must select at least one Division." EnableClientScript="true" Display="None" Runat="server" />
					<%end if%>
				</TABLE>
				<%else%>
				<CENTER>
					<asp:DataGrid ID="ViewRecords" AllowSorting="True" OnSortCommand="Sort_Grid" CellPadding="2" CellSpacing="2" HeaderStyle-BackColor="DimGray" HeaderStyle-BorderColor="black" HeaderStyle-Font-Bold="True" HeaderStyle-ForeColor="white" HeaderStyle-Height="18px" GridLines="Vertical" ItemStyle-BackColor="LightGrey" AlternatingItemStyle-BackColor="white" BorderStyle="Inset" BorderWidth="3px" runat="server"></asp:DataGrid>
					<br>
				</CENTER>
				<%end if%>
				<%=TailText%>
			</CENTER>
		</FORM>
	</BODY>
</HTML>
