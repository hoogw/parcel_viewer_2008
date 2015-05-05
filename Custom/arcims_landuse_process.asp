<% response.expires = -7 %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
	<title>Parcel Landuse Codes</title>
</head>

<body>

<!--#include file="dbParams.asp"--> 
<FONT FACE="Arial,sans-serif" SIZE="-2">
<% 
'dbResultFieldList = "*"
dblanduseFieldDescriptList = "Landuse,Current Number of County Parcels w/this Code,General Description,Specific Description,Detail Description,Use of Parcel,Number of Units,Multiplier,Density"
dbLanduseFieldDescript = Split(dbLanduseFieldDescriptList,",")
theNum = request.querystring("IDValue")
SQLquery = "SELECT * FROM land_use_descriptions WHERE Landuse = '"  & theNum & "'" 
'SQLquery = "SELECT " & dbResultFieldList & " FROM " & dbTable & " WHERE " & dbIDField & " = '"  & theNum & "'" 
dim conntemp, rsLanduse
set conntemp=server.createobject("adodb.connection")
conntemp.open dbSource
'response.write SQLquery
'response.write "Connected...<br>"
response.write "<font color='Blue'><b><font size='2'>Landuse Data For Code - "&theNum&"</font></b></font><br>"
response.write "<TABLE width='400'><tr><td><p align='right'><!---<input type=button name=btnClose value='Close' onclick='window.close()'>---></tr></td></TABLE>"
set rsLanduse=conntemp.execute(SQLquery)
howmanyfields=rsLanduse.fields.count-1
'howmanyfields=rsLanduse.fields.count
'response.write howmanyfields & "<br>"
recCount = 0
if rsLanduse.eof then

	response.write "<br><font size='2'>The landuse record submitted (listed in blue font above) does not have a match in the landuse code table.  If you would like to search for the description of a different code, please enter it here and click on the search button.<br></font>"
	response.write "<form name='landuse' action='arcims_landuse_process.asp' method='GET'>	<input maxlength='6' type='text' name='IDValue' size='6' value=''>&nbsp;&nbsp;<input type='submit' value='Search'></form>"


else
	do while not rsLanduse.eof
		recCount = recCount + 1
	'	response.write "<b>Record " & recCount & "</b><br>"
		response.write "<TABLE width='400'>"
		for i=0 to howmanyfields
			if (i/2 = i\2) then
				response.write "<TR BGCOLOR='#DDDDDD'>"
			else 
				response.write "<TR BGCOLOR='#EEEEEE'>"
			end if
			response.write "<TD width='200'><FONT FACE='Arial,sans-serif' SIZE='-1'><B>" & dbLanduseFieldDescript(i) & "</B></FONT></TD>"
			response.write "<TD width='200'><FONT FACE='Arial,sans-serif' SIZE='-1'>"
			thisvalue = rsLanduse(i)
			if isnull(thisvalue) then
				thisvalue = "&nbsp;"
			end if
			response.write thisvalue
			response.write"</FONT></TD>"
			response.write"</TR>"
		next
			response.write"</TABLE><br>"
		rsLanduse.movenext
	loop
	response.write "<br><font size='2'>If you would like to search for the description of a different code, please enter it here and click on the search button.<br></font>"
	response.write "<form name='landuse' action='arcims_landuse_process.asp' method='GET'>	<input maxlength='6' type='text' name='IDValue' size='6' value=''>&nbsp;&nbsp;<input type='submit' value='Search'></form>"

end if

response.write "<TABLE width='400'><tr><td><p align='right'><!---<input type=button name=btnClose value='Close' onclick='window.close()'>---></tr></td></TABLE>"
rsLanduse.close
set rsLanduse=nothing
conntemp.close
set conntemp=nothing


 %>



</FONT></body>
</html>
