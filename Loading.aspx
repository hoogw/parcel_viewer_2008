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
'	The purpose of this page is to provide a common 'loading' page while the application loads up.  The background of the web browser
'	is completely gray, and the 'loading' graphic is centered both horizontally and vertically.
'
'	The application variable "CS" is the colour scheme (blue, red, root beer, etc.)
'
'************************************************************************************************************************************
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<HTML>
	<HEAD>
		<TITLE>Loading</TITLE></HEAD><BODY bgcolor="#dddddd" style="cursor:wait;"><TABLE height="100%" width="100%" cellpadding="0" cellspacing="0">
			<TR valign="middle">
				<TD valign="middle"><CENTER><img src="images/<%=Application("LoadingGraphic")%>" border="0"></CENTER>
				</TD>
			</TR>
		</TABLE>
	</BODY>
</HTML>
