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
session("ParcelLayerID")=6
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
	<title>Identify Brief Results</title>
</head>

<SCRIPT LANGUAGE='JavaScript' TYPE='text/javascript'>
	function SendValue(fnd,APN,QL) {
		top.MapFrame.positionLoadingLyr();
		
		var url = "SS/parcel_details.aspx?APN=" + APN
		top.MapFrame.url = "";
		top.MapFrame.SSRefreshMap(APN,url);
	}

</script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>

<body onload="top.HaltLYRHide=0; top.MapFrame.hideLoadingLyr();">

<!--#include file="../includes/header.aspx"-->
<% 
theFieldDescriptList = "APN,Address,Owner"
theFieldDescript = Split(theFieldDescriptList,",")

dbResultFieldDescriptList = "Parcel ID,Situs Address,Situs City/St/Zip,Owner,Mail Address,Mail City/St/Zip,Zoning,Landuse Code,Lot Size (sq ft),Tax Rate Area,Neighborhood Code,Thomas Bros,Lot Number,Parcel/Subd. No"
'Array holding Field names defined in dbResultFieldDescriptList
dbResultFieldDescript = Split(dbResultFieldDescriptList,",")

theNum = replace(request("APN"),"'","")
theNum = "'" & replace(theNum,",","','") & "'"

session("ds") = "Provider=SQLOLEDB.1;" & request("ds")

set conntemp=server.createobject("adodb.connection")
conntemp.open session("ds")
SQLquery = "SELECT cntyap_nbr,situs_add1,name FROM PARCELS WHERE cntyap_nbr in ("  & theNum & ") ORDER BY cntyap_nbr"

set rstemp=conntemp.execute(SQLquery)

response.write "<br><div align='center'><font color='#0000FF'><b><font size='2'>Brief Parcel Description</font></b></font><hr></div><br>"

if rstemp.eof then
response.write  "The selected parcel is a base parcel with many sub-parcels (for example, it may be a condominium complex).  If you wish to view the sub-parcel information, please select the 'Parcel Details' tool from the Select menu and reselect the parcel of interest. "
response.end
end if

'Create Tabular Display of Attribute Data***********************************
		howmanyfields=rstemp.fields.count-1
		recCount = 0
		do while not rstemp.eof
			recCount = recCount + 1
			response.write "<TABLE width='100%'>"
			for i=0 to howmanyfields
				response.write "<TR BGCOLOR='#EEEEEE'>"
				response.write "<TD><FONT FACE='Arial,sans-serif' SIZE='-2'><B>" & theFieldDescript(i) & "</B></FONT></TD>"
				response.write "<TD width='75%'><FONT FACE='Arial,sans-serif' SIZE='-2'>"
				thisvalue = rstemp(i)
				if isnull(thisvalue) then
					thisvalue = "&nbsp;"
				end if
				if dbResultFieldDescript(i) = "Parcel ID" then
					apnBook = left(thisvalue, 3)
					apnPage = mid(thisvalue,4,4)
					apnParcel = mid(thisvalue,8,3)
					apnSubParcel = right(thisvalue,4)
					response.write "<a href=javascript:SendValue(""" & Trim(CStr(session("Fld_SHP"))) & """,""" & thisvalue & """,""" & session("ParcelLayerID") & """);>" & apnBook&"-"&apnPage&"-"&apnParcel&"-"&apnSubParcel & "</a>"
				else
				response.write thisvalue
				end if
				response.write"</FONT></TD>"
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
