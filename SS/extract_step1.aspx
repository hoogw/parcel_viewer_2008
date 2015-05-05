<%@ Page Language="vb" AutoEventWireup="false" Codebehind="extract_step1.aspx.vb" Inherits="dotNETViewer.extract_step1"%>
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
'	The purpose of this page is to provide the HTML interface to the first step of feature extracting.  
'
'************************************************************************************************************************************
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<TITLE>Feature Extraction Step 1</TITLE> 
		<!--#include file="../includes/header.aspx"-->
	</HEAD>
	
	<script language='JavaScript' type='text/javascript'>
		function ExProcess() {
			
			if (document.ex1.SelectBy.selectedIndex==0) {
				alert ("Please identify how you would like to select features");
				return;
			}

			<%if StartDate.SelectedDate <> "#12:00:00 AM#" then %>
				var StartDate=new Date("<%=Format(StartDate.selectedDate,"MM/dd/yyyy")%>");
			<%else%>
				var StartDate=new Date("01/01/1900");
				//alert ("Please enter a valid Start Date");
				//return;
			<%end if%>
			<%if EndDate.SelectedDate <> "#12:00:00 AM#" then %>
				var EndDate=new Date("<%=Format(EndDate.selectedDate,"MM/dd/yyyy")%>");
			<%else%>
				var EndDate=new Date("01/01/2500");
				//alert ("Please enter a valid End Date");
				//return;
			<%end if%>
			//if (document.pesubmit.StartDate.value=="01/01/1900") {
			//	alert("Please select a Start Date.");
			//	return;
			//}
			//if (document.pesubmit.EndDate.value=="01/01/2500") {
			//	alert("Please select a End Date.");
			//	return;
			//}
			document.pesubmit.selectby.value=document.ex1.SelectBy.options[document.ex1.SelectBy.selectedIndex].value;
			document.pesubmit.status.value=document.ex1.Status.options[document.ex1.Status.selectedIndex].value;

			top.HaltLYRHide=1;
			top.MapFrame.positionLoadingLyr();
			if (document.ex1.SelectBy.options[document.ex1.SelectBy.selectedIndex].value=='Polygon') {
				document.pesubmit.action="extract_userdefined.aspx";
				document.pesubmit.submit();
			} else {
				document.pesubmit.action="extract_userdefined.aspx?s=" + document.pesubmit.selectby.value;
				document.pesubmit.submit();
			}
		}

		function Instr() { 
			top.fwinURL[0]="SS/extract_instructions.aspx"; 
			var objTMP=top.MapFrame.findObj("iFramecontactinfoLayer",top.MapFrame.document); 
			top.MapFrame.ChangeiFrameURL(objTMP,"","yes",1); 
		}
		
	</script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>
	
	<BODY>
		<table cellpadding=0 cellspacing=0 border=0 width=100%><tr><TD align="center" bgcolor="#bbbbbb"><b>Feature Extraction Step 1</b></td></tr>
        <tr><td align=center><a href='javascript:Instr();'>Instructions</a></td></tr>
		</table>
		<hr color=black>

		<center><FORM name="ex1" id="ex1" runat=server method="post">
		<TABLE cellpadding=0 cellspacing=0 border=1 bordercolor=black width=250>
		<TR><TD><TABLE cellpadding=1 cellspacing=1 border=0 width=250><tr bgcolor=#cccccc><td align=center><FONT class=ssmsg2><b>Select By</b></td></tr><tr><td>
		<asp:DropDownList cssclass=HTMLFrmObjects  ID="SelectBy" AutoPostBack=True Runat=server style="width:240px;"></asp:DropDownList>
		</TD></TR></td></tr></table></td></tr><tr><td><TABLE cellpadding=1 cellspacing=1 border=0 width=250><tr bgcolor=#cccccc><td align=center><FONT class=ssmsg2><b>Start Date</b></font></td></tr><tr><td align=center>
		<asp:DropDownList cssclass=HTMLFrmObjects  ID="StartYear" Runat=server AutoPostBack=True Visible=True></asp:DropDownList>
		<asp:Calendar ID="StartDate" TitleFormat=Month TitleStyle-ForeColor=#FFFFFF DayStyle-BackColor=#eeeeee BorderWidth=2 TitleStyle-BorderWidth=2 OtherMonthDayStyle-BackColor=#808080 SelectedDayStyle-BackColor=#990000 TodayDayStyle-ForeColor=#000000  ShowGridLines=true BackColor=#ffffff BorderColor=#000000 TitleStyle-Font-Bold=True DayStyle-Font-Size=9px DayStyle-BorderColor=#aaaaaa DayHeaderStyle-Font-Size=9px NextPrevStyle-ForeColor=#ffffff NextPrevStyle-Font-Size=10px DayHeaderStyle-BackColor=#aaaaaa TitleStyle-BackColor=#777777 Width=100px Height=100px Runat=server Visible=True></asp:Calendar>
		</TD></TR></td></tr></table></td></tr><tr><td><TABLE cellpadding=1 cellspacing=1 border=0 width=250><tr bgcolor=#cccccc><td align=center><FONT class=ssmsg2><b>End Date</b></font></td></tr><tr><td align=center>
		<asp:DropDownList cssclass=HTMLFrmObjects  ID="EndYear" Runat=server AutoPostBack=True Visible=True></asp:DropDownList>
		<asp:Calendar ID="EndDate" TitleFormat=Month TitleStyle-ForeColor=#FFFFFF DayStyle-BackColor=#eeeeee BorderWidth=2 TitleStyle-BorderWidth=2 OtherMonthDayStyle-BackColor=#808080 SelectedDayStyle-BackColor=#990000 TodayDayStyle-ForeColor=#000000  ShowGridLines=true BackColor=#ffffff BorderColor=#000000 TitleStyle-Font-Bold=True DayStyle-Font-Size=9px DayStyle-BorderColor=#aaaaaa DayHeaderStyle-Font-Size=9px NextPrevStyle-ForeColor=#ffffff NextPrevStyle-Font-Size=10px DayHeaderStyle-BackColor=#aaaaaa TitleStyle-BackColor=#777777 Width=100px Height=100px Runat=server Visible=True></asp:Calendar>
		</TD></TR></td></tr></table></td></tr><tr><td><TABLE cellpadding=1 cellspacing=1 border=0 width=250><tr bgcolor=#cccccc><td align=center><FONT class=ssmsg2><b>Status</b></font></td></tr><tr><td>
		<asp:DropDownList cssclass=HTMLFrmObjects  ID="Status" AutoPostBack=True Runat=server style="width:240px;"></asp:DropDownList>
		</td></tr></table></td></tr><tr><td><TABLE cellpadding=1 cellspacing=1 border=0 width=250><tr bgcolor=#cccccc><td align=center><FONT class=ssmsg2><b>Functions</b></font></td></tr><TR><TD align=center><br><input type=button class=Btn onclick="ExProcess();" value="Continue"><br></FORM>

		<FORM name="pesubmit" method="post">
			<%if StartDate.SelectedDate <> "#12:00:00 AM#" then %>
				<input type=hidden name="StartDate" value="<%=Format(StartDate.selectedDate,"MM/dd/yyyy")%>">
			<%else%>
				<input type=hidden name="StartDate" value="01/01/1900">
			<%end if%>
			<%if EndDate.SelectedDate <> "#12:00:00 AM#" then %>
				<input type=hidden name="EndDate" value="<%=Format(EndDate.selectedDate,"MM/dd/yyyy")%>">
			<%else%>
				<input type=hidden name="EndDate" value="01/01/2500">
			<%end if%>

			<input type="hidden" name="selectby"> 
			<input type="hidden" name="status">
		</FORM>		
		
	</BODY>
</HTML>
