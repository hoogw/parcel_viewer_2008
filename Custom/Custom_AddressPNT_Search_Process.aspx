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

    On Error Resume Next

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
    Dim ObjectID

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
	session("lyr")="12"
	session("Fld_DB")="OBJECTID"
	session("Fld_SHP")="OBJECTID"
	session("Fld_DBNAMES")="OBJECTID,ADD_NUMBER,FULL_NAME,LOCALITY,POSTAL"
	session("ds")="Provider=SQLOLEDB.1;Initial Catalog=VECTOR;Data Source=GISSQLREG;User Id=SDE;Password=sde;"
	session("DBTbl")="v_streetsfull"
	''''''''''''''''''''''''''''''''''''''''''

	if session("ds") = "" then
		response.write ("Invalid data source")
		response.end
	end if

	if session("ds") = "" then
		response.write ("Invalid data source")
		response.end
	end if

    FieldNamestoDisplay=split(session("Fld_DBNAMES"),",")
    
    ColourScheme=Application("ColourScheme")
	StartOverASP= session("StartOverASP")
    'response.Write(request.form("SAfld0") & " - " & request.form("SAfld1") & " - " & request.form("SAfld2") & " - " & Request.Form("QueryString"))
%>
<body leftmargin="5" onload="top.HaltLYRHide=0; top.MapFrame.hideLoadingLyr();">

<script language='JavaScript' type='text/javascript'>
var undef, prefix, prefixTop
if (top.opener!=undef){prefix=top.opener.top.MapFrame; }else{if (opener==undef) {prefix=top.MapFrame;}else{prefix=opener.top.MapFrame;}}
prefixTop=top.opener.top;

			////Usually used for Search by Address, Owner, APN
			
			//If zooming to and displaying parcel details, use the function below AND rename the function above to SendValue2
			function SendValue2(fnd,Ob,QL) {
				//alert("FND = " + fnd);
				//alert("QL = " + QL);
				//top.MapFrame.positionLoadingLyr();
				//var url = "./custom/Custom_AddressPNT_details.aspx?ObjectID=" + Ob;

				//alert(url);
				//top.MapFrame.url = "";
				//top.MapFrame.SSRefreshMap(Ob,url);
			}

			function SendValue(fld,p1,QL) {

				//alert("FlD = " + fld);
				//alert("p1 = " + p1);
				//alert("QL = " + QL);

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
					//alert ("test = "+p1);
top.MapFrame.GoSimpleGUIiFrameRight('./custom/Custom_AddressPNT_details.aspx?thenum='+p1);
				//alert ("test 2");
				//	var url = "./custom/Custom_AddressPNT_details.aspx?ObjectID=" + p1;
				top.MapFrame.url = "";
				//alert ("test 3");
				prefix.RefreshMap();
				//alert ("test 4");
				}
			}
		</script>
<table width=100% cellpadding=0 cellspacing=0 border=0 ID="Table3"><tr  class=tblHdr>
			<td align=center><b>Address Search Results</b></font></td></tr></table><br><br>
	<center><input type=button class=Btn onclick='window.print();' Value="Print List">&nbsp;&nbsp;<input type=button class=Btn onclick='top.MapFrame.SaveMap()' Value="Print Map">
<!---
	<br><input type=button class=Btn onclick="top.MapFrame.GoSimpleGUIiFrameRight('custom/searchmain.aspx');" Value='New Search'><br><br></center>
--->
	</center>
<%

    strSQL = "Select " & session("Fld_DBNAMES") & " from " & Trim(session("DBTbl")) & " where "
	 
    If Trim(Request.Form("QueryString")) = "" Then
        WhereClauseValid = False
        
        if request.form("SAfld3") <> "" then
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
								strSQL &=  " (" & Trim(CStr(Request.Form("SAfld" & i & "Name"))) & " " & Trim(CStr(Request.Form("SAfld" & i & "Opr"))) & " '0" & replace(Trim(CStr(Request.Form("SAfld" & i))),"'","''") + "%'  "
								strSQL &=  " OR " & Trim(CStr(Request.Form("SAfld" & i & "Name"))) & " " & Trim(CStr(Request.Form("SAfld" & i & "Opr"))) & " '" & replace(Trim(CStr(Request.Form("SAfld" & i))),"'","") + "%') AND "
							Else
								strSQL &=  " " & Trim(CStr(Request.Form("SAfld" & i & "Name"))) & " " & Trim(CStr(Request.Form("SAfld" & i & "Opr"))) & " '" & Trim(CStr(Request.Form("SAfld" & i))) + "' AND "
							End If
						Case Else
							strSQL &=  " " & Trim(CStr(Request.Form("SAfld" & i & "Name"))) & " " & Trim(CStr(Request.Form("SAfld" & i & "Opr"))) & " " & Trim(CStr(Request.Form("SAfld" & i))) + " AND "
					End Select
				End If
			Next

			strSQL = Left(strSQL, Len(strSQL) - 5) 'remove the last "AND"
		end if

		strSQL &= " ORDER BY ADD_NUMBER"
    Else
        strSQL = Trim(Request.Form("QueryString"))
    End If

'	response.write (strSQL)
	response.write ("<!--- SQL: " & strSQL & " --->")

    Dim pConn As OleDbConnection
    Dim pAdapter As OleDbDataAdapter
	dim tmpDS
	
    If InStr(UCase(session("ds")), "PROVIDER") > 0 Then
        tmpDS = session("ds")
    Else
        tmpDS = "Provider=SQLOLEDB.1;" & session("ds")
    End If

'response.write(tmpDS)
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
        Write(intFileNum, "ADD_NUMBER")
        Write(intFileNum, "FULL_NAME")
        Write(intFileNum, "LOCALITY")
        Write(intFileNum, "POSTAL")
        WriteLine(intFileNum)

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
        response.write ("<TABLE border='0' cellspacing='1' cellpadding='2' width=95% ><TR>")

		response.write ("<TH class=tblHdr>Number</TH>")
		response.write ("<TH class=tblHdr>Street</TH>")
		response.write ("<TH class=tblHdr>City</TH>")
		response.write ("<TH class=tblHdr>Zip</TH>")
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
	    ObjectID = "Null"
            For j = 0 To ubound(FieldNamestoDisplay)
				if isDBNull(DT.Rows(i)(j))=false then
					
					thisvalue = Trim(CStr(DT.Rows(i)(j)))

					If Trim(thisvalue) = "" Then
						thisvalue =  "&nbsp;"
					End If
				
					select case j
					case 0
						ObjectID = thisvalue
					case 2
						response.write ("<TD width=85><center><a href=javascript:SendValue(""" & Trim(CStr(session("Fld_SHP"))) & """,""" & ObjectID & """,""" & CustLayer & """);>" & thisvalue & "</a></center></TD>")
						FirstRec = "SendValue(""" & Trim(CStr(session("Fld_SHP"))) & """,""" & objectid & """,""" & CustLayer & """)"
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
