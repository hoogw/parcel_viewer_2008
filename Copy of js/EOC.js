function GoEOC_ViewMaps() {
//	The purpose of this function is to open up a brand new pop-up window

	top.MapFrame.newwindow('EOC/eoc_ViewMaps.aspx','height=420,width=600,menubar=no,resizable=yes,tollbar=yes,scrollbars=yes','ED_VM')
}

function GoEOC_MetaData() {

	top.MapFrame.newwindow('EOC/eoc_MetaData.aspx','height=420,width=760,menubar=no,resizable=yes,tollbar=no,scrollbars=yes','ED_MD')

//	var objData=top.MapFrame.findObj('iFramedataLayer',top.MapFrame.document); 
//	if (objData!=null) { objData.src="includes/fwindow.aspx?l=data&title=MetaData&src=../EOC/eoc_MetaData.asp&s=yes"; }
//	showFloatingLayer(lyrdata);
}

function GoEOC_DemographicAnalyzer() {
//	The purpose of this function is to open up a brand new pop-up window 

//	top.MapFrame.newwindow('EOC/eoc_DemographicAnalyzer.aspx','height=220,width=400,menubar=no,resizable=yes,tollbar=no,scrollbars=yes','ED_DA')

	top.fwinURL[0]='EOC/eoc_DemographicAnalyzer.aspx';
	var objTMP=top.MapFrame.findObj("iFramecontactinfoLayer",top.MapFrame.document);
	top.MapFrame.ChangeiFrameURL(objTMP,"Demographic Analyzer","yes",1);

}

function GoEOC_AreaZoneSummaries() {
//	The purpose of this function is to open up a brand new pop-up window 

	top.fwinURL[0]='EOC/eoc_AreaZoneSummaries.aspx';
	var objTMP=top.MapFrame.findObj("iFramecontactinfoLayer",top.MapFrame.document);
	top.MapFrame.ChangeiFrameURL(objTMP,"Area Zone Summaries","yes",1);

//	top.MapFrame.newwindow('EOC/eoc_AreaZoneSummaries.aspx','height=220,width=400,menubar=no,resizable=yes,tollbar=no,scrollbars=yes','ED_AZ')
}
