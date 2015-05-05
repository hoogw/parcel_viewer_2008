<%@ Page %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<TITLE>Search All</TITLE>
		<meta name="generator" content="Help &amp; Manual">
		<meta name="keywords" content="Search All">
		<!-- Redirect browser to index page if page is not in the content frame.
       This script is only valid for regular HTML export -->
		<script language='JavaScript' type='text/javascript'>
       <!--
           if(top.frames.length==0) top.location.href='index.aspx?searchall.aspx'
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
						<b>Search All</b><b>
							<br>
						</b>
					</span>
				</TD>
				<TD align="right">
					<FONT face="Arial" size="2"><a href="javaScript:parent.reDisplay('1',1,0)">Top</a>&nbsp;
						<a href="javaScript:parent.reDisplay('2.3',1,0)">Previous</a>&nbsp; <a href="javaScript:parent.reDisplay('2.3.2',1,0)">
							Next</a> </FONT>
				</TD>
			</TR>
		</TABLE>
		<br>
		<span style="FONT-SIZE:10pt; COLOR:#000000; FONT-FAMILY:Helvetica,Arial">
<br>
<%If (Application("ClientName") = "SacCountyAssessor") Then%>
The<b><i>Search All</i></b> option allows you to reset the right hand pane to the main search screen.
	
<%else%>
The<b><i>Search All</i></b> option allows you to search by a number of layers which, depending upon your particular installation, may include Street Centerlines, Parcels, Cities, Sewers, and Sewer Services.  <b><i>Search 
					All</i></b> is unique to every customer. It is dynamic and will present different <b><i>Search 
					All</i></b> items depending on which feature layers are loaded within the individual application.
<br>

<br>
<span style="FONT-SIZE:12pt; COLOR:#000000; FONT-FAMILY:Wingdings">
				<span style="FONT-SIZE:12pt; COLOR:#800000; FONT-FAMILY:Wingdings">&nbsp;&nbsp;&nbsp;ð</span>
			</span></span><span style="FONT-SIZE:10pt; COLOR:#000000; FONT-FAMILY:Helvetica,Arial">Click the <b><i>Search 
					Tab</i></b> and select the<b><i> Search All </i></b>option to display the query dialog
<br>

<br>
<img src="search_all1.jpg" width="571" height="228" border="0" alt="search_all1">
<br>

<br>
</span><span style="FONT-SIZE:12pt; COLOR:#000000; FONT-FAMILY:Wingdings"><span style="FONT-SIZE:12pt; COLOR:#800000; FONT-FAMILY:Wingdings">&nbsp;&nbsp;&nbsp;ð</span>
		</span></SPAN><span style="FONT-SIZE:10pt; COLOR:#000000; FONT-FAMILY:Helvetica,Arial">Select a layer to query and click the 'Continue' button
<br>

<br>
<i><img src="lightbulb.jpg" width="9" height="14" border="0" alt="lightbulb"> Tip: Click 'Set 
				as Default Layer' to assign a designated layer to be used each time </i><b><i>Search 
					All</i></b><i> is executed. This is beneficial for repetitious interactions 
				so that you may avoid selecting the same desired layer from the list multiple 
				times.
				<br>
			</i>
<br>
After you've chosen a layer on which to search, the window will change to display the query criteria that is specific to the selected layer.  Your installation may have different criteria than that shown below.
<br>

<br>
<img src="search_parcels2.jpg" width="815" height="386" border="0" alt="search_parcels2">
<br>

<br>
</span><TABLE>
			<TR>
				<TD><span style="FONT-SIZE:12pt; COLOR:#000000; FONT-FAMILY:Wingdings"><span style="FONT-SIZE:12pt; COLOR:#800000; FONT-FAMILY:Wingdings">&nbsp;&nbsp;&nbsp;ð</span>
					</span></TD>
				<TD align="left"><span style="FONT-SIZE:10pt; COLOR:#000000; FONT-FAMILY:Helvetica,Arial">Enter your query criteria and then click the 'Continue' button</span></TD>
			</TR>
		</TABLE>
		<br>
		<br>
		<TABLE width="99%">
			<TR>
				<TD><span style="FONT-SIZE:12pt; COLOR:#000000; FONT-FAMILY:Wingdings"><span style="FONT-SIZE:12pt; COLOR:#800000; FONT-FAMILY:Wingdings">&nbsp;&nbsp;&nbsp;ð</span>
					</span></TD>
				<TD><span style="FONT-SIZE:10pt; COLOR:#000000; FONT-FAMILY:Helvetica,Arial">Select from the candidates listed by clicking on the 'Highlight' link.  GeoPrise.NET will now highlight and zoom to the selected entity within the map interface</span></SPAN></SPAN></TD>
			</TR>
		</TABLE>
		<%end if%>
		<br>
		<br>
	</BODY>
</HTML>
