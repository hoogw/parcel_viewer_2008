<% response.expires = -7 %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
	<title>Vacant Parcel Search - Address Results</title>
<SCRIPT LANGUAGE='JavaScript' TYPE='text/javascript'>
		
		function sendValue(Value1) {

      var myWin3 = window.open("","idWin","width=425,height=510,resizable,scrollbars");
		myWin3.location.href = "arcims_process.asp?IDValue=" + Value1;
      myWin3.focus();
		
			window.opener.parent.MapFrame.getDBQuery(Value1);
	    
			window.close();
			
		}
	</script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>
</head>

<body >
<FORM name="frmIDValue" ACTION="javascript:sendValue(frmIDValue.IDValue.value)">
	<INPUT TYPE="hidden" NAME="IDValue" VALUE="""">
	<INPUT TYPE="hidden" NAME="DisplayValue" VALUE="""">
</FORM>
<!--#include file="dbParams.asp"-->
<!--#include file="subdbtable.asp"--> 

<% 
theType = "address"
theStr = Trim(request.querystring("stname"))


SQLquery = "SELECT PARCELS.cntyap_nbr, situs_add1, name, vw.VACANT_PARCELS.vacant_landuse FROM PARCELS, vwVACANT_PARCELS WHERE street_nam LIKE '" & theStr & "%' and PARCELS.CNTYAP_NBR = vw.VACANT_PARCELS.CNTYAP_NBR ORDER BY situs_add1"


'response.write SQLquery & "<br>"
'response.end

dbCandidateFieldDescriptList = "Parcel ID,Address,Owner,Vacant Landuse"
dbCandidateFieldDescript = Split(dbCandidateFieldDescriptList,",")

call query2table(SQLquery,0)

 %>
 
</body>
</html>
