asdf
<%response.end%>

<% response.expires = -7 %>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
	<title>Parcel Detail Results</title>
<!--#include file="../includes/Header.aspx"-->
</head>


<SCRIPT LANGUAGE='JavaScript' TYPE='text/javascript'>

function sendAssessorImage(b,p) {
	var assessorImageWin = window.open("AssessorMaps.asp?apnBook=" + b + "&docPage=" + p,"AssessorMap","toolbar=0,location=0,directories=0,status=0,menubar=1,resizable=1,scrollbars=1");
	assessorImageWin.focus();
}

function sendNotes(IDValue) {
	var notesWin = window.open("arcims_notes_process.asp?IDValue=" + IDValue,"idWin2","toolbar=0,location=0,directories=0,status=0,menubar=1,resizable=1,scrollbars=1,width=700,height=425",false);
	notesWin.creator=top.MapFrame;
	notesWin.focus();

}

function sendTMaps(IDValue) {
 var TMapsWin = window.open("arcims_tmaps_process.asp?IDValue=" + IDValue,"idWinTMaps","toolbar=0,location=0,directories=0,status=0,menubar=1,resizable=1,scrollbars=1,width=700,height=425");
  TMapsWin.focus();
      TMapsWin.focus();

}

function sendAssessorMisc(IDValue) {
 var assessorWin = window.open("arcims_AssessorMiscProcess.asp?IDValue=" + IDValue,"idWin2","toolbar=0,resizable=1,location=0,directories=0,status=0,menubar=1,scrollbars=1,width=440,height=475");
  assessorWin.focus();
}

function sendAssessor(IDValue) {

 var assessorWin = window.open("assessor.asp?IDValue=" + IDValue,"idWin2","toolbar=0,resizable=1,location=0,directories=0,status=0,menubar=1,scrollbars=1,width=775,height=575");
  assessorWin.focus();
}



function sendRealEstate(theNum) {
      var realestateWin = window.open("","Candidates","toolbar=0,location=0,directories=0,status=0,menubar=1,scrollbars=1,resizable=1,copyhistory=0,width=440,height=445");
   realestateWin.location.href = "arcims_real_estate_process.asp?curAPN="+theNum;
      realestateWin.focus();

}

function sendHistory(theNum) {
      var historyWin = window.open("","Candidates","toolbar=0,location=0,directories=0,status=0,menubar=1,scrollbars=1,resizable=1,copyhistory=0,width=440,height=445");
   historyWin.location.href = "arcims_history_process.asp?IDValue="+theNum+"&curAPN="+theNum+"&theNext=1";
      historyWin.focus();

}

function sendPermit(theNum) {
      var permitWin = window.open("","Candidates","toolbar=0,location=0,directories=0,status=0,menubar=1,scrollbars=1,resizable=1,copyhistory=0,width=435,height=600");
   permitWin.location.href = "arcims_permits_process.asp?IDValue="+theNum;
      permitWin.focus();

}

function sendLanduse(theNum) {
      var landuseWin = window.open("","Candidates","toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,copyhistory=0,width=435,height=445");
  landuseWin.location.href = "arcims_landuse_process.asp?IDValue="+theNum;
      landuseWin.focus();

}

function sendDistricts(theNum) {
      var landuseWin = window.open("","Candidates","toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,copyhistory=0,width=435,height=500");
  landuseWin.location.href = "arcims_districts_process.asp?IDValue="+theNum;
      landuseWin.focus();

}

function sendAPPR(IDValue) {
 var apprWin = window.open("arcims_apprprocess.asp?IDValue=" + IDValue,"idWin2","toolbar=0,location=0,directories=0,resizable=1,status=0,menubar=1,scrollbars=1,width=400,height=475");
      apprWin.focus();
}

function sendAIMS(IDValue) {
 var aimsWin = window.open("arcims_aimsprocess.asp?IDValue=" + IDValue,"idWin2","toolbar=0,location=0,directories=0,resizable=1,status=0,menubar=1,scrollbars=1,width=400,height=475");
      aimsWin.focus();
}

function sendSales(IDValue) {
 var salesWin = window.open("arcims_salesprocess.asp?IDValue=" + IDValue,"idWin2","toolbar=0,resizable=1,location=0,directories=0,status=0,menubar=1,scrollbars=1,width=400,height=475");
      salesWin.focus();
}

