<!--- Custom Search Address ASP file --->
<!--- Inputs: 
		Num1		request("Num1")			First APN (range FROM)
		Num2		request("Num2")			Second APN (range TO)
		ds			request("ds")			The data source connection string
		CS			request("CS")			The colour scheme ID
	  REQUIREMENT:
		* <body onload="top.MapFrame.hideLoadingLyr()">
		* Javascript sendValue(Value1) block
--->

<%
	if trim(request("CS")) <> "" then
		application("CS")=trim(request("CS"))
	end if
%>

<HTML>
		<script language="javascript">
		function sendValue(Value1, subAPN) {
			var objMC=top.MapFrame.findObj("MapClickedX")
			objMC.value="";
			
			top.MapFrame.positionLoadingLyr();
			top.MapFrame.clearBufUrl();
			top.MapFrame.url="";
			var url = "parcel_details.aspx?APN=" + Value1
			top.MapFrame.SSRefreshMap(Value1,url);
		}
		</script>
		<!--#include file="../includes/header.aspx"--> 
		
		<!--#include file="dbParams.asp"--> 
		<!--#include file="subdbtable.asp"-->
<body onload="top.MapFrame.hideLoadingLyr()">
		<% 

		session("ds") = request("ds")
		theNum = request("Num1")
		theNum = left(theNum,3) & "-" & mid(theNum,4,3) & "-" & mid(theNum,7,3) & "-" & right(theNum,1)
		theNum1 = request("Num2")
		if theNum1 <> "" then
			theNum1 = left(theNum1,3) & "-" & mid(theNum1,4,3) & "-" & mid(theNum1,7,3) & "-" & right(theNum1,1)
			SQLquery = "SELECT APN, Legal_Desc, Owner_Name FROM Parcels WHERE APN >= '" & theNum & "' and APN <= '" & theNum1 & "' Order By APN"
		else
			SQLquery = "SELECT APN, Legal_Desc, Owner_Name FROM Parcels WHERE APN = '" & theNum & "' Order By APN"
		end if

		call query2table(SQLquery, theType)
		%>
</body>
</html>
