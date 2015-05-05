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
function platopen(plat){
var targeturl="http://mygeoprise.net/LOPlats/"+plat
targeturl
newwin=window.open(targeturl,"","scrollbars,resizable=yes")
}

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
Dim Coords as string
Dim Plat as string

Coords=""
theFieldDescript = Split("**Address,Address 1,Address 2,**Parcel Info,Assessor Parcel Number,Legal Description,Township/Range/Section,Lot Area, Acres,**Owner Information,Name,Address 1,Address 2,**Property Specs,Year Built, Living Area,Number Residential Units,Number of Stories,Parking Size, Parking Size, Parking Type,",",")

theNum = replace(request("APN"),"'","")
theNum = "'" & replace(theNum,",","','") & "'"
'response.Write ("the num =" & thenum & "<br><br>")
'response.Write (thefielddescript & "<br><br>")

'session("ds") = "Provider=SQLOLEDB.1;" & request("ds")
session("ds") = "Provider=SQLOLEDB.1;Initial Catalog=Costa2;Data Source=srv6;User Id=CostaMesa;Password=CostaMesa;"

if (session("ds")<> "" and session("ds") <> "Provider=SQLOLEDB.1;") then
	DS="Provider=SQLOLEDB.1;" & session("ds")
else
	DS="Provider=SQLOLEDB.1;" & application("dbSource")
end if

conntemp=createobject("adodb.connection")
conntemp.open (session("ds"))
SQLquery = "SELECT  ' ',AddressPrp,situs_city_state_zip_zip_4_dwl,' ',apnlink,legal_description,township_range_section,area,lot_acreage,' ',owner_name__first_name_first_,mail_address,mail_city_state_zip_zip_4_dwl,' ',year_built,bldg_living_area,no_residential_units,stories_no,parking_size,parking_type FROM FullFares WHERE Apnlink2 in (" & theNum & ") ORDER BY Apnlink2"

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
	                    response.Write ("<TR class=VC><td colspan=99 align=center><b>Record " & recCount & "</b></td></tr>")

			for i=0 to howmanyfields
                If (i / 2 = i \ 2) Then
                    response.Write ("<TR class=tblRow1>")
                Else
                    response.Write ("<TR class=tblRow2>")
                End If
		headcheck = InStr(1, theFieldDescript(i), "*")
		headstring = mid(Trim(theFieldDescript(i)),3,30)
		if headcheck > 0 then
			response.write ("<tr bgcolor='#CBCBE4'color='#663300'><td align=center colspan=2><b>" & headstring & "</b></td></tr>")
		else
			if theFieldDescript(i) = "Plat" then
				response.write ("<TD width='50%'>")
				thisvalue = rstemp(i).value
				Plat = "P" & (thisvalue) & ".tif"
				response.write ("<tr><TD><B>" & "Current Plat" & "</B></TD>")
				response.write ("<td><font class=SSCol1><a href=""javascript:platopen('" & plat & "')"">Display Plat Image</a></font></td></tr>")
			else
			response.write ("<TD><B>" & theFieldDescript(i) & "</B></TD>")
			response.write ("<TD width='50%'>")
			thisvalue = rstemp(i).value
			end if
			if isdbnull(thisvalue) then
				thisvalue = "&nbsp;"
			end if
			if headcheck > 0 then
				response.write ("Header")
			else
				if theFieldDescript(i) <> "Plat" then
					response.write (thisvalue)
				end if
			end if

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
