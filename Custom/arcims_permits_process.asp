<% response.expires = -7 %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
	<title>Parcel Permit Results</title>
</head>
<SCRIPT LANGUAGE=JavaScript>
function permitSubmit(caseno) {
var value = "";
value = value + "idmDocCustom23 LIKE '%"+caseno+"'"; 
document.search.HiddenQueryCondition.value = value;
document.search.submit();
	}
	
	function permitStatusSubmit(theStatusNo) {	document.location= "arcims_permit_status_process.asp?theStatusNo="+theStatusNo; }

</script><noscript><b>Javascript MUST be enabled on your browser</b></noscript> 
<body>


<!-- METADATA TYPE="typelib"
			  FILE="C:\Program Files\Common Files\System\ado\msado15.dll" -->
<!--#include file="dbParams.asp"--> 
<FONT FACE="Arial,sans-serif" SIZE="-2">

<form name="search" action="http://bid.ecm.saccounty.net/mz_qresultGIS.asp" method="POST" target="_blank">
	<input type="hidden" name="idmDocCustom23" value="cbn2000-00027"> 
    <input type="hidden" name="NewSearch" value="1">
    <input type="hidden" name="HiddenQueryCondition" value="">
</form>

<% 
'dbResultFieldList = "*"
dbPermitFieldDescriptList = "Case Number,Case Type,Parcel Number,Permit Description,Target Date,Finaled Date,Issued Date,Project Name,Case Status,Project Number"
dbPermitFieldDescript = Split(dbPermitFieldDescriptList,",")
theNum = request.querystring("IDValue")
SQLquery = "SELECT * FROM PERMITS WHERE PARCEL_NUMBER = '"  & theNum & "'" 
'SQLquery = "SELECT " & dbResultFieldList & " FROM " & dbTable & " WHERE " & dbIDField & " = '"  & theNum & "'" 
dim conntemp2, rsPermit
set conntemp2=server.createobject("adodb.connection")
conntemp2.open session("ds")
'response.write SQLquery
'response.write "Connected...<br>"
response.write "<font color='Blue'><b><font size='2'>Permit Data For Parcel: "


			apnBook = left(theNum, 3)
			apnPage = mid(theNum,4,4)
			apnParcel = mid(theNum,8,3)
			apnSubParcel = right(theNum,4)
response.write apnBook&"- "&apnPage&"- "&apnParcel&"- "&apnSubParcel
response.write "</font></b></font></div>"

'&theNum&"</font></b></font><br>"
response.write "<TABLE width='400'><tr><td><p align='right'><!---<input type=button name=btnClose value='Close' onclick='window.close()'>---></tr></td></TABLE>"
response.write "This process may take a few seconds while the FileNET system is being scanned.<br><br>"
On Error Resume Next
set rsPermit=conntemp2.execute(SQLquery)

howmanyfields=rsPermit.fields.count-1
'howmanyfields=rsPermit.fields.count
'response.write howmanyfields & "<br>"
recCount = 0
if rsPermit.eof then
	response.write "<br><font size='2'>The Case Number submitted (listed in blue font above) does not have a match in the GIS Permit table.  Please note that our Permit data covers the unincorporated areas only.  If you would like to perform a search based on a different Case Number, please enter it here and click on the search button.<br></font>"
	response.write "<form name='permit' action='arcims_permits_process.asp' method='GET'>	<input maxlength='14' type='text' name='IDValue' size='14' value=''>&nbsp;&nbsp;<input type='submit' value='Search'></form>"
else
	do while not rsPermit.eof
		recCount = recCount + 1
		response.write "<b>Record " & recCount & "</b><br>"
'		response.write "a"
		response.write "<TABLE width='400'>"
		for i=0 to howmanyfields
			if (i/2 = i\2) then
				response.write "<TR BGCOLOR='#DDDDDD'>"
			else 
				response.write "<TR BGCOLOR='#EEEEEE'>"
			end if
			response.write "<TD width='120'><FONT FACE='Arial,sans-serif' SIZE='-1'><B>" & dbPermitFieldDescript(i) & "</B></FONT></TD>"
			response.write "<TD width='280'><FONT FACE='Arial,sans-serif' SIZE='-1'>"
			thisvalue = rsPermit(i)
			if isnull(thisvalue) then
				thisvalue = "&nbsp;"
			end if
			
			if dbPermitFieldDescript(i) = "Case Number" then
'			response.write "s"
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
						objComm.CommandText = "scCaseNoCount"    
						objComm.CommandType = adCmdStoredProc
						
						objComm.Parameters.append objComm.CreateParameter("@caseNo", adVarChar, _
							adParamInput, 50, thisvalue )
						objComm.Parameters.append objComm.CreateParameter("@Number", adInteger, _
							adParamOutput)
					
						objComm.Execute
						intNumber = objComm.Parameters("@Number")				
						'********************************************
'			response.write "f"
						if intNumber > 0 then
							response.write "<valign='top'><font face='Arial' size='-1'><b><a href='Javascript:permitSubmit("""&thisvalue&""")'>"&thisvalue&"</a></b></font> - Click to View FileNET Images for this Case #<font face='Arial' size='-1'>"
						else
							response.write thisvalue
						end if
			else if dbPermitFieldDescript(i) = "Case Type" then
			response.write thisvalue & " - "
			SQLquery = "SELECT * FROM PERMIT_CASE_TYPES WHERE CASE_TYPE = '"  & thisvalue & "'" 
			set rsPermitType=conntemp2.execute(SQLquery)
			response.write rsPermitType("CST_DESCRIPTION")
			else if dbPermitFieldDescript(i) = "Case Status" then
					response.write "<valign='top'><font face='Arial' size='-1'><b><a href='Javascript:permitStatusSubmit("""&thisvalue&""")'>"&thisvalue&"</a></b></font><font face='Arial' size='-1'>"
			else
			response.write thisvalue
			end if
			end if
			end if
			response.write"</FONT></TD>"
			response.write"</TR>"
		next
			response.write"</TABLE><br>"
		rsPermit.movenext
	loop
	response.write "<br><font size='2'>If you would like to perform a search based on a different Case Number, please enter it here and click on the search button.<br></font>"
	response.write "<form name='permit' action='arcims_permits_process.asp' method='GET'>	<input maxlength='14' type='text' name='IDValue' size='14' value=''>&nbsp;&nbsp;<input type='submit' value='Search'></form>"
end if
response.write "<TABLE width='400'><tr><td><p align='right'><!---<input type=button name=btnClose value='Close' onclick='window.close()'>---></tr></td></TABLE>"
rsPermit.close
set rsPermit=nothing
'conntemp.close
set conntemp=nothing

 %>

</FONT></body>
</html>
