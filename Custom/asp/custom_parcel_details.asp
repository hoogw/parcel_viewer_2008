<!--- Custom Parcel Details ASP file --->
<!--- Inputs: 
		APN		request("APN")		The APN number
		ds		request("ds")		The data source connection string
		CS			request("CS")			The colour scheme ID
	  REQUIREMENT:
		* <body onload="top.MapFrame.hideLoadingLyr()">
	    * session("ds") = request("ds")  ;this session("ds") will be used in all ASP pages which need to reference the data source
--->


<% response.expires = -7 %>
<%
	if trim(request("CS")) <> "" then
		application("CS")=trim(request("CS"))
	end if

Sub PrintIt()
	howmanyfields=rstemp.fields.count-1

	response.Write "<br><table cellpadding=0 cellspacing=0 width=100% border=0>"
	for i = 0 to howmanyfields
	   'if left(ucase(cstr(rstemp.fields.item(i).name)),3) <> "OWN" then
		if (i/2 = i\2) then
			response.write "<TR BGCOLOR='#DDDDDD'>"
		else 
			response.write "<TR BGCOLOR='#EEEEEE'>"
		end if
		
		thisvalue=rstemp(i)
		if isnull(thisvalue) then
			thisvalue="&nbsp;"
		else
			thisvalue=rstemp(i)
		end if
		response.Write "<td width=35% ><b>" & rstemp.fields.item(i).name & "</b></td><td width=65% >" & thisvalue & "</td></tr>"
	   'end if
	next

	response.Write ("</table><br><br><br>")
end sub

%>
<html>
<head>
	<title>Parcel Detail Results</title>
</head>
<!--#include file="../includes/header.aspx"-->

<body onload="top.MapFrame.hideLoadingLyr()">

<FONT FACE="Arial,sans-serif" SIZE="-2">
<% 

theNum = request("APN")
theNum=replace(theNum,"'","")

if trim(theNum) = "" then
	response.Write ("No Parcel selected. Please try again.")
	response.End
end if

SQLquery = "SELECT * FROM PARCELS WHERE APN = '"  & theNum & "'" 
response.write "<div align='left'><font color='#0000FF'><b><font size='2'>&nbsp;Creating Attribute Data Table For Parcel<br>"
set conntemp=server.createobject("adodb.connection")

session("ds") = request("ds")
conntemp.open session("ds")

response.write theNum&"</font></b></font></div>"
set rstemp=conntemp.execute(SQLquery)

if (trim(theNum) = "" or trim(theNum) = "''") then
	response.End
end if

if rstemp.eof =false then
	
	PrintIt()
else
	theNumTemp=theNum
	theNum = left(theNum,len(theNum)-2)
	SQLquery = "SELECT * FROM PARCELS WHERE APN like '%"  & theNum & "%'" 
	set rstemp=conntemp.execute(SQLquery)

	if rstemp.eof=true then
		response.write "There is a data problem associated with this parcel."
	else
		response.Write "<br>Parcel " & theNumTemp & " not found in DB. Locating closest match(s).<br>"
		PrintIt()
	end if
end if

	rstemp.close
	set rstemp=nothing
	conntemp.close
	set conntemp=nothing

 %>
 
</FONT></body>
</html>
