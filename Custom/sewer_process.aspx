<%@ Page aspcompat=true %>
<% response.expires = -7 
dim idAlliFrame

if request("lyr")<> "" then
	session("lyr") = request("lyr")
end if

if request("idall")="true" then
	idAlliFrame=true
else
	idAlliFrame=false
end if

%>
<!-- MPCFile DWRViewer Entire File -->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
	<title>Sewer Search Results</title>
<!--#include file="../includes/Header.aspx"-->
</head>


<SCRIPT LANGUAGE='JavaScript' TYPE='text/javascript'>
function sendPipeType(Value1) {
		
	document.location= "pipe_type_process.asp?pipeType=" + Value1;

}

function sendDataProblems() {
	document.location= "data_problems.asp"
}

function ReSetDefaultLayer() {
	document.Rst.action="../ss/search_all.aspx?p=1&Mode=Reset&m=<%=request("m")%>"
	document.Rst.submit();
}

function SendValue(p1,p2) {

	var objWC = top.MapFrame.findObj("WhereClause")
	var objFN = top.MapFrame.findObj("SAFieldName")
	var objMF = top.MapFrame.findObj("MapFunction")
	var objQL = top.MapFrame.findObj("QueryLayer")
	var objC = top.MapFrame.findObj("CustomIDAllColour")
	var objZoomToFeature=top.MapFrame.findObj('ZoomToFeature');

	if (objWC!=null) {
		<%if idAlliFrame=true then%>
		if (objZoomToFeature!=null) { objZoomToFeature.value='N'; }
		<%else%>
		if (objZoomToFeature!=null) { objZoomToFeature.value='Y'; }
		<%end if%>
		top.MapFrame.positionLoadingLyr();
		objWC.value='&quot;' + p1 + '&quot; AND MH_TWO=&quot;' + p2 + '&quot;';
		objFN.value='MH_ONE';
		objMF.value=18;
		objC.value=255;
		objQL.value='<%=request("lyr")%>';
		top.MapFrame.RefreshMap();
	}
}
</script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>

<body>

<form name="Rst" method="post">
</form>

<% 

dim StartOverASP
dim mholedbResultFieldDescriptList
dim mholebResultFields
dim mholedbResultField
dim mholedbResultFieldList
dim theManholeNum1, theManholeNum2
dim mhstr
dim SQLquery as string
dim idALL
dim theManholeNum
dim theRequestType
dim howmanyfields
dim recCount as integer
dim i as integer
dim rsImagetemp
dim theSheetNo 
dim thisvalue

Session("BookMark").APN = ""
Session("BookMark").IDAllCoords = ""
Session("BookMark").IDAllLayers = ""
Session("BookMark").IDAllURL = ""
Session("BookMark").SearchAllQuery = ""
Session("BookMark").SearchAllParams = ""
Session("BookMark").SearchAllURL=Request.Url.ToString

StartOverASP="sewer.aspx?lyr=" & request("lyr")

mholedbResultFieldDescriptList = "U/S Manhole,D/S Manhole,Pipe Diameter (in),Pipe Length (ft),Pipe Type,U/S Depth (ft),Line Location,Line Type, U/S Elevation, D/S Elevation"
mholebResultFields = Split(mholedbResultFieldDescriptList,",")
mholedbResultField = "MH_US"
mholedbResultFieldList = "MH_US, MH_DS, PIPE_SIZE, PIPE_LENGTH, PIPETYPE, UPSDEPTH, LINELOC, LINE_TYPE, UPSELEV,DWNELEV"


'Data Extraction**********************************************************
theManholeNum1 = request.querystring("mhole1")
theManholeNum2 = request.querystring("mhole2")

idAlliFrame=False

if request.querystring("GVar") <> "" then
	idAlliFrame=True
	mhstr=left(request.querystring("GVar"),len(request.querystring("GVar"))-1)
	SQLquery = "SELECT " & mholedbResultFieldList & " FROM HANSEN WHERE MH_US in (" & mhstr & ")"  
