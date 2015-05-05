//	The purpose of this file is to define all of the postload javascript variables.
//
// arrLyrNames	- a javascript array full of the names of all floating window layers
// arrLyrStyle	- a javascript array full of the 'types' for all floating window layers 0=normal, 2=right docked
// lyr*			- kLayer objects for all floating window layers
// arrLyrsObjs	- a javascript array full of kLayer objects for all floating windows - used in drag.js to init drag on all floating windows
var arrLyrNames=new Array("overview","layers","Legend", "about","coord","data", "SS","projectdisp","ContactInfo","bookmark","BMDrawing","ToolbarFloat","MeasureDistance");
var arrLyrStyle=new Array("0","0","0","0","0","0","2","0","0","0","0","0","0");
var lyrMap=layer("Map");var lyrLegend=layer("Legend");var lyrtitlebar=layer("titlebar");var lyrRectLeft=layer("RectLeft");var lyrRectRght=layer("RectRght");var lyrRectTop=layer("RectTop");var lyrRectBotm=layer("RectBotm");var lyrStatusBarTool=layer("StatusBarTool");var lyroverview=layer("overview");var lyrlayers=layer("layers");var lyrabout=layer("about");var lyrSS=layer("SS"); var lyrMD=layer("MD");var lyrToolbarFloat=layer('ToolbarFloat'); var lyrcoord=layer("coord");var lyrdata=layer("data");var lyrprojectdisp=layer("projectdisp"); var lyrcontactinfo=layer("contactinfo"); var lyrbookmark=layer("bookmark"); var lyrBMDrawing=layer("BMDrawing"); var lyrMeasureDistance=layer("MeasureDistance");
var arrLyrsObjs=new Array(lyrMap,lyrRectLeft,lyrRectRght,lyrRectTop,lyrRectBotm,lyrLegend,lyrtitlebar,lyrStatusBarTool,lyroverview,lyrlayers,lyrabout,lyrSS,lyrMD,lyrToolbarFloat,lyrcoord,lyrdata,lyrprojectdisp,lyrcontactinfo,lyrbookmark,lyrBMDrawing,lyrToolbarFloat,lyrMeasureDistance);

// Initialization of the title bar to x,y coord 0,0, and z-index 1;
lyrtitlebar.move(0,0); lyrtitlebar.moveZ(1); lyrtitlebar.show();
// Initialization of the mapz layer to move it to x,y coord 0,(height of title bar graphic), and z-index 0;
lyrMap.move(0,TitleBarHeight); lyrMap.moveZ(0); lyrMap.show();
// Set minX and minY to top x,y coord of the map; This is used as an origin of the map space.
minX=lyrMap.getLeft();minY=lyrMap.getTop();
//showKLayer(lyrToolbarFloat);