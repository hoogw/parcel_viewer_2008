<%@ Page aspcompat=true %>
<%@ Import Namespace=System.Data %>
<%@ Import Namespace=System.Data.SQLClient %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<title>DB Input Form</title>

<!--#include file="../includes/Header.aspx"-->

</head>

<script language="Javascript">

function go() {
	if (confirm("Please confirm that you wish to submit this data to the DB.")) {
		document.frmAPN.submit();
	}
}
</script>

<BODY class="colr" LEFTMARGIN="2" TOPMARGIN="0" RIGHTMARGIN="0" onload="top.MapFrame.hideLoadingLyr()">
<%if request.form("x")="" and request.form("y")="" then%>
	<form name="frmAPN"  method=post action="custom_service_request_integration.aspx">

	<font class="SSHdr1">Service Request Integration</font><br>
	<br>
	<%if request("E")<>"" then%>
	<font color=red><%=request("E")%></font><br>
	<%end if%>
	<table cellpadding=2 cellspacing=2 border=0>
	<tr><td><font class=sshdr2>X-Coord:</td><td><%=clng(request("minX"))%></font></td></tr>
	<tr><td><font class=sshdr2>Y-Coord:</td><td><%=clng(request("minY"))%></font></td></tr>
	<tr><td><font class=sshdr2>Service<br>Request #: </font></td><td><input type=text size=10 id=SRID name=SRID value=""></td></tr>
	</table>

	<br><center><input type=button onclick="go();" class=Btn Value="Submit"></center><br>
	<input type=hidden name=x value='<%=clng(request("minX"))%>'>
	<input type=hidden name=y value='<%=clng(request("minY"))%>'>
</form>
<%else%>

<%
    err.clear()
	on error resume next

    Dim myConnection As New SqlConnection("Initial Catalog=Servicerequest10102003;Server=sql2;User Id=gis;Password=gis;pooling=false;connection timeout=120;")
    Dim strSQL As String = "update sruser.ServiceRequest set X_Coord=" & request("X") & ", Y_Coord=" & request("Y") & " where requestID=" & request("SRID") & vbcrlf
    strSQL &= "select count(*) from sruser.ServiceRequest where requestID=" & request("SRID")
    Dim myCommand As New SqlCommand(strSQL)
        Dim pReader As SqlDataReader              'Provides a means of reading a forward-only stream of rows from a SQL Server database
	Dim TheNumber

    myCommand.Connection = myConnection
    myConnection.Open()
        pReader = myCommand.ExecuteReader

	pReader.read()
	if cint(pReader(0))<=0 then
		response.redirect ("custom_service_request_integration.aspx?minx=" & request("x") & "&miny=" & request("y") & "&E=That Service Request number does not exist!")
	end if
    myCommand.Connection.Close()
%>

	<font class="SSHdr1">Service Request Integration</font><br>
	<br>

	<%if err.number <>0 then%>
	<font class="ssHdr2">Error: <%=err.number%> - <%=err.description%></font>
	<%else%>
	<font class="ssHdr2">Record for Service Request # <%=request("SRID")%><br>successfully updated</font>
	<%end if%>
	<br><br>
<%end if%>
</body>
