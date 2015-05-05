<%

on error resume next

dbSourceAssessor = "Provider=SQLOLEDB.1;Password=genfnuser;Persist Security Info=True;User ID=genfnuser;Initial Catalog=AssessorLib;Data Source=COSP-I-LIB01.saccounty.net"

set conntemp=server.createobject("adodb.connection")
conntemp.open dbSourceAssessor
docPage =left(apnPage, 3)
SQLassessor = "execute sproc_ERMA_INTGR_ASSESSOR @Option = 'Get_Map_Pages',@Book = '"& request("apnBook") &"',@Page = '"& request("docPage") &"',@Lib = 'assessorlib',@MaxDocs = '50'"
set rsAssTemp = conntemp.execute(SQLassessor)

response.redirect ("http://erma.ecm.saccounty.net/General/AccessorFileTransfer.asp?docID=" + rsAssTemp("e_NAME") +"&ClientID=ASSESSORLIB&Library=assessorlib")


'response.redirect ("http://erma.ecm.saccounty.net/General/ProxyFileTransfer.asp?docID=" + rsAssTemp("e_NAME") +"&ClientID=ASSESSORLIB")

'response.redirect ("http://erma.ecm.saccounty.net/General/ProxyFileTransfer.asp?docID=005153997&ClientID=ASSESSORLIB")
%>

