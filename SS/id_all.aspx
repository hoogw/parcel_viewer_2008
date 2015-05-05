<%@ Page Language="vb" AutoEventWireup="false" Codebehind="id_all.aspx.vb" Inherits="dotNETViewer.id_all" %>
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
'	The purpose of this page is to provide the HTML interface to facilitate an ID All function.  The way ID All works is as
'	follows: the user selects the ID All tool, selects an area on the map, selects the layer(s) to ID on, and the results are
'	presented to the user in a nice HTML table - one table per matching layer.
'
'************************************************************************************************************************************
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<TITLE>Identify All Results</TITLE>
		<%
On Error Resume Next
%>
		<!--#include file="../includes/header.aspx"-->
	</HEAD>
	
		<script language='JavaScript' type='text/javascript'>
		var undef;
		var prefix;
		
		if (opener==undef) {prefix=top.MapFrame; t=top;}else{prefix=opener.top.MapFrame; t=opener.top;}
		</script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>
		<%
		Dim p
		p = request("p")
		
        If Request("l") <> "" Then
            Session("IDAllDefLayers") = Request("l")
        End If
		
		'If we're resetting, take user back to the list of layers
		if trim(Session("IDAllDefLayers")) <> "" and Request("Mode") <> "Reset" and p<> 5 then
			p=2
		end if
		
		%>
		<%if p = "1" then%>
		<script language='JavaScript' type='text/javascript'>

			var objBufUrl = prefix.findObj("BufUrl");
			if (objBufUrl!=null) {objBufUrl.value="";}

			function SetDefaultLayer() {
				//Sets the default layer - call this page again with p=5
				if (document.IDAllStep1.IDAllLayers.selectedIndex==-1) {
					alert ("Please select at least one layer to proceed.");
					return;
				}

				document.IDAllStep1.target="_self";
				document.IDAllStep1.action="id_all.aspx?p=5&Mode=Reset"
				document.IDAllStep1.submit();
			}
						
			function submitit() {
				//Submit the page (p=2) so we can actually DO the ID All.
				if (document.IDAllStep1.IDAllLayers.selectedIndex==-1) {
					alert ("Please select at least one layer to proceed.");
					return;
				}
				
				//Setting HaltLYRHide to 1 forces the loading GIF to always stay on.
				//t.HaltLYRHide=1;
				prefix.positionLoadingLyr();

				var objWC = prefix.findObj("WhereClause")	//selected coordinates
				var objMF = prefix.findObj("MapFunction") //21 = ID All
				var objQL = prefix.findObj("QueryLayer") //Layer(s) we're doing an ID All on
				var objZoomToFeature=prefix.findObj('ZoomToFeature');  //Zoom to the features?  (N)

				if (objWC!=null) {
					if (objZoomToFeature!=null) { objZoomToFeature.value='N'; }
					objWC.value="<%=request("minX")%>,<%=request("maxX")%>,<%=request("minY")%>,<%=request("maxY")%>";
					
					//QL houses all the layers we wish to ID All on.
					objQL.value="";
					for (i=0;i<document.IDAllStep1.IDAllLayers.length; i++) {
						if (document.IDAllStep1.IDAllLayers.options(i).selected==true) {
							objQL.value=objQL.value + document.IDAllStep1.IDAllLayers.options(i).value + ",";
						}
					}
					objQL.value=objQL.value + "-1";
					objMF.value=21;
					prefix.RefreshMap();
				}

				document.IDAllStep1.action="id_all.aspx?p=2&l=" + t.idAllLayers + "&minX=<%=request("minX")%>&minY=<%=request("minY")%>&maxX=<%=request("maxX")%>&maxY=<%=request("maxY")%>"
				document.IDAllStep1.submit();
			}

			function DInst() {
				alert ("The Default Layer seclection allows a user to assign a designated layer to be used each time an 'Identify All' is executed.  This is beneficial for repetitious interactions so that the user may avoid selecting the same desired layer from the list many times.");
			}
			
		</script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>
	<BODY <%if request("p")<>1 then%>onload="t.HaltLYRHide=0; <%=BodyOnLoad%>"<%end if%>>
		<FORM ID="IDAllStep1" action="id_all.aspx?p=2&l=" runat="server" method="post" target=_new>
			
		<table cellpadding=0 cellspacing=0 border=0 width=100%><tr><TD align="center" bgcolor="#bbbbbb"><b>Identify Features</b></td></tr></table>
		<hr color=black>

			<center>
			<TABLE cellpadding=0 cellspacing=0 border=1 bordercolor=black width=250><TR><TD>
				<TABLE cellpadding=1 cellspacing=1 border=0 width=270><tr bgcolor=#cccccc><td align=center>
				<%if request("minx")="" then%>
				<b>Identify All Instructions</b></td></tr>
				<tr><td>
				<br>
				<FONT class="SSMsg2">1) Select an area on the map.</FONT><br>
				<FONT class="SSMsg2">2) Select the layer(s) you would like to query.</FONT><br>
				<FONT class="SSMsg2">3) Click on the Continue button.</FONT><br><br>			
				<%else%>
				<FONT class=ssmsg2><b>Choose a Layer</b></td></tr>
				<tr><td>
					<select name="IDAllLayers" id="IDAllLayers" multiple style="width:230px" size="10"><%=IDAllLayerOptions%></select>
					<br><br>
				</td></tr></table></td></tr><tr><td><TABLE cellpadding=1 cellspacing=1 border=0 width=100%><tr bgcolor=#cccccc><td align=center><FONT class=ssmsg2><b>Functions</b></font></td></tr><tr><td align=center>
					<%if request("Mode") <> "Reset" then%>
					<input type=button class=Btn onclick="submitit();" Value="Continue"><br><br>
					<%end if%>
					<%if Application("MenuStyle")="" then%>
					<a href="javascript:SetDefaultLayer();">Set as Default Layer(s)</a><br><span style="font-size:9px"><a href="javascript:DInst();">(default instructions)</a></span>
					<%end if%>
				<%end if%>
				</TD></TR></TABLE></td></tr></table>
			</center>	
		</FORM>
		<%elseif p = "2" then%>
		<script language='JavaScript' type='text/javascript' src="../js/layers.js"></script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>
		<script language='JavaScript' type='text/javascript'>

