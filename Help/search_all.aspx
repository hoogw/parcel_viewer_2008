<%@ Page Language="vb" AutoEventWireup="false" Codebehind="search_all.aspx.vb" Inherits="dotNETViewer.search_all"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<TITLE>search_all</TITLE>
		<%
On Error Resume Next
%>
		<!--#include file="../includes/header.aspx"-->
	</HEAD>
	<BODY onload="<%=strOnLoad%>">
		<%
		Dim p
		p = request("p")
		if p <> 3 And trim(Session("SearchAllDefLayers")) <> "" and Request("Mode") <> "Reset" then
			p=2
		end if
		%>
		<%if p = "1" then%>
		<script language='JavaScript' type='text/javascript'>
			function submitit() {
				if (document.SearchAllStep1.SearchAllLayer.selectedIndex==-1) {
					alert ("Please select a layer to proceed.");
					return;
				}
				
				top.MapFrame.positionLoadingLyr();

				document.SearchAllStep1.action="search_all.aspx?p=2&m=<%=request("m")%>&l=" + document.SearchAllStep1.SearchAllLayer.options[document.SearchAllStep1.SearchAllLayer.selectedIndex].value;
				document.SearchAllStep1.submit();
			}
			
			function SetDefaultLayer() {
				document.SearchAllStep1.action="search_all.aspx?p=5&m=<%=request("m")%>"
				document.SearchAllStep1.submit();
			}

			function DInst() {
				alert ("The Default Layer selection allows a user to assign a designated layer to be used each time an 'Search All' is executed.  This is beneficial for repetitious interactions so that the user may avoid selecting the same desired layer from the list many times.");
			}
			
		</script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>

		<FORM ID="SearchAllStep1" action="search_all.aspx?p=2&m=" runat="server" method="post">
		
		<TABLE width=600 cellpadding=0 cellspacing=0 border=0>
			<TR valign=top>
			<TD>
			<br>
			<asp:ListBox cssclass=HTMLFrmObjects ID="SearchAllLayer" Rows="5" SelectionMode="Single" AutoPostBack="False" Runat="server" Width="200"></asp:ListBox>
			<br><br>
			<input type=button class=Btn value="Continue" onclick="submitit();"><br>
			<br><a href="javascript:SetDefaultLayer();">Set as Default Layer</a><br><span style="font-size:9px"><a href="javascript:DInst();">(default instructions)</a></span>
			</TD>
			<TD>
			<br>
			<FONT class="SSMsg2">SEARCH ALL INSTRUCTIONS</FONT><br><br>
			<FONT class="SSMsg2">1) Select the layer you would like to query.</FONT><br>
			<FONT class="SSMsg2">2) Click on the Continue button.</FONT><br>
			</TD>
		</FORM>
		<%elseif p = "2" then%>
		<script language='JavaScript' type='text/javascript'>
				function submitit() {
					if (<%=JSIF%>) {
						alert ("Please fill out at least one of the search fields to proceed.");
						return;
					}
					
					top.MapFrame.positionLoadingLyr();
					document.SearchAllStep2.submit();
				}

		</script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>
		<FORM name="SearchAllStep2" action="search_all.aspx?p=3&d=<%=drilldown%>&m=<%=request("m")%>" method="post">
			<%=Information%>
			<input type=hidden name="QueryString" value="<%=WE%>">
		</FORM>
		<%elseif p = "3" then%>
		<script language='JavaScript' type='text/javascript'>
			function sendValue(IDValue,QL,FN,E) {

				var objWC = top.MapFrame.findObj("WhereClause")
				var objFN = top.MapFrame.findObj("SAFieldName")
				var objMF = top.MapFrame.findObj("MapFunction")
				var objQL = top.MapFrame.findObj("QueryLayer")
				var objC = top.MapFrame.findObj("CustomIDAllColour")
				var objZoomToFeature=top.MapFrame.findObj('ZoomToFeature');

				if (objWC!=null) {
					if (objZoomToFeature!=null) { objZoomToFeature.value='Y'; }
					top.MapFrame.positionLoadingLyr();
					objWC.value=IDValue + "~ENV~" + E;
					objFN.value=FN;
					objMF.value=18;
					objC.value=255;
					objQL.value=QL;
					top.MapFrame.RefreshMap();
				}
			}

			//For Address Search
			<%if Application("AppType")="EconDev" then%>
			function SendValueAddress(minx,maxx,miny,maxy) {
				top.MapFrame.positionLoadingLyr();
				//top.MapFrame.clearBufUrl(1);
				//var url = 
				top.MapFrame.GoSimpleGUIiFrameRight("EconDev/PropertyDetails_Front.aspx?U=&minX=" + minx + "&minY=" + miny + "&maxX=" + maxx + "&maxY=" + maxy + "&sb=" + top.edIDBiz + "&URL=");
				//top.MapFrame.url = "";
				//top.MapFrame.SSRefreshMap(Value1,url);
			}
			<%else%>
			function SendValueAddress(Value1) {
				top.MapFrame.positionLoadingLyr();
				top.MapFrame.clearBufUrl(1);
				var url = "SS/parcel_details.aspx?APN=" + Value1
				top.MapFrame.url = "";
				top.MapFrame.SSRefreshMap(Value1,url);
			}
			<%end if%>

			function DrillDown() {
				document.Qry.action="search_all.aspx?p=2&d=1&l=<%=request("lyr")%>&m=<%=request("m")%>";
				document.Qry.submit();
			}
			
		</script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>
		<FORM name="Qry" method=post>
		<input type=hidden name="QueryString" value="<%=WE%>">
        
        <%if Custom=True then%>
        <input type=hidden name=FieldCount value="<%=request("FieldCount")%>">
        <input type=hidden name=FieldsToShow value="<%=request("FieldsToShow")%>">
        <input type=hidden name=FieldClick value="<%=request("FieldClick")%>">
        <input type=hidden name=SendValueJSFunction value="<%=request("SendValueJSFunction")%>">
		<input type=hidden name=FieldLabelsToShow value="<%=request("FieldLabelsToShow")%>">
		<input type=hidden name=BackURL value="<%=request("BackURL")%>">
		<input type=hidden name=TitleText value="<%=request("TitleText")%>">
        <%end if%>
		</FORM>
		<%=Information%>
		<%elseif p = "5" then%>
		<%=Information%>
		<%end if%>

		<%if p <> 5 then%>
		<FORM ID="Rst" method="post" runat="server">
		</FORM>

		<script language='JavaScript' type='text/javascript'>
		function ReSetDefaultLayer() {
			document.Rst.action="search_all.aspx?p=1&Mode=Reset&m=<%=request("m")%>"
			document.Rst.submit();
		}
		</script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>
		<%end if%>
	</BODY>
</HTML>
