<!--- Custom Parcel Identify ASP file --->
<!--- Inputs: 
		APN		request("APN")		A comma delimited list of APN numbers
		ds		request("ds")		The data source connection string
	  REQUIREMENT:
		* <body onload="top.MapFrame.hideLoadingLyr()">
--->

<% 
response.expires = -7 

session("Fld_SHP")="ObjectID"
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
			<td align=center><b>Detailed Address Point Description</b></font></td></tr></table>
<br>

<br>
<table width=100% cellpadding=0 cellspacing=0 border=0 ID="Table3">
	<tr  >		
		<td align=center><input type=button class=Btn onclick='window.print();' Value="Print List"></td>
		
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
Dim ObjectID

Coords=""

session("ds")="Provider=SQLOLEDB.1;Initial Catalog=VECTOR;Data Source=GISSQLREG;User Id=SDE;Password=sde;"
session("DBTbl")="v_streetsfull"

theFieldDescript = Split("**Address,Street,Unit,Building,Floor,City,State,Zip,+ 4,**Coordinates,Lattitude,Longitude,State Plane X,State plane Y,**More Info,APN,Agency ,Side, ",",")


theNum = replace(request("APN"),"'","")
theNum = "'" & replace(theNum,",","','") & "'"

conntemp=createobject("adodb.connection")

if (session("ds")<> "" and session("ds") <> "Provider=SQLOLEDB.1;") then
	DS="Provider=SQLOLEDB.1;" & session("ds")
else
	DS="Provider=SQLOLEDB.1;" & application("dbSource")
end if
session("ds")="Provider=SQLOLEDB.1;Initial Catalog=VECTOR;Data Source=GISSQL;User Id=SDE;Password=sde;"
session("DBTbl")="v_streetsfull"

conntemp.open (DS)
'response.write("request value = " & trim(request("thenum")) & "<---")
ObjectID = trim(request("thenum"))
'response.write(ObjectID)

SQLquery = "SELECT  '  ',add_number+' '+full_name as street,Unit,Building,Floor,locality,State,Postal,Postal_addon,'  ',latitude,longitude,x_coord,y_coord,'  ',apn,agencyid FROM v_streetsfull WHERE ObjectID in (" & ObjectID & ") ORDER BY Full_Name"


'response.Write (SQLquery & "<br><br>" & DS & "<br><br>" & cint(err.number) & "-" & cstr(err.description))
rstemp=conntemp.execute(SQLquery)

response.write ("<br><div align='center'><font color='#0000FF'><b><font size='2'>Address Details</b><hr></div><br>")

%>
<br><br>
<%
if rstemp.eof then
	response.write ("The selected Address does not exist in the database.")
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
			recCount = recCount + 1
			response.write ("<TABLE width='100%'>")
			for i=0 to howmanyfields
		                If (i / 2 = i \ 2) Then
                		        response.Write ("<TR class=tblRow1>")
		                Else
                		        response.Write ("<TR class=tblRow2>")
                		End If
				headcheck = InStr(1, theFieldDescript(i), "*")
				headstring = mid(Trim(theFieldDescript(i)),3,30)
				if headcheck > 0
				    response.write ("<tr class=tblhdr><td align=center colspan=2><b>" & headstring & "</b></td></tr>")
				    response.write ("<TD width='60%'>")
				    thisvalue = rstemp(i).value
				    if isdbnull(thisvalue) then
					thisvalue = "&nbsp;"
			                Write(intFileNum, "")
				    else
	        		        Write(intFileNum, Trim(thisvalue))
				    end if
				    response.write("</TD>")
				    response.write("</TR>")
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
