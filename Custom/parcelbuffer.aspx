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
<script language='JavaScript' type='text/javascript'>
var undef, prefix
if (top.opener!=undef){prefix=top.opener.top.MapFrame;}else{if (opener==undef) {prefix=top.MapFrame;}else{prefix=opener.top.MapFrame;}}
</script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>

<SCRIPT LANGUAGE='JavaScript' TYPE='text/javascript'>
//function sendAPNValueX(Value1) {
//	var url="SS/parcel_details.aspx?APN=" + Value1; 
//	var frmcurrTool = prefix.findObj("currTool")
//	frmcurrTool.value=22;
//	prefix.positionLoadingLyr();
//	prefix.SSRefreshMap(Value1,url);
//}
	function sendAPNValue(Value1) {
		prefix.url="";
		if (prefix.simpleGUI==1) {
			prefix.GoSimpleGUIiFrameRight("SS/parcel_details.aspx?APN=" + Value1);
		}else{
			top.fwinURL[3]="SS/parcel_details.aspx?APN=" + Value1;
			var obj=prefix.findObj("iFrameSSLayer",prefix.document); 
			prefix.ChangeiFrameURL(obj,"Parcel Details","yes",2);
		}
	}

	function NewBuff() {
		//Instead of buffering around a pre-existing highlighted area, user clicks on a button to start a brand new buffer.
		//This function sets the stage to do this for them.
		top.bufX1=0;
		top.bufY1=0;
		top.bufLyr=0;
	
		prefix.BuffStuff('');
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
	session("lyr")="2"
	session("Fld_DB")="APN"
	session("Fld_SHP")="AIN"
	session("Fld_DBNAMES")="APN, Street_Nbr +' ' + Street_nam as Mail_ST, (CITY + ' ' + 'CA  ' + CAST(zip as varchar(10))) as Mail_ST2,"
	session("ds")=Application("dbSource")
	session("DBTbl")="Parcels"
	''''''''''''''''''''''''''''''''''''''''''
  

FieldNamestoDisplay=split(session("Fld_DBNAMES"),",")
    
    ColourScheme=Application("ColourScheme")
	StartOverASP= session("StartOverASP")
    
%>
<body leftmargin="5" onload="top.HaltLYRHide=0; prefix.hideLoadingLyr();">

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

	if request.querystring("GVar") <> "" then
		dim IDAllVars
		
		if trim(session("GVar")) <> "" then
			IDAllVars=split(left(trim(session("GVar")),len(trim(session("GVar")))-1),",")
			session("GVar")=""
		else
			IDAllVars=split(left(request.querystring("GVar"),len(request.querystring("GVar"))-1),",")
		end if
		WhereClause=""
		
		strSQL = "Select " & session("Fld_DBNAMES") & session("Fld_DB") & " from " & Trim(session("DBTbl")) & " where "
		
		for i = 0 to ubound(IDAllVars)
			if trim(left(IDAllVars(i),10)) <> "" then
				strSQL &= session("Fld_DB") & " LIKE '" & left(IDAllVars(i),10) & "%' OR "
				WhereClause &= session("Fld_DB") & " LIKE '" & left(IDAllVars(i),10) & "%' OR "
			end if
		next
		
		strSQL = left(strSQL,len(strSQL)-4)
		WhereClause = left(WhereClause,len(WhereClause)-4)
		
	end if

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
response.write ("<!--- tmpDS: " & tmpDS & " --->")
response.write ("<!--- SQL: " & strSQL & " --->")

	If nRecCount = 0 Then
		' Clean up
		' Do the no results HTML here
		Response.Write("<font color=red>No Records found based on your input.</font><br><br>&nbsp;&nbsp;&nbsp;")
		
		for i = 0 to request.form.count
			if trim(Request.Form("SAfld" & i)) <> "" then
				response.write ("<b>" & Request.Form("SAfld" & i) & "&nbsp;</b>")
			end if
		next
		response.write ("<br><br>")

'        response.write ("&nbsp;<a href=""javascript:document.location='" & StartOverASP & "'""><img src='../images/" & ColourScheme & "b_startover.gif' border=0></a>&nbsp;")
'response.write ("<input type=button class=BTN onclick='NewBuff();' value='Start Over'>")
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

'- Set configuration file directory
	GeoPrise.Utilities.Common.Configuration.ConfigurationSettings.AlternateDirectory ="\\10.0.0.2\ArcIMS\Website\_GlobalSettings\PDF_Configuration" 
    Dim OutputDir as String =GeoPrise.Utilities.Common.Configuration.ConfigurationSettings.AppSettings("GeoPrise_CSV.Output.Directory")

    FileOpen(intFileNum, OutputDir & "\" & strFileName & ".csv", OpenMode.Output)

    If Err.Number = 0 Then
       'Get Field Names

        response.write ("<TABLE border='0' cellspacing='1' cellpadding='2' width=95% ><TR>")

        response.write ("<TH class=tblHdr align=center>Highlight</TH>")
		response.write ("<TH class=tblHdr>Parcel Details</TH>")
		response.write ("<TH class=tblHdr>APN</TH>")
		response.write ("<TH class=tblHdr>Situs Addr 1</TH>")
		response.write ("<TH class=tblHdr>Situs Addr 2</TH>")


       
		'CSV File
		Write(intFileNum, "APN")
		Write(intFileNum, "Situs Addr 1")
		Write(intFileNum, "Situs Addr 2")
		Write(intFileNum, "Sub Division")


        WriteLine(intFileNum)   ' Print blank line to file.

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

			response.write ("<TD width=85><center><a href=javascript:SendValue(""" & Trim(CStr(session("Fld_SHP"))) & """,""" & replace(IDValue,"-","")  & """,""" & CustLayer & """);>Rec " & n & "</a></center></TD>")

            For j = 0 To ubound(FieldNamestoDisplay)-1
				if isDBNull(DT.Rows(i)(j))=false then
					thisvalue = Trim(CStr(DT.Rows(i)(j)))

					if (j=0) then
						response.write ("<td align=center><a href=""javascript:sendAPNValue('" & replace(thisvalue,"-","") & "');"")><nobr>Click Here</nobr></a></td>")
					end if
					
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
		
		response.write ("&nbsp;&nbsp;CSV File successfully generated.<br><br>&nbsp;&nbsp;<a href='http://service.export.mygeoprise.net/Output/" & strFileName & ".csv'>Right-Click Here</a> and select 'Save Target As' to download CSV file.")

		if idAlliFrame=false then
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
        response.write ("&nbsp;<a href=""javascript:document.location='" & StartOverASP & "'""><img src='../images/" & ColourScheme & "b_startover.gif' border=0></a>&nbsp;")
    End If

    Err.Clear()

	if reccount=1 then
		response.write ("<SCRIPT LANGUAGE='JavaScript' TYPE='text/javascript'>" & FirstRec & "</script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>")
	end if

%>
		<form name="Qry" method=post ID="Form1">
		<input type=hidden name="QueryString" value="<%=strSQL%>" ID="Hidden1">
		</form>
	<script language='JavaScript' type='text/javascript'>function MLGo(T1) { var ch; ch=-1; for (i=0; i<=2; i++) { if (document.ML.Type[i].checked) {ch=i;} } if (ch!=-1) {document.ML.action="parcelbufferML_PDF.aspx";prefix.newwindow('','height=150,width=300,menubar=yes,resizable=yes,tollbar=no,scrollbars=yes','ML'); document.ML.T.value=T1; document.ML.target='ML'; document.ML.ch.value=ch; document.ML.submit();} else {alert('Please select the mailing labels type before continuing.');} }</script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>
	<script language='JavaScript' type='text/javascript'>function MLGoPDF(T1) { var ch; ch=-1; for (i=0; i<=2; i++) { if (document.ML.Type[i].checked) {ch=i;} } if (ch==2){ alert("This option is not available for PDF generation.\n\nPlease select either [Resident Address] or [Owner Address]"); return false;} if (ch!=-1) {document.ML.action="parcelbufferML_PDF.aspx";prefix.newwindow('','height=550,width=750,menubar=yes,resizable=yes,tollbar=no,scrollbars=yes','ML'); document.ML.T.value=T1; document.ML.target='ML'; document.ML.ch.value=ch; document.ML.submit();} else {alert('Please select the mailing labels type before continuing.');} }</script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>
	

	<FORM name=ML action='parcelbufferML_PDF.aspx' method=POST ID="Form2">
	<input type=hidden name=T value="" ID="Hidden2">
	<input type=hidden name=ch value="" ID="Hidden3">
	<input type=hidden name=WC value="<%=WhereClause%>" ID="Hidden4">
	<HR width=100%>
	<TABLE width=95% cellpadding=0 cellspacing=0 border=0 ID="Table1"><TR valign=top><TD><b>&nbsp;&nbsp;Mailing Labels</b><br><br>&nbsp;&nbsp;<input type=radio name=Type value=1 ID="Radio1" >Resident Address<br> &nbsp;&nbsp;<input type=radio name=Type value=2 ID="Radio2" disabled>Owner Address<br>&nbsp;&nbsp;<input type=radio name=Type value=3 ID="Radio3" disabled>Both<br><br>&nbsp;&nbsp;&nbsp;&nbsp;<input type=button class=Btn onclick='MLGoPDF(1);' Value='Download PDF' ID="Button1" NAME="Button1">&nbsp;&nbsp;&nbsp;<input type=button class=Btn onclick='location.href="http://service.export.mygeoprise.net/Output/<%= strFileName %>.csv";' Value='Download CSV' ID="Button2" NAME="Button2">&nbsp;&nbsp;&nbsp;<!---<input type=button class=BTN onclick="NewBuff();" value="Start Over" ID="Button3" NAME="Button3">---><br><br><br></TD><TD><b>Mailing Label Instructions:</b><BR><BR>1) Select a label type.<br><i></i><br>2) Click on either '<b>Download PDF</b>.' or '<b>Download CSV</b>'</TD>
	</FORM>
	
			<noscript><b>Javascript MUST be enabled on your browser</b></noscript>
	<script language='JavaScript' type='text/javascript'>prefix.url='';</script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>


</form>
</body>
