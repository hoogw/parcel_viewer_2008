<%

on error resume next

	dim DocNum, i, tmp
	
	if trim(request("ds")) <> "" then
		session("ds") = "Provider=SQLOLEDB.1;" & request("ds")	'data source from .NET code
	end if

	if trim(request("FAC_NO")) <> "" then
		tmp = trim(request("FAC_NO"))
	

		response.redirect ("http://erma.ecm.saccounty.net/WQ/WQDoclist.asp?idmDocMVCustom2=" & tmp & "&dbchk=1")
	end if

%>

