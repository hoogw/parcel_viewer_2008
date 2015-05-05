<%@ Page %>
<%
On Error Resume Next
%>
<html>
	<head>
		<title>Untitled</title></head>
	<!--#include file="../includes/header.aspx"-->
	<body onload="top.MapFrame.hideLoadingLyr()">
		<center><font class="SSHdr1">Search Tips for Searching by APN </font>
		</center>
		<font class="SSMsg2">
			<p>Assessor parcel numbers in this application use the full 8 digit APN. You can enter dashes even though the database search field does not contain them. For example, an APN entered like this “139-192-36” will be find property record “13919236”.
			</p>
		</font><font class="SSMsg2">
			<p>To search the database for a single APN, it is not necessary to enter a complete number string in the “from:” dialog box. You can entering a partial APN and allow the application to produce a candidate list of all APNs that complete the sequence.  For example, entering the first part of our example APN like this "139192", will cause the application to produce a candidate list of APNs like “13919236”,“13919237”,“13919238”,“13919239” and so on from which you can pick.
				
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
