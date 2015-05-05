<%@ Page Language="vb" CodeBehind="printview.aspx.vb" AutoEventWireup="false" Inherits="dotNETViewer.printview" %>
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
On Error Resume Next
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<TITLE></TITLE>
		<STYLE>
		header_background
		{
			color:#000000;
			font-family:'Arial,trebuchet ms',helvetica,sans-serif;
			font-size:10px;
			font-weight:bold;
			height:20px;
			
			border:1px solid;
			border-top-color:#999999;
			border-left-color:#999999;
			border-right-color:#999999;
			border-bottom-color:#999999;
			filter:progid:DXImageTransform.Microsoft.Gradient(GradientType=0,StartColorStr='#ffffffff',EndColorStr='#999999');
		}
		</STYLE>
	</HEAD>
	<BODY topmargin="2" leftmargin="2" marginheight="2" marginwidth="2">
		<% 
		On Error Resume Next
		
		Dim orientation, scale, mMap, mOvMap,scalev
		
		'If our print map object is invalid, our session timed out - so alert the user!
        If IsNothing(Session("OVMapObj")) = True Then
            Response.Redirect("../includes/session_timeout.aspx", True)
        End If
		
		'Get the map and overview map session objects.
		mMap = session("MapObj")
		mOvMap = session("OVMapObj")
		
		 
		'Response.Write ("MAP: " & mOvMap.GetImageAsUrl())
		
		'Get print options (orientation and scale).
		orientation = request.Form("orientation")
		scale = CInt(request.Form("Scale"))
		Dim OVMap as string = mOvMap.GetImageAsUrl()
	 
		'Printing as portrait - format page for portrait.
		if orientation = "portrait" then 
		
		%>
		<div id="2"   style="width:<%=TableWidth%>;border:1px solid;" >
	
		<TABLE border="0"  cellpadding="0" cellspacing="0" width="<%= TableWidth %>">
			<TR>
				<TD width="100%">
				<div >
					<TABLE style="border-bottom:1px solid #000000;filter:progid:DXImageTransform.Microsoft.Gradient(GradientType=0,StartColorStr='#003399',EndColorStr='#ffffff')" border="0" width="100%" cellpadding="0" cellspacing="0">
						<TR >
						<%if trim(request.Form("TitleText")) <> "" then%>
							<TD height=50 width="100%" align="center" valign="center"><span style="color:#ffffff;font-family:Arial;font-weight:bold;font-size:16px;"><b><%=trim(request.Form("TitleText"))%></b></span></TD>
						<%else%>
							<TD><img border="0" src="../images/map_view.jpg" height=50 align="right"></TD>
							<!--<TD width="100%" align="center" valign="center"><span style="font-family:Arial;font-weight:bold;font-size:14px;"><b><%=Application("PrintTitle")%></b></span></TD>-->
						<%end if%>
							<!--<TD><img border="0" src="../images/<%=Application("ClientLogo")%>" height=50 align="right"></TD>-->
							
						</TR>
					</TABLE>
				</div>
				</TD>
			</TR>
			<TR>
				<TD width="100%" align="center" valign="center">
					<TABLE border="0" width="100%" cellpadding="0" cellspacing="0">
						<TR>
							<TD width="100%" align="center" valign="center"><img border=0 src="<%= MapImage %>"></TD>
						</TR>
					</TABLE>
				</TD>
			</TR>
			<%if request.form("ShowOVMap")<>"" or request.form("ShowLegend")<>"" then%>
			<TR>
				<TD height=125>
					<div style="width:<%=TableWidth%>;border-top:1px solid;" >
					<TABLE  width="100%">
						<%if request.form("ShowOVMap")="" and request.form("ShowLegend")<>"" then%>
						<TR>
							<TD width="100%" align="left" >
								<img border=0 src="<%= LegendURL %>">
							</TD>
						</TR>
						<%end if%>
						<%if request.form("ShowOVMap")<>"" and request.form("ShowLegend")="" then%>
						<TR>
							<TD width="100%" align="left" ><img border=0 src="<%= OVMap %>"></TD>
						</TR>
						<%end if%>
						<%if request.form("ShowOVMap")<>"" and request.form("ShowLegend")<>"" then%>
						<TR>
							<TD width="130" align="left" ><img border=0 src="<%= OVMap %>"></TD>
							<TD  align="left" ><img border=0 src="<%= LegendURL %>"></TD>
						</TR>
						<%end if%>
					</TABLE>
					</div>
				</TD>
			</TR>
			<%end if%>
		</TABLE>
		</div>
		<%
		'Landscape - format page for print in landscape
		else%>
		<div style="width:<%=TableWidth%>;border:1px solid;" >
		<TABLE border=0 cellpadding="0" cellspacing="0" bgcolor="#ffffff" >
			<TR>
				<TD width="100%">
				<div style="border-bottom:1px solid;" >
					<TABLE border="0" width="100%" cellpadding="0" cellspacing="0" style="filter:progid:DXImageTransform.Microsoft.Gradient(GradientType=0,StartColorStr='#003399',EndColorStr='#ffffff')" >
						<TR>
						<%if trim(request.Form("TitleText")) <> "" then%>
							<TD height=50 width="100%" align="center" valign="center"><span style="color:#ffffff;font-family:Arial;font-weight:bold;font-size:16px;"><b><%=trim(request.Form("TitleText"))%></b></span></TD>
						<%else%>
							<TD><img border="0" src="../images/map_view.jpg" height=50 align="right"></TD>
							<!--<TD width="100%" align="center" valign="center"><span style="font-family:Arial;font-weight:bold;font-size:14px;"><b><%=Application("PrintTitle")%></b></span></TD>-->
						<%end if%>
							<!--<TD><img border="0" src="../images/<%=Application("ClientLogo")%>" height=50 align="right"></TD>-->
							
						</TR>
					</TABLE>
				</div>
				</TD>
			</TR>
			<TR>
				<TD width="100%" align="center" valign="center">
					<div style="border-bottom:1px solid;" >
					<TABLE border="0" width="100%" cellpadding="0" cellspacing="0">
						<TR>
							<TD width="100%" align="center" valign="center"><img border=0 src="<%= MapImage %>"></TD>
							<TD valign=top>
								<div style="border-left:1px solid;" >
								<TABLE border="0" cellpadding=5 cellspacing=5 width="100%"><!---Right--->
									<%if request.form("ShowOVMap")<>"" then%>
									<TR valign=top>
										<td><span style="font-family:Arial;font-weight:bold;font-size:12px;">Overview Map</span></td>
									</tr>
									<TR valign=top>
										<TD align="center"><img border=0 src="<%= OVMap %>"></TD>
									</TR>
									<%end if%>
									<%if request.form("ShowLegend")<>"" then%>
									<TR valign=top>
										<td><span style="font-family:Arial;font-weight:bold;font-size:12px;">Legend</span></td>
									</tr>
									<TR valign=top ><!---Legend--->
										<TD align="center" height=200><img border=0 src="<%= LegendURL %>" ></TD>
									</TR>
									<%end if%>
								</TABLE>
								</div>
							</TD>
						</TR>
					</TABLE>
					</div>
				</TD>
			</TR>
			<TR>
				<TD>
					<p align="center"><span style="color:red;font-family:Arial;font-weight:normal;font-size:12px;">Note: This map was prepared for assessment purpose 
							only and does not represent a survey</span>
				</TD>
			</TR>
		</TABLE>
		</div>
		<%End If%>
		<DIV id="animlayer" style="position:absolute; left:400; top:120; visibility:hidden;"><img src="../images/<%=Application("LoadingGraphic")%>" border="0"></TD></DIV>
	</BODY>
</HTML>
