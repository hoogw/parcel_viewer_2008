<%@ Page Language="vb" AutoEventWireup="false" Codebehind="navBottom.aspx.vb" Inherits="dotNETViewer.navBottom"%>
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
'	hideLoadingLyr() - In the body's onload clause, this javascript function is executed.  This function resides in nav.js and the
'	purpose of this function is to hide the layer which houses the loading image.
'
'************************************************************************************************************************************
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<TITLE></TITLE>
		<!--#include file="../includes/header.aspx"-->
	</HEAD>

<%
	Dim j
	
	'Array full of zoom scale factors.
	Dim aryZ = New double(10) {.005,.01,.05,.1,.15,.2,.25,.3,.4,.5,1}
%>	        
	
	<script language='JavaScript' type='text/javascript'>
	
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
	
	<BODY onload="top.MapFrame.hideLoadingLyr()">
		<TABLE cellpadding=0 cellspacing=0 border=0 width=100% height=4><TR class="btn"><TD><img src="../images/spacer.gif" height=3></TD></TR></TABLE>
		
		<TABLE cellpadding=0 cellspacing=0 border=0 width=100%>
		<TR valign=center bgcolor="#E3E3E3">
		<TD align=left><TABLE cellpadding=3 cellspacing=3 border=0 width=30%><TR>
			<TD><a href="javascript:top.MapFrame.SetCurrTool(2,2);" ><img src="../images/icons/zoom-in_16.gif" border=0 alt="Zoom In"></TD>
			<TD><a href="javascript:top.MapFrame.SetCurrTool(5,2);" ><img src="../images/icons/zoom-out_16.gif" border=0></TD>
			<TD><a href="javascript:top.MapFrame.SetCurrTool(11,2);" ><img src="../images/icons/pan_16.gif" border=0></TD>
			<TD><a href="javascript:top.MapFrame.SaveMap();" ><img src="../images/icons/save_16.gif" border=0></TD>
			<TD><a href="javascript:top.MapFrame.SetCurrTool(22,2);" ><img src="../images/icons/identify-parcel-details_16.gif" border=0></TD>
			<TD><a href="javascript:top.MapFrame.swapLayerVis(top.MapFrame.lyrlayers,'windowLayers');" ><img src="../images/icons/layers_16.gif" border=0></TD>
		</TR></TABLE>
		</TD>
		<TD align=center><a href="javascript:resetSearch();">Main Search</a></TD>
		<TD align=right><TABLE cellpadding=1 cellspacing=1 border=0 width=200><TR>
			<TD></TD>
			
			<TD></TD>
			
			<TD></TD>
		</TR></TABLE>
		</TD>
		</TR></TABLE>
		<TABLE cellpadding=0 cellspacing=0 border=0 width=100% height=4><TR class="btn"><TD><img src="../images/spacer.gif" height=3></TD></TR></TABLE>
	</BODY>
</HTML>