else
	if theManholeNum1 = "" and theManholeNum2 = "" then
		idALL = "True"
		theManholeNum = request.querystring("FAC_ID")
	end if

	theRequestType = request.querystring("theRequestType")

	if theManholeNum1 <> "" and theManholeNum2 = "" then
		SQLquery = "SELECT " & mholedbResultFieldList & " FROM HANSEN WHERE MH_US = '"  & theManholeNum1 & "'"  
	end if
	if theManholeNum1 = "" and theManholeNum2 <> "" then
		SQLquery = "SELECT " & mholedbResultFieldList & " FROM HANSEN WHERE MH_DS = '"  & theManholeNum2 & "'"  
	end if
	if theManholeNum1 <> "" and theManholeNum2 <> "" then
		SQLquery = "SELECT " & mholedbResultFieldList & " FROM HANSEN WHERE MH_US = '"  & theManholeNum1 & "' and  MH_DS = '"  & theManholeNum2 & "'"  
	end if
end if

dim conntemp, rstemp
conntemp=server.createobject("adodb.connection")
conntemp.open ( "Provider=SQLOLEDB.1;" & Application("dbSource"))

response.write ("<!---" & SQLquery & "--->")

rstemp=conntemp.execute(SQLquery)

rstemp.movefirst()

'Exception (No Direct Match)************************************************

If rstemp.eof then
	if request("idall")="true" then
		response.write ("No Sewers selected.<br><br>")
		response.end
	end if

	response.write ("<font class=SSMsg2>Unfortunately, there is not a record in the sewer pipe database that matches the manhole number(s) that you supplied.<br><br>The format should be ###-###-###.  Please verify the manhole number(s) (particularly the first three numbers) and try again.<br><br>If you are still experiencing problems and you are confident that the manhole number(s) you are entering is correct, please contact Mark Perry at 875-6372.</font><br><br><a href='" & StartOverASP & "'>Click Here</a> to start over.")
	response.Write ("<br><font class=SSMsg2><a href='javascript:ReSetDefaultLayer();'>Click Here</a> to change the default layer(s) for Search All</font>")
