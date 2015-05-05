<% response.expires = -7 %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>Selected Manholes</title>

</head>

<SCRIPT LANGUAGE='JavaScript' TYPE='text/javascript'>

		function sendManhole(manholeNum, Value1) {
		
      var myWin2 = window.open("","Candidates","toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,copyhistory=0,width=350,height=390");
   myWin2.location.href = "manhole_process.asp?mhole=" + manholeNum;
      myWin2.focus();

}	
</script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>

<body >
<!--#include file="dbParams.asp"--> 
<!--#include file="subdbtable.asp"-->
<% 
theCount = request.querystring("theCount")
theNums = request.querystring("theNums")

'response.write theCount&"<br>"
'response.write theNums&"<br>"
'response.write "Selected Manholes"
'response.end

arrNums = Split(theNums,",")

SQLquery = "SELECT MH_US, MH_DS, PIPE_SIZE, PIPETYPE FROM HANSEN WHERE " 

for i = 0 to theCount-1

	if i=theCount-1 then
		theWhere = theWhere & "MH_US = '"  & arrNums(i) & "' "
	else
		theWhere = theWhere & "MH_US = '"  & arrNums(i) & "' OR "
	end if

next

SQLquery = SQLquery & theWhere & "ORDER BY MH_US"

'response.write SQLquery
'response.end

dim conntemp, rstemp
set conntemp=server.createobject("adodb.connection")
conntemp.open dbSource
set rstemp=conntemp.execute(SQLquery)
howmanyfields=rstemp.fields.count-1
recCount = 0
response.write "<TABLE width='100%'>"
	response.write "<TR BGCOLOR='Blue'>"
'	for i=0 to howmanyfields
'		response.write "<TH><FONT COLOR='Yellow' FACE='Arial' SIZE='-1'>" & dbCandidateFieldDescript(i) & "</FONT></TH>"
		response.write "<TH><FONT COLOR='Yellow' FACE='Arial' SIZE='-1'>Selected Pipes</FONT></TH>"
'	next
	response.write"</TR>"
response.write"<TR>Select a Manhole hyperlink to obtain detailed information about the specific sewer pipe and manhole.</TR>"
response.write "</TABLE>"
response.write "<TABLE width='100%'>"
	
	do while not rstemp.eof
		recCount = recCount + 1
		if (recCount/2 = recCount\2) then
			response.write "<TR BGCOLOR='#DDDDDD'>"
		else 
			response.write "<TR BGCOLOR='#EEEEEE'>"
		end if

		for i=0 to howmanyfields
			thisvalue = rstemp(i)
			if isnull(thisvalue) then
				thisvalue = "&nbsp;"
			end if
'			response.write "<TD><FONT FACE='Arial' SIZE='-1'>"
			response.write "<FONT FACE='Arial' SIZE='-1'>"
			if rstemp(i).name = "MH_US" then
				'displayValue = rstemp(dbDisplayField) 
response.write "MH From : <a href=""javascript:sendManhole('" & thisvalue & "','" & recCount-1 & "')""><b>" & thisvalue & "</b></a>"
			else
				if i=1 then
				response.write "MH To : <b><font color='Navy'>"&thisvalue&"</font></b>"
				else if i=2 then
				response.write "Diameter (in) : <b><font color='Navy'>"&thisvalue&"</font></b>"
				else
				response.write "Pipe Type : <b><font color='Navy'>"&thisvalue&"</font></b>"
				end if
				end if
			end if
'			response.write "</FONT></TD>"
			response.write "</FONT><br>"
		next
		rstemp.movenext
		response.write"<br></TR>"
	loop
response.write"</TABLE>"
rstemp.close
set rstemp=nothing
conntemp.close
set conntemp=nothing

 %>
 
</body>
</html>
