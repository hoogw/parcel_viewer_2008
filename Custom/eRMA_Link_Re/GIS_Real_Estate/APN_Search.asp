
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
i_Debug_Flag = 0'- 0 =Debug OFF/ 1 = Debug ON
bCheck_APN = Request("CHK_APN")  
s_APN = Request("idmDocMvCustom1")  
i_Exists_Flag = Request("Exists")  

g_Page = "http://documentstest.ecm.saccounty.net/realestate/reDocList.asp"
g_DocClass = "Contract/Agreement"
g_DocCategory = "Easement"
g_DocType = "Deed"
g_Sort = "V_AVAIL_STAT"


'----------------------------------------------------------------------------------------------------------------
Public Function Build_Submit_APN_Body(s_APN, iSource)
response.write "ad"
response.end
	Dim sHTML
	
	If iSource = 1 Then ' Real Estate Link
		g_Page = "http://documents.ecm.saccounty.net/realestate/reDocList.asp"
		g_DocClass = "Contract/Agreement"
		g_DocCategory = "Easement"
		g_DocType = "Deed"
		g_Sort = "V_AVAIL_STAT"
	ElseIf iSource = 2 Then 'Water Quality Link
		g_Page = "http://documents.ecm.saccounty.net/realestate/reDocList.asp"
		g_DocClass = "Contract/Agreement"
		g_DocCategory = "Easement"
		g_DocType = "Deed"
		g_Sort = "V_AVAIL_STAT"
		g_DocTypeRE = "Real Estate"
		theValue="12333"
	End If

	sHTML =  g_Page & "?"
	sHTML = sHTML &  "&idmDocMvCustom9=" & theValue
	sHTML = sHTML &  "&idmDocCustom40=" & g_DocTypeRE 
	sHTML = sHTML & "idmDocCustom2=" & g_DocCategory  
	sHTML = sHTML &  "&idmDocCustom38=" & g_DocType 
	sHTML = sHTML &  "&idmDocMvCustom1=" & s_APN
	sHTML = sHTML &  "&idmDocType=" & g_DocClass 
	sHTML = sHTML &  "&dbchk=1"
	
	If g_Sort <> "" Then
		sHTML = sHTML &  "&nmSortBy=" & g_Sort  
		sHTML = sHTML &  "&idmName="
	End If
	 
	Build_Submit_APN_Body = sHTML
	'Call Build_Search_APN_Body(0)
	
End Function

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
Public Function Retrieve_DocID(ByRef s_APN, iSource)
	Dim oRS 
	Dim oDB
	Dim sSQL
	Dim i_Debug_Flag
	i_Debug_Flag = 0
	
	If IsNull (s_APN) or s_APN = "" Then Retrieve_DocID = False : Exit Function
	
	If iSource = 1 Then ' Real Estate Link
		g_Page = "http://documents.ecm.saccounty.net/realestate/reDocList.asp"
		g_DocClass = "Contract/Agreement"
		g_DocCategory = "Easement"
		g_DocType = "Deed"
		g_Sort = "V_AVAIL_STAT"
	ElseIf iSource = 2 Then 'Water Quality Link
		g_Page = "http://documents.ecm.saccounty.net/realestate/reDocList.asp"
		g_DocClass = "Contract/Agreement"
		g_DocCategory = "Easement"
		g_DocType = "Deed"
		g_Sort = "V_AVAIL_STAT"
		g_DocTypeRE = "Real Estate"
		theValue="12333"
	End If

	sHTML =  g_Page & "?"
	sHTML = sHTML &  "&idmDocMvCustom9=" & theValue
	sHTML = sHTML &  "&idmDocCustom40=" & g_DocTypeRE 
	sHTML = sHTML & "idmDocCustom2=" & g_DocCategory  
	sHTML = sHTML &  "&idmDocCustom38=" & g_DocType 
	sHTML = sHTML &  "&idmDocMvCustom1=" & s_APN
	sHTML = sHTML &  "&idmDocType=" & g_DocClass 
	sHTML = sHTML &  "&dbchk=1"
	
	sSQL = "EXEC sp_Search_By_APN @APN='"
	sSQL = sSQL & Trim(s_APN) & "', @Class='" & g_DocClass & "', @Category='" & g_DocCategory & "', @Type='" & g_DocType & "'"
'	response.write sSQL

	Set oDB = New CDatabase
	oDB.Build_Connection(C_DB_CNNSTR_FNETLIB1)
	Set oRS = oDB.ExecQry (sSQL, i_Debug_Flag,1)
	
	'If i_Debug_Flag = 1 Then Response.End 
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
