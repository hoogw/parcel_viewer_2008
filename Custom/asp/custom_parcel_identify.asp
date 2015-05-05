<!--- Custom Parcel Identify ASP file --->
<!--- Inputs: 
		APN		request("APN")		A comma delimited list of APN numbers
		ds		request("ds")		The data source connection string
	  REQUIREMENT:
		* <body onload="top.MapFrame.hideLoadingLyr()">
--->

<% 
response.expires = -7 

session("Fld_SHP")="APN"
session("ParcelLayerID")=1
%>

<html>
<head>
	<title>Identify Brief Results</title>
</head>

<script language="JavaScript">
	function SendValue(fnd,APN,QL) {
		top.MapFrame.positionLoadingLyr();
		top.MapFrame.clearBufUrl(1);
		var url = "SS/parcel_details.aspx?APN=" + APN
		top.MapFrame.url = "";
		top.MapFrame.SSRefreshMap(APN,url);
	}

</script>

<body onload="top.HaltLYRHide=0; top.MapFrame.hideLoadingLyr();">

<!--#include file="../includes/header.aspx"-->
<% 
theFieldDescript = Split("APN,Owner Name,Address,City,State,ZIP,Legal Desc,Lot Acres",",")

theNum = replace(request("APN"),"'","")
theNum = "'" & replace(theNum,",","','") & "'"

session("ds") = "Provider=SQLOLEDB.1;" & request("ds")

set conntemp=server.createobject("adodb.connection")
conntemp.open session("ds")
'SQLquery = "SELECT APN, situs, name_1, SQ_FT_L, Acreage FROM PARCELS WHERE APN in ("  & theNum & ") ORDER BY APN"
SQLquery = "SELECT apn,owner_name,p_address,s_city,'CA' as s_state,s_zip FROM PARCELS WHERE APN in ("  & theNum & ") ORDER BY APN"


'response.Write (SQLquery & "<br><br>" & session("ds") & "<br><br>")
set rstemp=conntemp.execute(SQLquery)

response.write "<br><div align='center'><font color='#0000FF'><b><font size='2'>Brief Parcel Description</b><hr></div><br>"

if rstemp.eof then
response.write  "The selected parcel does not exist in the database."
response.end
end if

'Create Tabular Display of Attribute Data***********************************
		howmanyfields=rstemp.fields.count-1
		recCount = 0
		do while not rstemp.eof
			recCount = recCount + 1
			response.write "<TABLE width='100%'>"
			for i=0 to howmanyfields
                If (i / 2 = i \ 2) Then
                    response.Write ("<TR class=tblRow1>")
                Else
                    response.Write ("<TR class=tblRow2>")
                End If
				response.write "<TD><B>" & theFieldDescript(i) & "</B></TD>"
				response.write "<TD width='75%'>"
				thisvalue = rstemp(i)
				if isnull(thisvalue) then
					thisvalue = "&nbsp;"
				end if
				if theFieldDescript(i) = "Parcel ID" then
					apnBook = left(thisvalue, 3)
					apnPage = mid(thisvalue,4,3)
					apnParcel = mid(thisvalue,7)
					response.write "<a href=javascript:SendValue(""" & Trim(CStr(session("Fld_SHP"))) & """,""" & thisvalue & """,""" & session("ParcelLayerID") & """);>" & apnBook&"-"&apnPage&"-"&apnParcel & "</a>"
				else
				response.write thisvalue
				end if
				response.write"</TD>"
				response.write"</TR>"
			next
		rstemp.movenext
		response.write"</TABLE><br>"
		loop
rstemp.close
set rstemp=nothing
conntemp.close
set conntemp=nothing
 %>
 
</body>
</html>
