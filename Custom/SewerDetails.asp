<%

on error resume next


	if trim(request("ds")) <> "" then
		session("ds") = "Provider=SQLOLEDB.1;" & request("ds")	'data source from .NET code
	end if

	dim conntemp, rstemp
	set conntemp=server.createobject("adodb.connection")
	conntemp.open session("ds")

	response.write "<TABLE width='100%'>"
	response.write "<TR BGCOLOR='#DDDDDD'>"
	response.write "<TD><FONT FACE='Arial,sans-serif' SIZE='-1'><B>"
	response.write "Sewer Plans"
	response.write "</TD></B><TD><FONT FACE='Arial,sans-serif' SIZE='-1'>"
	
	if trim(request("MH_ONE")) <> "" then
		theManholeNum=trim(request("MH_ONE"))
	end if
	
	if trim(request("MH_NO")) <> "" then
		theManholeNum=trim(request("MH_NO"))
	end if

	if trim(request("MH_FROM")) <> "" then
		theManholeNum=trim(request("MH_FROM"))
	end if

	' Query for available AS-Built Images ***********************
	SQLquery = "SELECT PLAN_NO, SHEET_NO FROM WQ_PIPE_SHEET_LINK WHERE MH_US = '"  & theManholeNum & "'" 
	'response.write SQLquery
	'response.end
	'response.write "Connected...<br>"
	set rsImagetemp=conntemp.execute(SQLquery)
	
	If rsImagetemp.eof then
		response.write "No Sewer Plan Images Currently Available."
	else
		if rsImagetemp("SHEET_NO") <> "NSD" then
		theSheetNo = rsImagetemp("SHEET_NO")
		else 
		theSheetNo = 99999
		end if
		'if rsImagetemp("SHEET_NO") contains a comma then
			'convert it to an array and toggle through array creating multiple rows of links all the while testing for preceeding o's
		'else
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
		
		response.redirect("http://erma.ecm.saccounty.net/WQ/WQDoclist.asp?idmDocCustom38=Engineering&idmDocCustom2=Drawing/Map&idmDocMVCustom9=" & rsImagetemp("PLAN_NO") & theSheetNo & "*&dbchk=1")

end if
%>

