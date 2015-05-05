var PointSave_vml;
var LineSave_vml;
var PolySave_vml;

// Acetate vars
var MaxAText = 1;  // Max acetate text
var AText;  // Active drag text box
var ATextCount = 0;  // Acetate text count
var ATextX = new Array();
var ATextY = new Array();
var ATextXPrev = 0;
var ATextYPrev = 0;

var APointCount = 0;   // Acetate Point count
var APointX = new Array();
var APointY = new Array();

var ALineCount = 0;   // Acetate Line count
var ALineXYCount = 0; // Total x,y count
var ALineList = "";

var APolyCount = 0;   // Acetate poly count
var APolyXYCount = 0; // Total x,y count
var APolyList = "";

var MaxACircle = 5;   // Max acetate circles
var ACircleCount = 0;   // Acetate circle count
var ACircleX = new Array();
var ACircleY = new Array();
var ACircleRad = new Array();

var MaxXY = 40;  // Max acetate and select coords
var Xarray = new Array();
var Yarray = new Array();
var XyCount = 0;
var XyVML = "";
var XfirstPix;
var YfirstPix;
var XyFirstPntVML = "";

var CircleRadius = 1000;

// Number of decimals to show in xy coordinate readout in status bar
var NumXYDecimals = 2;

//========================
// Clear highlighting VML.
//========================
function clearVML() {
   top.MapFrame.point_vml.path = "m 0 0 l 0,0 0,0 0,0 0,0 e";
   top.MapFrame.line_vml.path = "m 0 0 l 0,0 0,0 0,0 0,0 e";
   top.MapFrame.poly_vml.path = "m 0 0 l 0,0 0,0 0,0 0,0 e";
}
//=========================
// Clear measure variables.
//=========================
function clearMeasureVar(i) {
	var undef;
	
	window.status=i;
	stopdrawing=false;
	XyCount = 0;
	XyVML = "";
	XyFirstPntVML = "";
	xyVML_vml.path = "m 0 0 l 0,0 0,0 0,0 0,0 e";
	xyClose_vml.path = "m 0 0 l 0,0 0,0 0,0 0,0 e";
	if (i==10||i==undef) {var objPts=findObj("dwg_ln_Points"); objPts.value ="";}
}

