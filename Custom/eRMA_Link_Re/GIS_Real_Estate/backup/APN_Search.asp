
<!--METADATA NAME="Microsoft ActiveX Data Objects 2.5 Library" TYPE="TypeLib" UUID="{00000205-0000-0010-8000-00AA006D2EA4}"-->
<!-- #include FILE="../Includes/incConstants.asp" -->
<!-- #include FILE="../Classes/CDatabase.asp" -->
<%

Dim bCheck_APN
Dim s_APN 
Dim i_Exists_Flag
Dim b_Exists
Dim i_Debug_Flag
Dim g_Page
Dim g_DocClass
Dim g_DocCategory
Dim g_DocType
dim g_Sort

'- Initializations
i_Debug_Flag = 1 '- 0 =Debug OFF/ 1 = Debug ON
bCheck_APN = Request("CHK_APN")  
s_APN = Request("idmDocMvCustom1")  
i_Exists_Flag = Request("Exists")  

g_Page = "http://documentstest.ecm.saccounty.net/realestate/reDocList.asp"
g_DocClass = "Contract/Agreement"
g_DocCategory = "Easement"
g_DocType = "Deed"
g_Sort = "V_AVAIL_STAT"

'g_Page = "http://documents.ecm.saccounty.net/WR/wrDocList.asp"
'g_DocClass = "Report"
'g_DocCategory = "Flood Reports"
'g_DocType = "Water Resources Documents"


'easement' 

'- Build generic HTML header
Call Build_HTM_Header()

'- Check to see if documents exist for passed APN number
If cbool(bCheck_APN) = True Then
	b_Exists = Retrieve_DocID(s_APN, i_Debug_Flag)
	If cbool(b_Exists) = True Then
		Build_Submit_APN_Body(s_APN)
	Else
		Response.Redirect  "APN_Search.asp?Exists=1"
	End If
Else
	Call Build_Search_APN_Body(i_Exists_Flag)
End If

'- Build generic HTML footer
Call Build_HTM_Footer()


'----------------------------------------------------------------------------------------------------------------
Public Sub Build_HTM_Header()
	WriteLine "	<!DOCTYPE HTML PUBLIC ""-//W3C//DTD HTML 4.0 Transitional//EN"">", true
	WriteLine "	<html>", true
	WriteLine "		<head>", true
	WriteLine "			<title></title>", true
	WriteLine "			<meta name=""vs_showGrid"" content=""False"">", true
	WriteLine "	</head>", true
	WriteLine "		<body>", true
End Sub

'----------------------------------------------------------------------------------------------------------------
Public Sub Build_HTM_Footer()
	WriteLine "		</body>", true
	WriteLine "	</html>", true
End Sub

