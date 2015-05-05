<%@ Page Language="vb" AutoEventWireup="false" Codebehind="index.aspx.vb" Inherits="dotNETViewer.index"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<TITLE>Search</TITLE> 
		
		<LINK rel="stylesheet" type="text/css" href="../includes/CSS/CV.css">
		<SCRIPT type="text/javascript" SRC="../js/crimeviewer.js"></SCRIPT>
	</HEAD>
<body bgcolor="#FFFFFF">

<%If (Application("ClientName") = "SacCountyAssessor") Then%>

<!--
<FORM id="PrintForm" name="PrintForm" action="assessorprint.aspx" method=Post target=_new>
<input type=hidden name=TitleText value="<%=Application("PrintTitle")%>">
<input type=hidden name="Scale" value="">
<input type=hidden name="papersize" value="8.5_11">
</form>
<script language="Javascript">
document.PrintForm.submit();
</script>
-->
Your document will be reading for printing shortly...
<%else%>

<SCRIPT language='JavaScript' type='text/javascript'>

	function showTab(tabIndex)
	{
		if(activeTabIndex>=0){
			if(activeTabIndex==tabIndex)return;
			var obj = document.getElementById('tabTab'+activeTabIndex);
			obj.className='tabInactive';
			var img = obj.getElementsByTagName('IMG')[0];
			img.src = '../images/tab_right_inactive.gif';
			document.getElementById('tabView' + activeTabIndex).style.display='none';
		}
		
		var thisObj = document.getElementById('tabTab'+tabIndex);		
		thisObj.className='tabActive';
		var img = thisObj.getElementsByTagName('IMG')[0];
		img.src = '../images/tab_right_active.gif';
		document.getElementById('tabView' + tabIndex).style.display='block';
		activeTabIndex = tabIndex;
		

		var parentObj = thisObj.parentNode;
		var aTab = parentObj.getElementsByTagName('DIV')[0];
		countObjects = 0;
		var startPos = 2;
		var previousObjectActive = false;
		while(aTab){
			if(aTab.tagName=='DIV'){
				if(previousObjectActive){
					previousObjectActive = false;
					startPos-=2;
				}
				if(aTab==thisObj){
					startPos-=2;
					previousObjectActive=true;
					setPadding(aTab,textPadding+1);
				}else{
					setPadding(aTab,textPadding);
				}
				
				aTab.style.left = startPos + 'px';
				countObjects++;
				startPos+=2;
			}			
			aTab = aTab.nextSibling;
		}
		
		return;
	}
 
	function ACN(x,y,a,ac) {
		document.D.X.value=x;
		document.D.Y.value=y;
		document.D.SA.value=a;
		
		document.D.action=ac;
		document.D.submit();
	}
	
	function pmwin() {
		top.MapFrame.newwindow('MapPrint.aspx','height=50,width=200,status=yes,menubar=no,resizable=yes,tollbar=no,scrollbars=no','EDMapPrint')
	}

    top.EDPDUrl = '<%=Session("PropDetailsURL")%>';

	</script>
	
		<FORM id="PrintForm" action="PrintViewPDF.aspx" method=Post target=_blank>
			<center>
					
