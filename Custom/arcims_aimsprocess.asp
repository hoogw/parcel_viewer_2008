<% response.expires = -7 %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
	<title>AIMS DATA</title>
</head>
<SCRIPT LANGUAGE='JavaScript' TYPE='text/javascript'>
function sendDeed(theNum) {
      var deedWin = window.open("","Candidates","toolbar=0,location=0,directories=0,status=0,menubar=1,scrollbars=1,resizable=1,copyhistory=0,width=435,height=150");
   deedWin.location.href = "arcims_deed_process.asp?IDValue="+theNum;
      deedWin.focus();

}
</script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>
<body>

<!--#include file="dbParams.asp"--> 
<FONT FACE="Arial,sans-serif" SIZE="-2">
<% 



aimsdbTable = "AIMS"
aimsdbResultFieldList = "OWNER_CODE,ZONEING,LAND_USE_CODE,NEIGHBORHOOD__NBR,RESP,EFF_DATE_OF_OWN,RECORDERS_DATE,RECORDERS_PAGE,DEED_OR_SALE_DAT,DEED_TYPE,RELIABILITY_CODE,SALES_CODE,STAMP_CODE,STAMP_AMOUNT,MULTI_PARC_SALE,OWNER_INTEREST,APPRAISER_ACTION,NEW_APPRAISER,NEW_VALUE_LAND,NEW_VALUE_STRUCT,NEW_VALUE_P_P,NEW_VALUE_FIXT,NEW_VALUE_HEX,NEW_VALUE_EX,NEW_VALUE_DATE,NEW_VALUE_CODE,NEW_VALUE_ENT_DT,OLD_APPRAISER,OLD_VALUE_LAND,OLD_VALUE_STRUC,OLD_VALUE_P_P,OLD_VALUE_FIXT,OLD_VALUE_HEX,OLD_VALUE_EX,OLD_VALUE_DATE,OLD_VALUE_CODE,OLD_VALUE_ENT_DT,BASE_YEAR,BASE_VALUE_LAND,BASE_VALUE_STRUC"
aimsdbResultFields = Split(aimsdbResultFieldList,",")

aimsdbResultFieldDescriptList = "Owner Type,Zoning,Land Use Code,Neighborhood Number,Responsibility Code,Effective Date Of Ownership,Recorders Date,Recorders Page,Deed or Sale Date,Deed Type,Reliability Code,Sales Type,Stamp Code,Transfer Tax,Multi Parcel Sale,Partial Interest Transfer,Action Code,Pending Appraiser,Pending Value Land,Pending Value Structure,Pending Value Personal Property,Pending Value Fixtures,Pending Value Homeowners Exemption,Pending Value Exemption,Pending Value Date,Pending Value Code,Pending Value Entry Date,Prior Appraiser,Assessed Value Land,Assessed Value Structure,Assessed Value Personal Property,Assessed Value Fixtures,Assessed Value Homeowners Exemption,Assessed Value Exemption,Assessed Value Date,Assessed Value Code,Assessed Value Entry Date,Base Year,Base Value Land,Base Value Structure"
aimsdbResultFieldDescript = Split(aimsdbResultFieldDescriptList,",")

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

'***********************************************************************

test = thePCL + 1
'response.write thePCL
'response.write test

'***********************************************************************

'SQLquery = "SELECT " & apprdbResultFieldList & " FROM " & apprdbTable & " where MAPBOOK = '"  & theMAPB & "' and PAGE = '" & thePG & "' and PARCEL = '" & thePCL & "' and PARCEL_SUB = '" & thePSUB & "'"

SQLquery = "SELECT "& aimsdbResultFieldList & " FROM " & aimsdbTable & " where MAPBOOK = '"  & theMAPB & "' and PAGE = '" & thePG & "' and PARCEL = '" & thePCL & "' and PARCEL_SUB = '" & thePSUB & "'"

'response.write SQLquery

dim conntemp, rstemp
set conntemp=server.createobject("adodb.connection")


conntemp.open dbSource
set rstemp=conntemp.execute(SQLquery)

howmanyfields=rstemp.fields.count-1
'howmanyfields=rstemp.fields.count-1
'i=0
recCount = 0
response.write "<font size='2' color='Blue'><b>Assessor Information Managment System Data for Parcel : "

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
		response.write "<TD><FONT FACE='Arial,sans-serif' SIZE='-1'><B>" & aimsdbResultFieldDescript(i) & "</B></FONT></TD>"
		response.write "<TD><FONT FACE='Arial,sans-serif' SIZE='-1'>"
if aimsdbResultFieldDescript(i) = "Base Year" then
	if len(rstemp(i)) < 2 then
		thisvalue = "0" & rstemp(i)
	else
		thisvalue = rstemp(i)
	end if
else
thisvalue = rstemp(i)
end if

if aimsdbResultFieldDescript(i) = "Deed Type" then
		thisvalue = "<b><a href='Javascript:sendDeed("""&rstemp(i)&""")'><font color='Blue'>"&rstemp(i)&"</font></a></b>"
end if

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
