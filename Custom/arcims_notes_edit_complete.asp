<% response.expires = -7 %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>PARCEL NOTES ADMIN COMPLETE</title>
	
</head>
<SCRIPT LANGUAGE='JavaScript' TYPE='text/javascript'>
function sendNotes(IDValue) {
//alert("dsaf");
 var notesWin = window.open("arcims_notes_process.asp?IDValue=" + IDValue,"idWin2","toolbar=0,location=0,directories=0,status=0,menubar=1,scrollbars=1,width=700,height=425");

  notesWin.focus();


}
</script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>
<body bgcolor="white">
<!--#include file="dbParams.asp"--> 
<!--saccocsr revised--> 


<% 
set conntemp=server.createobject("adodb.connection")
conntemp.open dbSource

theType = request.form("theType")
theNum = request.form("theNum")
theNoteText = request.form("theNoteText")
theSection = request.form("theSection")
theEnteredBy = request.form("theEnteredBy")
theDate = request.form("theDate")
theReferTo = request.form("theReferTo")
theRetired = request.form("theRetired")
theNoteID = request.form("theNoteID")


'response.write "theType : " & theType & "<br>"
'response.write "theNoteID : " & theNoteID & "<br>"
'response.write "theNum : " & theNum & "<br>"
'response.write "theNoteText : " & theNoteText & "<br>"
'response.write "theSection : " & theSection & "<br>"
'response.write "theEnteredBy : " & theEnteredBy & "<br>"
'response.write "theDate : " & theDate & "<br>"
'response.write "theReferTo : " & theReferTo & "<br>"
'response.write "theRetired : " & theRetired & "<br>"


'---------------------------
'response.write "here"
'response.end


On Error Resume Next

if theSection = "Make Selection" then
		response.write "<br><br>A 'Section' must be selected before a record can be created.  Please select the back button and correct it.<br><br>"
		response.write "<div align='center'><input type=button name=btnBack value='Back' onclick='history.back();'></div>"
		'response.write theCompleteDate
		response.end
end if

if theNoteText = "" or isnull(theNoteText)=true then
		response.write "<br><br>A description of your note must be entered in the 'Note Text' box before a record can be created.  Please select the back button and correct it.<br><br>"
		response.write "<div align='center'><input type=button name=btnBack value='Back' onclick='history.back();'></div>"
		'response.write theCompleteDate
		response.end
end if


'Verify Date Entries----
	theDate = dateValue(theDate)
if theDate <> "" then
	theDate = dateValue(theDate)

	if theDate > date or isdate(theDate) = false then
		response.write "<br><br>The Date entered in the 'Date' field is inaccurate.  Please select the back button and correct it.<br><br>"
		response.write "<div align='center'><input type=button name=btnBack value='Back' onclick='history.back();'></div>"
		'response.write theCompleteDate
		response.end
	end if

end if

'------------------------------

IF theType = "EDIT" then
SQLnotes = "execute notes_updateNotesParcels @NOTE_ID= " & theNoteID &",@STAFF_ID = " & theEnteredBy &",@SECTION_ID= " & theSection &",@PARCEL_NUMBER= '" & theNum & "',@NOTE_DATE= '" & theDate & "',@REFER_TO= '" & theReferTo &"',@RETIRED_FLAG= " & theRetired &",@NOTE_TEXT= '" & theNoteText &"'"
else if theType = "ADD" then
SQLnotes = "execute notes_addNotesParcels @NOTEID= " & theNoteID &",@STAFFID = " & theEnteredBy &",@SECTIONID= " & theSection &",@PARCELNUMBER= '" & theNum & "',@REFERTO= '" & theReferTo &"',@RETIREDFLAG= 0,@NOTETEXT= '" & theNoteText &"'"
end if
end if

'response.write SQLnotes & "<br><br>"
'response.end

conntemp.execute(SQLnotes)


conntemp.close
set conntemp=nothing

If Err.Number = 0 then

response.write "<br><br><br><br><br><br><div align='center'>The changes to the Parcel Notes record have been successfully completed in the Parcel Notes database.<br><br></div>"
'response.write "<div align='center'><input type=button name=btnClose value='Okay' onclick='window.close();'></div>"
response.write "<div align='center'><input type=button name=btnClose value='Okay' onclick='javascript:sendNotes("""&theNum&""");window.close();'></div>"
else

response.write "<br><br><br><br><br><br><div align='center'>There was an error ("&Err.Number&") while modifying the Parcel Notes record.  Please contact Mark Perry at 916-875-6372.<br><br></div>"

end if

 %>
 

 
</FONT></body>
</html>