//====================
// Mouseclick on map
//====================
function VML_Map_click(mouseX,mouseY,i) {

	//Type
	//10=Measure
	//24=Buffer by line/polygon
	//30=Drawing:Point
	//31=Drawing:Line
	//32=Drawing:Polygon
	//33=Drawing:Circle
	//34=Drawing:Text

	switch (i) {
		case 10:		
		case 24:
		case 31:
		case 32: //line stuff
			if (i==10 && (MDStyle!='Adv'&&MDStyle!=''&&XyCount==2)){return;}

			XyCount += 1;
			Xarray[XyCount] = Math.round(mouseX);
			Yarray[XyCount] = Math.round(mouseY);


			// Form VML paths
			if (XyCount == 1) {
				XfirstPix = mouseX;
				YfirstPix = mouseY;
				XyFirstPntVML = "m " + mouseX + "," + mouseY + " l ";
				XyVML = XyFirstPntVML;
			} else {
				XyVML += mouseX + "," + mouseY + " ";
			}

			if (XyCount > 0) {
				xyVML_vml.path = XyVML + mouseX + "," + mouseY + " e";
				if (XyCount > 2 && i==32) {
					xyClose_vml.path = XyFirstPntVML + mouseX + "," + mouseY + " e";
				}
			}

			if (i==10) {
				var objCMinX=findObj('CMapMinX'),objCMinY=findObj('CMapMinY');
				var objPts=findObj("dwg_md_Points");
				objPts.value += (objCMinX.value) + "," + (objCMinY.value) + ',';
			}else if (i==10||i==31) {
				var objCMinX=findObj('CMapMinX'),objCMinY=findObj('CMapMinY');
				var objPts=findObj("dwg_ln_Points");
				objPts.value += (objCMinX.value) + "," + (objCMinY.value) + ',';
			}else if (i==24) {
				var objCMinX=findObj('CMapMinX'),objCMinY=findObj('CMapMinY');
				var objPts=findObj("dwg_bf_Points");
				objPts.value += (objCMinX.value) + "," + (objCMinY.value) + ',';
			} else {
				var objCMinX=findObj('CMapMinX'),objCMinY=findObj('CMapMinY');
				var objPts=findObj("dwg_py_Points");
				objPts.value += (objCMinX.value) + "," + (objCMinY.value) + ',';
			}
			break;

		case 33:	//circle
			if (ACircleCount>=MaxACircle) {
				alert ("Only " + MaxACircle + " circles can be created at once - please click on the refresh button to save the current circles.");
				return;
			}
			var circleRad = top.dwgFRM.radius;

			var wStr = parseFloat(circleRad.value) + "";
			if (isNaN(wStr)) {
				circleRad.value = CircleRadius;
			}
			var wRad = parseFloat(circleRad.value);
			if (wRad < 1) {
				wRad = CircleRadius;
			}
			var radInPix = Math.round(wRad / xRatio);
			if (radInPix < 1 || radInPix > 4096) {
				radInPix = 1;
			}
			ACircleCount += 1;
			ACircleX[ACircleCount] = Math.round(mouseX);
			ACircleY[ACircleCount] = Math.round(mouseY);
			ACircleRad[ACircleCount] = wRad;

			CircleRadius = wRad;

			if (ACircleCount == 1) {
				aCircle1_vml.style.width  = (radInPix * 2) + "px";
				aCircle1_vml.style.height = (radInPix * 2) + "px";
				aCircle1_vml.style.left = (mouseX - radInPix) + "px";
				aCircle1_vml.style.top = (mouseY - radInPix) + "px";
				aCircle1_vml.style.visibility = "visible";

			} else if (ACircleCount == 2) {
				aCircle2_vml.style.width  = (radInPix * 2) + "px";
				aCircle2_vml.style.height = (radInPix * 2) + "px";
				aCircle2_vml.style.left = (mouseX - radInPix) + "px";
				aCircle2_vml.style.top = (mouseY - radInPix) + "px";
				aCircle2_vml.style.visibility = "visible";

			} else if (ACircleCount == 3) {
				aCircle3_vml.style.width  = (radInPix * 2) + "px";
				aCircle3_vml.style.height = (radInPix * 2) + "px";
				aCircle3_vml.style.left = (mouseX - radInPix) + "px";
				aCircle3_vml.style.top = (mouseY - radInPix) + "px";
				aCircle3_vml.style.visibility = "visible";

			} else if (ACircleCount == 4) {
				aCircle4_vml.style.width  = (radInPix * 2) + "px";
				aCircle4_vml.style.height = (radInPix * 2) + "px";
				aCircle4_vml.style.left = (mouseX - radInPix) + "px";
				aCircle4_vml.style.top = (mouseY - radInPix) + "px";
				aCircle4_vml.style.visibility = "visible";

			} else {
				aCircle5_vml.style.width  = (radInPix * 2) + "px";
				aCircle5_vml.style.height = (radInPix * 2) + "px";
				aCircle5_vml.style.left = (mouseX - radInPix) + "px";
				aCircle5_vml.style.top = (mouseY - radInPix) + "px";
				aCircle5_vml.style.visibility = "visible";
			}

			var objCMinX=findObj('CMapMinX'),objCMinY=findObj('CMapMinY');
			var objPts=findObj("dwg_cr_Points");
			objPts.value += (objCMinX.value) + "," + (objCMinY.value) + ',' + (circleRad.value) + ',';

			break;
						
		case 30:	//point
			APointCount += 1;
			APointX[APointCount] = Math.round(mouseX);
			APointY[APointCount] = Math.round(mouseY);

			// Form VML path
			aPoint_vml.path += "m " + (mouseX - 3) + "," + mouseY + " l " + (mouseX + 3) + "," + mouseY + " e ";

			var objCMinX=findObj('CMapMinX'),objCMinY=findObj('CMapMinY');
			var objPts=findObj("dwg_pt_Points");
			objPts.value += (objCMinX.value) + "," + (objCMinY.value) + ',';

			break;

		case 34:
			if (ATextCount == MaxAText) {
				alert("Please refresh the drawing before adding more text elements.");
				return;
			}
			if (ATextCount < MaxAText) {
				ATextCount += 1;
				ATextX[ATextCount] = mouseX;
				ATextY[ATextCount] = mouseY;
				ATextXPrev = mouseX
				ATextYPrev = mouseY
				top.MapFrame.AText.select();

				element=top.MapFrame.AText
				var numChar = element.value.length;
				var pos = parseInt(element.style.left) + (numChar * 10)

				if (pos > top.MapFrame.getWindowWidth()) {
					top.MapFrame.AText.style.left=top.MapFrame.getWindowWidth()-60;
				}

				if (ATextCount < MaxAText) {
					addText();
				}
			}

			var objCMinX=findObj('CMapMinX'),objCMinY=findObj('CMapMinY');
			var objPts=findObj("dwg_tx_Points");
			objPts.value += (parseFloat(objCMinX.value) + parseFloat(8*xRatio)) + "," + (parseFloat(objCMinY.value) ) + ",";
		
			//top.MapFrame.SetCurrTool(31,2);
		}

		if (i==10) {
			XyCount += 1;
			Xarray[XyCount] = mouseX;
			Yarray[XyCount] = mouseY;

			// Form VML paths
			if (XyCount == 1) {
				XyFirstPntVML = "m " + mouseX + "," + mouseY + " l ";
				XyVML = XyFirstPntVML;
			} else {
				XyVML += mouseX + "," + mouseY + " ";
			}

			// Update measure form
			if (XyCount == 1) {
				clearMeasureForm();
			} else {
				updateMeasureForm();
			}
		}
}

