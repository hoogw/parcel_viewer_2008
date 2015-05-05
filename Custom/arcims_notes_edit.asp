<% response.expires = -7 %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>PARCEL NOTES ADMIN</title>
</head>

<body>
<!--#include file="dbParams.asp"--> 

<FONT FACE="Arial,sans-serif" SIZE="-2">

<%	
session.timeout = 5
session("username")= request.form("username")
session("password")= request.form("password")

If session("login")=0 then 

theUser = session("username")
thePass = session("password")

set conntemp=server.createobject("adodb.connection")
conntemp.open dbSource
SQLlogin = "Select * from NOTES_STAFF WHERE USERNAME = '" & theUser & "' AND PASSWORD = '" & thePass & "'"
set rsLogin = conntemp.execute(SQLlogin)

If Err.Number = 0 then
	if not rsLogin.eof then
		session("login")=1
		session("STAFF_ID") = rsLogin("STAFF_ID")
	end if
else
response.write "<br><br><br><br><br><br><div align='center'>The Username and Password entered are invalid or have timed out for Parcel Notes Administration.  <br><br></div>"
response.write "<div align='center'><input type=button name=btnClose value='Okay' onclick='javascript:window.close();'></div>"
	response.write "<br>"
	response.write "<br>If you are having problems logging in, please contact Mark Perry at (916) 875-6372<br><br><br>"
end if

conntemp.close
set conntemp=nothing

if theUser <> "" or isnull(theUser) = false then
response.write "<font color='Red'><div align='center'>The Username and Password entered are invalid or have timed out for Parcel Notes Administration.  <br><br></div>"
response.write "<div align='center'><input type=button name=btnClose value='Okay' onclick='javascript:window.close();'>"
	response.write "<br>"
	response.write "<br>If you are having problems logging in, please contact Mark Perry at (916) 875-6372</div><br><br><br></font>"
end if

response.write "<table>"
response.write "<h4>Parcel Notes Administration Login</h4>"
response.write "<table>"
response.write "<tr>"
response.write	"<td>"

'response.write	"<form action='Javascript:sendProject(frmLogin.username.value, frmLogin.password.value)' name='frmLogin' id='frmLogin'>"
response.write	"<form name='frmLogin' id='frmLogin' method='post'>"

response.write	"Enter User Name:&nbsp;<br>"
response.write "<input type='text' name='username' value='' size='20' maxlength='20'>"
response.write "<br>Enter Password:&nbsp;&nbsp;&nbsp<br>"
response.write "<input type='password' name='password' value='' size='20' maxlength='20'>"
response.write	"<br><br>"

response.write "<input type='hidden' name='check' value=" & strCheck & ">"

response.write	"<input type='submit' name='submit' value='Submit'>"
response.write	"</form></td>"
response.write "</tr>"
response.write "</table>"

%>

<% else %>


<% 

set conntemp=server.createobject("adodb.connection")
conntemp.open dbSource
theType = request.querystring("theType")
theSection = request.querystring("theSection")

if theType <> "ADD" then

		SQLSectionquery="SELECT Section_id FROM NOTES_SECTION WHERE SECTION_NAME ='"&theSection&"'"
		'response.write SQLSectionquery
		'response.end
		set rsSection=conntemp.execute(SQLSectionquery)
		testSection = rsSection("Section_ID")
		
		SQLquery="SELECT * FROM NOTES_STAFF_SECTION WHERE STAFF_ID ='"&session("STAFF_ID")&"'"
		'response.write SQLquery
		'response.end
		set rstemp=conntemp.execute(SQLquery)
		
		do while not rstemp.eof
			theStaffSection = rstemp("Section_ID")
			if theStaffSection = testSection then
				sectionCheck = "Good"
			exit do
			end if
			rstemp.movenext
		loop
		
		if sectionCheck <> "Good" then
		response.write "The User Account information entered is not authorized to administer this type of project."
		response.write "<div align='center'><input type=button name=btnClose value='Okay' onclick='javascript:window.close();'>"
		response.end
		end if

end if

theNoteID = request.querystring("theNoteID")
theNum = request.querystring("theNum")
'response.write theType &"..."& theSection&"..."& theNoteID&"..."
response.write "<font size='+1' color='Blue'>"
if theType = "EDIT" then
response.write "EDIT "
else
response.write "ADD "
end if
response.write "Parcel Notes Record</font><br><hr><br>"
'response.end


if theType = "EDIT" then

'*****************************************
'********    Edit Record    ********
'*****************************************


response.write "<font size='1'>If you would like to edit this record, please enter any changes, then select the <strong>'Save Changes'</strong> button.</font>"

response.write "<div align='right'><input type=button name=btnClose value='Cancel' onclick='window.close()'>&nbsp;&nbsp;</div>"

dbResultFieldDescriptList = "PARCEL NUMBER,NOTE TEXT,SECTION NAME,ENTERED BY,ENTERED DATE,REFER TO,NOTE ID,RETIRED"
dbResultFieldDescript = Split(dbResultFieldDescriptList,",")