<%if trim(Session("IDAllDefLayers")) <> "" then%>

			prefix.positionLoadingLyr();

			var objWC = prefix.findObj("WhereClause")	//Selected coordinates for our ID All
			var objMF = prefix.findObj("MapFunction")	//Map function (21 = ID All)
			var objQL = prefix.findObj("QueryLayer")  //Layer(s) to do an ID All on
			var objZoomToFeature=prefix.findObj('ZoomToFeature');  //Zoom to the features?  (N)

			if (objWC!=null) {
				if (objZoomToFeature!=null) { objZoomToFeature.value='N'; }
				objQL.value='<%=trim(Session("IDAllDefLayers"))%>';
				objWC.value="<%=request("minX")%>,<%=request("maxX")%>,<%=request("minY")%>,<%=request("maxY")%>";
				objMF.value=21;

				prefix.RefreshMap();
			}
<%end if%>

			function ReSetDefaultLayer() {
				//Reset the default layer (i.e. clear it out)
				document.IDAllStep4.action="id_all.aspx?p=1&Mode=Reset&l="
				document.IDAllStep4.submit();
			}

			function sendValue(IDValue,QL,FN,E) {
				//Here the user wishes to highlight a feature by clicking on the "click here" link under the highlight column
				var objWC = prefix.findObj("WhereClause")	//Includes the x,y coordinates for the feature - makes processing faster
				var objFN = prefix.findObj("SAFieldName") //Usually #ID# - uniquely identify the individual feature
				var objMF = prefix.findObj("MapFunction") //18 = ID All and Search All feature highlight
				var objQL = prefix.findObj("QueryLayer")  // ID of layer we're working on.
				var objC = prefix.findObj("CustomIDAllColour")  // Colour to colour the feature 
				var objZoomToFeature=prefix.findObj('ZoomToFeature');  //Zoom to the features?  (N)

				if (objWC!=null) {
					if (objZoomToFeature!=null) { objZoomToFeature.value='N'; }
					prefix.positionLoadingLyr();
					objWC.value=IDValue + "~ENV~" + E;
					objFN.value=FN;
					objC.value=255;
					objQL.value=QL;
					objMF.value=18;
					prefix.RefreshMap();
				}
			}
			
			function PDetails(Value1) {
				//Parcel details link is avail. only if we're doing an ID All on the parcel layer
				prefix.url="";
				if (prefix.simpleGUI==1) {
					prefix.GoSimpleGUIiFrameRight("SS/parcel_details.aspx?APN=" + Value1);
				}else{
					t.fwinURL[3]="SS/parcel_details.aspx?APN=" + Value1;
					var obj=prefix.findObj("iFrameSSLayer",prefix.document); 
					prefix.ChangeiFrameURL(obj,"Parcel Details","yes",2);
				}
			}

			function calcHeight(o)	{
				//In case we have some iframes on our page, let's make sure they're all sized properly so no scroll bars show up.
				var the_height=document.getElementById(o).contentWindow.document.body.scrollHeight;//find the height of the internal page
				document.getElementById(o).style.height=the_height+20;//change the height of the iframe
			}

			prefix.positionLoadingLyr();
		</script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>
		<%=Information%>
		<FORM id="IDAllStep4" method="post" runat="server" target=_new>
		</FORM>
		&nbsp;<input type=button class=Btn onclick="window.print();" Value="Print">
		<%if Application("MenuStyle")="" then%>
		&nbsp;&nbsp;<input type=button class=BTN onclick="prefix.SSRefreshMap('IDAllclear',''); prefix.SetCurrTool(19,2);" value='Start Over'>
		<%end if%>
		<br><br>
		<%elseif p = "5" then%>
		<%=Information%>
		<%end if%>
	</BODY>
</HTML>
