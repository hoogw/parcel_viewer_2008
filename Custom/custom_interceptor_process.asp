<% response.expires = -7 %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>Identify Sewer Easement Interceptors</title>

</head>

<body >
<!-- METADATA TYPE="typelib"
			  FILE="C:\Program Files\Common Files\System\ado\msado15.dll" -->

<!--#include file="dbParams.asp"--> 

<% 
theInterceptorNum = request.querystring("NO")
theInterceptorName = request.querystring("INTERCEPTO")

response.write theInterceptorNum & "<br>"
response.write theInterceptorName & "<br>"
'response.end

response.write "<TD BGCOLOR='#DDDDDD'><FONT FACE='Arial,sans-serif' size='-2'><B>Interceptor Easements</B></FONT></TD>"
response.write "<TD BGCOLOR='#DDDDDD'><FONT FACE='Arial,sans-serif' size='-2'>"

						
If Pull_eRMA_Link(theInterceptorNum, 2) <> "" Then
thisvalue = "<valign='top'><font face='Arial' size='-2'><b><a href='javascript:sendRealEstate(""" & theNum & """);'><font color='Blue'>View Interceptor Easement Documents</font></a></b></font></td><td><font face='Arial' size='-2'>"
Else
thisvalue = "<valign='top'><font face='Arial' size='-2'>No Interceptor Easement Documents are available for this easement ID.</a></font></td><td><font face='Arial' size='-2'>"
End If
response.write"</FONT></TD></TR>"


'Real Estate

Public Function Pull_eRMA_Link(s_APN, iSource)
'- Check to see if documents exist for passed APN number

'b_Exists = Retrieve_DocID(s_APN, iSource)
'If cbool(b_Exists) = True Then
response.write s_APN & " -  " &iSource
'response.end
	Pull_eRMA_Link =  Build_Submit_APN_Body(s_APN, iSource)
'End If

End Function


response.write "<br><div align='center'><font color='#0000FF'><b><font size='3'>Sewer Interceptor Easement Documents</font></b></font><hr></div><br>"

'Create Tabular Display of Attribute Data***********************************
theFilenetPath = "http://documents.ecm.saccounty.net/WQ/wqDocList.asp?Facility="

response.write "<TABLE width='100%'>"




						'********************************************
						'****** Test FileNET DB Record Presence *****
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
			

				


				response.write "<TR BGCOLOR='#EEEEEE'><TD><a href='"&theFilenetPath&theInterceptorNum&"' target='_blank'><FONT FACE='Arial,sans-serif' SIZE='-2' color='#0000ff'><B>" & theInterceptorName & "</B></FONT></a></TD></TR>"



			
'			next
		response.write"</TABLE><br>"
 %>
 
</body>
</html>