//====================
// Mousemove around map
//====================
function VML_MD_MouseMove(mouseX,mouseY,i) {

	if (MDStyle!='Adv'&&MDStyle!=''&&XyCount==2){return;}

	if (i==34) {
        if (ATextCount == MaxAText) {
            return;
        }
        dist = twoPntDistance (mouseX, mouseY, ATextXPrev, ATextYPrev);
        if (dist > 6) {
            AText.style.visibility = "visible";
            AText.style.left = (mouseX + 8) + "px";
            AText.style.top  = (mouseY - 13) + "px";
        } else {
            if (ATextCount < MaxAText) {
                AText.style.visibility = "hidden";
            }
        }
		return; dist
	}
	
	// Draw VML rubber bands
	if (XyCount > 0) {
		xyVML_vml.path = XyVML + mouseX + "," + mouseY + " e";
		if ( XyCount > 2 && (i==10||i==32||(i>=23&&i<=25&&top.bufferextract==4))) { xyClose_vml.path = XyFirstPntVML + mouseX + "," + mouseY + " e";}

		//if (top.data_frame.measure_form || top.data_frame.insert_form) {
		if (i==10) {if (MDStyle=='Adv'||MDStyle==''){updateSegDist(mouseX,mouseY);} }
		//}
	}
}

