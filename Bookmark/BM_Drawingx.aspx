<%@ Page Language="vb" AutoEventWireup="false" Codebehind="BM_Drawing.aspx.vb" Inherits="dotNETViewer.BM_Drawing"%>
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
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<TITLE>Bookmark</TITLE> 
		<!--#include file="../includes/header.aspx"-->
		<script language='JavaScript' type='text/javascript'>
			
			function DrgTool(shape) {
				//Based upon what type of shape the user is trying to create, let's gray out all other shapes.  For example, if the
				//user selects circle, then have all the other shape options grayed out.
				if (shape=='pl') {
					top.MapFrame.SetCurrTool(100,2);
					showlayer(0);
				}
				if (shape=='circle') {
					top.MapFrame.SetCurrTool(102,2);
					showlayer(1);
				}
				if (shape=='callout') {
					top.MapFrame.SetCurrTool(101,2);
					showlayer(2);
				}
				if (shape=='poly') {
					top.MapFrame.SetCurrTool(103,2);
					showlayer(3);
				}
			}
			
			function ReSetDrawing() {
				//This function will call map function 140 - which resets and deletes all drawing objects & starts with a clean slate.
				top.MapFrame.positionLoadingLyr();

				top.dwgPL=0;
				top.dwgPoly=0;
				top.dwgC=0;
				top.dwgCO=0;
				top.dwgPolyPCt=0;
				top.MapFrame.RefreshBMDwgWindow();
				
				var objMF = top.MapFrame.findObj("MapFunction")

				if (objMF!=null) {
					objMF.value=140;
					top.MapFrame.RefreshMap();
				}
			}

			function NewObject() {
				//This function calls map function 200 - which saves the current drawing object to DB.
				top.MapFrame.positionLoadingLyr();

				top.dwgPL=0;
				top.dwgPoly=0;
				top.dwgC=0;
				top.dwgCO=0;
				top.dwgPolyPCt=0;
				top.MapFrame.RefreshBMDwgWindow();

				var objMF = top.MapFrame.findObj("MapFunction")

				if (objMF!=null) {
					objMF.value=200;
					top.MapFrame.RefreshMap();
				}

			}

			function RemoveLabels() {
				//This function calls map function 220 - which removes all the green numbered labels from the map.
				top.MapFrame.positionLoadingLyr();

				var objMF = top.MapFrame.findObj("MapFunction")

				if (objMF!=null) {
					objMF.value=220;
					top.MapFrame.RefreshMap();
				}

			}

			function RemoveLastPoint() {
				//This function calls map function 130 - which removes the last point when doing a line or ploygon.
				top.MapFrame.positionLoadingLyr();

				var objMF = top.MapFrame.findObj("MapFunction")

				if (objMF!=null) {
					objMF.value=130;
					top.MapFrame.RefreshMap();
				}
			}

			function CreateCircle(r) {
				//This function calls map function 150 - which creates a circle of specified radius and center point.
				top.MapFrame.positionLoadingLyr();

				var objMF = top.MapFrame.findObj("MapFunction")
				var objRad = top.MapFrame.findObj("Radius")

				if (objMF!=null) {
					objMF.value=150;
					objRad.value = document.BMForm.radius.value;
					top.MapFrame.RefreshMap();
				}
			}

			function CreateCallOut(r) {
				//This function calls map function 160 - which creates a call out of specified text and center point.
				top.MapFrame.positionLoadingLyr();

				var objMF = top.MapFrame.findObj("MapFunction")
				var objCOT = top.MapFrame.findObj("CallOutText")

				if (objMF!=null) {
					objMF.value=160;
					objCOT.value = document.BMForm.callouttext.value;
					top.MapFrame.RefreshMap();
				}
			}

			function CompletePoly () {
				//This function calls map function 170 - which completes a polygon (of at least three points).
				if (top.dwgPolyPCt<3) {
					alert ("Polygons require at least 3 points. You currently have " + top.dwgPolyPCt + ".");
					return;
				}
				
				top.MapFrame.positionLoadingLyr();

				var objMF = top.MapFrame.findObj("MapFunction")

				if (objMF!=null) {
					objMF.value=170;
					top.MapFrame.RefreshMap();
				}
			}
			
			function showlayer(theindex) {
				//This function takes care of showing/hiding the drawing options to the user.  For example, if a user selects circle, then all options
				//except circle should be grayed out.
				if (document.getElementById) {  
					switch (theindex) {
						case 0:
								document.getElementById('plRow').style.display = 'block';
								document.getElementById('polyRow').style.display = 'none';
								document.getElementById('CircleRow').style.display = 'none';
								document.getElementById('CORow').style.display = 'none';
								break;
						case 1:
								document.getElementById('plRow').style.display = 'none';
								document.getElementById('polyRow').style.display = 'none';
								document.getElementById('CircleRow').style.display = 'block';
								document.getElementById('CORow').style.display = 'none';
								break;
						case 2:
								document.getElementById('plRow').style.display = 'none';
								document.getElementById('polyRow').style.display = 'none';
								document.getElementById('CircleRow').style.display = 'none';
								document.getElementById('CORow').style.display = 'block';
								break;
						case 3:
								document.getElementById('plRow').style.display = 'none';
								document.getElementById('polyRow').style.display = 'block';
								document.getElementById('CircleRow').style.display = 'none';
								document.getElementById('CORow').style.display = 'none';
								break;
					}
				} else {
					switch (theindex) {
						case 0:
							document.layers['plRow'].visibility = "show";
							document.layers['polyRow'].visibility = "hide";
							document.layers['CircleRow'].visibility = "hide";
							document.layers['CORow'].visibility = "hide";
							break;
						case 1:
							document.layers['plRow'].visibility = "hide";
							document.layers['polyRow'].visibility = "hide";
							document.layers['CircleRow'].visibility = "show";
							document.layers['CORow'].visibility = "hide";
							break;
						case 2:
							document.layers['plRow'].visibility = "hide";
							document.layers['polyRow'].visibility = "hide";
							document.layers['CircleRow'].visibility = "hide";
							document.layers['CORow'].visibility = "show";
							break;
						case 3:
							document.layers['plRow'].visibility = "hide";
							document.layers['polyRow'].visibility = "show";
							document.layers['CircleRow'].visibility = "hide";
							document.layers['CORow'].visibility = "hide";
							break;
					}
				}
			}
			
			function CloseWin() {
				//Close the floating window.
				top.MapFrame.hideKLayer(top.MapFrame.lyrBMDrawing);
			}

		</script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>
	</HEAD>
	<BODY onload="top.dwgFRM=document">
		<FORM id="BMForm" name="BMForm" runat="server">
			<FONT class="sshdr1">Bookmark Drawing Tools</FONT><br>
			<br>
			<TABLE cellSpacing="0" cellPadding="2" border="0">
				<TR>
					<TD colSpan="2"><FONT class="ssmsg2">Please select the object you'd like to create:</FONT></TD>
				</TR>
				<TR id="PLradioRow">
					<TD colSpan="2"><FONT class="ssmsg2"><input id="point" onclick="DrgTool('pl');" type="radio" name="dt">Point 
							or Line</FONT></TD>
				</TR>
				<TR id="plRow" style="DISPLAY: none">
					<TD colSpan="2"><FONT class="ssmsg2">
							<OL>
								<LI>
								Select point(s) on the map
								</li>
								<LI>
								<input type=button class=Btn value="Complete" onclick="NewObject();">&nbsp;when done.
								</li>
							</ol>
							<CENTER><input type=button class=Btn value="Delete Last Point" onclick="RemoveLastPoint();"></CENTER>
					</TD>
				</TR>
				<TR id="PolyradioRow">
					<TD colSpan="2"><FONT class="ssmsg2"><input id="polygon" onclick="DrgTool('poly');" type="radio" name="dt">Polygon</FONT></TD>
				</TR>
				<TR id="polyRow" style="DISPLAY: none">
					<TD colSpan="2"><FONT class="ssmsg2">
							<OL>
								<LI>
								Select at least three points on the map
								</li>
								<LI><input type=button class=Btn value="Close Polygon" onclick="CompletePoly();">&nbsp;when done.
								</li>
							</ol>
							<CENTER><input type=button class=Btn value="Delete Last Point" onclick="RemoveLastPoint();"></CENTER>
					</TD>
				</TR>
				<TR id="CradioRow">
					<TD colSpan="2"><FONT class="ssmsg2"><input id="circle" onclick="DrgTool('circle');" type="radio" name="dt">Circle</FONT></TD>
				</TR>
				<TR id="CircleRow" style="DISPLAY: none">
					<TD colSpan="2"><FONT class="ssmsg2">
							<OL>
								<LI>
								Select a point on the map
								<LI>
									Enter a radius value:<br>
									<br>
									<input id="radius" type="text" maxLength="6" size="6" name="radius">&nbsp;<%=Application("MapUnits")%><LI><input type=button class=Btn value="Complete" onclick="CreateCircle();">
								</li>
							</ol>
						</FONT>
					</TD>
				</TR>
				<TR id="COradioRow">
					<TD colSpan="2"><FONT class="ssmsg2"><input id="circle" onclick="DrgTool('callout');" type="radio" name="dt">Text 
							Label</FONT></TD>
				</TR>
				<TR id="CORow" style="DISPLAY: none">
					<TD colSpan="2"><FONT class="ssmsg2">
							<OL>
								<LI>
								Select a point on the map
								<LI>
									Enter the text:<br>
									<textarea id="callouttext" rows="5" cols="25"></textarea>
								<LI>
									<input type=button class=Btn value="Complete" onclick="CreateCallOut();">
								</li>
							</ol>
						</FONT>
					</TD>
				</TR>
				<TR>
					<TD align="center" colSpan="2"><br>
						<input type=button class=Btn value="Restart" onclick="ReSetDrawing();">
						<br>
						<br>
						<input type=button class=Btn value="Close Window" onclick="CloseWin();">
					</TD>
				</TR>
				<TR>
					<TD align="center" colSpan="2">
						<CENTER><a href="../EconDev/EDInstructions.aspx?ID=BMDrawing">Drawing Instructions</a>
					</TD>
				</TR>

				<TR>
					<TD align="center" colSpan="2">
						<hr>
					</TD>
				</TR>
				<%if 0 then%>
				<%if BMDelete.Items.Count>1 then%>
				<TR>
					<TD align="center" colSpan="2"><FONT class="SSHdr1">Delete Drawing Object</FONT></TD>
				</TR>
				<TR>
					<TD colspan="2"><br>
						<asp:DropDownList cssclass=HTMLFrmObjects  ID="BMDelete" Visible="False" AutoPostBack="True" Runat="server" Width="150"></asp:DropDownList></TD>
				</TR>
				<TR>
					<TD colspan="2" align="center"><a href="javascript:RemoveLabels();">Remove Numbered 
							Labels</a></TD>
				</TR>
				<%end if%>
				<%end if%>
			</TABLE>
		</FORM>
	</BODY>
</HTML>
