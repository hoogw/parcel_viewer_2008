<% response.expires = -7 %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
	<title>Pipe Type Codes</title>
<!--#include file="../includes/header.aspx"-->
</head>

<body>


<!--#include file="dbParams.asp"--> 
<FONT FACE="Arial,sans-serif" SIZE="-2">
<% 
'dbResultFieldList = "*"
dbPipeTypeFieldDescriptList = "Code,Description,Last Updated"
dbPipeTypeFieldDescript = Split(dbPipeTypeFieldDescriptList,",")
thePipeType = request.querystring("pipeType")
SQLquery = "SELECT * FROM WQ_PIPE_TYPE WHERE PIPE_CODE = '"  & thePipeType & "'" 
dim conntemp, rsPipeType
set conntemp=server.createobject("adodb.connection")
conntemp.open dbSource
'response.write SQLquery
'response.write "Connected...<br>"
response.write "<font color='Blue'><b><font size='2'>Pipe Type Description</font></b></font><br>"
set rsPipeType=conntemp.execute(SQLquery)
howmanyfields=rsPipeType.fields.count-1
'howmanyfields=rsPipeType.fields.count
'response.write howmanyfields & "<br>"
recCount = 0
if rsPipeType.eof then

	response.write "<br><font size='2'>The Pipe Type record submitted does not have a match in the Pipe Type code table.  If you would like to search for the description of a different code, please enter it here and click on the search button.<br></font>"
	response.write "<form name='pipeType' action='pipe_type_process.asp' method='GET'>	<input maxlength='6' type='text' name='pipeType' size='6' value=''>&nbsp;&nbsp;<input type='submit' value='Search'></form>"


else
	do while not rsPipeType.eof
		recCount = recCount + 1
	'	response.write "<b>Record " & recCount & "</b><br>"
		response.write "<TABLE width='300'>"
		for i=0 to howmanyfields
			if (i/2 = i\2) then
				response.write "<TR BGCOLOR='#DDDDDD'>"
			else 
				response.write "<TR BGCOLOR='#EEEEEE'>"
			end if
			response.write "<TD width='100'><FONT FACE='Arial,sans-serif' SIZE='-1'><B>" & dbPipeTypeFieldDescript(i) & "</B></FONT></TD>"
			response.write "<TD width='200'><FONT FACE='Arial,sans-serif' SIZE='-1'>"
			thisvalue = rsPipeType(i)
			if isnull(thisvalue) then
				thisvalue = "&nbsp;"
			end if
			response.write thisvalue
			response.write"</FONT></TD>"
			response.write"</TR>"
		next
			response.write"</TABLE><br>"
		rsPipeType.movenext
	loop
	response.write "<br><font size='2'>If you would like to search for the description of a different code, please enter it here and click on the search button.<br></font>"
	response.write "<form name='pipeType' action='pipe_type_process.asp' method='GET'>	<input maxlength='6' type='text' name='pipeType' size='6' value=''>&nbsp;&nbsp;<input type='submit' value='Search'></form>"

end if

rsPipeType.close
set rsPipeType=nothing
conntemp.close
set conntemp=nothing


 %>

<a href="javascript:history.go(-1);">Click Here</a> to go back.

</FONT></body>
</html>
