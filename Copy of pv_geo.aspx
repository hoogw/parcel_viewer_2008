<%@ Page Language="vb" AutoEventWireup="false" Codebehind="pv_geo.aspx.vb" Inherits="dotNETViewer.pv_geo" %>
<!---.NET application         --->
<!---Programmer: Allen Briscoe-Smith  --->
<!---<%=User.Identity.Name%>--->

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
'	Initially, loading of this page must happen in 2 steps.  The first step will determine the browser's height and width.  This is
'	important so we know how to draw our floating windows, map images, etc.  EVERYTHING is based off of the size of our browser window.
'	The first 'pass' is necessary only when the application is first opening up.  The second 'pass' occurs 99.9% of the time - all the
'	other times this page is requested and the browser height/width is already known. 
'
'	This page is the presentation page for the entire application.  All of the processing happens in pv_process, and all the viewable
'	stuff happens here.  So this page is very important!  There is a TON of javascript going on in the background to make everything
'	work in synch.  Also in this page, we define most of the DIV layers which are used to make the application come alive.  Of course
'	most of the work is done in the VB file and the HTML DIV tags are rendered at run-time, but we do have a lot of DIV tags in the
'	ASPX page here.
'
'	Loading			This layer houses the loading graphic.
'	HideAll			This layer is a clear glass sheet over the entire browser window so a user doesn't randomly click on the map
'					while the application is trying to process a request.  ONE AT A TIME, folks!
'	titlebar		This layer is responsible for displaying the top title bar area.  This includes the client logo, and custom links 
'					drop down.
'	titlebarHorizLine This is the colourful horizontal line which separates the map area from the menu area.
'	titlebarNav		This layer contains all of the menu drop down images.  Dynamically generated depending on which items need to appear.
'	ClientTitle		This layer contains the title graphic.
'	EconDev			For Econ Dev, this layer is the right docked layer.
'	EconDevLeftCol	For Econ Dev, this layer is the left column strip (and location of the vertical Toolbar)
'	EconDevContent	For Econ Dev, this layer is the content area for econ dev processing (custom search pages, etc.)
'	ToolbarFloat			This layer contains the right most Toolbar icons (zoom in, zoom out, pan, etc.)
'	PanBGL			This layer appears only if pan arrows are desired (wizard setting).  This layer is the left vertical strip.
'	PanBGR			This layer appears only if pan arrows are desired (wizard setting).  This layer is the right vertical strip.
'	PanBGT			This layer appears only if pan arrows are desired (wizard setting).  This layer is the top horizontal strip.
'	PanBGB			This layer appears only if pan arrows are desired (wizard setting).  This layer is the bottom horizontal strip.
'
'************************************************************************************************************************************
%>
<%
On Error Resume Next

Application("MenuStyle")="1"

