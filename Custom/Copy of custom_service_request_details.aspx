<%@ Page aspcompat=true %>
<%@ Import Namespace=System.Data %>
<%@ Import Namespace=System.Data.OleDB %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<title>DB Input Form</title>

<!--#include file="../includes/Header.aspx"-->

<style>
	.btnNAV {	font-size: 13px;
				font-weight: bold;
				background-color: #E8F0EB;
	 }
</style>

</head>

<script language="Javascript">


function PermitSoft(v) {
	window.open('int_PermitSoft.aspx?id=' + v);
}

function SIRE(v) {
	window.open('int_SIRE.aspx?id=' + v);
}



</script>


<%
    'On Error Resume Next

	response.expires = -7 

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
    Dim ColourScheme
    Dim StartOverASP
    Dim FieldNamestoDisplay
    dim FindInArray
	dim DS,DT,nRecCount,nPageCount,nPage
	dim nStart, nEnd
	dim FirstRec as string
	dim idAlliFrame
	Dim MaxRecordsPerPage
	Dim Coords as string

	Coords=""

	MaxRecordsPerPage=100000

	if request("lyr")<> "" then
		session("lyr") = request("lyr")
	end if

	if request("idall")="true" then
		idAlliFrame=true
	else
		idAlliFrame=false
	end if

'Important''''''''''''''''''''''''''''''''
session("lyr")="id_servicerequests"
session("Fld_DB")="RequestID"
session("Fld_SHP")="Req_ID"
session("Fld_DBNAMES")="RequestID,OldReqID,RequestDate,RequestReceivedTime,RequestReceivedBy,InPerson,ByPhone,ByEmail,ByLetter,FirstName,LastName,CompanyName,Address,City,State,Zip,DayPhone,EvePhone,EMail,Fax,RequestStreetNumber,RequestStreetName,MapPage,MAD_ID,RequestLocation,RequestDescription,ReferralDate,ReferredDepartmentID,Division,Area,LastActionDate,NextActionDate,LotBook,CON,COA,ProblemProperty,ProblemPropertyPriority,DrugViolation,DrugCloseDt,Resolution,CompletedDate,CompletedBy,Department,SAVSAEligible,Posted,NextAction,FollowUpDate,PlacedBy,Closed,PhoneRoutetoCNA,OpenedCaseFileDate,CNAOriginated,CNACaseNumber,CNAAgency,CourtesyLetter,Priority,RequestFrom,ArchiveBoxNumber,PDHearing,HearingResolution,SRLastUpdt,"
session("ds")="Provider=SQLOLEDB.1;Initial Catalog=Servicerequest10102003;Server=sql2;User Id=gis;Password=gis;pooling=false;connection timeout=120;"
session("DBTbl")="SRUSER.ServiceRequest"
''''''''''''''''''''''''''''''''''''''''''

    FieldNamestoDisplay=split(session("Fld_DBNAMES"),",")
    
    ColourScheme=Application("ColourScheme")
	StartOverASP= session("StartOverASP")
    
%>

<script language='JavaScript' type='text/javascript'>
var undef, prefix, prefixTop
if (top.opener!=undef){prefix=top.opener.top.MapFrame; }else{if (opener==undef) {prefix=top.MapFrame;}else{prefix=opener.top.MapFrame;}}
prefixTop=top.opener.top;
</script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>

<body leftmargin="5" onload="prefixTop.HaltLYRHide=0; prefix.hideLoadingLyr();">

		<SCRIPT LANGUAGE='JavaScript' TYPE='text/javascript'>

			////Usually used for Search ALL and ID ALL
			function SendValue(fld,p1,QL) {

				var objWC = prefix.findObj("WhereClause")
				var objFN = prefix.findObj("SAFieldName")
				var objMF = prefix.findObj("MapFunction")
				var objQL = prefix.findObj("QueryLayer")
				var objC = prefix.findObj("CustomIDAllColour")
				var objZoomToFeature=prefix.findObj('ZoomToFeature');

				if (objWC!=null) {
					<%if idAlliFrame=true then%>
					if (objZoomToFeature!=null) { objZoomToFeature.value='N'; }
					<%else%>
					if (objZoomToFeature!=null) { objZoomToFeature.value='Y'; }
					<%end if%>
					prefix.positionLoadingLyr();
					//objWC.value="&apos;" + p1 + "&apos;";
					objWC.value=p1;
					objFN.value=fld;
					objMF.value=18;
					objC.value=255;
					objQL.value=QL;
					prefix.RefreshMap();
				}
			}

			////Usually used for Search by Address, Owner, APN
			
			//If zooming to and displaying parcel details, use the function below AND rename the function above to SendValue2
			//function SendValue(fnd,APN,QL) {
			//	prefix.positionLoadingLyr();
			//	
			//	var url = "parcel_details.aspx?APN=" + APN
			//	prefix.url = "";
			//	prefix.SSRefreshMap(APN,url);
			//}

		</script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>

