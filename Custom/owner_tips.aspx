<%@ Page %>
<%
On Error Resume Next
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head>
		<title>Owner Search Tips</title>	<!--#include file="../includes/header.aspx"-->
</head>
<script language='JavaScript' type='text/javascript'>
var undef, prefix
if (top.opener!=undef){prefix=top.opener.top.MapFrame;}else{if (opener==undef) {prefix=top.MapFrame;}else{prefix=opener.top.MapFrame;}}
</script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>
	<body onload="prefix.hideLoadingLyr()">
		<center><font class="SSHdr1">Search Tips for Searching by Owner </font>
			<br>
			<br>
		</center>
		<font class="SSMsg2">
			<p>When searching by owner name, enter a complete or partial last name to generate 
				a candidate list.</p>
		</font><font class="SSMsg2">
			<p>Owner names do not have to be complete. A partial name, or even a single letter, 
				is sufficient to generate a candidate list.</p>
		</font><font class="SSMsg2">
			<p>To be more specific, enter a complete last name followed by a first name or 
				first initial. Separate the two names with a single space.</p>
		</font><font class="SSMsg2">
			<p><a href="javascript:history.go(-1)">Click here to go back</a></p>
		</font>
	</body>
</html>
