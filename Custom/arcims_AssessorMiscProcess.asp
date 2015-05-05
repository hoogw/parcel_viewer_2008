<% response.expires = -7 %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>ASSESSOR DATA</title>
</head>
<SCRIPT LANGUAGE='JavaScript' TYPE='text/javascript'>
function sendDeed(theNum) {
      var deedWin = window.open("","Candidates","toolbar=0,location=0,directories=0,status=0,menubar=1,scrollbars=1,resizable=1,copyhistory=0,width=435,height=150");
   deedWin.location.href = "arcims_deed_process.asp?IDValue="+theNum;
      deedWin.focus();

}
</script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>
<body>

<!--#include file="dbParams.asp"--> 
<FONT FACE="Arial,sans-serif" SIZE="-2">
<% 

assessordbTable = "vASSESSOR_MISC"
assessordbResultFieldList = "RECORDERS_DATE,RECORDERS_PAGE,GRANTOR,GRANTEE,DEED_OR_SALE_DAT,DEED_TYPE"
assessordbResultFields = Split(assessordbResultFieldList,",")

assessordbResultFieldDescriptList = "Recording Date,Recording Page,Grantor,Grantee,Deed or Sale Date, Deed Type"
assessordbResultFieldDescript = Split(assessordbResultFieldDescriptList,",")

theNum = request.querystring("IDValue")

if len(theNum) = 12 then
theApn = "00"&theNum
elseif len(theNum) = 13 then
theApn = "0"&theNum
else
theApn = theNum
end if

'response.write theNum & "<br>"

theMAPB = left(theNum, 3)
thePG = mid(theNum, 4, 4)
thePCL = mid(theNum, 8, 3)
thePSUB = mid(theNum, 11, 4)


'SQLquery = "SELECT "& assessordbResultFieldList &" FROM " & assessordbTable & " where MAPBOOK = '"  & theMAPB & "' and PAGE = '" & thePG & "' and PARCEL = '" & thePCL & "' and PARCEL_SUB = '" & thePSUB & "' ORDER BY RECORDERS_DATE"

SQLquery = "select " & assessordbResultFieldList & " from vASSESSOR_MISC where cntyap_nbr = '" & theNum & "'"

'response.write SQLquery
'response.end

dim conntemp, rstemp
set conntemp=server.createobject("adodb.connection")

conntemp.open dbSource
set rstemp=conntemp.execute(SQLquery)

'		howmanyfields=rstemp.fields.count-3
		howmanyfields=rstemp.fields.count-1
		'i=0
		recCount = 0
		response.write "<font size='2' color='Blue'><b>Assessor Data for Parcel : "

			apnBook = left(theApn, 3)
			apnPage = mid(theApn,4,4)
			apnParcel = mid(theApn,8,3)
			apnSubParcel = right(theApn,4)
response.write apnBook&"- "&apnPage&"- "&apnParcel&"- "&apnSubParcel
response.write "</font></b></font></div>"

'&theApn&"</b><br></font>"
		response.write "<TABLE width='365'><tr><td><p align='right'><!---<input type=button name=btnClose value='Close' onclick='window.close()'>---></tr></td></TABLE>"
		response.write "<div align='center'><font color='Blue' size='2'>Note that data presented in the table below was current at the date of sale.</div>"
'		do while not rstemp.eof
		'response.write "check howmanyfields ="&howmanyfields&"<br>"
'			recCount = recCount + 1
'		response.write "<b>Record " & recCount & "</b><br></font>"
			response.write "<TABLE width='100%'>"
			for i=0 to howmanyfields
				if (i/2 = i\2) then
					response.write "<TR BGCOLOR='#DDDDDD'>"
				else 
					response.write "<TR BGCOLOR='#EEEEEE'>"
				end if
				response.write "<TD><FONT FACE='Arial,sans-serif' SIZE='-1'><B>" & assessordbResultFieldDescript(i) & "</B></FONT></TD>"
				response.write "<TD><FONT FACE='Arial,sans-serif' SIZE='-1'>"
				thisvalue = rstemp(i)
				if isnull(thisvalue) then
					thisvalue = "&nbsp;"
				end if

				'capture transfer tax for use in calculating est. sales price
'				if salesdbResultFieldDescript(i) = "Transfer Tax" then
'					transferTax = rstemp(i)
'				end if
				if assessordbResultFieldDescript(i) = " Deed Type" then
				thisvalue = "<b><a href='Javascript:sendDeed("""&rstemp(i)&""")'><font color='Blue'>"&rstemp(i)&"</font></a></b>"
				end if
				response.write thisvalue
				response.write"</FONT></TD>"
				response.write"</TR>"
			next
		rstemp.movenext
		response.write"</TABLE><br>"
'response.write "234"
'response.end
'		loop
		response.write "<TABLE width='365'><tr><td><p align='right'><!---<input type=button name=btnClose value='Close' onclick='window.close()'>---></tr></td></TABLE>"
rstemp.close
set rstemp=nothing
conntemp.close
set conntemp=nothing
set theNum=nothing
set theApn=nothing
 %>
 
</FONT></body>
</html>
