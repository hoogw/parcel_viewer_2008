<%@ Page %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<TITLE>Getting Started</TITLE>
		<meta name="generator" content="Help &amp; Manual">
		<meta name="keywords" content="Projects,Administration Utility,Standard Toolbar,Buttons ,Application Tabs,Pull-Down Menus">
		<!-- Redirect browser to index page if page is not in the content frame.
       This script is only valid for regular HTML export -->
		<script language='JavaScript' type='text/javascript'>
       <!--
           if(top.frames.length==0) top.location.href='index.aspx?navigatingtheinterface.aspx'
       //-->
		</script>
		<noscript>
	</HEAD>
	<BODY vLink="blue" aLink="blue" link="blue" bgColor="#fae285">
		<b>Javascript MUST be enabled on your browser</b></NOSCRIPT>
		<TABLE width="100%" border="0" cellspacing="0" cellpadding="2" bgcolor="#0080c0">
			<TR>
				<TD align="left">
					<span style="FONT-SIZE:12pt; COLOR:#000000; FONT-FAMILY:Helvetica,Arial">
						<b>Getting Started</b><b>
							<br>
						</b>
					</span>
				</TD>
				<TD align="right">
					<FONT face="Arial" size="2"><a href="javaScript:parent.reDisplay('1',1,0)">Top</a>&nbsp;
						<a href="javaScript:parent.reDisplay('1',1,0)">Previous</a>&nbsp; <a href="javaScript:parent.reDisplay('2.1',1,0)">
							Next</a> </FONT>
				</TD>
			</TR>
		</TABLE>
		<br>
		<span style="FONT-SIZE:10pt; COLOR:#000000; FONT-FAMILY:Helvetica,Arial">
			<img src="geopriselogo.jpg" width="260" height="50" border="0" alt="geopriselogo">
			<br>
			<span style="FONT-SIZE:1pt; COLOR:#000000; FONT-FAMILY:Helvetica,Arial">
				<hr>
			</span>
			<span style="FONT-SIZE:10pt; COLOR:#000000; FONT-FAMILY:Helvetica,Arial">
				<br>
			</span>
			<span style="FONT-SIZE:12pt; COLOR:#000000; FONT-FAMILY:Helvetica,Arial">
				<b>Navigating the User Interface
					<br>
				</b>
			</span>
			<span style="FONT-SIZE:10pt; COLOR:#000000; FONT-FAMILY:Helvetica,Arial">
<br>
Presented along the top of the GeoPrise.NET main map display are tools to aid in application navigation.  These tools consist of tabs with pull-down menus, an administration utility, and a standardized toolbar.
<br>
</span>
			<span style="FONT-SIZE:12pt; COLOR:#000000; FONT-FAMILY:Helvetica,Arial">
				<b>
					<br>
				</b>
				<TABLE width="100%" border="0" cellpadding="0" cellspacing="0">
					<TBODY>
						<TR valign="top">
							<TD width="14"><span style="FONT-SIZE:12pt; COLOR:#000000; FONT-FAMILY:Helvetica,Arial"></span>
			</span>
		</span><span style="FONT-SIZE:10pt; COLOR:#000000; FONT-FAMILY:Helvetica,Arial"><b></b><FONT face="Symbol" size="2" color="#000000">·</FONT><b></b></span></TD><TD><span style="FONT-SIZE:10pt; COLOR:#000000; FONT-FAMILY:Helvetica,Arial"><b>Application 
					Tabs/Pull-Down Menus </b>
			</span><span style="FONT-SIZE:14pt; COLOR:#000000; FONT-FAMILY:Helvetica,Arial"><%If (context.Application("ClientName") = "SacCountyAssessor") Then%><img src="assessorHelpmenu.jpg"><%else%><img src="clip0001.jpg" width="461" height="27" border="0" alt="clip0001"><%end if%>
&nbsp;<br>
</span></TD>
		</TR></TBODY></TABLE><TABLE width="100%" border="0" cellpadding="0" cellspacing="0">
			<TR valign="top">
				<TD><span style="FONT-SIZE:14pt; COLOR:#000000; FONT-FAMILY:Helvetica,Arial"></span></TD>
				<TD></TD>
			</TR>
		</TABLE>
		<span style="FONT-SIZE:14pt; COLOR:#000000; FONT-FAMILY:Helvetica,Arial">&nbsp;&nbsp;&nbsp;</span><span style="FONT-SIZE:10pt; COLOR:#000000; FONT-FAMILY:Helvetica,Arial">GeoPrise.NET's core functionality is accessed via pull-down menus logically organized within six application tabs.
