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
    Dim idx
    Dim ColourScheme
    Dim StartOverASP
    dim FindInArray
	dim DS,DT,nRecCount,nPageCount,nPage
	dim nStart, nEnd
	Dim FirstRec as string
	dim idAlliFrame
	Dim MaxRecordsPerPage

	MaxRecordsPerPage=100

	if request("idall")="true" then
		idAlliFrame=true
	else
		idAlliFrame=false
	end if

'Important''''''''''''''''''''''''''''''''
	
	session("Fld_DB")="APNLink2"
	session("Fld_SHP")="APNLink2"
	session("Fld_DBNAMES")="APNLink2,Owner_Name__First_Name_First_,Addressprp"
	session("ds")=Application("dbSource") '"Provider=SQLOLEDB.1;Initial Catalog=CostaMesa;Data Source=srv6;User Id=CostaMesa;Password=CostaMesa;"
	session("DBTbl")="FullFares"
	''''''''''''''''''''''''''''''''''''''''''

	if session("ds") = "" then
		response.write ("Invalid data source")
		response.end
	end if

	

    ColourScheme=Application("ColourScheme")
	StartOverASP= session("StartOverASP")
    
%>
<body leftmargin="5" onload="top.HaltLYRHide=0; prefix.hideLoadingLyr();">
<script language='JavaScript' type='text/javascript'>
var undef, prefix
if (top.opener!=undef){prefix=top.opener.top.MapFrame;}else{if (opener==undef) {prefix=top.MapFrame;}else{prefix=opener.top.MapFrame;}}
</script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>

		<SCRIPT LANGUAGE='JavaScript' TYPE='text/javascript'>

			////Usually used for Search by Address, Owner, APN
			
			//If zooming to and displaying parcel details, use the function below AND rename the function above to SendValue2
			function SendValue(fnd,APN,QL) {
				prefix.positionLoadingLyr();
				
				var url = "SS/parcel_details.aspx?APN=" + APN + "&s=OWNER"
				prefix.url = "";
				prefix.SSRefreshMap(APN,url);
			}

		</script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>

<%

    strSQL = "Select " & session("Fld_DBNAMES") & " from " & Trim(session("DBTbl")) & " where "

    If Trim(Request.Form("QueryString")) = "" Then
        WhereClauseValid = False
        
        if request.form("SAfld2") <> "" then
        'address range
        
        dim n1,n2,st
        
        n1=request.form("SAfld0")
        n2=request.form("SAfld1")
        st=request.form("SAfld2")
        
		strSQL &=  " (" & Trim(CStr(Request.Form("SAfld2Name"))) & " " & Trim(CStr(Request.Form("SAfld2Opr"))) & " '" & replace(Trim(CStr(st)),"'","''") + "%'  "
		strSQL &=  " OR " & Trim(CStr(Request.Form("SAfld2Name"))) & " " & Trim(CStr(Request.Form("SAfld2Opr"))) & " '" & replace(Trim(CStr(st)),"'","") + "%') AND "

		strSQL &=  " " & Trim(CStr(Request.Form("SAfld0Name"))) & " >= " & Trim(CStr(n1)) + " AND "
		strSQL &=  " " & Trim(CStr(Request.Form("SAfld1Name"))) & " <= " & Trim(CStr(n2)) + " "

        else
			For i = 0 To CInt(Request.Form("FieldCount"))
				If Trim(CStr(Request.Form("SAfld" & i))) <> "" Then
					WhereClauseValid = True
					Select Case Request.Form("SAfld" & i & "Type")
						Case "String"
							If UCase(Trim(CStr(Request.Form("SAfld" & i & "Opr")))) = "LIKE" Then
								strSQL &=  " (" & Trim(CStr(Request.Form("SAfld" & i & "Name"))) & " " & Trim(CStr(Request.Form("SAfld" & i & "Opr"))) & " '" & "%" & replace(Trim(CStr(Request.Form("SAfld" & i))),"'","''") + "%'  "
								strSQL &=  " OR " & Trim(CStr(Request.Form("SAfld" & i & "Name"))) & " " & Trim(CStr(Request.Form("SAfld" & i & "Opr"))) & " '" & "%" & replace(Trim(CStr(Request.Form("SAfld" & i))),"'","") + "%') AND "
							Else
								strSQL &=  " " & Trim(CStr(Request.Form("SAfld" & i & "Name"))) & " " & Trim(CStr(Request.Form("SAfld" & i & "Opr"))) & " '" & "%" & Trim(CStr(Request.Form("SAfld" & i))) + "' AND "
							End If
						Case Else
							strSQL &=  " " & Trim(CStr(Request.Form("SAfld" & i & "Name"))) & " " & Trim(CStr(Request.Form("SAfld" & i & "Opr"))) & " " & "%" &  Trim(CStr(Request.Form("SAfld" & i))) + " AND "
					End Select
				End If
			Next

			strSQL = Left(strSQL, Len(strSQL) - 5) 'remove the last "AND"
		end if

		strSQL &= " ORDER BY Owner_Name__First_Name_First_"
    Else
        strSQL = Trim(Request.Form("QueryString"))
    End If

	response.write ("<!--- SQL: " & strSQL & " --->")

