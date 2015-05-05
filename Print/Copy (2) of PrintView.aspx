<%@ Page Language="vb" CodeBehind="printview.aspx.vb" AutoEventWireup="false" Inherits="dotNETViewer.printview" %>
<%@ Register tagPrefix="GPWC_Reports" Namespace="GeoPrise.Module.WebControl.Reporting.PDF" Assembly="GeoPrise.Module.WebControl.Reporting" %>
<%@ Import Namespace=System.IO %>
<%@ Import Namespace=GeoPrise.Framework.Common.Configuration %>
<%@ Import Namespace=aims %>
<%

        Dim appUtilityFunctions As New dotnetviewer.clsUtilityFunctions  'Local object variable which allows us to utilize the functions and procedures in the clsUtilityFunctions class.
        Dim appPrintUtilityFunctions As New dotnetviewer.clsPrintFunctions
        Dim appHighlightFunctions As New dotnetviewer.clsHighlight       'Local object variable which allows us to utilize the functions and procedures in the clsHighlight class.
        Dim appMapFunctions As New dotnetviewer.clsMapFunctions          'Local object variable which allows us to utilize the functions and procedures in the clsMapFunctions class.
        Dim pv_geo As New dotnetviewer.pv_geo
        Dim i As Integer
        Dim j As Integer
        Dim mMap                                            'Pointer to the main application Map object As Map
        Dim ovmap
        Dim iLayerID
        Dim scale as double = 0
        Dim centerx, centery
        Dim mAcetateLayer, mEnvelope, mPoints, mPolygon, mPoint, mLegend, Renderer
        Dim hlitelayerid
        Dim geoprise_pdf As New GeoPrise.Module.WebControl.Reporting.PDF.WCConfig
        Dim m_orientation As String
        Dim m_papersize As String
        Dim m_map_scale As String
        Dim _scale 
		Dim _center_x
        Dim _center_y
        Dim m_map_title As String
       
        Dim _arrimggrp As Array
        Dim _arrimgprops As Array
        Dim _arrimgspecs As Array
		Dim _map_image_url as string
		Dim _ov_image_url as string
		Dim _legend_image_url as string
 
    

        Dim _image_key As String
        Dim _image_path As String
        Dim main_image_width As String
        Dim main_image_height As String
        Dim main_image_align As String
        Dim main_image_inset As String
        Dim main_image_path As String
        Dim main_image_x As String
        Dim main_image_y As String
        Dim legend_image_width As String
        Dim legend_image_height As String
        Dim legend_image_align As String
        Dim legend_image_inset As String
        Dim legend_image_path As String
        Dim legend_image_x As String
        Dim legend_image_y As String
        Dim ov_image_width As String
        Dim ov_image_height As String
        Dim ov_image_align As String
        Dim ov_image_inset As String
        Dim ov_image_path As String
        Dim ov_image_x As String
        Dim ov_image_y As String
        Dim _image_align As String
        Dim _image_inset As String
        Dim _image_x As String
        Dim _image_y As String
        Dim _set_orientation As Integer
        Dim _set_papersize As Integer
        Dim _papersize As string
        Dim _orientation_desc As String
        Dim _page_size_desc As String
        Dim _created as string

		On Error Resume Next
		
        If IsNothing(Session("OvMapObj")) = True Then
            Response.Redirect("../includes/session_timeout.aspx", True)
        End If

        '- Retrieve instance of map session object
        mMap = Session("MapObj")

        '- Retrieve form post variables
        m_orientation = Request.Form("orientation")
        m_papersize = Request.Form("paperSize")
        m_map_scale = Request.Form("scale")
        m_map_title = Request.Form("titletext")

        '- Adjust paper size
        If LCase(m_orientation) = "portrait" Then
            _set_orientation = 0
            _orientation_desc = "Portrait"
        Else
            _set_orientation = 1
            _orientation_desc = "Landscape"
        End If

        '- Derive special papersize
        Select Case m_papersize
            Case Is = cstr("8.5_11")
                _set_papersize = 1
                _page_size_desc = "8.5 x 11"
                'Case = "8.5_14"			'- Will possibly add later
                '	m_set_papersize = 1
            Case Is = "11_17"
                _set_papersize = 2
                _page_size_desc = "11 x 17"
            Case Is = "24_36"
                _set_papersize = 3
                _page_size_desc = "24 x 36"
            Case Else
                _set_papersize = 1
        End Select

        '- Return print attributes
        _arrimggrp = CStr(geoprise_pdf.EX_CalcPageSize(_set_orientation, _set_papersize)).Split("|")
        For i = 0 To (_arrimggrp.Length - 1)

            _arrimgprops = CStr(_arrimggrp(i)).Split("^")
            _image_key = _arrimgprops(0)        '- Image Unique ID

            '- Parse out and Width and Height
            _arrimgspecs = CStr(_arrimgprops(2)).Split("$")

            Select Case UCase(_image_key)
                Case "OVERVIEW MAP" '- Overview map"
                    ov_image_align = _arrimgprops(3)                '- Image Alignment
                    ov_image_inset = _arrimgprops(4)                '- Image Inset
                    ov_image_path = _arrimgprops(1)                 '- Image Physical Path
                    ov_image_width = CInt(_arrimgspecs(0))          '- Image Width
                    ov_image_height = CInt(_arrimgspecs(1))         '- Image Height

                    '- Parse out and X and Y
                    _arrimgspecs = CStr(_arrimgprops(5)).Split("$")
                    ov_image_x = CInt(_arrimgspecs(0))              '- Image Width
                    ov_image_y = CInt(_arrimgspecs(1))              '- Image Height

                Case "LEGEND"  '- Legend image
                    legend_image_align = _arrimgprops(3)            '- Image Alignment
                    legend_image_inset = _arrimgprops(4)            '- Image Inset
                    legend_image_path = _arrimgprops(1)             '- Image Physical Path
                    legend_image_width = CInt(_arrimgspecs(0))      '- Image Width
                    legend_image_height = CInt(_arrimgspecs(1))     '- Image Height

                    '- Parse out and X and Y
                    _arrimgspecs = CStr(_arrimgprops(5)).Split("$")
                    legend_image_x = CInt(_arrimgspecs(0))          '- Image Width
                    legend_image_y = CInt(_arrimgspecs(1))          '- Image Height

                Case "MAP DISPLAY" '- Main Map
                    main_image_align = _arrimgprops(3)              '- Image Alignment
                    main_image_inset = _arrimgprops(4)              '- Image Inset
                    main_image_path = _arrimgprops(1)               '- Image Physical Path
                    main_image_width = CInt(_arrimgspecs(0))        '- Image Width
                    main_image_height = CInt(_arrimgspecs(1))       '- Image Height

                    '- Parse out and X and Y
                    _arrimgspecs = CStr(_arrimgprops(5)).Split("$")
                    main_image_x = CInt(_arrimgspecs(0))            '- Image Width
                    main_image_y = CInt(_arrimgspecs(1))            '- Image Height
            End Select

        Next

        '- Set map height attributes
        mMap.height = main_image_height
        mMap.width = main_image_width

        '- Retrieve scale and set map extent
		If len(m_map_scale) = 0 Then
            '- Retrieve the current scale at the maps current extent
            _scale = Format((mMap.Extent.XMax - mMap.Extent.XMin) * 96 / mMap.Width, "#.##")

            With mMap.Extent
                _center_x = .xmin + ((.xmax - .xmin) / 2)
                _center_y = .ymin + ((.ymax - .ymin) / 2)
                .XMin = _center_x - ((mMap.Width / 96) * _scale) / 2
                .XMax = _center_x + ((mMap.Width / 96) * _scale) / 2
                .YMin = _center_y - ((mMap.Height / 96) * _scale) / 2
                .YMax = _center_y + ((mMap.Height / 96) * _scale) / 2
            End With
        Else
            _scale = CDbl(m_map_scale) '- Get from custom values (Request.Form("Scale"))

            With mMap.Extent
                _center_x = .xmin + ((.xmax - .xmin) / 2)
                _center_y = .ymin + ((.ymax - .ymin) / 2)
                .XMin = _center_x - ((mMap.Width / 96) * _scale) / 2
                .XMax = _center_x + ((mMap.Width / 96) * _scale) / 2
                .YMin = _center_y - ((mMap.Height / 96) * _scale) / 2
                .YMax = _center_y + ((mMap.Height / 96) * _scale) / 2
            End With
        End If

       
        '- Set overview map attributes
        ovmap = Session("OvMapObj")
        _ov_image_url = "Print"
        appMapFunctions.CreateOverViewMap(mMap, ovmap, _ov_image_url, "", 1)

        '- Set map legend attributes
        mLegend = mMap.Legend
        mLegend.Height = legend_image_height
        mLegend.Width = legend_image_width
        
        If _set_orientation = 1 And _set_papersize <> 1 Then
            mLegend.Autoextent = False
            mLegend.CanSplit = True
            'out_map_legend.Columns = out_map_legend.Width / 85
            mLegend.Columns = 1
            mLegend.Cellspacing = 2
            mLegend.SwatchHeight = 9
            mLegend.SwatchWidth = 9
        Else
            mLegend.Autoextent = False
            mLegend.CanSplit = True
            mLegend.Columns = mLegend.Width / 85
            mLegend.Cellspacing = 2
            mLegend.SwatchHeight = 9
            mLegend.SwatchWidth = 9

        End If


        Renderer = Nothing
        j = Nothing

        'If we have a highlight layer & are trying to print it, we need to make the fill colour black and solid transparency
        'This code does not execute unless we have a group renderer
        hlitelayerid = appUtilityFunctions.GetLayerIndex_ByName("HighlightLayer", mMap.Layers)
        If hlitelayerid <> -1 Then
            For i = 1 To mMap.Layers.Item(hlitelayerid).Count
                mMap.Layers.Item(hlitelayerid).Item(i).Symbol.FillColor = 0
                mMap.Layers.Item(hlitelayerid).Item(i).Symbol.FillStyle = 1
                mMap.Layers.Item(hlitelayerid).Item(i).Symbol.Transparency = 1
            Next
        End If

        'Create the scale bar and north arrow for the map
        appMapFunctions.CreateScaleBar(mMap.Layers, mMap.Width, Application("MapUnits"))
        appMapFunctions.CreateNorthArrow(mMap.Layers, 15, 30, 15, 7)
        appMapFunctions.CreateCopyright(mMap.Layers)

        mMap.Legend.Display = True
        appMapFunctions.RefreshMap(mMap, Nothing)

        '- Remove the scale bar and north arrow from the map - we only create it just before we refresh the map.
        appMapFunctions.ClearAcetateLayer("ScaleBar", mMap.Layers)
        appMapFunctions.ClearAcetateLayer("NorthArrow", mMap.Layers)

        '- Return image paths
        _map_image_url = mMap.GetImageAsUrl()
        _legend_image_url = mLegend.Url
		_created = Now()
		
        '- General HTML
        Response.Write(vbCrLf)
        Response.Write("<!DOCTYPE HTML PUBLIC ""-//W3C//DTD HTML 4.0 Transitional//EN"">")
        Response.Write(vbCrLf)
        Response.Write("<html>")
        Response.Write(vbCrLf)
        Response.Write("<head><title>Map Display: " & m_map_title & " - " & _created & "</title></head>")
        Response.Write(vbCrLf)
        Response.Write("<BODY topmargin=""2"" leftmargin=""2"" marginheight=""2"" marginwidth=""2"">")

        '- Build map title
        Response.Write(vbCrLf)
        Response.Write("<div id=""prt_map_attributes"" style=""background-color:#FFFFFF;font-family:arial;font-size:11px;font-weight:normal;color:#000000;z-index:2;position:absolute;margin:" & main_image_inset & ";left:15;height:60;width:" & main_image_width & ";"" >")
        Response.Write("<b>TITLE</b>: " & m_map_title)
        Response.Write("<br>")
        Response.Write("<b>ATTRIBUTES</b>: Created:" & Now() & ",&nbsp;&nbsp;Scale: " & _scale & "/&nbsp;&nbsp;Page Size: " & _page_size_desc & "/&nbsp;&nbsp;Orientation:" & _orientation_desc)
        Response.Write("<br>")
        Response.Write("</div>")
        Response.Write(vbCrLf)

        '- Main map div
        Response.Write("<div id=""prt_map_image_bdr"" style=""background-color:" & Application("AppColour_Base") & " ;font-family:arial;font-size:12px;font-weight:bold;overflow:hidden;z-index:2;position:absolute;margin:" & main_image_inset & ";top:" & (main_image_y - 20) & ";left:" & main_image_x & ";height:20;width:" & main_image_width & ";border:1px solid;"" >")
        Response.Write("&nbsp;&nbsp;<span style=""color:#FFFFFF;"">Map Display</span>")
        Response.Write("</div>")
        Response.Write("<div id=""prt_map_image"" style=""overflow:hidden;z-index:2;position:absolute;margin:" & main_image_inset & ";top:" & main_image_y & ";left:" & main_image_x & ";height:" & main_image_height & ";width:" & main_image_width & ";border-bottom:none;border-color:#000000;border:1px solid;"" >")
        Response.Write("<img src=""" & _map_image_url & """ border='0'>")
        Response.Write("</div>")
        Response.Write(vbCrLf)

        '- Legend map div
        Response.Write("<div id=""prt_map_legend_bdr"" style=""background-color:" & Application("AppColour_Base") & " ;font-family:arial;font-size:12px;font-weight:bold;overflow:hidden;z-index:2;position:absolute;margin:" & legend_image_inset & ";top:" & (legend_image_y - 20) & ";left:" & legend_image_x & ";height:20;width:" & legend_image_width & ";border:1px solid;"" >")
        Response.Write("&nbsp;&nbsp;<span style=""color:#FFFFFF;"">Map Legend</span>")
        Response.Write("</div>")
        Response.Write("<div id=""prt_map_legend"" style=""overflow:hidden;z-index:3;position:absolute;margin:" & legend_image_inset & ";top:" & legend_image_y & ";left:" & legend_image_x & ";height:" & legend_image_height & ";width:" & legend_image_width & ";border-bottom:none;border-color:#000000;border:1px solid;"" >")
        Response.Write("<img src=""" & _legend_image_url & """ border='0'>")
        Response.Write("</div>")
        Response.Write(vbCrLf)

        '- Overview map div
        Response.Write("<div id=""prt_map_ov_bdr"" style=""background-color:" & Application("AppColour_Base") & " ;font-family:arial;font-size:12px;font-weight:bold;overflow:hidden;z-index:2;position:absolute;margin:" & ov_image_inset & ";top:" & (ov_image_y - 20) & ";left:" & ov_image_x & ";height:20;width:" & ov_image_width & ";border:1px solid;"" >")
        Response.Write("&nbsp;&nbsp;<span style=""color:#FFFFFF;"">Map Overview</span>")
        Response.Write("</div>")
        Response.Write("<div id=""prt_map_ov"" style=""overflow:hidden;z-index:4;position:absolute;margin:" & ov_image_inset & ";top:" & ov_image_y & ";left:" & ov_image_x & ";height:" & ov_image_height & ";width:" & ov_image_width & ";border-color:#000000;border:1px solid;"" >")
        Response.Write("<img src=""" & _ov_image_url & """ border='0'>")
        Response.Write("</div>")
        Response.Write(vbCrLf)
        Response.Write("</body>")
        Response.Write(vbCrLf)
        Response.Write("</html>")


        appPrintUtilityFunctions = Nothing
        appHighlightFunctions = Nothing
        appUtilityFunctions = Nothing
        appMapFunctions = Nothing
        pv_geo = Nothing
        mAcetateLayer = Nothing
        mEnvelope = Nothing
        mPoints = Nothing
        mPolygon = Nothing
        mPoint = Nothing
%>
 

