// ArcIMSparam.js
// javascript file with parameters specific to calling page

//***************************************************************************
//*			parameters File for HTML Template		    *
//***************************************************************************

// get machine name
var hostName = document.location.host;
// common portion of url
var esriBlurb = "/servlet/com.esri.esrimap.Esrimap?ServiceName="
// make URL for getting mapservice catalog
var catURL = "http://" + hostName + esriBlurb + "catalog";
// make prefix for URL
var serverURL  = "http://" + hostName + esriBlurb;


//*********************************************************************
//*			parameters set by Designer			                     *
//*********************************************************************
//var imsURL = serverURL + "sanfrancisco";
//var imsOVURL = serverURL + "sanfrancisco";
var imsURL = "";
var imsOVURL = "";

// url for Custom QueryService if not ImageService(imsURL)...otherwise empty quotes
var imsQueryURL = "";
var imsGeocodeURL = "";

var mapBackColor = "255,255,255";
var ovBoxColor = "255,0,0";
var ovBoxSize = 3;

var hasOVMap=true;
var hasTOC=true;
var useModeFrame=false;

// /*
//initial map extent
var startLeft = 0;
var startRight = 0;
var startTop = 0;
var startBottom = 0;
//maximum map extent
var limitLeft = 0;
var limitRight = 0;
var limitTop = 0;
var limitBottom = 0;
// */
/*
//initial map extent
var startLeft = -122.52809;
var startRight = -122.310880;
var startTop =37.840374;
var startBottom =37.7;
//maximum map extent
var limitLeft = -122.528090;
var limitRight = -122.310880;
var limitTop = 37.840374;
var limitBottom = 37.634806;
*/

var usePan=true;
var usePanNorth=true;
var usePanWest=true;
var usePanEast=true;
var usePanSouth=true;
var useZoomIn=true;
var useZoomOut=true;
var useFullExtent=true;
var useZoomActive=true;
var useZoomLast=true;
var useIdentify=true;
var useMeasure=true;
var useSetUnits=true;
var useSelect=true;
var useQuery=true;
var useFind=true;
var useGeocode=false;
var useStoredQuery=false;
var useClearSelect=true;
var useSetUnits=true;
var usePrint=true;
var useBuffer=true;
var useExtract=false;

var usePictImageList=true;

var MapUnits = "Degrees";
var ScaleBarUnits = "Miles";

var useHyperLink=false;
var useHyperLinkAny=false;
var useIdentifyAll=false;
var useBufferShape=false; 
var hasToolBarOnLayer=false;
	// useHyperLink takes priority - both cannot be true
if (useHyperLink) useHyperLinkAny=false;
	// useIdentify takes priority - both cannot be true
if (useIdentify) useIdentifyAll=false;
	// allow debugging
var setDebug=true;



/**************************************
* Basic Map parameters
**************************************/

// variables for map pixel offset from upper left corner of frame
	// horizontal offset
var hspc = 0;
	// vertical offset
var vspc = 0;

//panning factor for arrow buttons
var panFactor = 85/100;
//zoom factors for v.3
var zoomFactor = 2

// margin factor for zooming in on selected lines and polygons - based on feature width and height. . . margin will be selectMargin * width or height
var selectMargin = 25/100;
// margin margin factor for zooming in on selected points - based on full extent. . . margin will be selectPointMargin * fullWidth or fullHeight
var selectPointMargin = 25/1000

// show the scale factor
var showScalePercent=true;
// display coords in status line
var showXYs=true;

// Have ArcXML responses URL encoded? Will not work with 2-byte characters
var doURLencode = false;

// automatically adjust for ArcMapServer, if necessary
	// North Arrow size is smaller from ArcMapServer
var autoAdjustForArcMapServer = true;

//variables for MapDrawing
	// North Arrow
var drawNorthArrow = true;
var NorthArrowType = "4";
var NorthArrowSize = "15";
var NorthArrowCoords = "20 35";
var NorthArrowAngle = "0";
	// Scale Bar
var drawScaleBar = true;
	// MapUnits=DEGREES,FEET,METERS
	// can MapUnits be changed by user?
var setMapUnits=false;
	// ScaleBarUnits=KILOMETERS,METERS,MILES,FEET
var ScaleBarBackground = "false";
var ScaleBarBackColor = "0,0,0";
var ScaleBarFontColor = "0,0,0";
var ScaleBarColor = "128,128,128";
var ScaleBarFont = "";
var ScaleBarStyle = "Regular";
var ScaleBarRound = "1";
var ScaleBarSize = "9";
var ScaleBarWidth = "5";
var ScaleBarPrecision = 2;
var numDecimals = ScaleBarPrecision;
	// Scale Bar 2
