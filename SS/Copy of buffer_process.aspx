<%@ Page Language="vb" AutoEventWireup="false" Codebehind="buffer_process.aspx.vb" Inherits="dotNETViewer.buffer_process" %>
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
'	The purpose of this page is to provide the HTML interface to the main buffer processing page.  The majority of the processing
'	logic for this page is in the VB page.  The public variable Information houses all the HTML code generated at run-time and is
'	presented on this ASPX page.
'
'************************************************************************************************************************************
%>
<%
On Error Resume Next
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD><TITLE>buffer_process</TITLE>
	<script language='JavaScript' type='text/javascript'>
	<%=JS%>

		var undef;
		var prefix;
		
		if (opener==undef) {prefix=top.MapFrame;}else{prefix=opener.top.MapFrame;}

		function calcHeight(o)
		//this function is used to calcualte the hight of the window this page is to be put into - so we take up the entire floating
		//window (minus margins, etc.)
		{
			var the_height=document.getElementById(o).contentWindow.document.body.scrollHeight;//find the height of the internal page
			document.getElementById(o).style.height=the_height+20;//change the height of the iframe
		}

		function NewBuff() {
			//Instead of buffering around a pre-existing highlighted area, user clicks on a button to start a brand new buffer.
			//This function sets the stage to do this for them.
			top.bufX1=0;
			top.bufY1=0;
			top.bufLyr=0;
		
			prefix.BuffStuff('');
		}
	
	</script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>
		<!--#include file="../includes/header.aspx"-->
	</HEAD>
	<BODY <%=AfterLoad%>>
		<!--- GeopriseVariables.txt file variable BData --->
		<!--- 0 - don't display anything (Buffer results page will be blank) --->
		<!--- 1 - Display only shape file data --->
		<!--- 2 - Display only customer's custom ASP file --->
		<%=Information%>
		<!---
		<%if trim(Information)<>"" then%><input type=button class=BTN onclick="NewBuff();" value="Start Over"><br><br><%end if%>
		--->
	</BODY>


</HTML>