If Session("PassedPVGeo") = 1 Then
%>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1"> 
<html xmlns:v="urn:schemas-microsoft-com:VML">
 	<HEAD><TITLE>.NET Application</TITLE>
	<!--#include file="includes/header.aspx"-->
	<DIV id="Loading" style="position:absolute;border:0px;z-index:1;left:0px;top:0px;visibility:hidden;"><img src="images/<%=Application("LoadingGraphic")%>" border="0"></TD></DIV>
	<DIV id="HideAll" align="left" style="overflow:hidden;z-index:100;cursor:wait;position:absolute;left:0px;top:0px;width:<%response.write(Session("mapWidth"))%>px;height:<%response.write (Session("mapHeight"))%>px; visibility:hidden;"><img src="images/spacer.gif" width="<%response.write (Session("mapWidth"))%>" height="<%response.write (Session("mapHeight"))%>" onclick="hideLoadingLyr();" border="0" ></DIV> 

	<script language='JavaScript' type='text/javascript'>
	var CoordLabel='<%=Application("CoordsLabel")%>';			//Label for the coordinates box (feet, miles, etc.)
	var TitleBarHeight=<%=Application("TitleBarHeight")%>;		//Integer value for the actual height of our title bar
	var jsAppType='<%=Application("AppType")%>';				//Name of our application
	var clientname='<%=Application("ClientName")%>';			//Name of our client
	var jsColourScheme='<%=ColourScheme%>';					    //Integer value for our colour scheme
	top.jsMapUnits='<%=Application("MapUnits")%>';				//top level javascript variable for map units (feet, miles, etc.)
	if (jsColourScheme=='') { jsColourScheme='1';}				//If we don't have a colour scheme, default to 1 (blue)
	var VertTB='<%=Application("VertTB")%>';					//Integer value 0=we do NOT display the vertical Toolbar, 1=we do
	var MDStyle='<%=trim(Application("MDStyle"))%>';			//Measure style: simple or advanced.
	var jsClientLogoAreaWidth='<%=CInt(Application("ClientLogoAreaWidth"))%>';
	var jsParcelDisplayNameSingular = '<%=Application("ParcelDisplayNameSingular")%>';	//'Parcel' or 'Property'?
	var jsParcelDisplayNamePlural = '<%=Application("ParcelDisplayNamePlural")%>';		//'Parcels' or 'Properties'?
	var jsMenuStyle='<%=Application("MenuStyle")%>';
	var jsStreetCLID='<%=Session("StreetCLID")%>';
	var jsBaseColour='<%=Application("AppColour_Base")%>';
	<%ToolbarOnOff=0%>
	<%if Application("AppType")="EconDev" or Application("AppType") = "SimpleGUI" then%>
	//We do display the right docked layer and bottom docked layer
	var dockedRightPaneWidth='<%=Application("RightDockWidth")%>'
	var simpleGUI=1;
	<%else%>
	//We do NOT display the bottom docked layer.
	var simpleGUI=0;
	<%end if%>

	<%if CInt(Application("dispPanArrows"))=1 then%>
	//we do display the pan arrows
	var jsPanArrows=1;
	<%else%>
	//we do NOT display the pan arrows
	var jsPanArrows=0;
	<%end if%>

	var dockedBottomPaneHeight='<%=Application("BottomDockHeight")%>'	//Integer value - height of bottom docked layer.

	<%if Application("AppType")="EconDev" then%>
	//This IS an econ dev application
	var econdev=1;
	<%else%>
	//This IS NOT an econ dev application
	var econdev=0;
	<%end if%>

	</script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>
	<%'Inclusion of ALL of our javascript libraries - as necessary%>
	<%if Application("AppType") = "EconDev"  then%>
	<!--#include file="includes/econdevTB.aspx"-->
	<script language='JavaScript' type='text/javascript' src="js/econdev.js"></script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>
	<%end if%>
	<script language='JavaScript' type='text/javascript' src="js/simpleGUI.js"></script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>
	<%if Application("Bookmark") = 1 or Application("AppType") = "EconDev" then%>
	<script language='JavaScript' type='text/javascript' src="js/bookmark.js"></script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>
	<%end if%>

	<%if Application("MenuStyle")="" then%>
	<!--#include file="includes/menuinit.aspx"-->
	<script language='JavaScript' type='text/javascript' src="js/menu.js"></script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>
	<%else%>
	<script>
	var jsMenuColour_HdrMB='<%=Application("MenuColour_HdrMB")%>';
	var jsMenuColour_HdrMBMO='<%=Application("MenuColour_HdrMBMO")%>';
	var jsMenuColour_HdrTC='<%=Application("MenuColour_HdrTC")%>';
	var jsMenuColour_HdrTCMO='<%=Application("MenuColour_HdrTCMO")%>';
	var jsMenuColour_DDMB='<%=Application("MenuColour_DDMB")%>';
	var jsMenuColour_DDTC='<%=Application("MenuColour_DDTC")%>';
	var jsMenuColour_DDMBMO='<%=Application("MenuColour_DDMBMO")%>';
	</script>
	<!--#include file="includes/menuinit_items.aspx"-->
	<%if Application("ClientName")="RegionalGIS" then%>
	<!--#include file="includes/menuinit_regionalgis.aspx"-->
	<%end if%>
	<script type="text/javascript" src="js/menus.js"></script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>
	<%end if%>
	<script language='JavaScript' type='text/javascript' src="js/layers.js"></script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>
	<script language='JavaScript' type='text/javascript' src="js/nav.js"></script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>
	<script language='JavaScript' type='text/javascript'>var lyrLoading=layer("Loading"); var lyrHideAll=layer("HideAll"); positionLoadingLyr();</script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>
	<script language='JavaScript' type='text/javascript' src="js/drag.js"></script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>
	<script language='JavaScript' type='text/javascript' src="js/VML.js"></script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>
	<%if Application("ClientName") = "SacCountyEOC" then%>
	<script language='JavaScript' type='text/javascript' src="js/EOC.js"></script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>
	<%end if%>
	<Link rel="stylesheet" type="text/css" href="includes/CSS/Style.css">
	</HEAD>

	<BODY bgcolor="#ffffff" onload="<%if Application("MenuStyle")<>"" then%>f29();<%end if%> PreLoadImages(); top.pvGeoDone=true; setTimeout('CheckmyappBM();',200); " onresize="windowResized();" alink="black" vlink="black" link="black">
	<DIV id="titlebar" style="overflow:hidden;z-index:-1;position:absolute;right:0px;top:0px;visibility:visible;overflow:hidden;width:100%;height:<%=Application("TitleBarHeight")%>px;"><TABLE cellpadding=0 cellspacing=0 width=100% height=100% background="images/<%=Application("TBBGGraphic")%>" bgcolor=darkblue><TR valign=top><TD align=left><%if trim(Application("ClientLogoURL")) <> "" and trim(Application("ClientLogo")) <> "" then%><a href="<%=Application("ClientLogoURL")%>" target=_blank><%end if%><%if trim(Application("ClientLogo")) <> "" then%><img src="images/<%=Application("ClientLogo")%>" border=0><%end if%><%if trim(Application("ClientLogoURL")) <> "" and trim(Application("ClientLogo")) <> "" then%></a><%end if%></TD></TR></TABLE></DIV>
	<DIV id="CurrToolDIV" style="z-index:2;position:absolute;right:0px;top:0px;visibility:<%if Application("ClientName")="VenturaCounty" then%>hidden<%else%>visible<%end if%>;overflow:hidden;"><table cellpadding=0 cellspacing=0 border=0><tr><td align=right><span style="overflow:hidden;position:relative;width:160px;height:21px;visibility:visible;overflow:hidden;" id="StatusBarTool"></span></td></tr></table></DIV>
	<DIV id="SelectALink" style="z-index:2;position:absolute;right:0px;top:20px;visibility:visible;overflow:hidden;"><table cellpadding=0 cellspacing=0 border=0><tr><td align=right>
	<TD valign=top width=100% align=right><FORM name='LinkDD' method='post'><select class=HTMLFrmObjects11  name='UserLinks' onchange='LinkSelect();' style="width:160px;"><option value=''>Select a Link</option>
	<%
	
	'Econ dev only - Brokerage report link in the drop down list.
	if Application("AppType")="EconDev" then
		response.write ("<option value='BrokerageReport'>Brokerage Admin</option>")
	end if
	
	'Project Coordination only - Admin log-in and out links in the drop down list.
	if Application("AppType") = "ProjCoord" 
		response.write ("<option value='ProjCoordLogIn'>Admin Log-In</option><option value='ProjCoordLogOut'>Admin Log-Out</option>")
	end if
	
	'Populate our custom links drop down list with the stuff we pulled from the geoprisevariables.TXT file.
	Dim i
	for i = 0 to Application("aryLinks").GetUpperBound(0) step 3
		response.write ("<option value='" & Application("aryLinks")(i+2) & "_" & Application("aryLinks")(i+1) & "'>" & Application("aryLinks")(i) & "</option>")
	next
	%>
	</select></FORM>	
	</td></tr></table></DIV>
		
	<DIV id="titlebarHorizLine" style="overflow:hidden;z-index:1;position:absolute;left:0px;top:<%response.write (CInt(Application("TitleBarHeight"))-2)%>px;visibility:visible;width:100%;height:2px;"><TABLE cellpadding=0 cellspacing=0 width=100% height=100%><TR valign=top bgcolor=darkblue><TD align=left><img src="images/spacer.gif" height=2 width=1></TD></TR></TABLE></DIV>

	<%dim aryPOS2%>
	<%if Application("MenuStyle")="" then%>
		<DIV id="titlebarNav" style="overflow:hidden;z-index:3;position:absolute;left:<%response.write (CInt(Application("ClientLogoAreaWidth")))%>px;top:<%response.write (CInt(Application("TitleBarHeight"))-27)%>px;visibility:visible;"><TABLE border="0" cellspacing="0" cellpadding="0"><TR valign=top><TD align=left><a onmouseover="enterTopItem(0);" onmouseout ="exitTopItem(0);" href="Javascript:Nothing();"><IMG src="images/<%=ColourScheme%>tab_overview.gif" width=89 height=26 border=0 name=m_overview></a></TD><TD align=left><a onmouseover="enterTopItem(1);" onmouseout ="exitTopItem(1);" href="Javascript:Nothing();"><IMG src="images/<%=ColourScheme%>tab_navigate.gif" width=74 height=26 border=0 name=m_navigate></a></TD><TD align=left><a onmouseover="enterTopItem(2);" onmouseout ="exitTopItem(2);" href="Javascript:Nothing();"><IMG src="images/<%=ColourScheme%>tab_search.gif" width=74 height=26 border=0 name=m_search></a></TD><TD align=left><a onmouseover="enterTopItem(3);" onmouseout ="exitTopItem(3);" href="Javascript:Nothing();"><IMG src="images/<%=ColourScheme%>tab_select.gif" width=74 height=26 border=0 name=m_select></a></TD><TD align=left><a onmouseover="enterTopItem(4);" onmouseout ="exitTopItem(4);" href="Javascript:Nothing();"><IMG src="images/<%=ColourScheme%>tab_reports.gif" width=74 height=26 border=0 name=m_reports></a></TD><% aryPOS2=5%><TD align=left><a onmouseover="enterTopItem(<%=aryPOS2%>);" onmouseout ="exitTopItem(<%=aryPOS2%>);" href="Javascript:Nothing();"><IMG src="images/<%=ColourScheme%>tab_help.gif" width=74 height=26 border=0 name=m_help></a></TD><%aryPOS2+=1%><% if Application("AppType")="ProjCoord" then%><TD align=left><span id="m_projects" style="visibility:hidden;"><a onmouseover="enterTopItem(<%=aryPOS2%>);" onmouseout ="exitTopItem(<%=aryPOS2%>);" href="Javascript:Nothing();"><IMG src="images/<%=ColourScheme%>tab_Projects.gif" width=74 height=26 border=0 name=m_imgprojects></a></span></TD><%end if%><% if Application("AppType")="EconDev" then%><TD align=left><span id="m_econdev"><a onmouseover="enterTopItem(<%=aryPOS2%>);" onmouseout ="exitTopItem(<%=aryPOS2%>);" href="Javascript:Nothing();"><IMG src="images/<%=ColourScheme%>tab_econdev.gif" width=74 height=26 border=0 name=m_imgecondev></a></span></TD><%end if%><% if Application("ClientName")="SacCountyEOC" then%><TD align=left><span id="m_eoc"><a onmouseover="enterTopItem(<%=aryPOS2%>);" onmouseout ="exitTopItem(<%=aryPOS2%>);" href="Javascript:Nothing();"><IMG src="images/<%=ColourScheme%>tab_eoc.gif" width=74 height=26 border=0 name=m_imgeoc></a></span></TD><%end if%></TR></TABLE></DIV>
	<%else%>
		<!--#include file="includes/MenuTabs.aspx"-->
	<%end if%>
	<%if Application("ClientTitle") <> "" then%>
		<DIV id="ClientTitle" style="overflow:hidden;z-index:2;position:absolute;left:100px;top:-1px;visibility:visible;"><img src="images/<%=Application("ClientTitle")%>"></DIV>
	<%end if%>

	<DIV id="ZoomLadder" style="overflow:hidden;z-index:2;position:absolute;right:5px;top:<%=(Application("TitleBarHeight")-18)%>px;visibility:visible;">
		<TABLE cellpadding=1 cellspacing=1 border=0 width=120><TR>
			<TD><img src="images/icons/z_+.gif" border=0></TD>
			<%
			Dim j
			'Array full of zoom scale factors.
			Dim aryZ = New double(10) {.005,.01,.05,.1,.15,.2,.25,.3,.4,.5,1}
		
			for j = 1 to aryZ.getupperbound(0)
			%>
			<TD><img src="images/icons/z_0.gif" border=0 name="z_<%=j%>" onclick="ZmLdr(<%=j%>,this);" onmouseover="top.MapFrame.di20('z_<%=j%>','images/icons/z_1.gif',this.document);" onmouseout="top.MapFrame.di20('z_<%=j%>','images/icons/z_0.gif',this.document);"></TD>
			<%
			next
			%>
			<TD><img src="images/icons/z_-.gif" border=0></TD>
		</TR></TABLE>
	</DIV>
		
	<%if Application("AppType")="EconDev" or Application("AppType")="SimpleGUI" then%>
			<%if Application("AppType")="SimpleGUI" then%>
				<DIV id='EconDev' style="z-index:1;background-color:<%=BaseColour%>;overflow:hidden;position:absolute;right:0px;top:<%=TitleBarHeight%>px;visibility:visible;overflow:hidden;width:<%response.write(Application("RightDockWidth")-1)%>px;height:100%">
				<DIV id='EconDevLeftCol' style="position:absolute;z-index:1;background-color:<%=BaseColour%>overflow:hidden;height:100%;width:5px;top:0;left:0px">&nbsp;</DIV>
				<iframe id='iEDFrameContent' src='SS/ss_blank.aspx?w=<%=Application("SimpleGUIACN")%>' style='border:0px;z-index:2;position:absolute;right:-1px;top:0px;height:<%=mapHeight-TitleBarHeight+2%>;width:<%response.write(Application("RightDockWidth")-5)%>' frameborder=1 framespacing=0 scrolling=yes></iframe>
			<%else%>
				<DIV id='EconDev' style="z-index:1;background-color:<%=BaseColour%>;overflow:hidden;position:absolute;right:0px;top:<%=TitleBarHeight%>px;visibility:visible;overflow:hidden;width:<%response.write(Application("RightDockWidth"))%>px;height:100%">
				<DIV id='EconDevLeftCol' style="position:absolute;z-index:1;background-color:<%=BaseColour%>overflow:hidden;height:100%;width:<%response.write(Application("RightDockWidth"))%>;top:0;left:0px">&nbsp;</DIV>
				<DIV id='EconDevContent' style="z-index:1;position:absolute;overflow:hidden;left:24px;top:0px;width:100%;height:100%;"><iframe id='iEDFrameContent' src='SS/ss_blank.aspx?w=<%=Application("SimpleGUIACN")%>' style='border:0px;z-index:0;position:absolute;left:0px;top:0px;height:<%=mapHeight-TitleBarHeight+2%>;width:<%response.write(Application("RightDockWidth")-22)%>' frameborder=1 framespacing=0 scrolling=yes></iframe></DIV>
			<%end if%>
		</DIV>
	<%end if%>
	<%if Application("AppType")="SimpleGUI" then%>
	<iframe id='iFrameBottomNavFrame' src='SimpleGUI/navBottom.aspx' style="position:absolute;z-index:3;overflow:hidden;height:<%=Application("BottomDockHeight")%>;width:<%response.write(Session("mapWidth")-Application("RightDockWidth")-1)%>px;bottom:-1px;left:0px" frameborder=0 framespacing=0 scrolling=no></iframe></DIV>
	<%end if%>	
	<%if CInt(Application("dispPanArrows"))=1 then
	Dim RDW as Integer
	if (Application("RightDockWidth")<>"") then 
		RDW=CInt(Application("RightDockWidth"))
	else 
		RDW=0
	end if

	Dim panborderwidth as Integer
	Dim panborderheight as Integer
	Dim ShowArrows as boolean

	if Application("ClientName")="VenturaCounty" then
		panborderwidth=5
		ShowArrows=false
		response.write ("<DIV id='xtragraphic' style='position:absolute;z-index:5;top:3px;left:580px;'><img src='images/MastRightBackgroundAssessor.jpg'></DIV>")
	else
		panborderwidth=15
		ShowArrows=true
	end if
	
	panborderheight=mH+1
	%>
	<script>panborderwidth='<%=panborderwidth%>';</script>
	<DIV id='PanBGL' style="position:absolute;background-color:'#<%=Application("NavBGColour")%>';z-index:1;border-right:1 solid black;height:<%=(panborderheight-(panborderwidth*2)+1)%>;width:<%=panborderwidth%>px;left:0px;top:<%=(TitleBarHeight)%>px"><TABLE cellpadding=0 cellspacing=0 border=0 width=<%=(panborderwidth+1)%> height=100%><%if ShowArrows then%><TR valign=top><TD align=left><a href="javascript:Pan(1)"><img src="images/icons/pan_topleft.gif" border=0></a></TD></tr><tr valign=middle><TD align=left><img src="images/spacer.gif" border=0></TD></TR><TR valign=center><TD align=left><a href="javascript:Pan(2)"><img src="images/icons/pan_left.gif" border=0></a></TD></TR><TR valign=bottom><TD align=left><a href="javascript:Pan(3)"><img src="images/icons/pan_bottomleft.gif" border=0></a></TD></TR><%end if%></TABLE></DIV>
	<DIV id='PanBGR' style="position:absolute;background-color:'#<%=Application("NavBGColour")%>';z-index:1;border-left:1 solid black;height:<%=(panborderheight-(panborderwidth*2)+1)%>;width:<%=panborderwidth%>px;right:<%response.write(RDW-1)%>px;top:<%=(TitleBarHeight)%>px"><TABLE cellpadding=0 cellspacing=0 border=0 width=<%=panborderwidth%> height=100%><%if ShowArrows then%><TR valign=top><TD align=right><a href="javascript:Pan(4)"><img src="images/icons/pan_topright.gif" border=0></a></TD><TD align=right><a href="javascript:Pan(4)"><img src="images/spacer.gif" border=0></a></TD></TR><TR valign=center><TD align=right><a href="javascript:Pan(5)"><img src="images/icons/pan_right.gif" border=0></a></TD></TR><TR valign=bottom><TD align=right><a href="javascript:Pan(6)"><img src="images/icons/pan_bottomright.gif" border=0></a></TR><%end if%></TABLE></DIV>
	<DIV id='PanBGT' style="position:absolute;background-color:'#<%=Application("NavBGColour")%>';z-index:2;border-bottom:1 solid black;height:<%=panborderwidth%>px;width:<%=Math.Abs(mapWidth -(panborderwidth*2)+2 - Application("RightDockWidth"))%>px;left:<%response.write(panborderwidth)%>px;top:<%response.write(TitleBarHeight)%>px"><TABLE cellpadding=0 cellspacing=0 border=0 height=<%=panborderwidth%> width=100%><%if ShowArrows then%><TR valign=top><TD align=center><a href="javascript:Pan(7)"><img src="images/icons/pan_top.gif" border=0></a></TD></TR><%end if%></TABLE></DIV>
	<DIV id='PanBGB' style="position:absolute;background-color:'#<%=Application("NavBGColour")%>';z-index:2;border-top:1 solid black;height:<%=panborderwidth%>px;width:<%=Math.Abs(mapWidth -(panborderwidth*2)+2 - Application("RightDockWidth"))%>px;left:<%response.write(panborderwidth)%>px;bottom:<%response.write(Application("BottomDockHeight")-1)%>px"><TABLE cellpadding=0 cellspacing=0 border=0 height=<%=panborderwidth%> width=100%><%if ShowArrows then%><TR valign=bottom><TD align=center><a href="javascript:Pan(8)"><img src="images/icons/pan_bottom.gif" border=0></a></TD></TD></TR><%end if%></TABLE></DIV>
	<%end if%>	

	<!--- VML stuff --->

	<v:shape id="point_vml" print="t" filled="f" coordsize="50,50" onmouseup="mapMouseUp()" onmousedown="mapMouseDown()" strokecolor="red" strokeweight="2pt"></v:shape>
	<v:shape id="line_vml" print="t" filled="f" coordsize="50,50" onmouseup="mapMouseUp()" onmousedown="mapMouseDown()" strokecolor="red" strokeweight="2pt"></v:shape>
	<v:shape id="poly_vml" coordsize="50,50" onmouseup="mapMouseUp()" print="t" filled="t" onmousedown="mapMouseDown()" fillcolor="yellow" strokecolor="red" strokeweight="1pt"><v:fill opacity=".10"></v:fill></v:shape>
	<v:shape id="xyVML_vml" ondblclick="mapMouseDblClick()" onmouseup="mapMouseUp()" onmousedown="mapMouseDown()" coordsize="50,50" filled="f" strokecolor="red" strokeweight="1.2pt"></v:shape>
	<v:shape id="xyClose_vml" ondblclick="mapMouseDblClick()" onmouseup="mapMouseUp()" onmousedown="mapMouseDown()" coordsize="50,50" filled="f" strokecolor="red" strokeweight="1.2pt"><v:stroke dashstyle="dash"></v:stroke></v:shape>
    <v:shape id="aPoint_vml" print="t" filled="f" coordsize="50,50" strokecolor="navy" strokeweight="4.5pt" ondblclick="mapMouseDblClick()" onmousedown="mapMouseDown()" onmouseup="mapMouseUp()" onmousemove="mapMouseMove()"></v:shape>
    <v:shape id="aLine_vml" print="t" filled="f" coordsize="50,50" strokecolor="red" strokeweight="1.2pt" ondblclick="mapMouseDblClick()" onmousedown="mapMouseDown()" onmouseup="mapMouseUp()" onmousemove="mapMouseMove()"></v:shape>
    <v:shape id="aPoly_vml" coordsize="50,50" print="t" filled="t" fillcolor="red" strokecolor="black" strokeweight="1pt" ondblclick="mapMouseDblClick()" onmousedown="mapMouseDown()" onmouseup="mapMouseUp()" onmousemove="mapMouseMove()"><v:fill opacity=".25"></v:fill></v:shape>
	<v:oval id="aCircle1_vml" print="t" ondblclick="mapMouseDblClick()" onmousedown="mapMouseDown()" onmouseout="mapMouseOut()" onmouseup="mapMouseUp()" onmousemove="mapMouseMove()" style="visibility:hidden;"><v:fill opacity=".10" color="red" /></v:oval>
	<v:oval id="aCircle2_vml" print="t" ondblclick="mapMouseDblClick()" onmousedown="mapMouseDown()" onmouseout="mapMouseOut()" onmouseup="mapMouseUp()" onmousemove="mapMouseMove()" style="visibility:hidden;"><v:fill opacity=".10" color="red" /></v:oval>
	<v:oval id="aCircle3_vml" print="t" ondblclick="mapMouseDblClick()" onmousedown="mapMouseDown()" onmouseout="mapMouseOut()" onmouseup="mapMouseUp()" onmousemove="mapMouseMove()" style="visibility:hidden;"><v:fill opacity=".10" color="red" /></v:oval>
	<v:oval id="aCircle4_vml" print="t" ondblclick="mapMouseDblClick()" onmousedown="mapMouseDown()" onmouseout="mapMouseOut()" onmouseup="mapMouseUp()" onmousemove="mapMouseMove()" style="visibility:hidden;"><v:fill opacity=".10" color="red" /></v:oval>
	<v:oval id="aCircle5_vml" print="t" ondblclick="mapMouseDblClick()" onmousedown="mapMouseDown()" onmouseout="mapMouseOut()" onmouseup="mapMouseUp()" onmousemove="mapMouseMove()" style="visibility:hidden;"><v:fill opacity=".10" color="red" /></v:oval>
	<input id=aText1 maxLength=64 size=4 name=aText1 value="" onkeyup="aTextChange(this)" onmousemove="aTextMove()">
	<input id=aText2 maxLength=64 size=4 name=aText2 value="" onkeyup="aTextChange(this)" onmousemove="aTextMove()">
	<input id=aText3 maxLength=64 size=4 name=aText3 value="" onkeyup="aTextChange(this)" onmousemove="aTextMove()">
	<input id=aText4 maxLength=64 size=4 name=aText4 value="" onkeyup="aTextChange(this)" onmousemove="aTextMove()">
	<input id=aText5 maxLength=64 size=4 name=aText5 value="" onkeyup="aTextChange(this)" onmousemove="aTextMove()">

	<% 
	On Error Resume Next
	response.write (MapLayer & LayersLayer & LegendLayer & RectangleLayer & OverviewLayer & aboutLayer & coordLayer & dataLayer & ToolbarFloatLayer & ProjectDisplayLayer & selectLayer & ContactInfoLayer & BookmarkLayer & BMDrawingLayer & MeasureDistanceLayer) 
	%>
	<script language='JavaScript' type='text/javascript' src="js/postload.js"></script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>
	<script language='JavaScript' type='text/javascript'><%response.write (LastMinuteJS)%></script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>
	<script language='JavaScript' type='text/javascript'>
		var lyrMapImg=layer("MapImg");
		var objMap=findObj("MapImg",document); 
		mapW=lyrMapImg.getWidth();mapH=lyrMapImg.getHeight();/*maxX=minX+mapW*/;
		
		//Here we determine the maxX and maxY values for where the user's mouse pointer is 'active'.  Again - everything is based upon the browser's height and
		//width, so when the mouse is going all over the browser window, we know what's 'in' and what's 'out'.
		if (simpleGUI==1) {
			maxX=parseInt(getWindowWidth())-parseInt(dockedRightPaneWidth);
			maxY=minY+mapH-parseInt(dockedBottomPaneHeight);
		} else {
			maxX=getWindowWidth();
			maxY=minY+mapH;
		}

		objMap.onmouseover=mapMouseOver;objMap.onmouseout=mapMouseOut;objMap.onmousedown=mapMouseDown;objMap.ondblclick=mapMouseDblClick;document.onmouseup=mapMouseUp;document.onmousemove=mapMouseMove;document.onselectstart=new Function ("return false");
		
		function mapVars() {
			//Javascript to initialize the map variables (more details in VB file).  We do this ONLY if we have completely loaded all frames and pages
			//necessary for processing.  This is a synchronization thing.
			if (top.ProcessDone==false||top.pvGeoDone==false||top.FrameLoaded==false) {top.mapVarTimeout=window.setTimeout("top.MapFrame.mapVars();",100); return false;}
			clearTimeout(top.mapVarTimeout);
			<%response.write(MapVariables)%>
		}

		top.mapVarTimeout=window.setTimeout("top.MapFrame.mapVars();",100);
		<%response.write(JSinitDrag)%>
	
		function CheckmyappBM() {
			//If we're pulling up a bookmark, we need to execute code to tell the processing page to fire off that bookmark.
			<%=CheckmyappBM%>
		}
		

		function PreLoadImages() {
			//preloading of images - just something to make the browsing experience more enjoyable.
			<%if Application("MenuStyle")="" then%>
			MM_preloadImages('images/<%=ColourScheme%>m_About.gif','images/<%=ColourScheme%>m_About_ro.gif','images/<%=ColourScheme%>m_AccountAdmin.gif','images/<%=ColourScheme%>m_AccountAdmin_ro.gif','images/<%=ColourScheme%>m_AddRecord.gif','images/<%=ColourScheme%>m_AddRecord_ro.gif','images/<%=ColourScheme%>m_AdminHelp.gif','images/<%=ColourScheme%>m_AdminHelp_ro.gif','images/<%=ColourScheme%>m_bookmark.gif','images/<%=ColourScheme%>m_bookmark_ro.gif','images/<%=ColourScheme%>m_Buffer.gif','images/<%=ColourScheme%>m_Buffer_ro.gif','images/<%=ColourScheme%>m_CandidateList.gif','images/<%=ColourScheme%>m_CandidateList_ro.gif','images/<%=ColourScheme%>m_Clear.gif','images/<%=ColourScheme%>m_Clear_ro.gif','images/<%=ColourScheme%>m_Comments.gif','images/<%=ColourScheme%>m_Comments_ro.gif','images/<%=ColourScheme%>m_Coordinates.gif','images/<%=ColourScheme%>m_Coordinates_ro.gif','images/<%=ColourScheme%>m_DataManagement.gif','images/<%=ColourScheme%>m_DataManagement_ro.gif','images/<%=ColourScheme%>m_DeleteRecord.gif','images/<%=ColourScheme%>m_DeleteRecord_ro.gif','images/<%=ColourScheme%>m_DisplayOptions.gif','images/<%=ColourScheme%>m_DisplayOptions_ro.gif','images/<%=ColourScheme%>m_EditRecord.gif','images/<%=ColourScheme%>m_EditRecord_ro.gif','images/<%=ColourScheme%>m_EDReport.gif','images/<%=ColourScheme%>m_EDReport_ro.gif','images/<%=ColourScheme%>m_FullExtent.gif','images/<%=ColourScheme%>m_FullExtent_ro.gif','images/<%=ColourScheme%>m_GeoAnalysis.gif','images/<%=ColourScheme%>m_GeoAnalysis_ro.gif','images/<%=ColourScheme%>m_IDAll.gif','images/<%=ColourScheme%>m_IDAll_ro.gif','images/<%=ColourScheme%>m_IDParcel.gif','images/<%=ColourScheme%>m_IDParcel_ro.gif','images/<%=ColourScheme%>m_IDParcelDetails.gif','images/<%=ColourScheme%>m_IDParcelDetails_ro.gif','images/<%=ColourScheme%>m_IDProject.gif','images/<%=ColourScheme%>m_IDProject_ro.gif','images/<%=ColourScheme%>m_Landmark.gif','images/<%=ColourScheme%>m_Landmark_ro.gif','images/<%=ColourScheme%>m_Layers.gif','images/<%=ColourScheme%>m_Layers_ro.gif','images/<%=ColourScheme%>m_Legend.gif','images/<%=ColourScheme%>m_Legend_ro.gif','images/<%=ColourScheme%>m_MainPage.gif','images/<%=ColourScheme%>m_MainPage_ro.gif','images/<%=ColourScheme%>m_MeasureDistance.gif','images/<%=ColourScheme%>m_MeasureDistance_ro.gif','images/<%=ColourScheme%>m_MetaData.gif','images/<%=ColourScheme%>m_MetaData_ro.gif','images/<%=ColourScheme%>m_OverviewMap.gif','images/<%=ColourScheme%>m_OverviewMap_ro.gif','images/<%=ColourScheme%>m_Pan.gif','images/<%=ColourScheme%>m_Pan_ro.gif','images/<%=ColourScheme%>m_Print.gif','images/<%=ColourScheme%>m_Print_ro.gif','images/<%=ColourScheme%>m_PropertyDetails.gif','images/<%=ColourScheme%>m_PropertyDetails_ro.gif','images/<%=ColourScheme%>m_PropertySearch.gif','images/<%=ColourScheme%>m_PropertySearch_ro.gif','images/<%=ColourScheme%>m_Report.gif','images/<%=ColourScheme%>m_Report_ro.gif','images/<%=ColourScheme%>m_Save.gif','images/<%=ColourScheme%>m_Save_ro.gif','images/<%=ColourScheme%>m_SearchAddress.gif','images/<%=ColourScheme%>m_SearchAddress_ro.gif','images/<%=ColourScheme%>m_SearchAll.gif','images/<%=ColourScheme%>m_SearchAll_ro.gif','images/<%=ColourScheme%>m_SearchAPN.gif','images/<%=ColourScheme%>m_SearchAPN_ro.gif','images/<%=ColourScheme%>m_SearchIntersection.gif','images/<%=ColourScheme%>m_SearchIntersection_ro.gif','images/<%=ColourScheme%>m_SearchOwner.gif','images/<%=ColourScheme%>m_SearchOwner_ro.gif','images/<%=ColourScheme%>m_SearchProject.gif','images/<%=ColourScheme%>m_SearchProject_ro.gif','images/<%=ColourScheme%>m_SiteHelp.gif','images/<%=ColourScheme%>m_SiteHelp_ro.gif','images/<%=ColourScheme%>m_UserComments.gif','images/<%=ColourScheme%>m_UserComments_ro.gif','images/<%=ColourScheme%>m_ZoomIn.gif','images/<%=ColourScheme%>m_ZoomIn_ro.gif','images/<%=ColourScheme%>m_ZoomLast.gif','images/<%=ColourScheme%>m_ZoomLast_ro.gif','images/<%=ColourScheme%>m_ZoomOut.gif','images/<%=ColourScheme%>m_ZoomOut_ro.gif','images/1menu_bottom.gif','images/1menu_top.gif')
			<%end if%>
		}
				
		//Zoom Ladder
		function ZmLdr(i,obj) {

			var o;
			var objMF = findObj("MapFunction")
			var objZL=findObj('ZoomLadder');

			obj.onmouseover="";
			obj.onmouseout="";
			obj.onclick="";
			di20('z_' + i,'images/icons/z_2.gif',this.document);

			if (objZL!=null) {
				objMF.value=6;	

				<%for j = 1 to aryZ.getupperbound(0)%>
					o=findObj("z_<%=j%>",this.document);

					if (o!=null && i!=<%=j%>) {
						o.onmouseover=function(){di20('z_<%=j%>','images/icons/z_1.gif',this.document);}
						o.onmouseout=function(){di20('z_<%=j%>','images/icons/z_0.gif',this.document);}
						o.onclick=function(){ZmLdr(<%=j%>,this);}
						di20('z_<%=j%>','images/icons/z_0.gif',this.document);
					} else {
						objZL.value='<%=aryZ(j)%>'; 
					}	
				<%next%>

				RefreshMap();
			}
		}

		<%if Application("ClientName")="CitrusHeights" and (request("ApplicationNum")<>"" or request("APN") <> "" or request("StreetNum") <>"" or request("StreetName") <> "" or request("ZIP") <> "") then%>
			var CHURL='Custom/S_PS_Integration.aspx?ApplicationNum=<%=request("ApplicationNum")%>&APN=<%=request("APN")%>&StreetNum=<%=request("StreetNum")%>&StreetName=<%=request("StreetName")%>&ZIP=<%=request("ZIP")%>';
			if (simpleGUI==1) {
				top.MapFrame.GoSimpleGUIiFrameRight(CHURL);
			} else {
				top.fwinURL[3]=CHURL; 
				var objTMP=findObj("iFrameSSLayer",document);
				ChangeiFrameURL(objTMP,"Integration","yes",2);
			}
		<%end if%>		
	</script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>
<!-- Programmer: A llen Br iscoe-S mi th --->

	</BODY>
	</HTML>
<%else
    Dim URL, params, i

    URL = "pv_init.aspx?"
    params = ""

    For i = 0 To Request.QueryString.Count
        If Trim(Request.QueryString.Keys.Item(i)) <> "" Then
            If Trim(params) <> "" Then
                params &= "&"
            End If
			if ucase(trim(request.querystring.allkeys(i)))<>"WINDOWWIDTH" and ucase(trim(request.querystring.allkeys(i)))<>"WINDOWHEIGHT" and ucase(trim(request.querystring.allkeys(i)))<>"PASS" then
	            params &= Trim(Request.QueryString.AllKeys(i)) & "=" & Trim(Request(Trim(Request.QueryString.Keys.Item(i))))
	        end if
        End If
    Next
%>
	<script language='JavaScript' type='text/javascript'>
		//PassedPVGeo is not 1, so we need to properly initialize the application - go back to pv_init and initialize!
		top.document.location="<%=URL%><%=params%>";
	</script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>
<%end if%>