'----------------------------------------------------------------------------------------------------------------
Public Sub Build_Submit_APN_Body(s_APN)
	WriteLine "			<form name=""APN_Search"" action=""" & g_Page & """ target=""_blank"" method=""post"" ID=""Form1"">", true
	WriteLine "				<TABLE ID=""Table2"">", true
	WriteLine "					<TR>", true
	WriteLine "						<TD>", true
	WriteLine "							<INPUT type=""hidden"" name=""idmDocCustom2"" value=""" & g_DocCategory & """ ID=""1""> <!-- FN_1 -->", true
	WriteLine "							<INPUT type=""hidden"" name=""idmDocCustom38"" value=""" & g_DocType & """ ID=""2""> <!-- FN_2 -->", true
	WriteLine "							<INPUT type=""hidden"" name=""idmDocMvCustom1"" value=" & s_APN & " ID=""6""> <!-- FN_5 -->", true
	WriteLine "							<INPUT type=""hidden"" name=""idmDocType"" value=""" & g_DocClass & """ ID=""4""> <!-- FN_3 -->", true
	WriteLine "							<INPUT type=""hidden"" name=""name=nmSortBy"" value=""" & g_Sort & """ ID=""4""> <!-- FN_3 -->", true
	
	'WriteLine "							<INPUT type=""hidden"" name=""idmDocCustom40"" value=""Real Estate"" ID=""5""> <!-- FN_4 -->", true
	WriteLine "							<INPUT type=""hidden"" name=""idmName"" ID=""6""> <!-- FN_5 -->", true
	WriteLine "						</TD>", true
	WriteLine "					</TR>", true
	WriteLine "				</TABLE>", true
	WriteLine "			</form>", true
	WriteLine "			<script language=""JavaScript"">", true
	WriteLine "				document.APN_Search.submit();", true
	WriteLine "			</script>", true
	
	Call Build_Search_APN_Body(0)
	
End Sub

'----------------------------------------------------------------------------------------------------------------
Public Sub Build_Search_APN_Body(i_Exists_Flag)
	
	WriteLine "			<form name=""APN_Search"" action=""APN_Search.asp""  method=""post"" ID=""Form1"">", true
	WriteLine "				<DIV style=""WIDTH: 594px; POSITION: relative; HEIGHT: 657px"" ms_positioning=""GridLayout"">&nbsp;", true
	WriteLine "					<TABLE id=""Table1"" style=""Z-INDEX: 104; LEFT: 9px; WIDTH: 560px; POSITION: absolute; TOP: 10px; HEIGHT: 109px"" cellSpacing=""0"" cellPadding=""0"" width=""560"" border=""1""  borderColor=""#0033cc"">", true
	WriteLine "						<TR>", true
	WriteLine "							<TD colSpan=""3""></TD>", true
	WriteLine "						</TR>", true
	WriteLine "					</TABLE>", true
	WriteLine "					<INPUT type=""hidden"" name=""CHK_APN"" value=true> ", true
	WriteLine "					<INPUT id=""Submit1"" style=""Z-INDEX: 105; LEFT: 200px; POSITION: absolute; TOP: 57px"" type=""submit"" value=""Submit"" name=""Submit1"">", true
	WriteLine "					<INPUT id=""Text1"" style=""Z-INDEX: 120; LEFT: 42px; POSITION: absolute; TOP: 58px"" type=""text"" name=""idmDocMvCustom1"">", true
	WriteLine "					<DIV style=""DISPLAY: inline; Z-INDEX: 107; LEFT: 41px; WIDTH: 197px; POSITION: absolute; TOP: 37px; HEIGHT: 17px"" ms_positioning=""FlowLayout""><PRE><FONT face=Arial size=2><STRONG>Enter APN Number</STRONG></FONT></PRE>", true
	WriteLine "					</DIV>", true
	
	If cbool(i_Exists_Flag) = true Then
		WriteLine "					<DIV style=""DISPLAY: inline; Z-INDEX: 107; LEFT: 41px; WIDTH: 197px; POSITION: absolute; TOP: 18px; HEIGHT: 17px"" ms_positioning=""FlowLayout""><PRE><FONT color=red face=Arial size=1><STRONG>No Documents Exist</STRONG></FONT></PRE>", true
		WriteLine "					</DIV>", true
	End If
	
	WriteLine "				</DIV>", true
	WriteLine "			</form>", true
End Sub

'--------------------------------------------------------------------------------------
Public Function Retrieve_DocID(ByRef s_APN, i_Debug_Flag)
	Dim oRS 
	Dim oDB
	Dim sSQL
	
	If IsNull (s_APN) or s_APN = "" Then Retrieve_DocID = False : Exit Function
	

	
	sSQL = "EXEC sp_Search_By_APN @APN='"
	sSQL = sSQL & Trim(s_APN) & "', @Class='" & g_DocClass & "', @Category='" & g_DocCategory & "', @Type='" & g_DocType & "'"

	Set oDB = New CDatabase
	oDB.Build_Connection(C_DB_CNNSTR_FNETLIB1)
	Set oRS = oDB.ExecQry (sSQL, i_Debug_Flag,1)
	
	If i_Debug_Flag = 1 Then Response.End 
	If Not oRS.EOF Then
		 Retrieve_DocID = True
	Else 
		Retrieve_DocID = False
	End If
 
End Function
	
'----------------------------------------------------------------------------------------------------------------
Public Sub WriteLine(sString, bCR) 
	If bCR = True Then Response.Write "" & sString & vbcrlf  Else  Response.Write "" & sString
End Sub 

%>

%>
