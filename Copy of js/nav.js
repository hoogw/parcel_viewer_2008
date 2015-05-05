//	The purpose of this file is to act as the main javascript file.

var mouseX=0,mouseY=0,x1=0,x2=0,y1=0,y2=0,minX=0,minY=0,maxX=0,maxY=0,overMap=false,mapX=0,mapY=0;
var crntWinWid=0,crntWinHgt=0,resizeCnt=0,sStatus='',sMD='',lastz=5,crntTool=0,crntToolType=0,sbHeight=0,chk='chk';
var submitted=false,zooming=false,dragging=false,removestreet=false;identifyall=false;addstreet=false;projectid=false;mapclicked=false,resizing=false,buffering=false,parceldetails=false,stopdrawing=false;
var wpt,ret,arrLyrNames,winParent=null,xRatio,yRatio,u,uX,uY,undef,_console,jsClearDrawings;
var SSNavButton=0,SelectAreaMax=3000,url="",pLoaded=false,pLoadedTO=0;
var intWait=60000,CoordThreshold=2,rubberbandthick=2,panborderwidth=15;
var jsControlString = "Processing has taken over 1 minute. Giving control back to user.\n\nTake note: Some requests can take several minutes to process and the server may be still be processing your request.\n\nAlso Note: If you are zoomed into a highly populated area, your project rendering can take several minutes due to the high volume of data to render.";
var jsstrAreaTooBig="Selection area too large."

// functions for capturing x,y map coords and drawing rectangles

function mapMouseDblClick() {
	var i;
	var wStr;

	var objCurrTool=findObj('CurrTool');
	//if (objCurrTool.value==10||objCurrTool.value==12||objCurrTool.value==23) { clearMeasureVar(objCurrTool.value); return; }

	switch (parseInt(objCurrTool.value)) {

		case 31:	// Save line

			if (XyCount > 1) {
				if ((ALineXYCount + XyCount) > MaxXY) {
					if (ALineCount == 0) {
						alert("You may enter a maximum of " + MaxXY + " points.");
						clearMeasureVar(objCurrTool.value);
					} else {
						alert("Please refresh the drawing before adding more line elements.");
						return;
					}
					return;
				}
				ALineXYCount += XyCount;

				ALineCount += 1;
				if (ALineCount == 1) {
					aLine_vml.path = "";
					ALineList = "";
				}
				
				// Set vml
				wStr = xyVML_vml.path + "";
				aLine_vml.path = wStr + aLine_vml.path;
			}

			var objPts=findObj("dwg_ln_Points"); if (objPts.value!=""){objPts.value+='|,'};
			break;
		
		case 32:

			if (XyCount > 2) {
				if ((APolyXYCount + XyCount) > MaxXY) {
					if (APolyCount == 0) {
						alert("You may enter a maximum of " + MaxXY + " points.");
						clearMeasureVar(objCurrTool.value);
					} else {
						alert("Please refresh the drawing before adding more polygon elements.");
						return;
					}
					return;
				}
				APolyXYCount += XyCount;

				APolyCount += 1;
				if (APolyCount == 1) {
					aPoly_vml.path = "";
					APolyList = "";
				}
			    
				// Set vml
				wStr = xyVML_vml.path + "";
				wStr = wStr.replace("e", "");
				wStr += XfirstPix + "," + YfirstPix + " e ";
				aPoly_vml.path = wStr + aPoly_vml.path;

			}
			var objPts=findObj("dwg_py_Points"); if (objPts.value!=""){objPts.value+='|,'};

			break;
	}


	// Reset vml drawing
	
	if (objCurrTool.value==10||objCurrTool.value==12||objCurrTool.value==23||objCurrTool.value==24) {stopdrawing=true;}else{stopdrawing=false;clearMeasureVar(objCurrTool.value); }
	//clearMeasureVar(objCurrTool.value);
	//clearVML();
}

function mapMouseMove(e){
	//If we're dragging the map (pan), then exit the function
	
	window.status="Current Tool: " + top.currentToolText;

	if(dragging) {return;}

	//If all frames of our application are loaded, then go ahead & hide the clear sheet protector layer & loading layer
	if (top.ProcessDone==false||top.pvGeoDone==false||top.FrameLoaded==false) {
		lyrHideAll.show();
		lyrLoading.moveZ(lastz+2);
		centerLayer(lyrLoading);
		lyrLoading.show();
	}
	
	var ox1=0,ox2=0,oy1=0,oy2=0,zx1=0,zx2=0,zy1=0,zy2=0,s;
	var objBuffType=findObj('BuffType'); 
	var specialbuff;

	//If buffering via rectangle
	specialbuff=false;
	if (buffering && objBuffType.value == 'rectangle') { specialbuff=true; }

	//Get the x,y coordinates of our mouse - compensate for the scroll bar on the right of the browser
	mouseX=(event.clientX+document.body.scrollLeft);
	mouseY=(event.clientY+document.body.scrollTop);

//window.status=mouseX + ',' + mouseY;
	coords="";

	//If the mouse cursor is within the browser window...
	if(checkMousePos()){
		var dX=lyrMap.getLeft()+lyrMapImg.getLeft(),dY=lyrMap.getTop()+lyrMapImg.getTop();
		ox1=x1-dX;oy1=y1-dY;ox2=mouseX-dX;oy2=mouseY-dY;

		//If we're not zooming, not doing parcel details, etc. then convert mouse xy's into map coordinates and hide the rubber band box
		if(!parceldetails&&!zooming&&!specialbuff&&!projectid&&!addstreet&&!removestreet&&!identifyall){
			x2=0;y2=0;
			getMapXY(ox2,oy2);
			hideZoomRect();
		}else{
			//Otherwise, we're doing something that requires the rubber band box to be sized & displayed - so let's do that now
			///if (x1>0&&y1>0) {
			x2=mouseX;y2=mouseY;
			if(x1>x2){zx2=x1;zx1=x2;}else{zx1=x1;zx2=x2};
			if(y1>y2){zy2=y1;zy1=y2;}else{zy1=y1;zy2=y2};
			lyrRectTop.move(zx1,zy1);lyrRectLeft.move(zx1,zy1);
			lyrRectRght.move(zx2,zy1);lyrRectBotm.move(zx1,zy2);
			lyrRectTop.size(zx2-zx1,rubberbandthick); lyrRectLeft.size(rubberbandthick,zy2-zy1);
			lyrRectRght.size(rubberbandthick,zy2-zy1); lyrRectBotm.size(zx2-zx1,rubberbandthick);
			showZoomRect();
			getMapXY(ox1,oy1);
			getMapXY(ox1,oy1);
			///} else {return;}
		}
	}else{
		//Outside of the browser window, so initialize our environment as if the user lifted the mouse button up
		if(mapclicked){mapMouseUp();};
		zooming=false;buffering=false;parceldetails=false;mapclicked=false;removestreet=false;addstreet=false;identifyall=false;projectid=false;hideZoomRect();
	}

	//Update the coordinates floating window with the latest HTML - if the coordinates box is visible.
	if (lyrcoord.isVisible()) {
		var theNAD83X,theNAD83Y,theNAD27X,theNAD27Y;
		//For the coordinates box, let's update the NAD83 and NAD27 coordinates
		u = Math.pow(10,3); uX = parseInt(mapX * u + (5/10)) / u; uY= parseInt(mapY * u + (5/10)) / u;
		theNAD83X = parseInt((uX), 10); theNAD83Y= parseInt((uY), 10);
		theNAD27X = parseInt((uX-4561358.6667), 10); theNAD27Y= parseInt((uY-1640386.9991), 10);

		coords = "" 
		coords += "<FONT class=tblHdrWhite><b>" + CoordLabel + "</b>:<br><b>x</b>: " + theNAD83X + "<br><b>y</b>: " + theNAD83Y
	
		if (clientname=='SacCounty'||clientname=='SacCountyEOC') {
			coords += "<br><FONT class=tblHdrWhite><b>NAD 27</b>:<br><b>x</b>: " + theNAD27X + "<br><b>y</b>: " + theNAD27Y;
		}

		//Lat/Lon goodies
		/*
		// Set up the coordinate system parameters.
		///a = 6378137 * 3.28                // major radius of ellipsoid, map units (NAD 83)
		a = theNAD83X * 3.28                // major radius of ellipsoid, map units (NAD 83)
		e = 0.08181922146          // eccentricity of ellipsoid (NAD 83)
		angRad = 0.01745329252     // number of radians in a degree
		pi4 = 3.141592653582 / 4   // Pi / 4
		p0 = 37.67 * angRad        // latitude of origin
		p1 = 38.33 * angRad           // latitude of first standard parallel
		p2 = 39.83 * angRad           // latitude of second standard parallel
		m0 = -122.0 * angRad       // central meridian
		x0 = 6561666.67                // False easting of central meridian, map units
		y0 = 1640416.67                  //False northing of central meridian, map units

		// Calculate the coordinate system constants.
		m1 = Math.cos(p1) / Math.sqrt(1 - ((e ^ 2) * Math.sin(p1) ^ 2))
		m2 = Math.cos(p2) / Math.sqrt(1 - ((e ^ 2) * Math.sin(p2) ^ 2))
		t0 = Math.tan(pi4 - (p0 / 2))
		t1 = Math.tan(pi4 - (p1 / 2))
		t2 = Math.tan(pi4 - (p2 / 2))
		t0 = t0 / (((1 - (e * (Math.sin(p0)))) / (1 + (e * (Math.sin(p0)))))^(e / 2))
		t1 = t1 / (((1 - (e * (Math.sin(p1)))) / (1 + (e * (Math.sin(p1)))))^(e / 2))
		t2 = t2 / (((1 - (e * (Math.sin(p2)))) / (1 + (e * (Math.sin(p2)))))^(e / 2))
		n = Math.log(m1 / m2) / Math.log(t1 / t2)
		f = m1 / (n * (t1 ^ n))
		rho0 = a * f * (t0 ^ n)

		// Convert the coordinate to Latitude/Longitude.

		// Calculate the Longitude.
		x =  - x0
		y =  - y0
		pi2 = pi4 * 2
		rho = Math.sqrt((x ^ 2) + ((rho0 - y) ^ 2))
		theta = Math.atan(x / (rho0 - y))
		t = (rho / (a * f)) ^ (1 / n)
		lon = (theta / n) + m0
		x = x + x0
		y = y + y0

		// Estimate the Latitude
		lat0 = pi2 - (2 * Math.atan(t))

		// Substitute the estimate into the iterative calculation that
		// converges on the correct Latitude value.
		part1 = (1 - (e * Math.sin(lat0))) / (1 + (e * Math.sin(lat0)))
		lat1 = pi2 - (2 * Math.atan(t * (part1 ^ (e / 2))))
		do {
			lat0 = lat1
			part1 = (1 - (e * Math.sin(lat0))) / (1 + (e * Math.sin(lat0)))
			lat1 = pi2 - (2 * Math.atan(t * (part1 ^ (e / 2))))
		} while (Math.abs(lat1 - lat0) >= 0.000000002);

		// Convert from radians to degrees.
		lat = lat1 / angRad
		lon = lon / angRad

		//Round the latitude and longitude
		lat = ((lat * 100000)) / 100000
		lon = ((lon * 100000)) / 100000

		// Calcuate degrees, minutes, and seconds.
		dLat = parseInt(lat)
		mLat = 60 * (lat - dLat)
		sLat = 60 * (mLat - parseInt(mLat))
		mLat = parseInt(mLat)

		lon = 0 - lon
		dLon = parseInt(lon)
		mLon = 60 * (lon - dLon)
		sLon = 60 * (mLon - parseInt(mLon))
		mLon = parseInt(mLon)
		lon = 0 - lon
		dLon = 0 - dLon

		//Round the seconds
		sLat = ((sLat * 100)) / 100
		sLon = ((sLon * 100)) / 100
		
		
		if (clientname=='SacCounty'||clientname=='SacCountyEOC') {
			coords += "<br><FONT class=tblHdrWhite><b>Lat/Lon</b>:<br><b>Lat</b>: " + sLat + "<br><b>Lon:</b>: " + sLon;
		}
*/
		coords +=  "</FONT><br><br>";	
		
		
		if(overMap){ writeStatus('r',coords,top.coordDOC);}
	}
	
	//Let's update the HTML in the Measure box, too, as the cursor moves around.
	var objCurrTool=findObj('CurrTool');

	if (objCurrTool!=null&&!stopdrawing){
		if (objCurrTool.value==10||(objCurrTool.value>=23&&objCurrTool.value<=25)||objCurrTool.value==32||objCurrTool.value==34) { VML_MD_MouseMove(mouseX,mouseY,objCurrTool.value); }
	}
}

