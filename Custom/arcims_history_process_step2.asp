<% response.expires = -7 %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
	<title>Parcel History Results</title>
</head>


<SCRIPT LANGUAGE='JavaScript' TYPE='text/javascript'>
function sendHistory(theNum) { document.location = "arcims_history_process.asp?IDValue="+theNum+"&curAPN="+theNum+"&theNext=1"; }
</script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>

<body>

<!--#include file="dbParams.asp"--> 
<FONT FACE="Arial,sans-serif" SIZE="-2">
<% 
'Header**********************************************************
curAPN = request.querystring("curAPN")
thePC_CREATE = request.querystring("PCCREATE")
'response.write curAPN &", "&thePC_CREATE
response.write "<font color='Blue'><b><font size='2'>CREATED/DELETED and ATTRIBUTES<BR>Parcel History Data For : <font color='Red'>"

			apnBook = left(curAPN, 3)
			apnPage = mid(curAPN,4,4)
			apnParcel = mid(curAPN,8,3)
			apnSubParcel = right(curAPN,4)
response.write apnBook&"- "&apnPage&"- "&apnParcel&"- "&apnSubParcel
response.write "</font></font></b></font></div>	"

response.write "<p align='right'><input type=button value='Back' onclick='window.history.back();'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<!---<input type=button name=btnClose value='Close' onclick='window.close()'>---></p>"


response.write "<font size='-1'>Parcel Numbers listed below were either created or deleted by the PC#.  Click on an APN below to view a parcel's history.</font><br><br>"

dim conntemp, rsHistory
set conntemp=server.createobject("adodb.connection")
conntemp.open session("ds")
'response.write SQLquery
'response.write "Connected...<br>"
SQLCreatequery = "SELECT DISTINCT NEW_PARCEL_NUMBER FROM vPSD_PARCEL_HISTORY WHERE PC_CREATE_NUMBER = '"&thePC_CREATE&"'"
SQLDeletequery = "SELECT DISTINCT OLD_PARCEL_NUMBER FROM vPSD_PARCEL_HISTORY WHERE PC_CREATE_NUMBER = '"&thePC_CREATE&"'"


set rsDeleted=conntemp.execute(SQLDeletequery)

response.write "<TABLE width='400'>"
	response.write "<TR BGCOLOR='#DDDDDD'>"
	response.write "<TD width='200'><FONT FACE='Arial,sans-serif' SIZE='-2'><B>DELETED PARCELS</B></FONT></TD>"
	response.write"</TR>"
