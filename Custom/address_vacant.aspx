<%@ Page %>
<%
On Error Resume Next
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head>
		<title>Vacant Parcel Search Input Form</title>
			<!--#include file="../includes/header.aspx"-->
</head>
	<SCRIPT LANGUAGE='JavaScript' TYPE='text/javascript'>
	function sendAddress(Value2) {
		top.MapFrame.positionLoadingLyr();
		
		document.location = "address_vacant_process.aspx?stname=" + Value2;
	}	
	function searchTips() {
		document.location = "address_tips.aspx";
	}	
	</script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>
	<body leftmargin="5" onload="top.MapFrame.hideLoadingLyr()">
		<form name="frmAddress" action="javascript:sendAddress(frmAddress.stname.value)" method="post">
			<font class="SSHdr1">Please enter the following information</font><br>
			<br>
			<font class="SSLbl1">Vacant Parcel Search - Street Name:</font><br>
			<input type="text" name="stname" size="24" value="Goethe"><br>
			<br>
			<input type="submit" value="Find Addresses" name="submit"><br>
			<br>
			<br>
			<font class="SSMsg2"><a href="address.aspx">Click Here</a> to return to the 
				standard address search.<br>
				<br>
			</font><font class="SSMsg2"><b>Note: </b>Do NOT enter Street Direction (E,W,N,S) or 
				Street Suffix (St., Ave., Blvd., etc.). A list of potential matches will be 
				displayed.</font>
		</form>
	</body>
</html>