function PrintMap(u,m) {
//	The purpose of this function is to open up a pop-up window, allowing the user to print the current map (this does not
//	use the print module).
//
	if (m==undef) {m='';}
	
	if (simpleGUI==1) {
		top.MapFrame.GoSimpleGUIiFrameRight(m+'Print/index.aspx');
	} else {
		top.fwinURL[3]=m+'Print/index.aspx' 
		var objTMP=findObj("iFrameSSLayer",document);
		ChangeiFrameURL(objTMP,"Print","yes",2);
	}
	//if (u=='-1') {newPwindow(m+'Print/Print.aspx?start=true','width=760,height=590,menubar=no,resizable=yes,tollbar=no,scrollbars=no,status=yes','PrintMap');
	//}else {newPwindow(m+'Print/PrintMap.aspx?murl=' + u,'width=760,height=590,menubar=no,resizable=yes,tollbar=no,scrollbars=no,status=yes','PrintMap');}
}

function SaveMap() {

	if (simpleGUI==1) {
		top.MapFrame.GoSimpleGUIiFrameRight('SS/savemap.aspx');
	} else {
		top.fwinURL[3]='SS/savemap.aspx' 
		var objTMP=findObj("iFrameSSLayer",document);
		ChangeiFrameURL(objTMP,"Save Map","yes",2);
	}
	hideKLayer(top.MapFrame.lyrSS);
}

function getMapXY(xIn,yIn){

	var tmpX=top.mapMinX+(xIn*xRatio); var tmpY=top.mapMinY+(yIn*yRatio)
	mapX=formatNumber(tmpX,2); mapY=formatNumber(tmpY,2);
}

function mapMouseDown(e){

	mapclicked=true;
	
	mouseBtn=window.event.button;shiftKey=window.event.shiftKey;
	if(mouseBtn>1){mapclicked=false;return};
	
	switch (crntTool) {
		case 2:
		case 5:
		case 31: zooming=true; break;
		case 22: parceldetails=true; break;
		case 23:
		case 24:
		case 25: buffering=true; break;
		case 27: parceldetails=true; break;
		case 29: parceldetails=true; break;
		case 40: addstreet=true; break;
		case 42: projectid=true; break;
		case 45: removestreet=true; break;
		case 19: identifyall=true; break;
	}

	//Only on these specific map functions do we want to do anything.  All others - ignore.
	if(zooming||identifyall||parceldetails||buffering||addstreet||removestreet||projectid||identifyall) {
		x1=mouseX;y1=mouseY;
		if (x1 <= 0 || y1 <= 0) {mapclicked=false; return;}
		else {
			//This is where we make the rubberband select box come alive!  So when the user moves the mouse (mapMouseMove, the box
			//will grow and shrink).
			lyrRectTop.move(mouseX,mouseY-1); lyrRectTop.size(rubberbandthick,rubberbandthick); lyrRectLeft.move(mouseX-1,mouseY);lyrRectLeft.size(rubberbandthick,rubberbandthick);lyrRectRght.move(mouseX-1,mouseY);lyrRectRght.size(rubberbandthick,rubberbandthick);lyrRectBotm.move(mouseX,mouseY-1);lyrRectBotm.size(rubberbandthick,rubberbandthick);
			showZoomRect(); 
		}
	}
}

function haltmouseclicks() {

	objMap.onmouseover=Nothing;	objMap.onmouseout=Nothing; objMap.onmousedown=Nothing; objMap.ondblclick=Nothing; document.onmouseup=Nothing; document.onmousemove=Nothing; document.onselectstart=Nothing;
}

function resumemouseclicks() {

	//Panning (11) is special since we're dragging the map - so ignore this request if we're panning.
	if (crntTool!=11) {
		objMap.onmouseover=mapMouseOver;objMap.onmouseout=mapMouseOut;objMap.onmousedown=mapMouseDown;objMap.ondblclick=mapMouseDblClick;
		document.onmouseup=mapMouseUp;document.onmousemove=mapMouseMove;document.onselectstart=new Function ("return false");
	}
}

function mapMouseUp(e){

	var objMapClickedX=findObj('MapClickedX')
	var objCMinX=findObj('CMapMinX'),objCMaxX=findObj('CMapMaxX'),objCMinY=findObj('CMapMinY'),objCMaxY=findObj('CMapMaxY');
	var dX=lyrMap.getLeft()+lyrMapImg.getLeft(),dY=lyrMap.getTop()+lyrMapImg.getTop();
	var looksok=false;

	//Clear out floating window URL array
	//clearFWinary();

	//If user clicked on the map then...
	if(mapclicked){
		if (crntTool==20||crntTool==10||crntTool==24||(crntTool>=30&&crntTool<=34)) {}else{haltmouseclicks();}

		objCMinX.value=0;objCMaxX.value=0;objCMinY.value=0;objCMaxY.value=0;
		objMapClickedX.value=0;


		if( (zooming||buffering||parceldetails||projectid||addstreet||identifyall||removestreet)  ){
			if (x1>0 && y1>0) {
				if((x1>x2)&&(x2>0)){z=x2;x2=x1;x1=z};
				if((y1>y2)&&(y2>0)){z=y2;y2=y1;y1=z};
				if(x1>0){objMapClickedX.value=x1-minX; objCMinX.value=(x1-minX)*xRatio;}
				if(y1>0){objCMinY.value=(y1-minY)*yRatio;}
				if(x2>0 && (x2-x1 > CoordThreshold) ){objCMaxX.value=(x2-minX)*xRatio;} else {if(x1>0) {objCMaxX.value=0;} };
				if(y2>0 && (y2-y1 > CoordThreshold) ){objCMaxY.value=(y2-minY)*yRatio;} else {if(y1>0) {objCMaxY.value=0;} };
				looksok=true;
			} else { looksok=false; }
		}else{
			if (mouseX>0 && mouseY>0) {
				objMapClickedX.value=mouseX-minX;
				objCMinX.value=(mouseX-minX)*xRatio; objCMinY.value=(mouseY-minY)*yRatio;
				objCMaxX.value=0; objCMaxY.value=0;
				looksok=true;
			} else { looksok=false; }
		}

		if (crntTool==10||(crntTool>=30&&crntTool<=34)) {looksok=true;}

		buffering=false;

		if (crntToolType==2 && looksok==true) {
			switch(crntTool){
				case 10:SSAction(10,""); break;		//10=Measure
				case 30:
				case 31:
				case 32:
				case 33:
				case 34: SSAction(crntTool,""); break;  //Drawing

				case 19:identifyall=false;			//ID All
						if (top.idAllLayerWindowtitle=="") {top.idAllLayerWindowtitle="Identify All";}
						SSAction(19,top.idAllLayerWindowtitle);
						break;
				case 20:SSAction(6,"Identify " + jsParcelDisplayNameSingular);break;	//Brief ID Parcels
				case 22:var objZoomToFeature=findObj('ZoomToFeature'); objZoomToFeature.value="N"; SSAction(7,jsParcelDisplayNameSingular + " Details");break;	//Parcel Details
				case 23:	//Buffer by rectangle
						buffering=true;
						setBuffType("rectangle",23); 
						switch (top.bufferextract) {
						case '1':	SSAction(8,"Buffer Area");
									break;
						case '2':	SSAction(8,"Extract Area");
									break;
						case '4':	SSAction(8,"Demographic Analysis");
									break;
						}
						break;
				case 24:	//Buffer by line/polygon
						buffering=true;
						setBuffType("line_poly",24); 

						switch (top.bufferextract) {
						case '1':	SSAction(24,"Buffer Selection");
									break;
						case '2':	SSAction(24,"Extract Selection");
									break;
						case '4':	SSAction(24,"Demographic Selection");
									break;
						}

						break;

				case 27:var objZoomToFeature=findObj('ZoomToFeature'); objZoomToFeature.value="N"; SSAction(7,"Parcel Project History");break;
				case 28:SSAction(crntTool,""); break;
				case 29:var objZoomToFeature=findObj('ZoomToFeature'); objZoomToFeature.value="N"; SSAction(7,"Permit Details");break;	//Permit Details
				case 40:	//Proj coord - add a street
						addstreet=false;
						resumemouseclicks();
						RefreshMap();
						break;
				case 42:	//Proj coord - ID Project
						projectid=false;
						ProjAction(5,'Identify Projects');
						resumemouseclicks();
						break;
				case 45:	//Proj coord - remove a street
						removestreet=false;
						resumemouseclicks();
						RefreshMap();
						break;
				case 80:	//RGis
						resumemouseclicks();
						RefreshMap();
						break;
				default:RefreshMap();break;
			};
		}
	}

	//Initialize and set all variables to false.
	zooming=false;parceldetails=false;mapclicked=false;removestreet=false;addstreet=false;identifyall=false;projectid=false;hideZoomRect();
}

