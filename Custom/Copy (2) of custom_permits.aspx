<%@ Page aspcompat=true %>
<%@ Import Namespace=System.Data %>
<%@ Import Namespace=System.Data.OleDB %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<title>DB Input Form</title>

<!--#include file="../includes/Header.aspx"-->

</head>

<script language="Javascript">

	function submitit() {
		//This function handles validation of form fields - for example to see if the selected dates are valid, etc.
			<%dim ErrorCount=0%>
			<%if ErrorCount= 1 then %>
				alert ('There is an error on the form.\nFor some reason, one of the drop downs is not populated with data.\n<%=Application("ContactSentence")%>');
			<%else%>
			<%if IssuedDateStart.SelectedDate <> "#12:00:00 AM#" then %>
				var IssuedDateStart=new Date("<%=Format(IssuedDateStart.selectedDate,"MM/dd/yyyy")%>");
			<%else%>
				var IssuedDateStart=new Date("01/01/1900");
			<%end if%>
			
			<%if IssuedDateEnd.SelectedDate <> "#12:00:00 AM#" then %>
				var IssuedDateEnd=new Date("<%=Format(IssuedDateEnd.selectedDate,"MM/dd/yyyy")%>");
			<%else%>
				var IssuedDateEnd=new Date("01/01/1900");
			<%end if%>
			<%if FinaledDateStart.SelectedDate <> "#12:00:00 AM#" then %>
				var FinaledDateStart=new Date("<%=Format(FinaledDateStart.selectedDate,"MM/dd/yyyy")%>");
			<%else%>
				var FinaledDateStart=new Date("01/01/2500");
			<%end if%>
			
			if (IssuedDateStart>IssuedDateEnd) {
				alert ("Issue End Date (" + IssuedDateStart.toDateString() + ") cannot be before the Begin Date (" + IssuedDateEnd.toDateString() + ")");
				return;
			}
			if (FinaledDateStart>FinaledDateEnd) {
				alert ("Final End Date (" + FinaledDateStart.toDateString() + ") cannot be before the Begin Date (" + FinaledDateEnd.toDateString() + ")");
				return;
			}
			
			document.pesubmit.PNOpr.value=document.frmDB.PNOpr.value;
			document.pesubmit.ANOpr.value=document.frmDB.ANOpr.value;
			document.pesubmit.PermitNumber.value=document.frmDB.PermitNumber.value;
			document.pesubmit.ApplicationNumber.value=document.frmDB.ApplicationNumber.value;
			document.pesubmit.V1.value=document.frmDB.V1.value;
			document.pesubmit.V2.value=document.frmDB.V2.value;

			document.pesubmit.submit();
			<%end if%>
	}

</script>

<%
'Important''''''''''''''''''''''''''''''''
session("lyr")="id_permits"
session("Fld_DB")="PERMIT_NUMBER"
session("Fld_SHP")="PERMITNUMB"
session("Fld_DBNAMES")="APPLICATION_NUMBER,PERMIT_NUMBER,PROJECT,APN,PERMIT_STATUS,TOTAL_FEE,VALUATION,APPLICATION_DATE,ISSUED_DATE,FINALED_DATE,WORK_TYPE,WORK_DESCRIPTION,RES_COMM,ADDRESS_ID,PREFIX_TYPE,PREFIX_DIR,ST_NUMBER,ST_NAME,ST_TYPE,SUFFIX_DIR,CITY,ZIP,FULL_ADDRESS,ADDR_FRACTION,UNIT_DESIGNATION,UNIT,FLOOR,BUILDING,"
session("ds")="Provider=SQLOLEDB.1;Initial Catalog=PermitSQL;Server=sql2;User Id=gis;Password=gis;pooling=false;connection timeout=120;"
session("DBTbl")="PermitSQL"
''''''''''''''''''''''''''''''''''''''''''

session("StartOverASP")=Request.Url.ToString
%>
<script language='JavaScript' type='text/javascript'>
var undef, prefix, prefixTop
if (top.opener!=undef){prefix=top.opener.top.MapFrame; }else{if (opener==undef) {prefix=top.MapFrame;}else{prefix=opener.top.MapFrame;}}
prefixTop=top;
</script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>

<body class="colr" leftmargin="5" onload="prefix.hideLoadingLyr();">

<form id="frmDB" action="custom_permits_process.aspx" method=post runat=server>

<font class='sshdr1'>
Please enter the following information</font><br><br>
<table cellpadding=0 cellspacing=0 border=0 width=90%>
<tr><td width=7>&nbsp;</td><td ><font class=SSLbl1>Permit #:</font></td><td align=left ><select id="PNOpr" style='width:75px;' runat=server><OPTION value=" = ">=</OPTION><option value=" < ">&lt;</option><option value=" > ">&gt;</option><option value=" <= ">&lt;=</option><option value=" >= ">&gt;=</option><option selected value=" LIKE ">LIKE</option></select>&nbsp;<input type=text id="PermitNumber" style='width:100px;' runat=server></td></tr>
<tr><td width=7>&nbsp;</td><td ><font class=SSLbl1>Application #:</font></td><td align=left ><select id="ANOpr" style='width:75px;' runat=server><OPTION value=" = ">=</OPTION><option value=" < ">&lt;</option><option value=" > ">&gt;</option><option value=" <= ">&lt;=</option><option value=" >= ">&gt;=</option><option selected value=" LIKE ">LIKE</option></select>&nbsp;<input type=text id="ApplicationNumber" style='width:100px;' runat=server></td></tr>

