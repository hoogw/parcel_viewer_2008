<%@ Page Language="vb" AutoEventWireup="false" Codebehind="index.aspx.vb" Inherits="dotNETViewer.index"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<TITLE>Search</TITLE> 
		<!--#include file="../includes/header.aspx"-->
	</HEAD>
<body>

<%If (Application("ClientName") = "SacCountyAssessor") Then%>
<FORM id="PrintForm" name="PrintForm" action="assessorprint.aspx" method=Post target=_new>
<input type=hidden name=TitleText value="<%=Application("PrintTitle")%>" ID="Hidden1">
<input type=hidden name="Scale" value="" ID="Hidden2">
<input type=hidden name="papersize" value="8.5_11" ID="Hidden3">
</form>
<script language="Javascript">
document.PrintForm.submit();


</script>

Your document will be reading for printing shortly...
<%else%>
		<script language="Javascript">

			function PrintView() {
				document.forms[0].action ="PrintView.aspx";
				return true;
			}
	
			function GeneratePDF() {
				document.forms[0].action ="PrintPDF.aspx";
				document.forms[0].submit();
				return true;
			}

		</script>

		<FORM id="PrintPreview" action="PrintView.aspx" method=Post target=_new>
		<TABLE cellpadding=1 cellspacing=1 border=0 width=100% ID="Table1">
			<TR>
				<TD align="center" class=tblhdr colspan=2>
						<b>Print Options</b>
				</TD>
			</TR>
			<TR>
				<TD colspan=2><hr></TD>
			</TR>
			<TR>
				<TD><span class="SSMsg2"><b>Title:</b></span></TD>
				<td><input type=text name=TitleText class=HTMLFrmObjects size=30 value="<%=Application("PrintTitle")%>" style="width:200px;" ID="Text1"></td>
			</TR>
			<TR>
				<TD><span class="SSMsg2"><b>Map Scale:</b></span></TD>
                  <td><select name="Scale" class=HTMLFrmObjects style="width:200px;" ID="Select1">
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
				</select></td>
			</TR>

               <tr>
                  <td class="promptNavy"><b>Paper Size:</b></td>
                  <td><select name="paperSize" id="paperSize" class=HTMLFrmObjects style="width:200px;">
						<option value="8.5_11">8.5&quot; x 11&quot; (Letter)</option>
						<option value="8.5_14">8.5&quot; x 14&quot; (Legal)</option>
						<option value="11_17">11&quot; x 17&quot; (B size)</option>
					</select></td>
               </tr>

				<tr><td>&nbsp;</td><td>&nbsp;</td></tr>
               <tr><td colspan="2" align=center >
<table class=borderw width=200 ID="Table2"><tr><td>
                  <table border="0" cellspacing="0" cellpadding="3" width=200 ID="Table3">
                     <tr>
                        <td colspan=2><b>Orientation:</b></td>
                     </tr>
                     <tr>
                        <td><input id="portrait" type="radio" name="orientation" value="portrait" checked>Portrait</td>
                        <td><input id="landscape" type="radio" name="orientation" value="landscape">Landscape</td>
                     </tr>
                  </table>
                  </td></tr></table>
               </td></tr>
				<tr><td>&nbsp;</td><td>&nbsp;</td></tr>
               <tr><td colspan="2" align=center>
<table class=borderw width=200 ID="Table4"><tr><td>
                  <table border="0" cellspacing="0" cellpadding="0" width=200 ID="Table5">
               <tr>
                  <td><b>Include:</b></td>
               </tr>
               <tr>
                  <td><input id="ShowOVMap" type="checkbox" name="ShowOVMap" checked value=1>Overview map</td>
               </tr>
               <tr>
                  <td><input id="ShowLegend" type="checkbox" name="ShowLegend" checked value=1>Legend</td>
               </tr>
            </table>
                  </td></tr></table>
                  </td></tr>
				<tr><td>&nbsp;</td><td>&nbsp;</td></tr>
                  </table>
            <hr>
            <center>
            <input id="Submit1" ONCLICK="return PrintView();"  type="submit" class=btn value="Print Preview... (pop-up)" NAME="printPreview">
            </center>
            <br>
            <center>
            <input id="Generate_PDF" ONCLICK="return GeneratePDF();" type="button" class=btn value="Generate PDF... (pop-up)" NAME="Generate_PDF">
            </center>
		</FORM>
		

<%end if%>

</body>
</html>