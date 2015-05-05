<% response.expires = -7 %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
	<title>Parcel Notes</title>
</head>

<SCRIPT LANGUAGE='JavaScript' TYPE='text/javascript'>

function editNotes(theType, theSection, theNoteID, theNum) {

	//var notesEditWin = window.open("arcims_notes_edit.asp?theType="+theType+"&theSection="+theSection+"&theNoteID="+theNoteID+"&theNum="+theNum,"notesWin4","toolbar=0,resizable=1,location=0,directories=0,status=0,menubar=0,scrollbars=1,width=600,height=550");
	//notesEditWin.focus();
	
	var undef;
	
	if (theType=="EDIT") {
		opener.top.MapFrame.mnuGoParcelNotes(theNum,"e");
	} else {
		opener.top.MapFrame.mnuGoParcelNotes(theNum,"a");
	}
}

function sendNotes(theSection, IDValue) {
//alert(theSection);
self.location.href = "arcims_notes_process.asp?theSection="+theSection+"&IDValue=" + IDValue;
}
</script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>

<body>

<!--#include file="dbParams.asp"--> 
<FONT FACE="Arial,sans-serif" SIZE="-2">
<% 

'mpcnotes

gendbResultFieldDescriptList = "NOTE, SECTION, STAFF, DATE, REFER TO"
gendbResultFields = Split(gendbResultFieldDescriptList,",")
gendbResultFieldList = "NOTE_TEXT, SECTION_NAME, NOTES_FULL_NAME, NOTE_DATE, REFER_TO, NOTE_ID"


'Data Extraction**********************************************************
theNum = request.querystring("IDValue")
theSection = request.querystring("theSection")


SQLquery = "SELECT "&gendbResultFieldList&" FROM vNOTES_PARCELS WHERE PARCEL_NUMBER = '"  & theNum & "' and (isnull(RETIRED_FLAG,  0) = 0)" 

dim conntemp, rstemp
set conntemp=server.createobject("adodb.connection")
conntemp.open dbSource
'response.write SQLquery
'response.write "Connected...<br>"

			apnBook = left(theNum, 3)
			apnPage = mid(theNum,4,4)
			apnParcel = mid(theNum,8,3)
			apnSubParcel = right(theNum,4)

'******************** Select Box
'response.write "<form name='NotesForm' action='get'>"
notesSQLquery = "SELECT SECTION_NAME FROM dbo.NOTES_SECTION ORDER BY SECTION_NAME" 
set conntemp=server.createobject("adodb.connection")
conntemp.open dbSource
set rstemp=conntemp.execute(notesSQLquery)

