<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>

<SCRIPT LANGUAGE='JavaScript' TYPE='text/javascript'>


function sendPropTax(theNum) {
  // alert(theNum);
      var propTaxWin = window.open("","Candidates","toolbar=0,location=0,directories=0,status=0,menubar=1,scrollbars=1,resizable=1,copyhistory=0,width=440,height=445");
   propTaxWin.location.href = "http://www.eproptax.saccounty.net/" //+theNum;
 //  propTaxWin.location.href = "http://ocitdevl/eproptax/ParcelLookup.asp?ParcelNumber="+theNum;
//  propTaxWin.location.href = "http://www.eproptax.saccounty.net/ParcelLookup.asp?ParcelNumber="+theNum;
      propTaxWin.focus();

}
			function printReport() {
  parent.ASSESSOR2.focus();
  window.print();				
		}

			function focusPolitical() {
  parent.ASSESSOR2.location='ASSESSOR2.ASP#POLITICAL'				
		}

			function focusBuilding() {
  parent.ASSESSOR2.location='ASSESSOR2.ASP#Building'				
		}

			function focusLand() {
  parent.ASSESSOR2.location='ASSESSOR2.ASP#Land'				
		}
		
			function focusFee() {
  parent.ASSESSOR2.location='ASSESSOR2.ASP#Fee'				
		}
		
			function focusOwnership() {
  parent.ASSESSOR2.location='ASSESSOR2.ASP#Ownership'				
		}
		
			function focusRoll() {
  parent.ASSESSOR2.location='ASSESSOR2.ASP#Roll'				
		}
		
</script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>

<head>
<title>Untitled</title>
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
</head>

<!--#include file="dbParams.asp"--> 

<body bgcolor="white">

<table width="117" border="0" bordercolor="black" bordercolordark="gray" bordercolorlight="white">
<tr>
<td width="117" align="center">&nbsp;</td>
</tr>
<tr>
<td bgcolor="#FFFFFF" width="117" align="center">
<p align="center"><strong>DATA TYPE</strong></p>
</td>
</tr>
<tr>
<td width="117" align="center"></td>
</tr>
<tr>
<td bgcolor="navy" width="117" align="center">
<p align="center"><a href="Javascript:focusLand()"><b><font color="#FFFF00">LAND</font></b></a></p>
</td>
</tr>
<tr>
<td width="117" align="center" bgcolor="navy">
<p align="center"><a href="Javascript:focusBuilding()"><b><font color="#FFFF00">BUILDING</font></b></a></p>
</td>
</tr>
<tr>
<td width="117" align="center" bgcolor="navy">
<p align="center"><a href="Javascript:focusPolitical()"><b><font color="#FFFF00">POLITICAL</font></b></a></p>
</td>
</tr>
<tr>
<td width="117" align="center" bgcolor="navy">
<p align="center"><a href="Javascript:focusFee()"><b><font color="#FFFF00">FEE</font></b></a></p>
</td>
</tr>
<tr>
<td width="117" align="center" bgcolor="navy">
<p align="center"><a href="Javascript:focusOwnership()"><b><font color="#FFFF00">OWNERSHIP</font></b></a></p>
</td>
</tr>
<tr>
<td width="117" align="center" bgcolor="navy">
<p align="center"><a href="Javascript:focusRoll()"><b><font color="#FFFF00">ROLL VALUES</font></b><a/></p>
</td>
</tr>

<tr>
<td width="117" align="center">&nbsp;</td>
</tr>
<tr>
<td width="117" align="center" bgcolor="navy">

<%
dbResultFieldList = "cntyap_nbr,situs_add1,situs_add2,name,mail1,mail2,landuse,subdivision"
SQLquery = "SELECT " & dbResultFieldList & " FROM " & dbTable & " WHERE " & dbIDField & " = '"  & session("theNum") & "'" 
dim conntemp, rstemp
set conntemp=server.createobject("adodb.connection")
conntemp.open dbSource
'response.write SQLquery
'response.write "Connected...<br>"
set rstemp=conntemp.execute(SQLquery)
			varCCR = rstemp("subdivision")
			              Dim varCCR, varBook, varPage, varMapType
			                varBook = Mid(varCCR, 2, 3)
			                varPage = Mid(varCCR, 5, 3)
			                varMapType = Left(varCCR, 1)
							
							
					                If Trim(varCCR) <> "" Then
					                    If varMapType = "S" Then
					                    thisvalue = "<valign='top'><b><a href=http://ccrmaps.finance.saccounty.net/mz_qresult_map.asp?doccode=435&book=" & varBook & "&page=" & varPage & " target=_new><font color='yellow'>DOCUMENTS</a></b></font></td><td>"
					                    else If varMapType = "P" Then
					                    thisvalue = "<valign='top'><b><a href=http://ccrmaps.finance.saccounty.net/mz_qresult_map.asp?doccode=433&book=" & varBook & "&page=" & varPage & " target=_new><font color='yellow'>DOCUMENTS</font></a></b></font></td><td>"
					                     Else
					                    thisvalue = "<valign='top'>DOCUMENTS</td><td>"
					  					End if
										End If
					 				Else
					                    thisvalue = "<valign='top'>DOCUMENTS</td><td>"
					 	            End If

					response.write "<p align='center'><b><font color='#FFFF00'>"&thisvalue&"</font></b></p>"


thisvalue=session("theNum")
						apnBook = left(thisvalue, 3)
						apnPage = mid(thisvalue,4,4)
						apnParcel = mid(thisvalue,8,3)
						apnSubParcel = right(thisvalue,4)

%>

</td>
</tr>
<tr>
<td width="117" align="center"><font color="#FFFF00">&nbsp;</font></td>
</tr>
<tr>
<td width="117" align="center"><FORM action="http://www.eproptax.saccounty.net/BillSummary.asp" name="BillSummary" method="post" target="_blank">
<input type=hidden name="Parcel_Number1" value="<%=apnBook%>">
<input type=hidden name="Parcel_Number2" value="<%=apnPage%>">
<input type=hidden name="Parcel_Number3" value="<%=apnParcel%>">
<input type=hidden name="Parcel_Number4" value="<%=apnSubParcel%>">
<input type=submit value="E-Prop Tax">
</Form>
<!-- <p align="center"><a href="Javascript:sendPropTax('<%=session("theNum")%>')"><b><font color="#FFFF00">E-PROP TAX</font></b></a></p> -->
</td>
</tr>


<tr>
<td width="80" align="center" >
<button onclick="Javascript:printReport();">Print Report</button>
<!-- <p align="center">
<a href="Javascript:printReport()"><b><font color="#FFFF00">PRINT REPORT</font></b></a></p> -->
</td>
</tr>
<tr>
<td width="117" align="center">&nbsp;</td>
</tr>
</table>

</body>

</html>
