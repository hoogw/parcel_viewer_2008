<%@ Page Language="vb" AutoEventWireup="false" Codebehind="AssessorPrint.aspx.vb" Inherits="dotNETViewer.AssessorPrint" aspcompat=true%>

<%@ Import Namespace=System.Data %>
<%@ Import Namespace=System.Data.OleDB %>

<%
'************************************************************************************************************************************
'	ASPX PAGE
'
'	This ASPX page serves as the presentation layer while the VB page serves as the code page.  In some cases, I utilize a public 
'	variable named INFORMATION to dynamically generate HTML which is then displayed on the presentation layer (ASPX page).  Simply 
'   including the value of this public variable will effectively include that dynamically generated HTML code at run-time. The 
'   purpose of this page is to display formatted information to the user.  This ASPX page is dynamically generated with 
'   each page request.  Take note that not all portions of the HTML code will be displayed with each page request due to various
'   conditions.  Please see the special notes section for more explanation (if applicable).
'
'	SPECIAL NOTES regarding this ASPX page:
'	
'	Inclusion of the header.aspx file (located in the includes filder) allows the user of a common 'header' for all ASPX files.
'	By including this file, a common CSS can be shared and 'included' throughout all ASPX pages.
'	
'	The purpose of this page is to provide the HTML interface to 
'
'************************************************************************************************************************************
%>
<%
On Error Resume Next
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<TITLE></TITLE>

<style>
	tr {	margin : 0px 0px 0px 0px;
 }
	td {	font-size: 9px;
		font-family: Verdana, Arial, sans-serif;
		margin : 0px 0px 0px 0px;
 }
</style>


	</HEAD>
	<BODY topmargin="0" leftmargin="0" marginheight="0" marginwidth="0" onload="self.print();">
		<% 
		On Error Resume Next
		
		Dim scale, mMap, mOvMap,scalev
		
		'If our print map object is invalid, our session timed out - so alert the user!
        If IsNothing(Session("MapObj")) = True Or IsNothing(Session("OVMapObj")) = True Then
            Response.Redirect("../includes/session_timeout.aspx", True)
        End If
		
		'Get the map and overview map session objects.
		mMap = session("MapObj")
		mOvMap = session("OVMapObj")
		
		'Get print options (scale).
		scale = CInt(request.querystring("mapscale"))
		scalev = CInt(request.querystring("mapscalev"))
	
		select case scale
			case 1: scale=200
			case 2: scale=100
			case 3:	scale=scalev
		end select
		
		%>
		<TABLE border="2" cellpadding="0" cellspacing="0" width="<%= (TableWidth) %>">
			<TR valign=middle>
				<TD width="100%">
					<TABLE border="0" width="100%" cellpadding="0" cellspacing="0">
						<TR>
							<td align=left><%=format(now(),"MM/dd/yyyy")%></td>
						<%if trim(request.querystring("TitleText")) <> "" then%>
							<TD width="100%" align="center" valign="center"><FONT size="2"><b><%=trim(request.querystring("TitleText"))%></b></FONT></TD>
						<%else%>
							<TD width="100%" align="center" valign="center"><FONT size="2"><b><%=Application("PrintTitle")%></b></FONT></TD>
						<%end if%>
							<TD><img border="0" src="../images/CountyLogo60x58.jpg" height=50 align="right"></TD>
						</TR>
					</TABLE>
				</TD>
			</TR>
			<TR>
				<TD width="100%" align="center" valign="center">
					<TABLE border="0" width="100%" cellpadding="2" cellspacing="2">
						<TR>
							<TD width="100%" align="center" valign="center"><img border=0 src="<%= MapImage %>"></TD>
						</TR>
					</TABLE>
				</TD>
			</TR>
<!---
			<TR>
				<TD height="100">
					<TABLE border="1" width="100%">
						<TR>
							<TD width="20%" align="center" colspan=2><img border=0 src="<%= OvMapImage %>"></TD>
							<TD width="33%" align="center" colspan=2><img border=0 src="<%= LegendURL %>"></TD>
						</TR>
					</TABLE>
				</TD>
			</TR>
--->
			<tr><td>

