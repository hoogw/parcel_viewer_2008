<%@ Page %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
   <TITLE>The Search Tab</TITLE>
   <meta name="generator" content="Help & Manual">
   <meta name="keywords" content="Search Tab,Search">
</HEAD>


  <!-- Redirect browser to index page if page is not in the content frame.
       This script is only valid for regular HTML export -->
  <script language='JavaScript' type='text/javascript'>
       <!--
           if(top.frames.length==0) top.location.href='index.aspx?thesearchtab.aspx'
       //-->
  </script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>


<BODY bgcolor="#FAE285" link=blue alink=blue vlink=blue>


<TABLE width="100%" border="0" cellspacing="0" cellpadding="2" bgcolor="#0080C0">
  <TR>
    <TD align="left">
      
<span style="font-family:Helvetica,Arial; font-size:12pt; color:#000000"><b>The Search Tab</b><b>
<br>
</b></span>
    </TD>
    <TD align="right">
     <FONT face="Arial" size="2">
     <a href="javaScript:parent.reDisplay('1',1,0)">Top</a>&nbsp;
     <a href="javaScript:parent.reDisplay('2.2.5',1,0)">Previous</a>&nbsp;
     <a href="javaScript:parent.reDisplay('2.3.1',1,0)">Next</a>
     </FONT>
    </TD>
  </TR>
</TABLE>
<br>


<span style="font-family:Helvetica,Arial; font-size:10pt; color:#000000"><img src="geopriselogo.jpg" width="260" height="50" border="0" alt="geopriselogo">
<br>
<span style="font-family:Helvetica,Arial; font-size:1pt; color:#000000"><hr></span><span style="font-family:Helvetica,Arial; font-size:10pt; color:#000000">
<br>
The Search tab is the third of the Application Tabs located at the top left of the main GeoPrise.NET application window.  
It consists of the following drop down menu selections:  
<%if (Application("SearchAll")) then%><a href=javaScript:parent.reDisplay('2.3.1',1,0)>Search All</a> <%end if%>
<%if (Application("SearchAddress")) then%><a href=javaScript:parent.reDisplay('2.3.2',1,0)>Search Address</a> <%end if%>
<%if (Application("SearchOwner")) then%><a href=javaScript:parent.reDisplay('2.3.3',1,0)>Search Owner</a> <%end if%>
<%if (Application("SearchAPN")) then%><a href=javaScript:parent.reDisplay('2.3.4',1,0)>Search APN</a> <%end if%>
<%if (Application("SearchIntersection")) then%><a href=javaScript:parent.reDisplay('2.3.6',1,0)>Search Intersection</a> <%end if%>
<%if (Application("AppType")="ProjCoord") then%><a href=project.aspx>Search Project</a> <%end if%>.
These tools are explained in detail in the next sections.
<br>

<br>
<img src="../images/1tab_search.gif"><br>
<img src="../images/1menu_top.gif"><br>
<%if (Application("SearchAll")) then%>
	<img src="../images/1m_SearchAll.gif"><br>
<%end if%>
<%if (Application("SearchAddress")) then%>
	<img src="../images/1m_SearchAddress.gif"><br>
<%end if%>
<%if (Application("SearchOwner")) then%>
	<img src="../images/1m_SearchOwner.gif"><br>
<%end if%>
<%if (Application("SearchAPN")) then%>
	<img src="../images/1m_SearchAPN.gif"><br>
<%end if%>
<%if (Application("SearchLandMark")) then%>
	<img src="../images/1m_Landmark.gif"><br>
<%end if%>
<%if (Application("SearchIntersection")) then%>
	<img src="../images/1m_SearchIntersection.gif"><br>
<%end if%>
<%if (Application("AppType")="ProjCoord") then%>
	<img src="../images/1m_SearchProject.gif"><br>
<%end if%>
<img src="../images/1menu_bottom.gif"><br>

<br>

<br>
</span></span></span>

</BODY>
</HTML>
