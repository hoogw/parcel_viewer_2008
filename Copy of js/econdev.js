function GoPropSearch() {
//	The purpose of this function is to direct the right docked pane to the main EconDev property search page using the GoSimpleGUIiFrameRight function

	//Show loading layer
	top.MapFrame.positionLoadingLyr(); 
	GoSimpleGUIiFrameRight("EconDev/search.aspx?i=0&z=1");
}

function GoGeoAnalysis() {
//	The purpose of this function is to direct the right docked pane to the GeoAnalysis page using the GoSimpleGUIiFrameRight function

	//Show loading layer
	top.MapFrame.positionLoadingLyr(); 
	GoSimpleGUIiFrameRight("EconDev/GeoAnalysis.aspx");
}

function GoCandidateList(z) {
//	The purpose of this function is to direct the right docked pane to revert back to the candidate list.  The candidate list
//	SQL query is stored in a top level javascript variable, top.PropCandidatesSQL.  The window location of the right docked
//	layer is changed using the GoSimpleGUIiFrameRight function

	if (top.PropCandidatesSQL==''||top.PropCandidatesSQL=='0') {
		alert ("You must perform a Property Search first.");
		return;
	}
	
	top.MapFrame.positionLoadingLyr(); 
	GoSimpleGUIiFrameRight("EconDev/Search.aspx?i=1&Mode=1&z=" + z + "&q=" + top.PropCandidatesSQL);
}

function GoMainPage() {
//	The purpose of this function is to direct the right docked pane to the intro EconDev page using the GoSimpleGUIiFrameRight function

	//Show loading layer
	top.MapFrame.positionLoadingLyr(); 
	GoSimpleGUIiFrameRight("EconDev/Intro.aspx");
}

function GoDataManagement(p) {
//	The purpose of this function is to open up a brand new pop-up window & point it to the Data Management page (in the EconDev folder)

	top.MapFrame.newwindow(p+'EconDev/DataMgmt.aspx?a=li','height=220,width=400,menubar=no,resizable=yes,tollbar=no,scrollbars=yes','ED_LILO')
}


function GoLastPropDetails() {
//	The purpose of this function is to 
//
//
	if (top.EDPDUrl!=undef) {
		top.MapFrame.positionLoadingLyr(); 
		GoSimpleGUIiFrameRight(top.EDPDUrl);
	} else {
		alert ("No Property Details available.");
	}
}