DO WHILE NOT rsDeleted.eof
			response.write "<TR BGCOLOR='#EEEEEE'>"
			response.write "<TD width='200'><FONT FACE='Arial,sans-serif' SIZE='-2'>"
			thisvalue = rsDeleted("OLD_PARCEL_NUMBER")
			apnHyphen = left( thisvalue, 3) & "-" & mid(thisvalue,4,4) & "-" & mid(thisvalue,8,3) & "-" & right(thisvalue,4)
			if isnull(thisvalue) then
				thisvalue = "&nbsp;"
			end if

			response.write "<FONT FACE='Arial,sans-serif' SIZE='-2'><B><a href='JAVASCRIPT:sendHistory(""" & thisvalue & """)'>"
				if thisvalue = curAPN then
					response.write "<font color='Red'>"&apnHyphen&"</font>"
				else
					response.write apnHyphen
				end if
			response.write "</a></B></FONT>"

'			response.write thisvalue
			response.write"</FONT></TD>"
			response.write"</TR>"
		rsDeleted.movenext	
LOOP
response.write"</TABLE><br>"


set rsCreated=conntemp.execute(SQLCreatequery)

response.write "<TABLE width='400'>"
	response.write "<TR BGCOLOR='#DDDDDD'>"
	response.write "<TD width='200'><FONT FACE='Arial,sans-serif' SIZE='-2'><B>CREATED PARCELS</B></FONT></TD>"
	response.write"</TR>"
DO WHILE NOT rsCreated.eof
			response.write "<TR BGCOLOR='#EEEEEE'>"
			response.write "<TD width='200'><FONT FACE='Arial,sans-serif' SIZE='-2'>"
			thisvalue = rsCreated("NEW_PARCEL_NUMBER")
			apnHyphen = left( thisvalue, 3) & "-" & mid(thisvalue,4,4) & "-" & mid(thisvalue,8,3) & "-" & right(thisvalue,4)
			if isnull(thisvalue) then
				thisvalue = "&nbsp;"
			end if
			response.write "<FONT FACE='Arial,sans-serif' SIZE='-2'><B><a href='JAVASCRIPT:sendHistory(""" & thisvalue & """)'>"&apnHyphen&"</a></B></FONT>"
'			response.write thisvalue
			response.write"</FONT></TD>"
			response.write"</TR>"
		rsCreated.movenext	
LOOP
response.write"</TABLE><br>"


'//////////////////////////////////////////////////////////////////////////////////////////////////
'-- In the global.asa
'--Project Data Connection
Application("PSD_ConnectionString") = 	"Provider=MSDAORA.1; Data Source=psd; User ID=gis; Password=gis@psd;Persist Security Info=True;"
Application("PSD_ConnectionTimeout") = 15
Application("PSD_CommandTimeout") = 30
Application("PSD_CursorLocation") = 3
Application("PSD_RuntimeUserName") = "gis"
Application("PSD_RuntimePassword") = "gis@psd"
'-- In the .asp ----------------------
Dim cnnPSD, rsPSD, strSQL
Set cnnPSD = Server.CreateObject("ADODB.Connection")
cnnPSD.CommandTimeout = 30
cnnPSD.ConnectionTimeout = 20
cnnPSD.Open Application("PSD_ConnectionString"), Application("PSD_RuntimeUsername"), Application("PSD_RuntimePassword")
strSQL = "SELECT * FROM PSD.V_PARCEL_HISTORY_TEXT WHERE PARCEL_NUMBER_TEXT = '"&curAPN&"'"
Set rsHistory = Server.CreateObject("ADODB.RecordSet")
rsHistory.Open strSQL, cnnPSD, adOpenDynamic
'//////////////////////////////////////////////////////////////////////////////////////////////////


dbHistoryFieldDescriptList = "Unique ID,APN,Pacel Size,Land Use Code,Neighborhood Code,Parcel Status Code,Created By PC Number,Deleted By PC Number,Tax Rate Area,MS4 Created Parcel,MS4 Deleted Parcel"
dbHistoryFieldDescript = Split(dbHistoryFieldDescriptList,",")

	
	'Build Tabular Display of Attribute Data**************************
	howmanyfields=rsHistory.fields.count-1
	'howmanyfields=rsHistory.fields.count
	'response.write howmanyfields & "<br>"
	recCount = 0
	do while not rsHistory.eof
		recCount = recCount + 1
	'	response.write "<b>Record " & recCount & "</b><br>"
		response.write "<TABLE width='400'>"
		for i=0 to howmanyfields
			if dbHistoryFieldDescript(i) <> "Unique ID" then
				if (i/2 = i\2) then
					response.write "<TR BGCOLOR='#DDDDDD'>"
				else 
					response.write "<TR BGCOLOR='#EEEEEE'>"
				end if
				response.write "<TD width='200'><FONT FACE='Arial,sans-serif' SIZE='-2'><B>" & dbHistoryFieldDescript(i) & "</B></FONT></TD>"
				response.write "<TD width='200'><FONT FACE='Arial,sans-serif' SIZE='-2'>"
				thisvalue = rsHistory(i)
				if isnull(thisvalue) then
					thisvalue = "&nbsp;"
				end if
				if dbHistoryFieldDescript(i) = "APN" then
					response.write left( thisvalue, 3) & "-" & mid(thisvalue,4,4) & "-" & mid(thisvalue,8,3) & "-" & right(thisvalue,4)
				else
					response.write thisvalue
				end if
				response.write"</FONT></TD>"
				response.write"</TR>"
			end if
		next
			response.write"</TABLE><br>"
		rsHistory.movenext
	loop



response.write "<p align='right'><input type=button value='Back' onclick='window.history.back();'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<!---<input type=button name=btnClose value='Close' onclick='window.close()'>---></p>"

rsHistory.close
set rsHistory=nothing
conntemp.close
set conntemp=nothing
 %>
 
</FONT></body>
</html>