var drawScaleBar2 = true;
var ScaleBar2Units = "KILOMETERS";
var ScaleBar2Background = "false";
var ScaleBar2BackColor = "0,0,0";
var ScaleBar2FontColor = "0,0,0";
var ScaleBar2Color = "128,128,128";
var ScaleBar2Font = "";
var ScaleBar2Style = "Regular";
var ScaleBar2Round = "1";
var ScaleBar2Size = "9";
var ScaleBar2Width = "5";
var ScaleBar2Precision = 2;

	// Copyright blurb
var drawCopyright = true;
var CopyrightFont = "";
var CopyrightStyle = "Regular";
var CopyrightSize = "8";
var CopyrightCoords = "3 3";
var CopyrightColor = "0,0,0";
var CopyrightBackground = "False";
var CopyrightBGColor = "255,255,255";
var CopyrightGlow = "False";
var CopyrightGlowColor = "255,255,255";
var CopyrightShadow = "False";
var CopyrightShadowColor = "32,32,32";
var CopyrightText = "Map created with ArcIMS - Copyright (C) 1992-2002 ESRI Inc.";

	// place bar behind Copyright text and scalebars
var drawBottomBar = true;
var bottomBarColor = "255,255,255";
var bottomBarOutline = "0,0,0";
var bottomBarHeight = "18";

	// Mode on Map
var drawModeOnMap = false;
var modeRefreshMap = false;
var modeMapColor = "255,255,255";
var modeMapGlow = "128,0,255";

var ovImageVar;
var ovBorderWidth = 2;
var ovExtentBoxSize = 2;

// map image background transparent? - requires gif or png8 types
var mapTransparent=false;

// setup test for Nav 4.0
var isIE = false;
var isNav = (navigator.appName.indexOf("Netscape")>=0);
var isNav4 = false;
var isIE4 = false;
var is5up = false;
//alert(navigator.appVersion);
if (isNav) {
	
	if (parseFloat(navigator.appVersion)<5) {
		isNav4=true;
		//alert("Netscape 4.x or older");
	} else {
		is5up = true;
	}
} else {
	isIE4=true;
	isIE=true;
	if ((navigator.appVersion.indexOf("MSIE 5")>0) || (navigator.appVersion.indexOf("MSIE 6")>0)) {
		isIE4 = false;
		is5up = true;
		//alert("IE5");
	}
}	
		
/**************************************
* Extended Map parameters
**************************************/

// variables for ovmap offset
var ovHspc = 0;
var ovVspc = 0;

// color for Main Map zoombox in html hex RGB format
var zoomBoxColor = "#ff0000";

// index of initial active layer. . . if more than or equal to layer count top layer used
var ActiveLayerIndex=99;

// variables for using individual components
var useTextFrame=true;
// use external window for dialogs
var useExternalWindow=false;

// colors for tables 
var textFrameBackColor="Silver";
var tableBackColor="White";
var textFrameTextColor="Black";
var textFrameLinkColor="Blue";
var textFrameFormColor="Gray";

// LayerList visible at service load
var showTOC=true;
// set layer visibility according to LayerList or by custom programming
var toggleVisible = true;
// set layer visibility of OVMap according to LayerList or by custom programming
	// imsURL must equal imsOVMap - depends on one LayerList
var toggleOVVisible = false;
// will the LayerList show all layers, not just those available at current scale
var listAllLayers = false;

// toggle the check of non-listing of layers in LayerList and Legend
// if true, noListLayer array must have an element defined for each layer
var hideLayersFromList=false;
// layers that will be listed in the LayerList or Legend
	// Note: This does not affect map display
var noListLayer = new Array();
// noListLayer[0] = false;
// noListLayer[1] = false;
// noListLayer[2] = false;
// noListLayer[3] = true;	// this one will not be listed
// noListLayer[4] = false;

	// Mode on floating layer
var drawFloatingMode = false;
var modeLayerOn = false;
var modeLayerColor = "Black";
var modeLayerShadowColor = "White";
var modeLayerFont = "Arial";
var modeLayerSize = "4";

	// does the overview map a layer on top of map?... 
var ovMapIsLayer=true;

var webParams = "";
if (parent.MapFrame!=null) {
	webParams = parent.document.location.search;
} else {
	webParams = document.location.search;
}

/**************************************
* Interactive Map parameters
**************************************/

// Click points - Measure/Shape Select/Shape Buffer
var clickMarkerColor="255,0,0";
var clickMarkerType="Circle";
var clickMarkerSize="6";


/**************************************
* Identify/Select/Query/Buffer parameters
**************************************/

// search tolerance in pixels around click
var pixelTolerance=2;
// color of selected features in decimal RGB format
var selectColor="255,255,0"
// color of highlighted feature in decimal RGB format
var highlightColor="255,0,0"
// level of transparency of selected and highlighted color
var transparentLevel = "0.5";
	// zoom to selected feature if only one is returned?
