<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
<title>Vacant Parcel Search Input Form</title>

	<LINK REL="stylesheet" 
		TYPE="text/css" 
		HREF="styles.css" 
		TITLE="styles">
			
</head>

<SCRIPT LANGUAGE='JavaScript' TYPE='text/javascript'>
		function sendAddress(Value2) {

      var myWin2 = window.open("","Candidates","toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=0,copyhistory=0,width=450,height=375");
   myWin2.location.href = "address_vacant_process.asp?stname=" + Value2;
      myWin2.focus();
}	

function searchTips() {
      var searchWin = window.open("","Tips","toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=0,copyhistory=0,width=450,height=445");
   searchWin.location.href = "address_tips.htm";
      searchWin.focus();

}	
</script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>


<body class="colr" leftmargin="5">

<form name="frmAddress" action="javascript:sendAddress(frmAddress.stname.value)">
<h4>
Please enter the following information</h4>
 
 Vacant Parcel Search - Street Name:<br>
	<input type="text" name="stname" size="24" value="Goethe"><br>
	<br>
	<input type="submit" value="Find Addresses" name="submit"><br><br>
<br>
<a href="address.asp">Click Here</a> to return to the standard address search.<br><br>
<font size="-1">    <b>Note: </b>Do NOT enter Street Direction (E,W,N,S) or
    Street Suffix (St., Ave., Blvd., etc.). A list of potential
    matches will be displayed.
</font>
</form>
</body>
