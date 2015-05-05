<% response.expires = -7 %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
	<title>Parcel History Results</title>
</head>


<SCRIPT LANGUAGE='JavaScript' TYPE='text/javascript'>
function sendHistory(theNum,PCCREATE) {
   document.location = "arcims_history_process_step2.asp?IDValue="+theNum+"&curAPN="+theNum+"&theNext=1&PCCREATE="+PCCREATE;
}

function sendHistory2(apnBook,apnPage,apnParcel,apnSubParcel) {
var Value1=apnBook+apnPage+apnParcel+apnSubParcel;

if (Value1.length<14){alert("Please verify that all of the required fields are completed for the APN in the following format, ###-####-###-####");}
else{

   document.location= "arcims_history_process.asp?IDValue="+Value1+"&curAPN="+Value1;

}
}

function smartfocus (curr,nxt) {

	if (curr.value.length >2) {
		nxt.focus();
	}
}

function smartfocus3 (curr,nxt) {

	if (curr.value.length >3) {
		nxt.focus();
	}
}

</script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>
<body>

<!--#include file="dbParams.asp"--> 
<FONT FACE="Arial,sans-serif" SIZE="-2">
<% 
curAPN = request.querystring("curAPN")


	Set cnnOracle = Server.CreateObject("ADODB.Connection")
	strConn = "Provider=MSDAORA.1; Data Source=psd; User ID=gis; Password=gis@psd;Persist Security Info=True;"
	cnnOracle.Open strConn
	Set comm = Server.CreateObject("ADODB.Command")
    comm.commandtype=4   
'    comm.commandtext = "RETURN_HISTORY_MASTER"
	comm.commandtext = "RETURN_HISTORY_MASTER_LIMIT"

'response.write curAPN & "<br>"
'response.end

    set param = comm.createparameter("InPut",129,1,14)
    comm.parameters.append param

    set param = comm.createparameter("OutPut",129,2,3000)
    comm.parameters.append param

    'Pass the input value
	comm.parameters(0).value = curAPN

 	Set comm.ActiveConnection = cnnOracle

    'Execute after setting the parameters
'response.write "<SCRIPT LANGUAGE='JavaScript' TYPE='text/javascript'>"
'response.write "alert('Pre-Stored Procedure');"
'response.write "</script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>"
   comm.execute()
'response.write "<SCRIPT LANGUAGE='JavaScript' TYPE='text/javascript'>"
'response.write "alert('Post-Stored Procedure');"
'response.write "</script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>"

'response.write curAPN & "<br>"
'response.end

'perrytemp = "HISTORY_RECS 0011 :,23700110590000,890211,22-FEB-00,23700110420000,880088,22-FEB-00,23700110360000,820800,22-FEB-00,23700110390000,820800,22-FEB-00,23700110480000,880088,22-FEB-00,23700110430000,840819,22-FEB-00,23700110360000,820800,22-FEB-00,23700110390000,820800,22-FEB-00,23700110440000,840819,22-FEB-00,23700110360000,820800,22-FEB-00,23700110390000,820800,22-FEB-00"
'perrytemp = "HISTORY_RECS 0004 :,23700110430000,840819,22-FEB-00,23700110360000,820800,22-FEB-00,23700110390000,820800,22-FEB-00,23700110440000,840819,22-FEB-00 "
'response.write perrytemp & "<br><br>"
'response.write comm.parameters(1).value & "<br><br>"
perrytemp = comm.parameters(1).value

PerryTemp2=mid(perrytemp, instr(perrytemp,":")+2,9999)
PerryCount=mid(perrytemp, instr(perrytemp,":")-5,4)

historyList = MID(trim(perrytemp2), 1)
'historyList = MID(trim(perrytemp), 22)
'response.write historyList& "<br><br>"

'Header**********************************************************

response.write "<font color='Blue'><b><font size='2'>Parcel History Data For: <font color='Red'>"

			apnBook = left(curAPN, 3)
			apnPage = mid(curAPN,4,4)
			apnParcel = mid(curAPN,8,3)
			apnSubParcel = right(curAPN,4)