<!-- START OF PANE CODE -->

	<div id="geoprise_xpPane">
	<div class="geoprise_panel">
	<div>
	<br>
	<center>
	<div id="geoprise_tabView">
	<div class="geoprise_aTab">
	<table width="230" border=0 border-color="White" ID="Table3">
	<tr>
	<td>
			
			<div id=map_sub1 style='background:#FFFFFF;MARGIN-LEFT:0px;MARGIN-RIGHT:0px;width:230px'>
				<div id=map_mod2 style='color:#000000;PADDING-LEFT:10px;PADDING-RIGHT:10px;font-family:arial;font-weight:bold;font-size:9px'>
					<TABLE cellpadding=1 cellspacing=1 border=0 width=100% ID="Table2">
					<TR>
						<td colspan=2>&nbsp;</td>
					</TR>
					<TR>
						<TD><span style='color:#000000;padding-right:5px;font-family:arial;font-weight:bold;font-size:12px'><b>Map Title:</b></span></TD>
						<td><input type=text name=TitleText style='color:#000000;padding-right:5px;font-family:arial;font-weight:normal;font-size:12px' size=30 value="<%=Application("PrintTitle")%>" style="width:125px;" ID="Text1"></td>
					</TR>
					<TR>
						<td colspan=2>&nbsp;</td>
					</TR>
					<TR>
						<TD><span style='color:#000000;padding-right:5px;font-family:arial;font-weight:bold;font-size:12px'><b>Map Scale:</b></span></TD>
						<td>
							<select name="Scale" style='color:#000000;padding-right:5px;font-family:arial;font-weight:normal;font-size:12px;width:125px;'  ID="Select1">
								<option value="">Automatic</option>
								<!---<option value="Nearest">Nearest Standard Scale</option>--->
								<option value="25">1 inch = 25 feet</option>
								<option value="50">1 inch = 50 feet</option>
								<option value="100">1 inch = 100 feet</option>
								<option value="200">1 inch = 200 feet</option>
								<option value="400">1 inch = 400 feet</option>
								<option value="800">1 inch = 800 feet</option>
								<option value="1600">1 inch = 1600 feet</option>
								<option value="2640">1 inch = 0.5 mile</option>
								<option value="5280">1 inch = 1 mile</option>
								<option value="10560">1 inch = 2 mile</option>
								<option value="26400">1 inch = 5 mile</option>
								<option value="52800">1 inch = 10 mile</option>
							</select>
						</td>
					</TR>
				
					<TR>
						<td colspan=2>&nbsp;</td>
					</TR>
					
					<tr>
						<td><span style='color:#000000;padding-right:5px;font-family:arial;font-weight:bold;font-size:12px'><b>Map Size:</b></span></td>
						<td>
							<select name="paperSize" id="paperSize" style='color:#000000;padding-right:5px;font-family:arial;font-weight:normal;font-size:12px;width:125px;'>
								<option value="8.5_11">8.5&quot; x 11&quot; (Letter)</option>
								<!--<option value="8.5_14">8.5&quot; x 14&quot; (Legal)</option>-->
								<option value="11_17">11&quot; x 17&quot; (B size)</option>
							</select>
						</td>
					</tr>
					<TR>
						<td colspan=2>&nbsp;</td>
					</TR>
					<tr>
						<td colspan=2><span style='color:#000000;padding-right:5px;font-family:arial;font-weight:bold;font-size:12px'><b>Map Layout:</b></span></td>
					</tr>
					<tr>
						<td colspan=2><input id="portrait" type="radio" name="orientation" value="portrait" checked>&nbsp;<span style='color:#000000;padding-right:5px;font-family:arial;font-weight:normal;font-size:11px'>Portrait</span></td>
					</tr>
					<tr>
						<td colspan=2><input id="landscape" type="radio" name="orientation" value="landscape">&nbsp;<span style='color:#000000;padding-right:5px;font-family:arial;font-weight:normal;font-size:11px'>Landscape</span></td>
					</tr>
					<TR>
						<td colspan=2>&nbsp;</td>
					</TR>
					<tr>
						<td><span style='color:#000000;padding-right:5px;font-family:arial;font-weight:bold;font-size:12px'><b>Map Display:</b></td>
					</tr>
					<tr>
						<td colspan=2><input id="ShowOVMap" type="checkbox" name="ShowOVMap" checked value=1>&nbsp;<span style='color:#000000;padding-right:5px;font-family:arial;font-weight:normal;font-size:12px'>Display Overview Map (HTML Option)</span></td>
					</tr>
					<tr>
						<td colspan=2><input id="ShowLegend" type="checkbox" name="ShowLegend" checked value=1>&nbsp;<span style='color:#000000;padding-right:5px;font-family:arial;font-weight:normal;font-size:12px'>Display Legend (HTML Option)</span></td>
					</tr>
					<TR>
						<td colspan=2>&nbsp;</td>
					</TR>
					<tr>
						<td colspan=2 ><span style='color:#000000;padding-right:5px;font-family:arial;font-weight:bold;font-size:12px'><b>Map Output Type:</b></span></td>
					</tr>
					<TR>
						<td valign=top nowrap><input id="pdf_output" type="radio" name="map_output" value="pdf" checked>&nbsp;<span style='color:#000000;padding-right:5px;font-family:arial;font-weight:normal;font-size:11px'>PDF Format</span></td><td>&nbsp;<IMG src="../images/acro_logo1.gif">&nbsp;</td>
					</TR>
					<TR>
						<td valign=top nowrap><input id="html_output" type="radio" name="map_output" value="html">&nbsp;<span style='color:#000000;padding-right:5px;font-family:arial;font-weight:normal;font-size:11px'>HTML Format</span></td><td>&nbsp;<IMG src="../images/ie_logo1.gif">&nbsp;</td>
					</TR>
					<TR>
						<td colspan=2>&nbsp;</td>
					</TR>
					
					<TR>
						<td colspan=2><span style='color:#000000;color:red;padding-right:5px;font-family:arial;font-weight:bold;font-size:10px'>*Note: If you are using a "Pop-up Blocker", please disable it for this site.</span></td>
					</TR>
					<TR>
						<td colspan=2>&nbsp;</td>
					</TR>
					<TR>
						<td colspan=2 align=center>&nbsp;<input id=printPreview class=btn type="button"  value="Download Map" onclick="GenerateMap();" NAME="printPreview"></td>
					</TR>
					<TR>
						<td colspan=2>&nbsp;</td>
					</TR>
           
				</table>
			</div>
		</div>
		</td>
	</tr>
	</table>
	</div>
	</div>
	<br>
	</center>
	</div>		
	</div>
	</div>
	<script type="text/javascript">
	
	initTabs(Array('Print Options'),0,270,400);
	//initgeoprise_xpPane(Array('Search Wizard- Crime Details'),Array(true),Array('pane1'));
	
	</script>
		</center>
		
		<script>
		function GenerateMap() {
		
			if (document.forms[0].pdf_output.checked == true) {
				document.forms[0].action="printviewpdf.aspx"
				document.forms[0].submit();
			}
			else {
				document.forms[0].action="printview.aspx"
				document.forms[0].submit();
			}
		
			 
		}
		
		</script>
		
           
		</FORM>

<%end if%>

</body>
</html>