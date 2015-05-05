<% response.expires = -7 %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
	<title>Parcel District Results</title>
</head>

<body>

<!--#include file="dbParams.asp"--> 
<FONT FACE="Arial,sans-serif" SIZE="-2">
<% 
'dbResultFieldList = "*"
dbPermitFieldDescriptList = "Fee District,Description"
dbPermitFieldDescript = Split(dbPermitFieldDescriptList,",")
theNum = request.querystring("IDValue")
SQLquery = "SELECT FEE_GROUP_DESCRIPTION,FEE_DESCRIPTION  FROM vwAPN_FEE_DESCRIPTIONS WHERE APN = '"  & theNum & "' ORDER BY FEE_GROUP_DESCRIPTION" 
'SQLquery = "SELECT " & dbResultFieldList & " FROM " & dbTable & " WHERE " & dbIDField & " = '"  & theNum & "'" 
dim conntemp, rsDistrict
set conntemp=server.createobject("adodb.connection")
conntemp.open dbSource
'response.write SQLquery
'response.write "Connected...<br>"
response.write "<font color='Blue'><b><font size='2'>Fee District Data For Parcel: "

			apnBook = left(theNum, 3)
			apnPage = mid(theNum,4,4)
			apnParcel = mid(theNum,8,3)
			apnSubParcel = right(theNum,4)
response.write apnBook&"- "&apnPage&"- "&apnParcel&"- "&apnSubParcel
response.write "</font></b></font></div>"

'&theNum&"</font></b></font><br>"
response.write "<TABLE width='400'><tr><td><p align='right'><!---<input type=button name=btnClose value='Close' onclick='window.close()'>---></tr></td></TABLE>"
set rsDistrict=conntemp.execute(SQLquery)
howmanyfields=rsDistrict.fields.count-1
'howmanyfields=rsDistrict.fields.count
'response.write howmanyfields & "<br>"
recCount = 0
if rsDistrict.eof then
	response.write "<br><font size='2'>The Parcel Number submitted (listed in blue font above) does not have a match in the GIS Fee District database.  If you would like to perform a search based on a different Parcel Number, please enter it here and click on the search button.<br></font>"
	response.write "<form name='permit' action='arcims_permits_process.asp' method='GET'>	<input maxlength='14' type='text' name='IDValue' size='14' value=''>&nbsp;&nbsp;<input type='submit' value='Search'></form>"
else
response.write "<TABLE width='100%'>"
	response.write "<TR BGCOLOR='#0000ff'>"
	response.write "<TH><FONT FACE='Arial' SIZE='1' color='#ffff00'><b>District Type</b></FONT></TH>"
	response.write "<TH><FONT FACE='Arial' SIZE='1' color='#ffff00'><b>Fee District</b></FONT></TH>"
	response.write"</TR>"
		
do while not rsDistrict.eof
		recCount = recCount + 1
		if (recCount/2 = recCount\2) then
			response.write "<TR BGCOLOR='#DDDDDD'>"
		else 
			response.write "<TR BGCOLOR='#EEEEEE'>"
		end if
		for i=0 to howmanyfields
		thisvalue = rsDistrict(i)
		if isnull(thisvalue) then
				thisvalue = "&nbsp;"
		end if
		response.write "<TD><FONT FACE='Arial' SIZE='1'>"
		response.write thisvalue
		response.write "</FONT></TD>"
			
		next
		rsDistrict.movenext
		response.write"</TR>"
loop
response.write"</TABLE>"
	
response.write "<br><font size='2'>If you would like to perform a search based on a different Parcel Number, please enter it here and click on the search button.<br></font>"
	response.write "<form name='permit' action='arcims_districts_process.asp' method='GET'>	<input maxlength='14' type='text' name='IDValue' size='14' value=''>&nbsp;&nbsp;<input type='submit' value='Search'></form>"
end if
response.write "<TABLE width='400'><tr><td><p align='right'><!---<input type=button name=btnClose value='Close' onclick='window.close()'>---></tr></td></TABLE>"
rsDistrict.close
set rsDistrict=nothing
conntemp.close
set conntemp=nothing


 %>

</FONT></body>
</html>
