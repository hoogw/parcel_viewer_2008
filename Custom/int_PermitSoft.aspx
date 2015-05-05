<%

on error resume next

	dim uid,pwd,url

	url= System.Configuration.ConfigurationSettings.AppSettings("PSURL")
	uid= System.Configuration.ConfigurationSettings.AppSettings("PSUserName")
	pwd= System.Configuration.ConfigurationSettings.AppSettings("PSPassword")

	'response.redirect (url & "?docid=" & uid & "&docid2=" & pwd & "&id=" & request("ID"))
%>
<script>
	document.location = '<%=url & "?permit id=" & request("ID")%>';
</script>
