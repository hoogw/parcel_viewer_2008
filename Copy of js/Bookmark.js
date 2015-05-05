function goBookmarkMain (m) {
//	The purpose of this function is to Set the right-docked layer to the main bookmark page, BM_Main
//
	top.fwinURL[2]="bookmark/BM_Main.aspx?m=" + m; 
	var obj=findObj("iFrameBookmarkLayer",document);
	ChangeiFrameURL(obj,"Bookmark Console","yes",1);
}

function GoMeasureDistance() {
//	The purpose of this function is to show the Measure layer
//
//
	showKLayer(lyrmeasuredist);
}

function GoBuffer(type,coords,LtB,url) {
//	The purpose of this function is to implment a buffer via a bookmark.  All we need to do is
//  take the URL passed in, u, and call ChangeiFrameURL - this will pop open the buffer results
//  window and direct it to the specified URL, u.
//
	if (type=='rectangle') {
		var bcoords=coords.split(",");

		if (simpleGUI==1) {
			GoSimpleGUIiFrameRight("SS/buffer.aspx?w=8&minX=" + bcoords[0] + "&maxX=" + bcoords[1] + "&minY=" + bcoords[2] + "&maxY=" + bcoords[3] + "&LtB=" + LtB);
		}else{
			top.fwinURL[3]="SS/buffer.aspx?w=8&minX=" + bcoords[0] + "&maxX=" + bcoords[1] + "&minY=" + bcoords[2] + "&maxY=" + bcoords[3] + "&LtB=" + LtB;
			var objTMP=top.MapFrame.findObj("iFrameSSLayer",document);
			top.MapFrame.ChangeiFrameURL(objTMP,"Buffer Results","yes",2);
		}

		top.MapFrame.newwindow(url,'height=500,width=750,menubar=no,resizable=yes,tollbar=no,scrollbars=yes','BufferResults');
	} else {

		if (simpleGUI==1) {
			GoSimpleGUIiFrameRight("SS/buffer.aspx?w=8&plcoords=" + coords + "&sel=lp&LtB=" + LtB);
		}else{
			top.fwinURL[3]="SS/buffer.aspx?w=8&plcoords=" + coords + "&sel=lp&LtB=" + LtB;
			var objTMP=top.MapFrame.findObj("iFrameSSLayer",document);
			ChangeiFrameURL(objTMP,"Buffer","yes",2);
		}
		
		
		top.MapFrame.newwindow(url + '&plcoords=' + coords,'height=500,width=750,menubar=no,resizable=yes,tollbar=no,scrollbars=yes','BufferResults');
	}
}

function GoSearchAll(saquery,saparams,m) {
//	The purpose of this function is to Set the right-docked layer to the Search All page, search_all
//  m=0 Search All query and parameters are set - use the coordinates and query params to implement the bookmark
//  m=1 Search All query and parameters are not set --- use the search All URL provided by the bookmark
//
	//if (m==0) {
		top.fwinURL[3]="SS/search_all.aspx" + saparams + "&p=2";
	//}else {
	//	top.fwinURL[3]=saparams + "&bm=1";
	//}
// SS/search_all.aspx?p=2&m=&lyr=id_Parcels
	var obj=findObj("iFrameSSLayer",document);
	ChangeiFrameURL(obj,"Search All","yes",2);

	var url="SS/search_all.aspx" + saparams + "&p=3&QueryString=" + saquery;
	top.MapFrame.newwindow(url,'height=500,width=750,menubar=no,resizable=yes,tollbar=no,scrollbars=yes','SearchAllResults');
}

function GoIDAll(c,q,u) {
//	The purpose of this function is to implement an ID All (via a bookmark).  By setting the stage for the main processor
//  form variables, we can tell the application to 'implement' and ID All via parameters.
//
	positionLoadingLyr();

	var objB = findObj("Bookmark")
	var objWC = findObj("WhereClause")
	var objMF = findObj("MapFunction")
	var objQL = findObj("QueryLayer")
	var objZoomToFeature=findObj('ZoomToFeature'); 

	if (objWC!=null) {
		if (objB!=null) { objB.value=''; }
		if (objZoomToFeature!=null) { objZoomToFeature.value='N'; }
		objWC.value=c;
		objQL.value=q;
		objMF.value=21;
		top.MapFrame.newwindow(u,'height=500,width=750,menubar=no,resizable=yes,tollbar=no,scrollbars=yes','SearchAllResults');

		RefreshMap();		//refreshing the map will execute map action 21 - ID All
	}
}

function GoAPN (p) {
//	The purpose of this function is to Set the right-docked layer to the parcel details page, parcel_details
//  If the app type is simpleGUI, then the window is a fixed right docked layer (i.e. you cannot minimize it).
//
	if (simpleGUI==1) {
		GoSimpleGUIiFrameRight("SS/parcel_details.aspx?APN=" + p);
	}else{
		
		top.fwinURL[3]="SS/parcel_details.aspx?APN=" + p;
		var objTMP=top.MapFrame.findObj("iFrameSSLayer",document); 
		top.MapFrame.ChangeiFrameURL(objTMP,"Parcel Details","yes",2);
	}
}

function GoIntersectionSearch (p) {
//	The purpose of this function is to Set the right-docked layer to the intersection search page, intersection_process
//  If the app type is simpleGUI, then the window is a fixed right docked layer (i.e. you cannot minimize it).
//
	if (simpleGUI==1) {
		GoSimpleGUIiFrameRight("SS/intersection_process.aspx?bm=1");
	}else{
		top.fwinURL[3]='SS/intersection_process.aspx?bm=1';
		var objTMP=top.MapFrame.findObj("iFrameSSLayer",document); 
		top.MapFrame.ChangeiFrameURL(objTMP,"Intersection Search","yes",2);
	}
}

function ShowDrawing(se) {
	//This function basically opens up a floating window & displays the BM_Drawinig.aspx page - drawing tools.
	top.fwinURL[6]='Bookmark/BM_Drawing.aspx?s=no&spedit=' + se;
	var objTMP=top.MapFrame.findObj("iFrameBMDrawingLayer",top.MapFrame.document);
	top.MapFrame.ChangeiFrameURL(objTMP,"Drawing Tools","yes",1);
}
