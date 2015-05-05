<!--- Custom Search Owner ASP file --->
<!--- Inputs: 
		Owner		request("Owner")		Owner Name
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
<!--#include file="dbParams.asp"--> 
<!--#include file="subdbtable.asp"-->
<% 
Function FixQuotes (theString)
	fixQuotes = REPLACE (theString, "'", "''")
End Function

Function EraseQuotes (theString)
	eraseQuotes = REPLACE (theString, "'", "")
End Function

theLastName = Trim(request("Owner"))
FixQuotes(theLastName)

session("ds")=request("ds")


SQLquery = "SELECT APN, Legal_Desc, Owner_Name FROM Parcels WHERE Owner_Name LIKE '" & FixQuotes(theLastName) & "%' OR Owner_Name LIKE '" & EraseQuotes(theLastName) & "%' ORDER BY APN"

call query2table(SQLquery, 2)
 %>
 
</body>
</html>
