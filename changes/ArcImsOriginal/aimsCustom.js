// aimsCustom.js
/*
*  JavaScript template file for ArcIMS HTML Viewer
*		dependent on aimsXML.js, ArcIMSparam.js, aimsCommon.js, aimsMap.js,
*		aimsLayers.js, aimsDHTML.js
*		aimsClick.js, aimsNavigation.js,
*/

// global variables
	aimsCustomPresent=true;
	// change these to send XML response to custom function.
	// use numbers >= 1000 and match in useCustomFunction()
	// defaults are defined in aimsXML.js and use standard functions
	
	// xml response mode for selection
	selectXMLMode = 6;
	// xml response mode for identify
	identifyXMLMode = 7;
	// xml response mode for query
	queryXMLMode = 8;
	// xml response mode for find
	findXMLMode = 14;
	// xml response mode hyperlink
	hyperlinkXMLMode = 15;




// custom function for handling clicks 
// 		flow redirected here when
//		toolMode set to >=1000
function customMapTool(e) {
				if (toolMode == 1001) {
						// insert code here
						return false;
					
				}
				if (toolMode == 1002) {
						// insert code here

				}

}

// send  XML response to custom function
//		flow  redirected here when
//		XMLMode >=1000
function useCustomFunction(theReply) {
	if (XMLMode==1001) {
		// insert code here
	} else if (XMLMode==1002) {
		// insert code here
	} else {
		alert(msgList[55] + XMLMode + msgList[56]);
	}
	hideLayer("LoadData");
}

// add custom stuff to Map XML request. . . between selection and geocode
function addCustomToMap1(){
	var customString = "";
	/*
		customString += '<LAYER type="ACETATE" name="theMode">\n';
		customString += '<OBJECT units="PIXEL">\n<TEXT coord="5 ' + (iHeight-10) + '" label="This is a test">\n';
		customString += '<TEXTMARKERSYMBOL fontstyle="BOLD" fontsize="12" font="ARIAL" fontcolor="' + modeMapColor + '" ';
		customString += 'threed="TRUE" glowing="' + modeMapGlow + '" />\n</TEXT>\n</OBJECT>';
		customString += '\n</LAYER>\n';
	*/
	return customString;
}

// add custom stuff to Map XML request. . . between clickpoints and copyright
function addCustomToMap2(){
	var customString = "";
	
	return customString;
}

// add custom stuff to Map XML request. . . under modeOnMap
function addCustomToMap3(){
	var customString = "";
		/*
		customString += '<LAYER type="ACETATE" name="theMode">\n';
		customString += '<OBJECT units="PIXEL">\n<TEXT coord="5 ' + (iHeight-10) + '" label="This is a test">\n';
		customString += '<TEXTMARKERSYMBOL fontstyle="BOLD" fontsize="12" font="ARIAL" fontcolor="' + modeMapColor + '" ';
		customString += 'threed="TRUE" glowing="' + modeMapGlow + '" />\n</TEXT>\n</OBJECT>';
		customString += '\n</LAYER>\n';
		alert(customString);
		*/
	return customString;
}

// add custom stuff to Map XML request. . . on top of everything
function addCustomToMap4(){
	var customString = "";
	
	return customString;
}

// extract layers to download
function extractIt() {
	hideLayer("measureBox");
	alert(msgList[51]);
}