'	response.write (strSQL)
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
		response.write ("<SCRIPT LANGUAGE='JavaScript' TYPE='text/javascript'>top.HaltLYRHide=0; prefix.hideLoadingLyr();</script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>")
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
%>
		<table width=100% cellpadding=0 cellspacing=0 border=0 ID="Table3"><tr class=tblHdr>
			<td align=center><b>Owner Search Results</b></font></td></tr></table>
			<br><bR>
<%
		Response.Write("<font color=red>&nbsp;&nbsp;&nbsp;No Records found based on your input:</font><br><br>&nbsp;&nbsp;&nbsp;")
		
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
		'We have records!
		response.write ("<font class=ssmsg2>Below are the results of your query. If your search has a single match, you will automatically be forwarded to the Parcel data page.<br><BR>Click on the Parcel ID hyperlink to view parcel attibute data.<BR><br></font>")

        response.write ("<TABLE border='0' cellspacing='1' cellpadding='2' width=95% ><TR>")

		response.write ("<TH class=tblHdr>Parcel ID</TH>")
		response.write ("<TH class=tblHdr>Owner</TH>")
		response.write ("<TH class=tblHdr>Address</TH>")
		
        response.write ("</TR>")

        reccount = 0
        n = CInt(Request("n"))

		For i = nStart To nEnd
            If (reccount / 2 = reccount \ 2) Then
                response.write ("<TR class=tblRow1>")
            Else
                response.write ("<TR class=tblRow2>")
            End If

            n = n + 1
            reccount = reccount + 1

            For j = 0 to DT.Columns.count-1
				if isDBNull(DT.Rows(i)(j))=false then
					
					thisvalue = Trim(CStr(DT.Rows(i)(j)))

					If Trim(thisvalue) = "" Then
						thisvalue =  "&nbsp;"
					End If
				
					select case j
					case 0
						response.write ("<TD width=85><center><a href=javascript:SendValue(""" & Trim(CStr(session("Fld_SHP"))) & """,""" & thisvalue & """);>" & thisvalue & "</a></center></TD>")
						FirstRec = "SendValue(""" & Trim(CStr(session("Fld_SHP"))) & """,""" & thisvalue & """)"
					case else
						response.write ("<TD width=85>" & thisvalue & "</TD>")
					end select
				else
					response.write ("<td>&nbsp;</td>")
				end if
            Next
            response.write ("</TR>")
        next

        response.write ("</TABLE><br><br><br>")
		response.write ("<SCRIPT LANGUAGE='JavaScript' TYPE='text/javascript'>function NPRecords(i) { document.Qry.action=""" & request.url.segments(ubound(request.url.segments)) & "?n="" + i; top.HaltLYRHide=1; prefix.positionLoadingLyr(); document.Qry.submit(); }</script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>")

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
        response.write ("&nbsp;<center><input type=button class=Btn onclick=""document.location='" & StartOverASP & "'"" Value=""Start Over""></center>&nbsp;")
    End If

    Err.Clear()

	if reccount=1 then
		response.write ("<SCRIPT LANGUAGE='JavaScript' TYPE='text/javascript'>" & FirstRec & "</script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>")
	end if

%>

		<form name="Qry" method=post ID="Form1">
		<input type=hidden name="QueryString" value="<%=strSQL%>" ID="Hidden1">
		</form>
		
	

</form>
</body>
