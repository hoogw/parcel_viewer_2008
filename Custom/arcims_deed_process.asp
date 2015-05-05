<% response.expires = -7 %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>Deed Results</title>
</head>

<body>

<!--#include file="dbParams.asp"--> 
<FONT FACE="Arial,sans-serif" SIZE="-2">
<% 


esdbResultFieldDescriptList = "Deed Code, Deed Description"
esdbResultFields = Split(esdbResultFieldDescriptList,",")

'Data Extraction**********************************************************
theDeed = request.querystring("IDValue")
SQLquery = "SELECT * FROM DEED_CODES WHERE DEED_CODE = '"  & theDeed & "'" 
response.write "<div align='left'><font color='Blue'><b><font size='2'>Deed Code Table"
dim conntemp, rstemp
set conntemp=server.createobject("adodb.connection")
conntemp.open dbSource

'Header**********************************************************************
'response.write theNum&"</font></b></font></div>"
'response.write "<TABLE width='100%'><tr><td><p align='right'><!---<input type=button name=btnClose value='Close' onclick='window.close()'>--->&nbsp;</tr></td></TABLE>"	
set rstemp=conntemp.execute(SQLquery)

if not rstemp.eof then
'Create Tabular Display of Attribute Data***********************************
		howmanyfields=rstemp.fields.count-1
		recCount = 0
		do while not rstemp.eof
			recCount = recCount + 1
			'response.write "<b>Record " & recCount & "</b><br>"
			response.write "<TABLE width='100%'>"
			for i=0 to howmanyfields
				if (i/2 = i\2) then
					response.write "<TR BGCOLOR='#DDDDDD'>"
				else 
					response.write "<TR BGCOLOR='#EEEEEE'>"
				end if
				response.write "<TD width='40%'><FONT FACE='Arial,sans-serif' SIZE='-1'><B>" & esdbResultFields(i) & "</B></FONT></TD>"
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
		
			response.write"</TABLE><br>"
		loop

else
	response.write "<br><font size='2'>The Deed Code submitted does not have a match in the GIS database.  Please try again, and if the problem persists, contact Mark Perry at 875-6372.<br></font>"

end if
rstemp.close
set rstemp=nothing
conntemp.close
set conntemp=nothing
response.write "<TABLE width='100%'><tr><td><p align='right'><!---<input type=button name=btnClose value='Close' onclick='window.close()'>--->&nbsp;</tr></td></TABLE>"	
 %>
 
</FONT></body>
</html>