<tr><td width=7>&nbsp;</td><td ><font class=SSLbl1>Work Description:</font></td><td align=left >
<select name="WorkDescription" id="WorkDescription"><option value=''>Please select...</option>
<%

    dim strSQL as string
    Dim pConn As OleDbConnection
    Dim pAdapter As OleDbDataAdapter
    dim tmpDS
    Dim i
    Dim thisvalue
    Dim DS, DT, nRecCount 

    If InStr(UCase(session("ds")), "PROVIDER") > 0 Then
        tmpDS = session("ds")
    Else
        tmpDS = "Provider=SQLOLEDB.1;" & session("ds")
    End If

    pConn = New OleDbConnection(tmpDS)
    pConn.Open()

	if cint(err.number)<>0 or cstr(err.description) <> "" then
		response.write ("Error with DB Connection String: " & cint(err.number) & " - " & cstr(err.description) & "<br>")
		response.write ("<SCRIPT LANGUAGE='JavaScript' TYPE='text/javascript'>prefixTop.HaltLYRHide=0; prefix.hideLoadingLyr();</script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>")
		response.end
	end if

	strSQL="SELECT DISTINCT WORK_DESCRIPTION from PermitSQL order by WORK_DESCRIPTION"	
	pAdapter = New OleDbDataAdapter(strSQL,pConn)

	DS = New DataSet
	pAdapter.Fill(DS)

	DT = DS.Tables(0)

	nRecCount = DT.Rows.Count

	If nRecCount = 0 Then
		response.write ("Error filling work description drop down...")
		Response.End 
	End If

	for i = 0 to DT.Rows.count-1
		if isDBNull(DT.Rows(i)(0))=false then
			thisvalue = Trim(CStr(DT.Rows(i)(0)))
			If Trim(thisvalue) = "" Then
			Else
				response.write ("<option value='" & thisvalue & "' ")
				if trim(ucase(thisvalue))=trim(ucase(request("WORKDESCRIPTION"))) then
					response.write (" selected ")
				end if
				response.write (">" & thisvalue & "</option>")
			End If
		end if
	next

%>
</select>
</td></tr>
<tr><td colspan=3>&nbsp;</td></tr>


<tr valign=top><td width=7>&nbsp;</td><td ><font class=SSLbl1>Date Issued<br>(Start Range):</font></td><td align=left colspan=2>
<asp:Calendar ID="IssuedDateStart" TitleFormat=Month TitleStyle-ForeColor=#FFFFFF DayStyle-BackColor=#eeeeee BorderWidth=2 TitleStyle-BorderWidth=2 OtherMonthDayStyle-BackColor=#808080 SelectedDayStyle-BackColor=#990000 TodayDayStyle-ForeColor=#000000  ShowGridLines=true BackColor=#ffffff BorderColor=#000000 TitleStyle-Font-Bold=True DayStyle-Font-Size=9px DayStyle-BorderColor=#aaaaaa DayHeaderStyle-Font-Size=9px NextPrevStyle-ForeColor=#ffffff NextPrevStyle-Font-Size=10px DayHeaderStyle-BackColor=#aaaaaa TitleStyle-BackColor=#777777 px Height=100px Runat=server Visible=true></asp:Calendar>
</td></tr>
<tr><td colspan=3>&nbsp;</td></tr>
<tr valign=top><td width=7>&nbsp;</td><td ><font class=SSLbl1>Date Issued<br>(End Range):</font></td><td align=left colspan=2>
<asp:Calendar ID="IssuedDateEnd" TitleFormat=Month TitleStyle-ForeColor=#FFFFFF DayStyle-BackColor=#eeeeee BorderWidth=2 TitleStyle-BorderWidth=2 OtherMonthDayStyle-BackColor=#808080 SelectedDayStyle-BackColor=#990000 TodayDayStyle-ForeColor=#000000  ShowGridLines=true BackColor=#ffffff BorderColor=#000000 TitleStyle-Font-Bold=True DayStyle-Font-Size=9px DayStyle-BorderColor=#aaaaaa DayHeaderStyle-Font-Size=9px NextPrevStyle-ForeColor=#ffffff NextPrevStyle-Font-Size=10px DayHeaderStyle-BackColor=#aaaaaa TitleStyle-BackColor=#777777 px Height=100px Runat=server Visible=true></asp:Calendar>
</td></tr>