function sendGeneral(IDValue) {
//alert("dsaf");
 var genWin = window.open("arcims_general_process.asp?IDValue=" + IDValue,"idWin2","toolbar=0,location=0,directories=0,status=0,menubar=1,scrollbars=1,width=400,height=225");
  genWin.focus();
}

function sendESD(IDValue) {
 var esdWin = window.open("arcims_esd_process.asp?IDValue=" + IDValue,"idWin2","toolbar=0,location=0,resizable=1,directories=0,status=0,menubar=1,scrollbars=1,width=400,height=225");
      esdWin.focus();
}

function sendPhone(IDValue) {
 var phoneWin = window.open("arcims_phone_process.asp?IDValue=" + IDValue,"idWin2","toolbar=0,resizable=1,location=0,directories=0,status=0,menubar=0,scrollbars=1,width=400,height=325");
      phoneWin.focus();
}

</script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>
<body onload="top.HaltLYRHide=0; top.MapFrame.hideLoadingLyr();">

<!--#include file="eRMA_Link_re/GIS_Real_Estate/APN_Search.asp"--> 

<!--#include file="dbParams.asp"--> 
<FONT FACE="Arial,sans-serif" SIZE="-2">
<% 
dbSource = "Provider=SQLOLEDB.1;Initial Catalog=GIS;Server=geoprise2\geoprise2;User Id=giswebuser;Password=giswebuser"
theNum	 =	request("APN")		'The APN number

session("ds") = "Provider=SQLOLEDB.1;" & request("ds")

dbResultFieldList = "cntyap_nbr,situs_add1,situs_add2,name,mail1,mail2,landuse,subdivision, convert(varchar(1),EE_Flag) as EE_Flag"
dbResultFields = Split(dbResultFieldList,",")

dbResultFieldDescriptList = "Parcel ID,Situs Address,Situs City/St/Zip,Owner,Mail Address,Mail City/St/Zip,Landuse Code,Parcel/Subd. No"
dbResultFieldDescript = Split(dbResultFieldDescriptList,",")

dbTable="ParcelsEE"
'Data Extraction / Header **************************************************
'theNum = request.querystring("IDValue")
SQLquery = "SELECT " & dbResultFieldList & " FROM " & dbTable & " WHERE " & dbIDField & " = '"  & theNum & "'" 
response.write "<div align='left'><font color='#0000FF'><b><font size='2'>Data Table For Parcel " & theNum & "</font></b></font></div><br>"
set conntemp=server.createobject("adodb.connection")
conntemp.open session("ds")

response.write vbcrlf & "<!--- SQL: " & SQLquery & "--->" & vbcrlf
'response.write "Connected...<br>"


'**************************************************************************
'Check for Landmark data***************************************************
'**************************************************************************
SQLLandmarkQuery = "SELECT * FROM LANDMARKS WHERE APN = '"  & theNum & "' AND (PRIMARY_FLAG = 'X' OR PRIMARY_FLAG = 'Y')"
set rsLandmark=conntemp.execute(SQLLandmarkQuery)
if NOT rsLandmark.eof then
response.write "<table border='0' width='100%'><tr><td width='100%' bgcolor='#000080'><p align='center'><font color='#FFFF00' size='-2'><b>"&rsLandmark("LANDMARK")&"</b></font></td></tr></table>"
end if
'**************************************************************************

set rstemp=conntemp.execute(SQLquery)

'**************************************************************************
'Check for EE ***************************************************
'**************************************************************************
err.Clear
thisvalue=rstemp(rstemp.fields.count-1)

'response.Write ("'" & isnull(thisvalue) & "'")

'response.Write (err.number & " " & err.Description)
if not isnull(thisvalue)  then
	response.write "<table border='0' width='100%'><tr><td width='100%' bgcolor='#000080'><p align='center'><font color='#FFFF00' size='-2'><b>Early Entry Parcel</b></font></td></tr></table>"
end if
'**************************************************************************

if rstemp.eof then
	theNum2 = left(theNum,10)
	theNum2 = theNum2 & "9999"

	SQLquery = "SELECT " & dbResultFieldList & " FROM " & dbTable & " WHERE " & dbIDField & " >= '"  & theNum & "' and " & dbIDField & " <= '" & theNum2 & "'"

	set rstemp=conntemp.execute(SQLquery)

	if not rstemp.eof then
		response.Write ("<font color=red><hr>NOTE: The parcel selected is a base parcel with many sub-parcels. Displaying sub-parcel information.</font><hr><br>")
	end if
