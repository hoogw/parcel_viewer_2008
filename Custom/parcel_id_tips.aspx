<%@ Page %>
<%
On Error Resume Next
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head>
		<title>Untitled</title>	<!--#include file="../includes/header.aspx"-->
</head>
<script language='JavaScript' type='text/javascript'>
var undef, prefix
if (top.opener!=undef){prefix=top.opener.top.MapFrame;}else{if (opener==undef) {prefix=top.MapFrame;}else{prefix=opener.top.MapFrame;}}
</script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>

	<body onload="prefix.hideLoadingLyr()">
		<center><font class="SSHdr1">Search Tips for Searching by APN </font>
		</center>
		<font class="SSMsg2">
			<p>Assessors Parcel numbers follow a specific numeric format as follows: Book# (3 
				characters) - Page# (4 characters) - Parcel# (3 characters) - Sub-parcel# (4 
				characters). All positions must be filled regardless if the number is zero or 
				an integer. For example, APN “009-0012-075-0000” must be entered in exactly 
				that manner; the string “9-12-75-0” will not work.
			</p>
		</font><font class="SSMsg2">
			<p>To search the database for a single APN (Assessors Parcel Number), it is 
				necessary to enter a complete number string in the “from:” dialog box. 
				Wildcards are not supported.
			</p>
		</font><font class="SSMsg2">
			<p>To search for a range of APN’s, enter a beginning APN in the “from:” dialog box, 
				and then an ending APN in the optional “to:” box.
			</p>
		</font><font class="SSMsg2">
			<p>If you encounter trouble finding a specific APN in the database, search using a 
				range of numbers. This will generate a candidate list from which you can pick 
				the specific APN.
			</p>
		</font><font class="SSMsg2">
			<p><a href="javascript:history.go(-1)">Click here to go back</a></p>
		</font>
	</body>
</html>
