<%
	Dim strFile
	Dim loc

	strFile = session("MapImageURL")

	Do
		Loc = InStr(strFile, "/")
		If loc = 0 Then Exit Do

		strFile = Mid(strFile, loc + 1)

	Loop

	filecopy (session("MapImageFile"),Application("PhysicalPath") & "/Output/" & strFile)
	
	Response.AddHeader("content-disposition", "attachment; filename=" & strFile)
	server.transfer("..\Output\" & strFile)
%>