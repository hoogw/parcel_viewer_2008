<%@ Page aspcompat=true %>
<%@ Import Namespace=System.Data %>
<%@ Import Namespace=System.Data.OleDB %>

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
	Dim FirstRec as string
	dim idAlliFrame
	Dim MaxRecordsPerPage
    Dim intFileNum As Integer
    Dim DateNow
    Dim strFileName As String

	MaxRecordsPerPage=100

	if request("lyr")<> "" then
		session("lyr") = request("lyr")
	end if

	if request("idall")="true" then
		idAlliFrame=true
	else
		idAlliFrame=false
	end if

	'Important''''''''''''''''''''''''''''''''
	session("lyr")="13"
	session("Fld_DB")="APN"
	session("Fld_SHP")="APN"
	session("Fld_DBNAMES")="APN,p_Address,owner_name"
	session("ds")="Provider=SQLOLEDB.1;" & Application("dbSource")
	session("DBTbl")="Parcels"
	''''''''''''''''''''''''''''''''''''''''''
response.Write(session("ds"))
	if session("ds") = "" then
		response.write ("Invalid data source")
		response.end
	end if

	
    FieldNamestoDisplay=split(session("Fld_DBNAMES"),",")
    
    ColourScheme=Application("ColourScheme")
	StartOverASP= session("StartOverASP")
    
%>
<body leftmargin="5" onload="top.HaltLYRHide=0; top.MapFrame.hideLoadingLyr();">

		<script language="javascript">

			////Usually used for Search by Address, Owner, APN
			
			//If zooming to and displaying parcel details, use the function below AND rename the function above to SendValue2
			function SendValue(fnd,APN,QL) {
				top.MapFrame.positionLoadingLyr();
				top.MapFrame.clearBufUrl(1);
				var url = "SS/parcel_details.aspx?APN=" + APN
				top.MapFrame.url = "";
				top.MapFrame.SSRefreshMap(APN,url);
			}

		</script>

	<center><input type=button class=Btn onclick='window.print();' Value="Print List">&nbsp;&nbsp;<input type=button class=Btn onclick='top.MapFrame.SaveMap()' Value="Print Map">
<!---
	<br><input type=button class=Btn onclick="top.MapFrame.GoSimpleGUIiFrameRight('custom/searchmain.aspx');" Value='New Search'>
