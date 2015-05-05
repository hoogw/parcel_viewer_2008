
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title></title>
		
<link rel="stylesheet" type="text/css" href="../includes/CSS/1SS.css">

	</HEAD>

	        
	
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

				
					o=top.MapFrame.findObj("z_1",this.document);

					if (o!=null && i!=1) {
						o.onmouseover=function(){top.MapFrame.di20('z_1','../images/icons/z_1.gif',this.document);}
						o.onmouseout=function(){top.MapFrame.di20('z_1','../images/icons/z_0.gif',this.document);}
						o.onclick=function(){Z(1,this);}
						top.MapFrame.di20('z_1','../images/icons/z_0.gif',this.document);
					} else {
						objZL.value='0.01'; 
					}	
				
					o=top.MapFrame.findObj("z_2",this.document);

					if (o!=null && i!=2) {
						o.onmouseover=function(){top.MapFrame.di20('z_2','../images/icons/z_1.gif',this.document);}
						o.onmouseout=function(){top.MapFrame.di20('z_2','../images/icons/z_0.gif',this.document);}
						o.onclick=function(){Z(2,this);}
						top.MapFrame.di20('z_2','../images/icons/z_0.gif',this.document);
					} else {
						objZL.value='0.05'; 
					}	
				
					o=top.MapFrame.findObj("z_3",this.document);

					if (o!=null && i!=3) {
						o.onmouseover=function(){top.MapFrame.di20('z_3','../images/icons/z_1.gif',this.document);}
						o.onmouseout=function(){top.MapFrame.di20('z_3','../images/icons/z_0.gif',this.document);}
						o.onclick=function(){Z(3,this);}
						top.MapFrame.di20('z_3','../images/icons/z_0.gif',this.document);
					} else {
						objZL.value='0.1'; 
					}	
				
					o=top.MapFrame.findObj("z_4",this.document);

					if (o!=null && i!=4) {
						o.onmouseover=function(){top.MapFrame.di20('z_4','../images/icons/z_1.gif',this.document);}
						o.onmouseout=function(){top.MapFrame.di20('z_4','../images/icons/z_0.gif',this.document);}
						o.onclick=function(){Z(4,this);}
						top.MapFrame.di20('z_4','../images/icons/z_0.gif',this.document);
					} else {
						objZL.value='0.15'; 
					}	
				
					o=top.MapFrame.findObj("z_5",this.document);

					if (o!=null && i!=5) {
						o.onmouseover=function(){top.MapFrame.di20('z_5','../images/icons/z_1.gif',this.document);}
						o.onmouseout=function(){top.MapFrame.di20('z_5','../images/icons/z_0.gif',this.document);}
						o.onclick=function(){Z(5,this);}
						top.MapFrame.di20('z_5','../images/icons/z_0.gif',this.document);
					} else {
						objZL.value='0.2'; 
					}	
				
					o=top.MapFrame.findObj("z_6",this.document);

					if (o!=null && i!=6) {
						o.onmouseover=function(){top.MapFrame.di20('z_6','../images/icons/z_1.gif',this.document);}
						o.onmouseout=function(){top.MapFrame.di20('z_6','../images/icons/z_0.gif',this.document);}
						o.onclick=function(){Z(6,this);}
						top.MapFrame.di20('z_6','../images/icons/z_0.gif',this.document);
					} else {
						objZL.value='0.25'; 
					}	
				
					o=top.MapFrame.findObj("z_7",this.document);

					if (o!=null && i!=7) {
						o.onmouseover=function(){top.MapFrame.di20('z_7','../images/icons/z_1.gif',this.document);}
						o.onmouseout=function(){top.MapFrame.di20('z_7','../images/icons/z_0.gif',this.document);}
						o.onclick=function(){Z(7,this);}
						top.MapFrame.di20('z_7','../images/icons/z_0.gif',this.document);
					} else {
						objZL.value='0.3'; 
					}	
				
					o=top.MapFrame.findObj("z_8",this.document);

					if (o!=null && i!=8) {
						o.onmouseover=function(){top.MapFrame.di20('z_8','../images/icons/z_1.gif',this.document);}
						o.onmouseout=function(){top.MapFrame.di20('z_8','../images/icons/z_0.gif',this.document);}
						o.onclick=function(){Z(8,this);}
						top.MapFrame.di20('z_8','../images/icons/z_0.gif',this.document);
					} else {
						objZL.value='0.4'; 
					}	
				
					o=top.MapFrame.findObj("z_9",this.document);

					if (o!=null && i!=9) {
						o.onmouseover=function(){top.MapFrame.di20('z_9','../images/icons/z_1.gif',this.document);}
						o.onmouseout=function(){top.MapFrame.di20('z_9','../images/icons/z_0.gif',this.document);}
						o.onclick=function(){Z(9,this);}
						top.MapFrame.di20('z_9','../images/icons/z_0.gif',this.document);
					} else {
						objZL.value='0.5'; 
					}	
				
					o=top.MapFrame.findObj("z_10",this.document);

					if (o!=null && i!=10) {
						o.onmouseover=function(){top.MapFrame.di20('z_10','../images/icons/z_1.gif',this.document);}
						o.onmouseout=function(){top.MapFrame.di20('z_10','../images/icons/z_0.gif',this.document);}
						o.onclick=function(){Z(10,this);}
						top.MapFrame.di20('z_10','../images/icons/z_0.gif',this.document);
					} else {
						objZL.value='1'; 
					}	
				

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
			<td><a href="javascript:top.MapFrame.PrintMap('-1','../');" ><img src="../images/icons/print_16.gif" border=0 alt="Print"></td>
		</table>
		</td>
		<td align=center><input type=button class=Btn onclick="resetSearch();" value="Main Search"></td>
		<td align=right><table cellpadding=1 cellspacing=1 border=0 width=30%><tr>
			<td><img src="../images/icons/z_+.gif" border=0></td>
			
			<td><img src="../images/icons/z_0.gif" border=0 name="z_1" onclick="Z(1,this);" onmouseover="top.MapFrame.di20('z_1','../images/icons/z_1.gif',this.document);" onmouseout="top.MapFrame.di20('z_1','../images/icons/z_0.gif',this.document);"></td>
			
			<td><img src="../images/icons/z_0.gif" border=0 name="z_2" onclick="Z(2,this);" onmouseover="top.MapFrame.di20('z_2','../images/icons/z_1.gif',this.document);" onmouseout="top.MapFrame.di20('z_2','../images/icons/z_0.gif',this.document);"></td>
			
			<td><img src="../images/icons/z_0.gif" border=0 name="z_3" onclick="Z(3,this);" onmouseover="top.MapFrame.di20('z_3','../images/icons/z_1.gif',this.document);" onmouseout="top.MapFrame.di20('z_3','../images/icons/z_0.gif',this.document);"></td>
			
			<td><img src="../images/icons/z_0.gif" border=0 name="z_4" onclick="Z(4,this);" onmouseover="top.MapFrame.di20('z_4','../images/icons/z_1.gif',this.document);" onmouseout="top.MapFrame.di20('z_4','../images/icons/z_0.gif',this.document);"></td>
			
			<td><img src="../images/icons/z_0.gif" border=0 name="z_5" onclick="Z(5,this);" onmouseover="top.MapFrame.di20('z_5','../images/icons/z_1.gif',this.document);" onmouseout="top.MapFrame.di20('z_5','../images/icons/z_0.gif',this.document);"></td>
			
			<td><img src="../images/icons/z_0.gif" border=0 name="z_6" onclick="Z(6,this);" onmouseover="top.MapFrame.di20('z_6','../images/icons/z_1.gif',this.document);" onmouseout="top.MapFrame.di20('z_6','../images/icons/z_0.gif',this.document);"></td>
			
			<td><img src="../images/icons/z_0.gif" border=0 name="z_7" onclick="Z(7,this);" onmouseover="top.MapFrame.di20('z_7','../images/icons/z_1.gif',this.document);" onmouseout="top.MapFrame.di20('z_7','../images/icons/z_0.gif',this.document);"></td>
			
			<td><img src="../images/icons/z_0.gif" border=0 name="z_8" onclick="Z(8,this);" onmouseover="top.MapFrame.di20('z_8','../images/icons/z_1.gif',this.document);" onmouseout="top.MapFrame.di20('z_8','../images/icons/z_0.gif',this.document);"></td>
			
			<td><img src="../images/icons/z_0.gif" border=0 name="z_9" onclick="Z(9,this);" onmouseover="top.MapFrame.di20('z_9','../images/icons/z_1.gif',this.document);" onmouseout="top.MapFrame.di20('z_9','../images/icons/z_0.gif',this.document);"></td>
			
			<td><img src="../images/icons/z_0.gif" border=0 name="z_10" onclick="Z(10,this);" onmouseover="top.MapFrame.di20('z_10','../images/icons/z_1.gif',this.document);" onmouseout="top.MapFrame.di20('z_10','../images/icons/z_0.gif',this.document);"></td>
			
			<td><img src="../images/icons/z_-.gif" border=0></td>
		</tr></table>
		</td>
		</tr></table>


		<table cellpadding=0 cellspacing=0 border=0 width=100% height=4><tr class="VC"><td><img src="../images/spacer.gif" height=3></td></tr></table>
	</body>
</HTML>
