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
<br>

<% 
dim theFieldDescript, theNum,SQLquery
dim conntemp, rstemp
dim howmanyfields, recCount, thisvalue,i
Dim intFileNum As Integer
Dim DateNow
Dim strFileName As String
Dim Coords as string
Dim DS as string
Dim headcheck
Dim strRight
Dim headstring
Dim APNCheck
Dim ShortList

Coords=""

theFieldDescript = Split("**SITUS INFO,Parcel ID,APN,Address,City/State,Street Num,Direction,Street,Type,Community,**DESCRIPTION,Building Size,Floors,Used For,Designed For,Condition,Garage SQFT,Quality Class,Building Count,Unit Count,Bedrooms,Full Baths,Half Baths,Total Rooms,**VALUAUTION,Land Value,Structure Value,Growing Value,PPMH Value,PP Business Value,Fixtures Value,Fixtures RP Value,Enrolled Value,**OTHER,Zoning,General Plan,Warning,Landuse Category,Building Seq Num,unit Seq Num,Status,Use Code,TRA,Acres,Land SQFT ",",")

theNum = replace(request("APN"),"'","")
theNum = "'" & replace(theNum,",","','") & "'"
'response.Write (thenum & "<br><br>")
response.Write (thefielddescript & "<br><br>")

if trim(request("ds")) <> "" then
	session("ds") = "Provider=SQLOLEDB.1;" & request("ds")
	'session("ds") = "Provider=SQLOLEDB.1;Initial Catalog=Madera;Data Source=actgis6;User Id=Madera;Password=Madera;"

	if (session("ds")<> "" and session("ds") <> "Provider=SQLOLEDB.1;") then
		DS="Provider=SQLOLEDB.1;" & session("ds")
	else
		DS="Provider=SQLOLEDB.1;" & application("dbSource")
	end if
else
	DS="Provider=SQLOLEDB.1;" & application("dbSource")
end if

conntemp=createobject("adodb.connection")
conntemp.open (DS)
SQLquery = "SELECT  ' ',APN,Parcel,Situs1,Situs2,SitusStrNum,SitusStrDir,SitusStreet,SitusStrType,SitusComm,' ',BldSize,NumFloors,BUsedFor,BDesignedFor,Condition,GarSQFT,qualityclass,bldgcnt,unitcnt,BDRMS,FullBaths,HalfBaths,TotalRooms,' ',landvalue,structurevalue,growingvalue,ppmhvalue,ppbusinessvalue,fixturesvalue,fixturesRPvalue,EnrolledValue,' ',zoning,gp,warning,landusecategory,buildingseqnum,unitseqnum,Status,UseCode,TRA,Acres,LandSQFT  FROM PARCELS WHERE APN in (" & theNum & ") ORDER BY APN"

'response.Write (SQLquery & "<br><br>" & session("ds") & "<br><br>")

rstemp=conntemp.execute(SQLquery)

response.write ("<div align='center'><font color='#0000FF'><b><font size='2'>Detailed Parcel Description</b><hr></div>")
response.write ("<align='left'><font color='red'><font size='2'>NOTE: If a property has more than one general plan or zoning designation a second property record will display the alternate Zoning and/or GP Codes.<hr>")

if rstemp.eof then
	response.write ("The selected parcel does not exist in the database.")
	response.end
end if
        FileOpen(intFileNum, HttpRuntime.AppDomainAppPath & "CSV\" & strFileName & ".csv", OpenMode.Output)

		for i = 0 to ubound(theFieldDescript)
			write (intFileNum,theFieldDescript(i))
		next
		writeline(intFileNum)
		
'Create Tabular Display of Attribute Data***********************************
		howmanyfields=rstemp.fields.count-3 'Don't print out the x,y coords
		recCount = 0
		APNCheck = 0
		do while not rstemp.eof
			ShortList = "False"
			recCount = recCount + 1
			response.write ("<TABLE width='100%'>")
	                    response.Write ("<TR class=VC><td colspan=99 align=center><b>Record " & recCount & "</b></td></tr>")
			for i=0 to howmanyfields
		                If (i / 2 = i \ 2) Then
				    If shortlist = "False"
                		        response.Write ("<TR class=tblRow1>")
				    end if
		                Else
				    If shortlist = "False"
                		        response.Write ("<TR class=tblRow2>")
				    end if
                		End If
				headcheck = InStr(1, theFieldDescript(i), "*")
				headstring = mid(Trim(theFieldDescript(i)),3,30)
				if theFieldDescript(i) = "Parcel ID" then
				    If APNCheck <> rstemp(i).value
				        APNCheck = rstemp(i).value
				    else
					ShortList = "True"
				    end if
				End If
				if headcheck > 0 and ShortList = "False" then
				    response.write ("<tr bgcolor='#CBCBE4'color='#663300'><td align=center colspan=2><b>" & headstring & "</b></td></tr>")
				else
				    If ShortList = "True"
				        if theFieldDescript(i) = "Zoning"
					    response.write ("<tr bgcolor='#CBCBE4'color='#663300'><td align=center colspan=2><b>Secondary Zoning & GP For</b></td></tr>")
					    response.write ("<tr bgcolor='#CBCBE4'color='#663300'><td align=center colspan=2><b>Parcel ID: </b>" & APNCheck & "</td></tr>")
				        end if
					if theFieldDescript(i) = "Zoning" or theFieldDescript(i) = "General Plan" or theFieldDescript(i) = "Warning" then
				            response.write ("<TD><B>" & theFieldDescript(i) & "</B></TD>")
				            response.write ("<TD width='60%'>")
				            thisvalue = rstemp(i).value
				            if isdbnull(thisvalue) then
				                thisvalue = "&nbsp;"
			                        Write(intFileNum, "")
				            else
	        		                Write(intFileNum, Trim(thisvalue))
				            end if
				            response.write (thisvalue)
				            response.write("</TD>")
				            response.write("</TR>")
					end if
				    Else
			    		response.write ("<TD><B>" & theFieldDescript(i) & "</B></TD>")
				    	response.write ("<TD width='60%'>")
				    	thisvalue = rstemp(i).value
				    	if isdbnull(thisvalue) then
					    thisvalue = "&nbsp;"
			                    Write(intFileNum, "")
				    	else
	        		            Write(intFileNum, Trim(thisvalue))
				    	end if
				    	if theFieldDescript(i) = "Parcel ID" then
					    response.write  (thisvalue)
				    	else
					    response.write (thisvalue)
				    	end if
				    	response.write("</TD>")
				    	response.write("</TR>")
				    end if
			        end if
			    next
			    Coords &= reccount & "," & rstemp(i).value & "," & rstemp(i+1).value & ","
			rstemp.movenext
			response.write("</TABLE><br>")
            WriteLine(intFileNum)
		loop

        FileClose(intFileNum)

		if reccount>0 and trim(strFileName) <> "" then
			response.write ("<br><hr><a href='..\CSV\" & strFileName & ".csv' target=_new>Right-Click Here</a> and select 'Save Target As' to download CSV file.<hr><br><br><br>")
		end if

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
