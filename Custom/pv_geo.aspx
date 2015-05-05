
 	<html><head><title>.NET Application</title>
	
<link rel="stylesheet" type="text/css" href="../includes/CSS/1SS.css">

	<!---<iframe id='Loading' align="center" src='loading.aspx' style='visibility:hidden;border:0px;z-index:1;position:absolute;left:0px;top:0px;' frameborder=0 framespacing=0 vspace=0 hspace=0 marginwidth=0 marginheight=0 scrolling=no ></iframe>--->
	<div id="Loading" style="position:absolute;border:0px;z-index:1;left:0px;top:0px;visibility:hidden;"><img src="images/1loading.gif" border="0"></TD></div>
	<div id="HideAll" align="left" style="overflow:hidden;z-index:100;cursor:wait;position:absolute;left:0px;top:0px;width:1020px;height:646px; visibility:hidden;"><img src="images/spacer.gif" width="1020" height="646" onclick="hideLoadingLyr();" border="0" ></div> 
	<script>menuContent = new Array ();menuContent[0] = new Array (-1,-1,151,70,78,new Array (),"overview");items = menuContent[0][5];items[0]="Coordinates"; items[1]= "javascript:swapLayerVis(lyrcoord,'windowcoord');";items[2]="OverviewMap"; items[3]= "javascript:swapLayerVis(lyroverview,'windowOverviewMap');";items[4]="layers"; items[5]= "javascript:swapLayerVis(lyrlayers,'windowLayers');";items[6]="Legend"; items[7]= "javascript:swapLayerVis(lyrLegend,'windowLegend');";items[8]="Bookmark"; items[9]= "javascript:goBookmarkMain(0);";menuContent [1] = new Array (-1,-1,151,155,78,new Array (), "navigate");items = menuContent[1][5];items[0]="FullExtent"; items[1]= "javascript:SetCurrTool(7,1);";items[2]="zoomin"; items[3]= "javascript:SetCurrTool(2,2);";items[4]="zoomout"; items[5]= "javascript:SetCurrTool(5,2);";items[6]="zoomlast"; items[7]= "javascript:SetCurrTool(8,1);";items[10]="pan"; items[11]= "javascript:SetCurrTool(11,2);";menuContent [2] = new Array (-1,-1,151,230,78,new Array(),"search");items = menuContent[2][5];items[0]="SearchAll"; items[1]= "javascript:SSAction(29,'Search All');";menuContent [3] = new Array (-1,-1,151,305,78,new Array(),"select");items = menuContent[3][5];items[0]="IDAll"; items[1]= "javascript:SSRefreshMap('IDAllclear','');SetCurrTool(19,2);";items[4]="IDParcel"; items[5]= "javascript:SetCurrTool(20,2);";items[6]="IDParcelDetails"; items[7]= "javascript:SetCurrTool(22,2);";items[8]="Buffer"; items[9]= "javascript:BuffStuff('');";items[10]="MeasureDistance"; items[11]= "javascript:SetCurrTool(10,2);showKLayer(lyrmeasuredist);";items[12]="clear"; items[13]= "javascript:SSRefreshMap('','');";menuContent [4] = new Array (-1,-1,151,380,78,new Array(), "reports");items = menuContent[4][5];items[2]="Print"; items[3]= "javascript:PrintMap('-1');";menuContent [5] = new Array (-1,-1,151,455,78,new Array(), "help");items = menuContent[5][5];items[0]="SiteHelp"; items[1]= "javascript:newwindow('Help/index.aspx','width=760,height=400,menubar=no,resizable=yes,tollbar=no,scrollbars=no','Help');";items[2]="About"; items[3]= "javascript:swapLayerVis(lyrabout,'windowabout');";</script>
	<script language="javascript">
	var CoordLabel='NAD 83';
	var TitleBarHeight=81;
	var appname='SimpleGUI';
	var clientname='VenturaCounty';
	var jsColourScheme='1';
	top.jsMapUnits='Feet';
	if (jsColourScheme=='') { jsColourScheme=1;}
	var VertTB='0';
	
    var jsParcelDisplayNameSingular = 'Parcel';
    var jsParcelDisplayNamePlural = 'Parcels';

	
	var dockedRightPaneWidth='335'
	var simpleGUI=1;
	
	var jsPanArrows=1;
	

	var dockedBottomPaneHeight='77'

	
	var econdev=0;
	

	</script>
	
	<script language="JavaScript" src="js/simpleGUI.js"></script>
	
	<script language="JavaScript" src="js/bookmark.js"></script>
	
	<script language="JavaScript" src="js/menu.js"></script>
	<script language="JavaScript" src="js/layers.js"></script>
	<script language="JavaScript" src="js/nav.js"></script>
	<script language="JavaScript">var lyrLoading=layer("Loading"); var lyrHideAll=layer("HideAll"); positionLoadingLyr();</script>
	<script language="JavaScript" src="js/drag.js"></script>
	<link rel="stylesheet" type="text/css" href="includes/CSS/1SS.css">
	</head>

	<body bgcolor="#ffffff" onload="PreLoadImages(); top.pvGeoDone=true; setTimeout('CheckmyappBM();',200); setTimeout('CheckWin(488,685,0);',210); " onresize="windowResized();" alink="black" vlink="black" link="black">
	<div id="titlebar" style="overflow:hidden;z-index:-1;position:absolute;right:0px;top:0px;visibility:visible;overflow:hidden;width:100%;height:81px;"><table cellpadding=0 cellspacing=0 width=100% height=100% background="images/VenturaTopRepeat.gif" bgcolor=white><tr valign=top><td align=left><img src="images/GlennLogo.gif" border=0></td><td valign=top width=100% align=right><form name='LinkDD' method='post'><!---<img src='images/about100x14.gif'>&nbsp;---><!---<select  class=HTMLFrmObjects  name='UserLinks' onchange='LinkSelect();' style="width:150px;"><option value=''>Select a Link</option>
	<option value='1_http://www.geoprise.net'>Geoprise.net</option>
	</select>---></form>
	</td><td><span class="border" style="overflow:hidden;position:relative;width:140px;height:21px;visibility:hidden;overflow:hidden;" id="StatusBarTool"></span></td></tr></table>
	</div>
	<div id="titlebarHorizLine" style="overflow:hidden;z-index:1;position:absolute;left:0px;top:77px;visibility:visible;width:100%;height:4px;"><table cellpadding=0 cellspacing=0 width=100% height=100% background="images/1menubar_bg_horiz.gif"><tr valign=top><td align=left><img src="images/spacer.gif"></td></tr></table></div>

	<div id="titlebarNav" style="overflow:hidden;z-index:3;position:absolute;left:70px;top:51px;visibility:visible;"><table border="0" cellspacing="0" cellpadding="0"><tr valign=middle><td align=left><a onmouseover="enterTopItem(0);" onmouseout ="exitTopItem(0);" href="Javascript:Nothing();"><IMG src="images/1tab_overview.gif" width=89 height=26 border=0 name=m_overview></a></td><td align=left><a onmouseover="enterTopItem(1);" onmouseout ="exitTopItem(1);" href="Javascript:Nothing();"><IMG src="images/1tab_navigate.gif" width=74 height=26 border=0 name=m_navigate></a></td><td align=left><a onmouseover="enterTopItem(2);" onmouseout ="exitTopItem(2);" href="Javascript:Nothing();"><IMG src="images/1tab_search.gif" width=74 height=26 border=0 name=m_search></a></td><td align=left><a onmouseover="enterTopItem(3);" onmouseout ="exitTopItem(3);" href="Javascript:Nothing();"><IMG src="images/1tab_select.gif" width=74 height=26 border=0 name=m_select></a></td><td align=left><a onmouseover="enterTopItem(4);" onmouseout ="exitTopItem(4);" href="Javascript:Nothing();"><IMG src="images/1tab_reports.gif" width=74 height=26 border=0 name=m_reports></a></td><td align=left><a onmouseover="enterTopItem(5);" onmouseout ="exitTopItem(5);" href="Javascript:Nothing();"><IMG src="images/1tab_help.gif" width=74 height=26 border=0 name=m_help></a></td></tr></table></div>
	<div id="ClientTitle" style="overflow:hidden;z-index:2;position:absolute;left:100px;top:8px;visibility:visible;width:400px;"><img src="images/GlennTitle.jpg"></div>

	
				<div id='EconDev' style="z-index:1;overflow:hidden;position:absolute;right:0px;top:81px;visibility:visible;overflow:hidden;width:334px;height:100%">
				<div id='EconDevLeftCol' style="position:absolute;z-index:1;overflow:hidden;height:100%;width:5px;top:0;left:0px"><img src='images/VertTBImages/1t_fw_vtb_lvert.gif' id='SSlvertimg' height=100% width=5></div>
				<iframe id='iEDFrameContent' src='SS/ss_blank.aspx?w=31' style='border:0px;z-index:2;position:absolute;right:-1px;top:0px;height:567;width:330' frameborder=1 framespacing=0 scrolling=yes></iframe>
			
		</div>
	
	<iframe id='iFrameBottomNavFrame' src='SimpleGUI/navBottom.aspx' style="position:absolute;z-index:3;overflow:hidden;height:77;width:684px;bottom:-1px;left:0px" frameborder=0 framespacing=0 scrolling=no></iframe></div>
	<div id='xtragraphic' style='position:absolute;z-index:5;top:3px;left:580px;'><img src='images/MastRightBackgroundAssessor.jpg'></div>
	<div id='PanBGL' style="position:absolute;background-color:'#FFFFFF';z-index:1;border-right:1 solid black;height:100%;width:5px;left:0px;top:81px"><table cellpadding=0 cellspacing=0 border=0 width=5 height=100%></table></div>
	<div id='PanBGR' style="position:absolute;background-color:'#FFFFFF';z-index:1;border-left:1 solid black;height:100%;width:5px;right:334px;top:81px"><table cellpadding=0 cellspacing=0 border=0 width=5 height=100%></table></div>
	<div id='PanBGT' style="position:absolute;background-color:'#FFFFFF';z-index:2;border-bottom:1 solid black;height:5px;width:685px;left:0px;top:81px"><table cellpadding=0 cellspacing=0 border=0 height=5 width=100%></table></div>
	<div id='PanBGB' style="position:absolute;background-color:'#FFFFFF';z-index:2;border-top:1 solid black;height:5px;width:685px;left:0px;bottom:76px"><table cellpadding=0 cellspacing=0 border=0 height=5 width=100%></table></div>
	<div id="Map" class="map" style="z-index:0;position:absolute;left:0px;top:91px;height:565px;width:685px;visibility:hidden;"><div id="MapImg" style="position:relative;height:100%;width:100%;background-image: url(http://geoprise1.metropolisnewmedia.com/output/Glenn_GEOPRISE11128381238.jpg); background-repeat:no-repeat;background-color:white;"></div></div><div id='Legend' style="z-index:-1;overflow:hidden;position:absolute;left:0px;top:0px;visibility:hidden;width:200px;height:315px;"><iframe id='iFrameLegendLayer' src='includes/fwindow.aspx?src=pv_Legend.aspx&l=Legend&title=Legend&s=yes' style='border:0px;z-index:5;position:absolute;top:0px;height=315;width=200;' frameborder=0 framespacing=0 scrolling=no></iframe><div id='LegendDrag' style="z-index:5;cursor:hand;position:absolute;left:0px;top:0px;height:15px;width:100%;"><img src='images/spacer.gif' height=15 width=100 border=0></div></div><div id=RectTop class=rect style="position:absolute;left:0px;top:0px;width:0px;height:2px;visibility:hidden;"></div><div id=RectRght class=rect style="position:absolute;left:0px;top:0px;width:2px;height:0px;visibility:hidden;"></div><div id=RectBotm class=rect style="position:absolute;left:0px;top:0px;width:0px;height:2px;visibility:hidden;"></div><div id=RectLeft class=rect style="position:absolute;left:0px;top:0px;width:2px;height:0px;visibility:hidden;"></div><div id='overview' style="z-index:-1;overflow:hidden;position:absolute;left:0px;top:0px;visibility:hidden;width:208px;height:163px;"><iframe id='iFrameoverviewLayer' src='includes/fwindow.aspx?type=img&l=overview&title=Overview Map&src=http%3a%2f%2fgeoprise1.metropolisnewmedia.com%2foutput%2fGlenn_legend_GEOPRISE11128382819.jpg&s=no' style='border:0px;z-index:5;position:absolute;top:0px;height=163;width=208;' frameborder=0 framespacing=0 scrolling=no></iframe><div id='overviewDrag' style="z-index:5;cursor:hand;position:absolute;left:0px;top:0px;height:15px;width:100%;"><img src='images/spacer.gif' height=15 width=100 border=0></div></div><div id='layers' style="z-index:-1;overflow:hidden;position:absolute;left:0px;top:0px;visibility:hidden;width:310px;height:350px;"><iframe id='iFramelayersLayer' src='includes/fwindow.aspx?l=layers&title=Layer Management&src=pv_layers.aspx&s=yes' style='border:0px;z-index:5;position:absolute;top:0px;height=350;width=310;' frameborder=0 framespacing=0 scrolling=no></iframe><div id='layersDrag' style="z-index:5;cursor:hand;position:absolute;left:0px;top:0px;height:15px;width:100%;"><img src='images/spacer.gif' height=15 width=100 border=0></div></div><div id='about' style="z-index:-1;overflow:hidden;position:absolute;left:0px;top:0px;visibility:hidden;width:410px;height:167px;"><iframe id='iFrameaboutLayer' src='includes/fwindow.aspx?type=img&l=about&title=About this Application&src=../images/about_401.jpg&s=no' style='border:0px;z-index:5;position:absolute;top:0px;height=167;width=410;' frameborder=0 framespacing=0 scrolling=no></iframe><div id='aboutDrag' style="z-index:5;cursor:hand;position:absolute;left:0px;top:0px;height:15px;width:100%;"><img src='images/spacer.gif' height=15 width=100 border=0></div></div><div id='coord' style="z-index:-1;overflow:hidden;position:absolute;left:0px;top:0px;visibility:hidden;width:150px;height:70px;"><iframe id='iFramecoordLayer' src='includes/fwindow.aspx?l=coord&title=Coordinates&src=coordinates.aspx&s=no' style='border:0px;z-index:5;position:absolute;top:0px;height=70;width=150;' frameborder=0 framespacing=0 scrolling=no></iframe><div id='coordDrag' style="z-index:5;cursor:hand;position:absolute;left:0px;top:0px;height:15px;width:100%;"><img src='images/spacer.gif' height=15 width=100 border=0></div></div><div id='data' style="z-index:-1;overflow:hidden;position:absolute;left:0px;top:0px;visibility:hidden;width:700px;height:300px;"><iframe id='iFramedataLayer' src='includes/fwindow.aspx?l=data&title=MetaData&src=../SS/ss_wait.aspx&s=no' style='border:0px;z-index:5;position:absolute;top:0px;height=300;width=700;' frameborder=0 framespacing=0 scrolling=no></iframe><div id='dataDrag' style="z-index:5;cursor:hand;position:absolute;left:0px;top:0px;height:15px;width:100%;"><img src='images/spacer.gif' height=15 width=100 border=0></div></div><div id='bufferwin' style="z-index:-1;overflow:hidden;position:absolute;left:0px;top:0px;visibility:hidden;width:175px;height:275px;"><iframe id='iFramebufferwinLayer' src='includes/fwindow.aspx?l=bufferwin&title=Buffer Step 1&src=..%2fSS%2fbuffer_step1.aspx%3fBT%3d%26h%3d275&s=no' style='border:0px;z-index:5;position:absolute;top:0px;height=275;width=175;' frameborder=0 framespacing=0 scrolling=no></iframe><div id='bufferwinDrag' style="z-index:5;cursor:hand;position:absolute;left:0px;top:0px;height:15px;width:100%;"><img src='images/spacer.gif' height=15 width=100 border=0></div></div><div id='projectdisp' style="z-index:-1;overflow:hidden;position:absolute;left:0px;top:0px;visibility:hidden;width:250px;height:400px;"><iframe id='iFrameprojectdispLayer' src='includes/fwindow.aspx?l=projectdisp&title=&src=..%2floading.aspx%3fCS%3d1&s=yes' style='border:0px;z-index:5;position:absolute;top:0px;height=400;width=250;' frameborder=0 framespacing=0 scrolling=no></iframe><div id='projectdispDrag' style="z-index:5;cursor:hand;position:absolute;left:0px;top:0px;height:15px;width:100%;"><img src='images/spacer.gif' height=15 width=100 border=0></div></div><div id='measuredist' style="z-index:-1;overflow:hidden;position:absolute;left:0px;top:0px;visibility:hidden;width:275px;height:107px;"><iframe id='iFramemeasuredistLayer' src='includes/fwindow.aspx?l=measuredist&title=Measure Distance&src=MeasureDistance.aspx&s=no' style='border:0px;z-index:5;position:absolute;top:0px;height=107;width=275;' frameborder=0 framespacing=0 scrolling=no></iframe><div id='measuredistDrag' style="z-index:5;cursor:hand;position:absolute;left:0px;top:0px;height:15px;width:100%;"><img src='images/spacer.gif' height=15 width=100 border=0></div></div><div id='SS' style="z-index:-1;overflow:hidden;position:absolute;right:0px;top:0px;visibility:hidden;width:360px;height:595px;"><iframe id='iFrameSSLayer' src='includes/fwindow.aspx?l=SS&title=Search&btn=2&src=../SS/ss_wait.aspx&s=yes' style='border:0px;z-index:5;position:absolute;top:0px;width:100%;height:100%;' frameborder=0 framespacing=0 scrolling=no ></iframe></div><div id='contactinfo' style="z-index:-1;overflow:hidden;position:absolute;left:0px;top:0px;visibility:hidden;width:400px;height:400px;"><iframe id='iFramecontactinfoLayer' src='includes/fwindow.aspx?l=contactinfo&title=Information&src=../SS/ss_wait.aspx&s=no' style='border:0px;z-index:5;position:absolute;top:0px;height=400;width=400;' frameborder=0 framespacing=0 scrolling=no></iframe><div id='contactinfoDrag' style="z-index:5;cursor:hand;position:absolute;left:0px;top:0px;height:15px;width:100%;"><img src='images/spacer.gif' height=15 width=100 border=0></div></div><div id='buffercontent' style="overflow:hidden;z-index:-1;position:absolute;left:0px;top:0px;visibility:hidden;width:1012;height:200px;"><iframe id='iFramebuffercontentLayer' src='includes/fwindow.aspx?l=buffercontent&title=&btn=3&src=../SS/ss_wait.aspx&s=no' style='border:0px;z-index:5;position:absolute;top:0px;width:100%;height:100%;' frameborder=0 framespacing=0 scrolling=no></iframe><div id='buffercontentDrag' style="z-index:5;cursor:hand;position:absolute;left:0px;top:0px;height:15px;width:100%;"><img src='images/spacer.gif' height=15 width=100 border=0></div></div><div id='IDALL' style="overflow:hidden;z-index:-1;position:absolute;left:0px;top:0px;visibility:hidden;width:1012;height:200px;"><iframe id='iFrameIDALLLayer' src='includes/fwindow.aspx?l=IDALL&title=&btn=3&src=../SS/ss_wait.aspx&s=no' style='border:0px;z-index:5;position:absolute;top:0px;width:100%;height:100%;' frameborder=0 framespacing=0 scrolling=no></iframe><div id='IDALLDrag' style="z-index:5;cursor:hand;position:absolute;left:0px;top:0px;height:15px;width:100%;"><img src='images/spacer.gif' height=15 width=100 border=0></div></div><div id='bookmark' style="z-index:-1;overflow:hidden;position:absolute;left:0px;top:0px;visibility:hidden;width:300px;height:400px;"><iframe id='iFramebookmarkLayer' src='includes/fwindow.aspx?l=bookmark&title=Bookmarks&src=../bookmark/BM_Main.aspx&s=no' style='border:0px;z-index:5;position:absolute;top:0px;height=400;width=300;' frameborder=0 framespacing=0 scrolling=no></iframe><div id='bookmarkDrag' style="z-index:5;cursor:hand;position:absolute;left:0px;top:0px;height:15px;width:100%;"><img src='images/spacer.gif' height=15 width=100 border=0></div></div><div id='BMDrawing' style="z-index:-1;overflow:hidden;position:absolute;left:0px;top:0px;visibility:hidden;width:300px;height:400px;"><iframe id='iFrameBMDrawingLayer' src='includes/fwindow.aspx?l=BMDrawing&title=Drawing Tools&src=../bookmark/BM_Drawing.aspx&s=no' style='border:0px;z-index:5;position:absolute;top:0px;height=400;width=300;' frameborder=0 framespacing=0 scrolling=no></iframe><div id='BMDrawingDrag' style="z-index:5;cursor:hand;position:absolute;left:0px;top:0px;height:15px;width:100%;"><img src='images/spacer.gif' height=15 width=100 border=0></div></div>
	<script language="Javascript" src="js/postload.js"></script>
	<script language="Javascript">crntTool = 2;crntToolType = 2; function Skale () { var u; var n=null; if (top.objScale!=u&&top.objScale!=n){ if (top.objScale.scale==u||top.objScale.scale==n){top.scaleTimeout=window.setTimeout('top.MapFrame.Skale();',100); return;} clearTimeout(top.scaleTimeout); top.objScale.scale.value='10545.02'; }else{top.scaleTimeout=window.setTimeout('top.MapFrame.Skale();',100);} } top.scaleTimeout=window.setTimeout('top.MapFrame.Skale();',10);  top.MapURL='http://geoprise1.metropolisnewmedia.com/output/Glenn_GEOPRISE11128381238.jpg';  top.OVExtentXMin=526840.931314925; top.OVExtentYMax=4407436.56310005;  top.xOVRatio=376.215571048265; top.yOVRatio=377.491926948874;  function SetLegend () {var udf; if (top.objLegendImg!=udf) {clearTimeout(top.LegendTimeOut); top.objLegendImg.src='http://geoprise1.metropolisnewmedia.com/output/Glenn_GEOPRISE11128381239.jpg';} else{ top.LegendTimeOut=window.setTimeout("SetLegend();",100);} }  top.LegendTimeOut=window.setTimeout("SetLegend();",100); hideKLayer(lyrabout);hideKLayer(lyroverview);hideKLayer(lyrlayers);hideKLayer(lyrcoord);hideKLayer(lyrmeasuredist);hideKLayer(lyrLegend);hideKLayer(lyrdata);hideKLayer(lyrIDALL);hideKLayer(lyrprojectdisp);hideKLayer(lyrbufferwin);hideKLayer(lyrbuffercontent);hideKLayer(lyrcontactinfo);hideKLayer(lyrSS);hideKLayer(lyrBMDrawing);hideKLayer(lyrbookmark);</script>
	<script language="Javascript">
		var objOVMap

		InitOVMap();
		
		function InitOVMap() {
			objOVMap=findObj("imgoverview",top.MapFrame.iFrameoverviewLayer);
		
			if (objOVMap==null) {
				top.InitMapVarsTimeout=window.setTimeout("top.MapFrame.InitOVMap();",20);
				return;
			}
			
			clearTimeout(top.InitMapVarsTimeout);
			
			//objOVMap.onmousedown=OVMapClick;
		}
		
		var lyrMapImg=layer("MapImg");
		var objMap=findObj("MapImg",document); 
		mapW=lyrMapImg.getWidth();mapH=lyrMapImg.getHeight();/*maxX=minX+mapW*/;
		
		/*maxX=getWindowWidth();maxY=minY+mapH;*/
		
		if (simpleGUI==1) {
			maxX=parseInt(getWindowWidth())-parseInt(dockedRightPaneWidth);
			maxY=minY+mapH-parseInt(dockedBottomPaneHeight);
		} else {
			maxX=getWindowWidth();
			maxY=minY+mapH;
		}

		objMap.onmouseover=mapOver;objMap.onmouseout=mapOut;objMap.onmousedown=mapDown;document.onmouseup=mUp;document.onmousemove=getMouseXY;document.onselectstart=new Function ("return false");
		
		function mapVars() {
			if (top.ProcessDone==false||top.pvGeoDone==false||top.FrameLoaded==false) {top.mapVarTimeout=window.setTimeout("top.MapFrame.mapVars();",100); return false;}
			clearTimeout(top.mapVarTimeout);
			top.mapMinX = 524765.259198797; top.mapMaxX = 600008.37340845; top.mapMaxY = 4355397.0579447; top.mapMinY = 4409000.91157144; top.Process.MapForm.EnvelopeMinX.value= 524765.259198797; top.Process.MapForm.EnvelopeMaxX.value= 600008.37340845; top.Process.MapForm.EnvelopeMinY.value= 4355397.0579447; top.Process.MapForm.EnvelopeMaxY.value= 4409000.91157144; 
		}

		top.mapVarTimeout=window.setTimeout("top.MapFrame.mapVars();",100);
		initDrag('about');initDrag('overview');initDrag('layers');initDrag('coord');initDrag('measuredist');initDrag('Legend');initDrag('data');initDrag('IDALL');initDrag('projectdisp');initDrag('bufferwin');initDrag('buffercontent');initDrag('contactinfo');initDrag('BMDrawing');initDrag('bookmark');
	
		function CheckmyappBM() {
			
		}
		
		function CheckWin(mH,mW,m) {
			return;
			
			var w,h,t
			
			t=50; //threshold
			w=getWindowWidth();
			h=getWindowHeight();
			hB=mH+81;
			
			
			mW=mW+335;
			
			//alert ('mH:' + mH + ' mW:' + mW + '  .... h:' + h + ' w: ' + w);
			//alert ('w: ' + Math.abs(w-mW) + ' h: ' + Math.abs(h-hB));
			
			if ((Math.abs(w-mW)>t) || (Math.abs(h-hB)>t)) {
				if (m==0) {
					window.location = "pv_process.aspx?Pass=1&WindowWidth=1020&WindowHeight=646&APNs=&myappBM="
				} else {
					var objMF = top.MapFrame.findObj("MapFunction")

					windowResized();
					if (objMF!=null) {
						objMF.value=-1;
						top.MapFrame.RefreshMap();
					}
				}
			}
		}
		
		function PreLoadImages() {
			MM_preloadImages('images/1m_About.gif','images/1m_About_ro.gif','images/1m_AccountAdmin.gif','images/1m_AccountAdmin_ro.gif','images/1m_AddRecord.gif','images/1m_AddRecord_ro.gif','images/1m_AdminHelp.gif','images/1m_AdminHelp_ro.gif','images/1m_bookmark.gif','images/1m_bookmark_ro.gif','images/1m_Buffer.gif','images/1m_Buffer_ro.gif','images/1m_CandidateList.gif','images/1m_CandidateList_ro.gif','images/1m_Clear.gif','images/1m_Clear_ro.gif','images/1m_Comments.gif','images/1m_Comments_ro.gif','images/1m_Coordinates.gif','images/1m_Coordinates_ro.gif','images/1m_DataManagement.gif','images/1m_DataManagement_ro.gif','images/1m_DeleteRecord.gif','images/1m_DeleteRecord_ro.gif','images/1m_DisplayOptions.gif','images/1m_DisplayOptions_ro.gif','images/1m_EditRecord.gif','images/1m_EditRecord_ro.gif','images/1m_EDReport.gif','images/1m_EDReport_ro.gif','images/1m_FullExtent.gif','images/1m_FullExtent_ro.gif','images/1m_GeoAnalysis.gif','images/1m_GeoAnalysis_ro.gif','images/1m_IDAll.gif','images/1m_IDAll_ro.gif','images/1m_IDParcel.gif','images/1m_IDParcel_ro.gif','images/1m_IDParcelDetails.gif','images/1m_IDParcelDetails_ro.gif','images/1m_IDProject.gif','images/1m_IDProject_ro.gif','images/1m_Landmark.gif','images/1m_Landmark_ro.gif','images/1m_Layers.gif','images/1m_Layers_ro.gif','images/1m_Legend.gif','images/1m_Legend_ro.gif','images/1m_MainPage.gif','images/1m_MainPage_ro.gif','images/1m_MeasureDistance.gif','images/1m_MeasureDistance_ro.gif','images/1m_MetaData.gif','images/1m_MetaData_ro.gif','images/1m_OverviewMap.gif','images/1m_OverviewMap_ro.gif','images/1m_Pan.gif','images/1m_Pan_ro.gif','images/1m_Print.gif','images/1m_Print_ro.gif','images/1m_PropertyDetails.gif','images/1m_PropertyDetails_ro.gif','images/1m_PropertySearch.gif','images/1m_PropertySearch_ro.gif','images/1m_Report.gif','images/1m_Report_ro.gif','images/1m_Save.gif','images/1m_Save_ro.gif','images/1m_SearchAddress.gif','images/1m_SearchAddress_ro.gif','images/1m_SearchAll.gif','images/1m_SearchAll_ro.gif','images/1m_SearchAPN.gif','images/1m_SearchAPN_ro.gif','images/1m_SearchIntersection.gif','images/1m_SearchIntersection_ro.gif','images/1m_SearchOwner.gif','images/1m_SearchOwner_ro.gif','images/1m_SearchProject.gif','images/1m_SearchProject_ro.gif','images/1m_SiteHelp.gif','images/1m_SiteHelp_ro.gif','images/1m_UserComments.gif','images/1m_UserComments_ro.gif','images/1m_ZoomIn.gif','images/1m_ZoomIn_ro.gif','images/1m_ZoomLast.gif','images/1m_ZoomLast_ro.gif','images/1m_ZoomOut.gif','images/1m_ZoomOut_ro.gif','images/1menu_bottom.gif','images/1menu_top.gif','images/1menubar_bg_horiz.gif')
		}
	</script>

	</body>
	</html>
