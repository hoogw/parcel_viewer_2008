<%@ Page Language="vb" AutoEventWireup="false" Codebehind="extract_predefined.aspx.vb" Inherits="dotNETViewer.extract_predefined"%>
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
'	The purpose of this page is to provide the HTML interface to the first step of feature extracting.  
'
'************************************************************************************************************************************
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<TITLE>Pre-Defined Extraction</TITLE> 
		<!--#include file="../includes/header.aspx"-->
	</HEAD>
	
	<BODY onload="top.HaltLYRHide=0; top.MapFrame.hideLoadingLyr(); top.MapFrame.SetCurrTool(2,2); top.MapFrame.clearMeasureVar();">
		<table cellpadding=0 cellspacing=0 border=0 width=100%><tr><TD align="center" bgcolor="#bbbbbb"><b>Feature Extraction Results</b></td></tr>
		</table>
		<hr color=black>

		<center>
		<TABLE cellpadding=0 cellspacing=0 border=1 bordercolor=black width=250>
		<TR><TD><TABLE cellpadding=1 cellspacing=1 border=0 width=250><tr bgcolor=#cccccc><td align=center><FONT class=ssmsg2><b>Selection Criteria</b></td></tr><tr><td>
		<table cellpadding=1 cellspacing=1 border=0>
		<%
		if ( instr(ucase(request.form("selectby")),"CITY OF")>0) then
			response.write ("<tr><td width=85><b>Select By</b>:</td><td>City of " & mid(trim(request.form("selectby")),instr(trim(ucase(request.form("selectby"))),"CITY OF")+7) & "</td></tr>")
		else
			response.write ("<tr><td><b>Select By</b>:</td><td>" & trim(request.form("selectby")) & "</td></tr>")
		end if

		if trim(request.form("startdate"))<>"01/01/1900" then
			response.write ("<tr><td><b>Start Date</b>:</td><td>" & request.form("startdate") & " " & request.form ("StartYear") & "</td></tr>")
		end if
		if trim(request.form("enddate"))<>"01/01/2500" then
			response.write ("<tr><td><b>End Date</b>:</td><td>" & request.form("enddate") & " " & request.form ("EndYear") & "</td></tr>")
		end if
		if trim(request.form("status"))<>"" then
			response.write ("<tr><td><b>Status</b>:</td><td>" & request.form("Status") & "</td></tr>")
		end if
		%>
		<tr><td>&nbsp;</td></tr>
		</table>

		</TD></TR></td></tr></table></td></tr><tr><td><TABLE cellpadding=1 cellspacing=1 border=0 width=250><tr bgcolor=#cccccc><td align=center><FONT class=ssmsg2><b>File Download</b></font></td></tr><tr><td align=center>
		<%if trim(FileURL) <> "" then%>
			<br><b><a href='<%=FileURL%>'>Click Here</a> to download your shape file(s) in compressed ZIP format.</b><br>
		<%else%>
			<br><b>There was an error producing your file - please contact your system admininstrator</b>
		<%end if%>
		<%if trim(DBFFileURL) <> "" then%>
			<br><b><a href='<%=DBFFileURL%>'>Click Here</a> to download your ZIP file with </b>
			<font color=red>
			<%if instr(ucase(request.form("selectby")),"CITY OF")>0 then%>
			all <%=Trim(Request.Form("status"))%> DB edit records for your city.
			<%else%>
			all <%=Trim(Request.Form("status"))%> DB edit records.
			<%end if%>
			</font><br>
		<%end if%>
		<tr><td>&nbsp;</td></tr>

		</TD></TR></td></tr></table></td></tr><tr><td><TABLE cellpadding=1 cellspacing=1 border=0 width=250><tr bgcolor=#cccccc><td align=center><FONT class=ssmsg2><b>Start Over</b></font></td></tr><tr><td align=center>
		<br><b><a href='extract_step1.aspx'>Click Here</a> to do another extract.</b>
		<tr><td>&nbsp;</td></tr>

		</TD></TR></td></tr></table></td></tr></table>

		
	</BODY>
</HTML>