function mapMouseOut(e){

	overMap=false;
}

function mapMouseOver(e){

	overMap=true;


	if(crntTool==11){Drag.init(objMap,null);objMap.onDragStart=dragStartMap;objMap.onDragEnd=dragEndMap;}
}

function checkMousePos(){

	oMinX=lyrMap.getLeft()+lyrMapImg.getLeft();oMinY=lyrMap.getTop()+lyrMapImg.getTop();
	if((mouseX<=minX)||(mouseY<=oMinY)||(mouseX>=maxX)||(mouseY>=maxY)){return false}else{return true};
}

function hideZoomRect(){

	lyrRectTop.hide();lyrRectLeft.hide();lyrRectRght.hide();lyrRectBotm.hide();
	if(!zooming&&!buffering&&!parceldetails&&!projectid&&!addstreet&&!identifyall&&!removestreet){lyrRectTop.move(0,0);lyrRectLeft.move(0,0);lyrRectRght.move(0,0);lyrRectBotm.move(0,0)};
}

function showZoomRect(){
//	The purpose of this function is to show the rubberband selection box.
//
	lyrRectTop.show();lyrRectLeft.show();lyrRectRght.show();lyrRectBotm.show();
}

function RefreshMap(){
//	The purpose of this function is to refresh the current map.  In essence, this will submit the main processor FORM.  This form is a
//	zero-height (hidden) form which does all of the processing.  This form also houses all the form variables required to process map
//	requests.  
//
	//Display a message in the window status bar and show the loading layer image.
	window.status = "Sending information to server..."
	top.ProcessDone=false;
	positionLoadingLyr();
	
	//If everything is kosher, disable the mouse and proceed forward!
	if(objMap!=null){
		haltmouseclicks();
		submitted=true;
	};

	setVal('WindowWidth',getWindowWidth());setVal('WindowHeight',getWindowHeight());

	//Submit the main processor form.
	top.Process.MapForm.submit();
}

function windowResized(){
//	The purpose of this function is to take appropriate action upon a resize of the browser window.  We set a boolean variable (resizing)
//	so we don't execute the code in this function more than once.
//
	if (!resizing) {
		//Show the loading layer.  We then need to get the new height and width.  We basically tell the main processor form that we're
		//just refreshing the map as a layer change (even though no layers have changed)
		positionLoadingLyr();
		var objLayerChange=findObj('LayerChange');
		var objWH=findObj('WindowHeight'); if (objWH!=null) {objWH.value=getWindowHeight();}
		var objWW=findObj('WindowWidth'); if (objWW!=null) {objWW.value=getWindowWidth();}
		objLayerChange.value="Y";
		if(!resizing){wpt=window.setInterval('getWindowParams()', 250)};
		resizing=true;

		//If we have our fixed right docked window, we need to make sure that the height is 100% of the new window size.
		if (simpleGUI==1) {
			var objED=findObj('iEDFrameContent', top.MapFrame.document); 
			objED.style.height = "100%"; //IE ONLY
		}

		//Call repositionElements in 400ms.  This will reposition any floating windows outside of the browser's range.
		ret=window.setInterval('repositionElements()', 400)
	}
}

function repositionElements(){
//	The purpose of this function is make sure the map and pan arrow areas are positioned & sized properly.
//

	//If map object still exists (it should!)
	if((findObj('Map',document))!=null){
		lyrMap.move(minX,minY);	//reposition the map to the 0,0 position

		//Make sure the map is the proper size that it should be
		lyrMap.size(getWindowWidth()-minX,getWindowHeight()-lyrMap.getTop())
		minX=lyrMap.getLeft(); minY=lyrMap.getTop(); mapW=lyrMap.getWidth(); mapH=lyrMap.getHeight();

		//Calculate the xRatio and yRatio values - used throughout app to translate mouse x,y to map x,y
		if (simpleGUI==1) {
			maxX=minX+mapW-dockedRightPaneWidth;
			maxY=minY+mapH-dockedBottomPaneHeight;
		} else {
			maxX=minX+mapW;
			maxY=minY+mapH;
		}

		xRatio = (top.mapMaxX-top.mapMinX)/(maxX-minX);
		yRatio = (top.mapMaxY-top.mapMinY)/(maxY-minY); //had -20 here!
	}

	//If we have a valid map, clear the timeout which calls this function over and over
	if (top.mapMaxX!=0||top.mapMaxY!=0||top.mapMinX!=0||top.mapMinY!=0) {clearTimeout(ret);}

	if (jsPanArrows==1) { 
		var objPT=findObj('PanBGT',top.MapFrame.document);
		var objPB=findObj('PanBGB',top.MapFrame.document);
		var objPL=findObj('PanBGL',top.MapFrame.document);
		var objPR=findObj('PanBGR',top.MapFrame.document);

		if (clientname=='Ventura') {
			objPT.style.width=parseInt( (top.mapMaxX-top.mapMinX)/xRatio - (panborderwidth*2)) + "px";
			objPB.style.width=parseInt( (top.mapMaxX-top.mapMinX)/xRatio - (panborderwidth*2)) + "px";
			objPL.style.height=parseInt(((top.mapMaxY-top.mapMinY)/yRatio)-panborderwidth-3) + "px";
			objPR.style.height=parseInt(((top.mapMaxY-top.mapMinY)/yRatio)-panborderwidth-3) + "px";
		} else {
			objPT.style.width=parseInt( (top.mapMaxX-top.mapMinX)/xRatio - (panborderwidth*2)-2) + "px";
			objPB.style.width=parseInt( (top.mapMaxX-top.mapMinX)/xRatio - (panborderwidth*2)-2) + "px";
			objPL.style.height=parseInt(((top.mapMaxY-top.mapMinY)/yRatio)) + "px";
			objPR.style.height=parseInt(((top.mapMaxY-top.mapMinY)/yRatio)) + "px";
		}
	}
	//If we have a bottom docked layer, call the resizeBottomNavFrame function to make sure it's sized properly.
	if (parseInt(dockedBottomPaneHeight)>0) { resizeBottomNavFrame(); }
}

function getWindowParams(){

	if(resizing){
		if((resizeCnt>=1)&&(crntWinWid==getWindowWidth())&&(crntWinHgt==getWindowHeight())){
			clearTimeout(wpt);
			SetCurrTool(55,1);
			init_all_Drag();
			RefreshMap();
		}else{
			if((crntWinWid==getWindowWidth())&&(crntWinHgt==getWindowHeight())){resizeCnt=resizeCnt+1;}
		}
		crntWinWid=getWindowWidth();crntWinHgt=getWindowHeight();
	}
}

// for floating layers
function showFloatingLayer(lyr){

	var newX=0,newY=0,j=null,lID=lyr.id;

	setVal(lID+'Visible',1);setChk('vis'+lID,true);
	if(exists(lID+'Left'))newX=parseInt(getVal(lID+'Left'),10);
	if(exists(lID+'Top'))newY=parseInt(getVal(lID+'Top'),10);

	for(i=0; i<arrLyrNames.length;i++){
		if(arrLyrNames[i].toLowerCase()==lyr.id.toLowerCase()){
			j=arrLyrStyle[i]
		};
	}
	lyr.move(newX,newY);checkLayerPosition(lyr,j);bringLayerToFront(lyr);lyr.show();
}

function hideFloatingLayer(lyr,t){
//	The purpose of this function is to hide a specific floating layer.  The input variable, lyr, is a pointer to the layer object of the
//	floating window. 
//
	if(hideFloatingLayer.arguments.length<2){
		setVal(lyr.id+'Visible',0);setChk('vis'+lyr.id,false);
		if(lyr.getLeft()>0)setVal(lyr.id+'Left',lyr.getLeft());
		if(lyr.getTop()>0)setVal(lyr.id+'Top',lyr.getTop());
	}
	sendLayerToBack(lyr);lyr.hide();lyr.move(-1000,-1000);
}

// layer positioning functions
function centerLayer(lyr){
//	The purpose of this function is to center a specific layer (like the loading GIF layer)
//
	lyr.move((getWindowWidth()-lyr.getWidth())/2, (getWindowHeight()-lyr.getHeight())/2)
}

function minLayer(lyr) {
//	The purpose of this function is to minimize a floating layer.  All we're really doing is resizing it to be 16px tall & just show the
//	top bar (with the min, restore, and close buttons)
//
	lyr.size(lyr.getWidth(),16);

	if (VertTB==1) { tb=12; } else {tb=0;}
}
function minLongWindow(lyr) {
//	The purpose of this function is to minimize one of the speical wide windows (buffer, ID All, Search All).
//
	lyr.size(lyr.getWidth(),16);

	lyr.move(0,maxY-16);
}

function dockLayerRight(lyr){
//	The purpose of this function is to properly dock a layer to the right.  All we really need to do is size the layer properly,
//	and force it to the right (using the MOVE layer function).
//
	var tb;
	lyr.size(lyr.getWidth(),lyrMap.getHeight());

	if (VertTB==1) { tb=12; } else {tb=0;}
	lyr.move(maxX-tb+14-lyr.getWidth(),minY);

}

function bringLayerToFront(lyr){

	lastz=lastz+1;lyr.moveZ(lastz);
}

function sendLayerToBack(lyr){
//	The purpose of this function is to adjust the z-index of a floating layer to bring it to the back of the layer stack.
//
	if (isIE) lyr.moveZ(-1);
	else lyr.moveZ(0);
}

function swapLayerVis(lyr,s){
//	The purpose of this function is to hide a floating layer if it is being displayed, and vice versa.
//
	var r;

	//If we have a string, then it's the layer's name... otherwise it's a pointer to the floating window layer
	if(typeof lyr=='string'){
		if(findObj(lyr)!=null){lyr=layer(lyr)}else{return};
	}
	if(typeof lyr=='object'){
		if(lyr.isVisible()){r='n';hideKLayer(lyr);}else{r='d';showKLayer(lyr);};
	}
}

// single entry points for showing/hiding both floating layers and popup browser windows
function showKLayer(lyr){
//	The purpose of this function is to show a floating window layer.
//
	
	//If we have a string, then it's the layer's name... otherwise it's a pointer to the floating window layer
	if(typeof lyr=='string'){
		if(findObj(lyr)!=null){lyr=layer(lyr);}else{openPopUpLayer(lyr);return}
	}
	if(typeof lyr=='object'){showFloatingLayer(lyr)}
}

function hideKLayer(lyr){
//	The purpose of this function is to hide a floating window layer.
//
	//If we have a string, then it's the layer's name... otherwise it's a pointer to the floating window layer
	if(typeof lyr=='string'){
		if(findObj(lyr)!=null){lyr=layer(lyr)}else{closePopUpLayer(lyr);return}
	}
	if(typeof lyr=='object'){hideFloatingLayer(lyr)}
}

