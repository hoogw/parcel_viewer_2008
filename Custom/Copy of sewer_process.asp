<% response.expires = -7 

if request("lyr")<> "" then
	session("lyr") = request("lyr")
end if
%>
<!-- MPCFile DWRViewer Entire File -->

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>Sewer Search Results</title>
<!--#include file="../includes/header.aspx"-->
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

//For ID All (Does a Highlight)
	//function sendValue (IDValue,QL,C) { //xmin,xmax,ymin,ymax

//		var objWC = top.MapFrame.findObj("WhereClause")
//		var objMF = top.MapFrame.findObj("MapFunction")
//		var objQL = top.MapFrame.findObj("QueryLayer")
//		var objC = top.MapFrame.findObj("CustomIDAllColour")
//		var objZoomToFeature=top.MapFrame.findObj('ZoomToFeature'); 

//		if (objWC!=null) {
//			if (objZoomToFeature!=null) { objZoomToFeature.value='N'; }
//			top.MapFrame.positionLoadingLyr();
//			objWC.value=IDValue; 
//			objMF.value=29;
//			objC.value=C;
//			
//			objQL.value=QL;
//			top.MapFrame.RefreshMap();
//		}
//	}
//For Search All (does a ZOOM and HIGHLIGHT)
function SendValue(p1,p2) {

	var objWC = top.MapFrame.findObj("WhereClause")
	var objFN = top.MapFrame.findObj("SAFieldName")
	var objMF = top.MapFrame.findObj("MapFunction")
	var objQL = top.MapFrame.findObj("QueryLayer")
	var objZoomToFeature=top.MapFrame.findObj('ZoomToFeature');

	if (objWC!=null) {
		if (objZoomToFeature!=null) { objZoomToFeature.value='Y'; }
		top.MapFrame.positionLoadingLyr();
		objWC.value='&quot;' + p1 + '&quot; AND MH_TWO=&quot;' + p2 + '&quot;';
		objFN.value='MH_ONE';
		objMF.value=18;
		objQL.value='<%=request("lyr")%>';
		top.MapFrame.RefreshMap();
	}
}
</script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>

<body>

<!--#include file="dbParams.asp"--> 

<form name="Rst" method="post">
</form>

<FONT FACE="Arial,sans-serif" SIZE="-2">
<% 

StartOverASP="sewer.asp?lyr=" & request("lyr")

mholedbResultFieldDescriptList = "U/S Manhole,D/S Manhole,Pipe Diameter (in),Pipe Length (ft),Pipe Type,U/S Depth (ft),Line Location,Line Type, U/S Elevation, D/S Elevation, Depth"
mholebResultFields = Split(mholedbResultFieldDescriptList,",")
mholedbResultField = "MH_US"
mholedbResultFieldList = "MH_US, MH_DS, PIPE_SIZE, PIPE_LENGTH, PIPETYPE, UPSDEPTH, LINELOC, LINE_TYPE, UPSELEV,DWNELEV,UPSDEPTH"


'Data Extraction**********************************************************
theManholeNum1 = request.querystring("mhole1")
theManholeNum2 = request.querystring("mhole2")

idAlliFrame=False

if request.querystring("GVar") <> "" then
	idAlliFrame=True
	mhstr=left(request.querystring("GVar"),len(request.querystring("GVar"))-1)
	SQLquery = "SELECT "&mholedbResultFieldList&" FROM HANSEN WHERE MH_US in (" & mhstr & ")"  
else
	if theManholeNum1 = "" and theManholeNum2 = "" then
		idALL = "True"
		theManholeNum = request.querystring("FAC_ID")
	end if

	theRequestType = request.querystring("theRequestType")

	if theManholeNum1 <> "" and theManholeNum2 = "" then
		SQLquery = "SELECT "&mholedbResultFieldList&" FROM HANSEN WHERE MH_US = '"  & theManholeNum1 & "'"  
	end if
	if theManholeNum1 = "" and theManholeNum2 <> "" then
		SQLquery = "SELECT "&mholedbResultFieldList&" FROM HANSEN WHERE MH_DS = '"  & theManholeNum2 & "'"  
	end if
	if theManholeNum1 <> "" and theManholeNum2 <> "" then
		SQLquery = "SELECT "&mholedbResultFieldList&" FROM HANSEN WHERE MH_US = '"  & theManholeNum1 & "' and  MH_DS = '"  & theManholeNum2 & "'"  
	end if
