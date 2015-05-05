<%@ Page Language="vb" AutoEventWireup="false" Codebehind="admin_proj.aspx.vb" Inherits="dotNETViewer.Admin_proj"%>
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
'	The purpose of this page is to provide the HTML interface to administer project field inclusion and ordering.  Most of the HTML
'	on this page is dynamically generated and put into the Public variable 'Information.'
'
'	A javascript function, "Submitit" is used to verify that all form variables are valid.  For example, all fields must have an order
'	value associated with it.  Also - if any sort of imporoper ordering is detected (skipped numbers, invalid numbers, ordering doesn't
'	start at zero, etc.), the user is alerted.
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
		<script language='JavaScript' type='text/javascript'>
	
		function submitit() {
			var Total=0;
			<%
			Dim count, Ttl
			
			Ttl=0
			
			for count = 0 to ItemCount-1
				response.write ("if (document.admin_proj.o" & count & ".value=='') {alert ('Please enter an order value for all items.'); return;}" & vbcrlf)
				Ttl=Ttl + count
			next

			for count = 0 to ItemCount-1
				response.write ("Total=Total + parseInt(document.admin_proj.o" & count & ".value);" & vbcrlf)
			next
			response.write ("if (Total != " & Ttl & ") {alert ('Improper ordering. Please make sure to start at 0, and do not skip any digits (e.g. 0,1,2,...)'); return;}")
			%>
			document.admin_proj.submit();
		}
		</script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>
		<!--#include file="../includes/header.aspx"-->
	</HEAD>
	<BODY>
		<CENTER>
			<%if request("ACN") <> "2" then%>
			<FONT class="SSMsg2">Please select which columns you wish to display and in which 
				order.<br>
				<br>
			</FONT>
			<FORM name="admin_proj" method="post" action="admin_proj.aspx?ACN=2">
				<TABLE cellpadding="0" cellspacing="0" border="0" width="70%">
					<TR>
						<TD>
							<%=Information%>
						</TD>
					</TR>
					<TR>
						<TD align="middle" colspan="3">
							<br>
							<br>
							<input type=button class=Btn onclick="submitit();" value="Submit">&nbsp;&nbsp;&nbsp;&nbsp;<input type=button class=Btn onclick="document.location='admin_intro.aspx'" value="Main Menu">
						</TD>
					</TR>
				</TABLE>
			</FORM>
			<%else%>
			<FONT class="SSMsg2">Your settings have been successfully saved.<br>
				<br>
				<a href="admin_intro.aspx">Click Here</a> to go back. </FONT>
			<%end if%>
		</CENTER>
	</BODY>
</HTML>