<br>
</span><span style="FONT-SIZE:14pt; COLOR:#000000; FONT-FAMILY:Helvetica,Arial">
			<br>
			<TABLE width="100%" border="0" cellpadding="0" cellspacing="0">
				<TBODY>
					<TR valign="top">
						<TD width="14"><span style="FONT-SIZE:14pt; COLOR:#000000; FONT-FAMILY:Helvetica,Arial"></span>
		</span></SPAN><span style="FONT-SIZE:10pt; COLOR:#000000; FONT-FAMILY:Helvetica,Arial"><b></b><FONT face="Symbol" size="2" color="#000000">·</FONT><b></b></span></TD><TD><span style="FONT-SIZE:10pt; COLOR:#000000; FONT-FAMILY:Helvetica,Arial"><b>Custom 
					Links</b></span><span style="FONT-SIZE:14pt; COLOR:#000000; FONT-FAMILY:Helvetica,Arial"><img src="clip0004.jpg" width="405" height="29" border="0" alt="clip0004">
&nbsp;<br>
</span></TD>
		</TR></TBODY></TABLE><TABLE width="100%" border="0" cellpadding="0" cellspacing="0">
			<TR valign="top">
				<TD><span style="FONT-SIZE:14pt; COLOR:#000000; FONT-FAMILY:Helvetica,Arial"></span></TD>
				<TD></TD>
			</TR>
		</TABLE>
		<span style="FONT-SIZE:14pt; COLOR:#000000; FONT-FAMILY:Helvetica,Arial">&nbsp;&nbsp;&nbsp;</span>
		<%if Application("AppType")="ProjCoord" then%>
		<span style="FONT-SIZE:10pt; COLOR:#000000; FONT-FAMILY:Helvetica,Arial">Project coordination administrator login/logout and access to the <b>
				<i>Projects</i></b> application tab is achieved using the administration utility</span><span style="FONT-SIZE:14pt; COLOR:#000000; FONT-FAMILY:Helvetica,Arial">.</span><span style="FONT-SIZE:10pt; COLOR:#000000; FONT-FAMILY:Helvetica,Arial">
<%end if%>
<b>
				<br>
			</b>
<%if Application("AppType")="BaseApp" or Application("AppType")="ProjCoord" then%>
<TABLE width="100%" border="0" cellpadding="0" cellspacing="0">
				<TBODY>
					<TR valign="top">
						<TD width="14"><span style="FONT-SIZE:10pt; COLOR:#000000; FONT-FAMILY:Helvetica,Arial"><b></b><FONT face="Symbol" size="2" color="#000000">·</FONT><b></b></span></B></span></SPAN></TD><TD><span style="FONT-SIZE:10pt; COLOR:#000000; FONT-FAMILY:Helvetica,Arial"><b>Standard 
					Toolbar </b>
			</span><span style="FONT-SIZE:14pt; COLOR:#000000; FONT-FAMILY:Helvetica,Arial"><img src="clip0002.jpg" width="199" height="30" border="0" alt="clip0002">
&nbsp;<br>
</span></TD>
		</TR></TBODY></TABLE>
		<TABLE width="100%" border="0" cellpadding="0" cellspacing="0">
			<TR valign="top">
				<TD><span style="FONT-SIZE:14pt; COLOR:#000000; FONT-FAMILY:Helvetica,Arial"></span></TD>
				<TD></TD>
			</TR>
		</TABLE>
		<span style="FONT-SIZE:14pt; COLOR:#000000; FONT-FAMILY:Helvetica,Arial">&nbsp;&nbsp;&nbsp;</span><span style="FONT-SIZE:10pt; COLOR:#000000; FONT-FAMILY:Helvetica,Arial">The standard toolbar provides quick and direct access to frequently used tools.</span><span style="FONT-SIZE:16pt; COLOR:#000000; FONT-FAMILY:Helvetica,Arial"><b>
				<br>
			</b>
			<br>
		</span><span style="FONT-SIZE:10pt; COLOR:#000000; FONT-FAMILY:Helvetica,Arial"><img src="overview3.jpg" width="657" height="469" border="0" alt="overview3">
			<br>
		</span></SPAN></SPAN>
		<%end if%>
		<%If Application("ClientName") = "SacCountyAssessor" Then%>
		<br>
		</SPAN><span style="FONT-SIZE:10pt; COLOR:#000000; FONT-FAMILY:Helvetica,Arial"><img src="overviewSCASR.jpg" border="0" alt="overview4">
			<br>
		</span></SPAN></SPAN>
		<%end if%>
		<%if Application("AppType")="SimpleGUI" and Application("ClientName") <> "SacCountyAssessor" then%>
		<br>
		</SPAN><span style="FONT-SIZE:10pt; COLOR:#000000; FONT-FAMILY:Helvetica,Arial"><img src="overviewSGUI.jpg" width="657" height="469" border="0" alt="overview3">
			<br>
		</span></SPAN></SPAN>
		<%end if%>
		<%if Application("AppType")="EconDev" then%>
		<br>
		</SPAN><span style="FONT-SIZE:10pt; COLOR:#000000; FONT-FAMILY:Helvetica,Arial"><img src="overviewED.jpg" width="657" height="469" border="0" alt="overview3">
			<br>
		</span></SPAN></SPAN>
		<%end if%>
	</BODY>
</HTML>