function IDALLStuff(pUrl,n) {
//	The purpose of this function is to change the wide ID All window's URL.  n is the title of the floating window.

	if (jsMenuStyle=='') {
		if (simpleGUI==1) {
			GoSimpleGUIiFrameRight(pUrl);
		}else{
			top.fwinURL[3]=pUrl;
			var objTMP=findObj("iFrameSSLayer",document);
			ChangeiFrameURL(objTMP,"","yes",2);
		}
	}else{
		newwindow(pUrl,'height=95,width=750,menubar=yes,resizable=yes,tollbar=yes,scrollbars=yes','IDAll')
	}
}

function SearchAllACN() {
	if (clientname=='SacCountyAssessor') {
		GoSimpleGUIiFrameRight('custom/searchmain.aspx')
	} else {
		Nothing();
	}
}
function SSAction(i,n,uids) {
//	The purpose of this function is to handle the majority of map functions.  This function is typically called after the user
//	depressed the mouse button (like clicking on a parcel for parcel details).  
//

	if ( (i>=6&&i<=10) || (i==12||i==19||i==24||i==25)|| (i>=28&&i<=34) ) {
		//Each of these map functions needs the x,y coordinates of the mouse when the mouse button was depressed.	
		//6=brief parcel identify    7=parcel details  8=Buffer Area  9=Data  10=Measure 19=Identify All  29=Search All
		//24 is selection by line / polygon; 
		
		//First, we capture the full coordinates of the current mouse location (in map coordinates)
		var objCMinX=findObj('CMapMinX'),objCMinY=findObj('CMapMinY');
		var objCMaxX=findObj('CMapMaxX'),objCMaxY=findObj('CMapMaxY');
		
		//Let's get the current map extent envelope coordinates, too.
		var objEMinX=findObj('EnvelopeMinX'),objEMaxY=findObj('EnvelopeMaxY');
		var objEMaxX=findObj('EnvelopeMaxX'),objEMinY=findObj('EnvelopeMinY');

		//Take the envelope coordinates & add it to our current position
		var X=parseFloat(objEMinX.value)+parseFloat(objCMinX.value);
		var Y=parseFloat(objEMaxY.value)+parseFloat(objCMinY.value);

		//If the user just clicked on the map, then the MAX variables (x and y) will be 0.  If it was a rubber band, then they will be >0
		if (objCMaxX.value!=0 && objCMaxY.value!=0) {
			var Xend=parseFloat(objEMinX.value)+parseFloat(objCMaxX.value);
			var Yend=parseFloat(objEMaxY.value)+parseFloat(objCMaxY.value);
		} else {
			var Xend=0; var Yend=0;
		}
		objCMinX.value=X; objCMaxX.value=Xend; objCMinY.value=Y; objCMaxY.value=Yend;
		
		//6=brief parcel identify
		//Simply direct the right docked layer to the brief parcel ID page with the exact x,y coordinates
		if (i==6) {	top.MapFrame.positionLoadingLyr(); if (simpleGUI==1) { GoSimpleGUIiFrameRight("SS/parcel_id_brief_process.aspx?w=" + i + "&minX=" + X + "&minY=" + Y); }else{ top.fwinURL[3]="SS/parcel_id_brief_process.aspx?w=" + i + "&minX=" + X + "&minY=" + Y; var objTMP=findObj("iFrameSSLayer",document); ChangeiFrameURL(objTMP,"Parcel Identify","yes",2); } }

		//7=parcel details  
		//Simply direct the right docked layer to the detailed parcel ID page with the exact x,y coordinates
		//Of course, check to make sure the selected area isn't TOO big.
		if (i==7&&econdev==0&&simpleGUI==0) { if ( ((Xend-X)<SelectAreaMax)||((Y-Yend)<SelectAreaMax) )  { top.MapFrame.positionLoadingLyr(); recordCoordsforBuffHL(X,Xend,Y,Yend,-1); top.fwinURL[3]="SS/parcel_id_detail_process.aspx?w=" + i + "&minX=" + X + "&minY=" + Y + "&maxX=" + Xend + "&maxY=" + Yend; var objTMP=findObj("iFrameSSLayer",document); ChangeiFrameURL(objTMP,n,"yes",2); }  else { alert (jsstrAreaTooBig); resumemouseclicks(); } }
		if (i==7&&(econdev==1||simpleGUI==1)) { if ( ((Xend-X)<SelectAreaMax)||((Y-Yend)<SelectAreaMax) )  { top.MapFrame.positionLoadingLyr(); recordCoordsforBuffHL(X,Xend,Y,Yend,-1); if (simpleGUI==1) { if (econdev==0||top.EDH==1) { GoSimpleGUIiFrameRight("SS/parcel_id_detail_process.aspx?w=" + i + "&minX=" + (X) + "&minY=" + (Y) + "&maxX=" + (Xend) + "&maxY=" + (Yend)); }else{ GoSimpleGUIiFrameRight("EconDev/PropertyDetails_Front.aspx?U=&minX=" + (X) + "&minY=" + (Y) + "&maxX=" + (Xend) + "&maxY=" + (Yend) + "&sb=" + top.edIDBiz + "&URL="); } }else{ var objEDFrm=findObj('iEDFrameContent',top.MapFrame.document); if (objEDFrm!=null) { objEDFrm.src="EconDev/PropertyDetails.aspx?U=&minX=" + (X) + "&minY=" + (Y) + "&maxX=" + (Xend) + "&maxY=" + (Yend) + "&sb=1&URL="; } } }  else { alert (jsstrAreaTooBig); resumemouseclicks(); } }

		//8=Buffer Area  
		//Simply direct the bottom wide window layer to the buffer step 2 page with the exact x,y coordinates.  We also need the layer that
		//the user is buffering around.  Lastly, we check to make sure the selected area isn't TOO big.
		if (i==8) {
			var objBuffType=findObj('BuffType'); 

			switch (top.bufferextract) {
			case '1':
					//Buffer
					if (objBuffType.value=='rectangle') { if ( ((Xend-X)<SelectAreaMax)||((Y-Yend)<SelectAreaMax) )  { buffering=false; var objLtB=findObj("LayerToBuffer",top.bufferselectionDOC); var objLtB2=findObj("LayerToBuffer"); objLtB2.value=objLtB.value; if (simpleGUI==1) { top.MapFrame.GoSimpleGUIiFrameRight("SS/buffer.aspx?w=" + i + "&minX=" + (X) + "&minY=" + (Y) + "&maxX=" + (Xend) + "&maxY=" + (Yend) + "&LtB=" + objLtB.value); } else { top.fwinURL[3]="SS/buffer.aspx?w=" + i + "&minX=" + (X) + "&minY=" + (Y) + "&maxX=" + (Xend) + "&maxY=" + (Yend) + "&LtB=" + objLtB.value; var objTMP=findObj("iFrameSSLayer",document); ChangeiFrameURL(objTMP,"Buffer","yes",2); }; RefreshMap();} else { alert (jsstrAreaTooBig); buffering=false; resumemouseclicks(); } }
					if (objBuffType.value=='line_poly') { if ( 1 )  { buffering=false; var objLtB=findObj("LayerToBuffer",top.bufferselectionDOC); var objLtB2=findObj("LayerToBuffer"); objLtB2.value=objLtB.value; if (simpleGUI==1) { top.MapFrame.GoSimpleGUIiFrameRight("SS/buffer.aspx?w=" + i + "&sel=lp&LtB=" + objLtB.value); } else { top.fwinURL[3]="SS/buffer.aspx?w=" + i + "&sel=lp&LtB=" + objLtB.value; var objTMP=findObj("iFrameSSLayer",document); ChangeiFrameURL(objTMP,"Buffer","yes",2); }; RefreshMap();} else { alert (jsstrAreaTooBig); buffering=false; resumemouseclicks(); } }
					break;
			case '2':
					//Extract
					if (objBuffType.value=='rectangle') {
						if (Xend==0) {Xend==X+.01};
						if (Yend==0) {Yend==Y+.01};
						buffering=false; 
						exurl="SS/extract_predefined.aspx?arypts=" + X + "," + Y + "," + X + "," + Yend + "," + Xend + "," + Yend + "," + Xend + "," + Y + "," + X + "," + Y + "&selectby=polygon&LayersToExtract=" + top.EXS1Frm.extractselection.LayersToExtract.value; 
						if (simpleGUI==1) { 
							top.MapFrame.GoSimpleGUIiFrameRight(exurl) 
						} else { 
							top.fwinURL[3]=exurl; var objTMP=findObj("iFrameSSLayer",document); ChangeiFrameURL(objTMP,"Extract","yes",2); 
						}
					}
					break;
			case '4':
					//Demographic Analysis
					if (objBuffType.value=='rectangle') {
						if (Xend==0) {Xend==X+.01};
						if (Yend==0) {Yend==Y+.01};
						buffering=false; 
						exurl="EOC/x.aspx?arypts=" + X + "," + Y + "," + X + "," + Yend + "," + Xend + "," + Yend + "," + Xend + "," + Y + "," + X + "," + Y + "&selectby=polygon&LayersToExtract=" + top.EXS1Frm.extractselection.LayersToExtract.value; 
					}
					break;
			}
		}
		//9=Data  
		//Displays the MetaData layer
		if (i==9) { var objData=top.MapFrame.findObj('iFramedataLayer',top.MapFrame.document); if (objData!=null) { objData.src="includes/fwindow.aspx?l=data&title=MetaData&src=../Custom/custom_metadata.asp?s=yes"; } showFloatingLayer(lyrdata); }

		//Measure(10);Buffer(24)
		if (i==10||i==24||(i>=30&&i<=34)) { VML_Map_click(mouseX,mouseY,i); }

		if (i==12&&objBuffType.value=='line_poly') { if ( 1 )  { RefreshMap();} else { alert (jsstrAreaTooBig); buffering=false; resumemouseclicks(); } }

		//19=Identify All
		//Simply direct the bottom wide window layer to the ID All page with the exact x,y coordinates.  We also need the layer(s) that
		//the user is ID All'ing on.  Lastly, we check to make sure the selected area isn't TOO big.
		if (i==19) { if ( ((Xend-X)<SelectAreaMax)||((Y-Yend)<SelectAreaMax) )  { IDALLStuff("SS/id_all.aspx?l=" + top.idAllLayers + "&minX=" + (X) + "&minY=" + (Y) + "&maxX=" + (Xend) + "&maxY=" + (Yend) + "&p=1",n);}  else { alert (jsstrAreaTooBig); resumemouseclicks(); } }

//		if (i==28){ RefreshMap();}
		
		if (i==28){ if (simpleGUI==1) { GoSimpleGUIiFrameRight("custom/custom_service_request_integration.aspx?minX=" + X + "&minY=" + Y); }else{ top.fwinURL[3]="custom/custom_service_request_integration.aspx?minX=" + X + "&minY=" + Y; var objTMP=findObj("iFrameSSLayer",document); ChangeiFrameURL(objTMP,n,"yes",2); } }

		//29=Search All
		//Simply direct the bottom wide window layer to the Search All page to begin the Search All process.
		if (i==29) { top.MapFrame.positionLoadingLyr(); IDALLStuff("SS/search_all.aspx?p=1",n); }
	} else {
		//Here we simply want to change the URL of our right docked layer to the appropriate page.  We don't really need to capture
		//any mouse coordinates, etc. - just display some results.
		if (simpleGUI==1) {
			GoSimpleGUIiFrameRight("SS/ss_blank.aspx?w=" + i + "&uids=" + uids);
		}else{
			top.fwinURL[3]='SS/ss_blank.aspx?w=' + i + "&uids=" + uids; 
			var objTMP=findObj("iFrameSSLayer",document);
			ChangeiFrameURL(objTMP,n,"yes",2);
		}
	}
}

