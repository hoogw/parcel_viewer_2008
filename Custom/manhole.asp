<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<title>Manhole Input Form</title>
<!--#include file="../includes/header.aspx"-->
			
</head>


<%

'Important''''''''''''''''''''''''''''''''
if trim(request("lyr")) <> "" then
	session("lyr") = request("lyr")	'ID of the layer being queried
end if
if trim(request("ds1")) <> "" then
	session("ds") = "Provider=SQLOLEDB.1;" & request("ds1")	'data source from .NET code
end if
''''''''''''''''''''''''''''''''''''''''''
%>
<SCRIPT LANGUAGE='JavaScript' TYPE='text/javascript'>
function sendManhole(Value1, Value2, Value3) {
		
	var manholeNum = Value1+Value2+Value3
	document.location="manhole_process.asp?mhole=" + manholeNum;
}	

function searchTips() {
      var searchWin = window.open("","Tips","toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=0,copyhistory=0,width=450,height=445");
   searchWin.location.href = "manhole_tips.htm";
      searchWin.focus();
}	

function smartfocus (curr,nxt,v) {
	if (curr.value.length>(v-1)) {
		nxt.focus();
		}
	}

</script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>


<body class="colr" leftmargin="5" onload="top.MapFrame.hideLoadingLyr();">

<form name="frmManhole" action="javascript:sendManhole(frmManhole.mholeBook.value,frmManhole.mholePage.value,frmManhole.mholeNum.value)">
<h4>
Please enter the following information</h4>
<b> Manhole Number:</b><br>
  <input type="text" name="mholeBook" size="2" value="" maxlength="3" onkeyup="smartfocus(this,mholePage,3);">-
  <input type="text" name="mholePage" size="2" value="" maxlength="3" onkeyup="smartfocus(this,mholeNum,3);">-
  <input type="text" name="mholeNum" size="2" value="" maxlength="3">
<br><br>
	<input type="submit" value="Find Manhole" name="submit"><br><br>
</form>
</body>
