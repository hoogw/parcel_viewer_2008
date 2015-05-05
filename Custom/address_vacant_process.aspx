<%@ Page CodeBehind="address_vacant_process.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="GeopriseApp.address_vacant_process" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>Vacant Parcel Search - Address Results</title>
		<%
On Error Resume Next
%>
		<% response.expires = -7 %>
		<SCRIPT LANGUAGE='JavaScript' TYPE='text/javascript'>
	function sendValue(Value1) {
		top.MapFrame.positionLoadingLyr();
		
		top.MapFrame.url="";
		var url="parcel_details.aspx?APN=" + Value1
		top.MapFrame.SSRefreshMap(Value1,url);
	}
		</script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>
		<!--#include file="../includes/header.aspx"-->
	</HEAD>
	<body onload="<%=AfterLoad%>">
		<%=Information%>
	</body>
</HTML>