function recordCoordsforBuffHL(X1,X2,Y1,Y2,L) {

	//top.bufX1=0;
	//top.bufY1=0;
	//top.bufLyr='';
	//return;
	
	top.bufX1=X1;
	if (X2!=0) { top.bufX2=X2; } else { top.bufX2=X1+.01}
	top.bufY1=Y1;
	if (Y2!=0) { top.bufY2=Y2; } else { top.bufY2=Y1+.01}
	top.bufLyr=L;
}

function ProjAction(i,n) {
//	The purpose of this function is to take appropriate action based upon the Project Coordination action that the user is trying to do.
//

	//For the most part, we can just direct the right docked layer to the catch-all proj_blank.aspx page with the appropriate action
	//variable (i).  (e.g. i=4 - Search Projects; i=6 - Project Report...
	if (i!=5){
		top.fwinURL[3]='Projects/proj_blank.aspx?w=' + i
		var objTMP=findObj("iFrameSSLayer",document);
		ChangeiFrameURL(objTMP,"Project Search","yes",2);
	} else {	
		//5 is project Identify -need envelope coords for that.
		var objCMinX=findObj('CMapMinX'),objCMinY=findObj('CMapMinY'),objCMaxX=findObj('CMapMaxX'),objCMaxY=findObj('CMapMaxY');
		var objEMinX=findObj('EnvelopeMinX'),objEMaxY=findObj('EnvelopeMaxY'),objEMaxX=findObj('EnvelopeMaxX'),objEMinY=findObj('EnvelopeMinY');

		X=parseFloat(objEMinX.value)+parseFloat(objCMinX.value),Y=parseFloat(objEMaxY.value)+parseFloat(objCMinY.value);
		if (objCMaxX.value!=0 && objCMaxY.value!=0) {
			var Xend=parseFloat(objEMinX.value)+parseFloat(objCMaxX.value);
			var Yend=parseFloat(objEMaxY.value)+parseFloat(objCMaxY.value);
		} else {
			var Xend=0,Yend=0;
		}
		
		//Once we have the selected coordinates, let's go ahead and direct the right docked layer to the project ID page with the coordinates.
		top.fwinURL[3]='Projects/proj_id.aspx?minX=' + X + '&minY=' + Y + '&maxX=' + Xend + '&maxY=' + Yend
		var objTMP=findObj("iFrameSSLayer",document);
		ChangeiFrameURL(objTMP,"Project Search","yes",2);
	}
}

function MapViewAction(id) {
	var frmMF = findObj("MapFunction")
	var frmMVID = findObj("MapViewID")

	frmMF.value=70;
	frmMVID.value=id;
	
	RefreshMap();
}

function SSRefreshMap (value,url,m) {
//	The purpose of this function is to take action based upon several different map functions that are handled in this function.  In many
//	cases, this function is called to refresh the map and to pipe in some form variables to do some sort of action.
//
	var varAPN, varLastFour, varRevAPN
	var frmAPN = findObj("APN")
	var frmSSUrl = findObj("SSUrl")
	var frmMF = findObj("MapFunction")
	var frmcurrTool = findObj("currTool")
	var frmiFrameContent = findObj("iFrameContent")
	var frmBufferCoords = findObj("BufferCoords")

	if (m!=undef) { //Econ Dev (Ventura) - selected parcels
		var frmCoordInfo=findObj("CoordInfo");
		frmAPN="";
		frmCoordInfo.value=value;
		frmSSUrl.value="";
		frmMF.value=60;
		if (frmcurrTool.value != 22 && frmcurrTool.value != 29 && frmcurrTool.value !=27) { frmcurrTool.value=2; }  //22=parcel details, 26=permit details
	} else if (value == "parceldetails") {		//Parcel Details
		frmMF.value=1;
		frmcurrTool.value=22; //23
		frmSSUrl.value=url;
		RefreshMap();
		return;
	} else if (value == "buffer") {				//Executing a buffer
		frmMF.value=1;
		frmcurrTool.value=2;
		frmBufferCoords.value=url; //contains xmin,ymin from buffer
		RefreshMap();
		return;
	} else if (value == 'bufferclear') {		//clear map before doing a buffer
		frmMF.value=27;
		frmcurrTool.value=2;
		var objBufUrl=findObj("BufUrl");
		objBufUrl.value="";
		url="";
	} else if (value == 'extractclear') {		//clear map before doing a extract
		frmMF.value=27;
		frmcurrTool.value=2;
		var objBufUrl=findObj("BufUrl");
		var objEX=findObj("ExtractSelectBy");
		objBufUrl.value="";
		objEX.value="Polygon";
		url="";
	} else if (value == 'IDAllclear') {			//Clear map before doing an ID All
		frmMF.value=19;
		frmcurrTool.value=2;
		var objBufUrl=findObj("BufUrl");
		objBufUrl.value="";
		url="";

		top.idAllLayers ="";
		IDALLStuff("SS/id_all.aspx?p=1&Mode=&l=","Identify All");
	} else if (value == 'projectclear') {		//Clear out the map before creating a new project
		frmMF.value=49;
		frmcurrTool.value=2;
//	} else if (value == 'DeleteBufferPoint' || value == 'DeleteextractPoint') {	//Delete the last point created (buffer)
//		frmMF.value=28;
//		frmcurrTool.value=2;
	} else if (value != "") {					//Parcel Details
		value=value.toString();

		varLastFour = value.substring(10,14);
		varRevAPN = value.substring(0,10)

		if (varLastFour == 0000)
		{
			varAPN = value;
		} else {
			varAPN = varRevAPN+"0000";
		}

		frmAPN.value=value;
		frmSSUrl.value=url;
		frmMF.value=1;
		if (frmcurrTool.value != 22 && frmcurrTool.value!=29 && frmcurrTool.value!=27) { frmcurrTool.value=2; }  //22=parcel details
	} else {								//Clear All button was pressed
		frmMF.value=0;
		frmcurrTool.value=2;
		hideKLayer(lyrdata);

		//For Project coordination, we want to reset the display options form.
		if (jsAppType=='ProjCoord') {
			if (top.objProj_Method!=null) {top.objProj_Method(0).checked=true;}
			if (top.ProjSym_Type!=null) {top.ProjSym_Type="";}
			
			objProjectParams = top.MapFrame.findObj("ProjectParams");
			if (objProjectParams!=null) {
				objProjectParams.value="";
			}			
			if (top.objSetMeth!=null) {top.objSetMeth('');}
		}

		if (frmiFrameContent!=null) {
			frmSSUrl.value="../"+frmiFrameContent.src;
		}
	}
	RefreshMap();
}

function checkLayerPosition(lyr,j){
//	The purpose of this function is to check the exact Top and Left position of a given layer to make sure that it is within the
//	browser window (and hasn't been dragged outside of the window.
//

	//j=2 is right docked layer. Call a positioning function and leave
	if(j=='2'){dockLayerRight(lyr);return};

	//Otherwise, j=0, which is a normal, draggable, floating window.
	var x1,x2,y1,y2;
	var fLeft=findObj(lyr.id+'Left');
	var fTop=findObj(lyr.id+'Top');
	if((fLeft==null)||(fTop==null)){return};

	x1=parseInt(fLeft.value,10);
	y1=parseInt(fTop.value,10);

	//If we have a bottom docked window, then we need to make sure users can't drag a window beyond it.
	if (simpleGUI==1) {
		tmpmaxX=parseInt(maxX)+parseInt(dockedRightPaneWidth);
		x2=tmpmaxX-parseInt(lyr.getWidth(),10);

		tmpmaxY=parseInt(maxY)+parseInt(dockedBottomPaneHeight);
		y2=tmpmaxY-parseInt(lyr.getHeight(),10);
	} else {
		x2=maxX-parseInt(lyr.getWidth(),10);
		y2=maxY-parseInt(lyr.getHeight(),10);
	}

	//Now we make sure that the x,y coordinates of our window are within the browser window.  If not, ground it!
	if(x2<0){x2=0};
	if(x1>x2){fLeft.value=x2;lyr.moveX(x2)};
	if(x1<0){fLeft.value=0;lyr.moveX(1)};
	if(y2<minY){y2=minY};
	if(y1>y2){fTop.value=y2;lyr.moveY(y2)};
	if(y1<minY+1){fTop.value=minY;lyr.moveY(minY)};
}

function positionLoadingLyr(){
//	The purpose of this function is to display the loading GIF image - most commonly displays when processing is being handled by the
//	main processing form.
//
	pLoaded=false;
	lyrHideAll.show();			//This is a clear layer which disallows a user to click anywhere while the loading GIF is up.
	lyrLoading.moveZ(lastz+2);
	centerLayer(lyrLoading);
	lyrLoading.show();
	top.loadTimeOut=window.setTimeout("top.MapFrame.pageLoaded();",30);

	//If 1 minute is up, then we need to alert the user that we're giving them control again - but processing is still going on.
	if (pLoadedTO==0) {
		pLoadedTO=setTimeout(" if (pLoaded==false) {alert (jsControlString); resumemouseclicks(); hideLoadingLyr(); }",intWait);
	} else {
		clearTimeout(pLoadedTO);
		pLoadedTO=setTimeout("if (pLoaded==false) {alert (jsControlString); resumemouseclicks(); hideLoadingLyr(); }",intWait);
	}
}

//	The purpose of this function is to hide the loading layer.  If the variable HaltLYRHide is 1, then we ignore this function.
function hideLoadingLyr()	{ if (top.HaltLYRHide==1) {return;}else{/*pLoaded=true;*/ clearTimeout(pLoadedTO); lyrLoading.hide(); lyrHideAll.hide();} }