response.write apnBook&"- "&apnPage&"- "&apnParcel&"- "&apnSubParcel
response.write "</font></font></b></font></div>"

response.write "<TABLE width='400'><tr><td><p align='right'><!---<input type=button name=btnClose value='Close' onclick='window.close()'>---></tr></td></TABLE>"

response.write "<font size='-1'>Since the early 1980's, the County Assessor has tracked all parcel update/delete activities with the Parcel Creation Number (PC#).  The parcel history functionality contained herein is limited to providing the user with the ability to 'toggle' through a series of PC#'s.</font><br><br>"

response.write "<font size='-1'>The APN's listed below include any parcel(s) that were retired in the creation of the selected parcel.  Parcel lineage can be very complex and may require further investigation.  Click on an APN below to view the parcel creation information associated with that parcel.</font><br><br>"

'Build Tabular Display of Attribute Data**************************
recCount = MID(perrytemp, 14, 4)

howmany = 3*(recCount)
arrHist = Split(historyList,",")

response.write "<TABLE width='400'>"

	response.write "<TR BGCOLOR='#BBBBBB'>"
	response.write "<TD width='180' align='center'><FONT FACE='Arial,sans-serif' SIZE='-1'><B>APN</B></FONT></TD>"
	response.write "<TD width='180' align='center'><FONT FACE='Arial,sans-serif' SIZE='-1'><B>PC CREATE NUMBER</B></FONT></TD>"
'	response.write "<TD width='180' align='center'><FONT FACE='Arial,sans-serif' SIZE='-1'><B>CREATE DATE</B></FONT></TD>"
	response.write"</TR>"

	for i=0 to howmany-3
		if (i/2 = i\2) then
			response.write "<TR BGCOLOR='#DDDDDD'>"
		else 
			response.write "<TR BGCOLOR='#EEEEEE'>"
		end if
		apnHyphen = left( arrHist(i), 3) & "-" & mid(arrHist(i),4,4) & "-" & mid(arrHist(i),8,3) & "-" & right(arrHist(i),4)
		response.write "<TD width='200'><FONT FACE='Arial,sans-serif' SIZE='-2'><B><a href='JAVASCRIPT:sendHistory(""" & arrHist(i) & """,""" & arrHist(i+1) & """)'>"&apnHyphen&"</a></B></FONT></TD>"
		response.write "<TD width='200'><FONT FACE='Arial,sans-serif' SIZE='-2'><B>" & arrHist(i+1) & "</B></FONT></TD>"
	'	response.write "<TD width='200'><FONT FACE='Arial,sans-serif' SIZE='-2'><B>" & arrHist(i+2) & "</B></FONT></TD>"
		response.write"</TR>"
		i=i+2
	next
response.write"</TABLE><br>"


response.write "<br><font size='2'>If you would like to perform a HISTORY search based on a different Parcel Number, please enter it here and click on the search button."' 


response.write "<form name='frmAPN' action='javascript:sendHistory2(frmAPN.apnBook.value,frmAPN.apnPage.value,frmAPN.apnParcel.value,frmAPN.apnSubParcel.value)'>"

response.write "<input type='text' name='apnBook' size='2' value='' maxlength='3' onkeyup='smartfocus(this,apnPage);'>--<input type='text' name='apnPage' size='3' value='' maxlength='4' onkeyup='smartfocus3(this,apnParcel);'>--<input type='text' name='apnParcel' size='2' value='' maxlength='3' onkeyup='smartfocus(this,apnSubParcel);'>--<input type='text' name='apnSubParcel' size='3' value='0000' maxlength='4'>&nbsp;&nbsp;&nbsp;<input type='submit' value='Search' name='submit'></form>"


response.write "<p align='right'><input type=button value='Back' onclick='window.history.back();'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<!---<input type=button name=btnClose value='Close' onclick='window.close()'>---></p>"



 %>

</FONT></body>
</html>
