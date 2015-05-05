<%@ Page %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
   <TITLE>The Overview Tab</TITLE>
   <meta name="generator" content="Help & Manual">
   <meta name="keywords" content="Overview,Overview Tab">
</HEAD>


  <!-- Redirect browser to index page if page is not in the content frame.
       This script is only valid for regular HTML export -->
  <script language='JavaScript' type='text/javascript'>
       <!--
           if(top.frames.length==0) top.location.href='index.aspx?theoverviewtab.aspx'
       //-->
  </script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>


<BODY bgcolor="#FAE285" link=blue alink=blue vlink=blue>


<TABLE width="100%" border="0" cellspacing="0" cellpadding="2" bgcolor="#0080C0">
  <TR>
    <TD align="left">
      
<span style="font-family:Helvetica,Arial; font-size:12pt; color:#000000"><b>The Overview Tab</b><b>
<br>
</b></span>
    </TD>
    <TD align="right">
     <FONT face="Arial" size="2">
     <a href="javaScript:parent.reDisplay('1',1,0)">Top</a>&nbsp;
     <a href="javaScript:parent.reDisplay('1.1',1,0)">Previous</a>&nbsp;
     <a href="javaScript:parent.reDisplay('2.1.1',1,0)">Next</a>
     </FONT>
    </TD>
  </TR>
</TABLE>
<br>


<span style="font-family:Helvetica,Arial; font-size:10pt; color:#000000"><img src="geopriselogo.jpg" width="260" height="50" border="0" alt="geopriselogo">
<br>
<span style="font-family:Helvetica,Arial; font-size:1pt; color:#000000"><hr></span><span style="font-family:Helvetica,Arial; font-size:10pt; color:#000000">
<br>
The Overview tab is the first of the Application Tabs located at the top left of the main GeoPrise.NET application window.  
It consists of the following drop down menu selections:  
<%if (Application("OverviewCoords")) then%><a href=javaScript:parent.reDisplay('2.1.1',1,0)>Coordinates</a> <%end if%>
<%if (Application("OverviewMap")) then%><a href=javaScript:parent.reDisplay('2.1.2',1,0)>Overview Map</a> <%end if%>
<%if (Application("OverviewLayers")) then%><a href=javaScript:parent.reDisplay('2.1.3',1,0)>Layers</a> <%end if%>
<%if (Application("OverviewLegend")) then%><a href=javaScript:parent.reDisplay('2.1.4',1,0)>Legend</a> <%end if%>
<%if (Application("Bookmark")) then%><a href=javaScript:parent.reDisplay('2.1.6',1,0)>Bookmarks</a> <%end if%>
<%if (Application("AppType")="ProjCoord") then%><a href="displayoptions.aspx">Display Options</a><%end if%>.
These tools are explained in detail in the following sections.
<br>

<br>

<br>
<img src="../images/1tab_overview.gif"><br>
<img src="../images/1menu_top.gif"><br>
<%if (Application("OverviewCoords")) then%><img src="../images/1m_Coordinates.gif"><br><%end if%>
<%if (Application("OverviewMap")) then%><img src="../images/1m_OverviewMap.gif"><br><%end if%>
<%if (Application("OverviewLayers")) then%><img src="../images/1m_layers.gif"><br><%end if%>
<%if (Application("OverviewLegend")) then%><img src="../images/1m_Legend.gif"><br><%end if%>
<%if (Application("Bookmark")) then%><img src="../images/1m_Bookmark.gif"><br><%end if%>
<%if (Application("AppType")="ProjCoord") then%><img src="../images/1m_displayoptions.gif"><br><%end if%>
<img src="../images/1menu_bottom.gif"><br>

<br>
</span></span></span>

</BODY>
</HTML>