var zoomToSingleSelect = false;
	// use only unique values in sample field value lists
var onlyUniqueSamples = true;
	// are string queries case insensitive?
		// false by default to match Java Viewer and ArcExplorer
var queryCaseInsensitive=false;

// fields to be returned in identify/selection/query request. . . #ALL#=all fields
var selectFields= "#ALL#";
//var selectFields= "#ID# #SHAPE#";
// swap out the list of returned fields? 
//If true, a list must be defined in selFieldList[n] for each layer to update selectFields
var swapSelectFields=false;
// array for each layer's returned fields if swapSelectFields=true
var selFieldList = new Array();
// sample set for world - if not #ALL#, id and shape fields required. Separate with a space
selFieldList[0]="NAME COUNTRY POPULATION #ID# #SHAPE#";
selFieldList[1]="URL #ID# #SHAPE#";
selFieldList[2]="#ALL#";
selFieldList[3]="#ALL#";
selFieldList[4]="#ALL#";
selFieldList[5]="NAME CONTINENT #ID# #SHAPE#";
selFieldList[6]="#ALL#";

// Hide the ID field display? The ID Field must be included in field list, but we don't have to show it.
var hideIDFieldData = false;
// Hide the shape field display? The Shape Field must be included in field list, but we don't have to show it.
var hideShapeFieldData = false;

// use the field alias in the data display? 
//If true, a list must be defined in fieldAliasList[n] for each layer defining aliases for those fields needing them
var useFieldAlias=false;
// array for aliases for each layer's returned fields if useFieldAlias=true
var fieldAliasList  = new Array();
// sample set for world - fieldname:alias pairs separated by a bar (|)... if no aliases, use empty string ("")
fieldAliasList[0]="NAME:City Name|POPULATION:Population";
fieldAliasList[1]="";
fieldAliasList[2]="";
fieldAliasList[3]="";
fieldAliasList[4]="";
fieldAliasList[5]="NAME:CountryName";
fieldAliasList[6]="";

// parameters for setting up hyperlinks in data display
var hyperLinkLayers = new Array(); // layers to have hyperlink
var hyperLinkFields = new Array();	// field in those layers to be used for hyperlink
var hyperLinkPrefix = new Array();  // prefix (if any) to place before field value to make hyperlink url
var hyperLinkSuffix = new Array();  // suffix (if any) to place after field value to make hyperlink url
hyperLinkLayers[0] = "Image";
hyperLinkFields[0] = "HOT";
hyperLinkPrefix[0] = "/gisdata/world/images/";
hyperLinkSuffix[0] = ".jpg";


// will the returned data be displayed in text frame?
var showSelectedData=true;
// will the returned features be drawn?
var showSelectedFeatures=true;
// maximum number of features returned from query
var maxFeaturesReturned=25;

// for ID All - List all visible layers in response - default is false
	// if false only visible layers with idenitified features written to table
	// if true the names of all visible layers will be diplayed even if no features returned
var listAllLayersInIDAll = false;

// number of data samples retrieved for query form
var numberDataSamples = 50;



/**************************************
* Legend parameters - aimsLegend.js
**************************************/

// legend map size
var legWidth=170;
var legHeight=300;
var legFont="Arial";
var legTitle="Legend";

/**************************************
* Options parameters - aimsOptions.js
**************************************/

// allowing user to set options
var allowOptions=false;

/**************************************
* ClassRender parameters - aimsClassRender.js
**************************************/

// parameters for custom class rendering... overrides default renderer
var ClassRenderLayer = new Array();  // layers to have custom renderers
var ClassRenderString = new Array(); // initial custom renderer XML string for the layers
ClassRenderLayer[0] = "Cities";
ClassRenderString[0] = "";
/*
ClassRenderString[0] ='<VALUEMAPRENDERER lookupfield="population">\n<RANGE LOWER="0" UPPER="1000000">\n<SIMPLEMARKERSYMBOL color="255,0,255" type="circle" size="4" />\n</RANGE>';
ClassRenderString[0] = ClassRenderString[0] + '<RANGE LOWER="1000000" UPPER="2500000">\n<SIMPLEMARKERSYMBOL color="255,0,255" type="circle" size="6" />\n</RANGE>';
ClassRenderString[0] = ClassRenderString[0] + '<RANGE LOWER="2500000" UPPER="5000000">\n<SIMPLEMARKERSYMBOL color="255,0,255" type="circle" size="9" />\n</RANGE>';
ClassRenderString[0] = ClassRenderString[0] + '<RANGE LOWER="5000000" UPPER="10000000">\n<SIMPLEMARKERSYMBOL color="255,0,255" type="circle" size="12" />\n</RANGE>';
ClassRenderString[0] = ClassRenderString[0] + '<RANGE LOWER="10000000" UPPER="30000000">\n<SIMPLEMARKERSYMBOL color="255,0,255" type="circle" size="16" />\n</RANGE>\n</VALUEMAPRENDERER>';
*/

