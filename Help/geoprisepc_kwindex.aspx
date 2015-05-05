<%@ Page %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD></HEAD>
<style type="text/css">
       SPAN.idxsection { font-family: Arial,Helvetica; font-weight: normal; font-size: 14pt; color: #000000; text-decoration: none }
       SPAN.idxkeyword { font-family: Arial,Helvetica; font-weight: normal; font-size: 10pt; color: #000000; text-decoration: none }
       SPAN.idxkeyword2 { font-family: Arial,Helvetica; font-weight: normal; font-size: 10pt; color: #000000; text-decoration: none }
       SPAN.idxlink { font-family: Arial,Helvetica; font-weight: normal; font-size: 8pt; color: #000000; text-decoration: none }

</style>
<BODY bgcolor="#FFFFFF">
<FONT face="Arial,Helvetica" size="4"><b>Keyword Index</b></FONT><br>
<FONT face="Arial,Helvetica" size="2">
<a href="javaScript:parent.reDisplay('navContent',0,0);">Table of Contents</a>
</FONT><br><br>

  <!-- Place holder for the index, do not delete the line below -->
  <script language='JavaScript' type='text/javascript'><!--
var isDOM=document.getElementById?1:0;
var isIE=document.all?1:0;
var isNS4=navigator.appName=='Netscape'&&!isDOM?1:0;
var isOp=window.opera?1:0;
var isWin=navigator.platform.indexOf('Win')!=-1?1:0;
var isDyn=isDOM||isIE||isNS4;
function getRef(id, par)
{
 par=!par?document:(par.navigator?par.document:par);
 return isIE ? par.all[id] :
  (isDOM ? (par.getElementById?par:par.ownerDocument).getElementById(id) :
  (isNS4 ? par.layers[id] : null));
}
function getSty(id, par)
{
 var r=getRef(id, par);
 return r?(isNS4?r:r.style):null;
}
if (!window.LayerObj) var LayerObj = new Function('id','par',
 'this.ref=getRef(id, par); this.sty=getSty(id, par); return this');
function getLyr(id, par) { return new LayerObj(id, par) }
function LyrFn(fn, fc)
{
 LayerObj.prototype[fn] = new Function('var a=arguments,p=a[0],px=isNS4||isOp?0:"px"; ' +
  'with (this) { '+fc+' }');
}
LyrFn('x','if (!isNaN(p)) sty.left=p+px; else return parseInt(sty.left)');
LyrFn('y','if (!isNaN(p)) sty.top=p+px; else return parseInt(sty.top)');
LyrFn('w','if (p) (isNS4?sty.clip:sty).width=p+px; ' +
 'else return (isNS4?ref.document.width:ref.offsetWidth)');
LyrFn('h','if (p) (isNS4?sty.clip:sty).height=p+px; ' +
 'else return (isNS4?ref.document.height:ref.offsetHeight)');
LyrFn('vis','sty.visibility=p');
LyrFn('write','if (isNS4) with (ref.document){write(p);close()} else ref.innerHTML=p');
LyrFn('alpha','var f=ref.filters,d=(p==null); if (f) {' +
 'if (!d&&sty.filter.indexOf("alpha")==-1) sty.filter+=" alpha(opacity="+p+")"; ' +
 'else if (f.length&&f.alpha) with(f.alpha){if(d)enabled=false;else{opacity=p;enabled=true}} }' +
 'else if (isDOM) sty.MozOpacity=d?"":p+"%"');
var CSSmode=document.compatMode;
CSSmode=(CSSmode&&CSSmode.indexOf('CSS')!=-1)||isDOM&&!isIE||isOp?1:0;
if (!window.page) var page = { win: window, minW: 0, minH: 0, MS: isIE&&!isOp,
 db: CSSmode?'documentElement':'body' }
page.winW=function()
 { with (this) return Math.max(minW, MS?win.document[db].clientWidth:win.innerWidth) }
page.winH=function()
 { with (this) return Math.max(minH, MS?win.document[db].clientHeight:win.innerHeight) }
page.scrollY=function()
 { with (this) return MS?win.document[db].scrollTop:win.pageYOffset }
page.scrollX=function()
 { with (this) return MS?win.document[db].scrollLeft:win.pageXOffset }
function tipTrack(evt, always) { with (this)
{
 evt=evt?evt:window.event;
 sX = page.scrollX();
 sY = page.scrollY();
 mX = isNS4 ? evt.pageX : sX + evt.clientX;
 mY = isNS4 ? evt.pageY : sY + evt.clientY;
}}
function tipPosition(forcePos) { with (this)
{
 if (!actTip) return;
 var wW = page.winW()-(isIE?0:15), wH = page.winH()-(isIE?0:15);
 var t=tips[actTip], tipX=eval(t[0]), tipY=eval(t[1]), tipW=div.w(), tipH=div.h(), adjY = 1;
 if (typeof(t[0])=='number') tipX += mX;
 if (typeof(t[1])=='number') tipY += mY;
 if (tipX + tipW + 5 > sX + wW) { tipX = sX + wW - tipW - 5; adjY = 2 }
 if (tipY + tipH + 5 > sY + wH) tipY = sY + wH - (adjY*tipH) - 5;
 if (tipX < sX+ 5) tipX = sX + 5;
 if (tipY < sY + 5) tipY = sY + 5;
 div.x(tipX);
 div.y(tipY-10);
}}
function tipShow(tipN) { with (this)
{
 if (!isDyn) return;
 if (!div) div = getLyr(myName + 'Layer');
 if (isDOM) div.sty.width = 'auto';
 if (actTip != tipN)
 {
  actTip = tipN;
   if (isNS4) div.ref.captureEvents(Event.MOUSEOVER | Event.MOUSEOUT);
   div.ref.onmouseover = new Function('evt', myName + '.show("' + tipN + '"); ' +
    'if (isNS4) return this.routeEvent(evt)');
   div.ref.onmouseout = new Function('evt', myName + '.hide(); ' +
   'if (isNS4) return this.routeEvent(evt)');
  position(true);
  div.write(template);
 }
 showTip = true;
 fade();
}}
function tipHide() { with (this)
{
 if (!isDyn || !actTip) return;
 if (isNS4 && xPos<=mX && mX<=xPos+div.w() && yPos<=mY && mY<=yPos+div.h()) return;
 clearTimeout(fadeTimer);
 fadeTimer = setTimeout('with (' + myName + ') { showTip=false; fade() }', hideDelay);
}}
function tipFade() { with (this)
{
 clearTimeout(fadeTimer);
 if (showTip)
 {
  div.vis('visible');
 }
 else
 {
  div.vis('hidden');
  actTip = "";
  clearInterval(trackTimer);
 }
}}
function TipObj(myName)
{
 this.myName = myName;
 this.tips = new Array();
 this.template = '';
 this.actTip = '';
 this.showTip = false;
 this.showDelay = 50;
 this.hideDelay = 500;
 this.xPos = this.yPos = this.sX = this.sY = this.mX = this.mY = 0;
 this.track = tipTrack;
 this.position = tipPosition;
 this.show = tipShow;
 this.hide = tipHide;
 this.fade = tipFade;
 this.div = null;
 this.trackTimer = this.fadeTimer = 0;
 this.doFades = false;
}
var kwPopup = new TipObj('kwPopup');
with (kwPopup)
{
 tips.links = new Array(5,0);
 tipStick = 0;
}
if (isNS4) document.captureEvents(Event.MOUSEMOVE);
document.onmousemove = function(evt)
{
 kwPopup.track(evt);
 if (isNS4) return document.routeEvent(evt);
}
var nsWinW = window.innerWidth, nsWinH = window.innerHeight;
function ns4BugCheck()
{
 if (isNS4 && (nsWinW!=innerWidth || nsWinH!=innerHeight)) location.reload()
}
window.onresize = function()
{
 ns4BugCheck();
}
function displayLink(aLink) {
with (kwPopup)
{
 actTip = "";
 hide();
 template = '<TABLE bgcolor="#000000" cellpadding="1" cellspacing="0" border="0">' +
  '<TR><TD><TABLE cellpadding="3" cellspacing="1" border="0">' +
  '<TR><TD bgcolor="#f0f0f0"><span class="idxlink">Topics Found</span></TD></TR>';
 template = template + '<TR><TD align="left" bgcolor="#ffffff"><span class="idxlink">' + aLink + '</span></TD></TR>';
 template = template + '</TABLE></TD></TR></TABLE>';
 show('links');
}
}
//--></script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>
<DIV id="kwPopupLayer" style="position: absolute; z-index: 1000; visibility: hidden; left: 0px; top: 0px; width: 10px">&nbsp;</DIV>
     <a name="A"><br><span class="idxsection">- A -</span><br><br>
<a href="javascript:void(0)" onMouseOver="JavaScript:displayLink('<a href=about.aspx target=content>About</a><br>')" onMouseOut="kwPopup.hide()"><span class="idxkeyword">About</span></a></br>
<%if (Application("AppType")="ProjCoord") then%>
<a href="javascript:void(0)" onMouseOver="JavaScript:displayLink('<a href=navigatingtheinterface.aspx target=content>Getting Started</a><br><a href=administrationutility.aspx target=content>Administration Utility</a><br>')" onMouseOut="kwPopup.hide()"><span class="idxkeyword">Administration Utility</span></a></br>
<%end if%>
<%if (Application("SearchAPN")) then%>
<a href="javascript:void(0)" onMouseOver="JavaScript:displayLink('<a href=searchtips3.aspx target=content>Search APN Tips</a><br>')" onMouseOut="kwPopup.hide()"><span class="idxkeyword">APN</span></a></br>
<%end if%>
<a href="javascript:void(0)" onMouseOver="JavaScript:displayLink('<a href=navigatingtheinterface.aspx target=content>Getting Started</a><br>')" onMouseOut="kwPopup.hide()"><span class="idxkeyword">Application Tabs</span></a></br>

     <a name="B"><br><span class="idxsection">- B -</span><br><br>
<%if Application("Bookmark") or Application("Naved_Bookmarks") then%>
<a href="javascript:void(0)" onMouseOver="JavaScript:displayLink('<a href=bookmarkdrawingtools.aspx target=content>Bookmark Drawing Tools</a><br><a href=pointslines.aspx target=content>Points &amp; Lines</a><br><a href=polygons.aspx target=content>Polygons</a><br><a href=circlesbuffers.aspx target=content>Circles &amp; Buffers</a><br><a href=text.aspx target=content>Text Label</a><br>')" onMouseOut="kwPopup.hide()"><span class="idxkeyword">Bookmark Drawing Tools</span></a></br>
<a href="javascript:void(0)" onMouseOver="JavaScript:displayLink('<a href=bookmarks.aspx target=content>Bookmarks</a><br><a href=bookmarks2.aspx target=content>Bookmarks</a><br>')" onMouseOut="kwPopup.hide()"><span class="idxkeyword">Bookmarks</span></a></br>
<%end if%>
<%if Application("Naved_PropertySearch") then%>
<a href="javascript:void(0)" onMouseOver="JavaScript:displayLink('<a href=brokerinformation.aspx target=content>Brokerage Information</a><br>')" onMouseOut="kwPopup.hide()"><span class="idxkeyword">Broker Information</span></a></br>
<a href="javascript:void(0)" onMouseOver="JavaScript:displayLink('<a href=brokerinformation.aspx target=content>Brokerage Information</a><br>')" onMouseOut="kwPopup.hide()"><span class="idxkeyword">Brokerage Information</span></a></br>
<%end if%>
<%if Application("SelectBuffer") then%>
<a href="javascript:void(0)" onMouseOver="JavaScript:displayLink('<a href=bufferselection.aspx target=content>Buffer</a><br>')" onMouseOut="kwPopup.hide()"><span class="idxkeyword">Buffer</span></a></br>
<%end if%>
<%if Application("Naved_PropertySearch") then%>
<a href="javascript:void(0)" onMouseOver="JavaScript:displayLink('<a href=businessreport.aspx target=content>Business Report</a><br>')" onMouseOut="kwPopup.hide()"><span class="idxkeyword">Business Report</span></a></br>
<%end if%>
<a href="javascript:void(0)" onMouseOver="JavaScript:displayLink('<a href=navigatingtheinterface.aspx target=content>Getting Started</a><br>')" onMouseOut="kwPopup.hide()"><span class="idxkeyword">Buttons</span></a></br>

     <a name="C"><br><span class="idxsection">- C -</span><br><br>
<%if Application("Bookmark") or Application("Naved_Bookmarks") then%>
<a href="javascript:void(0)" onMouseOver="JavaScript:displayLink('<a href=circlesbuffers.aspx target=content>Circles &amp; Buffers</a><br>')" onMouseOut="kwPopup.hide()"><span class="idxkeyword">Circles &amp; Buffers</span></a></br>
<%end if%>
<%if Application("SelectClear") then%>
<a href="javascript:void(0)" onMouseOver="JavaScript:displayLink('<a href=clearselection.aspx target=content>Clear</a><br>')" onMouseOut="kwPopup.hide()"><span class="idxkeyword">Clear</span></a></br>
<%end if%>
<%if Application("ClientName") = "SacCountyAssessor" then%>
<a href="javascript:void(0)" onMouseOver="JavaScript:displayLink('<a href=thereporttab.aspx target=content>The Comment Tab</a><br>')" onMouseOut="kwPopup.hide()"><span class="idxkeyword">Comment Tab</span></a></br>
<%end if%>
<%if Application("OverviewCoords") then%>
<a href="javascript:void(0)" onMouseOver="JavaScript:displayLink('<a href=coordinates.aspx target=content>Coordinates</a><br>')" onMouseOut="kwPopup.hide()"><span class="idxkeyword">Coordinates</span></a></br>
<%end if%>
<%if Application("Bookmark") or Application("Naved_Bookmarks") then%>
<a href="javascript:void(0)" onMouseOver="JavaScript:displayLink('<a href=createbookmark.aspx target=content>Create Bookmark</a><br>')" onMouseOut="kwPopup.hide()"><span class="idxkeyword">Create Bookmark</span></a></br>
<%end if%>

     <a name="D"><br><span class="idxsection">- D -</span><br><br>
<%if (Application("AppType")="EconDev") then%>
<a href="javascript:void(0)" onMouseOver="JavaScript:displayLink('<a href=datamanagement.aspx target=content>Data Management</a><br>')" onMouseOut="kwPopup.hide()"><span class="idxkeyword">Data Management</span></a></br>
<%end if%>
<%if Application("Bookmark") or Application("Naved_Bookmarks") then%>
<a href="javascript:void(0)" onMouseOver="JavaScript:displayLink('<a href=deletebookmark.aspx target=content>Delete Bookmark</a><br>')" onMouseOut="kwPopup.hide()"><span class="idxkeyword">Delete Bookmark</span></a></br>
<%end if%>
<%if Application("Naved_PropertySearch") then%>
<a href="javascript:void(0)" onMouseOver="JavaScript:displayLink('<a href=demographicreport.aspx target=content>Demographic Report</a><br>')" onMouseOut="kwPopup.hide()"><span class="idxkeyword">Demographic Report</span></a></br>
<a href="javascript:void(0)" onMouseOver="JavaScript:displayLink('<a href=demographicreport.aspx target=content>Demographic Report</a><br>')" onMouseOut="kwPopup.hide()"><span class="idxkeyword">Demographics</span></a></br>
<%end if%>
<%if (Application("AppType")="ProjCoord") then%>
<a href="javascript:void(0)" onMouseOver="JavaScript:displayLink('<a href=displayoptions.aspx target=content>Display Options</a><br>')" onMouseOut="kwPopup.hide()"><span class="idxkeyword">Display Options</span></a></br>
<%end if%>
<%if Application("Bookmark") or Application("Naved_Bookmarks") then%>
<a href="javascript:void(0)" onMouseOver="JavaScript:displayLink('<a href=bookmarkdrawingtools.aspx target=content>Bookmark Drawing Tools</a><br>')" onMouseOut="kwPopup.hide()"><span class="idxkeyword">Drawing Tools</span></a></br>
<%end if%>

     <a name="E"><br><span class="idxsection">- E -</span><br><br>
<%if (Application("AppType")="EconDev") then%>
<a href="javascript:void(0)" onMouseOver="JavaScript:displayLink('<a href=theeconomicdevelopmenttab.aspx target=content>The Economic Development Tab</a><br>')" onMouseOut="kwPopup.hide()"><span class="idxkeyword">Economic Development</span></a></br>
<%end if%>
<%if Application("Naved_Bookmarks") then%>
<a href="javascript:void(0)" onMouseOver="JavaScript:displayLink('<a href=bookmarks2.aspx target=content>Bookmarks</a><br>')" onMouseOut="kwPopup.hide()"><span class="idxkeyword">Economic Development Bookmarks</span></a></br>
<%end if%>
<%if (Application("AppType")="EconDev") then%>
<a href="javascript:void(0)" onMouseOver="JavaScript:displayLink('<a href=datamanagement.aspx target=content>Data Management</a><br>')" onMouseOut="kwPopup.hide()"><span class="idxkeyword">Economic Development Data Management</span></a></br>
<%end if%>
<%if Application("Naved_Geoanalysis") then%>
<a href="javascript:void(0)" onMouseOver="JavaScript:displayLink('<a href=geoanalysis.aspx target=content>GeoAnalysis</a><br>')" onMouseOut="kwPopup.hide()"><span class="idxkeyword">Economic Development Geographic Analysis</span></a></br>
<%end if%>
<%if (Application("AppType")="EconDev") then%>
<a href="javascript:void(0)" onMouseOver="JavaScript:displayLink('<a href=mainpage.aspx target=content>Main Page</a><br>')" onMouseOut="kwPopup.hide()"><span class="idxkeyword">Economic Development Main Page</span></a></br>
<%end if%>
<%if Application("Naved_PropertyDetails") then%>
<a href="javascript:void(0)" onMouseOver="JavaScript:displayLink('<a href=prop_details.aspx target=content>Prop. Details</a><br>')" onMouseOut="kwPopup.hide()"><span class="idxkeyword">Economic Development Prop. Details</span></a></br>
<%end if%>
<%if (Application("Naved_PropCandidateList")) then%>
<a href="javascript:void(0)" onMouseOver="JavaScript:displayLink('<a href=prop_candidatesearch.aspx target=content>Prop. Candidate Search</a><br>')" onMouseOut="kwPopup.hide()"><span class="idxkeyword">Economic Development Property Candidate Search</span></a></br>
<%end if%>
<%if (Application("Naved_PropertyDetails")) then%>
<a href="javascript:void(0)" onMouseOver="JavaScript:displayLink('<a href=prop_details.aspx target=content>Prop. Details</a><br>')" onMouseOut="kwPopup.hide()"><span class="idxkeyword">Economic Development Property Details</span></a></br>
<%end if%>
<%if (Application("Naved_PropertySearch")) then%>
<a href="javascript:void(0)" onMouseOver="JavaScript:displayLink('<a href=propertysearch.aspx target=content>Property Search</a><br>')" onMouseOut="kwPopup.hide()"><span class="idxkeyword">Economic Development Property Search</span></a></br>
<%end if%>
<%if (Application("AppType")="EconDev") then%>
<a href="javascript:void(0)" onMouseOver="JavaScript:displayLink('<a href=theeconomicdevelopmenttab.aspx target=content>The Economic Development Tab</a><br>')" onMouseOut="kwPopup.hide()"><span class="idxkeyword">Economic Development Tab</span></a></br>
<%end if%>
<%if (Application("AppType")="EconDev") then%>
<a href="javascript:void(0)" onMouseOver="JavaScript:displayLink('<a href=enhancedtoolbar.aspx target=content>Enhanced Toolbar</a><br>')" onMouseOut="kwPopup.hide()"><span class="idxkeyword">Enhanced Toolbar</span></a></br>
<%end if%>

     <a name="F"><br><span class="idxsection">- F -</span><br><br>
<%if (Application("NavFullExt")) then%>
<a href="javascript:void(0)" onMouseOver="JavaScript:displayLink('<a href=fullextent.aspx target=content>Full Extent</a><br>')" onMouseOut="kwPopup.hide()"><span class="idxkeyword">Full Extent</span></a></br>
<%end if%>

     <a name="G"><br><span class="idxsection">- G -</span><br><br>
<%if Application("Naved_Geoanalysis") then%>
<a href="javascript:void(0)" onMouseOver="JavaScript:displayLink('<a href=geoanalysis.aspx target=content>GeoAnalysis</a><br>')" onMouseOut="kwPopup.hide()"><span class="idxkeyword">Geo Analysis</span></a></br>
<a href="javascript:void(0)" onMouseOver="JavaScript:displayLink('<a href=geoanalysis.aspx target=content>GeoAnalysis</a><br>')" onMouseOut="kwPopup.hide()"><span class="idxkeyword">Geographic Analysis</span></a></br>
<%end if%>
<a href="javascript:void(0)" onMouseOver="JavaScript:displayLink('<a href=welcometogeoprise_net.aspx target=content>Welcome to GeoPrise.NET</a><br>')" onMouseOut="kwPopup.hide()"><span class="idxkeyword">GeoPrise.NET</span></a></br>

     <a name="H"><br><span class="idxsection">- H -</span><br><br>
<a href="javascript:void(0)" onMouseOver="JavaScript:displayLink('<a href=sitehelp.aspx target=content>Site Help</a><br>')" onMouseOut="kwPopup.hide()"><span class="idxkeyword">Help</span></a></br>
<a href="javascript:void(0)" onMouseOver="JavaScript:displayLink('<a href=thehelptab.aspx target=content>The Help Tab</a><br>')" onMouseOut="kwPopup.hide()"><span class="idxkeyword">Help Tab</span></a></br>

     <a name="I"><br><span class="idxsection">- I -</span><br><br>
<%if (Application("SelectIDAll")) then%>
<a href="javascript:void(0)" onMouseOver="JavaScript:displayLink('<a href=identifyall.aspx target=content>Identify All</a><br>')" onMouseOut="kwPopup.hide()"><span class="idxkeyword">Identify All</span></a></br>
<%end if%>
<%if (Application("SelectParcelID")) then%>
<a href="javascript:void(0)" onMouseOver="JavaScript:displayLink('<a href=parcelidentify.aspx target=content>Identify Parcel</a><br>')" onMouseOut="kwPopup.hide()"><span class="idxkeyword">Identify Parcel</span></a></br>
<%end if%>
<%if (Application("SelectParcelDetails")) then%>
<a href="javascript:void(0)" onMouseOver="JavaScript:displayLink('<a href=parceldetails.aspx target=content>Identify Parcel Details</a><br>')" onMouseOut="kwPopup.hide()"><span class="idxkeyword">Identify Parcel Details</span></a></br>
<%end if%>
<%if (Application("AppType")="ProjCoord") then%>
<a href="javascript:void(0)" onMouseOver="JavaScript:displayLink('<a href=identifyproject.aspx target=content>Identify Project</a><br>')" onMouseOut="kwPopup.hide()"><span class="idxkeyword">Identify Project</span></a></br>
<%end if%>

     <a name="L"><br><span class="idxsection">- L -</span><br><br>
<%if Application("SearchLandMark") then%>
<a href="javascript:void(0)" onMouseOver="JavaScript:displayLink('<a href=landmark.aspx target=content>Landmark</a><br>')" onMouseOut="kwPopup.hide()"><span class="idxkeyword">Landmark</span></a></br>
<%end if%>
<%if Application("OverviewLayers") then%>
<a href="javascript:void(0)" onMouseOver="JavaScript:displayLink('<a href=layers.aspx target=content>Layers</a><br>')" onMouseOut="kwPopup.hide()"><span class="idxkeyword">Layers</span></a></br>
<%end if%>
<%if Application("OverviewLegend") then%>
<a href="javascript:void(0)" onMouseOver="JavaScript:displayLink('<a href=legend.aspx target=content>Legend</a><br>')" onMouseOut="kwPopup.hide()"><span class="idxkeyword">Legend</span></a></br>
<%end if%>

     <a name="M"><br><span class="idxsection">- M -</span><br><br>
<%if (Application("AppType")="EconDev") then%>
<a href="javascript:void(0)" onMouseOver="JavaScript:displayLink('<a href=mainpage.aspx target=content>Main Page</a><br>')" onMouseOut="kwPopup.hide()"><span class="idxkeyword">Main Page</span></a></br>
<%end if%>
<%if Application("SelectMD") then%>
<a href="javascript:void(0)" onMouseOver="JavaScript:displayLink('<a href=measuredistance.aspx target=content>Measure Distance</a><br>')" onMouseOut="kwPopup.hide()"><span class="idxkeyword">Measure Distance</span></a></br>
<%end if%>
<%if Application("MetaData") then%>
<a href="javascript:void(0)" onMouseOver="JavaScript:displayLink('<a href=metadata.aspx target=content>Metadata</a><br>')" onMouseOut="kwPopup.hide()"><span class="idxkeyword">Metadata</span></a></br>
<%end if%>

     <a name="N"><br><span class="idxsection">- N -</span><br><br>
<a href="javascript:void(0)" onMouseOver="JavaScript:displayLink('<a href=thenavigatetab.aspx target=content>The Navigate Tab</a><br>')" onMouseOut="kwPopup.hide()"><span class="idxkeyword">Navigate</span></a></br>
<a href="javascript:void(0)" onMouseOver="JavaScript:displayLink('<a href=thenavigatetab.aspx target=content>The Navigate Tab</a><br>')" onMouseOut="kwPopup.hide()"><span class="idxkeyword">Navigate Tab</span></a></br>

     <a name="O"><br><span class="idxsection">- O -</span><br><br>
<a href="javascript:void(0)" onMouseOver="JavaScript:displayLink('<a href=theoverviewtab.aspx target=content>The Overview Tab</a><br>')" onMouseOut="kwPopup.hide()"><span class="idxkeyword">Overview</span></a></br>
<%if Application("OverviewMap") then%>
<a href="javascript:void(0)" onMouseOver="JavaScript:displayLink('<a href=overviewmap.aspx target=content>Overview Map</a><br>')" onMouseOut="kwPopup.hide()"><span class="idxkeyword">Overview Map</span></a></br>
<%end if%>
<a href="javascript:void(0)" onMouseOver="JavaScript:displayLink('<a href=theoverviewtab.aspx target=content>The Overview Tab</a><br>')" onMouseOut="kwPopup.hide()"><span class="idxkeyword">Overview Tab</span></a></br>

     <a name="P"><br><span class="idxsection">- P -</span><br><br>
<%if (Application("NavPan")) then%>
<a href="javascript:void(0)" onMouseOver="JavaScript:displayLink('<a href=pan.aspx target=content>Pan</a><br>')" onMouseOut="kwPopup.hide()"><span class="idxkeyword">Pan</span></a></br>
<%end if%>
<%if Application("Bookmark") or Application("Naved_Bookmarks") then%>
<a href="javascript:void(0)" onMouseOver="JavaScript:displayLink('<a href=pointslines.aspx target=content>Points &amp; Lines</a><br>')" onMouseOut="kwPopup.hide()"><span class="idxkeyword">Points &amp; Lines</span></a></br>
<a href="javascript:void(0)" onMouseOver="JavaScript:displayLink('<a href=polygons.aspx target=content>Polygons</a><br>')" onMouseOut="kwPopup.hide()"><span class="idxkeyword">Polygons</span></a></br>
<%end if%>
<%if Application("ReportPrint") then%>
<a href="javascript:void(0)" onMouseOver="JavaScript:displayLink('<a href=print.aspx target=content>Print</a><br>')" onMouseOut="kwPopup.hide()"><span class="idxkeyword">Print</span></a></br>
<%end if%>
<%if (Application("AppType")="ProjCoord") then%>
<a href="javascript:void(0)" onMouseOver="JavaScript:displayLink('<a href=navigatingtheinterface.aspx target=content>Getting Started</a><br>')" onMouseOut="kwPopup.hide()"><span class="idxkeyword">Projects</span></a></br>
<%end if%>
<%if (Application("Naved_PropertySearch")) then%>
<a href="javascript:void(0)" onMouseOver="JavaScript:displayLink('<a href=prop_candidatesearch.aspx target=content>Prop. Candidate Search</a><br>')" onMouseOut="kwPopup.hide()"><span class="idxkeyword">Prop. Candidate Search</span></a></br>
<%end if%>
<%if (Application("Naved_PropertyDetails")) then%>
<a href="javascript:void(0)" onMouseOver="JavaScript:displayLink('<a href=prop_details.aspx target=content>Prop. Details</a><br>')" onMouseOut="kwPopup.hide()"><span class="idxkeyword">Prop. Details</span></a></br>
<%end if%>
<%if (Application("Naved_PropertySearch")) then%>
<a href="javascript:void(0)" onMouseOver="JavaScript:displayLink('<a href=prop_candidatesearch.aspx target=content>Prop. Candidate Search</a><br>')" onMouseOut="kwPopup.hide()"><span class="idxkeyword">Property Candidate Search</span></a></br>
<%end if%>
<%if (Application("AppType")="EconDev") then%>
<a href="javascript:void(0)" onMouseOver="JavaScript:displayLink('<a href=zoominpropertydetails.aspx target=content>Zoom In &amp; Property Details</a><br><a href=prop_details.aspx target=content>Prop. Details</a><br>')" onMouseOut="kwPopup.hide()"><span class="idxkeyword">Property Details</span></a></br>
<%end if%>
<%if (Application("AppType")="EconDev") then%>
<a href="javascript:void(0)" onMouseOver="JavaScript:displayLink('<a href=viewphoto.aspx target=content>View Photo</a><br>')" onMouseOut="kwPopup.hide()"><span class="idxkeyword">Property Photo</span></a></br>
<%end if%>
<%if (Application("Naved_PropertySearch")) then%>
<a href="javascript:void(0)" onMouseOver="JavaScript:displayLink('<a href=propertysearch.aspx target=content>Property Search</a><br>')" onMouseOut="kwPopup.hide()"><span class="idxkeyword">Property Search</span></a></br>
<%end if%>
<%if (Application("AppType")="EconDev") then%>
<a href="javascript:void(0)" onMouseOver="JavaScript:displayLink('<a href=searchresults.aspx target=content>Search Results</a><br>')" onMouseOut="kwPopup.hide()"><span class="idxkeyword">Property Search Results</span></a></br>
<%end if%>
<%if (Application("AppType")="EconDev") then%>
<a href="javascript:void(0)" onMouseOver="JavaScript:displayLink('<a href=zoomin2.aspx target=content>Zoom In</a><br>')" onMouseOut="kwPopup.hide()"><span class="idxkeyword">Property Search Zoom In</span></a></br>
<%end if%>
<%if (Application("AppType")="EconDev") then%>
<a href="javascript:void(0)" onMouseOver="JavaScript:displayLink('<a href=proximityanalysis.aspx target=content>Proximity Analysis</a><br>')" onMouseOut="kwPopup.hide()"><span class="idxkeyword">Proximity</span></a></br>
<%end if%>
<%if (Application("AppType")="EconDev") then%>
<a href="javascript:void(0)" onMouseOver="JavaScript:displayLink('<a href=proximityanalysis.aspx target=content>Proximity Analysis</a><br>')" onMouseOut="kwPopup.hide()"><span class="idxkeyword">Proximity Analysis</span></a></br>
<%end if%>
<a href="javascript:void(0)" onMouseOver="JavaScript:displayLink('<a href=navigatingtheinterface.aspx target=content>Getting Started</a><br>')" onMouseOut="kwPopup.hide()"><span class="idxkeyword">Pull-Down Menus</span></a></br>

     <a name="R"><br><span class="idxsection">- R -</span><br><br>
<%if (Application("AppType")="ProjCoord") then%>
<a href="javascript:void(0)" onMouseOver="JavaScript:displayLink('<a href=projectreport.aspx target=content>Report</a><br>')" onMouseOut="kwPopup.hide()"><span class="idxkeyword">Report</span></a></br>
<%end if%>
<%if Application("MetaData") then%>
<a href="javascript:void(0)" onMouseOver="JavaScript:displayLink('<a href=metadata.aspx target=content>Metadata</a><br>')" onMouseOut="kwPopup.hide()"><span class="idxkeyword">Report Metadata</span></a></br>
<%end if%>
<%if Application("ReportPrint") then%>
<a href="javascript:void(0)" onMouseOver="JavaScript:displayLink('<a href=print.aspx target=content>Print</a><br>')" onMouseOut="kwPopup.hide()"><span class="idxkeyword">Report Print</span></a></br>
	<%if Application("ClientName") <> "SacCountyAssessor" then%>
	<a href="javascript:void(0)" onMouseOver="JavaScript:displayLink('<a href=thereporttab.aspx target=content>The Report Tab</a><br>')" onMouseOut="kwPopup.hide()"><span class="idxkeyword">Report Tab</span></a></br>
	<%end if%>
<%end if%>
<%if (Application("ReportUC")) then%>
<a href="javascript:void(0)" onMouseOver="JavaScript:displayLink('<a href=usercomments.aspx target=content>User Comments</a><br>')" onMouseOut="kwPopup.hide()"><span class="idxkeyword">Report User Comments</span></a></br>
<%end if%>
<%if (Application("AppType")="EconDev") then%>
<a href="javascript:void(0)" onMouseOver="JavaScript:displayLink('<a href=searchresults.aspx target=content>Search Results</a><br>')" onMouseOut="kwPopup.hide()"><span class="idxkeyword">Results</span></a></br>
<a href="javascript:void(0)" onMouseOver="JavaScript:displayLink('<a href=searchresults.aspx target=content>Search Results</a><br>')" onMouseOut="kwPopup.hide()"><span class="idxkeyword">Results List</span></a></br>
<%end if%>

     <a name="S"><br><span class="idxsection">- S -</span><br><br>
<%if Application("Bookmark") or Application("Naved_Bookmarks") then%>
<a href="javascript:void(0)" onMouseOver="JavaScript:displayLink('<a href=bookmarkdrawingtools.aspx target=content>Bookmark Drawing Tools</a><br>')" onMouseOut="kwPopup.hide()"><span class="idxkeyword">Saving Bookmarks</span></a></br>
<%end if%>
<a href="javascript:void(0)" onMouseOver="JavaScript:displayLink('<a href=thesearchtab.aspx target=content>The Search Tab</a><br>')" onMouseOut="kwPopup.hide()"><span class="idxkeyword">Search</span></a></br>
<%if Application("SearchAddress") then%>
<a href="javascript:void(0)" onMouseOver="JavaScript:displayLink('<a href=address.aspx target=content>Search Address</a><br>')" onMouseOut="kwPopup.hide()"><span class="idxkeyword">Search Address</span></a></br>
<a href="javascript:void(0)" onMouseOver="JavaScript:displayLink('<a href=searchtips.aspx target=content>Search Address Tips</a><br>')" onMouseOut="kwPopup.hide()"><span class="idxkeyword">Search Address Tips</span></a></br>
<%end if%>
<%if Application("SearchAll") then%>
<a href="javascript:void(0)" onMouseOver="JavaScript:displayLink('<a href=searchall.aspx target=content>Search All</a><br>')" onMouseOut="kwPopup.hide()"><span class="idxkeyword">Search All</span></a></br>
<%end if%>
<%if Application("SearchAPN") then%>
<a href="javascript:void(0)" onMouseOver="JavaScript:displayLink('<a href=apn.aspx target=content>Search APN</a><br>')" onMouseOut="kwPopup.hide()"><span class="idxkeyword">Search APN</span></a></br>
<a href="javascript:void(0)" onMouseOver="JavaScript:displayLink('<a href=searchtips3.aspx target=content>Search APN Tips</a><br>')" onMouseOut="kwPopup.hide()"><span class="idxkeyword">Search APN Tips</span></a></br>
<%end if%>
<%if Application("SearchIntersection") then%>
<a href="javascript:void(0)" onMouseOver="JavaScript:displayLink('<a href=intersection.aspx target=content>Search Intersection</a><br>')" onMouseOut="kwPopup.hide()"><span class="idxkeyword">Search Intersection</span></a></br>
<%end if%>
<%if Application("SearchOwner") then%>
<a href="javascript:void(0)" onMouseOver="JavaScript:displayLink('<a href=owner.aspx target=content>Search Owner</a><br>')" onMouseOut="kwPopup.hide()"><span class="idxkeyword">Search Owner</span></a></br>
<a href="javascript:void(0)" onMouseOver="JavaScript:displayLink('<a href=searchtips2.aspx target=content>Search Owner Tips</a><br>')" onMouseOut="kwPopup.hide()"><span class="idxkeyword">Search Owner Tips</span></a></br>
<%end if%>
<%if Application("AppType")="ProjCoord" then%>
<a href="javascript:void(0)" onMouseOver="JavaScript:displayLink('<a href=project.aspx target=content>Search Project</a><br>')" onMouseOut="kwPopup.hide()"><span class="idxkeyword">Search Project</span></a></br>
<%end if%>
<%if (Application("AppType")="EconDev") then%>
<a href="javascript:void(0)" onMouseOver="JavaScript:displayLink('<a href=propertysearch.aspx target=content>Property Search</a><br><a href=searchresults.aspx target=content>Search Results</a><br>')" onMouseOut="kwPopup.hide()"><span class="idxkeyword">Search Results</span></a></br>
<%end if%>
<a href="javascript:void(0)" onMouseOver="JavaScript:displayLink('<a href=thesearchtab.aspx target=content>The Search Tab</a><br>')" onMouseOut="kwPopup.hide()"><span class="idxkeyword">Search Tab</span></a></br>
<%if Application("SelectBuffer") then%>
<a href="javascript:void(0)" onMouseOver="JavaScript:displayLink('<a href=bufferselection.aspx target=content>Buffer</a><br>')" onMouseOut="kwPopup.hide()"><span class="idxkeyword">Select Buffer</span></a></br>
<%end if%>
<%if Application("SelectClear") then%>
<a href="javascript:void(0)" onMouseOver="JavaScript:displayLink('<a href=clearselection.aspx target=content>Clear</a><br>')" onMouseOut="kwPopup.hide()"><span class="idxkeyword">Select Clear</span></a></br>
<%end if%>
<%if Application("SelectIDAll") then%>
<a href="javascript:void(0)" onMouseOver="JavaScript:displayLink('<a href=identifyall.aspx target=content>Identify All</a><br>')" onMouseOut="kwPopup.hide()"><span class="idxkeyword">Select Identify All</span></a></br>
<%end if%>
<%if Application("SelectParcelID") then%>
<a href="javascript:void(0)" onMouseOver="JavaScript:displayLink('<a href=parcelidentify.aspx target=content>Identify Parcel</a><br>')" onMouseOut="kwPopup.hide()"><span class="idxkeyword">Select Identify Parcel</span></a></br>
<%end if%>
<%if Application("SelectParcelDetails") then%>
<a href="javascript:void(0)" onMouseOver="JavaScript:displayLink('<a href=parceldetails.aspx target=content>Identify Parcel Details</a><br>')" onMouseOut="kwPopup.hide()"><span class="idxkeyword">Select Identify Parcel Details</span></a></br>
<%end if%>
<%if Application("AppType")="ProjCoord" then%>
<a href="javascript:void(0)" onMouseOver="JavaScript:displayLink('<a href=identifyproject.aspx target=content>Identify Project</a><br>')" onMouseOut="kwPopup.hide()"><span class="idxkeyword">Select Identify Project</span></a></br>
<%end if%>
<%if Application("SelectMD") then%>
<a href="javascript:void(0)" onMouseOver="JavaScript:displayLink('<a href=measuredistance.aspx target=content>Measure Distance</a><br>')" onMouseOut="kwPopup.hide()"><span class="idxkeyword">Select Measure Distance</span></a></br>
<%end if%>
<a href="javascript:void(0)" onMouseOver="JavaScript:displayLink('<a href=theselecttab.aspx target=content>The Select Tab</a><br>')" onMouseOut="kwPopup.hide()"><span class="idxkeyword">Select Tab</span></a></br>
<a href="javascript:void(0)" onMouseOver="JavaScript:displayLink('<a href=sitehelp.aspx target=content>Site Help</a><br>')" onMouseOut="kwPopup.hide()"><span class="idxkeyword">Site Help</span></a></br>
<a href="javascript:void(0)" onMouseOver="JavaScript:displayLink('<a href=navigatingtheinterface.aspx target=content>Getting Started</a><br><a href=standardtoolbar.aspx target=content>Standard Toolbar</a><br>')" onMouseOut="kwPopup.hide()"><span class="idxkeyword">Standard Toolbar</span></a></br>


     <a name="T"><br><span class="idxsection">- T -</span><br><br>
<%if Application("Bookmark") or Application("Naved_Bookmarks") then%>
<a href="javascript:void(0)" onMouseOver="JavaScript:displayLink('<a href=text.aspx target=content>Text Label</a><br>')" onMouseOut="kwPopup.hide()"><span class="idxkeyword">Text Label</span></a></br>
<%end if%>
<%if (Application("AppType")="EconDev") then%>
<a href="javascript:void(0)" onMouseOver="JavaScript:displayLink('<a href=enhancedtoolbar.aspx target=content>Enhanced Toolbar</a><br>')" onMouseOut="kwPopup.hide()"><span class="idxkeyword">Toolbar - Enhanced</span></a></br>
<%end if%>
<a href="javascript:void(0)" onMouseOver="JavaScript:displayLink('<a href=standardtoolbar.aspx target=content>Standard Toolbar</a><br>')" onMouseOut="kwPopup.hide()"><span class="idxkeyword">Toolbar - Standard</span></a></br>

     <a name="U"><br><span class="idxsection">- U -</span><br><br>
<%if (Application("ReportUC")) then%>
<a href="javascript:void(0)" onMouseOver="JavaScript:displayLink('<a href=usercomments.aspx target=content>User Comments</a><br>')" onMouseOut="kwPopup.hide()"><span class="idxkeyword">User Comments</span></a></br>
<%end if%>

     <a name="V"><br><span class="idxsection">- V -</span><br><br>
<%if (Application("AppType")="EconDev") then%>
<a href="javascript:void(0)" onMouseOver="JavaScript:displayLink('<a href=viewphoto.aspx target=content>View Photo</a><br>')" onMouseOut="kwPopup.hide()"><span class="idxkeyword">View Photo</span></a></br>
<%end if%>

     <a name="Z"><br><span class="idxsection">- Z -</span><br><br>
<%if (Application("NavZoomIn")) then%>
<a href="javascript:void(0)" onMouseOver="JavaScript:displayLink('<a href=zoomin.aspx target=content>Zoom In</a><br>')" onMouseOut="kwPopup.hide()"><span class="idxkeyword">Zoom In</span></a></br>
<%end if%>
<%if (Application("AppType")="EconDev") then%>
<a href="javascript:void(0)" onMouseOver="JavaScript:displayLink('<a href=zoominpropertydetails.aspx target=content>Zoom In &amp; Property Details</a><br>')" onMouseOut="kwPopup.hide()"><span class="idxkeyword">Zoom In &amp; Property Details</span></a></br>
<%end if%>
<%if (Application("NavZoomLast")) then%>
<a href="javascript:void(0)" onMouseOver="JavaScript:displayLink('<a href=zoomlast.aspx target=content>Zoom Last</a><br>')" onMouseOut="kwPopup.hide()"><span class="idxkeyword">Zoom Last</span></a></br>
<%end if%>
<%if (Application("NavZoomOut")) then%>
<a href="javascript:void(0)" onMouseOver="JavaScript:displayLink('<a href=zoomout.aspx target=content>Zoom Out</a><br>')" onMouseOut="kwPopup.hide()"><span class="idxkeyword">Zoom Out</span></a></br>
<%end if%>



</BODY>
</HTML>

