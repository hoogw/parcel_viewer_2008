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
session("ParcelLayerID")=3
%>

<html>
<head>
	<title>Detailed Results</title>
</head>

<%if request("m")="z" then%>
<body>
<%else%>
<body onload="top.HaltLYRHide=0; top.MapFrame.hideLoadingLyr();">
<%end if%>
<!--#include file="../includes/header.aspx"-->

<script language="Javascript">
	function goBack () {
		document.Qry.submit();
	}
</script>


<table width=100% cellpadding=0 cellspacing=0 border=0 ID="Table3"><tr  class=tblHdr>
			<td align=center><b>Detailed Parcel Description</b></font></td></tr></table>
<br>

<br>
<table width=100% cellpadding=0 cellspacing=0 border=0 ID="Table3">
	<tr  >		
		<td align=center><input type=button class=Btn onclick='window.print();' Value="Print List"></td>
		<td align=center><input type=button class=Btn onclick='window.print();' Value="Print List"></td>
		<%if trim(session("SearchResultsURL")) <> "" then%>
		<td align=center><input type=button class=Btn onclick='window.print();' Value="Print List"></td>
		<%end if%>
	</tr>
</table>


<% 
dim theFieldDescript, theNum,SQLquery
dim conntemp, rstemp
dim howmanyfields, recCount, thisvalue,i
Dim intFileNum As Integer
Dim DateNow
Dim strFileName As String
Dim DS as string
Dim Coords as string
Dim headcheck
Dim strRight
Dim headstring
Dim APNCheck
Dim ShortList

Coords=""

theFieldDescript = Split("**Land Use,Zoning,**Waste Removal Services,Trash Day,Clean-Up Month,**Political Districts,Council Distrtct,Council Member,**SITUS INFO,Parcel Number,Lot Size,Lot Number,Address,City,Zipcode,Subdivision,**OWNER INFO,Address,City,State,Zipcode ",",")


theNum = replace(request("APN"),"'","")
theNum = "'" & replace(theNum,",","','") & "'"

session("ds") = request("ds")

conntemp=createobject("adodb.connection")

if (session("ds")<> "" and session("ds") <> "Provider=SQLOLEDB.1;") then
	DS="Provider=SQLOLEDB.1;" & session("ds")
else
	DS="Provider=SQLOLEDB.1;" & application("dbSource")
end if

conntemp.open (DS)

SQLquery = "SELECT  '  ',Zone,'  ',dayofweek,month,'  ',dist_num,Member,'  ',APN,Lot_Size,Lot #,Site_add,City,Zip,sub_name,'  ',Own_add,Own_City,Own_state,Own_zip FROM PARCEL WHERE APN in (" & theNum & ") ORDER BY APN"


'response.Write (SQLquery & "<br><br>" & DS & "<br><br>" & cint(err.number) & "-" & cstr(err.description))
rstemp=conntemp.execute(SQLquery)

'response.write ("<br><div align='center'><font color='#0000FF'><b><font size='2'>Detailed Parcel Description</b><hr></div><br>")

response.write ("<br><br><align='left'><font size='1'>NOTE: If a property has more than one zoning designation a second property record will display the alternate Zoning Code.")
%>
<br><br>
<%
if rstemp.eof then
	response.write ("The selected parcel does not exist in the database.")
	response.end
end if

        intFileNum = FreeFile()
        DateNow = Now()
        strFileName = "Properties_" & Format(DateNow, "MM_dd_yyyy") & "_" & Format(DateNow, "hh_mm_ss_tt")

        FileOpen(intFileNum, HttpRuntime.AppDomainAppPath & "CSV\" & strFileName & ".csv", OpenMode.Output)

		for i = 0 to ubound(theFieldDescript)
			write (intFileNum,theFieldDescript(i))
		next

		writeline(intFileNum)
		
'Create Tabular Display of Attribute Data***********************************
		howmanyfields=rstemp.fields.count-1 'Don't print out the x,y coords
		recCount = 0
		APNCheck = 0


		do while not rstemp.eof

			ShortList = "False"
			recCount = recCount + 1
			response.write ("<TABLE width='100%'>")
	                   response.Write ("<TR bgcolor='#CCCCCC'><td style='color:black' colspan=99 align=center><b>Record " & recCount & "</b><br><br></td></tr>")
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
				    response.write ("<tr class=tblhdr><td align=center colspan=2><b>" & headstring & "</b></td></tr>")
				else
				    If ShortList = "True"
				        if theFieldDescript(i) = "Zoning"
					    response.write ("<tr class=tblhdr><td align=center colspan=2><b>Secondary Zoning For</b></td></tr>")
					    response.write ("<tr class=tblhdr><td align=center colspan=2><b>Parcel ID: </b>" & APNCheck & "</td></tr>")
				        end if
					if theFieldDescript(i) = "Zoning" then
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

		if reccount>0 then
			'response.write ("<br><hr><a href='..\CSV\" & strFileName & ".csv' target=_new>Right-Click Here</a> 'and select 'Save Target As' to download CSV file.<hr><br><br><br>")
		end if

rstemp.close
rstemp=nothing
conntemp.close
conntemp=nothing
 %>
<hr style='height:1px;color:gray'>
		<form name="Qry" method=post ID="Form1" action="<%=trim(session("SearchResultsURL"))%>">
		<input type=hidden name="QueryString" value="<%=server.urldecode(trim(session("SearchResultsQ")))%>">
		</form>
 
<%if request("m")="z" then%>
<script language="Javascript">
	top.MapFrame.positionLoadingLyr();
	top.MapFrame.url = "";
	top.MapFrame.SSRefreshMap('<%=Coords%>','',1);
</script>

<%end if%>

</body>
</html>
