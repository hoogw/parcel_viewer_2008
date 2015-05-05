<% response.expires = -7 %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
	<title>Landmark Results</title>
<SCRIPT LANGUAGE='JavaScript' TYPE='text/javascript'>
		
	function sendValue(Value1) {
		top.MapFrame.positionLoadingLyr();
		
		var url="SS/parcel_details.aspx?APN=" + Value1
		top.MapFrame.url="";
		top.MapFrame.SSRefreshMap(Value1,url);
	}

	</script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>
<!--#include file="../includes/header.aspx"--> 
</head>

<body >
<!--#include file="dbParams.asp"--> 

<% 
theCategory = request("theCategory")
theBusiness = request("theBusiness")

if theCategory = "BUSINESS" then
SQLLandmarkQuery = "SELECT APN,LANDMARK FROM BUSINESS_LANDMARKS WHERE LANDMARK LIKE '"&theBusiness&"%' ORDER BY LANDMARK"
'response.write "The Business data is not finalized in production yet."
'response.end
else
SQLLandmarkQuery = "SELECT APN,LANDMARK FROM vwLANDMARKS_WITH_CATEGORY WHERE Description = '"&theCategory&"'"
end if

	dim conntemp, rstemp

	set conntemp=server.createobject("adodb.connection")
	conntemp.open session("ds")
	
	set rstemp=conntemp.execute(SQLLandmarkQuery)
	response.write "<TABLE width='365'><tr><td><p align='right'></tr></td></TABLE>"
	response.write "<br>Please select the Landmark hyperlink to create a map zoomed to and centered around a Landmark parcel and to view its parcel attibute data.  Please note that the selected parcel may or may not represent all parcels associated with the Landmark.<br><br>"
	recCount = 0
	response.write "<TABLE width='100%'><TR class=tblHdr><TH><font class=tblHdr>"&theCategory&" LANDMARKS</FONT></TH></TR>"
	
	do while not rstemp.eof
		recCount = recCount + 1
                If (recCount / 2 = recCount \ 2) Then
                    response.write "<TR class=tblRow1>"
                Else
                    response.write "<TR class=tblRow2>"
                End If
			thisvalue = rstemp("LANDMARK")
			thisAPN = rstemp("APN")
			if isnull(thisvalue) then
				thisvalue = "&nbsp;"
			end if
			response.write "<TD><font class=SSCol1>"
response.write "<a href=""javascript:sendValue('" & thisAPN & "')"">" & thisvalue & "</a>"
			response.write "</FONT></TD>"
		rstemp.movenext
		response.write"</TR>"
	loop
	response.write"</TABLE><br>"
	response.write "<font class=SSMsg2>"
	if recCount = 0 then
		response.write "Select the close button to close this window and return to the main application window.  If you are having difficulty finding a parcel, please refer to the 'Search Tips' or to the 'Help' section."
	end if
	response.write "</FONT>"
	
	response.write "<TABLE width='365'><tr><td><p align='right'></tr></td></TABLE>"
		response.write "<TABLE width='365'><tr><td><p align='left'><input type=button class=Btn name=btnClose value='Back to Search' onclick='history.back()'></tr></td></TABLE>"
	rstemp.close
	set rstemp=nothing
	conntemp.close
	set conntemp=nothing



 %>
 
</body>
</html>
