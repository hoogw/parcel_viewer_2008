<!DOCTYPE HTML PUBLIC '-//W3C//DTD HTML 4.0 Transitional//EN'>

<html>
<head>
	<title>Untitled</title>
</head>

<body bgcolor='white'>

<!--#include file="dbParams.asp"--> 
<%

'response.write "test"
'response.end


'**********  Create Parcel Attribute Dataset / Hyphenate APN   ***************
thisvalue = session("theNum")
set conntemp=server.createobject("adodb.connection")
conntemp.open dbSource
SQLquery = "select * from vPARCEL_CHARACTERISTICS where cntyap_nbr = '"&thisvalue&"'"
set rstemp=conntemp.execute(SQLquery)

apnBook = left(thisvalue, 3)
apnPage = mid(thisvalue,4,4)
apnParcel = mid(thisvalue,8,3)
apnSubParcel = right(thisvalue,4)
'*****************************************************************************
					
					
'  Begin Assessor Presentation
Response.write  "<TABLE width='100%'  bordercolor='white' bordercolordark='white' bordercolorlight='white'>"
Response.write  " <TR><TD></TD>"
Response.write  "    <TD width='300'>"
Response.write  "      <P align=center><STRONG>ASSESSOR'S PARCEL NUMBER&nbsp;</STRONG></P></TD><TD width='300' bgcolor='yellow'><P align=center><STRONG>&nbsp;"&apnBook&"-"&apnPage&"-"&apnParcel&"-"&apnSubParcel&"</STRONG></P></TD><TD></TD></TR></TABLE>"
Response.write  "<P><BR></P>"
Response.write  "<P><TABLE width='100%'  bordercolor='white' bordercolordark='white' bordercolorlight='white'>"
  
Response.write  "<TR><TD></TD>"
Response.write  "		 <TD bgcolor='navy'>"
Response.write  "      <P align=center><STRONG><font color='Yellow'><A NAME='LAND'>LAND INFORMATION</a></font></STRONG> "
Response.write  "</P> </TD><TD></TD></TR></TABLE></P>"

Response.write  "<P><TABLE width='100%' bordercolor='black' bordercolordark='gray' bordercolorlight='white'>"
  
Response.write  " <TR><TD></TD>    <TD></TD>    <TD></TD>    <TD></TD></TR>  <TR>    <TD></TD>"
Response.write  "    <TD width='300' bgcolor='EEEEEE'>"
Response.write  "      <P align=right>THOMAS BROTHERS COORDINATES&nbsp;</P></TD>"

'******************************  Thomas Bros Grid Coordinates   ***************
SQLquery = "SELECT PRC FROM PARCELS WHERE " & dbIDField & " = '"  & thisvalue & "'" 
set rsTBM=conntemp.execute(SQLquery)
'******************************************************************************

Response.write  " <TD  width='300' bgcolor='white'>&nbsp;"&rsTBM("PRC")&"</TD>"
Response.write  "    <TD></TD></TR>  <TR>    <TD></TD>"
Response.write  "    <TD bgcolor='EEEEEE'>"
Response.write  "      <P align=right>ASSESSOR'S LAND USE CODE&nbsp;</P>   </TD>"
Response.write  "    <TD bgcolor='yellow'>&nbsp;      "&rstemp("LAND_USE_CODE")&"</TD>"
Response.write  "    <TD></TD></TR>"
Response.write  "  <TR>    <TD>      </TD>"
Response.write  "    <TD bgcolor='EEEEEE'>"
Response.write  "      <P align=right>SUBDIVISION NAME&nbsp;</P> </TD>"
Response.write  "    <TD bgcolor='white'>&nbsp;      "&rstemp("SUBDIVISION_NAME")&"</TD>"
Response.write  "    <TD></TD></TR>  <TR>    <TD>      </TD>"
Response.write  "    <TD bgcolor='EEEEEE'>"
Response.write  "      <P align=right>LOT NUMBER&nbsp;</P> </TD>"
Response.write  "    <TD bgcolor='white'>&nbsp;      "&rstemp("LOT")&"</TD>"
Response.write  "    <TD></TD></TR>  <TR>    <TD>      </TD>"
Response.write  "    <TD bgcolor='EEEEEE'>"
Response.write  "      <P align=right>PARCEL AREA&nbsp;</P> </TD>"
Response.write  "    <TD bgcolor='white'>&nbsp;"&rstemp("LOTSIZE")&"</TD>"
Response.write  "    <TD></TD></TR>  <TR>    <TD></TD>    <TD></TD>    <TD></TD>    <TD></TD></TR></TABLE></P><P><BR></P><P>"
Response.write  "<TABLE width='100%'  bordercolor='white' bordercolordark='white' bordercolorlight='white'>"
  
 Response.write  " <TR><TD></TD>"