<%
	if request("GVar")="" and idalliFrame=true then
		Response.Write("<font color=red>No Records found based on your selection</font><br><br>&nbsp;&nbsp;&nbsp;")
		response.end
	end if

		strSQL = "Select " & session("Fld_DBNAMES") & session("Fld_DB") & " from " & Trim(session("DBTbl")) & " where RequestID in ("
		strSQL &= "'" & request("pid") & "')"
	response.write ("<!--- SQL: " & strSQL & " --->")

    Dim pConn As OleDbConnection
    Dim pAdapter As OleDbDataAdapter
	dim tmpDS
	
    If InStr(UCase(session("ds")), "PROVIDER") > 0 Then
        tmpDS = session("ds")
    Else
        tmpDS = "Provider=SQLOLEDB.1;" & session("ds")
    End If

    pConn = New OleDbConnection(tmpDS)
    pConn.Open()

	if cint(err.number)<>0 or cstr(err.description) <> "" then
		response.write ("Error with DB Connection String: " & cint(err.number) & " - " & cstr(err.description) & "<br>")
		response.write ("<SCRIPT LANGUAGE='JavaScript' TYPE='text/javascript'>prefixTop.HaltLYRHide=0; prefix.hideLoadingLyr();</script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>")
		response.end
	end if
	
    pAdapter = New OleDbDataAdapter(strSQL,pConn)

	DS = New DataSet
	pAdapter.Fill(DS)

	DT = DS.Tables(0)

	nRecCount = DT.Rows.Count

	If nRecCount = 0 Then
		' Clean up
		' Do the no results HTML here
		Response.Write("<font color=red>No Records found based on your input:</font><br><br>&nbsp;&nbsp;&nbsp;")
		
		for i = 0 to request.form.count
			if trim(Request.Form("SAfld" & i)) <> "" then
				response.write ("<b>" & Request.Form("SAfld" & i) & "&nbsp;</b>")
			end if
		next
		response.write ("<br><br>")

        response.write ("&nbsp;<center><input type=button class=Btn onclick=""document.location='" & StartOverASP & "'"" Value=""Start Over""></center>&nbsp;")
		Response.End 
		' Done
	End If

	nPageCount = nRecCount \ MaxRecordsPerPage
	If nRecCount Mod MaxRecordsPerPage > 0 Then
		nPageCount += 1
	End If

	nPage = Convert.ToInt32(Request.QueryString("n"))
	If nPage < 1 Or nPage > nPageCount Then
		nPage = 1
	End If
	
	n=(nPage-1)*MaxRecordsPerPage

	nStart = MaxRecordsPerPage * (nPage - 1)
	nEnd = nStart + MaxRecordsPerPage - 1

	If nEnd > nRecCount - 1 Then
		nEnd = nRecCount - 1
	End If

    If Err.Number = 0 Then
       'Get Field Names

	response.write ("<font class=SSHdr2>Permits for Parcel " & request("APN") & ":<br><br></font>")
        response.write ("<TABLE border='0' cellspacing='1' cellpadding='2' width=95% ><TR>")

	response.write ("<tr><Td class=tblHdr width=100>PermitSoft</Td><td><a href=""javascript:PermitSoft('" & request("pid") & "');"">Click Here</a></td></tr>")
	response.write ("<tr><Td class=tblHdr>SIRE</Td><td><a href=""javascript:SIRE('" & request("pid") & "');"">Click Here</a></td></tr>")

        idx=ubound(FieldNamestoDisplay)

        response.write ("</TR>")

        reccount = 0
		CustLayer = Trim(CStr(session("Lyr")))

		For i = nStart To nEnd

            n = n + 1
            reccount = reccount + 1

			'Highlight Column
			thisvalue = Trim(CStr(DT.Rows(i)(idx)))
			if instr(thisvalue," ")>0 then
				IDValue = "&apos;" & thisvalue & "&apos;"
			else
				IDValue = thisvalue
			end if

'			response.write ("<TD><nobr><center><a href='javascript:SendValue(""" & Trim(CStr(session("Fld_SHP"))) & """,""" & IDValue & """,""" & CustLayer & """);'>Rec " & n & "</a></center></nobr></TD>")
'			response.write ("<TD><nobr><center><a href='javascript:PermitSoft(1);'>Rec " & n & "</a></center></nobr></TD>")
'			response.write ("<TD><nobr><center><a href='javascript:SIRE(1);'>Rec " & n & "</a></center></nobr></TD>")

            For j = 0 To ubound(FieldNamestoDisplay)-3
            If (reccount / 2 = reccount \ 2) Then
                response.write ("<TR class=tblRow1>")
            Else
                response.write ("<TR class=tblRow2>")
            End If
				if isDBNull(DT.Rows(i)(j))=false then
					thisvalue = Trim(CStr(DT.Rows(i)(j)))

					If Trim(thisvalue) = "" Then
						thisvalue="&nbsp;"
					End If
				else
					thisvalue="&nbsp;"
				end if

