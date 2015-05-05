<%@ Page Language="vb" AutoEventWireup="false" Codebehind="search_all.aspx.vb" Inherits="dotNETViewer.search_all"%>
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
'	The purpose of this page is to provide the HTML interface to facilitate a search all function.  The way Search All works is 
'	as follows: the user selects the Search All tool.  The user then selects the layer they wish to search.  Some query fields
'	then come up by which they make their selection.  Upon clicking on submit, a list of matching candidates with full details 
'	appears.  The user can then click on the highlight button which will highlight and zoom to the feature selected.  
'
'************************************************************************************************************************************
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<TITLE>Search All Results</TITLE>
		<%
On Error Resume Next
%>
		<!--#include file="../includes/header.aspx"-->
	</HEAD>
	<BODY <%if request("p")<>3 then%>onload="<%=strOnLoad%>"<%end if%>>
		
		<script language='JavaScript' type='text/javascript'>
		var undef;
		var prefix;
		
		if (opener==undef) {prefix=top.MapFrame;}else{prefix=opener.top.MapFrame;}
		</script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>
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
				//submit our selected layer(s) to go to step 2
				if (document.SearchAllStep1.SearchAllLayer.selectedIndex==-1) {
					alert ("Please select a layer to proceed.");
					return;
				}
				
				//Display the loading GIF layer
				prefix.positionLoadingLyr();

				//Submit the form.
				document.SearchAllStep1.action="search_all.aspx?p=2&m=<%=request("m")%>&lyr=" + document.SearchAllStep1.SearchAllLayer.options[document.SearchAllStep1.SearchAllLayer.selectedIndex].value;
				document.SearchAllStep1.submit();
			}
			
			function SetDefaultLayer() {
				//page function 5 will set the selected layer as the default layer
				document.SearchAllStep1.action="search_all.aspx?p=5&m=<%=request("m")%>"
				document.SearchAllStep1.submit();
			}

			function DInst() {
				//Display instructions
				alert ("The Default Layer selection allows a user to assign a designated layer to be used each time an 'Search All' is executed.  This is beneficial for repetitious interactions so that the user may avoid selecting the same desired layer from the list many times.");
			}
			
		</script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>


		<FORM ID="SearchAllStep1" action="search_all.aspx?p=nge Search</b></font></td></tr></table>

		<TABLE width=600 cellpadding=0 cellspacing=0 border=0>
			<TR valign=top>
			<TD>
			<br>
			<select name="SearchAllLayer" id="SearchAllLayer" size=5 style="width:200px;">
			<%=SearchAllLayerOptions%>
			</select>
			<br><br>
			<input type=button class=Btn value="Continue" onclick="submitit();"><br>
			<%if Application("MenuStyle")="" then%>
			<br><a href="javascript:SetDefaultLayer();">Set as Default Layer</a><br><span style="font-size:9px"><a href="javascript:DInst();">(default instructions)</a></span>
			<%end if%>
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
					//In this function, we validate that the necessary data is there.  If there is an error, prompt the user and do not continue.
					//The IF statement clause is dynamically generated.
					if (<%=JSIF%>) {
						alert ("Please fill out at least one of the search fields to proceed.");
						return;
					}
					
					//Show loading GIF layer and submit form.
					prefix.positionLoadingLyr();
					document.SearchAllStep2.submit();
				}

		</script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>
		<FORM name="SearchAllStep2" action="search_all.aspx?p=3&d=<%=drilldown%>&m=<%=request("m")%>" method="post" target=_new>
			
<table cellpadding=1 cellspacing=1 border=0>
			<tr><td><%=Information%></td></tr></table>
			<input type=hidden name="QueryString" value="<%=WE%>">
		</FORM>
		<%elseif p = "3" then%>
		<script language='JavaScript' type='text/javascript'>
			function sendValue(IDValue,QL,FN,E) {
				
				var objWC = prefix.findObj("WhereClause")	//Includes the x,y coordinates for the feature - makes processing faster
				var objFN = prefix.findObj("SAFieldName")	//Usually #ID# - uniquely identify the individual feature
				var objMF = prefix.findObj("MapFunction") //18 = ID All and Search All feature highlight
				var objQL = prefix.findObj("QueryLayer")	// ID of layer we're working on.
				var objC = prefix.findObj("CustomIDAllColour")	// Colour to colour the feature 
				var objZoomToFeature=prefix.findObj('ZoomToFeature');	//Zoom to the features?  (Y)

				if (objWC!=null) {
					if (objZoomToFeature!=null) { objZoomToFeature.value='Y'; }
					prefix.positionLoadingLyr();
					objWC.value=IDValue + "~ENV~" + E;
					objFN.value=FN;
					objMF.value=18;
					objC.value=255;
					objQL.value=QL;
					prefix.RefreshMap();
				}
			}

			//For Address Search
			<%if Application("AppType")="EconDev" then%>
			function SendValueAddress(minx,maxx,miny,maxy) {
				prefix.positionLoadingLyr();
				prefix.GoSimpleGUIiFrameRight("EconDev/PropertyDetails_Front.aspx?U=&minX=" + minx + "&minY=" + miny + "&maxX=" + maxx + "&maxY=" + maxy + "&sb=" + top.edIDBiz + "&URL=");
			}
			<%else%>
			function SendValueAddress(Value1) {
				//This function allows the user to click on an APN and it will trigger the main processing page (pv_process) to 
				//display the parcel details for the selected parce.  Other things which must happen are: display the loading
				//layer, clear out the buffer window (asthetics), and call SSRefreshMap - this javascript function actually
				//starts the zoom-to-parcel and display results process.
				prefix.positionLoadingLyr();
				//prefix.clearBufUrl(1);
				var url = "SS/parcel_details.aspx?APN=" + Value1
				prefix.url = "";
				prefix.SSRefreshMap(Value1,url);
			}
			<%end if%>

			function DrillDown() {
				//Not used
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
