<%@ Page %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
   <TITLE>The Select Tab</TITLE>
   <meta name="generator" content="Help & Manual">
   <meta name="keywords" content="Select Tab">
</HEAD>


  <!-- Redirect browser to index page if page is not in the content frame.
       This script is only valid for regular HTML export -->
  <script language='JavaScript' type='text/javascript'>
       <!--
           if(top.frames.length==0) top.location.href='index.aspx?theselecttab.aspx'
       //-->
  </script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>


<BODY bgcolor="#FAE285" link=blue alink=blue vlink=blue>


<TABLE width="100%" border="0" cellspacing="0" cellpadding="2" bgcolor="#0080C0">
  <TR>
    <TD align="left">
      
<span style="font-family:Helvetica,Arial; font-size:12pt; color:#000000"><b>The Select Tab</b><b>
<br>
</b></span>
    </TD>
    <TD align="right">
     <FONT face="Arial" size="2">
     <a href="javaScript:parent.reDisplay('1',1,0)">Top</a>&nbsp;
     <a href="javaScript:parent.reDisplay('2.3.7',1,0)">Previous</a>&nbsp;
     <a href="javaScript:parent.reDisplay('2.4.1',1,0)">Next</a>
     </FONT>
    </TD>
  </TR>
</TABLE>
<br>


<span style="font-family:Helvetica,Arial; font-size:10pt; color:#000000"><img src="geopriselogo.jpg" width="260" height="50" border="0" alt="geopriselogo">
<br>
<span style="font-family:Helvetica,Arial; font-size:1pt; color:#000000"><hr></span><span style="font-family:Helvetica,Arial; font-size:10pt; color:#000000">
<br>
The Select tab is the fourth of the Application Tabs located at the top left of the main GeoPrise.NET application window.  
It consists of the following drop down menu selections:  
<%if (Application("SelectIDAll")) then%><a href=javaScript:parent.reDisplay('2.4.1',1,0)>Identify All</a> <%end if%>
<%if (Application("AppType")="ProjCoord") then%><a href=identifyproject.aspx>Identify Project</a> <%end if%>
<%if (Application("SelectParcelID")) then%><a href=javaScript:parent.reDisplay('2.4.3',1,0)>Identify Parcel</a> <%end if%>
<%if (Application("SelectParcelDetails")) then%><a href=javaScript:parent.reDisplay('2.4.4',1,0)>Identify Parcel Details</a> <%end if%>
<%if (Application("SelectBuffer")) then%><a href=javaScript:parent.reDisplay('2.4.5',1,0)>Buffer</a> <%end if%>
<%if (Application("SelectMD")) then%><a href=javaScript:parent.reDisplay('2.4.6',1,0)>Measure Distance</a> <%end if%>
<%if (Application("SelectClear")) then%><a href=javaScript:parent.reDisplay('2.4.7',1,0)>Clear</a> <%end if%>.
These tools are explained in detail in the next sections.
<br>

<br>
<img src="../images/1tab_select.gif"><br>
<img src="../images/1menu_top.gif"><br>
<%if (Application("SelectIDAll")) then%>
<img src="../images/1m_IDAll.gif"><br>
<%end if%>
<%if (Application("AppType")="ProjCoord") then%>
	<img src="../images/1m_IDProject.gif"><br>
<%end if%>
<%if (Application("SelectParcelID")) then%>
	<img src="../images/1m_IDParcel.gif"><br>
<%end if%>
<%if (Application("SelectParcelDetails")) then%>
	<img src="../images/1m_IDParcelDetails.gif"><br>
<%end if%>
<%if (Application("SelectBuffer")) then%>
	<img src="../images/1m_Buffer.gif"><br>
<%end if%>
<%if (Application("SelectMD")) then%>
	<img src="../images/1m_MeasureDistance.gif"><br>
<%end if%>
<%if (Application("SelectClear")) then%>
	<img src="../images/1m_clear.gif"><br>
<%end if%>
<img src="../images/1menu_bottom.gif"><br>

<br>

<br>
</span></span></span>

</BODY>
</HTML>