response.write "<form name='frmEdit' method='post' action='arcims_notes_edit_complete.asp'>"
response.write "<input type='hidden' name='theType' value='"&theType&"'>"
SQLquery="SELECT * FROM vNOTES_PARCELS WHERE NOTE_ID ='"&theNoteID&"'"
'response.write SQLquery
'response.end
set rstemp=conntemp.execute(SQLquery)
if not rstemp.eof then

howmanyfields=rstemp.fields.count-1
'howmanyfields=rstemp.fields.count
'response.write howmanyfields & "<br>"
recCount = 0
do while not rstemp.eof
	recCount = recCount + 1
'	response.write "<b>Record " & recCount & "</b><br>"
	response.write "<TABLE width='100%'>"
	
	for i=0 to howmanyfields
		response.write "<TR BGCOLOR='#EEEEEE'>"
		
		If dbResultFieldDescript(i) = "NOTE ID" then
		i=i+1
		response.write "<TD><FONT FACE='Arial,sans-serif' SIZE='-2'><B>" & dbResultFieldDescript(i) & "</B></FONT></TD>"
		response.write "<input type='hidden' name='theNoteID' value='"&theNoteID&"'>"
		response.write "<input type='hidden' name='theNum' value='"&rstemp("PARCEL_NUMBER")&"'>"
		else
		response.write "<TD><FONT FACE='Arial,sans-serif' SIZE='-2'><B>" & dbResultFieldDescript(i) & "</B></FONT></TD>"
		end if
		
		response.write "<TD width='75%'><FONT FACE='Arial,sans-serif' SIZE='-1'>"
		thisvalue = rstemp(i)
		if isnull(thisvalue) then
			'thisvalue = "&nbsp;"
		end if

		if dbResultFieldDescript(i) = "PARCEL NUMBER" then
			response.write "<input type='text' name='theNumHyphen' value='"
'			&thisvalue&
				theNum = thisvalue
				apnBook = left(theNum, 3)
				apnPage = mid(theNum,4,4)
				apnParcel = mid(theNum,8,3)
				apnSubParcel = right(theNum,4)
				response.write apnBook&"-"&apnPage&"-"&apnParcel&"-"&apnSubParcel
			response.write "' readonly>"
		end if

		if dbResultFieldDescript(i) = "NOTE TEXT" then
			response.write "<textarea rows='6' name='theNoteText' cols='48'>"&thisvalue&"</textarea>"
		end if
		
		if dbResultFieldDescript(i) = "SECTION NAME" then
				SQLquery="SELECT * FROM vNOTES_STAFF_SECTION WHERE STAFF_ID ='"&session("STAFF_ID")&"'" 
				set rsSection=conntemp.execute(SQLquery)
				
				response.write "<select name='theSection' size='1'>"
				response.write "<option value='"&testSection&"' selected>"&theSection&"</option>"
				While not rsSection.eof
					if thisvalue <> rsSection("SECTION_NAME") then
					response.write "<option value='"&rsSection("SECTION_ID")&"'>"&rsSection("SECTION_NAME")&"</option>"
					end if
				rsSection.movenext
				wend	

		end if
		
		if dbResultFieldDescript(i) = "ENTERED BY" then
				SQLquery = "SELECT STAFF_ID FROM NOTES_STAFF WHERE NOTES_STAFF.STAFF_FIRST_NAME + ' ' + NOTES_STAFF.STAFF_LAST_NAME = '"&thisvalue&"'"
				set rsStaff=conntemp.execute(SQLquery)
			response.write "<input type='hidden' name='theEnteredBy' value='"&rsStaff("STAFF_ID")&"'>"
			response.write "<input type='text' name='theEnteredByDisplay' value='"&thisvalue&"' size='30' READONLY>"
		end if
		
		if dbResultFieldDescript(i) = "ENTERED DATE" then
			response.write "<input type='text' name='theDate' value='"&thisvalue&"' READONLY>"
		end if

		if dbResultFieldDescript(i) = "REFER TO" then
			response.write "<textarea rows='6' name='theReferTo' cols='48'>"&thisvalue&"</textarea>"
		end if
		
		if dbResultFieldDescript(i) = "RETIRED" then
'		response.write thisvalue
				response.write "<select name='theRetired' size='1'>"
			if thisvalue = "True" then
					response.write "<option value='1' selected>YES</option>"
					response.write "<option value='0'>NO</option>"
			else if thisvalue = "False" then
					response.write "<option value='0' selected>NO</option>"
					response.write "<option value='1'>YES</option>"
			else
					response.write "<option value='1'>YES</option>"
					response.write "<option value='0'>NO</option>"
			end if
			end if
				response.write "</select>"
		end if
	next
	rstemp.movenext
	response.write "</tr>"

		response.write "<TABLE width='100%'><tr><td width='35%' align='left'><input type='submit' value='Save Changes'>&nbsp;</td>"
		response.write "</form>"		
		response.write "<td width='35%' align='right'><input type=button name=btnClose value='Cancel' onclick='window.close()'>&nbsp;</td></tr></TABLE>"

loop

'*****************************************************************
end if
else if theType = "ADD" then

