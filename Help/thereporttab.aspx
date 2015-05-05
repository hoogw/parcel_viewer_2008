<%@ Page %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
   <TITLE>The <%if Application("ClientName")="SacCountyAssessor" then%>Comment<%else%>Report<%end if%> Tab</TITLE>
   <meta name="generator" content="Help & Manual">
   <meta name="keywords" content="Report Tab">
</HEAD>


  <!-- Redirect browser to index page if page is not in the content frame.
       This script is only valid for regular HTML export -->
  <script language='JavaScript' type='text/javascript'>
       <!--
           if(top.frames.length==0) top.location.href='index.aspx?thereporttab.aspx'
       //-->
  </script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>


<BODY bgcolor="#FAE285" link=blue alink=blue vlink=blue>


<TABLE width="100%" border="0" cellspacing="0" cellpadding="2" bgcolor="#0080C0">
  <TR>
    <TD align="left">
      
<span style="font-family:Helvetica,Arial; font-size:12pt; color:#000000"><b>The <%if Application("ClientName")="SacCountyAssessor" then%>Comment<%else%>Report<%end if%> Tab</b><b>
<br>
</b></span>
    </TD>
    <TD align="right">
     <FONT face="Arial" size="2">
     <a href="javaScript:parent.reDisplay('1',1,0)">Top</a>&nbsp;
     <a href="javaScript:parent.reDisplay('2.4.7',1,0)">Previous</a>&nbsp;
     <a href="javaScript:parent.reDisplay('2.5.1',1,0)">Next</a>
     </FONT>
    </TD>
  </TR>
</TABLE>
<br>


<span style="font-family:Helvetica,Arial; font-size:10pt; color:#000000"><img src="geopriselogo.jpg" width="260" height="50" border="0" alt="geopriselogo">
<br>
<span style="font-family:Helvetica,Arial; font-size:1pt; color:#000000"><hr></span><span style="font-family:Helvetica,Arial; font-size:10pt; color:#000000">
<br>
The <%if Application("ClientName")="SacCountyAssessor" then%>Comment<%else%>Report<%end if%> tab is the fifth of the Application Tabs located at the top left of the main GeoPrise.NET application window.  
It consists of the following drop down menu selection: 
<%if (Application("ReportPrint")) then%><a href=javaScript:parent.reDisplay('2.5.2',1,0)>Print</a> <%end if%>
<%if (Application("MetaData")) then%><a href=javaScript:parent.reDisplay('2.5.1',1,0)>Metadata</a> <%end if%>
<%if (Application("Report")) then%><a href=javaScript:parent.reDisplay('2.5.3',1,0)>Report</a> <%end if%>
<%if (Application("ReportUC")) then%><a href=javaScript:parent.reDisplay('2.5.4',1,0)>User Comments</a> <%end if%>
<%if (Application("AppType")="ProjCoord") then%><a href=projectreport.aspx>Project Report</a> <%end if%>.
These tools are explained in detail in the next sections.
<br>

<br>
<img src="../images/1tab_reports.gif"><br>
<img src="../images/1menu_top.gif"><br>
<%if (Application("MetaData")) then%>
<img src="../images/1m_Metadata.gif"><br>
<%end if%>
<%if (Application("ReportPrint")) then%>
<img src="../images/1m_Print.gif"><br>
<%end if%>
<%if (Application("Report")) then%>
<img src="../images/1m_Report.gif"><br>
<%end if%>
<%if (Application("ReportUC")) then%>
<img src="../images/1m_UserComments.gif"><br>
<%end if%>
<%if (Application("AppType")="ProjCoord") then%>
<img src="../images/1m_Report.gif"><br>
<%end if%>
<img src="../images/1menu_bottom.gif"><br>

<br>
</span></span></span>

</BODY>
</HTML>
