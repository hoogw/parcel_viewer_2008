<%@ Page Language="vb" AutoEventWireup="false" Codebehind="search_all_db.aspx.vb" Inherits="GeopriseApp.search_all_db"%>
<HTML>
	<HEAD>
		<title>search_all_db</title>
		<%
On Error Resume Next
%>
		<!--#include file="../includes/header.aspx"-->
	</HEAD>
	<body onload="<%=strOnLoad%>">
		<%if request("p") = "1" then%>
		<script language="javascript">
			function submitit() {
				if (document.SearchAllStep1.SearchAllTable.selectedIndex==-1) {
					alert ("Please select a DB table to proceed.");
					return;
				}
				
				if (document.SearchAllStep1.BLayer.selectedIndex==-1) {
					alert ("Please select a layer. When you are presented with DB results, you will be able to click on a button to highlight the specific feature.  This feature will reside on the layer you choose.")
					return;
				}
				if (document.SearchAllStep1.BFields.selectedIndex==-1) {
					alert ("Please select a field. This field in the DB must be an exact match to the field in the selected layer / field. E.g. Parcel DB table (field Parcel Number) -> Parcel Layer, APN field.")
					return;
				}
				
				top.MapFrame.positionLoadingLyr();

				document.SearchAllStep1.action="search_all_db.aspx?p=2&t=" + document.SearchAllStep1.SearchAllTable.options[document.SearchAllStep1.SearchAllTable.selectedIndex].value;
				document.SearchAllStep1.submit();
			}
			
		function AlterBFields() {
			if (document.SearchAllStep1.BLayer.selectedIndex<=0) {return;}
			var lyr=document.SearchAllStep1.BLayer.options[document.SearchAllStep1.BLayer.selectedIndex].value;
			var objBFieldsSpan=top.MapFrame.findObj("BFieldsSpan",document.SearchAllStep1);
			
			<%=BFieldsJS%>
		}

		</script>
		<form ID="SearchAllStep1" action="search_all_db.aspx?p=2" runat="server" method="post">
			<font class="SSMsg2">Please select which DB table you would like to query, along with the corresponding layer/unique field:</font><br>
			<br>
<table cellpadding=2 cellspacing=0>
<tr>
<td>
	<asp:ListBox ID="SearchAllTable" Rows="5" SelectionMode="Single" AutoPostBack="False" Runat="server" Width="200"></asp:ListBox>
</td>
	<TD align=left valign=top><select name="BLayer" onchange="AlterBFields();"><option value="">Select a Layer...</option><% response.write (SelectOptions)%></select></TD>
	<TD align=left valign=top><span id="BFieldsSpan"></span></TD>
</tr>
</table>
			<br>
			<br>
			<a href="javascript:submitit();"><img src="../images/<%=ColourScheme%>b_continue.gif" border="0"></a>
		</form>
		<%elseif request("p") = "2" then%>
		<script language="javascript">
				function submitit() {
					if (<%=JSIF%>) {
						alert ("Please fill out at least one of the search fields to proceed.");
						return;
					}
					
					if (<%=JSIF_radio%>) {
						alert ("Please select which DB column is the 'unique identifier' for records.");
						return;
					}
					
					top.MapFrame.positionLoadingLyr();
					document.SearchAllStep2.submit();
				}

		</script>
		<form name="SearchAllStep2" action="search_all_db.aspx?p=3" method="post">
			<%=Information%>
			<input type=hidden name=t value="<%=request("t")%>">
			<input type=hidden name=Lyr value="<%=request("BLayer")%>">
			<input type=hidden name=Fld value="<%=request("BFields")%>">
		</form>
		<%elseif request("p") = "3" then%>
		<script language="javascript">
			function sendValue (IDValue,QL) {

				var objWC = top.MapFrame.findObj("WhereClause")
				var objMF = top.MapFrame.findObj("MapFunction")
				var objQL = top.MapFrame.findObj("QueryLayer")
				var objZoomToFeature=top.MapFrame.findObj('ZoomToFeature'); 

				if (objWC!=null) {
					if (objZoomToFeature!=null) { objZoomToFeature.value='Y'; }
					top.MapFrame.positionLoadingLyr();
					objWC.value=IDValue; //xmin + "," + xmax + "," + ymin + "," + ymax;
					objMF.value=29;
					objQL.value=QL;
					top.MapFrame.RefreshMap();
				}
			}
		</script>
		<form name="Qry" method=post>
		<input type=hidden name="QueryString" value="<%=WE%>">
		</form>
		<%=Information%>
		<%end if%>
	</body>
</HTML>