Response.write  "    <TD bgcolor='navy'>"
Response.write  "      <P align=center><font color='Yellow'><STRONG><A NAME='Building'>BUILDING INFORMATION</STRONG></font> "
Response.write  "    </P> </TD><TD></TD></TR></TABLE>	<br>"
Response.write  "<TABLE width='100%' bordercolor='black' bordercolordark='gray' bordercolorlight='white'>"
  
Response.write  "  <TR>    <TD></TD>    <TD></TD>    <TD></TD>    <TD></TD>   <TD></TD>    <TD></TD></TR>  <TR>"
Response.write  "    <TD bgcolor='EEEEEE'>FIRST FLOOR</TD>"
Response.write  "    <TD bgcolor='white'>&nbsp;"&rstemp("FIRST_FLR_AREA")&"</TD>"
Response.write  "    <TD bgcolor='EEEEEE'>KITCHEN</TD>"
Response.write  "    <TD bgcolor='white'>&nbsp;"&rstemp("KITCHEN")&"</TD>"
Response.write  "    <TD bgcolor='EEEEEE'>COVERED PARKING SPACES</TD>"
Response.write  "    <TD bgcolor='white'>&nbsp;"&rstemp("PARKING_SPACES")&"</TD></TR>"
Response.write  "  <TR>"
Response.write  "    <TD bgcolor='EEEEEE'>SECOND FLOOR</TD>"
Response.write  "    <TD bgcolor='white'>&nbsp;"&rstemp("SEC_FLR_AREA")&"</TD>"
Response.write  "    <TD bgcolor='EEEEEE'>LIVING ROOM</TD>"
Response.write  "    <TD bgcolor='white'>&nbsp;"&rstemp("LIVING_ROOM")&"</TD>"
Response.write  "    <TD bgcolor='EEEEEE'>GARAGE AREA</TD>"
Response.write  "    <TD bgcolor='white'>&nbsp;"&rstemp("GARAGE_AREA")&"</TD></TR>"
Response.write  "  <TR>"
Response.write  "    <TD bgcolor='EEEEEE'>FINISHED BASEMENT</TD>"
Response.write  "    <TD bgcolor='white'>&nbsp;"&rstemp("FIN_BASEMNT_AREA")&"</TD> "
Response.write  "    <TD bgcolor='EEEEEE'>BEDROOMS</TD>"
Response.write  "    <TD bgcolor='white'>&nbsp;"&rstemp("NO_OF_BEDROOMS")&"</TD>"
Response.write  "    <TD></TD>    <TD></TD></TR>  <TR>"
Response.write  "    <TD bgcolor='EEEEEE'>CONVERTED GARAGE</TD>"
Response.write  "    <TD bgcolor='white'>&nbsp;"&rstemp("CONV_GARAGE_AREA")&"</TD>"
Response.write  "    <TD bgcolor='EEEEEE'>BATHS</TD>"
Response.write  "    <TD bgcolor='white'>&nbsp;"&rstemp("NR_OF_BATHS")&"</TD>"
Response.write  "    <TD></TD>    <TD></TD></TR>  <TR>"
Response.write  "    <TD bgcolor='EEEEEE'>ADDITIONS</TD>"
Response.write  "    <TD bgcolor='white'>&nbsp;"&rstemp("TOTAL_ADDN_AREA")&"</TD>"
Response.write  "    <TD bgcolor='EEEEEE'>DINING</TD>"
Response.write  "    <TD bgcolor='white'>&nbsp;"&rstemp("DINING_ROOM")&"</TD>"
Response.write  "    <TD bgcolor='EEEEEE'>HEATING/COOLING</TD>"
Response.write  "    <TD bgcolor='white'>&nbsp;"&rstemp("CENT_AC")&"</TD></TR>"
Response.write  "  <TR>"
Response.write  "    <TD bgcolor='EEEEEE'>TOTAL LIVING AREA</TD>"
Response.write  "    <TD bgcolor='white'>&nbsp;"&rstemp("TOTAL_LIVING_AREA")&"</TD>"
Response.write  "    <TD bgcolor='EEEEEE'>FAMILY</TD>"
Response.write  "    <TD bgcolor='white'>&nbsp;"&rstemp("FAMILY_ROOM")&"</TD>"
Response.write  "    <TD bgcolor='EEEEEE'>FIREPLACES</TD>"
Response.write  "    <TD bgcolor='white'>&nbsp;"&rstemp("FIREPLACE")&"</TD></TR>"
Response.write  "  <TR>"
Response.write  "    <TD></TD>"
Response.write  "    <TD></TD>"
Response.write  "    <TD bgcolor='EEEEEE'>MISC ROOMS</TD>"
Response.write  "    <TD bgcolor='white'>&nbsp;"&rstemp("MISC_ROOMS")&"</TD>"
Response.write  "    <TD bgcolor='EEEEEE'>POOL</TD>"
Response.write  "    <TD bgcolor='white'>&nbsp;"&rstemp("POOL_COST")&"</TD></TR>"
Response.write  "  <TR>    <TD></TD>    <TD></TD>    <TD></TD>    <TD></TD>"
Response.write  "    <TD bgcolor='EEEEEE'>SPA</TD>"
Response.write  "    <TD bgcolor='white'>&nbsp;"&rstemp("SPA_HOT_TUB")&"</TD></TR>"
Response.write  "  <TR>"
Response.write  "    <TD bgcolor='EEEEEE'>EFFECTIVE YEAR BUILT</TD>"
Response.write  "    <TD bgcolor='yellow'>&nbsp;"&rstemp("EFFECT_YR")&"</TD>"
Response.write  "    <TD></TD>    <TD></TD>    <TD></TD>    <TD></TD></TR>  <TR>"
Response.write  "    <TD bgcolor='EEEEEE'>STORIES</TD>"
Response.write  "    <TD bgcolor='white'>&nbsp;"&rstemp("NR_OF_STORIES")&"</TD>"
Response.write  "    <TD></TD>    <TD></TD>    <TD></TD>    <TD></TD></TR>  <TR>   <TD></TD>    <TD></TD>    <TD></TD>    <TD></TD>    <TD></TD>"
Response.write  "    <TD></TD></TR></TABLE></P>"
Response.write  "<P><BR></P><P>"
Response.write  "<TABLE width='100%'  bordercolor='white' bordercolordark='white' bordercolorlight='white'>"
  
