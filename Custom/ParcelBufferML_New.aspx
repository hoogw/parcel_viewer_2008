<%@ Page aspcompat=true %>
<%@ Import Namespace=System.Data.SqlClient %>
<%@ Import Namespace=System.Data %>
<%@ Import Namespace=System.Data.OleDB %>
<%@ Import Namespace=GeoPrise.Utilities.PDF.Enumerators %>
<%@ Import Namespace=GeoPrise.Utilities.PDF %>

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

<body leftmargin="5">

<%
    'On Error Resume Next

	response.expires = -7 

    Dim strSQL
    Dim intFieldCount 
    Dim i as integer
    Dim reccount 
    Dim thisvalue
    Dim AddressLabelType
	Dim DS,DT
	Dim intFileNum 
    Dim pConn As OleDbConnection
    Dim pAdapter As OleDbDataAdapter
	Dim tmpDS
	Dim DateNow 
	Dim strFileName 
	Dim columncount
	Dim strName
	
	
    AddressLabelType = CInt(Request.form("ch"))

	strSQL = "Select ('APN' + CNTYAP_NBR) as CNTYAP_NBR,situs_add1,situs_add2,mail1,mail2,name from PARCELSEE where " & trim(request.form("WC"))

    If InStr(UCase(session("ds")), "PROVIDER") > 0 Then
        tmpDS = session("ds")
    Else
        tmpDS = "Provider=SQLOLEDB.1;" & session("ds")
    End If
    
    'Response.Write(strSQL)

'' START HERE
 
			Dim SQLrdr As SqlDataReader
			Dim SQLConn As New SqlConnection 
			Dim XMLFileSource as string
			Dim PDF_FileName as string
			Dim Temp as New Templates
			SQLConn.ConnectionString ="Password=gisuser;Persist Security Info=True;User ID=gisuser;Initial Catalog=GIS;Data Source=PWASQLSTAGE"
			SQLConn.open()
			Dim SQLCom As New SqlCommand(strSQL, SQLConn)
			SQLConn = New SQLConnection("Password=gisuser;Persist Security Info=True;User ID=gisuser;Initial Catalog=GIS;Data Source=PWASQLSTAGE")
		 
			'Response.Write (SQLConn.ConnectionString)
		 
			GeoPrise.Utilities.Common.Configuration.ConfigurationSettings.AlternateDirectory ="E:\ArcIMS\Website\NEWDWQViewer\bin" 
			SQLRdr = SQLCom.ExecuteReader() 
			SQLConn.Close()
	
			PDF_FileName = Temp.Draw_Avery5160Labels(SQLRdr,"Name^CNTYAP_NBR^situs_add1^situs_add2", GeoPrise_Special.PDFPageFormat.Letter)
			Response.Write (PDF_FileName)
		
			Temp = nothing
			SQLRdr = nothing
			Response.end
	'
	'int i =0;
	'		for (i=0; i < 1; i++) {
	'			DateTime sysDate = DateTime.Today;
	'			System.Guid GUID = System.Guid.NewGuid();
	'			string XMLFilename = txtXMLFile.Text;
	'			string TimeStampID = TimeFunctions.ConvertDateTimeToFullTimestamp(sysDate);
	'			TimeStampID = TimeStampID + "_" + GUID.ToString();