/**************************************
* Geocode parameters - aimsGeocode.js
**************************************/

// maximum geocode candidates returned - default = 5
var maxGeocodeCandidates=20;
// minimal acceptable geocode score for candidate
var minGeocodeScore=25;
var geocodePointColor = "255,0,0";
var geocodePointSize = "15";
var geocodeLabelSize = "12";
// custom functions needed for Reverse Geocoding
var useReverseGeocode = false;

// the starting point. . . it all starts here on loading
function checkParams() {
	appDir = getPath(document.location.pathname);
	// global for overview map. . . change if not on same frame as Map
	ovImageVar = document.ovImage;
	debugOn = 0;
	//alert(tURL);
	if (parent.TextFrame==null) {
		useTextFrame = false;
		useExternalWindow=true;
	}
	if (!hasLayer("measureBox")) useMeasure=false;
	if ((!useMeasure) && (!drawScaleBar)) useSetUnits=false;
	if (ovImageVar==null) hasOVMap = false;
	if (parent.TOCFrame==null) hasTOC = false;
	if (parent.ModeFrame==null) useModeFrame = false;
	
	if (isIE)	{
		if (hasLayer("theTop")) document.all.theTop.style.cursor = "crosshair";
		if (hasOVMap) ovImageVar.style.cursor = "hand";
	}
	if (hasOVMap) {
		// size of ov map image
		i2Width = parseInt(ovImageVar.width);
		i2Height = parseInt(ovImageVar.height);
		forceNewOVMap = false;
		// position of ov map
		//ovMapLeft = iWidth - (i2Width + 6);
		//ovMapTop = 2;
	}

	if (webParams!="") {
		//alert(webParams);
		getCommandLineParams(webParams);
	}
	// if starting extents zero'd then flag to get start from mapservice
	if ((startLeft!=0) && (startRight!=0)) getStartingExtent=false;
	// if limit extents zero'd then flag to get max from mapservice
	if ((limitLeft!=0) && (limitRight!=0)) {
		getLimitExtent=false;
		enforceFullExtent=true;
	}
	if (ovBoxColor=="") ovBoxColor = "255,0,0";
	//ovBoxColor = convertHexToDec(ovBoxColor);
	checkCoords();
	if (aimsNavigationPresent) {
		// Set up event capture for mouse movement
		if (isNav4) {
			document.captureEvents(Event.MOUSEMOVE);
			document.captureEvents(Event.MOUSEDOWN);
			document.captureEvents(Event.MOUSEUP);
			//document.captureEvents(Event.MOUSEOUT);
		}
		document.onmousemove = getMouse;
		//document.onmousedown = chkMouseDown;
		document.onmousedown = mapTool;
		document.onmouseup = chkMouseUp;
		//document.onmouseout = chkMouseOut;
	} else {
		usePan=false;
		usePanNorth=false;
		usePanWest=false;
		usePanEast=false;
		usePanSouth=false;
		useMeasure=false;
		useZoomIn=false;
		useZoomOut=false
		//useFullExtent=false;
		useZoomActive=false;
		//useZoomLast=false;	
	}
	
	if (!aimsBufferPresent) {
		useBuffer=false;
	}
	if (!aimsQueryPresent) {
		aimsBufferPresent=false;
		useQuery=false;
		useFind=false;
		useBuffer=false;
		useStoredQuery=false;
	}
	if (!aimsSelectPresent) {
		aimsQueryPresent=false;
		aimsBufferPresent=false;
 		useSelect=false;
		useQuery=false;
		useFind=false;
		useBuffer=false;
		useStoredQuery=false;
		useClearSelect=false;
	}
	if (!aimsIdentifyPresent) {
		aimsSelectPresent=false;
		aimsQueryPresent=false;
		aimsBufferPresent=false;
		canQuery=false;
		useIdentify=false;
 		useSelect=false;
		useQuery=false;
		useFind=false;
		useBuffer=false;
		useStoredQuery=false;
		useHyperLink=false;
		useHyperLinkAny=false;
		useIdentifyAll=false;
	}
	if (!aimsGeocodePresent) {
		useGeocode=false;
		useReverseGeocode=false;
	}
	if (!aimsPrintPresent) {
		usePrint=false;
	}
	if (!aimsOptionsPresent) {
		allowOptions=false;
	}
	if ((aimsXMLPresent) && (aimsMapPresent)) {
		if (aimsClickPresent) clickFunction("zoomin");
		if (parent.ToolFrame!=null) parent.ToolFrame.document.location="toolbar.htm";
		startMap();
	} else {
		alert(msgList[0]);
	}
}


