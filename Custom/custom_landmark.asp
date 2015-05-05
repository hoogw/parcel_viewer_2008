<!--- Custom Landmark ASP file --->
<!--- Inputs: 
		ds			request("ds")			The data source connection string
	  REQUIREMENT:
		* <body onload="top.MapFrame.hideLoadingLyr()">
		* Javascript sendValue(Value1) block
	    * session("ds") = "Provider=SQLOLEDB.1;" & request("ds")  ;this session("ds") will be used in all ASP pages which need to reference the data source

--->

<% response.expires = -7 %>

<%
if trim(request("ds")) <> "" then
	session("ds") = "Provider=SQLOLEDB.1;" & request("ds")
end if
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<title>Landmark Selection Form</title>
<!--#include file="../includes/header.aspx"--> 
</head>

<SCRIPT LANGUAGE='JavaScript' TYPE='text/javascript'>
	function sendValue(Value1) { document.location = "landmark_process.asp?landmark=" + Value1; }
</script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>


<body class="colr" leftmargin="5">
<form name="frmLandmark" action="custom_landmark.asp" ID="Form1">
<font class=SSHdr1>
Please select a Landmark Category</font>

<!--#include file="dbParams.asp"--> 
<% 
theCategory = request("theCategory")
theCheck = request("theCheck")

SQLLandmarkQuery = "SELECT DISTINCT MAJOR_CATEGORY FROM vwLANDMARKS_WITH_CATEGORY ORDER BY MAJOR_CATEGORY"
set conntemp=server.createobject("adodb.connection")
conntemp.open session("ds")
set rsLandmark=conntemp.execute(SQLLandmarkQuery)

response.write "<p><select class=HTMLFrmObjects name='theCategory' size='1'>"
	recCount = 0

if theCheck = "" then
	response.write "<option value='BUSINESS'>BUSINESS</option>"
end if

do while not rsLandmark.eof

	recCount = recCount + 1
	if theCheck <> "" then
		response.write "<option value='"&theCategory&"' selected>"&theCategory&"</option>"
		do while not rsLandmark.eof
			rsLandmark.movenext
		loop
	'else if recCount = 1 then
		'response.write "<option value='"&rsLandmark("Major_category")&"' selected>"&rsLandmark("Major_category")&"</option>"
	else
		if rsLandmark("Major_category") <> "" then
		response.write "<option value='"&rsLandmark("Major_category")&"'>"&rsLandmark("Major_category")&"</option>"
		end if
'	end if
	end if
		if not rsLandmark.eof then
	rsLandmark.movenext
		end if
loop

response.write "</select> </p>"
response.write "<input type='hidden' name='theCheck' value='Y'>"
if theCheck = "" then
response.write "<input  tabindex=1 type='submit' class=Btn value='Continue' name='submit'>&nbsp;&nbsp;"
response.write "<input  tabindex=2 type='button' class=Btn value='Back' onclick='Javascript:window.close()'>"
end if
response.write "</form>"

if theCategory <> "" then
	if theCategory <> "BUSINESS" then
		SQLLandmarkQuery = "SELECT DISTINCT DESCRIPTION FROM vwLANDMARKS_WITH_CATEGORY WHERE MAJOR_CATEGORY = '"&theCategory&"' ORDER BY DESCRIPTION"
		
		set rsLandmarkSub=conntemp.execute(SQLLandmarkQuery)
		response.write "<form name='frmLandmarkSub' action='landmark_process.asp'>"
		response.write "<p><select class=HTMLFrmObjects name='theCategory' size='1'>"
			recCount = 0
		do while not rsLandmarkSub.eof
			recCount = recCount + 1
			if recCount = 1 then
				response.write "<option value='"&rsLandmarkSub("DESCRIPTION")&"' selected>"&rsLandmarkSub("DESCRIPTION")&"</option>"
			else
				response.write "<option value='"&rsLandmarkSub("DESCRIPTION")&"'>"&rsLandmarkSub("DESCRIPTION")&"</option>"
			end if
			rsLandmarkSub.movenext
		loop
		response.write "</select> </p>"
	else
		response.write "<form name='frmLandmarkSub' action='landmark_process.asp'>"
		response.write "Enter the first few characters of the name:"
		response.write "<input type='hidden' name='theCategory' value='BUSINESS'>"
		response.write "<input  tabindex=3 type='text' class=HTMLFrmObjects name='theBusiness' value=''><br><br>"
	end if
response.write "<input type='hidden' name='theCheck' value=''>"
response.write "<input  tabindex=4 type='submit' class=Btn value='Continue' name='submit'>&nbsp;&nbsp;"
response.write "<input  tabindex=5 type='button' class=Btn value='Back' onclick='Javascript:history.back()'>"
response.write "</form>"
else

if theCheck <> "" then
response.write "Please go back and select a Landmark category<br>"

response.write "<input  tabindex=6 type='button' class=Btn value='Back' onclick='Javascript:history.back()'>"
end if
end if

response.write "</body>"

rsLandmark.close
set rsLandmark=nothing
'conntemp.close
set conntemp=nothing

 %>