select case j
case 0:
response.write ("<TD class=tblHdr><nobr>Request ID</nobr></td>")
case 1:
response.write ("<TD class=tblHdr><nobr>Old Request ID</nobr></td>")
case 2:
response.write ("<TD class=tblHdr><nobr>Request Date</nobr></td>")
case 3:
response.write ("<TD class=tblHdr><nobr>Request Received Time</nobr></td>")
case 4:
response.write ("<TD class=tblHdr><nobr>Request Received By</nobr></td>")
case 5:
response.write ("<TD class=tblHdr><nobr>In Person</nobr></td>")
case 6:
response.write ("<TD class=tblHdr><nobr>By Phone</nobr></td>")
case 7:
response.write ("<TD class=tblHdr><nobr>By Email</nobr></td>")
case 8:
response.write ("<TD class=tblHdr><nobr>By Letter</nobr></td>")
case 9:
response.write ("<TD class=tblHdr><nobr>First Name</nobr></td>")
case 10:
response.write ("<TD class=tblHdr><nobr>Last Name</nobr></td>")
case 11:
response.write ("<TD class=tblHdr><nobr>Company Name</nobr></td>")
case 12:
response.write ("<TD class=tblHdr><nobr>Address</nobr></td>")
case 13:
response.write ("<TD class=tblHdr><nobr>City</nobr></td>")
case 14:
response.write ("<TD class=tblHdr><nobr>State</nobr></td>")
case 15:
response.write ("<TD class=tblHdr><nobr>Zip</nobr></td>")
case 16:
response.write ("<TD class=tblHdr><nobr>Day Phone</nobr></td>")
case 17:
response.write ("<TD class=tblHdr><nobr>Evening Phone</nobr></td>")
case 18:
response.write ("<TD class=tblHdr><nobr>EMail</nobr></td>")
case 19:
response.write ("<TD class=tblHdr><nobr>Fax</nobr></td>")
case 20:
response.write ("<TD class=tblHdr><nobr>Request Street Number</nobr></td>")
case 21:
response.write ("<TD class=tblHdr><nobr>Request Street Name</nobr></td>")
case 22:
response.write ("<TD class=tblHdr><nobr>Map Page</nobr></td>")
case 23:
response.write ("<TD class=tblHdr><nobr>MAD_ID</nobr></td>")
case 24:
response.write ("<TD class=tblHdr><nobr>Request Location</nobr></td>")
case 25:
response.write ("<TD class=tblHdr><nobr>Request Description</nobr></td>")
case 26:
response.write ("<TD class=tblHdr><nobr>Referral Date</nobr></td>")
case 27:
response.write ("<TD class=tblHdr><nobr>Referred Department ID</nobr></td>")
case 28:
response.write ("<TD class=tblHdr><nobr>Division</nobr></td>")
case 29:
response.write ("<TD class=tblHdr><nobr>Area</nobr></td>")
case 30:
response.write ("<TD class=tblHdr><nobr>Last Action Date</nobr></td>")
case 31:
response.write ("<TD class=tblHdr><nobr>Next Action Date</nobr></td>")
case 32:
response.write ("<TD class=tblHdr><nobr>Lot Book</nobr></td>")
case 33:
response.write ("<TD class=tblHdr><nobr>CON</nobr></td>")
case 34:
response.write ("<TD class=tblHdr><nobr>COA</nobr></td>")
case 35:
response.write ("<TD class=tblHdr><nobr>Problem Property</nobr></td>")
case 36:
response.write ("<TD class=tblHdr><nobr>Problem Property Priority</nobr></td>")
case 37:
response.write ("<TD class=tblHdr><nobr>Drug Violation</nobr></td>")
case 38:
response.write ("<TD class=tblHdr><nobr>Drug Close Date</nobr></td>")
case 39:
response.write ("<TD class=tblHdr><nobr>Resolution</nobr></td>")
case 40:
response.write ("<TD class=tblHdr><nobr>Completed Date</nobr></td>")
case 41:
response.write ("<TD class=tblHdr><nobr>Completed By</nobr></td>")
case 42:
response.write ("<TD class=tblHdr><nobr>Department</nobr></td>")
case 43:
response.write ("<TD class=tblHdr><nobr>SAVSA Eligible</nobr></td>")
case 44:
response.write ("<TD class=tblHdr><nobr>Posted</nobr></td>")
case 45:
response.write ("<TD class=tblHdr><nobr>Next Action</nobr></td>")
case 46:
response.write ("<TD class=tblHdr><nobr>Follow UpDate</nobr></td>")
case 47:
response.write ("<TD class=tblHdr><nobr>Placed By</nobr></td>")
case 48:
response.write ("<TD class=tblHdr><nobr>Closed</nobr></td>")
case 49:
response.write ("<TD class=tblHdr><nobr>Phone Route to CNA</nobr></td>")
case 50:
response.write ("<TD class=tblHdr><nobr>Opened Case File Date</nobr></td>")
case 51:
response.write ("<TD class=tblHdr><nobr>CNA Originated</nobr></td>")
case 52:
response.write ("<TD class=tblHdr><nobr>CNA Case Number</nobr></td>")
case 53:
response.write ("<TD class=tblHdr><nobr>CNA Agency</nobr></td>")
case 54:
response.write ("<TD class=tblHdr><nobr>Courtesy Letter</nobr></td>")
case 55:
response.write ("<TD class=tblHdr><nobr>Priority</nobr></td>")
case 56:
response.write ("<TD class=tblHdr><nobr>Request From</nobr></td>")
case 57:
response.write ("<TD class=tblHdr><nobr>Archive Box Number</nobr></td>")
case 58:
response.write ("<TD class=tblHdr><nobr>PD Hearing</nobr></td>")
case 59:
response.write ("<TD class=tblHdr><nobr>Hearing Resolution</nobr></td>")
case 60:
response.write ("<TD class=tblHdr><nobr>SR Last Update</nobr></td>")
end select


