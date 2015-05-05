<%

on error resume next

	dim DocNum, i, tmp
	
	if trim(request("ds")) <> "" then
		session("ds") = "Provider=SQLOLEDB.1;" & request("ds")	'data source from .NET code
	end if

	if trim(request("ESMNT_NBR")) <> "" then
		tmp = trim(request("ESMNT_NBR"))
	elseif trim(request("EASEMENT_I")) <> "" then
		tmp = trim(request("EASEMENT_I"))
	elseif trim(request("NO")) <> "" then
		tmp = trim(request("NO"))
	end if
	
	for i = len(tmp) to 1 step -1
		if asc(mid(tmp,i,1)) >= 48 and asc(mid(tmp,i,1)) <=57 then
			DocNum=mid(tmp,i,1) & DocNum
		else
			exit for
		end if
	next
	
	for i = len(DocNum) to 5
		DocNum = "0" & DocNum
	next

	response.redirect ("http://erma.ecm.saccounty.net/RealEstate/reDoclist.asp?idmDocCustom38=Deed&idmDocCustom2=Easement&idmDocMVCustom9=" & DocNum & "&dbchk=1")

%>

