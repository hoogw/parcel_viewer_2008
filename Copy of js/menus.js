NS4=(document.layers) ;
NS60=(navigator.userAgent.indexOf("Netscape6/6.0")!=-1);
Opera=(navigator.userAgent.indexOf('Opera')!=-1)||(navigator.appName.indexOf('Opera')!=-1)||(window.opera);
Opera7=(Opera&&document.createElement!=null&&document.addEventListener!=null);
IE4=(document.all&&!Opera) ;
mac=((IE4)&&(navigator.appVersion.indexOf ("Mac")!=-1));
DOM=document.documentElement&&!NS4&&!IE4&&!Opera;
mswnd=(navigator.appVersion.indexOf("Windows")!=-1||navigator.appVersion.indexOf("WinNT")!=-1);

if(IE4)
{
	av=navigator.appVersion;
	avi=av.indexOf("MSIE");
	if (avi==-1){version = parseInt (av);}else {version=parseInt(av.substr(avi+4));}
}
var ver='6.1.3EnStd';
var m1=new Object;
m1.name='m1';
if(!window.lastm||window.lastm<1)lastm=1;
if(NS4||IE4||DOM||Opera)
{
m1.v17=null;
m1.v17Timeout='';
var maxZ=1000;
m1.v18;
m1.targetFrame;
var docLoaded=false;
m1.bIncBorder=true;
m1.v29=null;
m1.v29Str='';
m1.scrollDelay=0;
m1.scrollStep=20;
m1.showDelayedTimeout=null;
m1.fadingSteps=5;
m1.v21=".";
m1.maxlev=3;
m1.v22=0;
m1.bVarWidth=0;
m1.bShowDel=50;	/////
m1.lvl0size=170;
m1.lvl1size=200;
m1.lvl2size=100;
m1.levelOffset=50;
m1.bord=1;
m1.vertSpace=0;		/////
m1.sep=1;
m1.v19=false;
m1.v20=false;
m1.cntFrame="content";
m1.v24="content";
m1.mout=true;
m1.iconSize=7;
m1.closeDelay=50;
m1.v25=false;		//false
m1.popupOpacity = 0;
m1.v11=false;
m1.rm=-1;
m1.v10=0;
m1.popupLeftPad = 5;
m1.v01=2;
//m1.tlmHlBg="#FFFFFF";		//mouseover colour for top level menus (bg)
//m1.tlmHlCol="#000000";		//mouseover colour for top level menus (text)
//m1.tlmOrigBg="#1072B8";		//regular colour for top level menus (bg)
//m1.tlmOrigCol="#ffffff";	//regular colour for top level menus (text)
//m1.borderCol="#000000";		//1px border around every sub menu item

m1.tlmHlBg=jsMenuColour_HdrMBMO;		//mouseover colour for top level menus (bg)
m1.tlmHlCol=jsMenuColour_HdrTCMO;		//mouseover colour for top level menus (text)
m1.tlmOrigBg=jsMenuColour_HdrMB;		//regular colour for top level menus (bg)
m1.tlmOrigCol=jsMenuColour_HdrTC;	//regular colour for top level menus (text)

m1.borderCol="#000000";		//1px border around every sub menu item

m1.menuHorizontal=true;
m1.scrollHeight=9;
}

//				text size, bold, italics, text colour, bg colour, mosue-over text colour,font,mouse-over bg colour
m1.lev0 = new Array ("10px",false,false,"#" + jsMenuColour_DDTC,"#" + jsMenuColour_DDMB,"#" + jsMenuColour_HdrTCMO,"Verdana, Arial, sans-serif","#" + jsMenuColour_DDMBMO) ;
m1.lev1 = new Array ("10px",false,false,"#" + jsMenuColour_DDTC,"#" + jsMenuColour_DDMB,"#" + jsMenuColour_HdrTCMO,"Verdana, Arial, sans-serif","#" + jsMenuColour_DDMBMO) ;
m1.lev2 = new Array ("10px",false,false,"#" + jsMenuColour_DDTC,"#" + jsMenuColour_DDMB,"#" + jsMenuColour_HdrTCMO,"Verdana, Arial, sans-serif","#" + jsMenuColour_DDMBMO) ;
m1.lev3 = new Array ("10px",false,false,"#" + jsMenuColour_DDTC,"#" + jsMenuColour_DDMB,"#" + jsMenuColour_HdrTCMO,"Verdana, Arial, sans-serif","#" + jsMenuColour_DDMBMO) ;
//m1.lev3 = new Array ("10px",false,false,"#000000","#ECE9D8","black","Verdana, Arial, sans-serif","#FFFFFF") ;

absPath="";
if (m1.v19 && !m1.v20)
	{
	if (document.URL.lastIndexOf("\\")>document.URL.lastIndexOf("/")) {sepCh = "\\" ;} else {sepCh = "/" ;}
	absPath = document.URL.substring(0,document.URL.lastIndexOf(sepCh)+1);
	}
m1.popupOffset = 0;
m1.v02=m1.lvl1size;
if(Opera&&!Opera7)document.write("<"+"script language='JavaScript1.2' src='js/menu_opera.js'><"+"/"+"script>");
else if(NS4)document.write("<"+"script language='JavaScript1.2' src='js/menu_ns4.js'><"+"/"+"script>");
else if(document.getElementById) document.write("<"+"script language='JavaScript1.2' src='js/menu_dom.js'><"+"/"+"script>");
