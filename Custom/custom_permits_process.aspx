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

	function SuperQuery() {
		document.SQry.submit();
	}

function PermitSoft(v) {
	window.open('int_PermitSoft.aspx?id=' + v);
}

function SIRE(v,sd) {
	window.open('int_SIRE.aspx?id=' + v + '&SearchDimension=' + sd);
}



function PermitDetails(n) {
	document.location="custom_permit_details.aspx?pid=" + n;
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
	dim intFileNum 
	dim DateNow
	dim strFileName 
	Dim firstJS
	Dim SQ

	Coords=""

	MaxRecordsPerPage=50

	if request("lyr")<> "" then
		session("lyr") = request("lyr")
	end if

	if request("idall")="true" then
		idAlliFrame=true
	else
		idAlliFrame=false
	end if

'Important''''''''''''''''''''''''''''''''
session("lyr")="id_permits"
session("Fld_DB")="PERMIT_NUMBER"
session("Fld_SHP")="PER_NUM"
session("Fld_DBNAMES")="PERMIT_NUMBER,APPLICATION_NUMBER,WORK_Description,ISSUED_DATE,FINALED_DATE,VALUATION,X_Coord,Y_Coord,"
session("ds")="Provider=SQLOLEDB.1;Initial Catalog=PermitSQL;Server=sql2;User Id=gis;Password=gis;pooling=false;connection timeout=120;"
session("DBTbl")="vPermitSQL"
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
					objWC.value="&apos;" + p1 + "&apos;";
					//objWC.value="'" + p1 + "'";
					//objWC.value=p1;
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


	if request.querystring("APN") <> "" then
		strSQL = "Select " & session("Fld_DBNAMES") & session("Fld_DB") & " from " & Trim(session("DBTbl")) & " where APN in ("
	
		strSQL &= "'" & request("APN") & "')"
	elseif request.querystring("GVar") <> "" then
		dim IDAllVars
		
		IDAllVars=replace( left(request.querystring("GVar"),len(request.querystring("GVar"))-1),", ", ",")
		
		strSQL = "Select " & session("Fld_DBNAMES") & session("Fld_DB") & " from " & Trim(session("DBTbl")) & " where APPLICATION_NUMBER in ("
		
		strSQL &= "'" & replace(IDAllVars,",","','") & "')"
	else
		If Trim(Request.Form("QueryString")) = "" Then

			strSQL = "Select " & session("Fld_DBNAMES") & session("Fld_DB") & " from " & Trim(session("DBTbl")) & " where "
			if trim(request.form("PermitNumber"))<> "" then
				strSQL &= " Permit_Number " & request.form("PNOpr") & "'" & request.form("PermitNumber")
				if trim(ucase(request.form("PNOpr")))="LIKE" then
					strSQL &="%"
				end if
				strSQL &="' AND "
			end if
			if trim(request.form("ApplicationNumber"))<> "" then
				strSQL &= " Application_Number " & request.form("ANOpr") & " '" & request.form("ApplicationNumber")
				if trim(ucase(request.form("ANOpr")))="LIKE" then
					strSQL &="%"
				end if
				strSQL &="' AND "
			end if
			if trim(request.form("WorkDescription"))<> "" then
				strSQL &= " WORK_TYPE = '" & request.form("WorkDescription") & "' AND "
			end if
			if trim(request.form("IssuedDateStart"))<>"" and trim(request.form("IssuedDateStart"))<> "//" then
				strSQL &= " Issued_Date >= '" & request.form("IssuedDateStart") & "' AND "
			end if
			if trim(request.form("IssuedDateEnd"))<>"" and trim(request.form("IssuedDateEnd"))<> "//" then
				strSQL &= " Issued_Date <= '" & request.form("IssuedDateEnd") & "' AND "
			end if
			if trim(request.form("FinaledDateStart"))<> "" and trim(request.form("FinaledDateStart"))<> "//" then
				strSQL &= " Finaled_Date >= '" & request.form("FinaledDateStart") & "' AND "
			end if
			if trim(request.form("FinaledDateEnd"))<>"" and trim(request.form("FinaledDateEnd"))<> "//" then
				strSQL &= " Finaled_Date <= '" & request.form("FinaledDateEnd") & "' AND "
			end if
			if trim(request.form("V1"))<> "" then
				strSQL &= " Valuation >= " & request.form("V1") & " AND "
			end if
			if trim(request.form("V2"))<> "" then
				strSQL &= " Valuation <= " & request.form("V2") & " AND "
			end if

		        strSQL = Left(strSQL, Len(strSQL) - 5) 'remove the last "AND"
			strSQL &= " ORDER BY Permit_Number"

		Else
			strSQL = Trim(Request.Form("QueryString"))
		End If
	end if

response.write (vbcrlf & "<!--- " & strSQL & " --->" & vbcrlf)


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
		Response.Write("<font color=red>No Records found based on your selections</font><br><br>&nbsp;&nbsp;&nbsp;")
		
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

	intFileNum = FreeFile()
	DateNow = Now()
	strFileName = "CH_PD_" & Format(DateNow, "MM_dd_yyyy") & "_" & Format(DateNow, "hh_mm_ss_tt")

	FileOpen(intFileNum, HttpRuntime.AppDomainAppPath & "CSV\" & strFileName & ".csv", OpenMode.Output)

	Write(intFileNum, "Permit Number")
	Write(intFileNum, "Application Number")
	Write(intFileNum, "Work Type")
	Write(intFileNum, "Issued Date")
	Write(intFileNum, "Finaled Date")
	Write(intFileNum, "Valuation")
        WriteLine(intFileNum)   ' Print blank line to file.


        response.write ("<TABLE border='0' cellspacing='1' cellpadding='2' width=95% ><TR>")

        response.write ("<TH class=tblHdr align=center>Highlight Map</TH>")

	response.write ("<TH class=tblHdr>Permit Detail</TH>")
	response.write ("<TH class=tblHdr>Imaging</TH>")
	response.write ("<TH class=tblHdr>Permit City</TH>")
 
response.write ("<TD class=tblHdr><nobr>Permit Number</nobr></td>")
response.write ("<TD class=tblHdr><nobr>Application Number</nobr></td>")
response.write ("<TD class=tblHdr><nobr>Work Type</nobr></td>")
response.write ("<TD class=tblHdr><nobr>Issued Date</nobr></td>")
response.write ("<TD class=tblHdr><nobr>Finaled Date</nobr></td>")
response.write ("<TD class=tblHdr><nobr>Valuation</nobr></td>")
      
        idx=ubound(FieldNamestoDisplay)

        response.write ("</TR>")

        reccount = 0
		CustLayer = Trim(CStr(session("Lyr")))

		For i = nStart To nEnd
            If (reccount / 2 = reccount \ 2) Then
                response.write ("<TR class=tblRow1>")
            Else
                response.write ("<TR class=tblRow2>")
            End If

            n = n + 1
            reccount = reccount + 1

			'Highlight Column
			thisvalue = Trim(CStr(DT.Rows(i)(idx)))
			if instr(thisvalue," ")>0 then
				IDValue = "&apos;" & thisvalue & "&apos;"
			else
				IDValue = thisvalue
			end if

			response.write ("<TD width=85><nobr><center><a href='javascript:SendValue(""" & Trim(CStr(session("Fld_SHP"))) & """,""" & IDValue & """,""" & CustLayer & """);'><img src='../images/menuicons/mnu_nav_zoomin.gif' border=0></a></center></nobr></TD>")
			FirstJS="SendValue(""" & Trim(CStr(session("Fld_SHP"))) & """,""" & IDValue & """,""" & CustLayer & """)"

			response.write ("<TD width=85><nobr><center><a href=""javascript:PermitDetails('" & IDValue & "');"">" & DT.Rows(i)(0) & "</a></center></nobr></TD>")
			response.write ("<TD width=85><nobr><center><a href=""javascript:SIRE('CD_BLDG_App_Plans|Application_Number|" & DT.Rows(i)(1) & "|CD_BLDG_App_Reports|Application_Number|" & DT.Rows(i)(1) & "|CD_BLDG_Permits_and_Apps|Application_Number|" & DT.Rows(i)(1) & "',3);"">" & DT.Rows(i)(1) & "</a></center></nobr></TD>")
			response.write ("<TD width=85><nobr><center><a href=""javascript:PermitSoft('" & DT.Rows(i)(1) & "');"">" & DT.Rows(i)(1) & "</a></center></nobr></TD>")

		SQ &= DT.Rows(i)(0) & "|"
            For j = 0 To ubound(FieldNamestoDisplay)-3
				if isDBNull(DT.Rows(i)(j))=false then
					thisvalue = Trim(CStr(DT.Rows(i)(j)))

					If Trim(thisvalue) = "" Then
						response.write ("<td>&nbsp;</td>")
					Else
						response.write ("<td>" & thisvalue & "</TD>")
					End If
					Write(intFileNum, thisvalue)
				else
					response.write ("<td>&nbsp;</td>")
					Write(intFileNum, "")
				end if
            Next

			Coords &= n & "," & DT.Rows(i)(ubound(FieldNamestoDisplay)-2) & "," & DT.Rows(i)(ubound(FieldNamestoDisplay)-1) & ","

            response.write ("</TR>")
        WriteLine(intFileNum)   ' Print blank line to file.
		next

        response.write ("</TABLE><br><br><br>")
		
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

'			response.write ("&nbsp;<input class=btnNAV type=button value='Start Over' onclick=""document.location='" & StartOverASP & "'"">&nbsp;")

			' Next page
			if (nPage+1)<=nPageCount.toString then
				response.write ("<input class=btnNAV type=button value=' > ' onclick=""javascript:NPRecords(" & (nPage + 1).ToString() & ")"">&nbsp;")
			end if
			' Last page
			if (nPage)<nPageCount.ToString() then
				response.write ("<input class=btnNAV type=button value=' >> ' onclick=""javascript:NPRecords(" & nPageCount.ToString() & ")"">")
			end if

			response.write ("</form>Page <b>" & nPage & "</b> of <b>" & nPageCount.ToString() & "</b><br>")
			response.Write ("(" & nRecCount.ToString() & " total records)<br></center>")
		end if
	Else
        response.write ("No data found.<br><br>")
        response.write ("&nbsp;<center><input type=button class=Btn onclick=""document.location='" & StartOverASP & "'"" Value=""Start Over""></center>&nbsp;")
    End If

      FileClose(intFileNum)
    Err.Clear()

'	if reccount=1 then
'		response.write ("<SCRIPT LANGUAGE='JavaScript' TYPE='text/javascript'>" & FirstJS & "</script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>")
'	end if

%>

<center>
<br><input type=button onclick='window.print();' value="Print">&nbsp;&nbsp;&nbsp;
<input type=button onclick='SuperQuery();' value="Super Query">
<br><br><a href='..\CSV\<%=strFileName%>.csv'>Right-Click Here</a> and select 'Save Target As' to download CSV file.
</center>

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

<form name="SQry" action="http://gis/website/SIREIntegration/index.aspx" method="POST" target="_new">
<input type=hidden name="IDs" value="<%=mid(SQ,1,len(SQ)-1)%>">
<input type=hidden name="SearchDimension" value="1">
</form>

</body>
