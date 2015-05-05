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
	
		function Z(i,obj) {
		
			var o;
			var objMF = top.MapFrame.findObj("MapFunction")
			var objZL=top.MapFrame.findObj('ZoomLadder');

			obj.onmouseover="";
			obj.onmouseout="";
			obj.onclick="";
			top.MapFrame.di20('z_' + i,'../images/icons/z_2.gif',this.document);

			if (objZL!=null) {
				objMF.value=6;	

				<%for j = 1 to aryZ.getupperbound(0)%>
					o=top.MapFrame.findObj("z_<%=j%>",this.document);

					if (o!=null && i!=<%=j%>) {
						o.onmouseover=function(){top.MapFrame.di20('z_<%=j%>','../images/icons/z_1.gif',this.document);}
						o.onmouseout=function(){top.MapFrame.di20('z_<%=j%>','../images/icons/z_0.gif',this.document);}
						o.onclick=function(){Z(<%=j%>,this);}
						top.MapFrame.di20('z_<%=j%>','../images/icons/z_0.gif',this.document);
					} else {
						objZL.value='<%=aryZ(j)%>'; 
					}	
				<%next%>

				top.MapFrame.RefreshMap();
			}
		}
	
		function resetSearch () {
			top.MapFrame.GoSimpleGUIiFrameRight('custom/searchmain.aspx');
		}
	</script>
	
	<body onload="top.MapFrame.hideLoadingLyr()">
		<table cellpadding=0 cellspacing=0 border=0 width=100% height=4><tr class="VC"><td><img src="../images/spacer.gif" height=3></td></tr></table>
		
		<table cellpadding=0 cellspacing=0 border=0 width=100%>
		<tr valign=top bgcolor="#E3E3E3">
		<td align=left><table cellpadding=3 cellspacing=3 border=0 width=30%><tr>
			<td><a href="javascript:top.MapFrame.SetCurrTool(2,2);" ><img src="../images/icons/zoom-in_16.gif" border=0 alt="Zoom In"></td>
			<td><a href="javascript:top.MapFrame.SetCurrTool(5,2);" ><img src="../images/icons/zoom-out_16.gif" border=0 alt="Zoom Out"></td>
			<td><a href="javascript:top.MapFrame.SetCurrTool(11,2);" ><img src="../images/icons/pan_16.gif" border=0 alt="Pan"></td>
			<td><a href="javascript:top.MapFrame.SaveMap();" ><img src="../images/icons/save_16.gif" border=0 alt="Save Map"></td>
			<td><a href="javascript:top.MapFrame.SetCurrTool(22,2);" ><img src="../images/icons/identify-parcel-details_16.gif" border=0 alt="Parcel Details"></td>
			<td><a href="javascript:top.MapFrame.swapLayerVis(top.MapFrame.lyrlayers,'windowLayers');" ><img src="../images/icons/layers_16.gif" border=0 alt="Layers"></td>
		</tr>
<tr>
			<td><a href="javascript:top.MapFrame.SetCurrTool(7,1);" ><img src="../images/icons/full-extent_16.gif" border=0 alt="Zoom To Full Extent"></td>
			<td><a href="javascript:top.MapFrame.goBookmarkMain(0);" ><img src="../images/icons/bookmarks_16.gif" border=0 alt="Bookmarks"></td>
			<td><a href="javascript:top.MapFrame.PrintMap('-1');" ><img src="../images/icons/print_16.gif" border=0 alt="Print"></td>
			<td><a href="javascript:top.MapFrame.SSRefreshMap('','');" ><img src="../images/icons/clearhighlight_1.gif" border=0 alt="Clear Graphics"></td>
			<td><a href="javascript:top.MapFrame.SSRefreshMap('IDAllclear','');top.MapFrame.SetCurrTool(19,2);" ><img src="../images/icons/IDall_16.gif" border=0 alt="Identify All"></td>
		</table>
		</td>
		<td align=center><input type=button class=Btn onclick="resetSearch();" value="Main Search"></td>
		<td align=right><table cellpadding=1 cellspacing=1 border=0 width=30%><tr>
			<td><img src="../images/icons/z_+.gif" border=0></td>
			<%
			for j = 1 to aryZ.getupperbound(0)
			%>
			<td><img src="../images/icons/z_0.gif" border=0 name="z_<%=j%>" onclick="Z(<%=j%>,this);" onmouseover="top.MapFrame.di20('z_<%=j%>','../images/icons/z_1.gif',this.document);" onmouseout="top.MapFrame.di20('z_<%=j%>','../images/icons/z_0.gif',this.document);"></td>
			<%
			next
			%>
			<td><img src="../images/icons/z_-.gif" border=0></td>
		</tr></table>
		</td>
		</tr></table>


		<table cellpadding=0 cellspacing=0 border=0 width=100% height=4><tr class="VC"><td><img src="../images/spacer.gif" height=3></td></tr></table>
	</body>
</HTML>
