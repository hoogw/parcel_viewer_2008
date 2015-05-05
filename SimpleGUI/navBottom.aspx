<%@ Page Language="vb" AutoEventWireup="false" Codebehind="navBottom.aspx.vb" Inherits="dotNETViewer.navBottom"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title></title>
		<!--#include file="../includes/header.aspx"-->
	</HEAD>

<%
	dim j
	dim aryZ = New double(10) {.005,.01,.05,.1,.15,.2,.25,.3,.4,.5,1}
%>	        
	
	<script language="Javascript">
	
	
		function resetSearch () {
			top.MapFrame.GoSimpleGUIiFrameRight('custom/searchmain.aspx');
		}
	</script>
	
	<body onload="top.MapFrame.hideLoadingLyr()">
		<table cellpadding=0 cellspacing=0 border=0 width=100% height=4><tr class="VC"><td><img src="../images/spacer.gif" height=3></td></tr></table>
		
		<table cellpadding=0 cellspacing=0 border=0 width=100%>
		<tr valign=top bgcolor="#E3E3E3">
		<td align=left><table cellpadding=3 cellspacing=3 border=0 width=55%><tr>
			<td width=20><a href="javascript:top.MapFrame.SetCurrTool(2,2);" ><img src="../images/icons/zoom-in_16.gif" border=0 alt="Zoom In"></td>
			<td width=20><a href="javascript:top.MapFrame.SetCurrTool(5,2);" ><img src="../images/icons/zoom-out_16.gif" border=0 alt="Zoom Out"></td>
			<td width=20><a href="javascript:top.MapFrame.SetCurrTool(11,2);" ><img src="../images/icons/pan_16.gif" border=0 alt="Pan"></td>
			<td width=20><a href="javascript:top.MapFrame.SaveMap();" ><img src="../images/icons/save_16.gif" border=0 alt="Save Map"></td>
			<td width=20><a href="javascript:top.MapFrame.SetCurrTool(22,2);" ><img src="../images/icons/identify-parcel-details_16.gif" border=0 alt="Parcel Details"></td>
			<td width=20><a href="javascript:top.MapFrame.swapLayerVis(top.MapFrame.lyrlayers,'windowLayers');" ><img src="../images/icons/layers_16.gif" border=0 alt="Layers"></td>
			<td align=right><input type=button class=Btn onclick="resetSearch();" value="Main Search"></td>
		</tr>
<tr>
			<td width=20><a href="javascript:top.MapFrame.SetCurrTool(7,1);" ><img src="../images/icons/full-extent_16.gif" border=0 alt="Zoom To Full Extent"></td>
			<td width=20><a href="javascript:top.MapFrame.goBookmarkMain(0);" ><img src="../images/icons/bookmarks_16.gif" border=0 alt="Bookmarks"></td>
			<td width=20><a href="javascript:top.MapFrame.PrintMap('-1');" ><img src="../images/icons/print_16.gif" border=0 alt="Print"></td>
			<td width=20><a href="javascript:top.MapFrame.SSRefreshMap('','');" ><img src="../images/icons/clearhighlight_1.gif" border=0 alt="Clear Graphics"></td>
			<td width=20><a href="javascript:top.MapFrame.SetCurrTool(90,2);" ><img src="../images/pictotool_16x16_2.gif" border=0 alt="Display Oblique View"></td>

		</table>
		</TR>
	</body>
</HTML>