function UpdateSelTool(s) {
//	The purpose of this function is to prepare (generate the HTML) to update the "Current Tool" box (upper right hand corner of application).
//
	top.currentToolText=s;
///	window.status="Current Tool: " + top.currentToolText;
	writeStatus('l',"<TABLE width='220' class='borderw'><TR><TD><FONT class=ssmsg3>Tool:&nbsp;"+s+"</FONT></TD></TR></TABLE>",lyrStatusBarTool.object);
}

function writeStatus(l,s,o){
//	The purpose of this function is to update the "Current Tool" box (upper right hand corner of application).
//
	if (o==undef) {return;}
	if(l=='r'){if(sStatus!=s){sStatus=s;o.innerHTML=sStatus};
	}else{o.innerHTML=s};
}

function writeMD(s,o){
//	The purpose of this function is to write out the HTML to the Measure floating layer window.  The HTML is prepared in another
//	function, this function just writes out the HTML to the floating layer.
//
	if (o==undef) {return;}
	if(sMD!=s){sMD=s; o.innerHTML=sMD};
}

function SetCurrTool(i,t){
//	The purpose of this function is to properly set the currently selected tool.  
//

	if((objMapFunction=findObj('MapFunction'))!=null){
		//objMapFunction.value=i;
		
		//Map function 55 is used to just refresh the layers on the map
		if (i!=55) {objMapFunction.value=i;} else {objLayerChange=findObj('LayerChange'); objLayerChange.value='Y'; if (resizing) {return;} }
		switch(t){
			case 1:	//just refresh the map.
				RefreshMap();break;
			case 2:	
				//Need to take some action here.  For buffering (23,24,25), we need to make sure the BuffType map variable is set to
				//the type of buffer (line, or polygon).
				if(i==23) {objBuffType=findObj('BuffType'); if (objBuffType.value=='line') {i=24;}; if (objBuffType.value=='polygon') {i=25;} }
				
				//If we're panning, make sure the mouse events are set to the appropriate drag functions
				if(crntTool==11){Drag.end(); objMap.onmousedown=mapMouseDown;objMap.ondblclick=mapMouseDblClick;document.onmouseup=mapMouseUp;document.onmousemove=mapMouseMove;} // objMap.onmousedown=mapMouseDown;document.onmouseup=mapMouseUp;document.onmousemove=mapMouseMove};

				//if (crntTool==14){crntTool=10;} else {crntTool=i;}
				crntTool=i;
				crntToolType=t;
				
				//Now let's restore the mouse events to the way they should be - we're done initializing for the new tool type
				var objCurrTool=findObj('CurrTool');objCurrTool.value=i;
				resumemouseclicks(); 
				
				//If we're a vertical or horizontal Toolbar, call the appropriate function to set the mouse cursor to
				//reflect the current tool selected
				if (VertTB=='1') {setMapCursorV();} else{setMapCursorH();}
				break;
		}
	}
	if(parentValid()){winParent.SetCurrTool(i,t);if(t==1){winParent.focus()}};
}

//Regular Horizontal Toolbar
function setMapCursorH(){
//	The purpose of this function is to set the map cursor and 'current tool' to the appropriate values based upon the action the
//	user is selecting to perform.  This function works for the horizontal Toolbar scheme.
//
	var strTool="None Selected"; var ovrname=''; var ovrimg='';
	map=findObj('Map',document)

	jsClearDrawings=1;
	switch(crntTool){
		case 2:  if (map!=null){map.style.cursor="crosshair"};jsClearDrawings=0;strTool="Zoom In";break;
		case 5:  if (map!=null){map.style.cursor="crosshair"};jsClearDrawings=0;strTool="Zoom Out";break;
		case 10: if (map!=null){map.style.cursor="default"};strTool="Measure";break;
		case 11: if (map!=null){map.style.cursor="move"};jsClearDrawings=0;strTool="Pan";break;
		case 12: if (map!=null){map.style.cursor="default"};strTool="Parcel Notes";break;
		case 14: if (map!=null){map.style.cursor="default"};strTool="Measure";break;
		case 19: if (map!=null){map.style.cursor="help"};if (top.idAllLayerWindowtitle=="") {top.idAllLayerWindowtitle="Identify Features";}strTool=top.idAllLayerWindowtitle;break;
		case 20: if (map!=null){map.style.cursor="help"};strTool=jsParcelDisplayNameSingular + " Identify";break;
		case 21: if (map!=null){map.style.cursor="help"};if (top.idAllLayerWindowtitle=="") {top.idAllLayerWindowtitle="Identify Features";}strTool=top.idAllLayerWindowtitle;break;
		case 22: if (map!=null){map.style.cursor="help"};strTool=jsParcelDisplayNameSingular + " Details";break;
		case 23: if (map!=null){map.style.cursor="help"}; if (top.bufferextract==1){strTool="Buffer Selection";}; if (top.bufferextract==2){strTool="Extract Selection";}; if (top.bufferextract==3){strTool="Parcel Notes";}; if (top.bufferextract==4){strTool="Demographic Analysis";}; ovrname='tb_Buffer';break;
		case 24: if (map!=null){map.style.cursor="help"}; if (top.bufferextract==1){strTool="Buffer Selection";}; if (top.bufferextract==2){strTool="Extract Selection";}; if (top.bufferextract==3){strTool="Parcel Notes";}; if (top.bufferextract==4){strTool="Demographic Analysis";}; ovrname='tb_Buffer';break;
		case 25: if (map!=null){map.style.cursor="help"}; if (top.bufferextract==1){strTool="Buffer Selection";}; if (top.bufferextract==2){strTool="Extract Selection";}; if (top.bufferextract==3){strTool="Parcel Notes";}; if (top.bufferextract==4){strTool="Demographic Analysis";}; ovrname='tb_Buffer';break;
		case 26: if (map!=null){map.style.cursor="help"}; if (top.bufferextract==1){strTool="Buffer Selection";}; if (top.bufferextract==2){strTool="Extract Selection";}; if (top.bufferextract==3){strTool="Parcel Notes";}; if (top.bufferextract==4){strTool="Demographic Analysis";}; ovrname='tb_Buffer';break;
		case 27: if (map!=null){map.style.cursor="help"};strTool="Parcel Project History";break;
		case 28: if (map!=null){map.style.cursor="help"};strTool="Service Request X,Y";break;
		case 29: if (map!=null){map.style.cursor="help"};strTool="Permits By Parcel";break;
		case 30: if (map!=null){map.style.cursor="default"};strTool="Drawing - Point";break;
		case 31: if (map!=null){map.style.cursor="default"};strTool="Drawing - Line";break;
		case 32: if (map!=null){map.style.cursor="default"};strTool="Drawing - Polygon";break;
		case 33: if (map!=null){map.style.cursor="default"};strTool="Drawing - Circle";break;
		case 34: if (map!=null){map.style.cursor="crosshair"};strTool="Drawing - Text";break;
		case 40: if (map!=null){map.style.cursor="hand"};strTool="Add a Street";break;
		case 41: if (map!=null){map.style.cursor="hand"};strTool="Add a Street";break;
		case 42: if (map!=null){map.style.cursor="help"};strTool="Project Identify";break;
		case 45: if (map!=null){map.style.cursor="hand"};strTool="Remove a Street";break;
		case 80: if (map!=null){map.style.cursor="hand"};strTool="Range Edit Web";break;
		default: if (map!=null){map.style.cursor="default"};break;
	};

	if(strTool!=''){
		UpdateSelTool(strTool);
	}
}

//Vertical Tool Bar
function setMapCursorV(){
//	The purpose of this function is to set the map cursor and 'current tool' to the appropriate values based upon the action the
//	user is selecting to perform.  This function works for the vertical Toolbar scheme.
//
	var strTool="None Selected"; var ovrname=''; var ovrimg='',iDir;
	map=findObj('Map',document)

	if (econdev==1) {
		iDir= 'images/VertTBImages/' + jsColourScheme;
	} else {
		iDir= 'images/' + jsColourScheme;
	}

	jsClearDrawings=1;

	switch(crntTool){
		case 2:  if (map!=null){map.style.cursor="crosshair"};jsClearDrawings=0;strTool="Zoom In";ovrname='tb_zoomin';ovrimg=iDir+'t_zoomin_act.gif';break;
		case 5:  if (map!=null){map.style.cursor="crosshair"};jsClearDrawings=0;strTool="Zoom Out";ovrname='tb_zoomout';ovrimg=iDir+'t_zoomout_act.gif';break;
		case 10: if (map!=null){map.style.cursor="default"};strTool="Measure";ovrname='tb_MeasureDistance';ovrimg=iDir+'t_MeasureDistance_act.gif';break;
		case 11: if (map!=null){map.style.cursor="move"};jsClearDrawings=0;strTool="Pan";ovrname='tb_pan';ovrimg=iDir+'t_pan_act.gif';break;
		case 12: if (map!=null){map.style.cursor="default"};strTool="Parcel Notes";break;
		case 14: if (map!=null){map.style.cursor="default"};strTool="Measure";ovrname='tb_MeasureDistance';ovrimg=iDir+'t_MeasureDistance_act.gif';break;
		case 19: if (map!=null){map.style.cursor="help"};strTool="Identify Features";ovrname='tb_IDAll';ovrimg=iDir+'t_IDAll_act.gif';break;
		case 20: if (map!=null){map.style.cursor="help"};strTool=jsParcelDisplayNameSingular + " Identify";ovrname='tb_parcelidentify';ovrimg=iDir+'t_IDParcel_act.gif';break;
		case 21: if (map!=null){map.style.cursor="help"};strTool="Identify Features";ovrname='tb_IDAll';ovrimg=iDir+'t_IDAll_act.gif';break;
		case 22: if (map!=null){map.style.cursor="help"};strTool=jsParcelDisplayNameSingular + " Details";ovrname='tb_parceldetails';ovrimg=iDir+'t_IDParcelDetails_act.gif';break;
		case 23: if (map!=null){map.style.cursor="help"};switch (top.bufferextract) {case 1:strTool="Buffer Selection";break; case 2:strTool="Extract Selection";break; case 3: strTool="Parcel Notes";break; case 4: strTool="Demographic Analysis";break;}; ovrname='tb_Buffer';ovrimg=iDir+'t_Buffer_act.gif';break;
		case 24: if (map!=null){map.style.cursor="help"};switch (top.bufferextract) {case 1:strTool="Buffer Selection";break; case 2:strTool="Extract Selection";break; case 3: strTool="Parcel Notes";break; case 4: strTool="Demographic Analysis";break;}; ovrname='tb_Buffer';ovrimg=iDir+'t_Buffer_act.gif';break;
		case 25: if (map!=null){map.style.cursor="help"};switch (top.bufferextract) {case 1:strTool="Buffer Selection";break; case 2:strTool="Extract Selection";break; case 3: strTool="Parcel Notes";break; case 4: strTool="Demographic Analysis";break;}; ovrname='tb_Buffer';ovrimg=iDir+'t_Buffer_act.gif';break;
		case 26: if (map!=null){map.style.cursor="help"};switch (top.bufferextract) {case 1:strTool="Buffer Selection";break; case 2:strTool="Extract Selection";break; case 3: strTool="Parcel Notes";break; case 4: strTool="Demographic Analysis";break;}; ovrname='tb_Buffer';ovrimg=iDir+'t_Buffer_act.gif';break;
		case 27: if (map!=null){map.style.cursor="help"};strTool="Parcel Project History";break;
		case 28: if (map!=null){map.style.cursor="help"};strTool="Service Request X,Y";break;
		case 29: if (map!=null){map.style.cursor="help"};strTool="Permits By Parcel";break;
		case 30: if (map!=null){map.style.cursor="default"};strTool="Drawing - Point";break;
		case 31: if (map!=null){map.style.cursor="default"};strTool="Drawing - Line";break;
		case 32: if (map!=null){map.style.cursor="default"};strTool="Drawing - Polygon";break;
		case 33: if (map!=null){map.style.cursor="default"};strTool="Drawing - Circle";break;
		case 34: if (map!=null){map.style.cursor="crosshair"};strTool="Drawing - Text";break;
		case 40: if (map!=null){map.style.cursor="hand"};strTool="Add a Street";break;
		case 41: if (map!=null){map.style.cursor="hand"};strTool="Add a Street";break;
		case 42: if (map!=null){map.style.cursor="help"};strTool="Project Identify";break;
		case 45: if (map!=null){map.style.cursor="hand"};strTool="Remove a Street";break;
		case 80: if (map!=null){map.style.cursor="hand"};strTool="Range Edit Web";break;
		default: if (map!=null){map.style.cursor="default"};break;
	};

	//Initialize the Toolbar and update the 'Tool: xxxxx' message in upper right corner of application.
	clearToolbarV();

	//We also need to make sure to make the appropriate Toolbar image set to the "ON" image (if applicable)
	if (ovrimg!=''&&ovrname!='') {
		di20(ovrname,ovrimg);
	}
	if(strTool!=''){
		UpdateSelTool(strTool);
	}
}

