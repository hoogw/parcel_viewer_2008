<% 

sub query2table(inputQuery, theType)
	response.write "Creating list of candidates..."
	response.write "If your search has a single match, you will automatically be forwarded to the Parcel data page."
	dim conntemp, rstemp
	set conntemp=server.createobject("adodb.connection")
	conntemp.open session("ds")
	
	set rstemp=conntemp.execute(inputQuery)

	response.write "<TABLE width='365'><tr><td><p align='right'><!---<input type=button name=btnClose value='Close' onclick='window.close()'>---></tr></td></TABLE>"
	response.write "<br>Please select the Parcel ID hyperlink to view parcel attibute data.<br><br>"
	'inputQuery1 = replace(inputQuery, "'", "zz")
	'inputQuery1 = replace(inputQuery1, "%", "yy")
	'Response.Write "<a href='download.asp?sql=" & inputQuery1 & "' >Download Option</a><p>"
	howmanyfields=rstemp.fields.count-1
	recCount = 0
	response.write "<TABLE width='100%'>"
	response.write "<TR BGCOLOR='Blue'>"
	for i=0 to howmanyfields
		response.write "<TH><FONT COLOR='Yellow' FACE='Arial' SIZE='-1'>" & dbCandidateFieldDescript(i) & "</FONT></TH>"
	next
	response.write"</TR>"
	do while not rstemp.eof
		recCount = recCount + 1
		if (recCount/2 = recCount\2) then
			response.write "<TR BGCOLOR='#DDDDDD'>"
		else 
			response.write "<TR BGCOLOR='#EEEEEE'>"
		end if

		for i=0 to howmanyfields
			thisvalue = rstemp(i)
			if isnull(thisvalue) then
				thisvalue = "&nbsp;"
			end if
			isHyper = false
			response.write "<TD><FONT FACE='Arial' SIZE='-1'>"
			if layerLinkField = rstemp(i).name then
				displayValue = rstemp(dbDisplayField) 
response.write "<a href=""javascript:sendValue('" & thisvalue & "','" & theType & "')"">" & thisvalue & "</a>"
			theForward  = thisvalue
			else
				response.write thisvalue
			end if
			response.write "</FONT></TD>"
		next
		rstemp.movenext
		response.write"</TR>"
	loop
	response.write"</TABLE><br>"
	response.write "<FONT FACE='Arial' SIZE='-1'>"
	if recCount = 0 then
		if theType = "address" then
							if (theNum = "") then
							addressQuery = "SELECT APN FROM MULTIPLE_PARCEL_ADDRESSES WHERE ST_NAME_MIDDLE LIKE '" & theStr & "%'"
							else
							addressQuery = "SELECT APN FROM MULTIPLE_PARCEL_ADDRESSES WHERE ADDR_NBR = "  & theNum & " AND ST_NAME_MIDDLE LIKE '" & theStr & "%'"
							end if
							'response.write addressQuery & "<br>"
							'response.end
							set rsAddress=conntemp.execute(addressQuery)
							
							if not rsAddress.eof then
	SQLquery = "SELECT " & dbCandidateFieldList & " FROM " & dbTable & " WHERE CNTYAP_NBR = '" & rsAddress("APN")&"'"
							'response.write SQLquery
							'response.end
							set rstemp=conntemp.execute(SQLquery)
							END IF
							howmanyfields=rstemp.fields.count-1
							recCount = 0
							response.write "<TABLE width='100%'>"
							do while not rstemp.eof
								recCount = recCount + 1
								if (recCount/2 = recCount\2) then
									response.write "<TR BGCOLOR='#DDDDDD'>"
								else 
									response.write "<TR BGCOLOR='#EEEEEE'>"
								end if
						
								for i=0 to howmanyfields
									thisvalue = rstemp(i)
									if isnull(thisvalue) then
										thisvalue = "&nbsp;"
									end if
									isHyper = false
									response.write "<TD><FONT FACE='Arial' SIZE='-1'>"
									if layerLinkField = rstemp(i).name then
										displayValue = rstemp(dbDisplayField) 
						response.write "<a href=""javascript:sendValue('" & thisvalue & "','" & theType & "')"">" & thisvalue & "</a>"
									theForward  = thisvalue
									else
										response.write thisvalue
									end if
									response.write "</FONT></TD>"
								next
								rstemp.movenext
								response.write"</TR>"
							loop
							response.write"</TABLE><br>"
							if recCount = 0 then
								response.write "No matching records."
								response.write "Select the close button to close this window and return to the main application window.  If you are having difficulty finding a parcel, please refer to the 'Search Tips' or to the 'Help' section."
							elseif recCount = 1 then
								response.write "1 matching record..."
								response.write "You will be automatically forwarded to the Parcel data page."
								response.write " <SCRIPT TYPE='text/javascript' LANGUAGE='JavaScript'>"
								response.write "javascript:sendValue("""&theForward	&""");"
								response.write "</script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>"
							else
								response.write recCount & " matching records."
							end if

		else
		response.write "No matching records."
		response.write "Select the close button to close this window and return to the main application window.  If you are having difficulty finding a parcel, please refer to the 'Search Tips' or to the 'Help' section."
		end if
		
	elseif recCount = 1 then
		response.write "1 matching record..."
		response.write "You will be automatically forwarded to the Parcel data page."
		response.write " <SCRIPT TYPE='text/javascript' LANGUAGE='JavaScript'>"
		response.write "javascript:sendValue("""&theForward	&""");"
		response.write "</script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>"
	else
		response.write recCount & " matching records."
	end if
	response.write "</FONT>"
	rstemp.close
	set rstemp=nothing
	conntemp.close
	set conntemp=nothing
end sub
 %>