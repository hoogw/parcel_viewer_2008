<%@ Page Language="vb" AutoEventWireup="false" Codebehind="admin_cp.aspx.vb" Inherits="dotNETViewer.Admin_cp" %>
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
'	The ASPX page is very simple here.  All we do is display the HTML code dynamically generated by the VB page: Information variable.
'	A .NET Data Grid (SelectRecords) is also displayed which shows coordinated projects (if any are found).
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
		<FORM name="CP" method="post" action="admin_cp.aspx?Pass=4">
			<CENTER>
				<asp:DataGrid ID="SelectRecords" HeaderStyle-HorizontalAlign="Center" HeaderStyle-VerticalAlign="Middle" CellPadding="2" Font-Size="7px" CellSpacing="0" HeaderStyle-BackColor="DimGray" HeaderStyle-Font-Bold="True" HeaderStyle-ForeColor="white" HeaderStyle-Height="6px" GridLines="Both" ItemStyle-BackColor="LightGrey" AlternatingItemStyle-BackColor="white" BorderStyle="Inset" BorderWidth="1px" BorderColor="black" runat="server"></asp:DataGrid>
				<%=Information%>
				<%=TailText%>
			</CENTER>
		</FORM>
	</BODY>
</HTML>
