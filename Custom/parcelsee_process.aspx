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

<SCRIPT LANGUAGE='JavaScript' TYPE='text/javascript'>
	function PDetails(Value1) {
		if (top.MapFrame.simpleGUI==1) {
			top.MapFrame.GoSimpleGUIiFrameRight("SS/parcel_details.aspx?APN=" + Value1);
		}else{
			top.fwinURL="SS/parcel_details.aspx?APN=" + Value1;
			var obj=top.MapFrame.findObj("iFrameSSLayer",top.MapFrame.document); 
			top.MapFrame.ChangeiFrameURL(obj,"Parcel Details","yes",2);
		}
	}
</script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>

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
session("lyr")="id_EarlyEntryParcels"
session("Fld_DB")="CNTYAP_NBR"
session("Fld_SHP")="APN"
session("Fld_DBNAMES")="CNTYAP_NBR,STREET_NBR,STREET_NAM,SUBDIVISION,LOT,"
session("ds")="Provider=SQLOLEDB.1;Initial Catalog=GIS;Server=PWASQL;User Id=gisuser;Password=gisuser;pooling=false;connection timeout=120;"
session("DBTbl")="PARCELSEE"
''''''''''''''''''''''''''''''''''''''''''

    FieldNamestoDisplay=split(session("Fld_DBNAMES"),",")
    
    ColourScheme=Application("ColourScheme")
	StartOverASP= session("StartOverASP")
    
%>
<body leftmargin="5" onload="top.HaltLYRHide=0; top.MapFrame.hideLoadingLyr();">

		<SCRIPT LANGUAGE='JavaScript' TYPE='text/javascript'>

			////Usually used for Search ALL and ID ALL
			function SendValue(fld,p1,QL) {

				var objWC = top.MapFrame.findObj("WhereClause")
				var objFN = top.MapFrame.findObj("SAFieldName")
				var objMF = top.MapFrame.findObj("MapFunction")
				var objQL = top.MapFrame.findObj("QueryLayer")
				var objC = top.MapFrame.findObj("CustomIDAllColour")
				var objZoomToFeature=top.MapFrame.findObj('ZoomToFeature');

				if (objWC!=null) {
					<%if idAlliFrame=true then%>
					if (objZoomToFeature!=null) { objZoomToFeature.value='N'; }
					<%else%>
					if (objZoomToFeature!=null) { objZoomToFeature.value='Y'; }
					<%end if%>
					top.MapFrame.positionLoadingLyr();
					objWC.value="&apos;" + p1 + "&apos;";
					objFN.value=fld;
					objMF.value=18;
					objC.value=255;
					objQL.value=QL;
					top.MapFrame.RefreshMap();
				}
			}

			////Usually used for Search by Address, Owner, APN
			
			//If zooming to and displaying parcel details, use the function below AND rename the function above to SendValue2
			//function SendValue(fnd,APN,QL) {
			//	top.MapFrame.positionLoadingLyr();
			//	
			//	var url = "parcel_details.aspx?APN=" + APN
			//	top.MapFrame.url = "";
			//	top.MapFrame.SSRefreshMap(APN,url);
			//}

		</script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>

<%

	if request.querystring("GVar") <> "" then
		dim IDAllVars
		
		IDAllVars=replace( left(request.querystring("GVar"),len(request.querystring("GVar"))-1),", ", ",")
		
		strSQL = "Select " & session("Fld_DBNAMES") & session("Fld_DB") & " from " & Trim(session("DBTbl")) & " where " & session("Fld_DB") & " in ("
		
		strSQL &= "'" & replace(IDAllVars,",","','") & "')"
	else
		If Trim(Request.Form("QueryString")) = "" Then

			strSQL = "Select " & session("Fld_DBNAMES") & session("Fld_DB") & " from " & Trim(session("DBTbl")) & " where "

			WhereClauseValid = False
			For i = 0 To CInt(Request.Form("FieldCount"))
				If Trim(CStr(Request.Form("SAfld" & i))) <> "" Then
					WhereClauseValid = True
					Select Case Request.Form("SAfld" & i & "Type")
						Case "String"
							If UCase(Trim(CStr(Request.Form("SAfld" & i & "Opr")))) = "LIKE" Then
								strSQL &=  " (" & Trim(CStr(Request.Form("SAfld" & i & "Name"))) & " " & Trim(CStr(Request.Form("SAfld" & i & "Opr"))) & " '" & replace(Trim(CStr(Request.Form("SAfld" & i))),"'","''") + "%'  "
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
		Else
			strSQL = Trim(Request.Form("QueryString"))
		End If
	end if

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
		response.write ("<SCRIPT LANGUAGE='JavaScript' TYPE='text/javascript'>top.HaltLYRHide=0; top.MapFrame.hideLoadingLyr();</script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>")
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

        response.write ("&nbsp;<a href=""javascript:document.location='" & StartOverASP & "'""><img src='../images/" & ColourScheme & "b_startover.gif' border=0></a>&nbsp;")
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

        response.write ("<TABLE border='0' cellspacing='1' cellpadding='2' width=95% ><TR>")

        response.write ("<TH class=tblHdr align=center>Highlight</TH>")

		response.write ("<TH class=tblHdr>Parcel Details</TH>")
		response.write ("<TH class=tblHdr>APN</TH>")
		response.write ("<TH class=tblHdr>Street Number</TH>")
		response.write ("<TH class=tblHdr>Street Name</TH>")
		response.write ("<TH class=tblHdr>Sub Division</TH>")
		response.write ("<TH class=tblHdr>Lot</TH>")
       
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

			response.write ("<TD width=85><center><a href=javascript:SendValue(""" & Trim(CStr(session("Fld_SHP"))) & """,""" & IDValue & """,""" & CustLayer & """);>Rec " & n & "</a></center></TD>")

            For j = 0 To ubound(FieldNamestoDisplay)-1
				if isDBNull(DT.Rows(i)(j))=false then
					thisvalue = Trim(CStr(DT.Rows(i)(j)))

					if (j=0) then
						response.write ("<td><a href=""javascript:PDetails('" & thisvalue & "');"")>Click Here</a></td>")
					end if
					If Trim(thisvalue) = "" Then
						response.write ("<td>&nbsp;</td>")
					Else
						response.write ("<td>" & thisvalue & "</TD>")
					End If
				else
					response.write ("<td>&nbsp;</td>")
				end if
            Next
            response.write ("</TR>")
		next

        response.write ("</TABLE><br><br><br>")
		
		if idAlliFrame=false then
			response.write ("<SCRIPT LANGUAGE='JavaScript' TYPE='text/javascript'>function NPRecords(i) { document.Qry.action=""" & request.url.segments(ubound(request.url.segments)) & "?n="" + i; top.HaltLYRHide=1; top.MapFrame.positionLoadingLyr(); document.Qry.submit(); }</script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>")

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
		end if
	Else
        response.write ("No data found.<br><br>")
        response.write ("&nbsp;<a href=""javascript:document.location='" & StartOverASP & "'""><img src='../images/" & ColourScheme & "b_startover.gif' border=0></a>&nbsp;")
    End If

    Err.Clear()

	if reccount=1 then
		response.write ("<SCRIPT LANGUAGE='JavaScript' TYPE='text/javascript'>" & FirstRec & "</script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>")
	end if

%>
		<form name="Qry" method=post ID="Form1">
		<input type=hidden name="QueryString" value="<%=strSQL%>">
		</form>

</form>
</body>
