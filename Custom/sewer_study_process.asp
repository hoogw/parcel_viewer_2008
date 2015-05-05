<% response.expires = -7 %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
	<title>Identify Sewer Study Results</title>

</head>

<body >
<!-- METADATA TYPE="typelib"
			  FILE="C:\Program Files\Common Files\System\ado\msado15.dll" -->

<!--#include file="dbParams.asp"--> 

<% 

response.write "<br><div align='center'><font color='#0000FF'><b><font size='3'>Sewer Studies</font></b></font><hr></div><br>"

'Create Tabular Display of Attribute Data***********************************
theFilenetPath = "http://documents.ecm.saccounty.net/WQ/wqDocList.asp?Facility="

response.write "<TABLE width='100%'>"

theCount = 0
theSewerStudy0 = request.querystring("FACNO")
theSewerStudyName0 = request.querystring("PROJECT")

'theCount = request.querystring("theCount")
'theSewerStudy0 = request.querystring("theSewerStudy0")
'theSewerStudy1 = request.querystring("theSewerStudy1")
'theSewerStudy2 = request.querystring("theSewerStudy2")
'theSewerStudy3 = request.querystring("theSewerStudy3")
'theSewerStudy4 = request.querystring("theSewerStudy4")
'theSewerStudyName0 = request.querystring("theSewerStudyName0")
'theSewerStudyName1 = request.querystring("theSewerStudyName1")
'theSewerStudyName2 = request.querystring("theSewerStudyName2")
'theSewerStudyName3 = request.querystring("theSewerStudyName3")
'theSewerStudyName4 = request.querystring("theSewerStudyName4")
'response.write theCount & "<br>"
'response.write theSewerStudy0 & "<br>"
'response.write theSewerStudy1 & "<br>"
'response.end

for i = 0 to 4
	if i=0 then
	thisvalue = theSewerStudy0
	else if i=1 then
	thisvalue = theSewerStudy1
	else if i=2 then
	thisvalue = theSewerStudy2
	else if i=3 then
	thisvalue = theSewerStudy3
	else if i=4 then
	thisvalue = theSewerStudy4
	end if
	end if
	end if
	end if
	end if
	
	if isnull(thisvalue) or thisvalue = "" then
	thisvalue = 1
	end if
	
						'********************************************
						'****** Test FileNET DB Record Presence *****
						'******     based on BID Case Number    *****
						'********************************************
						Dim intNumber, objComm
						Set objComm = Server.CreateObject("ADODB.Command" )
					
						objComm.ActiveConnection = "Provider=SQLOLEDB.1;Password=GISUser;Persist Security Info=True;User ID=GISUser;Initial Catalog=fnetlib1;Data Source=PWAFNETLIB" 
'If Err.Number <> 0 then
'	response.write "<br><font size='2'>There is currently a problem accessing the Permit database.  Please check back soon.<br></font></table>"
'response.write "<TABLE width='400'><tr><td><p align='right'><!---<input type=button name=btnClose value='Close' onclick='window.close()'>---></tr></td></TABLE>"
'response.end
'end if
						objComm.CommandText = "scDocCountByFacNo"    
						objComm.CommandType = adCmdStoredProc
						
						objComm.Parameters.append objComm.CreateParameter("@sFacility", adVarChar, _
							adParamInput, 50, thisvalue )
						objComm.Parameters.append objComm.CreateParameter("@iCount", adInteger, _
							adParamOutput)
					
						objComm.Execute
						intNumber = objComm.Parameters("@iCount")
						
						'response.write "intNumber"&i&" = "&intNumber&"<br><br>"
			

				
			if i=0 then
'			 	if intNumber > 0 then
				response.write "<TR BGCOLOR='#EEEEEE'><TD><a href='"&theFilenetPath&theSewerStudy0&"' target='_blank'><FONT FACE='Arial,sans-serif' SIZE='-2' color='#0000ff'><B>" & theSewerStudyName0 & "</B></FONT></a></TD></TR>"
response.redirect(theFilenetPath&theSewerStudy0)
'				else
'					if thisvalue <> "" then
'				response.write "<TR BGCOLOR='#EEEEEE'><TD><FONT FACE='Arial,sans-serif' SIZE='-2' color='#0000ff'><B>"&theSewerStudyName0& "</B></FONT></a></TD></TR>"
'					end if
'				end if
			end if

			if i=1 then
			 	if intNumber > 0 then
				response.write "<TR BGCOLOR='#EEEEEE'><TD><a href='"&theFilenetPath&theSewerStudy1&"' target='_blank'><FONT FACE='Arial,sans-serif' SIZE='-2' color='#0000ff'><B>" & theSewerStudyName1 & "</B></FONT></a></TD></TR>"
response.redirect(theFilenetPath&theSewerStudy1)

				else
					if thisvalue <> "" then
				response.write "<TR BGCOLOR='#EEEEEE'><TD><FONT FACE='Arial,sans-serif' SIZE='-2' color='#0000ff'><B>"&theSewerStudyName1& "</B></FONT></a></TD></TR>"
					end if
				end if
			end if

			if i=2 then
				if intNumber > 0 then
				response.write "<TR BGCOLOR='#EEEEEE'><TD><a href='"&theFilenetPath&theSewerStudy2&"' target='_blank'><FONT FACE='Arial,sans-serif' SIZE='-2' color='#0000ff'><B>" & theSewerStudyName2 & "</B></FONT></a></TD></TR>"
response.redirect(theFilenetPath&theSewerStudy2)
				else
					if thisvalue <> "" then
				response.write "<TR BGCOLOR='#EEEEEE'><TD><FONT FACE='Arial,sans-serif' SIZE='-2' color='#0000ff'><B>"&theSewerStudyName2& "</B></FONT></a></TD></TR>"
					end if
				end if
			end if

			if i=3 then
				if intNumber > 0 then
				response.write "<TR BGCOLOR='#EEEEEE'><TD><a href='"&theFilenetPath&theSewerStudy3&"' target='_blank'><FONT FACE='Arial,sans-serif' SIZE='-2' color='#0000ff'><B>" & theSewerStudyName3 & "</B></FONT></a></TD></TR>"
response.redirect(theFilenetPath&theSewerStudy3)
				else
					if thisvalue <> "" then
				response.write "<TR BGCOLOR='#EEEEEE'><TD><FONT FACE='Arial,sans-serif' SIZE='-2' color='#0000ff'><B>"&theSewerStudyName3& "</B></FONT></a></TD></TR>"
					end if
				end if
			end if

			if i=4 then
				if intNumber > 0 then
				response.write "<TR BGCOLOR='#EEEEEE'><TD><a href='"&theFilenetPath&theSewerStudy4&"' target='_blank'><FONT FACE='Arial,sans-serif' SIZE='-2' color='#0000ff'><B>" & theSewerStudyName4 & "</B></FONT></a></TD></TR>"
response.redirect(theFilenetPath&theSewerStudy4)
				else
					if thisvalue <> "" then
				response.write "<TR BGCOLOR='#EEEEEE'><TD><FONT FACE='Arial,sans-serif' SIZE='-2' color='#0000ff'><B>"&theSewerStudyName4& "</B></FONT></a></TD></TR>"
					end if
				end if
			end if
next


			
'			next
		response.write"</TABLE><br>"
 %>
 
</body>
</html>
