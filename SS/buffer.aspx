<%@ Page CodeBehind="buffer.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="dotNETViewer.buffer" %>
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
'	hideLoadingLyr() - In the body's onload clause, this javascript function is executed.  This function resides in nav.js and the
'	purpose of this function is to hide the layer which houses the loading image.
'
'	The purpose of this page is to provide the HTML interface to allow a user to facilitate a buffer function.  This page appears
'	in the wide window on the bottom of the application.  By the time this page is called, the user has already selected the first
'	layer to buffer 'around' and the area of interest.  This page allows a user to continue the buffering process by selecting the
'	second layer to buffer 'on', the buffer distance, and the field(s) to be displayed when buffering results appear.
'
'************************************************************************************************************************************
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
<%
On Error Resume Next
%>
	<script language='JavaScript' type='text/javascript'>
		
	function sendValue(Value1,Value2,Value3) {
		//This function submits the buffer page to the main buffer processing page.
		
		var objBFieldsSpan=top.MapFrame.findObj("BFieldsSpan",document.frmBuffer);
		var tmpF="";
		var i;

		//Make sure the user has selected a layer to buffer around
		if (Value2=="") {
			alert ("Please select a layer to buffer around.");
			return;
		}
		
		//User must select at least one field to display when buffering results shall appear
		if (objBFieldsSpan==null) {
			alert ("Invalid Fields drop down.");
			return;
		}

		//Stuff all the field Indexes into a comma delimited list - and pass that along to the processing page.
		for (i=0; i<=document.frmBuffer.BFields.options.length-1; i++) {
			if (document.frmBuffer.BFields.options[i].selected) {
				tmpF=tmpF + document.frmBuffer.BFields.options[i].value + ','
			}
		}
		tmpF=tmpF + "-1";

		top.MapFrame.url="";
		BufUrl=top.MapFrame.findObj("BufUrl")
		BufUrl.value=""
		
		//Moving right along, we can now go to the main buffer processing page
		var newloc="buffer_process.aspx?p=1&minx=<%=Request("minX")%>&miny=<%=Request("minY")%>&maxx=<%=Request("maxX")%>&maxy=<%=Request("maxY")%>&b=" + Value1+"&l="+Value2+"&LtB="+Value3+"&F="+tmpF;
		top.MapFrame.newwindow(newloc,'height=500,width=750,menubar=no,resizable=yes,tollbar=no,scrollbars=yes','BufferResults')
		//document.location = newloc;
	}

	function AlterBFields() {
		//When a user selects a layer to buffer around, the list of fields must dynamically change real-time.
		//Note the BFieldsJS variable - this is dynamically generated Javascript code which will facilitate this dynamic nature for us.
		if (document.frmBuffer.BLayer.selectedIndex<=0) {return;}
		var lyr=document.frmBuffer.BLayer.options[document.frmBuffer.BLayer.selectedIndex].value;
		var objBFieldsSpan=top.MapFrame.findObj("BFieldsSpan",document.frmBuffer);
		
		<%=BFieldsJS%>
	}

	</script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>

	<!--#include file="../includes/header.aspx"-->

	</HEAD>
	<BODY class="colr" LEFTMARGIN="2" TOPMARGIN="0" RIGHTMARGIN="0" onload="top.MapFrame.hideLoadingLyr(); top.bufferextract='1';">
		<FORM name="frmBuffer" method="post" action="javascript:sendValue(frmBuffer.BFeet[frmBuffer.BFeet.selectedIndex].value,frmBuffer.BLayer[frmBuffer.BLayer.selectedIndex].value,'<%=Request("LtB")%>');">
		<table cellpadding=0 cellspacing=0 border=0 width=100%><tr><TD align="center" bgcolor="#bbbbbb"><b>Buffer Step 2</b></td></tr></table>
		<hr color=black>
			<table cellpadding=0 cellspacing=0 border=1 bordercolor=black align=center>
			<tr><td>
			<table WIDTH="250" cellpadding=1 cellspacing=1 border=0>
				<tr><TD align="center" bgcolor="#bbbbbb"><b><FONT class="SSMsg2"><B>Buffer Distance:</B></FONT></TD></tr>
				<tr><td><select  class=HTMLFrmObjects  name="BFeet"><%response.write (BFeetOptions)%></select>&nbsp;<%=Application("MapUnits")%></TD>
				</tr>
			</table>
			</td></tr>
			<tr><td>
			<table WIDTH="250" cellpadding=1 cellspacing=1 border=0>
				<tr><TD align="center" bgcolor="#bbbbbb"><b><FONT class="SSMsg2"><B>Buffer Layer:</B></FONT></TD></tr>
				<tr><td><select  class=HTMLFrmObjects  name="BLayer" onchange="AlterBFields();" style="width:240px"><option value="">Select a Layer...</option><% response.write (SelectOptions)%></select></TD>
				</tr>
			</table>
			</td></tr>
			<tr><td>
			<table WIDTH="250" cellpadding=1 cellspacing=1 border=0>
				<tr><TD align="center" bgcolor="#bbbbbb"><b><FONT class="SSMsg2"><B>Display Fields:</B></FONT></TD></tr>
				<tr><td><span id="BFieldsSpan"></span></TD>
				</tr>
			</table>
			</td></tr>
			</TABLE>
			</td></tr>
			</table>
<center>
<br><INPUT type="submit" class=Btn value="Buffer" name="theButton">
</center>
		</FORM>
		
		<script language='JavaScript' type='text/javascript'>
			function NewBuff() {
				//Instead of buffering around a pre-existing highlighted area, user clicks on a button to start a brand new buffer.
				//This function sets the stage to do this for them.
				top.bufX1=0;
				top.bufY1=0;
				top.bufLyr=0;
			
				top.MapFrame.BuffStuff('');
			}
			
			if (top.bufX1!=0 &&	top.bufY1!=0 &&	top.bufLyr!=0) {
				document.write ("<br><a href=javascript:NewBuff();>Click Here</a> to start Buffering from Step 1.<br><br>");
			}else{
				document.write ("<br><a href=javascript:NewBuff();>Click Here</a> to start over.<br><br>");
			}
		</script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>
	</BODY>
</HTML>