response.write "<form name='NotesForm'>"
'************** Title
response.write "<div align='left'><font color='Gray'><b><font size='2'>Parcel Notes/Tags For Parcel: "
response.write "<font color='Blue'>"&apnBook&"- "&apnPage&"- "&apnParcel&"- "&apnSubParcel
response.write "</font></font></b></font>"
'************** End Title
response.write "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<select name='notes' size='1' onchange='Javascript:sendNotes(NotesForm.notes.value,"""&theNum&""")'>"

if theSection = "" or isnull(theSection) = true or theSection = "ALL" then
	response.write "<option selected value='ALL'>ALL</option>"
else
	response.write "<option value='ALL'>ALL</option>"
end if
	
 While NOT rstemp.EOF
 	thisvalue = rstemp("SECTION_NAME")
	
	if rstemp("SECTION_NAME") = theSection then
		response.write "<option selected value='" & thisvalue & "'>" & thisvalue & "</option>"
	else
		response.write "<option value='" & thisvalue & "'>" & thisvalue & "</option>"
	end if
	rstemp.MoveNext
  Wend

response.write "</select>"
rstemp.close
set rstemp=nothing
'response.write "<input type='submit' value='Find Projects' name='submit'><br>"
response.write "</form>"
'******************** End Select Box

response.write "</div><hr><br>"

'Header**********************************************************************
'response.write theNum&"</font></b></font></div>"
set rstemp=conntemp.execute(SQLquery)

'Create Tabular Display of Attribute Data***********************************
howmanyfields=rstemp.fields.count-1
'howmanyfields=rstemp.fields.count
'response.write howmanyfields & "<br>"
recCount = 0
	response.write "<div align='left'><font color='Blue'><b><font size='2'>Parcel Notes: "
	'response.write "</div><div align='right'><A HREF='JAVASCRIPT:editNotes(""ADD"",0,0,"""&theNum&""")'><FONT FACE='Arial' SIZE='2' COLOR='#0000FF'><b>Add New Note</b></A>&nbsp;&nbsp;</FONT></TD></div>"
	response.write "<TABLE width='100%'>"
	response.write "<TR BGCOLOR='#0000ff'>"
	'response.write "<TH width='5%'><FONT FACE='Arial' SIZE='2' color='#ffff00'><b>EDIT</b></FONT></TH>"
	response.write "<TH width='35%'><FONT FACE='Arial' SIZE='2' color='#ffff00'><b>NOTES</b></FONT></TH>"
	response.write "<TH width='15%'><FONT FACE='Arial' SIZE='2' color='#ffff00'><b>SECTION</b></FONT></TH>"
	response.write "<TH width='15%'><FONT FACE='Arial' SIZE='2' color='#ffff00'><b>STAFF</b></FONT></TH>"
	response.write "<TH width='10%'><FONT FACE='Arial' SIZE='2' color='#ffff00'><b>DATE</b></FONT></TH>"
	response.write "<TH width='30%'><FONT FACE='Arial' SIZE='2' color='#ffff00'><b>REFER TO</b></FONT></TH>"
	response.write"</TR>"
do while not rstemp.eof
	recCount = recCount + 1
'	response.write "<b>Record " & recCount & "</b><br>"
	
	
	
	if theSection = "" or isnull(theSection) = true or theSection = "ALL" then
		response.write "<TR BGCOLOR='#EEEEEE'>"
		for i=0 to howmanyfields
			if i=0 then
				'response.write "<TD><A HREF='JAVASCRIPT:editNotes(""EDIT"","""&rstemp("SECTION_NAME")&""","""&rstemp("NOTE_ID")&""","""&theNum&""")'><FONT FACE='Arial' SIZE='1' COLOR='#0000FF'><div align='center'>Edit</div></A></FONT></TD>"
			else
				response.write "<TD><FONT FACE='Arial' SIZE='1'>"
				x=i-1
				response.write trim(rstemp(x))
				response.write "</FONT></TD>"
			end if
		next
		response.write"</TR>"
	else
		if rstemp("SECTION_NAME") = theSection then
			response.write "<TR BGCOLOR='#EEEEEE'>"
			for i=0 to howmanyfields
				if i=0 then
					'response.write "<TD><A HREF='JAVASCRIPT:editNotes(""EDIT"","""&rstemp("SECTION_NAME")&""","""&rstemp("NOTE_ID")&""")'><FONT FACE='Arial' SIZE='1' COLOR='#0000FF'><div align='center'>Edit</div></A></FONT></TD>"
				else
					response.write "<TD><FONT FACE='Arial' SIZE='1'>"
				x=i-1
				response.write trim(rstemp(x))
					response.write "</FONT></TD>"
				end if
			next
			response.write"</TR>"
		end if
	end if
	
	rstemp.movenext

loop
	response.write"</TABLE><br>"

'==============================
response.write "<br><div align='left'><font color='Blue'><b><font size='2'>Parcel Tags: "
gendbResultFieldDescriptList = "Parcel Tag"
gendbResultFields = Split(gendbResultFieldDescriptList,",")

gendbResultFieldList = "Parcel Tag"

'Data Extraction**********************************************************

SQLquery = "SELECT TAG FROM PARCEL_TAGS WHERE PARCEL_NUMBER = '"  & theNum & "'" 
set rstemp=conntemp.execute(SQLquery)

'Create Tabular Display of Attribute Data***********************************
howmanyfields=rstemp.fields.count-1
'howmanyfields=rstemp.fields.count
'response.write howmanyfields & "<br>"
	response.write "<TABLE width='100%'>"
recCount = 0
do while not rstemp.eof
	recCount = recCount + 1
'	response.write "<b>Record " & recCount & "</b><br>"

	for i=0 to howmanyfields
'		if (i/2 = i\2) then
'			response.write "<TR BGCOLOR='#AAAAAA'>"
'		else 
			response.write "<TR BGCOLOR='#CCCCCC'>"
'		end if
		response.write "<TD width='65%'><FONT FACE='Arial,sans-serif' SIZE='-1'><B>" & gendbResultFields(i) & "</B></FONT></TD>"
		'response.write "<TR><TD>" & rstemp(i).name & "</TD>"
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


loop
	response.write"</TABLE><br>"
'===============================


rstemp.close
set rstemp=nothing
conntemp.close
set conntemp=nothing
response.write "<TABLE width='100%'><tr><td><p align='right'><!---<input type=button name=btnClose value='Close' onclick='window.close()'>--->&nbsp;</tr></td></TABLE>"	
 %>
 
</FONT></body>
</html>
