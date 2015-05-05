//	The purpose of this Drag variable is to create a javascript class called Drag.  By using this, we can cleanly define functions for
//	initialization, start, drag, and end.

var Drag={
	obj : null,
	init : function(o,oRoot,minX,maxX,minY,maxY,bSwapHorzRef,bSwapVertRef,fXMapper,fYMapper){
				//Here we initialize dragging by setting the mouse events to the proper js functions.
		o.onmousedown=Drag.start;
		o.hmode=bSwapHorzRef ? false : true ;
		o.vmode=bSwapVertRef ? false : true ;
		o.root=oRoot && oRoot != null ? oRoot : o ;
		if(o.hmode && isNaN(parseInt(o.root.style.left))) o.root.style.left="0px";
		if(o.vmode && isNaN(parseInt(o.root.style.top))) o.root.style.top="0px";
		if(!o.hmode && isNaN(parseInt(o.root.style.right))) o.root.style.right="0px";
		if(!o.vmode && isNaN(parseInt(o.root.style.bottom))) o.root.style.bottom="0px";
		o.minX=typeof minX != 'undefined' ? minX : null;
		o.minY=typeof minY != 'undefined' ? minY : null;
		o.maxX=typeof maxX != 'undefined' ? maxX : null;
		o.maxY=typeof maxY != 'undefined' ? maxY : null;
		o.xMapper=fXMapper ? fXMapper : null;
		o.yMapper=fYMapper ? fYMapper : null;
		o.root.onDragStart=new Function();
		o.root.onDragEnd=new Function();
		o.root.onDrag=new Function();
	},
	start : function(e)	{
			//This function fires off when we start dragging
		var o=Drag.obj=this;
		e=Drag.fixE(e);
		var y=parseInt(o.vmode ? o.root.style.top  : o.root.style.bottom);
		var x=parseInt(o.hmode ? o.root.style.left : o.root.style.right );
		o.root.onDragStart(x,y);
		o.lastMouseX=e.clientX;o.lastMouseY=e.clientY;
		if (o.hmode){
			if(o.minX != null) o.minMouseX=e.clientX-x+o.minX;
			if(o.maxX != null) o.maxMouseX=o.minMouseX+o.maxX-o.minX;
		}else{
			if(o.minX != null) o.maxMouseX=-o.minX+e.clientX+x;
			if(o.maxX != null) o.minMouseX=-o.maxX+e.clientX+x;
		}
		if(o.vmode){
			if(o.minY != null) o.minMouseY=e.clientY-y+o.minY;
			if(o.maxY != null) o.maxMouseY=o.minMouseY+o.maxY-o.minY;
		}else{
			if(o.minY != null) o.maxMouseY=-o.minY+e.clientY+y;
			if(o.maxY != null) o.minMouseY=-o.maxY+e.clientY+y;
		}
		document.onmousemove=Drag.drag;document.onmouseup=Drag.end;
		
		return false;
	},
	drag : function(e){
			//This function fires off while we are dragging
		e=Drag.fixE(e);
		var o=Drag.obj;
		var ey=e.clientY;var ex=e.clientX;
		var y=parseInt(o.vmode ? o.root.style.top  : o.root.style.bottom);
		var x=parseInt(o.hmode ? o.root.style.left : o.root.style.right );
		var nx,ny;
		
		if(o.minX != null) ex=o.hmode ? Math.max(ex,o.minMouseX) : Math.min(ex,o.maxMouseX);
		if(o.maxX != null) ex=o.hmode ? Math.min(ex,o.maxMouseX) : Math.max(ex,o.minMouseX);
		if(o.minY != null) ey=o.vmode ? Math.max(ey,o.minMouseY) : Math.min(ey,o.maxMouseY);
		if(o.maxY != null) ey=o.vmode ? Math.min(ey,o.maxMouseY) : Math.max(ey,o.minMouseY);
		
		nx=x+((ex-o.lastMouseX) * (o.hmode ? 1 : -1));
		ny=y+((ey-o.lastMouseY) * (o.vmode ? 1 : -1));
		if(o.xMapper) nx=o.xMapper(y)
		else if(o.yMapper) ny=o.yMapper(x)
		
		Drag.obj.root.style[o.hmode ? "left" : "right"]=nx+"px";
		Drag.obj.root.style[o.vmode ? "top" : "bottom"]=ny+"px";
		Drag.obj.lastMouseX=ex;Drag.obj.lastMouseY=ey;
		Drag.obj.root.onDrag(nx,ny);

		return false;
	},
	end : function(){
			//This function fires off when we're done dragging
		document.onmousemove=null;document.onmouseup=null;
		if(Drag.obj!=null){
			Drag.obj.root.onDragEnd(parseInt(Drag.obj.root.style[Drag.obj.hmode ? "left" : "right"]),parseInt(Drag.obj.root.style[Drag.obj.vmode ? "top" : "bottom"]));
		}
		Drag.obj=null;
	},
	fixE : function(e){
		if(typeof e == 'undefined') e=window.event;
		if(typeof e.layerX == 'undefined') e.layerX=e.offsetX;
		if(typeof e.layerY == 'undefined') e.layerY=e.offsetY;
		return e;
	}
};