function clearToolbarV() {
//	The purpose of this function is to initialize the vertical Toolbar (top right of application).  Essentially we just need to make
//	sure that all images are in the 'off' position.
//

	var iDir;
	if (econdev==1) {
		iDir= 'images/VertTBImages/' + jsColourScheme;
	} else {
		iDir= 'images/' + jsColourScheme;
	}
	
	di20("tb_zoomin",iDir + "t_zoomin_off.gif");
	di20("tb_zoomout",iDir + "t_zoomout_off.gif");
	di20("tb_pan",iDir + "t_pan_off.gif");
	di20("tb_parcelidentify",iDir + "t_IDParcel_off.gif");
	di20("tb_parceldetails",iDir + "t_IDParcelDetails_off.gif");
	di20("tb_layers",iDir + "t_layers_off.gif");
	di20("tb_print",iDir + "t_print_off.gif");

	di20("tb_MeasureDistance",iDir + "t_MeasureDistance_off.gif");
	di20("tb_IDAll",iDir + "t_IDAll_off.gif");
	di20("tb_Buffer",iDir + "t_Buffer_off.gif");
}

function clearSSUrl(h) {
//	The purpose of this function is to clear out the right docked window.  In essence, we are clearing out any content in the right docked window.
//

	//if h is valid, we want to hide the window, too!
	if (h){ hideKLayer(lyrSS); }

	//Change the URL location of the window to a blank page (ss_wait.aspx)
	top.fwinURL[3]='SS/ss_wait.aspx';
	var objTMP=findObj("iFrameSSLayer",document);
	ChangeiFrameURL(objTMP,"","yes",2,1);
}

function pageLoaded(){
//	The purpose of this function is to execute the necessary code to complete initialization when the main processing page has loaded.
//
	
	//Get our exact x,y coordinates for the position of the mouse.
	mapMouseMove;

	if (pLoaded==true) {return;}

	//We MUST make sure that all frames are loaded before we consider the page 100% loaded.  If not, let's call ourselves again in 30 ms.
	//Maybe by then everything will be 100% loaded.
	if (top.ProcessDone==false||top.pvGeoDone==false||top.FrameLoaded==false) {top.loadTimeOut=window.setTimeout("top.MapFrame.pageLoaded();",30); return false;}

	if (jsClearDrawings) {
//	alert ("Clearing Drawings");
		clearVML();
		clearMeasureVar();
		initAllElements();
	}

	top.TopMapFrame=top.MapFrame;
	
	pLoaded=true;
	clearTimeout(top.loadTimeOut);

	SSUrl=findObj("SSUrl"); BufUrl=findObj("BufUrl"); 

	//If there is anything existing in our form variable for buffering, let's make sure the wide buffer content window displays
	//the buffer results (from the user's prior request.)
	if(BufUrl.value!=""&&top.MapFrame.url!=BufUrl.value){

		top.MapFrame.url=BufUrl.value;

		//Let's not reload a page that is already loaded.
		if (BufUrl.value.indexOf("http")==-1) {top.fwinURL[1]="SS/" + BufUrl.value; } 
			else {top.fwinURL[1]=BufUrl.value;} 
		var objTMP=findObj("iFrameSSLayer",document);
		ChangeiFrameURL(objTMP,"","yes",3);
		hideKLayer(lyrSS);
	}

	//If there is anything existing in our form variable for SS (right docked layer), let's make sure the right docked layer is visible
	//and content is displayed appropriately in it.
	if(SSUrl.value!=""&&url!=SSUrl.value){
		if (simpleGUI==1) {
			//Change the document location of the right docked layer to the value in the map form variable SSUrl
			GoSimpleGUIiFrameRight(SSUrl.value);
			SSUrl.value="";
		}else{
			//Change the document location of the iframe in the right docked layer to the value in the map form variable SSUrl
			//Probably the same as above...
			top.fwinURL[3]= SSUrl.value;
			var objTMP=findObj("iFrameSSLayer",document);
			ChangeiFrameURL(objTMP,"","yes",2);
			
			url="";
			SSUrl.value="";
		}
	}
	
	//Reposition elements on our user's browser screen
	ret=window.setInterval('repositionElements()', 300)

	//Make sure the current tool is selected properly
	SetCurrTool(crntTool,crntToolType);

	//If we're panning, then make sure we initialize our dragging events so the user can drag the map
	if(crntTool==11){ Drag.init(objMap,null);objMap.onDragStart=dragStartMap;objMap.onDragEnd=dragEndMap; }
	
	mouseX=0; mouseY=0;
	
	//If we have a bottom docked layer, let's make sure the Economic Development IFrame (right layer) is sized appropriately
	if (simpleGUI==1) {
		var objED=findObj('iEDFrameContent', top.MapFrame.document); 
		var objWH=findObj('WindowHeight');
		objED.style.height = 100-((TitleBarHeight)/objWH.value)*100 + "%"; //IE ONLY
	}

	//After 200ms, let's unlock the mouse and get rid of the loading layer.
	setTimeout("resumemouseclicks(); hideLoadingLyr();",200);
}

function RefreshLayersiFrame() {
//	The purpose of this function is to refresh the layer management console.
//
	top.fwinURL[5]='includes/pv_layers.aspx'
	var objTMP=findObj("iFrameLayersLayer",document);
	ChangeiFrameURL(objTMP,"Layer Management","yes",1,1);
}

function ShowUserComments() {
//	The purpose of this function is to create a pop-up window with the user comments page.
//
	newwindow('SS/User_Comments.aspx','height=500,width=550,menubar=no,resizable=yes,tollbar=no,scrollbars=yes','UserComments')
}

function clearFWinary() {
//	The purpose of this function is to clear out the floating window location array.
//
	top.MapFrame.url=''; top.fwinURL[0]=''; top.fwinURL[1]=''; top.fwinURL[2]=''; top.fwinURL[3]=''; top.fwinURL[4]=''; top.fwinURL[5]=''; top.fwinURL[6]='';
}

function BuffStuff(l) {
//	The purpose of this function is to execute initialization code to prepare the application to facilitate a buffer action.
//

	//Clear out the right docked layer document location.
	var frmSSUrl = findObj("SSUrl")
	frmSSUrl.value="";

	//If we don't already have a highlighted feature, let's initialize & start from scratch
	clearVML()
	clearMeasureVar();
	if (top.bufX1!=0 &&	top.bufY1!=0 &&	top.bufLyr!=0) {
		setBuffType("rectangle",23);		//By default, buffer by rubber band rectangle selection

		buffering=false; 

		//Set the URL of the wide buffer window to the first buffer page (step 1)
		var url;
		url="SS/buffer.aspx?minX=" + (top.bufX1) + "&minY=" + (top.bufY1) + "&maxX=" + (top.bufX2) + "&maxY=" + (top.bufY2) + "&LtB=" + top.bufLyr;

		if (simpleGUI==1) {
			top.MapFrame.GoSimpleGUIiFrameRight(url);
		} else {
			top.fwinURL[3]=url;
			var objTMP=findObj("iFrameSSLayer",document);
			ChangeiFrameURL(objTMP,"Buffer","yes",2);
		}

		var objLtB2=findObj("LayerToBuffer"); 
		objLtB2.value=top.bufLyr;

		BufUrl.value="";
	} else {
		//Start from scratch!  Let's clear out any buffer results or window contents & initialize from start.
		objLtB=findObj("LayerToBuffer"); 
		objLtB.value=l;

		if (simpleGUI==1) {
			top.MapFrame.GoSimpleGUIiFrameRight('SS/buffer_step1.aspx');
		} else {
			top.fwinURL[3]='SS/buffer_step1.aspx'; 
			var objTMP=findObj("iFrameSSLayer",document);
			ChangeiFrameURL(objTMP,"","yes",2);
		}

		top.bufferextract=1;	//note that we're doing a buffer - not an extract
		SetCurrTool(23,2);
		SSRefreshMap('bufferclear','');
	}
}

function setBuffType(bt,mf,lp) { 
//	The purpose of this function is to set the buffer action (type) in javascript.  This can be Rectangle, Line, or Polygon.
//	in doing this, javascript throughout the app can know what 'mode' we're buffering in.  This is especially important when
//	handling click events (mouse up, in particular) so we know if our buffering is done (rectangle), or if we need to accept
//	more points (line, or polygon selection).
//
	top.MapFrame.x1=0;
	top.MapFrame.y1=0; 
	var objBuffType=findObj('BuffType'); 
	var objMF=findObj('MapFunction'); 
	objMF.value=mf; 
	crntTool=mf; 
	objBuffType.value=bt;
	if (lp!=undef) {
		var objLP=findObj('LinePolygon');
		if (objLP!=null) { objLP.value=lp;}
	}
} 