'*****************************************
'********    Add Record    ********
'*****************************************


response.write "<font size='1'>If you would like to add a new record, please enter the appropriate values, then select the <strong>'Add Record'</strong> button.</font>"

response.write "<div align='right'><input type=button name=btnClose value='Cancel' onclick='window.close()'>&nbsp;&nbsp;</div>"

dbResultFieldDescriptList = "PARCEL NUMBER,NOTE TEXT,SECTION NAME,ENTERED BY,ENTERED DATE,REFER TO,NOTE ID,RETIRED"
dbResultFieldDescript = Split(dbResultFieldDescriptList,",")


response.write "<form name='frmAdd' method='post' action='arcims_notes_edit_complete.asp'>"
response.write "<input type='hidden' name='theType' value='"&theType&"'>"

	response.write "<TABLE width='100%'>"
	for i=0 to 6
		response.write "<TR BGCOLOR='#EEEEEE'>"

		If dbResultFieldDescript(i) = "NOTE ID" then
		SQLquery = "SELECT MAX(NOTE_ID)+1 AS MAXNOTE FROM NOTES_PARCELS"
'		response.write SQLQuery
'		response.end
		set rsMax=conntemp.execute(SQLquery)
		i=i+1
		response.write "<TD><FONT FACE='Arial,sans-serif' SIZE='-2'><B>" & dbResultFieldDescript(i) & "</B></FONT></TD>"
		response.write "<input type='hidden' name='theNoteID' value='"&rsMax("MAXNOTE")&"'>"
		response.write "<input type='hidden' name='theNum' value='"&theNum&"'>"
		else
		response.write "<TD><FONT FACE='Arial,sans-serif' SIZE='-2'><B>" & dbResultFieldDescript(i) & "</B></FONT></TD>"
		end if
		
		response.write "<TD width='75%'><FONT FACE='Arial,sans-serif' SIZE='-1'>"

		if dbResultFieldDescript(i) = "PARCEL NUMBER" then
			response.write "<input type='text' name='theNumHyphen' value='"
				apnBook = left(theNum, 3)
				apnPage = mid(theNum,4,4)
				apnParcel = mid(theNum,8,3)
				apnSubParcel = right(theNum,4)
				response.write apnBook&"-"&apnPage&"-"&apnParcel&"-"&apnSubParcel
			response.write "' readonly>"
		end if

		if dbResultFieldDescript(i) = "NOTE TEXT" then
			response.write "<textarea rows='6' name='theNoteText' cols='48'></textarea>"
		end if
		
		if dbResultFieldDescript(i) = "SECTION NAME" then
				SQLquery="SELECT * FROM vNOTES_STAFF_SECTION WHERE STAFF_ID ='"&session("STAFF_ID")&"'" 
				set rsSection=conntemp.execute(SQLquery)
				
				response.write "<select name='theSection' size='1'>"
				response.write "<option value='Make Selection' selected>Make Selection</option>"
				While not rsSection.eof
					if thisvalue <> rsSection("SECTION_NAME") then
					response.write "<option value='"&rsSection("SECTION_ID")&"'>"&rsSection("SECTION_NAME")&"</option>"
					end if
				rsSection.movenext
				wend	

		end if
		
		if dbResultFieldDescript(i) = "ENTERED BY" then
		SQLNamequery="SELECT STAFF_FIRST_NAME, STAFF_LAST_NAME FROM NOTES_STAFF WHERE STAFF_ID ='"&session("STAFF_ID")&"'"
		'response.write SQLquery
		'response.end
		set rsName=conntemp.execute(SQLNamequery)
		
		response.write "<input type='hidden' name='theEnteredBy' value='"&session("STAFF_ID")&"'>"
		response.write "<input type='text' name='theEnteredByDisplay' value='"&rsName("STAFF_FIRST_NAME")&" "&rsName("STAFF_LAST_NAME")&"' size='30' READONLY><font size='-2'>will be changed to authentication name</font>"
		end if
		
		if dbResultFieldDescript(i) = "ENTERED DATE" then
			response.write "<input type='text' name='theDate' value='"&DATE&"' READONLY>"
		end if

		if dbResultFieldDescript(i) = "REFER TO" then
			response.write "<textarea rows='6' name='theReferTo' cols='48'></textarea>"
		end if
		
	next

	response.write "</tr>"

		response.write "<TABLE width='100%'><tr><td width='35%' align='left'><input type='submit' value='Add Record'>&nbsp;</td>"
		response.write "</form>"		
		response.write "<td width='35%' align='right'><input type=button name=btnClose value='Cancel' onclick='window.close()'>&nbsp;</td></tr></TABLE>"

else if theType <> "ADD" or theType <> "EDIT" then

response.write "<br><br><br><br>There was a problem accessing the requested record.  Please contact Mark Perry at 875-6372."
response.write "<td><p align='right'><input type=button name=btnClose value='Okay' onclick='window.close()'>&nbsp;</td></tr></TABLE>"

end if
end if
end if
				conntemp.close
				set conntemp=nothing

 %>
 
 
<% end if %>

</FONT></body>
</html>
