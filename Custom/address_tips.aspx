<%@ Page %>
<%
On Error Resume Next
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head>
		<title>Address Search Tips</title>	<!--#include file="../includes/header.aspx"-->
</head>
<script language='JavaScript' type='text/javascript'>
var undef; var prefix;
if (opener==undef) {prefix=top.MapFrame;}else{prefix=opener.top.MapFrame;}
</script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>
	<body leftmargin="20" onload="prefix.hideLoadingLyr()">
		<center><font class="SSHdr1">Search Tips for Searching by Address</font></center>
		<br>
		<p><font class="SSMsg2">When searching by address, omit all street prefixes (north, 
				south, east, west, or N, S, E, W) and all street suffixes (St., Ave., apt#, 
				etc.). </font>
		</p>
		<br>
		<p><font class="SSMsg2">Do not use wildcard symbols – they are not recognized by this 
				application. </font>
		</p>
		<br>
		<p><font class="SSMsg2">It is not necessary to have both a house number and street name 
				to generate a candidate list; either of the two can begin the process. </font>
		</p>
		<br>
		<p><font class="SSMsg2">House numbers must be complete. For example, entering “97” will 
				only find houses that have a complete house number of “97”; the application 
				will not return all house numbers that begin with “97…”. </font>
		</p>
		<br>
		<p><font class="SSMsg2">Street names do not have to be complete. A partial street name, 
				or even a single letter, is sufficient to generate a candidate list. </font>
		</p>
		<br>
		<p><font class="SSMsg2">If you are unsure of the spelling of a particular street, use 
				the dynamic street finder index (highlighted in red). Enter one letter at a 
				time into the street name dialog box, and the index will generate possible 
				street names. A street number can be used in conjunction with the index to 
				narrow the search. </font>
		</p>
		<br>
		<br>
		<p><font class="SSMsg2"><a href="javascript:history.go(-1)">Click here to go back</a></font></p>
	</body>
