<%@ Page %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
<TITLE>GeoPrise.NET Help</TITLE>
<script language='JavaScript' type='text/javascript'>

var tocTab = new Array();var ir=0;
tocTab[ir++] = new Array ("1", "Welcome to GeoPrise.NET", "welcometogeoprise_net.aspx", "", "cicon1.gif", "cicon2.gif");
tocTab[ir++] = new Array ("1.1", "Getting Started", "navigatingtheinterface.aspx", "", "cicon11.gif", "cicon11.gif");
tocTab[ir++] = new Array ("2", "Application Tabs", "", "", "cicon1.gif", "cicon2.gif");
tocTab[ir++] = new Array ("2.1", "The Overview Tab", "theoverviewtab.aspx", "", "cicon1.gif", "cicon2.gif");
<%if Application("OverviewCoords") then%>tocTab[ir++] = new Array ("2.1.1", "Coordinates", "coordinates.aspx", "", "cicon11.gif", "cicon11.gif");<%end if%>
<%if Application("OverviewMap") then%>tocTab[ir++] = new Array ("2.1.2", "Overview Map", "overviewmap.aspx", "", "cicon11.gif", "cicon11.gif");<%end if%>
<%if Application("OverviewLayers") then%>tocTab[ir++] = new Array ("2.1.3", "Layers", "layers.aspx", "", "cicon11.gif", "cicon11.gif");<%end if%>
<%if Application("OverviewLegend") then%>tocTab[ir++] = new Array ("2.1.4", "Legend", "legend.aspx", "", "cicon11.gif", "cicon11.gif");<%end if%>
<%if Application("AppType")="ProjCoord" then%>tocTab[ir++] = new Array ("2.1.5", "Display Options", "displayoptions.aspx", "", "cicon11.gif", "cicon11.gif");<%end if%>
<%if Application("Bookmark") or Application("Naved_Bookmarks") then%>tocTab[ir++] = new Array ("2.1.6", "Bookmarks", "bookmarks.aspx", "", "cicon1.gif", "cicon2.gif");<%end if%>
<%if Application("Bookmark") or Application("Naved_Bookmarks") then%>tocTab[ir++] = new Array ("2.1.6.1", "Create Bookmark", "createbookmark.aspx", "", "cicon11.gif", "cicon11.gif");<%end if%>
<%if Application("Bookmark") or Application("Naved_Bookmarks") then%>tocTab[ir++] = new Array ("2.1.6.2", "Delete Bookmark", "deletebookmark.aspx", "", "cicon11.gif", "cicon11.gif");<%end if%>
<%if Application("Bookmark") or Application("Naved_Bookmarks") then%>tocTab[ir++] = new Array ("2.1.6.3", "Bookmark Drawing Tools", "bookmarkdrawingtools.aspx", "", "cicon1.gif", "cicon2.gif");<%end if%>
<%if Application("Bookmark") or Application("Naved_Bookmarks") then%>tocTab[ir++] = new Array ("2.1.6.3.1", "Points &amp; Lines", "pointslines.aspx", "", "cicon11.gif", "cicon11.gif");<%end if%>
<%if Application("Bookmark") or Application("Naved_Bookmarks") then%>tocTab[ir++] = new Array ("2.1.6.3.2", "Polygons", "polygons.aspx", "", "cicon11.gif", "cicon11.gif");<%end if%>
<%if Application("Bookmark") or Application("Naved_Bookmarks") then%>tocTab[ir++] = new Array ("2.1.6.3.3", "Circles &amp; Buffers", "circlesbuffers.aspx", "", "cicon11.gif", "cicon11.gif");<%end if%>
<%if Application("Bookmark") or Application("Naved_Bookmarks") then%>tocTab[ir++] = new Array ("2.1.6.3.4", "Text Label", "text.aspx", "", "cicon11.gif", "cicon11.gif");<%end if%>
tocTab[ir++] = new Array ("2.2", "The Navigate Tab", "thenavigatetab.aspx", "", "cicon1.gif", "cicon2.gif");
<%if Application("NavZoomIn") then%>tocTab[ir++] = new Array ("2.2.1", "Zoom In", "zoomin.aspx", "", "cicon11.gif", "cicon11.gif");<%end if%>
<%if Application("NavZoomOut") then%>tocTab[ir++] = new Array ("2.2.2", "Zoom Out", "zoomout.aspx", "", "cicon11.gif", "cicon11.gif");<%end if%>
<%if Application("NavZoomLast") then%>tocTab[ir++] = new Array ("2.2.3", "Zoom Last", "zoomlast.aspx", "", "cicon11.gif", "cicon11.gif");<%end if%>
<%if Application("NavFullExt") then%>tocTab[ir++] = new Array ("2.2.4", "Full Extent", "fullextent.aspx", "", "cicon11.gif", "cicon11.gif");<%end if%>
<%if Application("NavPan") then%>tocTab[ir++] = new Array ("2.2.5", "Pan", "pan.aspx", "", "cicon11.gif", "cicon11.gif");<%end if%>
tocTab[ir++] = new Array ("2.3", "The Search Tab", "thesearchtab.aspx", "", "cicon1.gif", "cicon2.gif");
<%if Application("SearchAll") then%>tocTab[ir++] = new Array ("2.3.1", "Search All", "searchall.aspx", "", "cicon1.gif", "cicon2.gif");<%end if%>
<%if Application("SearchAddress") then%>tocTab[ir++] = new Array ("2.3.2", "Search Address", "address.aspx", "", "cicon1.gif", "cicon2.gif");<%end if%>
<%if Application("SearchAddress") then%>tocTab[ir++] = new Array ("2.3.2.1", "Search Address Tips", "searchtips.aspx", "", "cicon11.gif", "cicon11.gif");<%end if%>
<%if Application("SearchOwner") then%>tocTab[ir++] = new Array ("2.3.3", "Search Owner", "owner.aspx", "", "cicon1.gif", "cicon2.gif");<%end if%>
<%if Application("SearchOwner") then%>tocTab[ir++] = new Array ("2.3.3.1", "Search Owner Tips", "searchtips2.aspx", "", "cicon11.gif", "cicon11.gif");<%end if%>
<%if Application("SearchAPN") then%>tocTab[ir++] = new Array ("2.3.4", "Search APN", "apn.aspx", "", "cicon1.gif", "cicon2.gif");<%end if%>
<%if Application("SearchAPN") then%>tocTab[ir++] = new Array ("2.3.4.1", "Search APN Tips", "searchtips3.aspx", "", "cicon11.gif", "cicon11.gif");<%end if%>
<%if Application("SearchLandMark") then%>tocTab[ir++] = new Array ("2.3.5", "Landmark", "landmark.aspx", "", "cicon11.gif", "cicon11.gif");<%end if%>
<%if Application("SearchIntersection") then%>tocTab[ir++] = new Array ("2.3.6", "Search Intersection", "intersection.aspx", "", "cicon11.gif", "cicon11.gif");<%end if%>
<%if Application("AppType")="ProjCoord" then%>tocTab[ir++] = new Array ("2.3.7", "Search Project", "project.aspx", "", "cicon11.gif", "cicon11.gif");<%end if%>
tocTab[ir++] = new Array ("2.4", "The Select Tab", "theselecttab.aspx", "", "cicon1.gif", "cicon2.gif");
<%if Application("SelectIDAll") then%>tocTab[ir++] = new Array ("2.4.1", "Identify All", "identifyall.aspx", "", "cicon11.gif", "cicon11.gif");<%end if%>
<%if Application("AppType")="ProjCoord" then%>tocTab[ir++] = new Array ("2.4.2", "Identify Project", "identifyproject.aspx", "", "cicon11.gif", "cicon11.gif");<%end if%>
<%if Application("SelectParcelID") then%>tocTab[ir++] = new Array ("2.4.3", "Identify Parcel", "parcelidentify.aspx", "", "cicon11.gif", "cicon11.gif");<%end if%>
<%if Application("SelectParcelDetails") then%>tocTab[ir++] = new Array ("2.4.4", "Identify Parcel Details", "parceldetails.aspx", "", "cicon11.gif", "cicon11.gif");<%end if%>
<%if Application("SelectBuffer") then%>tocTab[ir++] = new Array ("2.4.5", "Buffer", "bufferselection.aspx", "", "cicon11.gif", "cicon11.gif");<%end if%>
<%if Application("SelectMD") then%>tocTab[ir++] = new Array ("2.4.6", "Measure Distance", "measuredistance.aspx", "", "cicon11.gif", "cicon11.gif");<%end if%>
<%if Application("SelectClear") then%>tocTab[ir++] = new Array ("2.4.7", "Clear", "clearselection.aspx", "", "cicon11.gif", "cicon11.gif");<%end if%>
tocTab[ir++] = new Array ("2.5", "The <%if Application("ClientName") = "SacCountyAssessor" then%>Comment<%else%>Report<%end if%> Tab", "thereporttab.aspx", "", "cicon1.gif", "cicon2.gif");
<%if Application("MetaData") then%>tocTab[ir++] = new Array ("2.5.1", "Metadata", "metadata.aspx", "", "cicon11.gif", "cicon11.gif");<%end if%>
<%if Application("ReportPrint") then%>tocTab[ir++] = new Array ("2.5.2", "Print", "print.aspx", "", "cicon11.gif", "cicon11.gif");<%end if%>
<%if Application("Report") then%>tocTab[ir++] = new Array ("2.5.3", "Report", "projectreport.aspx", "", "cicon11.gif", "cicon11.gif");<%end if%>
<%if Application("ReportUC") then%>tocTab[ir++] = new Array ("2.5.4", "User Comments", "usercomments.aspx", "", "cicon11.gif", "cicon11.gif");<%end if%>
tocTab[ir++] = new Array ("2.6", "The Help Tab", "thehelptab.aspx", "", "cicon1.gif", "cicon2.gif");
<%if 1 then%>tocTab[ir++] = new Array ("2.6.1", "Site Help", "sitehelp.aspx", "", "cicon11.gif", "cicon11.gif");<%end if%>
<%if 1 then%>tocTab[ir++] = new Array ("2.6.2", "About", "about.aspx", "", "cicon11.gif", "cicon11.gif");<%end if%>
<%if Application("AppType")="EconDev" then%>tocTab[ir++] = new Array ("3", "The Economic Development Tab", "theeconomicdevelopmenttab.aspx", "", "cicon1.gif", "cicon2.gif");<%end if%>
<%if 1 then%>tocTab[ir++] = new Array ("3.1", "Enhanced Toolbar", "enhancedtoolbar.aspx", "", "cicon11.gif", "cicon11.gif");<%end if%>
<%if Application("Naved_MainPage") then%>tocTab[ir++] = new Array ("3.2", "Main Page", "mainpage.aspx", "", "cicon11.gif", "cicon11.gif");<%end if%>
<%if Application("Naved_PropertySearch") then%>tocTab[ir++] = new Array ("3.3", "Property Search", "propertysearch.aspx", "", "cicon1.gif", "cicon2.gif");<%end if%>
<%if Application("Naved_PropertySearch") then%>tocTab[ir++] = new Array ("3.3.1", "Search Results", "searchresults.aspx", "", "cicon1.gif", "cicon2.gif");<%end if%>
<%if Application("Naved_PropertySearch") then%>tocTab[ir++] = new Array ("3.3.1.1", "Zoom In", "zoomin2.aspx", "", "cicon11.gif", "cicon11.gif");<%end if%>
<%if Application("Naved_PropertySearch") then%>tocTab[ir++] = new Array ("3.3.1.2", "Zoom In &amp; Property Details", "zoominpropertydetails.aspx", "", "cicon1.gif", "cicon2.gif");<%end if%>
<%if Application("Naved_PropertySearch") then%>tocTab[ir++] = new Array ("3.3.1.2.1", "Demographic Report", "demographicreport.aspx", "", "cicon11.gif", "cicon11.gif");<%end if%>
<%if Application("Naved_PropertySearch") then%>tocTab[ir++] = new Array ("3.3.1.2.2", "Business Report", "businessreport.aspx", "", "cicon11.gif", "cicon11.gif");<%end if%>
<%if Application("Naved_PropertySearch") then%>tocTab[ir++] = new Array ("3.3.1.2.3", "Proximity Analysis", "proximityanalysis.aspx", "", "cicon11.gif", "cicon11.gif");<%end if%>
<%if Application("Naved_PropertySearch") then%>tocTab[ir++] = new Array ("3.3.1.3", "Brokerage Information", "brokerinformation.aspx", "", "cicon11.gif", "cicon11.gif");<%end if%>
<%if Application("Naved_PropertySearch") then%>tocTab[ir++] = new Array ("3.3.1.4", "View Photo", "viewphoto.aspx", "", "cicon11.gif", "cicon11.gif");<%end if%>
<%if Application("Naved_PropCandidateList") then%>tocTab[ir++] = new Array ("3.4", "Prop. Candidate Search", "prop_candidatesearch.aspx", "", "cicon11.gif", "cicon11.gif");<%end if%>
<%if Application("Naved_PropertyDetails") then%>tocTab[ir++] = new Array ("3.5", "Prop. Details", "prop_details.aspx", "", "cicon11.gif", "cicon11.gif");<%end if%>
<%if Application("Naved_Geoanalysis") then%>tocTab[ir++] = new Array ("3.6", "GeoAnalysis", "geoanalysis.aspx", "", "cicon11.gif", "cicon11.gif");<%end if%>
<%if Application("Naved_DataManagement") then%>tocTab[ir++] = new Array ("3.7", "Data Management", "datamanagement.aspx", "", "cicon11.gif", "cicon11.gif");<%end if%>
<%if Application("Naved_Bookmarks") then%>tocTab[ir++] = new Array ("3.8", "Bookmarks", "bookmarks2.aspx", "", "cicon11.gif", "cicon11.gif");<%end if%>
<%if Application("AppType")="ProjCoord" then%>tocTab[ir++] = new Array ("4", "Administration Utility", "administrationutility.aspx", "", "cicon1.gif", "cicon2.gif");<%end if%>
<%if Application("AppType")="BaseApp" then%>tocTab[ir++] = new Array ("5", "Standard Toolbar", "standardtoolbar.aspx", "", "cicon1.gif", "cicon2.gif");<%end if%>
</script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>
<script language='JavaScript' type='text/javascript' src="geoprisepc_content.js"></script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>
</HEAD>
<frameset cols="20%,*"
          frameborder="1"
          framespacing="1"
          border="1"
          onload="reDisplay('',1,0,0);">
<frame name="toc"
       src="about:blank">
<frame name="content"
       src="about:blank">
		<NOFRAMES>
			Your Browser does not support frames!
		</NOFRAMES>
</frameset>
</HTML>
