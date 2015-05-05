<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<HTML>
	<HEAD>
		<title>Data Currency Information</title> 
		<!--#include file="../includes/header.aspx"-->
		<!--#include file="dbParams.asp"-->
	</HEAD>
<body onload="top.HaltLYRHide=0; top.MapFrame.hideLoadingLyr();">
		<FONT class="SSMsg2"><font class='SSHdr1'>Online Application - Data 
				Currency</font><br>
			<TABLE width='100%'>
				<TR class="SSHdr2">
					<TH>
						<FONT class="tblHdr"><b>Theme Name*</b></FONT></TH>
					<TH>
						<FONT class="tblHdr"><b>Updated</b></FONT></TH>
					<TH>
						<FONT class="tblHdr"><b>Description</b></FONT></TH>
					<TH>
						<FONT class="tblHdr"><b>Source**</b></FONT></TH>
				</TR>
				<%
		On Error Resume Next

		Dim Information
        Dim SQLquery, howmanyfields, recCount, i, thisvalue
        Dim conntemp, rstemp

        Information = ""
        SQLquery = "SELECT THEME_NAME,LAST_UPDATE,DESCRIPTION,SOURCE FROM vwDATA_CURRENCY WHERE ONLINE_FLAG = 'Y'"

		err.clear()
        set conntemp = server.createobject("ADODB.Connection")
        conntemp.open dbSource
        set rstemp = conntemp.execute(SQLquery)

        If Err.Number <> 0 Then
            Information = "<br>Error Occured.<br><br>Error Number " & Err.Number & " : " & cstr(err.description)
			'goto Leave
			rstemp=nothing
			conntemp=nothing
			response.write (Information)
			response.end
        End If

        howmanyfields = rstemp.fields.count - 1
        recCount = 0

		if err.number = 0 then
			Do While Not rstemp.eof

				If Err.Number <>0 Then
					rstemp=nothing
					conntemp=nothing
					response.write (Information)
					response.end
				End If

				recCount = recCount + 1
				If (recCount / 2 = recCount \ 2) Then
					Information = Information & "<TR BGCOLOR='#DDDDDD'>"
				Else
					Information = Information & "<TR BGCOLOR='#EEEEEE'>"
				End If

				For i = 0 To howmanyfields
					thisvalue = cstr(rstemp(i))
					If isnull(thisvalue) Then
						thisvalue = "&nbsp;"
					End If
					Information = Information & "<TD><font class=SSCrow1>" & thisvalue & "</font></TD>"
				Next
				rstemp.movenext()
				Information = Information & "</TR>"
			Loop
		end if
		
Leave:
        rstemp.close()
        rstemp = Nothing
        conntemp.close()
        conntemp = Nothing
		
		response.write (Information)
		%>
				<br>
				<TABLE width='100%'>
					<tr>
						<td>
							<br>
							<font class="SSMsg2">*&nbsp;&nbsp;Wherever possible, these listings reflect the 
								most up-to-data sources of data. Historically, the data is complete, unless 
								otherwise indicated in the 'date range' statement.<br>
								<font class="SSMsg2">**&nbsp;Regarding Assessor Data - Data currency reflects 
									business cycle requirements of the Assessor's Office. Gaps between event 
									occurrence and processing are expected.</font></td>
					</tr>
				</TABLE>
				<br>
				<br>
		</FONT>
	</body>
</HTML>