end if

if not rstemp.eof then
		
		varCCR = rstemp("subdivision")

		'Create Tabular Display of Attribute Data***********************************
		howmanyfields=rstemp.fields.count-1
		'howmanyfields=rstemp.fields.count
		'response.write howmanyfields & "<br>"
		recCount = 0
		do while not rstemp.eof
			recCount = recCount + 1
		'	response.write "<b>Record " & recCount & "</b><br>"
			response.write "<TABLE width='100%'>"
			for i=0 to howmanyfields
		if dbResultFieldDescript(i) = "Parcel/Subd. No" then
		else
				'if (i/2 = i\2) then
					'response.write "<TR BGCOLOR='#DDDDDD'>"
				'else 
					response.write "<TR BGCOLOR='#EEEEEE'>"
				'end if
				response.write "<TD><FONT FACE='Arial,sans-serif' SIZE='-2'><B>" & dbResultFieldDescript(i) & "</B></FONT></TD>"
				'response.write "<TR><TD>" & rstemp(i).name & "</TD>"
				response.write "<TD width='75%'><FONT FACE='Arial,sans-serif' SIZE='-2'>"
				thisvalue = rstemp(i)
				if isnull(thisvalue) then
					thisvalue = "&nbsp;"
				end if
				
		'*****************************************
		'******  Landuse Map               *****
		'*****************************************
		if dbResultFieldDescript(i) = "Landuse Code" then
						landuse = "<valign='top'><font face='Arial' size='-2'><b><a href='Javascript:sendLanduse("""&thisvalue&""")'><font color='Blue'>"&thisvalue&"</font></a></b></font>	<font face='Arial' size='-2'>"
						response.write landuse
		else if dbResultFieldDescript(i) = "Parcel ID" then
			apnBook = left(thisvalue, 3)
			apnPage = mid(thisvalue,4,4)
			apnParcel = mid(thisvalue,8,3)
			apnSubParcel = right(thisvalue,4)
			response.write apnBook&"-"&apnPage&"-"&apnParcel&"-"&apnSubParcel
		else
						response.write thisvalue
		end if
		end if
		'*****************************************
						response.write"</FONT></TD>"
						response.write"</TR>"
			end if
			next
			rstemp.movenext
		'*****************************************
		'******      Jurisdiction		     *****
		'*****************************************
						response.write "<TD BGCOLOR='#EEEEEE'><FONT FACE='Arial,sans-serif' SIZE='-2'><B>Jurisdiction</B></FONT></TD>"
						response.write "<TD BGCOLOR='#EEEEEE'><FONT FACE='Arial,sans-serif' SIZE='-2'>"
		
					SQLquery="select * from vwJURISDICTION where APN = '" & theNum &"'"
					'RESPONSE.WRITE SQLquery
					set rsJurisdiction=conntemp.execute(SQLquery)
					
					if rsJurisdiction.EOF then
						response.write "Unincorporated"
					else
						response.write "<valign='top'><font face='Arial' size='-2'>"&rsJurisdiction("DISTRICT")&"</font></td><td><font face='Arial' size='-2'>"
					end if
				response.write"</FONT></TD>"
				response.write"</TR>"
		'*****************************************
		
		'*****************************************
		'******      Supervisor District     *****
		'*****************************************
						response.write "<TD BGCOLOR='#EEEEEE'><FONT FACE='Arial,sans-serif' size='-2'><B>Sup. District</B></FONT></TD>"
						response.write "<TD BGCOLOR='#EEEEEE'><FONT FACE='Arial,sans-serif' size='-2'>"
		
					SQLquery="select * from vwAPN_SUPERVISOR_DISTRICTS where APN = '" & theNum &"'"
					'RESPONSE.WRITE SQLquery
					set rsSuper=conntemp.execute(SQLquery)
					
					if rsSuper.EOF then
						response.write "No Supervisor District record is available in the GIS database."
					else
						response.write "<valign='top'><font face='Arial' size='-2'>"&rsSuper("SUPERVISOR_DISTRICT")&"</font></td><td><font face='Arial' size='-2'>"
					end if
				response.write"</FONT></TD>"
				response.write"</TR>"
		'*****************************************
		
		'*****************************************
		'******      Phone Information       *****
		'*****************************************
						response.write "<TD BGCOLOR='#DDDDDD'><FONT FACE='Arial,sans-serif' size='-2'><B>Phone #</B></FONT></TD>"
						response.write "<TD BGCOLOR='#DDDDDD'><FONT FACE='Arial,sans-serif' size='-2'>"
					SQLquery="select * from vwTELEPHONE_NUMBERS where APN = '" & theNum &"'"
					'RESPONSE.WRITE SQLquery
					set rsPhone=conntemp.execute(SQLquery)
					
					if rsPhone.EOF then
						response.write "Update Phone Info for Production --- No phone record is available in the GIS database."
					else
						response.write "<valign='top'><font face='Arial' size='-2'><b><a href='Javascript:sendPhone(""" & theNum & """)'><font color='Blue'>View Listed Phone Number Info</font></a></b></font></td><td><font face='Arial' size='-2'>"
					end if
				
				response.write"</FONT></TD>"
				response.write"</TR>"
		'*****************************************
		
		'*****************************************
		'******      CUBS Information       *****
		'*****************************************
						response.write "<TD BGCOLOR='#DDDDDD'><FONT FACE='Arial,sans-serif' size='-2'><B>CUBS Info</B></FONT></TD>"
						response.write "<TD BGCOLOR='#DDDDDD'><FONT FACE='Arial,sans-serif' size='-2'>"
						response.write "<valign='top'><font face='Arial' size='-2'><b><a href='Javascript:sendESD(""" & theNum & """)'><font color='Blue'>View CUBS Data</font></a></b></font></td><td><font face='Arial' size='-2'>"
				
				response.write"</FONT></TD>"
				response.write"</TR>"
		'*****************************************
		
		'*****************************************
		'******  General Information  *****
		'*****************************************
						response.write "<TD BGCOLOR='#DDDDDD'><FONT FACE='Arial,sans-serif' size='-2'><B>General Info</B></FONT></TD>"
						response.write "<TD BGCOLOR='#DDDDDD'><FONT FACE='Arial,sans-serif' size='-2'>"
						response.write "<valign='top'><font face='Arial' size='-2'><b><a href='Javascript:sendGeneral(""" & theNum & """)'><font color='Blue'>View General Parcel Data</font></a></b></font></td><td><font face='Arial' size='-2'>"
				
				response.write"</FONT></TD>"
				response.write"</TR>"
		'*****************************************
		
		
		'*****************************************
		'******  Parcel Notes			     *****
		'*****************************************
		'mpcNotes
						response.write "<TD BGCOLOR='#DDDDDD'><a href='Javascript:sendNotes(""" & theNum & """)'><FONT FACE='Arial,sans-serif' size='-2'><B>Parcel Notes</B></FONT></a></TD>"
						response.write "<TD BGCOLOR='#DDDDDD'><FONT FACE='Arial,sans-serif' size='-2'>"

					SQLquery="select NOTE_ID from NOTES_PARCELS where PARCEL_NUMBER = '" & theNum &"'"
					'RESPONSE.WRITE SQLquery
					set rsNotes=conntemp.execute(SQLquery)
					
					if rsNotes.EOF then
	
						SQLquery = "SELECT TAG FROM PARCEL_TAGS WHERE PARCEL_NUMBER = '"  & theNum & "'" 
						set rsTags=conntemp.execute(SQLquery)

						if rsTags.EOF then
							response.write "No Parcel Notes have been recorded in the GIS database."
						else
							response.write "<valign='top'><font face='Arial' size='-2'><b><a href='Javascript:sendNotes(""" & theNum & """)'><font color='Blue'>View Parcel Notes</font></a></b></font></td><td><font face='Arial' size='-2'>"
						end if
					else
						response.write "<valign='top'><font face='Arial' size='-2'><b><a href='Javascript:sendNotes(""" & theNum & """)'><font color='Blue'>View Parcel Notes</font></a></b></font></td><td><font face='Arial' size='-2'>"
					end if
					set rsNotes=nothing
					set rsTags=nothing
					
				response.write"</FONT></TD>"
				response.write"</TR>"
		'*****************************************

			
			
		'*****************************************
		'******  Tentative Maps			     *****
		'*****************************************
				response.write "<TD BGCOLOR='#DDDDDD'><FONT FACE='Arial,sans-serif' size='-2'><B>Tentative Maps</B></FONT></TD>"
				response.write "<TD BGCOLOR='#DDDDDD'><FONT FACE='Arial,sans-serif' size='-2'>"

				SQLquery="select PARCEL_NUMBER from vPLANNING_APPLICATIONS where PARCEL_NUMBER = '" & theNum &"'"
				'RESPONSE.WRITE SQLquery
				set rsTMaps=conntemp.execute(SQLquery)
				
				if rsTMaps.EOF then
					response.write "No Planning Control Data available for this parcel."
				else
					response.write "<valign='top'><font face='Arial' size='-2'><b><a href='Javascript:sendTMaps(""" & theNum & """)'><font color='Blue'>View Planning Control Data</font></a></b></font></td><td><font face='Arial' size='-2'>"
				end if
				set rsTMaps=nothing
					
				response.write"</FONT></TD>"
				response.write"</TR>"
		'*****************************************


			
		'*****************************************
		'******  Recorders Map               *****
		'*****************************************
						response.write "<TD BGCOLOR='#DDDDDD'><FONT FACE='Arial,sans-serif' size='-2'><B>Record Map</B></FONT></TD>"
						response.write "<TD BGCOLOR='#DDDDDD'><FONT FACE='Arial,sans-serif' size='-2'>"
		'				thisvalue = rstemp(i)
				              Dim varCCR, varBook, varPage, varMapType
		'	                varCCR = rstemp("subdivsio")
response.write ("<!---varCCR: " & varCCR & "--->")
			                varBook = Mid(varCCR, 2, 3)
			                varPage = Mid(varCCR, 5, 3)
			                varMapType = Left(varCCR, 1)
			                If Trim(varCCR) <> "" Then
			                    If varMapType = "S" Then
			                    thisvalue = "<valign='top'><font face='Arial' size='-2'><b><a href=http://ccrmaps.finance.saccounty.net/mz_qresult_map.asp?doccode=435&book=" & varBook & "&page=" & varPage & " target=_new><font color='Blue'>View Subdivision Maps</font></a></b></font></td><td><font face='Arial' size='-2'>"
			                    else If varMapType = "P" Then
			                    thisvalue = "<valign='top'><font face='Arial' size='-2'><b><a href=http://ccrmaps.finance.saccounty.net/mz_qresult_map.asp?doccode=433&book=" & varBook & "&page=" & varPage & " target=_new><font color='Blue'>View Recorded Parcel Maps</font></a></b></font></td><td><font face='Arial' size='-2'>"
			                     Else
			                    thisvalue = "<valign='top'><font face='Arial' size='-2' >No maps are available for this parcel</a></font></td><td><font face='Arial' size='-2'>"
			  					End if
								End If
			 				Else
			                    thisvalue = "<valign='top'><font face='Arial' size='-2'>No maps are available for this parcel</a></font></td><td><font face='Arial' size='-2'>"
			 	            End If
					response.write thisvalue
				response.write"</FONT></TD>"
				response.write"</TR>"
		'*****************************************


		
		'*****************************************
		'******  Real Estate                *****
		'*****************************************
		
		curAPN = theNum
				response.write "<TD BGCOLOR='#DDDDDD'><FONT FACE='Arial,sans-serif' size='-2'><B>RE Easements</B></FONT></TD>"
				response.write "<TD BGCOLOR='#DDDDDD'><FONT FACE='Arial,sans-serif' size='-2'>"


			apnBook = left(curAPN, 3)
			apnPage = mid(curAPN,4,4)
			apnParcel = mid(curAPN,8,3)
			APN_FileNet = apnBook &"-"& apnPage &"-"& apnParcel

'If Pull_eRMA_Link(APN_FileNet, 1) <> "" Then

'	                    thisvalue = "<valign='top'><font face='Arial' size='-2'><b><a href='javascript:sendRealEstate(""" & theNum & """);'><font color='Blue'>View County Real Estate Easement Documents</font></a></b></font></td><td><font face='Arial' size='-2'>"
'	                Else
'	                    thisvalue = "<valign='top'><font face='Arial' size='-2'>No Real Estate Easement Documents are available for this parcel</a></font></td><td><font face='Arial' size='-2'>"
'	 	            End If
thisvalue = "<valign='top'><font face='Arial' size='-2'>Real Estate Easement Documents are presentily unavailable</a></font></td><td><font face='Arial' size='-2'>"

				response.write thisvalue
				response.write"</FONT></TD>"
				response.write"</TR>"
		
		
		'*****************************************
		
		
		'*****************************************
		'******  Deed of Trust               *****
		'*****************************************
						response.write "<TD BGCOLOR='#DDDDDD'><FONT FACE='Arial,sans-serif' size='-2'><B>Deed</B></FONT></TD>"
						response.write "<TD BGCOLOR='#DDDDDD'><FONT FACE='Arial,sans-serif' size='-2'>"
					SQLquery="select RECORDERS_DATE, RECORDERS_PAGE from AIMS where CNTYAP_NBR = " & theNum
					'RESPONSE.WRITE SQLquery
					set rsDeed=conntemp.execute(SQLquery)
					
					if rsDeed.EOF then
							thisDeed = "<valign='top'><font face='Arial' size='-2' >No Property Transfer Document record in database for this parcel.</a></font></td><td><font face='Arial' size='-2'>"
					else
							dim mediaCheck, ccrPage, verifyMonth, verifyDay
							mediaCheck = rsDeed("RECORDERS_DATE")
							ccrPage = rsDeed("RECORDERS_PAGE")
							verifyMonth = mid(mediaCheck, 3, 2)
							verifyDay =  mid(mediaCheck, 5, 2)
		
							if verifyMonth < 13 and verifyDay < 32 then
		
									if mediaCheck > "010000"  and mediaCheck < "100000" then
									thisDeed = "<valign='top'><font face='Arial' size='-2'><b><a href=http://or-imaging.finance.saccounty.net/mz_qresult_or.asp?Book=20"&mediaCheck&"&Page=" & ccrPage & " target=_new><font color='Blue'>View Property Transfer Document</font></a></b></font></td><td><font face='Arial' size='-2'>"
									else if mediaCheck < "010000"  and mediaCheck > "000000" then
									thisDeed = "<valign='top'><font face='Arial' size='-2' color='#0000FF'><b>Microfiche Index is 20"& mediaCheck&", "&ccrPage&"</a></b></font></td><td><font face='Arial' size='-2'>"
									else
									thisDeed = "<valign='top'><font face='Arial' size='-2' color='#0000FF'><b>Microfiche Index is 19"& mediaCheck&", "&ccrPage&"</a></b></font></td><td><font face='Arial' size='-2'>"
									end if
									end if
							
							else
							
									thisDeed = "<valign='top'><font face='Arial' size='-2' >No Deed record in database for this parcel.</a></font></td><td><font face='Arial' size='-2'>"
									
							end if	
					end if
					rsDeed.close
					set rsDeed=nothing
				response.write thisDeed
				
				response.write"</FONT></TD>"
				response.write"</TR>"
		'*****************************************
		
		'*****************************************
		'******  Permit Information          *****
		'*****************************************
						response.write "<TD BGCOLOR='#DDDDDD'><FONT FACE='Arial,sans-serif' size='-2'><B>Building Permits</B></FONT></TD>"
						response.write "<TD BGCOLOR='#DDDDDD'><FONT FACE='Arial,sans-serif' size='-2'>"
					SQLquery="select * from PERMITS where PARCEL_NUMBER = '" & theNum&"'"
					'RESPONSE.WRITE SQLquery
					set rsPermit=conntemp.execute(SQLquery)
					
					if rsPermit.EOF then
							thisPermit = "<valign='top'><font face='Arial' size='-2' >No Permit record in database for this parcel.</a></font></td><td><font face='Arial' size='-2'>"
					else
		'					thisPermit = "<valign='top'><font face='Arial' size='-2'><b><a href=arcims_permits_process.asp?IDValue="&theNum&" target=_new>View Permit Data</a></b></font></td><td><font face='Arial' size='-2'>"
							thisPermit = "<valign='top'><font face='Arial' size='-2'><b><a href='Javascript:sendPermit("""&theNum&""")'><font color='Blue'>View Permit Data</font></a></b></font></td><td><font face='Arial' size='-2'>"
					end if	
					rsPermit.close
					set rsPermit=nothing
				response.write thisPermit
				
				response.write"</FONT></TD>"
				response.write"</TR>"
		'*****************************************
		
		'*****************************************
		'******  Parcel History Information  *****
		'*****************************************
						response.write "<TD BGCOLOR='#DDDDDD'><FONT FACE='Arial,sans-serif' size='-2'><B>Parcel History</B></FONT></TD>"
						response.write "<TD BGCOLOR='#DDDDDD'><FONT FACE='Arial,sans-serif' size='-2'>"

'mpchistory===================================================================
Application("PSD_ConnectionString") = "Provider=MSDAORA.1; Data Source=psd; User ID=gis; Password=gis@psd;Persist Security Info=True;"
Application("PSD_ConnectionTimeout") = 15
Application("PSD_CommandTimeout") = 30
Application("PSD_CursorLocation") = 3
Application("PSD_RuntimeUserName") = "gis"
Application("PSD_RuntimePassword") = "gis@psd"
'-- In the .asp ----------------------
Dim cnnPSD, rsPSD, strSQL
Set cnnPSD = Server.CreateObject("ADODB.Connection")
cnnPSD.CommandTimeout = 30
cnnPSD.ConnectionTimeout = 20
cnnPSD.Open Application("PSD_ConnectionString"), Application("PSD_RuntimeUsername"), Application("PSD_RuntimePassword")
strSQL = "SELECT COUNT(*) FROM PSD.V_PARCEL_HISTORY where PARCEL_NUMBER ='" & theNum & "'"
'strSQL = "select * from V_P_HISTORY where NEW_PARCEL_NUMBER = '" & theNum & "'"
Set rsPSD = Server.CreateObject("ADODB.RecordSet")
rsPSD.Open strSQL, cnnPSD, adOpenDynamic
'======================================
   
'					If rsPSD.eof Then
varCount = cint(rsPSD("COUNT(*)"))
					If varCount < 1 Then
					'response.write rsPSD("count(*)")
							thisHistory = "<valign='top'><font face='Arial' size='-2' >No Parcel History records in database for this parcel.</a></font></td><td><font face='Arial' size='-2'>"
					else
					thisHistory = "<valign='top'><font face='Arial' size='-2'><b><a href='Javascript:sendHistory("""&theNum&""")'><font color='Blue'>View Splits and Merges History Data</font></a></b></font></td><td><font face='Arial' size='-2'>"
									
					end if	
				response.write thisHistory
				
				response.write"</FONT></TD>"
				response.write"</TR>"
		'*****************************************		
		'*****************************************
		'******  Parcel District Information  *****
		'*****************************************
						response.write "<TD BGCOLOR='#DDDDDD'><FONT FACE='Arial,sans-serif' size='-2'><B>Fee Districts</B></FONT></TD>"
						response.write "<TD BGCOLOR='#DDDDDD'><FONT FACE='Arial,sans-serif' size='-2'>"
					'SQLquery="select * from vwAPN_FEE_DESCRIPTIONS where APN = '" & theNum &"'"
					'RESPONSE.WRITE SQLquery
					'set rsDistrict=conntemp.execute(SQLquery)
					'response.write "count"&rsDistrict.RecordCount
					'if rsDistrict.EOF then
						'thisDistrict = "<valign='top'><font face='Arial' size='-2' >No Fee District records in database for this parcel.</a></font></td><td><font face='Arial' size='-2'>"
		'			else
					thisDistrict = "<valign='top'><font face='Arial' size='-2'><b><a href='Javascript:sendDistricts("""&theNum&""")'><font color='Blue'>View District Data</font></a></b></font></td><td><font face='Arial' size='-2'>"
									
		'			end if	
		'			rsDistrict.close
		'			set rsDistrict=nothing
				response.write thisDistrict
				
				response.write"</FONT></TD>"
				response.write"</TR>"
		'*****************************************
		
		'******************************************
		'******  	New Assessor Information  *****
		'******************************************
		
						response.write "<TD BGCOLOR='#DDDDDD'><FONT FACE='Arial,sans-serif' size='-2'><B>Assessor Info</B></FONT></TD>"
						response.write "<TD BGCOLOR='#DDDDDD'><FONT FACE='Arial,sans-serif' size='-2'>"
						response.write "<valign='top'><font face='Arial' size='-2'><b><a href='Javascript:sendAssessor(""" & theNum & """)'><font color='Blue'>View Assessor Data</font></a></b></font></td><td><font face='Arial' size='-2'>"
				
				response.write"</FONT></TD>"
				response.write"</TR>"
		
		
		'******************************************
		
		
		'******************************************
		'******   Addnl Assessor Information  *****
		'******************************************
		
if	varEarlyEntry = 1 then
response.write"-"
response.write"</FONT></TD>"
response.write"</TR>"

response.write "<TD BGCOLOR='#DDDDDD'><FONT FACE='Arial,sans-serif' size='-2'><B>Additional Assessor Info</B></FONT></TD>"
response.write "<TD BGCOLOR='#DDDDDD'><FONT FACE='Arial,sans-serif' size='-2'>"
response.write"-"
response.write"</FONT></TD>"
response.write"</TR>"
else

					SQLquery4 = "SELECT * from SALES_MASTER where CNTYAP_NBR = '"  & theNum & "'"
					set rstemp4=conntemp.execute(SQLquery4)
					
						response.write "<TD BGCOLOR='#DDDDDD'><FONT FACE='Arial,sans-serif' size='-2'><B>Additional Assessor Info</B></FONT></TD>"
						response.write "<TD BGCOLOR='#DDDDDD'><FONT FACE='Arial,sans-serif' size='-2'>"
					if rstemp4.eof = true then
					checkSales = ""
					else
					checkSales = rstemp4("MAPBOOK") + rstemp4("PAGE") + rstemp4("PARCEL") + rstemp4("PARCEL_SUB")
					end if
								
					if checkSales = theNum then
					response.write "<valign='top'><font face='Arial' size='-2'><b><a href='Javascript:sendAssessorMisc("""&theNum&""")'><font color='Blue'>View Additional Assessor Data</font></a></b></font></td><td><font face='Arial' size='-2'>"
					else
					response.write	"<valign='top'><font face='Arial' size='-2' >No Additional Assessor data records in database for this parcel.</a></font></td><td><font face='Arial' size='-2'>"
					end if
					set checkSales = nothing
end if
				response.write"</FONT></TD>"
				response.write"</TR>"
					
		'*********************************************
		
		'******************************************
		'*****   Assessor FileNET Integration  ****
		'******************************************


		response.write "<TD BGCOLOR='#DDDDDD'><FONT FACE='Arial,sans-serif' size='-2'><B>Assessor Maps</B></FONT></TD>"
		response.write "<TD BGCOLOR='#DDDDDD'><FONT FACE='Arial,sans-serif' size='-2'>"
		response.write "<valign='top'><font face='Arial' size='-2'><b>"

		docPage =left(apnPage, 3)
		SQLassessor = "execute sproc_ERMA_INTGR_ASSESSOR @Option = 'Get_Map_Pages',@Book = '"&apnBook&"',@Page = '"&docPage&"',@Lib = 'assessorlib',@MaxDocs = '50'"
		response.write "<a href=""javascript:sendAssessorImage('"& apnBook & "','" & docPage & "')"">View Assessor Map</a>"
				
		response.write"</FONT></TD>"
		response.write"</TR>"

		'*******************************************
		
			response.write"</TABLE><br>"
		loop
else
theNum2 = left(theNum,10)
theNum2 = theNum2 & "9999"
response.write theNum & " - " & theNum2
'response.write "<SCRIPT LANGUAGE='JavaScript' TYPE='text/javascript'>"
'response.write " var newWin2 = window.open('','Candidates','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=0,copyhistory=0,width=450,height=375');"
'response.write "newWin2.location.href = 'parcel_id_process.asp?apn=" & theNum & "&apn2=" & theNum2 & "&type=X';"
'response.write "newWin2.focus();"
'response.write "window.close();"
'response.write "</script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>"
'response.write "There is a data problem associated with this parcel.  Please notify Mark Perry at 875-6372."
end if

rstemp.close
set rstemp=nothing
conntemp.close
set conntemp=nothing
'response.write "<TABLE width='100%'><tr><td><p align='right'><!---<input type=button name=btnClose value='Close' onclick='window.close()'>--->&nbsp;</tr></td></TABLE>"	
'response.write "<TABLE width='100%'><tr><td><p align='right'><input type=button name=btnPrint value='Print' onclick='window.print()'>&nbsp;</tr></td></TABLE>"	

'Real Estate
Public Function Pull_eRMA_Link(s_APN, iSource)
'- Check to see if documents exist for passed APN number

b_Exists = Retrieve_DocID(s_APN, iSource)
If cbool(b_Exists) = True Then
	Pull_eRMA_Link =  Build_Submit_APN_Body(s_APN, iSource)
End If

End Function


 %>

<center><br><input type=button class=Btn value="Print" onclick="window.print();" ID="Button1" NAME="Button1"><br><br></center>
 
</FONT></body>
</html>
