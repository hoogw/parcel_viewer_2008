<%@ Page Language="vb" AutoEventWireup="false" Codebehind="BM_Drawing.aspx.vb" Inherits="dotNETViewer.BM_Drawing"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<TITLE>Bookmark</TITLE>
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
'	The purpose of this page is to provide the HTML interface to allow a user to draw on a map using pre-defined drawing tools:
'	points/lines, polygons, circles, and call-out boxes.  All the user has to do is select the radio button corresponding to the
'	object they wish to create.  Once this radio button is selected, all other drawing options will be grayed out until the user
'	clicks on the "complete" button for the drawing object they are creating.
'
'	Drawing objects are individually saved to the database.
'
'	top.dwgFRM - This is a top-level javascript variable which is set to the document of this page.  It is SO much easier to do it
'	like this rather than having to figure out the correct javascript object paths to point to the objects on this dang page!
'
'************************************************************************************************************************************
%>
		<!--#include file="../includes/header.aspx"-->
		<script language='JavaScript' type='text/javascript'>
			
			function DrgTool(shape) {
				//Based upon what type of shape the user is trying to create, let's gray out all other shapes.  For example, if the
				//user selects circle, then have all the other shape options grayed out.
				if (shape=='point') {
					top.MapFrame.SetCurrTool(30,2);
					showExtraParameters(0);
				}
				if (shape=='line') {
					top.MapFrame.SetCurrTool(31,2);
					showExtraParameters(2);
				}
				if (shape=='polygon') {
					top.MapFrame.SetCurrTool(32,2);
					showExtraParameters(2);
				}
				if (shape=='circle') {
					top.MapFrame.SetCurrTool(33,2);
					showExtraParameters(1);
					try {document.BMForm.radius.focus();} catch(e){};
				}
				if (shape=='text') {
					top.MapFrame.SetCurrTool(34,2);
					showExtraParameters(0);
					top.MapFrame.addText();
					top.MapFrame.AText = top.MapFrame.aText1;
					top.MapFrame.AText.value = "";
					top.MapFrame.AText.size = 4;
					top.MapFrame.ATextXPrev = 0;
					top.MapFrame.ATextYPrev = 0;
				}
				if (shape=='delete') {
					top.MapFrame.clearVML();
					top.MapFrame.clearMeasureVar();
					top.MapFrame.initAllElements();
				}
				if (shape=='refresh') {
				
					var objMF = top.MapFrame.findObj("MapFunction")
					if (objMF!=null) {
						objMF.value=30;
						top.MapFrame.RefreshMap();
					}
				}
			}
			
			function CreateCircle(r) {
				//This function calls map function 150 - which creates a circle of specified radius and center point.
				top.MapFrame.positionLoadingLyr();

				var objMF = top.MapFrame.findObj("MapFunction")
				var objRad = top.MapFrame.findObj("Radius")

				if (objMF!=null) {
					objRad.value = document.BMForm.radius.value;
					objMF.value=150;
					top.MapFrame.RefreshMap();
				}
			}

			function showExtraParameters(theindex) {
				//This function takes care of showing/hiding the drawing options to the user.  For example, if a user selects circle, then all options
				//except circle should be grayed out.
				if (document.getElementById) {  
					switch (theindex) {
						case 0:
								document.getElementById('xtraParams1').style.display = 'block';
								document.getElementById('xtraParams2').style.display = 'none';
								document.getElementById('xtraParams3').style.display = 'none';
								break;
						case 1:
								document.getElementById('xtraParams1').style.display = 'none';
								document.getElementById('xtraParams2').style.display = 'block';
								document.getElementById('xtraParams3').style.display = 'none';
								break;
						case 2:
								document.getElementById('xtraParams1').style.display = 'none';
								document.getElementById('xtraParams2').style.display = 'none';
								document.getElementById('xtraParams3').style.display = 'block';
								break;
					}
				} else {
					switch (theindex) {
						case 0:
							document.layers['xtraParams1'].visibility = "show";
							document.layers['xtraParams2'].visibility = "hide";
							document.layers['xtraParams3'].visibility = "hide";
							break;
						case 1:
							document.layers['xtraParams1'].visibility = "hide";
							document.layers['xtraParams2'].visibility = "show";
							document.layers['xtraParams3'].visibility = "hide";
							break;
						case 2:
							document.layers['xtraParams1'].visibility = "hide";
							document.layers['xtraParams2'].visibility = "hide";
							document.layers['xtraParams3'].visibility = "show";
							break;
					}
				}
			}
			
			function CloseWin() {
				//Close the floating window.
				top.MapFrame.hideKLayer(top.MapFrame.lyrBMDrawing);
			}

			function RefreshMap() {
				
			}
			
			function SESubmit() {
				//DrgTool('refresh');
				if (document.BMForm.Jurisdiction.selectedIndex==0) {alert ("Please choose a jurisdiction!");return;}
				
				document.location="BM_Create.aspx?UserName=<%=session("RGISUserName")%>&BMJ=" + document.BMForm.Jurisdiction.options[document.BMForm.Jurisdiction.selectedIndex].value + "&BMName=" + document.BMForm.SMUName.value + "&c=" + document.BMForm.SpatialEditComments.value;
			}
			
		</script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>
	</HEAD>
	<!--- U: <%=Session("RGISUserName")%> --->
	<!--- A: <%=Session("RGISUserAgency")%> --->
	<!--- C: <%=Application("ClientName")%> --->
	<BODY onload="top.dwgFRM=document.BMForm; DrgTool('delete'); showExtraParameters(0); ">
		<FORM id="BMForm" name="BMForm" runat="server">
			<table cellpadding="0" cellspacing="0" border="0" width="100%">
				<tr>
					<TD align="center" bgcolor="#bbbbbb"><b>Drawing Tools</b></TD>
				</tr>
			</table>
			<hr color="black">
			<table cellpadding="0" cellspacing="0" border="1" bordercolor="black" align="center">
				<tr>
					<td>
						<table WIDTH="250" cellpadding="1" cellspacing="1" border="0">
							<tr>
								<TD align="center" bgcolor="#bbbbbb"><b><FONT class="SSMsg2"><B>Choose a Drawing Tool:</B></FONT></b></TD>
							</tr>
							<tr>
								<td align="center">
									<input type="button" title="Point" onclick="DrgTool('point');" style="BACKGROUND:url(../images/menuicons/dwg_point.gif); WIDTH:25px; HEIGHT:25px">&nbsp;
									<input type="button" title="Line" onclick="DrgTool('line');" style="BACKGROUND:url(../images/menuicons/dwg_line.gif); WIDTH:25px; HEIGHT:25px">&nbsp;
									<input type="button" title="Polygon" onclick="DrgTool('polygon');" style="BACKGROUND:url(../images/menuicons/dwg_polygon.gif); WIDTH:25px; HEIGHT:25px">&nbsp;
									<input type="button" title="Circle" onclick="DrgTool('circle');" style="BACKGROUND:url(../images/menuicons/dwg_circle.gif); WIDTH:25px; HEIGHT:25px">&nbsp;
									<input type="button" title="Text" onclick="DrgTool('text');" style="BACKGROUND:url(../images/menuicons/dwg_text.gif); WIDTH:25px; HEIGHT:25px">&nbsp;
									<input type="button" title="Delete Drawings" onclick="DrgTool('delete');" style="BACKGROUND:url(../images/menuicons/dwg_delete.gif); WIDTH:25px; HEIGHT:25px">&nbsp;
									<input type="button" title="Refresh Map" onclick="DrgTool('refresh');" style="BACKGROUND:url(../images/menuicons/dwg_refresh.gif); WIDTH:25px; HEIGHT:25px">&nbsp;
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td>
						<table WIDTH="250" cellpadding="1" cellspacing="1" border="0">
							<tr>
								<TD align="center" bgcolor="#bbbbbb"><b><FONT class="SSMsg2"><B>Extra Parameters:</B></FONT></b></TD>
							</tr>
							<TR id="xtraParams1" style="DISPLAY: none">
								<td>N/A</td>
							</TR>
							<TR id="xtraParams2" style="DISPLAY: none">
								<td><br>
									<b>Circle Radius</b>:&nbsp;&nbsp;&nbsp;<input id="radius" type="text" class="HTMLFrmObjects" maxLength="6" size="6" name="radius"
										value="1000">&nbsp;<%=Application("MapUnits")%>
									<br>
									<br>
								</td>
							<TR id="xtraParams3" style="DISPLAY: none">
								<td><br>
									<font color="red"><B>Double-click</B> on map to finish drawing and start a new 
										drawing object.</font>
									<br>
									<br>
								</td>
							</TR>
							<%if request("spedit")="1" then%>
							<TR>
								<td><hr>
									<b>
										<center>Spatial Edit Request Instructions</center>
									</b>
									<br>
									<font color="red">Use the drawing tools to make your markups. When done, please add 
										any comments below, commit your drawings, and click on the submit button.</font><br>
									<br>
									<font class="ssmsg2">Brief Name:</font><br>
									<input type="text" style="WIDTH:240px" name="SMUName"><br>
									<font class="ssmsg2">Jurisdiction:</font><br>
									<select name=Jurisdiction><%=JurisdictionDD%></select><br>
									<font class="ssmsg2">Comments:</font><br>
									<textarea style="WIDTH:240px; HEIGHT:40px" id="SpatialEditComments"></textarea><br>
									<center><input type="button" class="btn" onclick="DrgTool('refresh');" value="Commit Drawings">&nbsp;&nbsp;<input type="button" name="SpatialEditSubmit" class="btn" value="Submit" onclick="SESubmit();"></center>
								</td>
							</TR>
							<%end if%>
						</table>
					</td>
				</tr>
			</table>
			</TD></TR></TABLE>
		</FORM>
		<%if request("spedit")<>"1" then%>
		<CENTER><input type="button" class="btn" onclick="DrgTool('refresh');" value="Commit Drawings"><!---<br><a href="../EconDev/EDInstructions.aspx?ID=BMDrawing">Drawing Instructions</a><br><br>---></CENTER>
		<%end if%>
	</BODY>
</HTML>
