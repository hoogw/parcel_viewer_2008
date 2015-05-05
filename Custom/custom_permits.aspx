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
			
			document.pesubmit.PNOpr.value=document.frmDB.PNOpr.value;
			document.pesubmit.ANOpr.value=document.frmDB.ANOpr.value;
			document.pesubmit.PermitNumber.value=document.frmDB.PermitNumber.value;
			document.pesubmit.ApplicationNumber.value=document.frmDB.ApplicationNumber.value;
			document.pesubmit.V1.value=document.frmDB.V1.value;
			document.pesubmit.V2.value=document.frmDB.V2.value;
			document.pesubmit.WorkDescription.value=document.frmDB.WorkDescription.value;

document.pesubmit.IssuedDateStart.value=document.frmDB.IssuedDateStartMonth.value + '/' + document.frmDB.IssuedDateStartDay.value + '/' + document.frmDB.IssuedDateStartYear.value;
document.pesubmit.IssuedDateEnd.value=document.frmDB.IssuedDateEndMonth.value + '/' + document.frmDB.IssuedDateEndDay.value + '/' + document.frmDB.IssuedDateEndYear.value;
document.pesubmit.FinaledDateStart.value=document.frmDB.FinaledDateStartMonth.value + '/' + document.frmDB.FinaledDateStartDay.value + '/' + document.frmDB.FinaledDateStartYear.value;
document.pesubmit.FinaledDateEnd.value=document.frmDB.FinaledDateEndMonth.value + '/' + document.frmDB.FinaledDateEndDay.value + '/' + document.frmDB.FinaledDateEndYear.value;

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
session("DBTbl")="vPermitSQL"
''''''''''''''''''''''''''''''''''''''''''

session("StartOverASP")=Request.Url.ToString
%>
<script language='JavaScript' type='text/javascript'>
var undef, prefix, prefixTop
if (top.opener!=undef){prefix=top.opener.top.MapFrame; }else{if (opener==undef) {prefix=top.MapFrame;}else{prefix=opener.top.MapFrame;}}
prefixTop=top;
</script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>

<body class="colr" leftmargin="5" onload="prefix.hideLoadingLyr();">

<FORM name="frmDB" action="custom_permits_process.aspx" method=post target=_new>

<font class='sshdr1'>
Please enter the following information</font><br><br>
<table cellpadding=0 cellspacing=0 border=0 width=90%>
<tr><td width=7>&nbsp;</td><td ><font class=SSLbl1>Permit #:</font></td><td align=left ><select id="PNOpr" style='width:75px;'><OPTION value=" = ">=</OPTION><option value=" < ">&lt;</option><option value=" > ">&gt;</option><option value=" <= ">&lt;=</option><option value=" >= ">&gt;=</option><option selected value=" LIKE ">LIKE</option></select>&nbsp;<input type=text id="PermitNumber" style='width:100px;'></td></tr>
<tr><td width=7>&nbsp;</td><td ><font class=SSLbl1>Application #:</font></td><td align=left ><select id="ANOpr" style='width:75px;'><OPTION value=" = ">=</OPTION><option value=" < ">&lt;</option><option value=" > ">&gt;</option><option value=" <= ">&lt;=</option><option value=" >= ">&gt;=</option><option selected value=" LIKE ">LIKE</option></select>&nbsp;<input type=text id="ApplicationNumber" style='width:100px;'></td></tr>

<tr><td width=7>&nbsp;</td><td ><font class=SSLbl1>Work Type:</font></td><td align=left >
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

	strSQL="SELECT DISTINCT WORK_TYPE from vPermitSQL order by WORK_TYPE"	
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
					'response.write (" selected ")
				end if
				response.write (">" & thisvalue & "</option>")
			End If
		end if
	next

%>
</select>
</td></tr>
<tr><td colspan=3>&nbsp;</td></tr>
<%
dim d as integer
dim y as integer
dim m as integer
%>
<tr valign=top><td width=7>&nbsp;</td><td ><font class=SSLbl1>Date Issued<br>(Start Range):</font></td><td align=left colspan=2>
<select class=HTMLFrmObjects ID="IssuedDateStartMonth">
<%

response.write ("<option value=''></option>")
for m = 1 to 12
	response.write ("<option value='" & m & "' ")
	if format(now(),"MM")=format(m,"0#") then
		'response.write (" selected ")
	end if
	response.write (">" & format (m,"0#") & "</option>")
next
%>
</select>

<select class=HTMLFrmObjects ID="IssuedDateStartDay">
<%

response.write ("<option value=''></option>")
for d = 1 to 31
	response.write ("<option value='" & d & "' ")
	if format(now(),"dd")=format(d,"0#") then
		'response.write (" selected ")
	end if
	response.write (">" & format (d,"0#") & "</option>")
next
%>
</select>

<select class=HTMLFrmObjects ID="IssuedDateStartYear">
<%

response.write ("<option value=''></option>")
for y = 2000 to 2050
	response.write ("<option value='" & y & "' ")
	if format(now(),"yyyy")=format(y,"####") then
		'response.write (" selected ")
	end if
	response.write (">" & format (y,"####") & "</option>")
next
%>
</select>

</td></tr>
<tr><td colspan=3>&nbsp;</td></tr>
<tr valign=top><td width=7>&nbsp;</td><td ><font class=SSLbl1>Date Issued<br>(End Range):</font></td><td align=left colspan=2>
<select class=HTMLFrmObjects ID="IssuedDateEndMonth">
<%

