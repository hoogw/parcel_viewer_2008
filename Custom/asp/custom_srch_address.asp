<!--- Custom Search Address ASP file --->
<!--- Inputs: 
		Num1		request("Num1")			Street Number (first)
		Num2		request("Num2")			Street Number (second)
		StreetName	request("StreetName")	Street Name
		ds			request("ds")			The data source connection string
		CS			request("CS")			The colour scheme ID
	  REQUIREMENT:
		* <body onload="top.MapFrame.hideLoadingLyr()">
	    * session("ds") = request("ds")  ;this session("ds") will be used in all ASP pages which need to reference the data source
		* Javascript sendValue(Value1) block
--->

       <script language="javascript">
        function sendValue(Value1) {
			top.MapFrame.positionLoadingLyr();

			var objMC=top.MapFrame.findObj("MapClickedX")
			objMC.value="";

			top.MapFrame.clearBufUrl();
			var url = "parcel_details.aspx?APN=" + Value1
			top.MapFrame.url = "";
			top.MapFrame.SSRefreshMap(Value1,url);
		}
        </script>

<% response.expires = -7 %>
<%
	if trim(request("CS")) <> "" then
		application("CS")=trim(request("CS"))
	end if
%>

<!--#include file="../includes/header.aspx"-->

<body onload="top.MapFrame.hideLoadingLyr()">
<FORM name="frmIDValue" ACTION="javascript:sendValue(frmIDValue.IDValue.value)" ID="Form1">
	<INPUT TYPE="hidden" NAME="IDValue" VALUE="""" ID="Hidden1">
	<INPUT TYPE="hidden" NAME="DisplayValue" VALUE="""" ID="Hidden2">
</FORM>
<%
session("ds") = request("ds")
%>
<!--#include file="dbParams.asp"--> 
<!--#include file="subdbtable.asp"-->
<% 
Function FixQuotes (theString)
	fixQuotes = REPLACE (theString, "'", "''")
End Function

Function EraseQuotes (theString)
	eraseQuotes = REPLACE (theString, "'", "")
End Function

theType = "address"
theNum = Trim(request("Num1"))
theStr = Trim(request("StreetName"))
theNum2 = Trim(request("Num2"))

if (theNum2 <> "") then
	SQLquery = "SELECT APN, Legal_Desc, Owner_Name FROM Parcels WHERE S_HOUSE# >= "  & theNum & " AND S_HOUSE# <= "  & theNum2 & " AND S_NAME LIKE '" & theStr & "%' ORDER BY APN"
else
	if (theNum = "") then
		SQLquery = "SELECT APN, Legal_Desc, Owner_Name FROM Parcels WHERE S_NAME LIKE '" & FixQuotes(theStr) & "%' OR S_NAME LIKE '" & EraseQuotes(theStr) & "%'  ORDER BY APN"
	else
		SQLquery = "SELECT APN, Legal_Desc, Owner_Name FROM Parcels WHERE S_HOUSE# = "  & theNum & " AND S_NAME like '" & FixQuotes(theStr) & "%' OR S_HOUSE# = "  & theNum & " AND S_NAME like '" & EraseQuotes(theStr) & "%'  ORDER BY APN"
	END IF
end if

call query2table(SQLquery, theNum2)
 %>
 
</body>
</html>
