<% response.expires = -7 %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
	<title>Permit Status Data</title>
</head>
<body>

<!--#include file="dbParams.asp"--> 
<FONT FACE="Arial,sans-serif" SIZE="-2">
<% 

permitStatusdbResultFieldDescriptList = "Status Code, Status Desc, Freeze Status, Action Code"
permitStatusdbResultFields = Split(permitStatusdbResultFieldDescriptList,",")

'Data Extraction**********************************************************
theStatusNo = request.querystring("theStatusNo")
'response.write thepermitStatus
SQLquery = "SELECT * FROM PERMITS_CASE_STATUS WHERE STATUS_CODE LIKE '"  & theStatusNo & "%'" 

response.write "<div align='left'><font color='Blue'><b><font size='2'>Permit Status Code Description : " & theStatusNo
dim conntemp, rstemp
set conntemp=server.createobject("adodb.connection")
conntemp.open session("ds")

'response.write SQLquery
'response.write "Connected...<br>"

response.write "</font></b></font></div>"

'Header**********************************************************************
'response.write theNum&"</font></b></font></div>"
response.write "<TABLE width='100%'><tr><td><p align='right'><!---<input type=button name=btnClose value='Close' onclick='window.close()'>--->&nbsp;</tr></td></TABLE>"	
set rstemp=conntemp.execute(SQLquery)


if not rstemp.eof then
'Create Tabular Display of Attribute Data***********************************
		howmanyfields=rstemp.fields.count-1
		recCount = 0
		do while not rstemp.eof
			recCount = recCount + 1
			response.write "<b>Record " & recCount & "</b><br>"
			response.write "<TABLE width='360'>"
			for i=0 to howmanyfields
				if (i/2 = i\2) then
					response.write "<TR BGCOLOR='#DDDDDD'>"
				else 
					response.write "<TR BGCOLOR='#EEEEEE'>"
				end if
				response.write "<TD width='90'><FONT FACE='Arial,sans-serif' SIZE='-1'><B>" & permitStatusdbResultFields(i) & "</B></FONT></TD>"
				response.write "<TD width='270'><FONT FACE='Arial,sans-serif' SIZE='-1'>"
				thisvalue = rstemp(i)
				if isnull(thisvalue) then
					thisvalue = "&nbsp;"
				end if
						response.write thisvalue
						response.write"</FONT></TD>"
						response.write"</TR>"
			next
			rstemp.movenext
		
			response.write"</TABLE><br>"
		loop
	response.write "<br><font size='2'>If you would like to perform a search based on a different Permit Status Code, please enter it here and click on the search button.<br></font>"
	response.write "<form name='permitStatus' action='arcims_permit_status_process.asp' method='GET'>	<input maxlength='14' type='text' name='theStatusNo' size='14' value=''>&nbsp;&nbsp;<input type='submit' value='Search'></form>"
else
	response.write "<br><font size='2'>The Permit Status Code submitted (listed in blue font above) does not have a match in the GIS database.  If you would like to perform a search based on a different Permit Status Code, please enter it here and click on the search button.<br></font>"
	response.write "<form name='permitStatus' action='arcims_permit_status_process.asp' method='GET'>	<input maxlength='14' type='text' name='theStatusNo' size='14' value=''>&nbsp;&nbsp;<input type='submit' value='Search'></form>"
end if

rstemp.close
set rstemp=nothing
conntemp.close
set conntemp=nothing
response.write "<TABLE width='100%'><tr><td><p align='right'><input type=button name=btnBac value='Back' onclick='history.back()'>&nbsp;</tr></td></TABLE>"	
 %>
 
</FONT></body>
</html>
