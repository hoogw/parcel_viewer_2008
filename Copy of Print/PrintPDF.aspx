<%@ Page Language="vb" CodeBehind="printview.aspx.vb" AutoEventWireup="false" Inherits="dotNETViewer.printview" %>
<%@ Import Namespace=System.IO %>
<%@ Import Namespace=GeoPrise.Utilities.PDF.Enumerators %>
<%@ Import Namespace=GeoPrise.Utilities.PDF %>
<%@ Import Namespace=GeoPrise.Utilities.Common.Configuration %>
<%
'************************************************************************************************************************************
'	ASPX PAGE
'
'	This ASPX page serves as the presentation layer while the VB page serves as the code page.  In some cases, I utilize a public 
'	variable named INFORMATION to dynamically generate HTML which is then displayed on the presentation layer (ASPX page).  Simply 
'   including the value of this public variable will effectively include that dynamically generated HTML code at run-time. The 
'   purpose of this page is to display formatted information to the user.  This ASPX page is dynamically generated with 
'   each page request.  Take note that not all portions of the HTML code will be displayed with each page request due to various
'   conditions.  Please see the special notes section for more explanation (if applicable).
'
'	SPECIAL NOTES regarding this ASPX page:
'	
'	Inclusion of the header.aspx file (located in the includes filder) allows the user of a common 'header' for all ASPX files.
'	By including this file, a common CSS can be shared and 'included' throughout all ASPX pages.
'	
'	The purpose of this page is to provide the HTML interface to 
'
'************************************************************************************************************************************
%>
<%

		'On Error Resume Next
		
		Dim orientation, scale, mMap, mOvMap,scalev, paperSize
		Dim PDFMapImage, PDFMapImageOV, PDFMapImageLegend, PDFHeader, PDFMapSource
		
		'Get print options (orientation and scale).
		orientation = request.Form("orientation")
		paperSize = request.Form("paperSize")


			'- Overview and Legend must either both be on or off

		If Not((request.form("ShowLegend")<> ""  And request.form("ShowOVMap")<> "") Or (request.form("ShowLegend")= ""  And request.form("ShowOVMap")= "")) Then

			'- Open new window to display document
			Response.Write("<script LANGUAGE=""JavaScript"">" & vbcrlf)
			Response.Write("alert('[BOTH] the Map Oveview and Map Legend must be on or [BOTH] the Map Oveview and Map Legend must be [OFF] to render a map in PDF format.');")
			Response.Write("window.close();" & vbcrlf)
			Response.Write("</script>" & vbcrlf)
			Response.end
		ElseIF   (request.form("ShowOVMap")<> "") Then
			If len(OvMapImage) < 1 Then
			'- Open new window to display document
			Response.Write("<script LANGUAGE=""JavaScript"">" & vbcrlf)
			Response.Write("alert('Your session has timed out; please refresh your browser.');")
			Response.Write("window.close();" & vbcrlf)
			Response.Write("</script>" & vbcrlf)
			Response.end
			End If
		End If
	
		'Response.Write( orientation & "<BR>")
		'Response.Write( scale & "<BR>")
		'Response.Write( paperSize & "<BR>")
		'Response.end
		
		'If our print map object is invalid, our session timed out - so alert the user!
        If IsNothing(Session("OVMapObj")) = True Then
            Response.Redirect("../includes/session_timeout.aspx", True)
        End If
		
		'Get the map and overview map session objects.
		mMap = session("MapObj")
		mOvMap = session("OVMapObj")
		

		If (paperSize ="8.5_11" And Lcase(orientation) = "portrait") Then
			PDFMapImage = ""
			PDFMapImageOV = ""
			PDFMapImageLegend = ""
			
			PDFMapImage = MapImage
			PDFHeader = "\\10.0.0.2\ArcIMS\Website\GP_ElkGrove\economicdev\Images\ElkGroveTitle.jpg"
			PDFMapImage = "\\10.0.0.2\ArcIMS\Output\" & Path.GetFileName(PDFMapImage)
			
			If (OvMapImage <> "") Then
				
				If (request.form("ShowOVMap") <>"") then
					OvMapImage = "\\10.0.0.2\ArcIMS\Output\" & Path.GetFileName(OvMapImage)
				Else
					OvMapImage = ""
				End If
			End If
			
			If (LegendURL <> "") Then
				If (request.form("ShowLegend") <>"") then
					LegendURL = "\\10.0.0.2\ArcIMS\Output\" & Path.GetFileName(LegendURL)
				Else
					LegendURL = ""
				End If
			End If
			


			GeoPrise.Utilities.Common.Configuration.ConfigurationSettings.AlternateDirectory ="\\10.0.0.2\ArcIMS\Website\_GlobalSettings\PDF_Configuration" 
			'REsponse.Write(PDFHeader & " - " & PDFMapImage & " - " & OvMapImage & " - " & LegendURL )
'Response.end
			PDFMapSource = Templates.Draw_MapImage(PDFHeader,PDFMapImage,OvMapImage,LegendURL)
			PDFMapSource = Path.GetFileName(PDFMapSource)

			'Response.Write ("PDF: " & PDFMapSource)
'Response.end
			'- Open new window to display document
			Response.Write("<script LANGUAGE=""JavaScript"">" & vbcrlf)
		Response.Write("window.open(""http://service.pdf.mygeoprise.net/Output/" & PDFMapSource & """,null,""height=550,width=750,status=yes,resizable=yes,toolbar=no,menubar=no,location=no"");")
			Response.Write("window.close();" & vbcrlf)
			Response.Write("</script>" & vbcrlf)
			
'Response.end
		Else
			'- Open new window to display document
			Response.Write("<script LANGUAGE=""JavaScript"">" & vbcrlf)
			Response.Write("alert('You may only user the default paper size [8.5 X 11 Letter]\n and [Portrait] option with PDF generation.');")
			Response.Write("window.close();" & vbcrlf)
			Response.Write("</script>" & vbcrlf)
			Response.end
		End If
		
			
		%>
		