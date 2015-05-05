<%

on error resume next

	dim uid,pwd,url

	url= System.Configuration.ConfigurationSettings.AppSettings("SIREURL")
	uid= System.Configuration.ConfigurationSettings.AppSettings("SIREUserName")
	pwd= System.Configuration.ConfigurationSettings.AppSettings("SIREPassword")

%>

<form name="SQry" action="http://gis/website/SIREIntegration/index.aspx" method="POST">
<input type=hidden name="IDs" value="<%=request("ID")%>">
<input type=hidden name="SearchDimension" value="<%=request("SearchDimension")%>">
</form>

<script>
document.SQry.submit();
</script>