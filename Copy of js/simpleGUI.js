function GoSimpleGUIiFrameRight(s) {
//    The purpose of this function is to have a common point to change the content area of the right docked 
//    layer.  The name of this layer is iEDFrameContent.  Anyone who calls this function will have a page or 
//    a URL being sent as the parameter (s).  We use the findObj function to get a pointer to the iFrame.  
//    If the iFrame is found, we then set its source to the value of 's'.

	var objEDFrm=top.MapFrame.findObj('iEDFrameContent',top.MapFrame.document); 
	if (objEDFrm!=null) { objEDFrm.src=s; }
}

function resizeBottomNavFrame() {
//	The purpose of this function is to resize the bottom docked layer.  We use the findObj function to return
//	a pointer to the bottom docked layer.  Once this is obtained, we resize it according to the maxX and maxY
//	values of the map.  This fires off when the browser window is being resized.
	var objBNF=findObj('iFrameBottomNavFrame',top.MapFrame.document);
	objBNF.style.width=parseInt(((top.mapMaxX-top.mapMinX)/xRatio)) + "px";

}

function SelectPropertiesinExtent() {
//	The purpose of this function is to select the properties visible within the current extent.  This function
//	will set the main map function to 61 and refreshes the map.  By calling RefreshMap, you are asking the main
//	processing frame to run map function 61.
	var frmMF = findObj("MapFunction")

	frmMF.value=61;
	RefreshMap();
}