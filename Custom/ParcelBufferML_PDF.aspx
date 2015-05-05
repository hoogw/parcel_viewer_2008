<%@ Page aspcompat=true %>
<%@ Import Namespace=System.Data.SqlClient %>
<%@ Import Namespace=System.Data %>
<%@ Import Namespace=System.Data.OleDB %>
<%@ Import Namespace=GeoPrise.Utilities.PDF.Enumerators %>
<%@ Import Namespace=GeoPrise.Utilities.PDF %>
<%@ Import Namespace=GeoPrise.Utilities.Common.Configuration %>
<%@ Import Namespace=System.IO %>
 

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
		
	'- PDF Generation variables
	Dim SQLRdr As SqlDataReader
	Dim SQLConn As New SqlConnection 
	Dim PDF_FileName as string
	Dim Avery5160_Template as New Templates
	
    AddressLabelType = CInt(Request.form("ch"))

	'- Build SQL
	If AddressLabelType = 0 then
		strSQL = "Select ('APN: ' + COALESCE(CNTYAP_NBR, '')) as CNTYAP_NBR,COALESCE(situs_add1,'') as situs_add1,COALESCE(situs_add2,'') as situs_add2,mail1,mail2,('Resident') as name from v_Parcels_ML where " & trim(request.form("WC"))
	ElseIf AddressLabelType=1 Then
		strSQL = "Select ('APN: ' + COALESCE(CNTYAP_NBR, '')) as CNTYAP_NBR,COALESCE(situs_add1,'') as situs_add1,COALESCE(situs_add2,'') as situs_add2,mail1,mail2, COALESCE(name,'') as name from v_Parcels_ML where " & trim(request.form("WC"))
	End IF
'Response.Write(strSQL)
	'response.end
	'- Build Connection
     'If InStr(UCase(session("ds")), "PROVIDER") > 0 Then
    '    tmpDS = session("ds")
    'Else
   '     tmpDS = "Provider=SQLOLEDB.1;" & session("ds")
    'End If
    
    '- Replace OLEDB for SQLDataReader
	'tmpDS = tmpDS.ToUpper()
	'tmpDS = tmpDS.Replace("PROVIDER=SQLOLEDB.1;","")

	'If tmpDS.length < 1 Then
	'	Response.Write("<script LANGUAGE=""JavaScript"">" & vbcrlf)
	'	Response.Write("alert(""Please refresh the results page and try again"");" & vbcrlf)
	'	Response.Write("window.close();" & vbcrlf)
	'	'Response.Write("window.opener.location.reload();" & vbcrlf)
	'	Response.Write("</script>" & vbcrlf)
	'	Response.end
	'End If	
	
	'- Initiate connection
	SQLConn = New SQLConnection("Password=g30pr!s3;Persist Security Info=True;User ID=geoprise;Initial Catalog=elkgrove;Data Source=localhost")
	SQLConn.open()

	Dim SQLCom As New SqlCommand(strSQL, SQLConn)
		
	
	SQLRdr = SQLCom.ExecuteReader() 
	
	

	'- Set configuration file directory
	GeoPrise.Utilities.Common.Configuration.ConfigurationSettings.AlternateDirectory ="\\10.0.0.2\ArcIMS\Website\_GlobalSettings\PDF_Configuration" 
	PDF_FileName = Avery5160_Template.Draw_Avery5160Labels(SQLRdr,"Name^CNTYAP_NBR^situs_add1^situs_add2", GeoPrise.Utilities.PDF.Enumerators.GeoPrise_Special.PDFPageFormat.Letter)

	PDF_FileName = Path.GetFileName(PDF_FileName)
	
	'- Dispose of objects
	Avery5160_Template = nothing
	SQLConn = nothing
	SQLCom = nothing
	SQLRdr = nothing
	
	'- Open new window to display document
	Response.Write("<script LANGUAGE=""JavaScript"">" & vbcrlf)
	Response.Write("window.open(""http://service.pdf.mygeoprise.net/Output/" & PDF_FileName & """,null,""height=550,width=750,status=no,resizable=yes,toolbar=no,menubar=no,location=no"");")
    Response.Write("window.close();" & vbcrlf)
	Response.Write("</script>" & vbcrlf)
	
	Response.end
%>