else
	dim thePipe1,thePipe2

	thePipe1 = rstemp("MH_US").value
	thePipe2 = rstemp("MH_DS").value

	'if idAlliFrame=False then
	'	response.write ("<div align='left'><font color='Blue'><b><font size='2'>SEWER PIPE INFORMATION FOR - " & rstemp("MH_US") & rstemp("MH_DS")
	'else
	'	response.write ("<div align='left'><font color='Blue'><b><font size='2'>SEWER PIPE INFORMATION FOR PIPES (" & mhstr & ")"
	'end if
	'response.write theNum&"</font></b></font></div><br><br>"
	
	'Create Tabular Display of Attribute Data***********************************
	howmanyfields=rstemp.fields.count-1
	recCount = 0

		response.write ("<TABLE border='0' cellspacing='2' cellpadding='5' width=95% >")

		response.write ("<TR>")

		response.write ("<TH class=tblHdr align=center>Highlight</TD>")
		response.write ("<TH class=tblHdr align=center><nobr>Sewer Plans</nobr></TD>")

		for i = 0 to ubound (mholebResultFields)
			response.write ("<TH class=tblHdr align=center>" & mholebResultFields(i) & "</TD>")
		next

		do
	
			if rstemp.eof=true then exit do
			
			if (recCount/2 = recCount\2) then
				response.write ("<TR class=tblRow1>")
			else 
				response.write ("<TR class=tblRow2>")
			end if

			recCount=recCount+1
			'Highlight column
			'if request.querystring("GVar") <> "" then
				'ID All
	            'response.write ("<TD><a href='javascript:sendValue(""" & rstemp(0) & """,""" & session("lyr") & """,255);'><nobr>Click Here</nobr></a></TD>"
			'else
				'Search All
				response.write ("<TD><a href=""javascript:SendValue('" & rstemp(0).value & "','" & rstemp(1).value & "');""><nobr>Click Here</nobr></a></td>")
			'end if

			'Sewer Plans Column
			SQLquery = "SELECT PLAN_NO, SHEET_NO FROM WQ_PIPE_SHEET_LINK WHERE MH_US = '"  & rstemp(0).value & "'" 
			rsImagetemp=conntemp.execute(SQLquery)
			
			If rsImagetemp.eof then
				response.write ("<td>N/A</td>")
			else
			
				dim strVar
				
				strVar=""
				
				do
					if rsImagetemp.EOF then exit do

					if rsImagetemp("SHEET_NO") <> "NSD" then
						theSheetNo = rsImagetemp("SHEET_NO").value
					else 
						theSheetNo = 99999
					end if
					
					if theSheetNo="NSD" then
						theSheetNo="~~~"
					else if theSheetNo > 0 and theSheetNo < 10 then
						theSheetNo = "00"&rsImagetemp("SHEET_NO").value
					else if theSheetNo > 9 and theSheetNo < 100 then
						theSheetNo = "0"&rsImagetemp("SHEET_NO").value
					else if theSheetNo > 99 and theSheetNo < 1000 then
						theSheetNo = rsImagetemp("SHEET_NO").value
					else
						theSheetNo = ""
					end if
				
					strVar = strVar & rsImagetemp("PLAN_NO").value & theSheetNo & "$"
					
					'response.write ("<!---" & vbcrlf & rsImagetemp("PLAN_NO").value  & " --- " & theSheetNo & "--->" & vbcrlf)
					rsImagetemp.movenext()
				loop
				strVar=left(strVar,len(strVar)-1)
				
				response.Write ("<!---" & strVar & "--->")
				response.write ("<td><nobr><a href=http://erma.ecm.saccounty.net/WQ/WQDoclist.asp?idmDocCustom38=Engineering&idmDocCustom2=Drawing/Map&idmDocMVCustom9=" & strVar & "&dbchk=1 target=_new><font color='Blue'>Sewer Plans</font></a></nobr></td>")
			end if
			
			'The rest of the columns
			for i = 0 to howmanyfields

				thisvalue = rstemp(i).value
				if isdbnull(thisvalue) then
					thisvalue = "&nbsp;"
				end if
		
				response.Write ("<td>" & thisvalue & "</td>")
			next
			
			rstemp.movenext
		loop

	response.write ("</TABLE>")

	if (theRequestType <> "MouseClick" or idALL <> "False") and idAlliFrame=False then

		response.write ("<SCRIPT LANGUAGE='JavaScript' TYPE='text/javascript'>" & vbcrlf)
		response.write ("var objWC = top.MapFrame.findObj(""WhereClause"")" & vbcrlf)
		response.write ("var objFN = top.MapFrame.findObj(""SAFieldName"")" & vbcrlf)
		response.write ("var objMF = top.MapFrame.findObj(""MapFunction"")" & vbcrlf)
		response.write ("var objQL = top.MapFrame.findObj(""QueryLayer"")" & vbcrlf)
		response.write ("var objZoomToFeature=top.MapFrame.findObj('ZoomToFeature'); "  & vbcrlf)

		response.write ("if (objWC!=null) {" & vbcrlf)
		response.write ("	if (objZoomToFeature!=null) { objZoomToFeature.value='Y'; }" & vbcrlf)
		response.write ("	top.MapFrame.positionLoadingLyr();" & vbcrlf)
		response.Write ("	objWC.value='&quot;" & thePipe1 & "&quot; AND MH_TWO=&quot;" & thePipe2 & "&quot;';")
		response.write ("	objFN.value='MH_ONE';" & vbcrlf)
		response.write ("	objMF.value=18;" & vbcrlf)
		response.write ("	objQL.value='" & session("lyr") & "';" & vbcrlf)
		response.write ("	top.MapFrame.RefreshMap();" & vbcrlf)
		response.write ("}" & vbcrlf)

	    response.write ("</script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>")

	end if

end if

rstemp.close
rstemp=nothing
conntemp.close
conntemp=nothing

if idAlliFrame=False then

	if (recCount>0) then
		response.Write("<br><br><a href=""" & StartOverASP & """>Click Here</a> to start over.<br><br><br>")
		response.Write ("<font class=SSMsg2><a href='javascript:ReSetDefaultLayer();'>Click Here</a> to change the default layer(s) for Search All</font>")
	end if
end if

 %>
 
</FONT></body>
</html>
