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
    Dim thisvalue
    Dim n 
    Dim WhereClauseValid 
    Dim IDValue 
    Dim CustLayer 
    Dim ColourScheme
    Dim StartOverASP
    Dim FieldNamestoDisplay
    dim FindInArray
	dim DS,DT,nRecCount,nPageCount,nPage
	dim nStart, nEnd
	dim FirstRec as string
	dim idAlliFrame
	Dim MaxRecordsPerPage
	dim intFileNum 
	dim DateNow
	dim strFileName 

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
session("lyr")="id_parcels"
session("Fld_DB")="APNBR"
session("Fld_SHP")="APN"
session("ds")="Provider=SQLOLEDB.1; Initial Catalog=ParcelAttributeDB;Server=sql2;User Id=gis;Password=gis;pooling=false;connection timeout=120;"
session("DBTbl")="MAD"
''''''''''''''''''''''''''''''''''''''''''

    ColourScheme=Application("ColourScheme")
	StartOverASP= session("StartOverASP")
    
%>

<script language='JavaScript' type='text/javascript'>
var undef, prefix, prefixTop
if (top.opener!=undef){prefix=top.opener.top.MapFrame; }else{if (opener==undef) {prefix=top.MapFrame;}else{prefix=opener.top.MapFrame;}}
prefixTop=top;
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

			function GoPermit(APN) {
				var url='http://gis/website/citrusHeights/Custom/custom_permits_process.aspx?APN=' + APN + '&lyr=id_permits';
				top.MapFrame.newwindow(url,'height=500,width=550,menubar=yes,resizable=yes,tollbar=yes,scrollbars=yes','Permits')
			}
		</script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>

<%

	if request.querystring("APN") <> "" then
		strSQL = "Select * from VWParcelInfo where APNBR in ("
		
		strSQL &= "'" & request.querystring("APN") & "')"
	else
		response.write ("NO apn sent...")
		response.end

	end if

	response.write (vbcrlf & "<!--- SQL: " & strSQL & " --->" & vbcrlf & vbcrlf)

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
		Response.Write("<font color=red>No Records found.</font><br><br>&nbsp;&nbsp;&nbsp;")
		Response.End 
		' Done
	End If


    If Err.Number = 0 Then
       'Get Field Names

	intFileNum = FreeFile()
	DateNow = Now()
	strFileName = "CH_PD_" & Format(DateNow, "MM_dd_yyyy") & "_" & Format(DateNow, "hh_mm_ss_tt")

	FileOpen(intFileNum, HttpRuntime.AppDomainAppPath & "CSV\" & strFileName & ".csv", OpenMode.Output)


	dim DISPAPN

	DISPAPN = mid(request("APN"),1,3) & "-" & mid(request("APN"),4,4) & "-" & mid(request("APN"),8,3) & "-" & mid(request("APN"),11)
	response.write ("<font class=sshdr2>Parcel Details for APN " & DISPAPN & "</font><br><br>")
        response.write ("<TABLE border='0' cellspacing='1' cellpadding='2' width=95% ><TR>")
	'response.write ("<TR class=tblRow1><td><b>Permit Info</b></td><td><a href=""javascript:GoPermit('" & DT.Rows(0)(1) & "');"">Click Here</a></TD></TR>")

		CustLayer = Trim(CStr(session("Lyr")))

	for j = 0 to DT.columns.count-1
		Write(intFileNum, DT.Columns(j).ColumnName)
	next
        WriteLine(intFileNum)   ' Print blank line to file.

	for i = 0 to DT.rows.count-1
            For j = 0 To DT.columns.count-1
	            If (j / 2 = j \ 2) Then
	                response.write ("<TR class=tblRow1>")
	            Else
        	        response.write ("<TR class=tblRow2>")
	            End If
				response.write ("<td><b>" & DT.Columns(j).ColumnName & "</b></td>")

				if isDBNull(DT.Rows(i)(j))=false then
					thisvalue = Trim(CStr(DT.Rows(i)(j)))

					if j=0 and  DT.Columns(j).ColumnName="APN" then
						thisvalue=DISPAPN
					end if

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
	            response.write ("</TR>")
            Next
		response.write ("<tr><td colspan=2><hr width=100% color=black></td></tr>")
        WriteLine(intFileNum)   ' Print blank line to file.
	next

        response.write ("</TABLE><br>")
		
	Else
        response.write ("No data found.<br><br>")
        response.write ("&nbsp;<center><input type=button class=Btn onclick=""document.location='" & StartOverASP & "'"" Value=""Start Over""></center>&nbsp;")
    End If

      FileClose(intFileNum)
    Err.Clear()

%>
		<form name="Qry" method=post ID="Form1">
		<input type=hidden name="QueryString" value="<%=strSQL%>">
		</form>

<center>
<br><input type=button onclick='window.print();' value="Print">
<br><br><a href='..\CSV\<%=strFileName%>.csv'>Right-Click Here</a> and select 'Save Target As' to download CSV file.
</center>
</form>
</body>