Response.write  "  <TR><TD></TD>    <TD bgcolor='navy'>"
Response.write  "      <P align=center><font color='Yellow'><STRONG><A NAME='POLITICAL'>POLITICAL AREA</a></STRONG></FONT> "
Response.write  "    </P> </TD><TD></TD></TR></TABLE></P>"

Response.write  "<TABLE width='100%' bordercolor='black' bordercolordark='gray' bordercolorlight='white'>"
  
Response.write  "  <TR>    <TD></TD>    <TD></TD>    <TD></TD>    <TD></TD></TR>  <TR>"
Response.write  "    <TD bgcolor='EEEEEE'>"
Response.write  "      <P align=right>ZONING</P></TD>"
Response.write  "    <TD bgcolor='yellow'>&nbsp;"&rstemp("ZONEING")&"</TD>"
Response.write  "    <TD bgcolor='EEEEEE'>"
Response.write  "      <P align=right>JURISDICTION</P></TD>"
Response.write  "        <TD bgcolor='white'>&nbsp;"&rstemp("JURISDICTION")&"</TD></TR>"
Response.write  "  <TR>"
Response.write  "    <TD bgcolor='EEEEEE'>"
Response.write  "      <P align=right>TAX RATE AREA</P>  </TD>"
Response.write  "    <TD bgcolor='white'>&nbsp;"&rstemp("NEW_CODE_AREA")&"</TD>"
Response.write  "    <TD bgcolor='EEEEEE'>"
Response.write  "      <P align=right>COUNTY SUPERVISORS DISTRICT</P>  </TD>"
Response.write  "        <TD bgcolor='white'>&nbsp;"&rstemp("SUPERVISOR_DISTRICT")&"</TD></TR>"
Response.write  "  <TR>    <TD></TD>    <TD></TD>    <TD></TD>    <TD></TD></TR></TABLE><P></P><P><BR></P><P>"
Response.write  "<TABLE width='100%'  bordercolor='white' bordercolordark='white' bordercolorlight='white'>"
  
