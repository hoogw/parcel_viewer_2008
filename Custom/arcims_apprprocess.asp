<% response.expires = -7 %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
	<title>APPR DATA</title>
</head>

<body>

<!--#include file="dbParams.asp"--> 
<FONT FACE="Arial,sans-serif" SIZE="-2">
<% 
apprdbTable = "APPRAISALS"
apprdbResultFieldList = "QUALITY_CLASS,MODEL_NR,NR_OF_STORIES,SLAB_FLOOR,EFFECT_YR,ENTRY_HALL,DINING_ROOM,FAMILY_ROOM,NO_OF_BEDROOMS,NR_OF_BATHS,UTILITY_RM,SUPP_ROOMS,TOTAL_RMS,CONDITION,BUILT_INS,CENT_AC,FIREPLACE,ROOF_COVER,SOLAR_WATER_HTR,SOLAR_SPACE_HTR,FIRST_FLR_AREA,SEC_FLR_AREA,CONV_GARAGE_AREA,TOTAL_ADDN_AREA,AREA_FOR_MOD,FIN_BASEMNT_AREA,PARKING_SPACES,GARAGE_AREA,COV_PATIO,MISC_COST,POOL_COST,POOL_DATE,SQ_FEET_ACTUAL,LOT_ACRES,BASE_LOT_PCT,RESP,NEIGHBORHOOD_NR,RECORDERS_DATE,RECORDERS_PAGE,RELIABILITY_CODE,PERMIT_NR_1,PERMIT_DATE_1,PERMIT_DESC_1,PERMIT_VALUE_1,PERMIT_COMP_1,PERMIT_NR_2,PERMIT_DATE_2,PERMIT_DESC_2,PERMIT_VALUE_2,PERMIT_COMP_2,PERMIT_NR_3,PERMIT_DATE_3,PERMIT_DESC_3,PERMIT_VALUE_3,PERMIT_COMP_3,PERMIT_NR_4,PERMIT_DATE_4,PERMIT_DESC_4,PERMIT_VALUE_4,PERMIT_COMP_4,PERMIT_NR_5,PERMIT_DATE_5,PERMIT_DESC_5,PERMIT_VALUE_5,PERMIT_COMP_5"
apprdbResultFields = Split(apprdbResultFieldList,",")

apprdbResultFieldDescriptList = "Quality Class,Model Number,Stories,Floor,Effective Year,Entry Hall,Dining Room,Family Room,Bedrooms,Baths,Utility Room,Miscellaneous Rooms,Total Rooms,Condition,Built-in Appliances,Central Heat/Air,Fireplace,Roof Cover,Solar Water Heater,Solar Space Heater,First Floor Area,Second Floor Area,Converted Garage Area,Total Addition Area,Total Living Area,Finished Basement Area,Covered Parking Spaces,Garage Square Footage,Covered Patio,Miscellaneous Buildings Cost,Pool Cost,Pool Date,Lot (in square feet),Lot (in acres),Base Lot Percent,Responsibility Code,Neighborhood Number,Recording Date,Recording Page,Reliability Code,Permit 1,Permit Issue Date 1,Permit Code 1,Permit Application Value 1,Permit Status 1,Permit 2,Permit Issue Date 2,Permit Code 2,Permit Application Value 2,Permit Status 2,Permit 3,Permit Issue Date 3,Permit Code 3,Permit Application Value 3,Permit Status 3,Permit 4,Permit Issue Date 4,Permit Code 4,Permit Application Value 4,Permit Status 4,Permit 5,Permit Issue Date 5,Permit Code 5,Permit Application Value 5,Permit Status 5"
apprdbResultFieldDescript = Split(apprdbResultFieldDescriptList,",")

theNum = request.querystring("IDValue")

if len(theNum) = 12 then
theApn = "00"&theNum
elseif len(theNum) = 13 then
theApn = "0"&theNum
else
theApn = theNum
end if

'response.write theNum & "<br>"

theMAPB = left(theNum, 3)
thePG = mid(theNum, 4, 4)
thePCL = mid(theNum, 8, 3)
thePSUB = mid(theNum, 11, 4)

'SQLquery = "SELECT " & apprdbResultFieldList & " FROM " & apprdbTable & " where MAPBOOK = '"  & theMAPB & "' and PAGE = '" & thePG & "' and PARCEL = '" & thePCL & "' and PARCEL_SUB = '" & thePSUB & "'"

SQLquery = "SELECT "& apprdbResultFieldList &" FROM " & apprdbTable & " where MAPBOOK = '"  & theMAPB & "' and PAGE = '" & thePG & "' and PARCEL = '" & thePCL & "' and PARCEL_SUB = '" & thePSUB & "'"

'response.write SQLquery

dim conntemp, rstemp
set conntemp=server.createobject("adodb.connection")

conntemp.open dbSource
set rstemp=conntemp.execute(SQLquery)

howmanyfields=rstemp.fields.count-1
'howmanyfields=rstemp.fields.count-1
'i=0
recCount = 0
response.write "<font size='2' color='Blue'><b>Appraisal Data for Parcel : "


			apnBook = left(theApn, 3)
			apnPage = mid(theApn,4,4)
			apnParcel = mid(theApn,8,3)
			apnSubParcel = right(theApn,4)
response.write apnBook&"- "&apnPage&"- "&apnParcel&"- "&apnSubParcel
response.write "</font></b></font></div>"

'&theApn&"</b><br></font>"
response.write "<TABLE width='365'><tr><td><p align='right'><!---<input type=button name=btnClose value='Close' onclick='window.close()'>---></tr></td></TABLE>"
do while not rstemp.eof
'response.write "check howmanyfields ="&howmanyfields&"<br>"
	recCount = recCount + 1
'	response.write "<b>Record " & recCount & "</b><br>"
	response.write "<TABLE width='100%'>"
	for i=0 to howmanyfields
		if (i/2 = i\2) then
			response.write "<TR BGCOLOR='#DDDDDD'>"
		else 
			response.write "<TR BGCOLOR='#EEEEEE'>"
		end if
		response.write "<TD><FONT FACE='Arial,sans-serif' SIZE='-1'><B>" & apprdbResultFieldDescript(i) & "</B></FONT></TD>"
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
	response.write"</TABLE><br>"
loop
response.write "<TABLE width='365'><tr><td><p align='right'><!---<input type=button name=btnClose value='Close' onclick='window.close()'>---></tr></td></TABLE>"
rstemp.close
set rstemp=nothing
conntemp.close
set conntemp=nothing
set theNum=nothing
set theApn=nothing
 %>
 
</FONT></body>
</html>
