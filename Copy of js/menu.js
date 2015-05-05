var delay=500; var menuElement=new Array (); var usedWidth=0; var numOfMenus=0; var topID=-1; var dly;
var initX       = 61; // x-coordinate of top left corner of dropdown menu 
var initY       = TitleBarHeight-1; // y-coordinate of top left corner of dropdown menu 
var backColor   = ''; // the background color of dropdown menu, set empty '' for transparent
var borderColor = 'black'; // the color of dropdown menu border
var borderSize  = '1'; // the width of dropdown menu border
var itemHeight  = 18;
var xOverlap    = 5;
var yOverlap    = 10;

isNC    = (document.layers) ? 1 : 0;
isOPERA = (navigator.userAgent.indexOf('Opera') >= 0)? true : false;
isIE    = (document.all && !isOPERA)? true : false;
isDOM   = (document.getElementById && !isIE && !isOPERA)? true : false;

// constructor of menu elements
function menuConstructor (id, content) {
//	The purpose of this function is to create the drop down menu items.  

	var undef;
	
	this.ID            = id;
	this.parentID      = content [0]*1;
	this.parentItemID  = content [1]*1;
	this.width         = content [2]*1;
	this.timerID       = -1;
	this.isOn          = false;
	this.item          = new Array ();
	this.currItemID    = -1;
	
	this.x = content [3]*1;
	
	if (this.x < 0 && this.parentID == -1) { this.x = initX + usedWidth; usedWidth = usedWidth + this.width; }
	else if (this.x < 0 && this.parentID > -1) { this.x =  menuElement [this.parentID].x + menuElement [this.parentID].width - xOverlap; }

	this.y = content [4]*1;

	if (this.y < 0 && this.parentID == -1) this.y = initY;
	else if (this.y < 0 && this.parentID > -1) this.y =  menuElement [this.parentID].y + itemHeight*this.parentItemID + yOverlap;
	
	items = content [5];
	
	layerBody = "<TABLE width=" + this.width + " cellpadding=0 cellspacing=0 border=0 onmouseover=\"clearTimeout(dly); di20('m_" + content[6] + "','images/" + jsColourScheme + "tab_" + content[6] + "_ro.gif');\" onmouseout=\"dly=setTimeout('di20(\\'m_" + content[6] + "\\',\\'images/" + jsColourScheme + "tab_" + content[6] + ".gif\\');',200);\">";
	layerBody += '<TR><TD><img src="images/' + jsColourScheme + 'menu_top.gif" height=10></TD></TR>';
	for (j = 0; j <= items.length - 2; j = j + 2)
	{
		if (items[j+1]!="" && items[j]!="" && items[j]!=undef && items[j+1]!=undef) {
			layerBody += "<TD><a href=\"" + items [j + 1] + "\" onmouseover=\"di20('img_" + items [j] + "','images/" + jsColourScheme + "m_" + items [j] + "_ro.gif');\" onmouseout=\"di20('img_" + items [j] + "','images/" + jsColourScheme + "m_" + items [j] + ".gif');\"><img src='images/" + jsColourScheme + "m_" + items [j] + ".gif' border=0 name='img_" + items [j] + "'></a></TD>";
			if (j < items.length - 2) {
				layerBody = layerBody +  '<TR>\n';
			} else {
				layerBody = layerBody + '\n';
			}
		}
	}
	layerBody += '<TR><TD><img src="images/' + jsColourScheme + 'menu_bottom.gif" height=7></TD></TR>';

	if (!isNC) layerHeader = '<DIV id=Menu' + this.ID + ' onMouseOver="enterMenu (' + this.ID + ');" onMouseOut = "exitMenu (' + this.ID + ');"' + ' style="width: ' + this.width + '; visibility: hidden; position: absolute; left: ' + this.x + '; top: ' + this.y + '; z-index:50;">';
	else layerHeader = '<layer id=Menu' + this.ID + ' onMouseOver="enterMenu (' + this.ID + ');" onMouseOut = "exitMenu (' + this.ID + ');"' + ' visibility=hide left=' + this.x + ' top =' + this.y + '>';

	layerHeader += '<TABLE width=' + this.width + ' cellpadding=0 cellspacing=0 border=0><TD>';
	layerFooter = '</TABLE></TD></TABLE>';

 	if (!isNC) layerFooter = layerFooter + '</DIV>';
	else layerFooter = layerFooter + '</layer>';
	document.writeln (layerHeader + layerBody + layerFooter);
	return this;
}

