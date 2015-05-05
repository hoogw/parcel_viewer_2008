<%@ Page %>
<%
On Error Resume Next
%>
<html>
	<head>
		<title>Address Search Tips</title></head>
	<!--#include file="../includes/header.aspx"-->
	<body leftmargin="20" onload="top.MapFrame.hideLoadingLyr()">
		<center><font class="SSHdr1">Search Tips for Searching by Address</font></center>
		<br>
		<p><font class="SSMsg2">When searching by address, omit all street suffixes (St., Ave., apt#, 
				etc.). </font>
		</p>
		<br>
		<p><font class="SSMsg2">You CAN use the wildcard symbol "%" – This is especially useful for completing a number sequence. Entering "24%" in the street number field, and "Main" in the street name field will find all properties on "Main" with house numbers beginning with the numbers "24..." </font>
		</p>
		<p><font class="SSMsg2">It is not necessary to have both a house number and street name 
				to generate a candidate list; either of the two can begin the process.  When entering just a street name, you do not need to enter a "%" in front of the street name. </font>
		</p>
		<br>
		<p><font class="SSMsg2">Street names do not have to be complete. A partial street name, 
				or even a single letter, is sufficient to generate a candidate list. </font>
		</p>
		<br>
		<br>
		<p><font class="SSMsg2"><a href="javascript:history.go(-1)">Click here to go back</a></font></p>
	</body>
