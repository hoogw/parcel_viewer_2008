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

theFieldDescript ="test"

theNum = replace(request("APN"),"'","")
theNum = "'" & replace(theNum,",","','") & "'"
'response.Write (thenum & "<br><br>")
'response.Write (thefielddescript & "<br><br>")

session("ds") = "Provider=SQLOLEDB.1;" & request("ds")

if (session("ds")<> "" and session("ds") <> "Provider=SQLOLEDB.1;") then
	DS="Provider=SQLOLEDB.1;" & session("ds")
else
	DS="Provider=SQLOLEDB.1;" & application("dbSource")
end if

conntemp=createobject("adodb.connection")
conntemp.open (session("ds"))
SQLquery ="SELECT "-",APN,Situs1,Situs2,SitusStrNum,SitusStrDir,SitusStreet,SitusStrType,SitusComm,"-",BldSize,NumFloors,BUsedFor,BDesignedFor,Condition,GarSQFT,qualityclass,bldgcnt,unitcnt,BDRMS,FullBaths,HalfBaths,TotalRooms"-",landvalue,structurevalue,growingvalue,ppmhvalue,ppbusinessvalue,fixturesvalue,fixturesRPvalue,EnrolledValue,"-",landusecategory,buildingseqnum,unitseqnum,Status,UseCode,TRA,Acres,LandSQFT  FROM PARCELS WHERE APN in (" & theNum & ") ORDER BY APN"

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
				response.write ("<TD><B>" & theFieldDescript(i) & "</B></TD>")
				response.write ("<TD width='75%'>")
				thisvalue = rstemp(i).value
				if isdbnull(thisvalue) then
					thisvalue = "&nbsp;"
				end if
				if theFieldDescript(i) = "Parcel ID" then
					response.write  (thisvalue)
				else
				response.write (thisvalue)
				end if
				response.write("</TD>")
				response.write("</TR>")
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