<%

	Dim strSQL
	Dim intFieldCount 
	Dim i as integer
	dim j as integer
	Dim reccount 
	Dim thisvalue
	Dim n 
	Dim WhereClauseValid 
	Dim IDValue 
	Dim CustLayer 
	Dim idx
	Dim StartOverASP
	Dim FieldNamestoDisplay
	dim FindInArray
	dim DS,DT,nRecCount,nPageCount,nPage
	dim nStart, nEnd
	Dim FirstRec as string
	dim idAlliFrame
	Dim TheAPN as string
	Dim apnBook, apnPage, apnParcel,apnSubParcel
	Dim dbSource as string
	Dim pConn As OleDbConnection
	Dim pAdapter As OleDbDataAdapter
	Dim pReader
	dim tmpDS
	Dim theAddress, theJurisdiction, theSupDistrict

	TheAPN = Session("BookMark").APN 'request("APN")

	if trim(TheAPN)="" then
		response.write ("No Parcel selected")
	else
			
			apnBook = left(TheAPN, 3)
			apnPage = mid(TheAPN,4,4)
			apnParcel = mid(TheAPN,8,3)
			apnSubParcel = right(TheAPN,4)

			session("ds") = "Provider=SQLOLEDB.1;" & Application("dbSource")
			dbSource=session("ds")


			If InStr(UCase(session("ds")), "PROVIDER") > 0 Then
				tmpDS = session("ds")
			Else
				tmpDS = "Provider=SQLOLEDB.1;" & session("ds")
			End If

			pConn = New OleDbConnection(tmpDS)
			pConn.Open()

			if cint(err.number)<>0 or cstr(err.description) <> "" then
				response.write ("Error with DB Connection String: " & cint(err.number) & " - " & cstr(err.description) & "<br>")
				if session("tb") then
					response.write ("<script>top.HaltLYRHide=0; top.MapFrame.hideLoadingLyr();</script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>")
				end if
				response.end
			end if

			strSQL = "select * from vPARCELS_SUPS where APN = '" & TheAPN & "'"

			pAdapter = New OleDbDataAdapter(strSQL,pConn)
			pReader = pAdapter.SelectCommand.ExecuteReader

			pReader.read()

			theAddress=pReader(1) & " " & pReader(2)
			theJurisdiction=pReader(38)
			theSupDistrict=pReader(37)
		%>

		<table width=100% border=1 >
		<tr valign=top>
		<td width=50%>
		<TABLE summary="Formatting Table"  width='100%' ID="Table3">
			<TR><TD width=50%><b>Parcel Number</b></TD><TD width='50%'><%=apnBook%>-<%=apnPage%>-<%=apnParcel%>-<%=apnSubParcel%></TD></TR>
			<TR><TD><b>Address</b></TD><TD><%=theAddress%></TD></TR>
			<TR><TD><b>Jurisdiction</b></TD><TD><%=theJurisdiction%></TD></TR>
			<TR><TD><b>Supervisor District</b></TD><TD><%=theSupDistrict%></TD></TR>
			<TR><TD bgcolor='navy' align=center colspan=2><font color='Yellow'><B>ASSESSOR'S <%=pReader("Roll_Year")%> ROLL VALUES</B></font></TD></TR>
			<tr><td><b>Land Value ($)</b></td><td bgcolor="white"><%=pReader("LAND_VALUE")%></td></tr>
			<tr><td><b>Improvement Value ($)</b></td><td bgcolor="white"><%=pReader("IMPROVEMENT_VALUE")%></td></tr>
			<tr><td><b>Personal Property Value ($)</b></td><td bgcolor="white"><%=pReader("PERSONAL_PROPERTY_VALUE")%></td></tr>
			<tr><td><b>Fixtures ($)</b></td><td bgcolor="white"><%=pReader("Fixtures")%></td></tr>
			<tr><td><b>Homeowner's Exemption ($)</b></td><td bgcolor="white"><%=pReader("HOMEOWNERS_EXEMPTION")%></td></tr>
			<tr><td><b>Other Exemption ($)</b></td><td bgcolor="white"><%=pReader("OTHER_EXEMPTION")%></td></tr>
			<tr><td><b>Net Assessed Value ($)</b></td><td bgcolor="white"><%=pReader("NET_ASSESSED_VALUE")%></td></tr>
			<TR><TD bgcolor='navy' align=center colspan=2><font color='Yellow'><B>LAND INFORMATION</B></font></TD></TR>
			<tr><td><b>Thomas Brothers Coordinates</b></td><td><%=pReader("THOMAS_BROS_GRID_COORDS")%></td></tr>
			<tr><td><b>Assessor's Land Use Code</b></td><td><b><%=pReader("ASSESSOR_LAND_USE_CODE")%></b></td></tr>
			<tr><td><b>Subdivision Name</b></td><td><%=pReader("SUBDIVISION")%></td></tr>
			<tr><td><b>Lot Number</b></td><td><%=pReader("LOT_NUMBER")%></td></tr>
			<tr><td><b>Approx. Parcel Area (sq ft)</b></td><td><%=pReader("PARCEL_AREA")%></td></tr>
		</TABLE>
		</td>
		<td width=50%>
		<TABLE summary="Formatting Table"  width='100%' ID="Table3">
			<TR><TD bgcolor='navy' align=center colspan=2><font color='Yellow'><B>PROPERTY BUILDING INFORMATION</B></font></TD></TR>

		<%if ucase(mid(pReader("ASSESSOR_LAND_USE_CODE"),1,2)) <> "A1" OR (ucase(mid(pReader("ASSESSOR_LAND_USE_CODE"),1,2)) = "A1" AND (trim(cstr(pReader("TOTAL_LIVING_AREA")))="" OR cint(pReader("TOTAL_LIVING_AREA"))=0) ) then%>
			<tr><td colspan=2>No property building information is available for this parcel on-line.  Property information may be available for purchase at the Assessor's Office located at 3701 Power Inn Road, Suite 3000, Sacramento, CA</td></tr>
		<%else%>

		<tr><td width=55%><b>First Floor Area (sq ft)</b></td><td><%=pReader("FIRST_FLOOR")%></td></tr>
		<tr><td><b>Upper Floor Area (sq ft)</b></td><td><%=pReader("Other_bldg_area")%></td></tr>
		<tr><td><b>Finished Basement Area (sq ft)</b></td><td><%=pReader("FINISHED_BASEMENT")%></td></tr>
		<tr><td><b>Converted Garage Area (sq ft)</b></td><td><%=pReader("CONVERTED_GARAGE")%></td></tr>
		<tr><td><b>Addition Area (sq ft)</b></td><td><%=pReader("ADDITIONS")%></td></tr>
		<tr><td><b>Total Area (sq ft)</b></td><td><%=pReader("TOTAL_LIVING_AREA")%></td></tr>
		<tr><td><b>Garage Area (sq ft)</b></td><td><%=pReader("GARAGE_AREA")%></td></tr>

		<tr><td><table>
		<tr><td width=60%><b>Kitchen</b></td><td width=40%><%=pReader("KITCHEN")%></td></tr>
		<tr><td><b>Living Room</b></td><td><%=pReader("LIVING_ROOM")%></td></tr>
		<tr><td><b>Bedrooms</b></td><td><%=pReader("BEDROOMS")%></td></tr>
		<tr><td><b>Baths</b></td><td><%=pReader("BATHS")%></td></tr>
		<tr><td><b>Dining Room</b></td><td><%=pReader("DINING")%></td></tr>
		<tr><td><b>Family Room</b></td><td><%=pReader("FAMILY")%></td></tr>
		<tr><td><b>Misc. Rooms</b></td><td><%=pReader("MISC_ROOMS")%></td></tr>
		</table>
		</td>
		<td><table>
		<tr><td><b>Covered Parking Spaces</b></td><td align="left" bgcolor="white">&nbsp;<%=pReader("COVERED_PARKING_SPACES")%></td></tr>
		<tr><td><b>Heating/Cooling</b></td><td><%=pReader("HEATING_COOLING")%></td></tr>
		<tr><td><b>Fireplaces</b></td><td><%=pReader("FIREPLACES")%></td></tr>
		<tr><td><b>Pool</b></td><td><%if trim(cstr(pReader("POOL")))<>"" and cint(pReader("POOL"))>0 then%>Y<%else%>N<%end if%></td></tr>
		<tr><td><b>Spa</b></td><td><%=pReader("SPA")%></td></tr>
		<tr><td><b>Effective Year Built</b></td><td><%=pReader("EFFECTIVE_YEAR_BUILT")%></td></tr>
		<tr><td><b>Stories</b></td><td><%=pReader("STORIES")%></td></tr>
		</table>
		<%end if%>
		</TABLE>
		</td>
		</tr>
		</table>
	<%end if%>


			</td></tr>
		</TABLE>
	</BODY>
</HTML>