--->
<br><br></center>
<%

    strSQL = "Select " & session("Fld_DBNAMES") & " from " & Trim(session("DBTbl")) & " where "

    If Trim(Request.Form("QueryString")) = "" Then
		if trim(request.form("SAfld0")) <> "" then
			strSQL = Trim(CStr(Request.Form("SAfld0Name"))) & " = '" & Trim(CStr(Request.Form("SAfld0"))) + "' "
		end if
		if trim(request.form("SAfld1")) <> "" then
			strSQL = Trim(CStr(Request.Form("SAfld0Name"))) & " >= '" & Trim(CStr(Request.Form("SAfld0"))) + "' AND "
			strSQL &= Trim(CStr(Request.Form("SAfld1Name"))) & " <= '" & Trim(CStr(Request.Form("SAfld1"))) + "' "
		end if

		strSQL = "Select " & session("Fld_DBNAMES") & " from " & Trim(session("DBTbl")) & " where " & strSQL & " ORDER BY APN"

    Else
        strSQL = Trim(Request.Form("QueryString"))
    End If	

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
		response.write ("<script>top.HaltLYRHide=0; top.MapFrame.hideLoadingLyr();</script>")
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
		Response.Write("No Items found.<br><br>")
        response.write ("&nbsp;<input type=button class=Btn onclick=""document.location='" & StartOverASP & "'"" Value=""Start Over"">&nbsp;")
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
        intFileNum = FreeFile()
        DateNow = Now()
        strFileName = "Properties_" & Format(DateNow, "MM_dd_yyyy") & "_" & Format(DateNow, "hh_mm_ss_tt")

        FileOpen(intFileNum, HttpRuntime.AppDomainAppPath & "CSV\" & strFileName & ".csv", OpenMode.Output)
        Write(intFileNum, "Parcel ID")
        Write(intFileNum, "Address")
        Write(intFileNum, "Owner")
        WriteLine(intFileNum)

        response.write ("<TABLE border='0' cellspacing='1' cellpadding='2' width=95% ><TR>")

		response.write ("<TH class=tblHdr>Parcel ID</TH>")
		response.write ("<TH class=tblHdr>Address</TH>")
		response.write ("<TH class=tblHdr>Owner</TH>")
        response.write ("</TR>")

        reccount = 0
        n = CInt(Request("n"))
		CustLayer = Trim(CStr(session("Lyr")))

		For i = nStart To nEnd
            If (reccount / 2 = reccount \ 2) Then
                response.write ("<TR class=tblRow1>")
            Else
                response.write ("<TR class=tblRow2>")
            End If

            n = n + 1
            reccount = reccount + 1

            For j = 0 To ubound(FieldNamestoDisplay)
				if isDBNull(DT.Rows(i)(j))=false then
					
					thisvalue = Trim(CStr(DT.Rows(i)(j)))

					If Trim(thisvalue) = "" Then
						thisvalue =  "&nbsp;"
					End If
				
					select case j
					case 0
						response.write ("<TD width=85><center><a href=javascript:SendValue(""" & Trim(CStr(session("Fld_SHP"))) & """,""" & thisvalue & """,""" & CustLayer & """);>" & thisvalue & "</a></center></TD>")
						FirstRec = "SendValue(""" & Trim(CStr(session("Fld_SHP"))) & """,""" & thisvalue & """,""" & CustLayer & """)"
					case else
						response.write ("<TD width=85>" & thisvalue & "</TD>")
					end select

	                Write(intFileNum, Trim(thisvalue))
				else
					response.write ("<td>&nbsp;</td>")

	                Write(intFileNum, "")
				end if
            Next
            response.write ("</TR>")
            WriteLine(intFileNum)
        next

        FileClose(intFileNum)

        response.write ("</TABLE><br><br><br>")
		response.write ("<script language='javascript'>function NPRecords(i) { document.Qry.action=""" & request.url.segments(ubound(request.url.segments)) & "?n="" + i; top.HaltLYRHide=1; top.MapFrame.positionLoadingLyr(); document.Qry.submit(); }</script>")

		response.write ("<form><center>")
		' First page
		if (nPage)>1 then
			response.write ("<input class=btnNAV type=button value=' << ' onclick=""javascript:NPRecords(1)"">&nbsp;")
		end if
		' Previous page
		if (nPage-1)>0 then
			response.write ("<input class=btnNAV type=button value=' < ' onclick=""javascript:NPRecords(" & (nPage - 1).ToString() & ")"">&nbsp;")
		end if

        response.write ("&nbsp;<input class=btnNAV type=button value='Start Over' onclick=""document.location='" & StartOverASP & "'"">&nbsp;")

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
    Else
        response.write ("No data found on the selected layers in the selected area.<br><br>")
        response.write ("&nbsp;<input type=button class=Btn onclick=""document.location='" & StartOverASP & "'"" Value=""Start Over"">&nbsp;")
    End If

    Err.Clear()

	if reccount=1 then
		response.write ("<script>" & FirstRec & "</script>")
	else
        response.write ("<br><hr><a href='..\CSV\" & strFileName & ".csv' target=_new>Right-Click Here</a> and select 'Save Target As' to download CSV file.<hr><br><br><br>")
	end if

	session("SearchResultsURL")=Request.url.tostring
	session("SearchResultsQ")=server.UrlEncode(strSQL)

%>

	<form name="Qry" method=post ID="Form1">
	<input type=hidden name="QueryString" value="<%=strSQL%>">
	</form>

</form>
</body>
