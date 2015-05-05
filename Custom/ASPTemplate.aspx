<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<title>DB Input Form</title>

<!--#include file="../includes/Header.aspx"-->

</head>

<%
'Important''''''''''''''''''''''''''''''''
'WIZ_LAYER
'WIZ_FIELD1
'WIZ_FIELD2
'WIZ_DISPFIELDS
'WIZ_DATASOURCE
'WIZ_DBTBL
''''''''''''''''''''''''''''''''''''''''''

session("StartOverASP")=Request.Url.ToString
%>
<script language='JavaScript' type='text/javascript'>
var undef, prefix, prefixTop
if (top.opener!=undef){prefix=top.opener.top.MapFrame; }else{if (opener==undef) {prefix=top.MapFrame;}else{prefix=opener.top.MapFrame;}}
prefixTop=top.opener.top;
</script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>

<body class="colr" leftmargin="5" onload="prefix.hideLoadingLyr();">

'WIZ_FORMTAG

<h4>
Please enter the following information</h4>
'WIZ_DBFIELDS
</form>

<SCRIPT LANGUAGE='JavaScript' TYPE='text/javascript'>
	function submitit() {
'WIZ_JSIF
		alert ("Please fill out at least one of the search fields to proceed.");
		return;
	}
	prefixTop.HaltLYRHide=1;
	prefix.positionLoadingLyr();
	document.frmDB.submit();
	}

</script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>

</body>
