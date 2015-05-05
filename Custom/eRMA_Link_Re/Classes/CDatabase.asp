
<%
'Database Connection Class
'Const DEBUG_OFF = 0
'Const DEBUG_ON = 1

Class CDatabase
	Private m_oConn
	Private m_oRS
	Private m_sConnectString
 
	
	Public Function Build_Connection(sConnection)
		m_sConnectString = sConnection
	
		Set m_oConn = Server.CreateObject("ADODB.Connection")
		m_oConn.Open m_sConnectString
		'm_sConnectString = "Provider=SQLOLEDB;Data Source=Tran;User Id=sa;password=peaceful; Initial Catalog=Test;"
	End Function
'---------------------------------------------------------------------------------------------------------
	Public Property Get ConnectString()
		ConnectString = m_sConnectString
	End Property
'---------------------------------------------------------------------------------------------------------			
	Public Property Let ConnectString(sConnectString)
		m_sConnectString = sConnectString
	End Property
'---------------------------------------------------------------------------------------------------------			
	Public Property Get Connection()
		Set Connection = m_oConn
	End Property
'---------------------------------------------------------------------------------------------------------			
	Public Function Execute(sSQL)
		m_oConn.Execute sSQL
	End Function
	
'---------------------------------------------------------------------------------------------------------		
	Public Function ExecQry(m_sSQL, iDebug, iMaxRecords)
	
	'- Function will return a disconnected recordset - Debug options are available
	Set m_oRS = server.createobject("ADODB.Recordset")

		If iDebug = 1 Then
			Response.Write "<br><SPAN style=' FONT-SIZE: 8pt;COLOR: blue;FONT-FAMILY: arial,helvetica,tahoma'>SQL DEBUG STATEMENT<br>" & vbcrlf
			Response.Write "<SPAN style=' FONT-SIZE: 8pt;COLOR: blue;FONT-FAMILY: arial,helvetica,tahoma'>----------------------------------------------------<br>" & vbcrlf
			Response.Write "<SPAN style='font-family:verdana;color:red;font-size:12px;'>" & m_sSQL & "</SPAN><br><BR><BR>"
			If iMaxRecords <> 0 Then 
				Response.Write "<SPAN style=' FONT-SIZE: 8pt;COLOR: blue;FONT-FAMILY: arial,helvetica,tahoma'>MAX RECORDS: " & iMaxRecords &  "<br>" & vbcrlf
			Else
				Response.Write "<SPAN style=' FONT-SIZE: 8pt;COLOR: blue;FONT-FAMILY: arial,helvetica,tahoma'>MAX RECORDS:  NOT SET<br>" & vbcrlf
			End If
			Response.Write "<SPAN style=' FONT-SIZE: 8pt;COLOR: blue;FONT-FAMILY: arial,helvetica,tahoma'>----------------------------------------------------<br>" & vbcrlf
		End If
		
		With m_oRS
			If iMaxRecords <> 0 Then .MaxRecords = iMaxRecords
			.CursorLocation = 3
			.LockType = 4
			.CursorType = 2
		End With

		m_oRS.Open m_sSQL, m_oConn

		Set m_oRS.ActiveConnection = Nothing
		Set ExecQry = m_oRS
	
	End Function
	
'---------------------------------------------------------------------------------------------------------			
	Public Function PadQuotes(sValue)
	'Use this function to properly create a sql statement from
	'VB to any database
	   Dim sBodyBuild
	   Dim sBodyString
	   Dim iLength
	   Dim i
	   Dim bTest
	   
	   sBodyBuild = ""
	   sBodyString = sValue
	   iLength = Len(sBodyString)
	   For i = 1 To iLength
	      sBodyBuild = sBodyBuild & Mid(sBodyString, i, 1)
	      If Mid(sBodyString, i, 1) = Chr(39) Then
			 'Response.Write sBodyBuild & "  " 
			 'bTest = True
			 sBodyBuild = left(sBodyBuild,len(sBodyBuild) - 1) & ""
	         'ORIG: sBodyBuild = sBodyBuild & Mid(sBodyString, i, 1)
	      End If
	   Next
	   
	   'If bTest = True Then Response.Write sBodyBuild & "  "  :Response.End 
	   sBodyString = sBodyBuild
	   PadQuotes = sBodyString
	End Function
'---------------------------------------------------------------------------------------------------------			
	Private Sub Class_Initialize()
		'Use the constant for the connectionstring
		 
		'm_sConnectString = "Provider=SQLOLEDB;Data Source=Tran;User Id=sa;password=peaceful; Initial Catalog=Test;"

		'Set m_oConn = Server.CreateObject("ADODB.Connection")
		'm_oConn.Open m_sConnectString
	End Sub
	
'---------------------------------------------------------------------------------------------------------	
	Private Sub Class_Terminate()
		'Set m_oConn = Nothing
	End Sub
End Class
%>