Response.write  "  <TR><TD></TD>    <TD bgcolor='navy'>"
Response.write  "      <P align=center><font color='Yellow'><STRONG><A NAME='Fee'>FEE DISTRICTS</a></STRONG></FONT> "
Response.write  "    </P> </TD><TD></TD></TR></TABLE></P>"
Response.write  "<P>"
Response.write  "<TABLE width='100%' bordercolor='black' bordercolordark='gray' bordercolorlight='white'>"
  
Response.write  "  <TR>    <TD></TD>    <TD></TD>    <TD></TD>    <TD></TD></TR>  <TR>   <TD></TD>    "
'******************************  Fee Districts   **************************
dbPermitFieldDescriptList = "Fee District,Description"
dbPermitFieldDescript = Split(dbPermitFieldDescriptList,",")
SQLquery = "SELECT FEE_GROUP_DESCRIPTION,FEE_DESCRIPTION  FROM vwAPN_FEE_DESCRIPTIONS WHERE APN = '"  & thisvalue & "' AND (FEE_GROUP_DESCRIPTION LIKE '%DEVELOPMENT%' OR FEE_GROUP_DESCRIPTION LIKE '%WATER%' OR FEE_GROUP_DESCRIPTION LIKE '%SEWER%' OR FEE_GROUP_DESCRIPTION LIKE '%REFUSE%') ORDER BY FEE_GROUP_DESCRIPTION" 
set rsDistrict=conntemp.execute(SQLquery)
if rsDistrict.eof then
	response.write "<br><font size='2'>The Parcel Number submitted (listed in blue font above) does not have a match in the GIS Fee District database.<br></font>"
else
response.write "<TABLE width='100%'>"
	response.write "<TR>"
	response.write "<TH><b><u>DISTRICT TYPE</u></b></TH>"
	response.write "<TH><b><u>FEE DISTRICT</u></b></TH>"
	response.write"</TR>"
		
do while not rsDistrict.eof
		recCount = recCount + 1
			response.write "<TR>"
		for i=0 to 1
				thisDistrict = rsDistrict(i)
				if isnull(thisDistrict) then
						thisDistrict = "&nbsp;"
				end if
				if i=0 then
						response.write "<TD BGCOLOR='#EEEEEE'>"
				else
						response.write "<TD>"
				end if
				response.write thisDistrict
				response.write "</TD>"
		next
		rsDistrict.movenext
		response.write"</TR>"
loop
response.write"</TABLE>"
end if
'*****************************************************************************

Response.write  "    <TD></TD></TR>  <TR>    <TD></TD>    <TD></TD>    <TD></TD>   <TD></TD></TR></TABLE></P><P>"
Response.write  "<TABLE width='100%'  bordercolor='white' bordercolordark='white' bordercolorlight='white'>"
  
Response.write  "  <TR><TD></TD>"
Response.write  "    <TD bgcolor='navy'>"
Response.write  "      <P align=center><font color='Yellow'><STRONG><A NAME='Ownership'>OWNERSHIP</a></STRONG></FONT> "
Response.write  "    </P> </TD><TD></TD></TR></TABLE><BR>"
Response.write  "<TABLE width='100%' bordercolor='black' bordercolordark='gray' bordercolorlight='white'>"
  
