<%@ Page Language="vb" CodeBehind="printview.aspx.vb" AutoEventWireup="false" Inherits="dotNETViewer.printview" %>
<%@ Register tagPrefix="GPWC_Reports" Namespace="GeoPrise.Module.WebControl.Reporting.PDF" Assembly="GeoPrise.Module.WebControl.Reporting" %>
<%@ Import Namespace=System.IO %>
<%@ Import Namespace=GeoPrise.Framework.Common.Configuration %>
<%@ Import Namespace=aims %>
<%
 
'- Destroyable oject declarations
Dim geoprise_pdf As New GeoPrise.Module.WebControl.Reporting.PDF.WCConfig
Dim map_current as New Map

'- General variables declaration
Dim  m_set_orientation as integer = 0 
Dim  m_set_papersize as integer = 0
Dim  m_orientation as string = "" 
Dim  m_papersize as string = ""
Dim  m_map_scale as string = ""
Dim  m_map_title as string = ""
Dim _pdf_config_dir as string = ""
Dim _pdf_out_url as string = ""
Dim _pdf_out_dir as string = ""
Dim _pdf_out_file  as string = ""
Dim _img_config as string = ""
Dim _sql_query as string = ""

''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' Verify the referenced, current map object
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
'- Retrieve current map
map_current = Session("MapObj")

'- If current map object is invalid, our session timed out - Alert User
If IsNothing(Session("MapObj")) = True Then
	
	Response.Write("<script LANGUAGE=""JavaScript"">" & vbcrlf)
	Response.Write("window.open(""../includes/session_timeout.aspx"",null,""height=550,width=750,status=yes,resizable=yes,toolbar=no,menubar=no,location=no"");")
	Response.Write("window.close();" & vbcrlf)
	Response.Write("</script>" & vbcrlf)
Else

	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	' Initialize PDF settings
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	'- Assign form post variables 'Get print options (orientation and scale).
	m_orientation = request.Form("orientation")
	m_paperSize = request.Form("paperSize")
	m_map_scale = request.Form("scale")
	m_map_title = request.Form("titletext")


	'- Adjust paper size
	If lcase(m_orientation) = "portrait" then
		m_set_orientation= 0 
	Else
		m_set_orientation= 1 
	End If

	Select Case m_papersize
		Case ="8.5_11"
			m_set_papersize = 1
		'Case = "8.5_14"			'- Will possibly add later
		'	m_set_papersize = 1
		Case = "11_17"
			m_set_papersize = 2
		Case = "24_36"
			m_set_papersize = 3
		Case Else
			m_set_papersize = 1
	End Select

	'- Set up map title text
	If len(m_map_title) = 0 Then
		m_map_title = "Description: General Mapview"
	Else
		m_map_title = "Description: " & m_map_title
	End If



	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	' General PDF Settings
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	'- Set Image & Configuration Paths 
	_pdf_out_dir = "D:\ArcIMS\Output\"
	_pdf_config_dir = "D:\GeoPrise.Net\_configuration" 
	_pdf_out_url = "http://srv6/output/"

	'- Font Adjustments
	'geoprise_pdf.Report_Header_Font = "Eras Bold ITC"
	geoprise_pdf.Report_Header_Font = "Arial" '"Eras Bold ITC"
    	geoprise_pdf.Report_Header_Font_Color = "Black"
    	geoprise_pdf.Box_Module_Font = "Arial Black"
    	geoprise_pdf.Box_Module_Font_Color = "Navy" '"Black"
    	geoprise_pdf.Box_Module_Border_Color = "Navy" '"DarkGray" '59
    	geoprise_pdf.Box_Module_Color = "Whitesmoke" '"Silver" '123
  
	'- PDF output settings
	geoprise_pdf.Output_Directory = "D:\ArcIMS\Output"
	geoprise_pdf.Template_Path = "D:\\ArcIMS\\Website\\_globalsettings\\PDF_Configuration\\pdf-config.xml"
	geoprise_pdf.Template_Type = "_cv"
	geoprise_pdf.Client_Name = "City of Costa Mesa"

	'- PDF page settings
	geoprise_pdf.Page_Orientation = m_set_orientation
	geoprise_pdf.Page_Size = m_set_papersize

	'- PDF type
	geoprise_pdf.Report_Type = 0 '- PDF Map Output only

	'- PDF map settings
	geoprise_pdf.Map_Title = m_map_title
	geoprise_pdf.Map_Service_Main = "CostaPlan5"
	geoprise_pdf.Map_Service_OV = "Over1"
	geoprise_pdf.Map_Server_Name = "srv6"
	geoprise_pdf.Map_Scale	= m_map_scale
	'geoprise_pdf.Image_Config = _img_config

	'- PDF debug settings
	geoprise_pdf.Debug_On = 0
	geoprise_pdf.Debug_Log_Source = "VIEWER_CRIMES"

	'- Retrieve link to pdf
	_pdf_out_file = geoprise_pdf.EX_Report(map_current)

	'- Open new window to display document
	Response.Write("<script LANGUAGE=""JavaScript"">" & vbcrlf)
	Response.Write("window.open(""" & _pdf_out_url & Path.GetFileName(_pdf_out_file) & """,null,""height=550,width=750,status=yes,resizable=yes,toolbar=no,menubar=no,location=no"");")
	Response.Write("window.close();" & vbcrlf)
	Response.Write("</script>" & vbcrlf)
End If

'- Destroy objects
geoprise_pdf = Nothing
map_current = Nothing


%>

		