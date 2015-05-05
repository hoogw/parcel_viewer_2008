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
//function sendAPNValueX(Value1) {
//	var url="SS/parcel_details.aspx?APN=" + Value1; 
//	var frmcurrTool = opener.top.MapFrame.findObj("currTool")
//	frmcurrTool.value=22;
//	opener.top.MapFrame.positionLoadingLyr();
//	opener.top.MapFrame.SSRefreshMap(Value1,url);
//}
	function sendAPNValue(Value1) {
		opener.top.MapFrame.url="";
		if (opener.top.MapFrame.simpleGUI==1) {
			opener.top.MapFrame.GoSimpleGUIiFrameRight("SS/parcel_details.aspx?APN=" + Value1);
		}else{
			opener.top.fwinURL[3]="SS/parcel_details.aspx?APN=" + Value1;
			var obj=opener.top.MapFrame.findObj("iFrameSSLayer",opener.top.MapFrame.document); 
			opener.top.MapFrame.ChangeiFrameURL(obj,"Parcel Details","yes",2);
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
	dim WhereClause
	dim intFileNum 
	dim DateNow
	dim strFileName 
	
	MaxRecordsPerPage=2500

	if request("lyr")<> "" then
		session("lyr") = request("lyr")
	end if

	if request("idall")="true" then
		idAlliFrame=true
	else
		idAlliFrame=false
	end if

'Important''''''''''''''''''''''''''''''''
session("lyr")="1"
'session("Fld_DB")="Apnlink2"
session("Fld_DB") = "APN"
session("Fld_SHP")="AIpnlink2"
session("Fld_DBNAMES")="AddressPrp,situs_city_state_zip_zip_4_dwl,apnlink,legal_description,township_range_section,area,lot_acreage,owner_name__first_name_first_,mail_address,mail_city_state_zip_zip_4_dwl,year_built,bldg_living_area,no_residential_units,stories_no,parking_size,parking_type"
session("ds")="Server=srv6;Database=Costa2;User ID=CostaMesa;Password=CostaMesa;"
session("DBTbl")="fullfares"
''''''''''''''''''''''''''''''''''''''''''

    FieldNamestoDisplay=split(session("Fld_DBNAMES"),",")
    
    ColourScheme=Application("ColourScheme")
	StartOverASP= session("StartOverASP")
    
%>
<body leftmargin="5" onload="opener.top.HaltLYRHide=0; opener.top.MapFrame.hideLoadingLyr();">

		<SCRIPT LANGUAGE='JavaScript' TYPE='text/javascript'>

			////Usually used for Search ALL and ID ALL
			function SendValue(fld,p1,QL) {

				var objWC = opener.top.MapFrame.findObj("WhereClause")
				var objFN = opener.top.MapFrame.findObj("SAFieldName")
				var objMF = opener.top.MapFrame.findObj("MapFunction")
				var objQL = opener.top.MapFrame.findObj("QueryLayer")
				var objC = opener.top.MapFrame.findObj("CustomIDAllColour")
				var objZoomToFeature=opener.top.MapFrame.findObj('ZoomToFeature');

				if (objWC!=null) {
					<%if idAlliFrame=true then%>
					if (objZoomToFeature!=null) { objZoomToFeature.value='N'; }
					<%else%>
					if (objZoomToFeature!=null) { objZoomToFeature.value='Y'; }
					<%end if%>
					opener.top.MapFrame.positionLoadingLyr();
					objWC.value="&apos;" + p1 + "&apos;";
					objFN.value=fld;
					objMF.value=18;
					objC.value=255;
					objQL.value=QL;
					opener.top.MapFrame.RefreshMap();
				}
			}

			////Usually used for Search by Address, Owner, APN
			
			//If zooming to and displaying parcel details, use the function below AND rename the function above to SendValue2
			//function SendValue(fnd,APN,QL) {
			//	opener.top.MapFrame.positionLoadingLyr();
			//	opener.top.MapFrame.clearBufUrl();
			//	var url = "parcel_details.aspx?APN=" + APN
			//	opener.top.MapFrame.url = "";
			//	opener.top.MapFrame.SSRefreshMap(APN,url);
			//}

		</script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>

<%

	if request.querystring("GVar") <> "" then
		dim IDAllVars
		
		if trim(session("GVar")) <> "" then
			IDAllVars=split(left(trim(session("GVar")),len(trim(session("GVar")))-1),",")
			session("GVar")=""
		else
			IDAllVars=split(left(request.querystring("GVar"),len(request.querystring("GVar"))-1),",")
		end if
		WhereClause=""
		
		strSQL = "Select " & session("Fld_DBNAMES") & " from " & Trim(session("DBTbl")) & " where "
		
		for i = 0 to ubound(IDAllVars)
			if trim(left(IDAllVars(i),10)) <> "" then
				strSQL &= session("Fld_DB") & " LIKE '" & left(IDAllVars(i),10) & "%' OR "
				WhereClause &= session("Fld_DB") & " LIKE '" & left(IDAllVars(i),10) & "%' OR "
			end if
		next
		
		strSQL = left(strSQL,len(strSQL)-4)
		WhereClause = left(WhereClause,len(WhereClause)-4)
'response.write("whereclause = " & whereclause)
		
	end if

    Dim pConn As OleDbConnection
    Dim pAdapter As OleDbDataAdapter
	dim tmpDS
	
    If InStr(UCase(session("ds")), "PROVIDER") > 0 Then
        tmpDS = session("ds")
    Else
        tmpDS = "Provider=SQLOLEDB.1;" & session("ds")
    End If
'	response.write(strSQL & "<----")
'	response.write(tmpDS)
    pConn = New OleDbConnection(tmpDS)
    pConn.Open()

	if cint(err.number)<>0 or cstr(err.description) <> "" then
		response.write ("Error with DB Connection String: " & cint(err.number) & " - " & cstr(err.description) & "<br>")
		response.write ("<SCRIPT LANGUAGE='JavaScript' TYPE='text/javascript'>opener.top.HaltLYRHide=0; opener.top.MapFrame.hideLoadingLyr();</script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>")
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

    intFileNum = FreeFile()
    DateNow = Now()
    strFileName = "BufferML_" & Format(DateNow, "MM_dd_yyyy") & "_" & Format(DateNow, "hh_mm_ss_tt")

    FileOpen(intFileNum, HttpRuntime.AppDomainAppPath & "CSV\" & strFileName & ".csv", OpenMode.Output)

    If Err.Number = 0 Then
       'Get Field Names
        response.write ("<TABLE border='0' cellspacing='1' cellpadding='2' width=95% ><TR>")
'        response.write ("<TH class=tblHdr align=center>Highlight</TH>")
'		response.write ("<TH class=tblHdr>Parcel Details</TH>")
		response.write ("<TH class=tblHdr>Address 1</TH>")
		response.write ("<TH class=tblHdr>Address 2</TH>")
		response.write ("<TH class=tblHdr>Assessor Parcel Number</TH>")
		response.write ("<TH class=tblHdr>Legal Description</TH>")
		response.write ("<TH class=tblHdr>Township/Range/Section</TH>")
		response.write ("<TH class=tblHdr>Lot Area</TH>")
		response.write ("<TH class=tblHdr>Acres</TH>")
		response.write ("<TH class=tblHdr>Name</TH>")
		response.write ("<TH class=tblHdr>Address 1</TH>")
		response.write ("<TH class=tblHdr>Address 2</TH>")
		response.write ("<TH class=tblHdr>Year Built</TH>")
		response.write ("<TH class=tblHdr>Living Area</TH>")
		response.write ("<TH class=tblHdr>Number Residential Units</TH>")
		response.write ("<TH class=tblHdr>Total Rooms</TH>")
		response.write ("<TH class=tblHdr>Number of Stories</TH>")
		response.write ("<TH class=tblHdr>Parking Size</TH>")
		response.write ("<TH class=tblHdr>Parking Type</TH>")


		'CSV File
		Write(intFileNum, "AddressPrp")
		Write(intFileNum, "situs_city_state_zip_zip_4_dwl")
		Write(intFileNum, "apnlink2")
		Write(intFileNum, "legal_description,township_range_section")
		Write(intFileNum, "area")
		Write(intFileNum, "lot_acreage")
		Write(intFileNum, "owner_name__first_name_first_")
		Write(intFileNum, "mail_address")
		Write(intFileNum, "mail_city_state_zip_zip_4_dwl")
		Write(intFileNum, "year_built")
		Write(intFileNum, "bldg_living_area")
		Write(intFileNum, "no_residential_units,stories_no")
		Write(intFileNum, "parking_size")
		Write(intFileNum, "parking_type")


        WriteLine(intFileNum)   ' Print blank line to file.

        idx=ubound(FieldNamestoDisplay)
'	response.write("IDX = " & idx)
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
			'thisvalue = Trim(CStr(DT.Rows(i)(idx)))
			'response.write(">>>>>" & thisvalue & "<<<<<<")
			'if instr(thisvalue," ")>0 then
				'IDValue = "&apos;" & thisvalue & "&apos;"
			'response.write(">>>>>111 " & IDvalue & " <<<<<<")
			'else
				'IDValue = thisvalue
			'response.write(">>>>>222 " & IDvalue & " <<<<<<")
			'end if
			'response.write(">>" & thisvalue & "<<>>" & idvalue & "<<")
			'response.write ("<TD width=85><center><a href=javascript:SendValue(""" & Trim(CStr(session("Fld_SHP"))) & """,""" & idvalue & """,""" & CustLayer & """);>Rec " & n & "</a></center></TD>")

            For j = 0 To ubound(FieldNamestoDisplay)-1
				if isDBNull(DT.Rows(i)(j))=false then
					thisvalue = Trim(CStr(DT.Rows(i)(j)))

'					if (j=0) then
'						response.write ("<td align=center><a href=""javascript:sendAPNValue('" & left(thisvalue,10) & "');"")><nobr>Click Here</nobr></a></td>")
'					end if
					
                    Write(intFileNum, thisvalue)
					response.write ("<td>" & thisvalue & "</TD>")
				else
                    Write(intFileNum, "")
					response.write ("<td>&nbsp;</td>")
				end if
            Next

            response.write ("</TR>")

            WriteLine(intFileNum)   ' Print blank line to file.
		next

        response.write ("</TABLE><br><br>")
        FileClose(intFileNum)
		
		response.write ("CSV File successfully generated.<br><br><a href='..\CSV\" & strFileName & ".csv'>Right-Click Here</a> and select 'Save Target As' to download CSV file.")

		if idAlliFrame=false then
			response.write ("<SCRIPT LANGUAGE='JavaScript' TYPE='text/javascript'>function NPRecords(i) { document.Qry.action=""" & request.url.segments(ubound(request.url.segments)) & "?n="" + i; opener.top.HaltLYRHide=1; opener.top.MapFrame.positionLoadingLyr(); document.Qry.submit(); }</script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>")

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
	<script language='JavaScript' type='text/javascript'>function MLGo(T1) { var ch; ch=-1; for (i=0; i<=2; i++) { if (document.ML.Type[i].checked) {ch=i;} } if (ch!=-1) {opener.top.MapFrame.newwindow('','height=500,width=550,menubar=yes,resizable=yes,tollbar=no,scrollbars=yes','ML'); document.ML.T.value=T1; document.ML.target='ML'; document.ML.ch.value=ch; document.ML.submit();} else {alert('Please select the mailing labels type before continuing.');} }</script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>
	
	<FORM name=ML action='parcelbufferML.aspx' method=POST >
	<input type=hidden name=T value="">
	<input type=hidden name=ch value="">
	<input type=hidden name=WC value="<%=WhereClause%>">
	<HR width=100%>
	<TABLE width=95% cellpadding=0 cellspacing=0 border=0><TR valign=top><TD><b>Mailing Labels</b><br><br><input type=radio name=Type value=1 >Resident Address<br> <input type=radio name=Type value=2 >Owner Address<br><input type=radio name=Type value=3>Both<br><br><input type=button class=Btn onclick='MLGo(1);' Value='Continue'>&nbsp;&nbsp;&nbsp;<input type=button class=Btn onclick='MLGo(2);' Value='CSV Download'><br><br><br></TD><TD>MAILING LABEL INSTRUCTIONS<BR><BR>1) Select the type of mailing labels you want.<br><i>Then:</i><br>2) Click on the Continue button. A pop-up window will appear with your mailing labels.<br><i>OR</i><br>3) Click on the CSV Download button. A pop-up window will appear with a link to your CSV file.</TD>
	</FORM>
	<script language='JavaScript' type='text/javascript'>opener.top.MapFrame.url='';</script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>


</form>
</body>