response.write ("<td>" & thisvalue & "</TD>")
      

            Next

			Coords &= n & "," & DT.Rows(i)(ubound(FieldNamestoDisplay)-2) & "," & DT.Rows(i)(ubound(FieldNamestoDisplay)-1) & ","

            response.write ("</TR><tr><td colspan=2><hr width=100% color=black></td></tr>")
		next

        response.write ("</TABLE><br><center><a href='javascript:history.go(-1);'>Go Back</a></center><br><br>")
		
		if idAlliFrame=false then
			response.write ("<SCRIPT LANGUAGE='JavaScript' TYPE='text/javascript'>function NPRecords(i) { document.Qry.action=""" & request.url.segments(ubound(request.url.segments)) & "?SA=")
			if request.form("SA")=1 or request("SA")=1 then
				response.write ("1")
			end if
			response.write ("&n="" + i; prefixTop.HaltLYRHide=1; prefix.positionLoadingLyr(); document.Qry.submit(); }</script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>")

			response.write ("<form><center>")
			' First page
			if (nPage)>1 then
				response.write ("<input class=btnNAV type=button value=' << ' onclick=""javascript:NPRecords(1)"">&nbsp;")
			end if
			' Previous page
			if (nPage-1)>0 then
				response.write ("<input class=btnNAV type=button value=' < ' onclick=""javascript:NPRecords(" & (nPage - 1).ToString() & ")"">&nbsp;")
			end if

			' Next page
			if (nPage+1)<=nPageCount.toString then
				response.write ("<input class=btnNAV type=button value=' > ' onclick=""javascript:NPRecords(" & (nPage + 1).ToString() & ")"">&nbsp;")
			end if
			' Last page
			if (nPage)<nPageCount.ToString() then
				response.write ("<input class=btnNAV type=button value=' >> ' onclick=""javascript:NPRecords(" & nPageCount.ToString() & ")"">")
			end if

'			response.write ("</form>Page <b>" & nPage & "</b> of <b>" & nPageCount.ToString() & "</b><br>")
'			response.Write ("(" & nRecCount.ToString() & " total records)<br></center>")
		end if
	Else
        response.write ("No data found.<br><br>")
        response.write ("&nbsp;<center><input type=button class=Btn onclick=""document.location='" & StartOverASP & "'"" Value=""Start Over""></center>&nbsp;")
    End If

    Err.Clear()

	if reccount=1 then
		response.write ("<SCRIPT LANGUAGE='JavaScript' TYPE='text/javascript'>" & FirstRec & "</script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>")
	end if

%>

<input type=hidden name=SA value="<%=request("SA")%>">
<%if request("SA")="1" or request.form("SA")=1 then%>
<script language="Javascript">
	opener.top.MapFrame.positionLoadingLyr();
	opener.top.MapFrame.url = "";
	opener.top.MapFrame.SSRefreshMap('<%=Coords%>','',1);
</script>
<%end if%>
		<form name="Qry" method=post ID="Form1">
		<input type=hidden name="QueryString" value="<%=strSQL%>">
		</form>

</form>
</body>