response.write ("<option value=''></option>")
for m = 1 to 12
	response.write ("<option value='" & m & "' ")
	if format(now(),"MM")=format(m,"0#") then
		'response.write (" selected ")
	end if
	response.write (">" & format (m,"0#") & "</option>")
next
%>
</select>

<select class=HTMLFrmObjects ID="IssuedDateEndDay">
<%

response.write ("<option value=''></option>")
for d = 1 to 31
	response.write ("<option value='" & d & "' ")
	if format(now(),"dd")=format(d,"0#") then
		'response.write (" selected ")
	end if
	response.write (">" & format (d,"0#") & "</option>")
next
%>
</select>

<select class=HTMLFrmObjects ID="IssuedDateEndYear">
<%

response.write ("<option value=''></option>")
for y = 2000 to 2050
	response.write ("<option value='" & y & "' ")
	if format(now(),"yyyy")=format(y,"####") then
		'response.write (" selected ")
	end if
	response.write (">" & format (y,"####") & "</option>")
next
%>
</select>
</td></tr>

<tr><td colspan=3>&nbsp;</td></tr>
<tr valign=top><td width=7>&nbsp;</td><td ><font class=SSLbl1>Date Finaled<br>(Start Range):</font></td><td align=left colspan=2>
<select class=HTMLFrmObjects ID="FinaledDateStartMonth">
<%

response.write ("<option value=''></option>")
for m = 1 to 12
	response.write ("<option value='" & m & "' ")
	if format(now(),"MM")=format(m,"0#") then
		'response.write (" selected ")
	end if
	response.write (">" & format (m,"0#") & "</option>")
next
%>
</select>

<select class=HTMLFrmObjects ID="FinaledDateStartDay">
<%

response.write ("<option value=''></option>")
for d = 1 to 31
	response.write ("<option value='" & d & "' ")
	if format(now(),"dd")=format(d,"0#") then
		'response.write (" selected ")
	end if
	response.write (">" & format (d,"0#") & "</option>")
next
%>
</select>

<select class=HTMLFrmObjects ID="FinaledDateStartYear">
<%

response.write ("<option value=''></option>")
for y = 2000 to 2050
	response.write ("<option value='" & y & "' ")
	if format(now(),"yyyy")=format(y,"####") then
		'response.write (" selected ")
	end if
	response.write (">" & format (y,"####") & "</option>")
next
%>
</select></td></tr>
<tr><td colspan=3>&nbsp;</td></tr>
<tr valign=top><td width=7>&nbsp;</td><td ><font class=SSLbl1>Date Finaled<br>(End Range):</font></td><td align=left colspan=2>
<select class=HTMLFrmObjects ID="FinaledDateEndMonth">
<%

response.write ("<option value=''></option>")
for m = 1 to 12
	response.write ("<option value='" & m & "' ")
	if format(now(),"MM")=format(m,"0#") then
		'response.write (" selected ")
	end if
	response.write (">" & format (m,"0#") & "</option>")
next
%>
</select>

<select class=HTMLFrmObjects ID="FinaledDateEndDay">
<%

response.write ("<option value=''></option>")
for d = 1 to 31
	response.write ("<option value='" & d & "' ")
	if format(now(),"dd")=format(d,"0#") then
		'response.write (" selected ")
	end if
	response.write (">" & format (d,"0#") & "</option>")
next
%>
</select>

<select class=HTMLFrmObjects ID="FinaledDateEndYear">
<%

response.write ("<option value=''></option>")
for y = 2000 to 2050
	response.write ("<option value='" & y & "' ")
	if format(now(),"yyyy")=format(y,"####") then
		'response.write (" selected ")
	end if
	response.write (">" & format (y,"####") & "</option>")
next
%>
</select></td></tr>

<tr><td width=7>&nbsp;</td><td ><font class=SSLbl1>Permit Valuation<br>(Range):</font></td><td align=left ><input type=text class=HTMLFrmObjects name="V1" id=V1 style='width:70px;' >&nbsp;<input type=text class=HTMLFrmObjects name="V2" id=V2 style='width:70px;' ></td></tr>

</table><br><center><input type=button class=Btn onclick='submitit();' Value='Continue'>&nbsp;<input type=reset class=btn value="Reset"><!---&nbsp;&nbsp;&nbsp;<input type=button class=Btn onclick="document.location='<%=session("StartOverASP")%>'" Value='Start Over'>---></center><br>
</form>

<FORM name="pesubmit" action="custom_permits_process.aspx" method=post target=_new>

	<input type=hidden name="PermitNumber" value="<%=request("PermitNumber")%>">
	<input type=hidden name="ApplicationNumber" value="<%=request("ApplicationNumber")%>">
	<input type=hidden name="WorkDescription" value="<%=request("WorkDescription")%>">
	<input type=hidden name="V1" value="<%=request("V1")%>">
	<input type=hidden name="V2" value="<%=request("V2")%>">
	<input type=hidden name="PNOpr" value="<%=trim(request("PNOpr"))%>">
	<input type=hidden name="ANOpr" value="<%=trim(request("ANOpr"))%>">
	<input type=hidden name="IssuedDateStart" >
	<input type=hidden name="IssuedDateEnd" >
	<input type=hidden name="FinaledDateStart" >
	<input type=hidden name="FinaledDateEnd">
	<input type=hidden name=SA value=1>
</FORM>

</body>
