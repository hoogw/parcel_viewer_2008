<%@ Page %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
   <TITLE>The Navigate Tab</TITLE>
   <meta name="generator" content="Help & Manual">
   <meta name="keywords" content="Navigate Tab,Navigate">
</HEAD>


  <!-- Redirect browser to index page if page is not in the content frame.
       This script is only valid for regular HTML export -->
  <script language='JavaScript' type='text/javascript'>
       <!--
           if(top.frames.length==0) top.location.href='index.aspx?thenavigatetab.aspx'
       //-->
  </script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>


<BODY bgcolor="#FAE285" link=blue alink=blue vlink=blue>


<TABLE width="100%" border="0" cellspacing="0" cellpadding="2" bgcolor="#0080C0">
  <TR>
    <TD align="left">
      
<span style="font-family:Helvetica,Arial; font-size:12pt; color:#000000"><b>The Navigate Tab</b><b>
<br>
</b></span>
    </TD>
    <TD align="right">
     <FONT face="Arial" size="2">
     <a href="javaScript:parent.reDisplay('1',1,0)">Top</a>&nbsp;
     <a href="javaScript:parent.reDisplay('2.1.6.3.4',1,0)">Previous</a>&nbsp;
     <a href="javaScript:parent.reDisplay('2.2.1',1,0)">Next</a>
     </FONT>
    </TD>
  </TR>
</TABLE>
<br>


<span style="font-family:Helvetica,Arial; font-size:10pt; color:#000000"><img src="geopriselogo.jpg" width="260" height="50" border="0" alt="geopriselogo">
<br>
<span style="font-family:Helvetica,Arial; font-size:1pt; color:#000000"><hr></span><span style="font-family:Helvetica,Arial; font-size:10pt; color:#000000">
<br>
The Navigate tab is the second of the Application Tabs located at the top left of the main GeoPrise.NET application window.  
It consists of the following drop down menu selections:  
<%if (Application("NavZoomIn")) then%><a href=javaScript:parent.reDisplay('2.2.1',1,0)>Zoom In</a> <%end if%>
<%if (Application("NavZoomOut")) then%><a href=javaScript:parent.reDisplay('2.2.2',1,0)>Zoom Out</a> <%end if%>
<%if (Application("NavZoomLast")) then%><a href=javaScript:parent.reDisplay('2.2.3',1,0)>Zoom Last</a> <%end if%>
<%if (Application("NavFullExt")) then%><a href=javaScript:parent.reDisplay('2.2.4',1,0)>Full Extent</a> <%end if%>
<%if (Application("NavPan")) then%><a href=javaScript:parent.reDisplay('2.2.5',1,0)>Pan</a> <%end if%>.
These tools are explained in detail in the next sections.
<br>

<br>
<img src="../images/1tab_reports.gif"><br>
<img src="../images/1menu_top.gif"><br>
<%if (Application("NavFullExt")) then%>
	<img src="../images/1m_FullExtent.gif"><br>
<%end if%>
<%if (Application("NavZoomIn")) then%>
	<img src="../images/1m_zoomin.gif"><br>
<%end if%>
<%if (Application("NavZoomOut")) then%>
	<img src="../images/1m_zoomout.gif"><br>
<%end if%>
<%if (Application("NavZoomLast")) then%>
	<img src="../images/1m_zoomlast.gif"><br>
<%end if%>
<%if (Application("NavPan")) then%>
	<img src="../images/1m_pan.gif"><br>
<%end if%>
<img src="../images/1menu_bottom.gif"><br>
<br>

<br>
</span></span></span>

</BODY>
</HTML>