// layer dragging functions
function initDrag(sLyr){
//	The purpose of this function is to initialize dragging for ALL floating layers.  Since dragging of floating layers is javascript intensive, we
//	do the initialization here in our JS block of code.  Basically, we are calling the drag.init function to initialize draggin for the layer we
//	are passing in (sLyr).  If we have a bottom docked or right docked layer, we need to allow for the fact that while the map area is of size x,y,
//	the area we can drag in is larger by the size of these permanent docked windows
	if (simpleGUI==1) {
		tmpmaxX=parseInt(maxX)+parseInt(dockedRightPaneWidth);
		tmpmaxY=parseInt(maxY)+parseInt(dockedBottomPaneHeight);
		Drag.init(findObj(sLyr+'Drag',document),findObj(sLyr,document),minX,tmpmaxX-layer(sLyr).getWidth(),minY,tmpmaxY-layer(sLyr).getHeight());
	} else {
		Drag.init(findObj(sLyr+'Drag',document),findObj(sLyr,document),minX,maxX-layer(sLyr).getWidth(),minY,maxY-layer(sLyr).getHeight());
	}
	findObj(sLyr,document).onDragStart=dragStart;findObj(sLyr,document).onDrag=dragDragging;findObj(sLyr,document).onDragEnd=dragEnd;
}

function init_all_Drag() {
//	This function is one of the several functions called when the browser window is resized.  It allows us to refresh all of our floating windows'
//	positions, drag-able areas, etc.

	var t1;

	//For all layers that we have (floating windows), we need to reset their min (x,y) and max (x,y) values so we reflect
	//the current browser window height and width.
	for(i=0; i<arrLyrNames.length;i++){
		o=findObj(arrLyrNames[i],document);
		d=findObj(arrLyrNames[i]+'Drag',document);

		if (d!=null) { 
			d.minX=minX; d.maxX=crntWinWid-layer(o.id).getWidth();
			d.minY=minY; d.maxY=crntWinHgt-layer(o.id).getHeight();
		} else {
			 //SS Layer Stuff
			for(j=0; j<arrLyrsObjs.length;j++){
				if(arrLyrsObjs[j].id.toLowerCase()==arrLyrNames[i].toLowerCase()){
					dockLayerRight(arrLyrsObjs[j])

					t1=findObj("iFrameSS",top.SSiframePointer.document);
					top.SSiframePointer.resizeIt(t1.id);
					j=arrLyrsObjs.length+1;
				}
			}
		}
	}
}

function dragStart(x,y){
//	This function is called when we are starting to drag a floating window.  We make sure to set our dragging variable to true so we know that
//	we're dragging.  Also, we make sure that the clear drag layer is sized appropriately & it's z-index is at the front so the user's 
//	experience is optimal.

	dragging=true;
	lyr=layer(this.id);lyrDrag=layer(this.id+'Drag');
	lyrDrag.size(lyr.getWidth(),lyr.getHeight());
	bringLayerToFront(lyr);bringLayerToFront(lyrDrag);
}

function dragDragging(x,y){
//	This function is called when we are done dragging a floating window and we have let go of the mouse button.  We call drag.end here.

	if(!dragging){Drag.end()}
}

function dragEnd(curX,curY){
//	This function fires off when we're done dragging a floating window.  CrntTool 11 is pan.
//	The input to this function is the exact x,y coordinates which we dropped the floating window at.
//	We make sure to update the main processor form variables to reflect the new x,y location of the window

	dragging=false;
	
	if (crntTool==11) {
		Drag.init(objMap,null);objMap.onDragStart=dragStartMap;objMap.onDragEnd=dragEndMap;document.onmousemove=mapMouseMove
	} else {
		objMap.onmousedown=mapMouseDown;document.onmouseup=mapMouseUp;document.onmousemove=mapMouseMove;objMap.ondblclick=mapMouseDblClick;
	}
	lyrDrag=layer(this.id+'Drag');
	lyrDrag.size(lyrDrag.getWidth(),15);

	if((curX==null)||(curY==null)){return true};
	setVal(this.id+'Left',curX);setVal(this.id+'Top',curY);
	checkLayerPosition(lyr);
}

function dragStartMap(curX,curY){
	//sendLayerToBack(lyrMap);
	lyrMapImg.moveZ(lyrMap.getZIndex()+1);

}

function dragEndMap(curX,curY){
//	This function is called when we have stopped dragging the map (pan).

	//findObj('CMapMinX').value=(lyrMapImg.getLeft()-minX)*xRatio;
	//findObj('CMapMinY').value=(lyrMapImg.getTop()-(minY-TitleBarHeight))*yRatio;

	oMinX=lyrMap.getLeft()+lyrMapImg.getLeft();oMinY=lyrMap.getTop()+lyrMapImg.getTop();
	setVal('CMapMinX',(lyrMapImg.getLeft()-minX)*xRatio);setVal('CMapMinY',(lyrMapImg.getTop()-(minY-TitleBarHeight))*yRatio);

	RefreshMap();
}