end if

dim conntemp, rstemp
set conntemp=server.createobject("adodb.connection")
conntemp.open dbSource

set rstemp=conntemp.execute(SQLquery)

'Exception (No Direct Match)************************************************
If rstemp.eof then
	response.write "<font size='-1'>Unfortunately, there is not a record in the sewer pipe database that matches the manhole number(s) that you supplied.<br><br>The format should be ###-###-###.  Please verify the manhole number(s) (particularly the first three numbers) and try again.<br><br>If you are still experiencing problems and you are confident that the manhole number(s) you are entering is correct, please contact Mark Perry at 875-6372.</font><br><br><a href='" & StartOverASP & "'>Click Here</a> to start over."
	response.Write "<font class=SSMsg2><a href='javascript:ReSetDefaultLayer();'>Click Here</a> to change the default layer(s) for Search All</font>"
else
	dim thePipe1,thePipe2

	thePipe1 = rstemp("MH_US")
	thePipe2 = rstemp("MH_DS")

	'if idAlliFrame=False then
	'	response.write "<div align='left'><font color='Blue'><b><font size='2'>SEWER PIPE INFORMATION FOR - " & rstemp("MH_US") & rstemp("MH_DS")
	'else
	'	response.write "<div align='left'><font color='Blue'><b><font size='2'>SEWER PIPE INFORMATION FOR PIPES (" & mhstr & ")"
	'end if
	'response.write theNum&"</font></b></font></div><br><br>"
	
	'Create Tabular Display of Attribute Data***********************************
	howmanyfields=rstemp.fields.count-1
	recCount = 0

		response.write "<TABLE border='0' cellspacing='2' cellpadding='5' width=95% >"

		response.write ("<TR>")

		response.write ("<TH class=tblHdr align=center>Highlight</TD>")
		response.write ("<TH class=tblHdr align=center><nobr>Sewer Plans</nobr></TD>")

		for i = 0 to ubound (mholebResultFields)
			response.write ("<TH class=tblHdr align=center>" & mholebResultFields(i) & "</TD>")
		next

		do
	
			if rstemp.eof=true then exit do
			
			if (recCount/2 = recCount\2) then
				response.write "<TR class=tblRow1>"
			else 
				response.write "<TR class=tblRow2>"
			end if

			recCount=recCount+1
			'Highlight column
			'if request.querystring("GVar") <> "" then
				'ID All
	            'response.write "<TD><a href='javascript:sendValue(""" & rstemp(0) & """,""" & session("lyr") & """,255);'><nobr>Click Here</nobr></a></TD>"
			'else
				'Search All
				response.write "<TD><a href=""javascript:SendValue('" & rstemp(0) & "','" & rstemp(1) & "');""><nobr>Click Here</nobr></a></td>"
			'end if

			'Sewer Plans Column
			SQLquery = "SELECT PLAN_NO, SHEET_NO FROM WQ_PIPE_SHEET_LINK WHERE MH_US = '"  & rstemp(0) & "'" 
			set rsImagetemp=conntemp.execute(SQLquery)
			
			If rsImagetemp.eof then
				response.write "<td>N/A</td>"
			else
				if rsImagetemp("SHEET_NO") <> "NSD" then
					theSheetNo = rsImagetemp("SHEET_NO")
				else 
					theSheetNo = 99999
				end if
				
				if theSheetNo > 0 and theSheetNo < 10 then
					theSheetNo = "00"&rsImagetemp("SHEET_NO") 
				else if theSheetNo > 9 and theSheetNo < 100 then
					theSheetNo = "0"&rsImagetemp("SHEET_NO")
				else if theSheetNo > 99 and theSheetNo < 1000 then
					theSheetNo = rsImagetemp("SHEET_NO")
				else
					theSheetNo = ""
				end if
				end if
				end if
				
				response.write "<td><nobr><a href=http://erma.ecm.saccounty.net/WQ/WQDoclist.asp?idmDocCustom38=Engineering&idmDocCustom2=Drawing/Map&idmDocMVCustom9="&rsImagetemp("PLAN_NO")&theSheetNo&"*&dbchk=1 target=_new><font color='Blue'>Sewer Plans</font></a></nobr></td>"
			end if
			
			'The rest of the columns
			for i = 0 to howmanyfields

				thisvalue = rstemp(i)
				if isnull(thisvalue) then
					thisvalue = "&nbsp;"
				end if
		
				response.Write ("<td>" & thisvalue & "</td>")
			next
			
			rstemp.movenext
		loop

			'if mholebResultFields(i) = "U/S Manhole" then
			'		theBook = left(thisvalue, 3)
			'		thePage = mid(thisvalue, 4, 3)
			'		theMhole = mid(thisvalue, 7, 3)
			'		response.write theBook &"-"& thePage &"-"& theMhole
			'		thePipe=theBook&thePage&theMhole
			'else if mholebResultFields(i) = "D/S Manhole" then
			'		theBook = left(thisvalue, 3)
			'		thePage = mid(thisvalue, 4, 3)
			'		theMhole = mid(thisvalue, 7, 3)
			'		response.write theBook &"-"& thePage &"-"& theMhole

			'else if mholebResultFields(i) = "Pipe Type" then
			'	response.write"<a href='javascript:sendPipeType("""&thisvalue&""");'><font color='Blue'>"&thisvalue&"</font></a>"
			'else
			'	response.write thisvalue
			'end if
			'end if
			'end if

	response.write"</TABLE>"

	if (theRequestType <> "MouseClick" or idALL <> "False") and idAlliFrame=False then

		response.write "<SCRIPT LANGUAGE='JavaScript' TYPE='text/javascript'>" & vbcrlf
		response.write "var objWC = top.MapFrame.findObj(""WhereClause"")" & vbcrlf
		response.write "var objFN = top.MapFrame.findObj(""SAFieldName"")" & vbcrlf
		response.write "var objMF = top.MapFrame.findObj(""MapFunction"")" & vbcrlf
		response.write "var objQL = top.MapFrame.findObj(""QueryLayer"")" & vbcrlf
		response.write "var objZoomToFeature=top.MapFrame.findObj('ZoomToFeature'); "  & vbcrlf

		response.write "if (objWC!=null) {" & vbcrlf
		response.write "	if (objZoomToFeature!=null) { objZoomToFeature.value='Y'; }" & vbcrlf
		response.write "	top.MapFrame.positionLoadingLyr();" & vbcrlf
		response.Write "	objWC.value='&quot;" & thePipe1 & "&quot; AND MH_TWO=&quot;" & thePipe2 & "&quot;';"
		response.write "	objFN.value='MH_ONE';" & vbcrlf
		response.write "	objMF.value=18;" & vbcrlf
		response.write "	objQL.value='" & session("lyr") & "';" & vbcrlf
		response.write "	top.MapFrame.RefreshMap();" & vbcrlf
		response.write "}" & vbcrlf

	    response.write "</script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>"

	end if

end if

rstemp.close
set rstemp=nothing
conntemp.close
set conntemp=nothing

if idAlliFrame=False then

	if (recCount>0) then
		response.Write("<br><br><a href=""" & StartOverASP & """>Click Here</a> to start over.<br><br><br>")
		response.Write "<font class=SSMsg2><a href='javascript:ReSetDefaultLayer();'>Click Here</a> to change the default layer(s) for Search All</font>"
	end if

	response.write "<TABLE width='100%'><tr><td><p align='right'><input type=button name=btnPrint value='Print' onclick='window.print()'>&nbsp;</tr></td></TABLE>"	
end if

 %>
 
</FONT></body>
</html>
