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
session("lyr")="id_ProjectTracking"
session("Fld_DB")="FILE_NUM"
session("Fld_SHP")="FILE_NUM"
session("Fld_DBNAMES")="CITY_PR_N,PR_NAME,FILE_NUM,APPLICANT,PLANNER,DATE_SUB,DATE_COM,CUR_ZONE,"
session("ds")="Provider=SQLOLEDB.1;Initial Catalog=MasterAddressDB;Server=sql2;User Id=gis;Password=gis;pooling=false;connection timeout=120;"
session("DBTbl")="v_Entitlements"
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

		strSQL = "Select * from " & Trim(session("DBTbl")) & " where FILE_NUM in ("
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

	response.write ("<font class=SSHdr2>Entitlement Details for File Number: " & request("pid") & ":<br><br></font>")
        response.write ("<TABLE border='0' cellspacing='1' cellpadding='2' width=95% ><TR>")

	'response.write ("<tr><Td class=tblHdr>PermitSoft</Td><td><a href=""javascript:PermitSoft('" & request("pid") & "');"">Click Here</a></td></tr>")
	'response.write ("<tr><Td class=tblHdr>SIRE</Td><td><a href=""javascript:SIRE('" & request("pid") & "');"">Click Here</a></td></tr>")

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

'			response.write ("<TD width=85><nobr><center><a href='javascript:SendValue(""" & Trim(CStr(session("Fld_SHP"))) & """,""" & IDValue & """,""" & CustLayer & """);'>Rec " & n & "</a></center></nobr></TD>")
'			response.write ("<TD width=85><nobr><center><a href='javascript:PermitSoft(1);'>Rec " & n & "</a></center></nobr></TD>")
'			response.write ("<TD width=85><nobr><center><a href='javascript:SIRE(1);'>Rec " & n & "</a></center></nobr></TD>")

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

response.write ("<TD class=tblHdr width=120><nobr>" & DT.Columns(j).ColumnName & "</nobr></td>")

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