Response.write  "  <TR>    <TD></TD>    <TD></TD>    <TD></TD>    <TD></TD></TR>  <TR>   <TD></TD>    <TD bgcolor='EEEEEE'>"
Response.write  "      <P align=right>OWNER</P></TD>"
Response.write  "    <TD bgcolor='white'>&nbsp;"&rstemp("OWNER_NAMES")&"</TD>"
Response.write  "    <TD></TD></TR>  <TR>    <TD></TD>    <TD></TD>    <TD></TD>   <TD></TD></TR>  <TR>    <TD></TD>    <TD bgcolor='EEEEEE'>"
Response.write  "      <P align=right>PROPERTY ADDRESS</P> </TD>"
Response.write  "    <TD bgcolor='white'>&nbsp;"&rstemp("SITUS_ADD1")&"</TD>"
Response.write  "    <TD></TD></TR>  <TR>    <TD></TD>    <TD></TD>"
Response.write  "    <TD bgcolor='white'>&nbsp;"&rstemp("SITUS_ADD2")&"</TD>"
Response.write  "    <TD></TD></TR>  <TR>    <TD></TD>    <TD></TD>    <TD></TD>   <TD></TD></TR>  <TR>    <TD></TD>    <TD bgcolor='EEEEEE'>"
Response.write  "      <P align=right>MAILING ADDRESS</P> </TD>"
Response.write  "    <TD bgcolor='white'>&nbsp;"&rstemp("MAIL1")&"</TD>"
Response.write  "    <TD></TD></TR>  <TR>    <TD></TD>    <TD></TD>"
Response.write  "    <TD bgcolor='white'>&nbsp;"&rstemp("MAIL2")&"</TD>"
Response.write  "    <TD></TD></TR>  <TR>    <TD></TD>    <TD></TD>    <TD></TD>   <TD></TD></TR>  <TR>    <TD></TD>    <TD></TD>    <TD></TD>   <TD></TD></TR></TABLE></P><P>"
Response.write  "<TABLE width='100%'  bordercolor='white' bordercolordark='white' bordercolorlight='white'>"
  
Response.write  "  <TR><TD></TD>"
Response.write  "    <TD bgcolor='navy'>"
Response.write  "      <P align=center><font color='Yellow'><STRONG><A NAME='Roll'>ASSESSOR'S ROLL VALUES</a></STRONG></FONT> "
Response.write  "    </P> </TD><TD></TD></TR></TABLE></P><P>"
Response.write  "<TABLE width='100%' bordercolor='black' bordercolordark='gray' bordercolorlight='white'>"
  
Response.write  "  <TR>    <TD></TD>    <TD></TD>    <TD></TD>    <TD></TD>   <TD></TD>    <TD></TD>    <TD></TD></TR>  <TR>    <TD></TD>    <TD>"
Response.write  "      <P align=center><U>LAND</U></P></TD>"
Response.write  "    <TD><U></U></TD>    <TD>"
Response.write  "      <P align=center><U>STRUCTURES</U></P></TD>"
Response.write  "    <TD><U></U></TD>    <TD>      "
Response.write  "<P align=center><U>TOTAL</U></P></TD>"
Response.write  "    <TD></TD></TR>  <TR>    <TD></TD>"
Response.write  "    <TD bgcolor='white'><div align='center'>&nbsp;$ "&rstemp("NEW_VALUE_LAND")&"</div></TD>"
Response.write  "    <TD></TD>"
Response.write  "    <TD bgcolor='white'><div align='center'>&nbsp;$ "&rstemp("NEW_VALUE_STRUCT")&"</div></TD>"
Response.write  "    <TD></TD>"
Response.write  "    <TD bgcolor='white'><div align='center'>$&nbsp;"&rstemp("TOTAL_VALUE")&"</div></TD>"
Response.write  "    <TD></TD></TR>  <TR>    <TD></TD>    <TD></TD>    <TD></TD>   <TD></TD>    <TD></TD>    <TD></TD>    <TD></TD></TR></TABLE></P><P><BR><BR><BR><BR><BR></P>"

%>


</body>
</html>
