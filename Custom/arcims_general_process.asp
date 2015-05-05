<% response.expires = -7 %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
	<title>General Parcel Results</title>
</head>

<SCRIPT LANGUAGE='JavaScript' TYPE='text/javascript'>
function sendZone(theZone) {
document.location= "arcims_zone_process.asp?theZone="+theZone;
}
</script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>

<body>

<!--#include file="dbParams.asp"--> 
<FONT FACE="Arial,sans-serif" SIZE="-2">
<% 

gendbResultFieldDescriptList = "Zone, Lot Size, Tax Rate Area, Neighborhood Code, Subdivision Code, Lot Number, Thomas Bros"
gendbResultFields = Split(gendbResultFieldDescriptList,",")

gendbResultFieldList = "ZONE, LOTSIZE, TXRTARC, NEIBRHC, SUBDIViSIOn, LOT, PRC"

'Data Extraction**********************************************************
theNum = request.querystring("IDValue")
SQLquery = "SELECT "&gendbResultFieldList&" FROM vParcelWithSubdivisionName WHERE " & dbIDField & " = '"  & theNum & "'" 
response.write "<div align='left'><font color='Blue'><b><font size='2'>General Data Table For Parcel: "
dim conntemp, rstemp
set conntemp=server.createobject("adodb.connection")
conntemp.open session("ds")
'response.write SQLquery
'response.write "Connected...<br>"

			apnBook = left(theNum, 3)
			apnPage = mid(theNum,4,4)
			apnParcel = mid(theNum,8,3)
			apnSubParcel = right(theNum,4)
response.write apnBook&"- "&apnPage&"- "&apnParcel&"- "&apnSubParcel
response.write "</font></b></font></div>"

'Header**********************************************************************
'response.write theNum&"</font></b></font></div>"
set rstemp=conntemp.execute(SQLquery)

'Create Tabular Display of Attribute Data***********************************
howmanyfields=rstemp.fields.count-1
'howmanyfields=rstemp.fields.count
'response.write howmanyfields & "<br>"
recCount = 0
do while not rstemp.eof
	recCount = recCount + 1
'	response.write "<b>Record " & recCount & "</b><br>"
	response.write "<TABLE width='100%'>"
	for i=0 to howmanyfields
		if (i/2 = i\2) then
			response.write "<TR BGCOLOR='#DDDDDD'>"
		else 
			response.write "<TR BGCOLOR='#EEEEEE'>"
		end if
		response.write "<TD width='40%'><FONT FACE='Arial,sans-serif' SIZE='-1'><B>" & gendbResultFields(i) & "</B></FONT></TD>"
		'response.write "<TR><TD>" & rstemp(i).name & "</TD>"
		response.write "<TD><FONT FACE='Arial,sans-serif' SIZE='-1'>"
		thisvalue = rstemp(i)
		if isnull(thisvalue) then
			thisvalue = "&nbsp;"
		end if
				if gendbResultFields(i) = "Zone" then
					response.write "<valign='top'><font face='Arial' size='-1'><b><a href='Javascript:sendZone("""&thisvalue&""")'><font color='Blue'>"&thisvalue&"</font></a></b></font>	<font face='Arial' size='-2'>"
				else
					response.write thisvalue
				end if
				response.write"</FONT></TD>"
				response.write"</TR>"
	next
	rstemp.movenext

	response.write"</TABLE><br>"
loop

'==============================

gendbResultFieldDescriptList = "Parcel Tag"
gendbResultFields = Split(gendbResultFieldDescriptList,",")

gendbResultFieldList = "Parcel Tag"

'Data Extraction**********************************************************
SQLquery = "SELECT TAG FROM PARCEL_TAGS WHERE PARCEL_NUMBER = '"  & theNum & "'" 
set rstemp=conntemp.execute(SQLquery)

'Create Tabular Display of Attribute Data***********************************
howmanyfields=rstemp.fields.count-1
'howmanyfields=rstemp.fields.count
'response.write howmanyfields & "<br>"
	response.write "<TABLE width='100%'>"
recCount = 0
do while not rstemp.eof
	recCount = recCount + 1
'	response.write "<b>Record " & recCount & "</b><br>"

	for i=0 to howmanyfields
		if (i/2 = i\2) then
			response.write "<TR BGCOLOR='#AAAAAA'>"
		else 
			response.write "<TR BGCOLOR='#CCCCCC'>"
		end if
		response.write "<TD width='65%'><FONT FACE='Arial,sans-serif' SIZE='-1'><B>" & gendbResultFields(i) & "</B></FONT></TD>"
		'response.write "<TR><TD>" & rstemp(i).name & "</TD>"
		response.write "<TD><FONT FACE='Arial,sans-serif' SIZE='-1'>"
		thisvalue = rstemp(i)
		if isnull(thisvalue) then
			thisvalue = "&nbsp;"
		end if
				response.write thisvalue
				response.write"</FONT></TD>"
				response.write"</TR>"
	next
	rstemp.movenext


loop
	response.write"</TABLE><br>"
'===============================


rstemp.close
set rstemp=nothing
conntemp.close
set conntemp=nothing
response.write "<TABLE width='100%'><tr><td><p align='right'><!---<input type=button name=btnClose value='Close' onclick='window.close()'>--->&nbsp;</tr></td></TABLE>"	
 %>
 
</FONT></body>
</html>