'
	'		 	//string PDFResult =  ConstructPDF.GeneratePDF(XMLFilename,txtOutputDir.Text);
	'			string PDFResult =  ConstructPDF.GeneratePDF(XMLFilename);
	'		}
	'		MessageBox.Show(this, "DONE", "Result: ", MessageBoxButtons.OK, MessageBoxIcon.Information);
	
	'' END HERE
	

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

	If DT.Rows.Count = 0 Then
		' Clean up
		' Do the no results HTML here
		Response.Write("<font color=red>No Records found based on your input</font><br>")
		Response.End 
	End If

    intFileNum = FreeFile()
    DateNow = Now()
    strFileName = "BufferML_" & Format(DateNow, "MM_dd_yyyy") & "_" & Format(DateNow, "hh_mm_ss_tt")


    '- Set configuration file directory
    GeoPrise.Utilities.Common.Configuration.ConfigurationSettings.AlternateDirectory ="\\10.0.0.2\ArcIMS\Website\_GlobalSettings\PDF_Configuration" 
    Dim OutputDir as String =GeoPrise.Utilities.Common.Configuration.ConfigurationSettings.AppSettings("GeoPrise_CSV.Output.Directory")


    FileOpen(intFileNum, OutputDir & "\" & strFileName & ".csv", OpenMode.Output)

	dim sit1,sit2,mail1,mail2,apn, name,j
	Dim Information
	
    Information = ("<TABLE border='0' width='100%'><TR valign=top>")
    columncount = 4

	'Resident
	if AddressLabelType = 0 or AddressLabelType=2 then
		for i = 0 to DT.Rows.Count
			apn  = Trim(CStr(DT.Rows(i)(0)))
			sit1 = Trim(CStr(DT.Rows(i)(1)))
			sit2 = Trim(CStr(DT.Rows(i)(2)))
			name = Trim(CStr(DT.Rows(i)(5)))

			If columncount Mod 3 = 1 Then
				Information &= "<TD align='left' width='37%' height='92'>"
			ElseIf columncount Mod 3 = 2 Then
				Information &= "<TD width='3'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD><TD align='left' width='32%' height='92'>"
			ElseIf columncount Mod 3 = 0 Then
				Information &= "<TD width='3'>&nbsp;&nbsp;&nbsp;&nbsp;</TD><TD align='left' width='31%' height='92'>"
			End If

			Information &= "<FONT color=black size='-2'><br>Resident</font>"
			Information &= "<FONT color=black size='-2'><br>APN: " & apn & "</font>"
			Information &= "<FONT color=black size='-2'><br>" & sit1 & "</font>"
			Information &= "<FONT color=black size='-2'><br>" & sit2 & "</font>"
			recCount = recCount + 1

			Write(intFileNum, "Resident")
			Write(intFileNum, "APN: " & apn)
			Write(intFileNum, sit1)
			Write(intFileNum, sit2)
			
			If columncount Mod 3 = 0 And i < recCount Then
				Information &= "</TR><TR valign=top>"
			ElseIf columncount Mod 3 = 0 And i < recCount Then
				Information &= "</TR>"
			ElseIf i >= recCount Then
				For j = 2 To (columncount Mod 3) Step -1
					Information &= "<TD>&nbsp;</TD>"
				Next
			End If
			columncount += 1

			WriteLine(intFileNum)   ' Print blank line to file.
		next
		
		Information &= "</TABLE>"
    end if
    
    Information &= ("<TABLE border='0' width='100%'><TR valign=top>")
    columncount = 4
    'Owner
    if AddressLabelType = 1 or AddressLabelType=2 then
		for i = 0 to DT.Rows.Count
			apn  = Trim(CStr(DT.Rows(i)(0)))
			sit1 = Trim(CStr(DT.Rows(i)(1)))
			sit2 = Trim(CStr(DT.Rows(i)(2)))
			mail1= Trim(CStr(DT.Rows(i)(3)))
			mail2= Trim(CStr(DT.Rows(i)(4)))
			name = Trim(CStr(DT.Rows(i)(5)))

			'No Duplicate labels
			if AddressLabelType=2 and (cstr(trim(sit1))=cstr(trim(mail1)) ) then
				goto here
			end if
			
			If columncount Mod 3 = 1 Then
				Information &= "<TD align='left' width='37%' height='92'>"
			ElseIf columncount Mod 3 = 2 Then
				Information &= "<TD width='3'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD><TD align='left' width='32%' height='92'>"
			ElseIf columncount Mod 3 = 0 Then
				Information &= "<TD width='3'>&nbsp;&nbsp;&nbsp;&nbsp;</TD><TD align='left' width='31%' height='92'>"
			End If

			Information &= "<FONT color=black size='-2'><br>" & name & "</font>"
			Information &= "<FONT color=black size='-2'><br>APN: " & apn & "</font>"
			Information &= "<FONT color=black size='-2'><br>" & mail1 & "</font>"
			Information &= "<FONT color=black size='-2'><br>" & mail2 & "</font>"
			recCount = recCount + 1

			Write(intFileNum, name)
			Write(intFileNum, "APN: " & apn)
			Write(intFileNum, mail1)
			Write(intFileNum, mail2)

			If columncount Mod 3 = 0 And i < recCount Then
				Information &= "</TR><TR valign=top>"
			ElseIf columncount Mod 3 = 0 And i < recCount Then
				Information &= "</TR>"
			ElseIf i >= recCount Then
				For j = 2 To (columncount Mod 3) Step -1
					Information &= "<TD>&nbsp;</TD>"
				Next
			End If
			columncount += 1

			WriteLine(intFileNum)   ' Print blank line to file.
here:
		next
		
		Information &= "</TABLE><br><br>"
    end if
    
    if request.form("t")=1 then
		response.write (Information)
	end if
    FileClose(intFileNum)
	
	response.write ("CSV File successfully generated.<br><br><a href='http://service.export.mygeoprise.net/Output/" & strFileName & ".csv'>Right-Click Here</a> and select 'Save Target As' to download CSV file.")

    Err.Clear()

%>

</form>
</body>
