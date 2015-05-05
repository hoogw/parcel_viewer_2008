<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<title>Manhole Input Form</title>
<!--#include file="../includes/Header.aspx"-->
			
</head>


<%

'Important''''''''''''''''''''''''''''''''
if trim(request("lyr")) <> "" then
	session("lyr") = request("lyr")	'ID of the layer being queried
end if
	session("ds") = "Provider=SQLOLEDB.1;Initial Catalog=GIS;Server=PWASQL;User Id=gisuser;Password=gisuser;pooling=false;connection timeout=120;"
''''''''''''''''''''''''''''''''''''''''''
%>
<SCRIPT LANGUAGE='JavaScript' TYPE='text/javascript'>
function sendManhole(Value1, Value2, Value3, Value4, Value5, Value6) {
		
	var manholeNum1 = Value1+Value2+Value3
	var manholeNum2 = Value4+Value5+Value6
	document.location="sewer_process.aspx?lyr=<%=request("lyr")%>&mhole1=" + manholeNum1 + "&mhole2=" + manholeNum2;
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

<form name="frmManhole" action="javascript:sendManhole(frmManhole.mholeBook1.value,frmManhole.mholePage1.value,frmManhole.mholeNum1.value,frmManhole.mholeBook2.value,frmManhole.mholePage2.value,frmManhole.mholeNum2.value)">
<h4>
Please enter the following information</h4>
<b> Upstream Manhole:</b><br>
  <input type="text" name="mholeBook1" size="2" value="" maxlength="3" onkeyup="smartfocus(this,mholePage1,3);">-
  <input type="text" name="mholePage1" size="2" value="" maxlength="3" onkeyup="smartfocus(this,mholeNum1,3);">-
  <input type="text" name="mholeNum1" size="2" value="" maxlength="3" onkeyup="smartfocus(this,mholeBook2,3);">
<br><br>
<b> Downstream Manhole:</b><br>
  <input type="text" name="mholeBook2" size="2" value="" maxlength="3"  onkeyup="smartfocus(this,mholePage2,3);">-
  <input type="text" name="mholePage2" size="2" value="" maxlength="3"  onkeyup="smartfocus(this,mholeNum2,3);">-
  <input type="text" name="mholeNum2" size="2" value="" maxlength="3" ID="Text3">
<br><br>

	<input type="submit" value="Find Sewer Pipe" name="submit"><br><br>
</form>
</body>
