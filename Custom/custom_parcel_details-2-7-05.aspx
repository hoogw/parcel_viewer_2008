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
session("ParcelLayerID")=11
%>

<html>
<head>
	<title>Detailed Results</title>
</head>

<body onload="top.HaltLYRHide=0; top.MapFrame.hideLoadingLyr();">

<!--#include file="../includes/header.aspx"-->

<script language="Javascript">
	function goBack () {
		document.Qry.submit();
	}
// strRight returns str to the right
function strRight(str, char)
{
   var   retVal = "-1";
   if (str.indexOf (char) >  -1 ) 
      retVal = str.substring (str.indexOf (char)+ 1 , str.length);
   return(retVal);
}
</script>

<center><input type=button class=Btn onclick='window.print();' Value="Print List">&nbsp;&nbsp;<input type=button class=Btn onclick='top.MapFrame.SaveMap()' Value="Print Map">
<br>
<%if trim(session("SearchResultsURL")) <> "" then%>
<input type=button class=Btn onclick="goBack();" Value='Previous'><br><br>
<%end if%>
</center>

<% 
dim theFieldDescript, theNum,SQLquery
dim conntemp, rstemp
dim howmanyfields, recCount, thisvalue,i
Dim DS as string
Dim headcheck
Dim strRight
Dim headstring

theFieldDescript = Split("**Situs Info,APN,Address,City/State,Street Num,Direction,Street,Type,Community,**DESCRIPTION,Building Size,Floors,Used For,Designed For,Condition,Garage SQFT,Quality Class,Building Count,Unit Count,Bedrooms,Full Baths,Half Baths,Total Rooms,**VALUAUTION,Land Value,Structure Value,Growing Value,PPMH Value,PP Business Value,Fixtures Value,Fixtures RP Value,Enrolled Value,**OTHER INFO,Landuse Category,Building Seq Num,unit Seq Num,Status,Use Code,TRA,Acres,Land SQFT ",",")

theNum = replace(request("APN"),"'","")
theNum = "'" & replace(theNum,",","','") & "'"
'response.Write (thenum & "<br><br>")
response.Write (thefielddescript & "<br><br>")

'session("ds") = "Provider=SQLOLEDB.1;" & request("ds")
session("ds") = "Provider=SQLOLEDB.1;Initial Catalog=Madera;Data Source=localhost;User Id=Madera;Password=Madera;"

if (session("ds")<> "" and session("ds") <> "Provider=SQLOLEDB.1;") then
	DS="Provider=SQLOLEDB.1;" & session("ds")
else
	DS="Provider=SQLOLEDB.1;" & application("dbSource")
end if

conntemp=createobject("adodb.connection")
conntemp.open (session("ds"))
SQLquery = "SELECT  ' ',APN,Situs1,Situs2,SitusStrNum,SitusStrDir,SitusStreet,SitusStrType,SitusComm,' ',BldSize,NumFloors,BUsedFor,BDesignedFor,Condition,GarSQFT,qualityclass,bldgcnt,unitcnt,BDRMS,FullBaths,HalfBaths,TotalRooms,' ',landvalue,structurevalue,growingvalue,ppmhvalue,ppbusinessvalue,fixturesvalue,fixturesRPvalue,EnrolledValue,' ',landusecategory,buildingseqnum,unitseqnum,Status,UseCode,TRA,Acres,LandSQFT  FROM PARCELS WHERE APN in (" & theNum & ") ORDER BY APN"

'response.Write (SQLquery & "<br><br>" & session("ds") & "<br><br>")

rstemp=conntemp.execute(SQLquery)

response.write ("<br><div align='center'><font color='#0000FF'><b><font size='2'>Detailed Parcel Description</b><hr></div><br>")

if rstemp.eof then
	response.write ("The selected parcel does not exist in the database.")
	response.end
end if

'Create Tabular Display of Attribute Data***********************************
		howmanyfields=rstemp.fields.count-1
		recCount = 0
		do while not rstemp.eof
			recCount = recCount + 1
			response.write ("<TABLE width='100%'>")
			for i=0 to howmanyfields
                If (i / 2 = i \ 2) Then
                    response.Write ("<TR class=tblRow1>")
                Else
                    response.Write ("<TR class=tblRow2>")
                End If
				headcheck = InStr(1, theFieldDescript(i), "*")
				headstring = Trim(theFieldDescript(i))
				headstring = mid(headstring,3,30)
				if headcheck > 0 then
					response.write ("<tr bgcolor='#CBCBE4'color='#663300'><td align=center colspan=2><b>" & headstring & "</b></td></tr>")
				else
				response.write ("<TD><B>" & theFieldDescript(i) & "</B></TD>")
				response.write ("<TD width='60%'>")
				thisvalue = rstemp(i).value
				if isdbnull(thisvalue) then
					thisvalue = "&nbsp;"
				end if
				headcheck = InStr(1, theFieldDescript(i), "*")
				if headcheck > 0 then
					response.write ("Header")
				else
				response.write (thisvalue)
				end if
				response.write("</TD>")
				response.write("</TR>")
				end if
			next
			rstemp.movenext
			response.write("</TABLE><br>")
		loop

rstemp.close
rstemp=nothing
conntemp.close
conntemp=nothing
 %>

		<form name="Qry" method=post ID="Form1" action="<%=trim(session("SearchResultsURL"))%>">
		<input type=hidden name="QueryString" value="<%=server.urldecode(trim(session("SearchResultsQ")))%>">
		</form>
 
</body>
</html>