function ChangeiFrameURL(obj,title,scrolling,btn,donotshowit) {
//	The purpose of this function is to alter an iFrame's URL location.  This is used primarily with the floating windows.
//	We need to have an object pointer to the iFrame, the title text for the floating window, whether or not the control
//	buttons appear atop the floating window (min, restore, close).
//
	if (obj!=null) {
		obj.src='includes/fwindow.aspx?l=' + obj.parentElement.id + '&btn=' + btn + '&title=' + title + '&s=' + scrolling;

		//Sometimes, we just want to change the URL but not display the window...
		if (donotshowit) {return;}
		
		//Here we iterate through all our floating windows & make sure they're visible if we want them to be.
		for(i=0; i<arrLyrsObjs.length;i++){
			if(arrLyrsObjs[i].id.toLowerCase()==obj.parentElement.id.toLowerCase()){
				l=arrLyrsObjs[i]; showKLayer(l); return;
			}
		}
	}
}

function StartAdmin() {
//	The purpose of this function is to create a new pop-up window with the project coord admin.
//
	newwindow('Admin/admin_intro.aspx','height=500,width=550,menubar=no,resizable=yes,tollbar=no,scrollbars=yes','Admin')
}

function newwindow(newpage,param,winname) {
//	The purpose of this function is to provide a common interface to open up new pop-up windows.
//
	var detailwindow=window.open(newpage, winname,param);
	detailwindow.focus();
}

function newPwindow(newpage,param,winname) {
//	The purpose of this function is to open up a new print window (when printing a map).  
//
	var detailwindow=window.open(newpage + "&sk=" + top.objScale.scale.value, winname,param);
	detailwindow.focus();
}

function findObj(s,n){
//	The purpose of this function is to find a desired object.  This function is used A LOT.  Basically, instead of having to know
//	the document object model in JS, we juse this function to return a pointer to any object we may be looking for.  For example,
//	a form variable, a pointer to an iframe, etc.  Once we have the pointer to the object, we can adjust the object's properties.
	var obj=MM_findObj(s,n);
	return obj;
}

function parentValid(){
//	The purpose of this function is to determine if the parent window is valid.  This basically check to see if we have a valid browser
//	window open still.
  if(winParent==null){winParent=window.parent};
  if((winParent==null)||(winParent.closed)||(winParent==window))return false;
  if(winParent.chk!='chk'){return false}else{return true};
}

function formatNumber(v,decplaces){
//	The purpose of this function is to format an input number to x decimal places
	var str=""+Math.round(eval(v)*Math.pow(10,decplaces))
	while (str.length <= decplaces) {
		str="0"+str;
	}
	var decpoint = str.length - decplaces
	return str.substring(0,decpoint) + "." + str.substring(decpoint,str.length)
}

//	The purpose of this function is to do nothing
function Nothing() {}

function Pan(direc) {
//	The purpose of this function is to make the pan arrows come alive.  Depending on the pan arrow the user clicks on,
//	the direc variable will be sent to the main processor page to pan the map in the correct direction.

	var frmMF = findObj("MapFunction")
	var frmPD = findObj("PanDirection")
	
	//We need to show the loading layer graphic, set map function to 15, and refresh the processor page (refreshmap)	
	if (frmMF!=null && frmPD!=null && top.MapFrame.crntTool!=10) {
		positionLoadingLyr();
		frmMF.value=15;
		frmPD.value=direc;
		RefreshMap();
	}
}

function debug(msg) {
	if ((_console==null)||(_console.closed)) {
		_console=window.open("","console","width=600,height=300,resizable");
		_console.document.open("text/plain");
	}
	//_console.focus();
	_console.document.writeln(msg + "\n");
}
function mnuGoSearchAll(l) {
	//top.MapFrame.positionLoadingLyr(); 

	url="SS/search_all.aspx?p=2&m=&lyr=" + l;
	if (simpleGUI==1) {
		top.MapFrame.GoSimpleGUIiFrameRight(url);
	} else {
		top.fwinURL[3]=url;
		var objTMP=findObj("iFrameSSLayer",document);
		ChangeiFrameURL(objTMP,"Search All","yes",2);
	}
}
function mnuGoIDAll(l,lfull) {
	//top.MapFrame.positionLoadingLyr(); 
	hideKLayer(lyrSS);
	top.idAllLayers=l;
	SetCurrTool(19,2);
	top.idAllLayerWindowtitle="Identify " + lfull;
	top.currentToolText=top.idAllLayerWindowtitle;
	UpdateSelTool(top.idAllLayerWindowtitle);
}
function mnuGoBuffer() {
	top.MapFrame.positionLoadingLyr(); 
	BuffStuff('');
}
function mnuGoMeasureDistance() {
	SetCurrTool(10,2);
	
	if (clientname=="SacCounty" || clientname=="SacCountyEOC") {
		showKLayer(lyrMeasureDistance);
	} else {
		if (simpleGUI==1) {
			top.MapFrame.GoSimpleGUIiFrameRight('includes/MeasureDistance.aspx');
		} else {
			top.fwinURL[3]='includes/MeasureDistance.aspx' 
			var objTMP=findObj("iFrameSSLayer",document);
			ChangeiFrameURL(objTMP,"Measure","yes",2);
		}
	}
}

function mnuGoUpdateAddress() {
	SetCurrTool(80,2);

	url="/RGisPortal/RangeEditWeb.aspx?uids=&sid=" + jsStreetCLID + "2";
	top.UpdateAddressWIN=window.open(url,'UpdateAddress','height=425,width=545,menubar=no,resizable=yes,tollbar=no,scrollbars=yes');
}
function mnuGoSpatialEdit() {
	ShowDrawing(1)
}

function mnuGoParcelNotes(n,a) {
	var url;
	
	if (a=='a') { //Add
		url='../ParcelNotes/AddNote.aspx?c=' + jsBaseColour + '&apns=' + n;
	}
	if (a=='e') { //edit
		url='../ParcelNotes/EditNote.aspx?c=' + jsBaseColour + '&apns=' + n;
	}
	if (a==undef) { //edit
		SetCurrTool(12,2);
		url='../ParcelNotes/default.aspx?c=' + jsBaseColour;
	}
	
	if (simpleGUI==1) {
		top.MapFrame.GoSimpleGUIiFrameRight(url);
	} else {
		top.fwinURL[3]=url;
		var objTMP=findObj("iFrameSSLayer",document);
		ChangeiFrameURL(objTMP,"Parcel Notes","yes",2);
	}
}
function setVal(s,v){o=findObj(s);if(o!=null)o.value=v}
function getVal(s){o=findObj(s);if(o!=null){return o.value}else{return ''}}
function setChk(s,v){o=findObj(s);if(o!=null)o.checked=v}
function getChk(s,v){o=findObj(s);if(o!=null){return o.checked}else{return false}}
function exists(s){o=findObj(s);if(o!=null){return true}else{return false}}

/* These are dreamweaver functions to preload images and find objects */
function MM_preloadImages() { 
 var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
   var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
   if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}
function MM_findObj(n, d) { 
  //if(!d) d=document;
  var p,i,x;  if(!d) d=top.Process.document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; if (d.forms!=undef) {for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];}
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}

function di20(id, newSrc,d) {
//	The purpose of this function is to switch out one image for another.  the input is the id (id) of the image to be 'altered',
//  newSrc is the name of the new image, and d is a pointer to the form's document.  This function uses FWFindImage to get a
//	pointer to the image that needs to be altered.

	if (d) {
		var theImage = top.MapFrame.findObj(id,d);
		if (theImage) { theImage.src = newSrc; }
	}else {
		d=document;
		var theImage = FWFindImage(d, id, 0);
		if (theImage) { theImage.src = newSrc; }
	}
}


function FWFindImage(doc, name, j) {
//	The purpose of this function is to return a pointer to the image in question by parsing the document's layers object

    var theImage = false;
    if (doc.images) { theImage = doc.images[name]; }
    if (theImage) { return theImage; }
    if (doc.layers) {
        for (j = 0; j < doc.layers.length; j++) {
            theImage = FWFindImage(doc.layers[j].document, name, 0);
            if (theImage) { return (theImage); }
        }
    }
    return (false);
}


function LinkSelect() {
//	The purpose of this function is to facilitate a bit of logic for the custom links drop down box.  If the user were to select,
//	say, Admin Log-in from the drop down box, we need to know to open up the admin log-in screen in a pop-up.  There are three
//	different custom 'cases': project coordination log in, log out, and Econ Dev's Brokerage report.  For all other cases, we
//	process things generically.  The custom links are configured so that you would either open it up in a brand new browser
//	window (1), full screen in the current window (2), or in a floating window (3).
//
//
	var opt=document.LinkDD.UserLinks.options[document.LinkDD.UserLinks.selectedIndex].value;
	document.LinkDD.UserLinks.selectedIndex=0;
	if (opt=="ProjCoordLogIn") {
		newwindow('Admin/admin_login.aspx?a=li','height=220,width=350,menubar=no,resizable=yes,tollbar=no,scrollbars=yes','AdminLILO')
		return;
	} else if (opt=="ProjCoordLogOut") {
		newwindow('Admin/admin_login.aspx?a=lo','height=220,width=350,menubar=no,resizable=yes,tollbar=no,scrollbars=yes','AdminLILO')
		return;
	} else if (opt=="BrokerageReport") {
		newwindow('EconDev/ed_BrokerageReport.aspx','height=420,width=550,menubar=no,resizable=yes,tollbar=no,scrollbars=yes','edBrokerageRpt')
		return;
	} else {

		switch (parseInt(opt.substr(0,1))) {
		case 1: //1=New Window
				newwindow(opt.substr(2),'height=500,width=550,menubar=no,resizable=yes,tollbar=no,scrollbars=yes',parseInt(Math.random*10000))
				break;
		case 2: //2=Full screen
				top.document.location = opt.substr(2);
				break;
		case 3: //3=Floating Window
				var objiFrameProjectDisplay = top.MapFrame.findObj("iFrameprojectdispLayer",top.MapFrame.document);
				if (objiFrameProjectDisplay!=null) {
					objiFrameProjectDisplay.src='includes/fwindow.aspx?l=projectdisp&title=Information&src=' + opt.substr(2) + '&s=yes';
					swapLayerVis(lyrprojectdisp,'windowprojectdisp');
				}
				break;
		}
		
	}
}