<tr><td colspan=3>&nbsp;</td></tr>
<tr valign=top><td width=7>&nbsp;</td><td ><font class=SSLbl1>Date Finaled<br>(Start Range):</font></td><td align=left colspan=2>
<asp:Calendar ID="FinaledDateStart" TitleFormat=Month TitleStyle-ForeColor=#FFFFFF DayStyle-BackColor=#eeeeee BorderWidth=2 TitleStyle-BorderWidth=2 OtherMonthDayStyle-BackColor=#808080 SelectedDayStyle-BackColor=#990000 TodayDayStyle-ForeColor=#000000  ShowGridLines=true BackColor=#ffffff BorderColor=#000000 TitleStyle-Font-Bold=True DayStyle-Font-Size=9px DayStyle-BorderColor=#aaaaaa DayHeaderStyle-Font-Size=9px NextPrevStyle-ForeColor=#ffffff NextPrevStyle-Font-Size=10px DayHeaderStyle-BackColor=#aaaaaa TitleStyle-BackColor=#777777 px Height=100px Runat=server Visible=true></asp:Calendar>
</td></tr>
<tr><td colspan=3>&nbsp;</td></tr>
<tr valign=top><td width=7>&nbsp;</td><td ><font class=SSLbl1>Date Finaled<br>(End Range):</font></td><td align=left colspan=2>
<asp:Calendar ID="FinaledDateEnd" TitleFormat=Month TitleStyle-ForeColor=#FFFFFF DayStyle-BackColor=#eeeeee BorderWidth=2 TitleStyle-BorderWidth=2 OtherMonthDayStyle-BackColor=#808080 SelectedDayStyle-BackColor=#990000 TodayDayStyle-ForeColor=#000000  ShowGridLines=true BackColor=#ffffff BorderColor=#000000 TitleStyle-Font-Bold=True DayStyle-Font-Size=9px DayStyle-BorderColor=#aaaaaa DayHeaderStyle-Font-Size=9px NextPrevStyle-ForeColor=#ffffff NextPrevStyle-Font-Size=10px DayHeaderStyle-BackColor=#aaaaaa TitleStyle-BackColor=#777777 px Height=100px Runat=server Visible=true></asp:Calendar>
</td></tr>

<tr><td width=7>&nbsp;</td><td ><font class=SSLbl1>Permit Valuation<br>(Range):</font></td><td align=left ><input type=text name="V1" id=V1 style='width:70px;' runat=server>&nbsp;<input type=text name="V2" id=V2 style='width:70px;' runat=server></td></tr>

</table><br><center><input type=button class=Btn onclick='submitit();' Value='Continue'><!---&nbsp;&nbsp;&nbsp;<input type=button class=Btn onclick="document.location='<%=session("StartOverASP")%>'" Value='Start Over'>---></center><br>
<input type=hidden name=SA value=1>
</form>

<FORM name="pesubmit" action="custom_permits_process.aspx" method=post target=_new>

	<input type=hidden name="PermitNumber" value="<%=request("PermitNumber")%>">
	<input type=hidden name="ApplicationNumber" value="<%=request("ApplicationNumber")%>">
	<input type=hidden name="WorkDescription" value="<%=request("WorkDescription")%>">
	<input type=hidden name="V1" value="<%=request("V1")%>">
	<input type=hidden name="V2" value="<%=request("V2")%>">
	<input type=hidden name="PNOpr" value="<%=trim(request("PNOpr"))%>">
	<input type=hidden name="ANOpr" value="<%=trim(request("ANOpr"))%>">

	<%if IssuedDateStart.SelectedDate <> "#12:00:00 AM#" then %>
		<input type=hidden name="IssuedDateStart" value="<%=Format(IssuedDateStart.selectedDate,"MM/dd/yyyy")%>">
	<%else%>
		<input type=hidden name="IssuedDateStart" value="01/01/1900">
	<%end if%>

	<%if IssuedDateEnd.SelectedDate <> "#12:00:00 AM#" then %>
		<input type=hidden name="IssuedDateEnd" value="<%=Format(IssuedDateEnd.selectedDate,"MM/dd/yyyy")%>">
	<%else%>
		<input type=hidden name="IssuedDateEnd" value="01/01/1900">
	<%end if%>

	<%if FinaledDateStart.SelectedDate <> "#12:00:00 AM#" then %>
		<input type=hidden name="FinaledDateStart" value="<%=Format(FinaledDateStart.selectedDate,"MM/dd/yyyy")%>">
	<%else%>
		<input type=hidden name="FinaledDateStart" value="01/01/1900">
	<%end if%>

	<%if FinaledDateEnd.SelectedDate <> "#12:00:00 AM#" then %>
		<input type=hidden name="FinaledDateEnd" value="<%=Format(FinaledDateEnd.selectedDate,"MM/dd/yyyy")%>">
	<%else%>
		<input type=hidden name="FinaledDateEnd" value="01/01/1900">
	<%end if%>
</FORM>

</body>