//=============================
// Clear measure form and vars.
//=============================
function clearMeasureAll() {
   clearMeasureForm();
   clearMeasureVar();
}
//====================
// Clear measure form.
//====================
function clearMeasureForm() {
	var md1=findObj('mdTotal',top.MDDOC);
	md1.innerHTML = "0 " + top.jsMapUnits;
	
	if (MDStyle=='Adv' || MDStyle=='') {
		var md2=findObj('mdCurrent',top.MDDOC);
		var md3f=findObj('mdAreaF',top.MDDOC);
		var md3a=findObj('mdAreaA',top.MDDOC);
		var md3m=findObj('mdAreaM',top.MDDOC);
		var mdP=findObj('dwg_md_Points');
		md2.innerHTML = "0 " + top.jsMapUnits;
		md3f.innerHTML = "0 sq Feet";
		md3m.innerHTML = "0 sq Miles";
		md3a.innerHTML = "0 Acres";
		mdP.value="";
	}
}
//=========================
// Update segment distance.
//=========================
function updateSegDist(xMap,yMap) {
   var xyCount = XyCount;
   var xArray = Xarray;
   var yArray = Yarray;
   var lenFeet = 0;
   var lenMile = 0;
   var wStr;
   var u = Math.pow(10, NumXYDecimals);

   if (xyCount > 0) {
      lenFeet = twoPntDistance(xArray[xyCount]*xRatio, yArray[xyCount]*yRatio, xMap*xRatio, yMap*yRatio);
      
      lenFeet = parseInt(lenFeet * u + 0.5) / u;
      
      lenMile = lenFeet / 5280;
      lenMile = parseInt(lenMile * u + 0.5) / u;

      wStr = "";
      if (lenMile > 1) {
         wStr = lenMile + "  Miles";
      } else {
         wStr = lenFeet + "  Feet";
      }
      var mdcurr=findObj('mdCurrent',top.MDDOC);

      if (mdcurr!=null) {mdcurr.innerHTML = wStr;}
   }
}
//=====================
// Update measure form.
//=====================
function updateMeasureForm() {
   var xyCount = XyCount;
   var xArray = Xarray;
   var yArray = Yarray;
   
   var wStr;
   var u = Math.pow(10, NumXYDecimals);

   var lenFeet = 0;
   var lenMile = 0;

   var areaFeet = 0;
   var areaAcre = 0;
   var areaMile = 0;

   if (xyCount > 1) {
      //==============
      // Total length.
      //==============
      lenFeet = multiPntDistance(xyCount, xArray, yArray);
      lenFeet = parseInt(lenFeet * u + 0.5) / u;

      lenMile = lenFeet / 5280;
      lenMile = parseInt(lenMile * u + 0.5) / u;

      wStr = "";
      if (lenMile > 1) {
         wStr = lenMile + "  Miles";
      } else {
         wStr = lenFeet + "  Feet";
      }
      var md1=findObj('mdTotal',top.MDDOC);
      md1.innerHTML = wStr;
   }
   
	if (MDStyle!='Adv'&&MDStyle!=''){return;}

   //======
   // Area.
   //======
   if (xyCount > 2) {
      var md1=findObj('mdAreaF',top.MDDOC);
      var md2=findObj('mdAreaA',top.MDDOC);
      var md3=findObj('mdAreaM',top.MDDOC);

      areaFeet = computeArea(xyCount, xArray, yArray);
      areaFeet = Math.round(areaFeet);

      areaAcre = areaFeet / 43560.0;
      areaAcre = parseInt(areaAcre*u+0.5) / u;

      areaMile = areaFeet / 27878400.0;
      areaMile = parseInt(areaMile*u+0.5) / u;

      if (areaFeet > 9999999) {
//         areaFeet = "&nbsp"
      }      
      md1.innerHTML = areaFeet + ' sq Feet';

      if (areaAcre < 0.01 || areaAcre > 1000000) {
         areaAcre = "&nbsp"
      }
      md2.innerHTML = areaAcre + ' Acres';

      if (areaMile < 0.1) {
         areaMile = "&nbsp"
      }      
      md3.innerHTML = areaMile + ' sq Miles';
   }
}
//==============
// Compute area.
//==============
function computeArea(numPnt,x,y) {
   var area = 0;
   var i,j;
   var xjyi, xiyj;
   var xydiff;
   j = numPnt;

   for (i=1; i<=numPnt; i++) {
      xiyj = (x[i]*xRatio) * (y[j]*yRatio);
      xjyi = (x[j]*xRatio) * (y[i]*yRatio);
      xydiff = (xiyj - xjyi);
      area += xydiff;
      j = i;
   }
   area = Math.abs(area / 2);
   return area;  
}
//==========================
// Compute 2 point distance.
//==========================
function twoPntDistance(x1,y1,x2,y2) {
   var dist;
   var xD = Math.abs(x1 - x2);
   var yD = Math.abs(y1 - y2);

   dist = Math.sqrt(Math.pow(xD,2) + Math.pow(yD,2));
   return dist;  
}
//==============================
// Compute multi-point distance.
//==============================
function multiPntDistance(numPnt,x,y) {
   var dist = 0;
   var i;
   for (i=1; i<numPnt; i++) {
      dist += twoPntDistance(x[i]*xRatio, y[i]*yRatio, x[i+1]*xRatio, y[i+1]*yRatio);
   }
   return dist;  
}
//=====================
// aText keydown event.
//=====================
function aTextChange(element) {

   var objT = top.MapFrame.findObj(element.id);
   if (objT!=null) {objT.value=element.value}

   var numChar = element.value.length;
   var pos = parseInt(element.style.left) + (numChar * 10)

   if (pos < top.MapFrame.getWindowWidth()) {
      if (numChar > 0) {
         element.size = numChar;
      }
   }
}
//======================
// Text move over event.
//======================
function aTextMove() {
    if (ATextCount < MaxAText) {
        AText.style.visibility = "hidden";
    }
}
//=====================
// Add acetate text.
//=====================
function addText() {
   if (ATextCount == MaxAText) {
      alert("Please refresh the drawing before adding more text elements");
      return;
   }
   if (ATextCount == 0) {
      AText = top.MapFrame.aText1;

   } else if (ATextCount == 1) {
      AText = top.MapFrame.aText2;

   } else if (ATextCount == 2) {
      AText = top.MapFrame.aText3;

   } else if (ATextCount == 3) {
      AText = top.MapFrame.aText4;

   } else if (ATextCount == 4) {
      AText = top.MapFrame.aText5;
   }
   AText.value = "";
   AText.size = 4;
}
//==============
// Init acetate.
//==============
function initAllElements() {
   with (top.MapFrame) {
      // Text
      ATextCount = 0;
      aText1.style.visibility = "hidden";
      aText2.style.visibility = "hidden";
      aText3.style.visibility = "hidden";
      aText4.style.visibility = "hidden";
      aText5.style.visibility = "hidden";

      // Point      
      APointCount = 0;
      aPoint_vml.path = "m 0,0 l 0,0 e";

      // Line
      ALineCount = 0;
      ALineList = "";
      ALineXYCount = 0;
      aLine_vml.path = "m 0,0 l 0,0 e";
      
      // Polygon
      APolyCount = 0;
      APolyList = "";
      APolyXYCount = 0;
      aPoly_vml.path = "m 0,0 l 0,0 0,0 0,0 e";

      // Circle
      ACircleCount = 0;
      aCircle1_vml.style.visibility = "hidden";
      aCircle2_vml.style.visibility = "hidden";
      aCircle3_vml.style.visibility = "hidden";
      aCircle4_vml.style.visibility = "hidden";
      aCircle5_vml.style.visibility = "hidden";
   }
   
	var objPts=findObj("dwg_pt_Points"); objPts.value="";
	var objPts=findObj("dwg_bf_Points"); objPts.value="";
	var objPts=findObj("dwg_ln_Points"); objPts.value="";
	var objPts=findObj("dwg_py_Points"); objPts.value="";
	var objPts=findObj("dwg_cr_Points"); objPts.value="";
	var objPts=findObj("dwg_tx_Points"); objPts.value="";

	if (top.MapFrame.crntTool==34) {
		top.MapFrame.AText = top.MapFrame.aText1;
		top.MapFrame.AText.value = "";
		top.MapFrame.AText.size = 4;
		top.MapFrame.ATextXPrev = 0;
		top.MapFrame.ATextYPrev = 0;
	}
}