function enterTopItem (ID) {
	di20("m_" + menuContent [ID][6],"images/" + jsColourScheme + "tab_" + menuContent [ID][6] + "_ro.gif");
	if (topID != ID && topID != -1) hideTree (topID);
	releaseTree (ID);
	topID = ID;
	show (ID);
}

function exitTopItem (ID) {
	di20("m_" + menuContent [ID][6],"images/" + jsColourScheme + "tab_" + menuContent [ID][6] + ".gif");
	menuElement [ID].timerID = setTimeout ('hide (' + ID + ')', delay);
}

function enterItem (menuID, itemID) {
	var currItemID = menuElement [menuID].currItemID;

	if (currItemID != i & currItemID > -1) hide (currItemID);
	
	for (var i = 0; i < numOfMenus; i++) {
		if (menuElement [i].parentID == menuID && menuElement [i].parentItemID == itemID) {
			clearTimeout (menuElement [i].timerID); menuElement [i].timerID = -1; show (i); return 0;
		}
	}
	return -1;
}

function exitItem (menuID, itemID) {
	for (var i = 0; i < numOfMenus; i++) {
		if (menuElement [i].parentID == menuID &&  menuElement [i].parentItemID == itemID) {
			menuElement [i].timerID = setTimeout ('hide (' + i + ')', delay); return 0;
		}
	}
}

function enterMenu (ID) {
	var parentID = menuElement [ID].parentID;
	if (parentID == -1) {
		clearTimeout (menuElement [ID].timerID); menuElement [ID].timerID = -1;
	}
	else
		releaseTree (ID);
}

function exitMenu (ID) {
	timeoutTree (ID);
}

function hideTree (ID) {
	hide (ID);
	for (var j = 0; j < numOfMenus; j++) {
		if (menuElement [j].parentID == ID && menuElement [j].isOn) { 
			hideTree (j); return 0;
		}
	}
}

function releaseTree (ID) {
	clearTimeout (menuElement [ID].timerID);
	menuElement [ID].timerID = -1;

	var parentID = menuElement [ID].parentID;
	if (parentID > -1)
		releaseTree (parentID);
}

function timeoutTree (ID) {
	menuElement [ID].timerID = setTimeout ('hide (' + ID + ')', delay);
	var parentID = menuElement [ID].parentID;
	if (parentID > -1)
		timeoutTree (parentID);
}

function show (ID) {
	if (isDOM) 
		document.getElementById('Menu' + ID).style.visibility = "visible";
    else if (isIE) 
		document.all['Menu' + ID].style.visibility = "visible";
    else if (isNC) 
		document.layers[ID].visibility = "show";		

	menuElement [ID].isOn = true;

	if (menuElement [ID].parentID > -1)
		menuElement [menuElement [ID].parentID].currItemID = ID;
}

function hide (ID) {
	if (isDOM) 
		document.getElementById('Menu' + ID).style.visibility = "hidden";
    else if (isIE) 
		document.all['Menu' + ID].style.visibility = "hidden";
    else if (isNC) 
		document.layers[ID].visibility = "hide";

	menuElement [ID].isOn = false;

	if (menuElement [ID].parentID > -1)
		menuElement [menuElement [ID].parentID].currItemID = -1;
}

function createMenuTree () {
	for (var i = 0; i < menuContent.length; i++) {
		menuElement [i] = new menuConstructor (i, menuContent [i]); numOfMenus++;
	}
}

//Call the createMenuTree function - this creates the menus for us!
createMenuTree ();

//Dreamweaver function
function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}
