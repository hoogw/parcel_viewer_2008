<!--- Custom Mailing Labels ASP file --->
<!--- Inputs: 
		APN		request("APN")		The APN number(s)
		ds		request("ds")		The data source connection string
		CS			request("CS")			The colour scheme ID
	  REQUIREMENT:
		* <body onload="top.MapFrame.hideLoadingLyr()">
	    * session("ds") = request("ds")  ;this session("ds") will be used in all ASP pages which need to reference the data source
--->


<% response.expires = -7 %>
<%
	if trim(request("CS")) <> "" then
		application("CS")=trim(request("CS"))
	end if
%>
<html>
<head>
	<title>Parcel Detail Results</title>
</head>
<!--#include file="../includes/header.aspx"-->

<body>

<FONT FACE="Arial,sans-serif" SIZE="-2">
<% 
dim columncount

theNum = request("APNs")
theNum=replace(theNum,"'","")

if trim(theNum) = "" then
	response.Write ("No Parcel selected. Please try again.")
	response.End
end if

SQLquery = "SELECT OwnName1, address, city, zipcode FROM PARCELS WHERE APN in ("  & theNum & ")" 
set conntemp=server.createobject("adodb.connection")

session("ds") = request("ds")
conntemp.open session("ds")

set rstemp=conntemp.execute(SQLquery)

rstemp.movefirst()
columncount = 4

response.Write "<TABLE border='0' width='100%'><tr>"

do while not rstemp.eof

	howmanyfields=rstemp.fields.count-1

	for j = 0 to howmanyfields
		thisvalue=rstemp(j)
		if isnull(thisvalue) then
			thisvalue="&nbsp;"
		else
			thisvalue=rstemp(j)
		end if
		
        Select Case j
            Case 0
                If columncount Mod 3 = 1 Then
                    response.write ("<TD align='left' width='37%' height='92'>")
                ElseIf columncount Mod 3 = 2 Then
                    response.write ("<td width='3'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td><TD align='left' width='32%' height='92'>")
                ElseIf columncount Mod 3 = 0 Then
                    response.write ("<td width='3'>&nbsp;&nbsp;&nbsp;&nbsp;</td><TD align='left' width='31%' height='92'>")
                End If
                response.write ("<FONT FACE='Arial,sans-serif' SIZE='-2'>" & thisvalue)
            Case 1
                response.write ( "<br>" & thisvalue)
            Case 2
                response.write ( "<br>" & thisvalue & ", MD&nbsp;&nbsp;")
            Case 3
                response.write (thisvalue & "</FONT></TD>")
        End Select



		'response.Write "<td width=35% ><b>" & rstemp.fields.item(i).name & "</b></td><td width=65% >" & thisvalue & "</td></tr>"
	next

    If columncount Mod 3 = 0 And rstemp.eof = False Then
        response.write ("</tr><tr>")
    ElseIf columncount Mod 3 = 0 And rstemp.eof = False Then
        response.write ("</tr>")
    ElseIf rstemp.eof Then
        For i = 2 To (columncount Mod 3) Step -1
            response.write ("<td>&nbsp;</td>")
        Next
    End If

    columncount = columncount + 1
	rstemp.movenext()
loop

	response.Write ("</table><br><br><br>")
	rstemp.close
	set rstemp=nothing
	conntemp.close
	set conntemp=nothing

 %>
 
</FONT></body>
</html>
