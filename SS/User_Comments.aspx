<%@ Page CodeBehind="User_Comments.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="dotNETViewer.User_Comments" %>
<%
'************************************************************************************************************************************
'	ASPX PAGE
'
'	This ASPX page serves as the presentation layer while the VB page serves as the code page.  In some cases, I utilize a public 
'	variable named INFORMATION to dynamically generate HTML which is then displayed on the presentation layer (ASPX page).  Simply 
'   including the value of this public variable will effectively include that dynamically generated HTML code at run-time. The 
'   purpose of this page is to display formatted information to the user.  This ASPX page is dynamically generated with 
'   each page request.  Take note that not all portions of the HTML code will be displayed with each page request due to various
'   conditions.  Please see the special notes section for more explanation (if applicable).
'
'	SPECIAL NOTES regarding this ASPX page:
'	
'	Inclusion of the header.aspx file (located in the includes filder) allows the user of a common 'header' for all ASPX files.
'	By including this file, a common CSS can be shared and 'included' throughout all ASPX pages.
'
'	The purpose of this page is to provide the HTML interface to the user comments pop-up window.
'
'************************************************************************************************************************************
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<BODY onload="try {document.frmGIS.theName.focus();} catch(e){};">

<%
On Error Resume Next
response.expires = -7

Dim UCType as integer

UCType=0

If (Application("ClientName") = "SacCountyAssessor") or _
	(Application("ClientName") = "RegionalGIS") or _
	(Application("AppType")="EconDev") Then
		UCType=1
end if

if UCType=1 then
%>
<script language='JavaScript' type='text/javascript'>
function validate() {
	//This function validates to make sure that the appropriate form fields actually have been filled out.
	//Sac county assessor ONLY
	if (document.frmGIS.theName.value=='') {
		alert ("Please enter a valid name.");
		return;
	}
	if (document.frmGIS.theReturnAddress.value=='') {
		alert ("Please enter a valid eMail Address.");
		return;
	}
	if ((document.frmGIS.AssessorParcelNum1.value=='')&&(document.frmGIS.AssessorParcelNum2.value=='')&&(document.frmGIS.AssessorParcelNum3.value=='')&&(document.frmGIS.AssessorParcelNum4.value=='')&&(document.frmGIS.AssessorAddress1.value=='')&&(document.frmGIS.AssessorAddress2.value=='')) {
		alert ("Please enter the assessor parcel number OR the property address.");
		return;
	}
	if (document.frmGIS.theBodyText.value=='') {
		alert ("Please enter some comments.");
		return;
	}
	
	//Submit the form.
	document.frmGIS.submit();
}

	function smartfocus (curr,nxt,v) {
		//This cool function will advance the cursor to the next designated textbox once a specific character length has been
		//reached in a 'prior' textbox.
		if (curr.value.length>(v-1)) {
			nxt.focus();
		}
	}

</script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>
<%else%>
<script language='JavaScript' type='text/javascript'>
function validate() {
	//No validation to be done - just submit the form.
	
	document.frmGIS.submit();
}

	function smartfocus (curr,nxt,v) {
		//This cool function will advance the cursor to the next designated textbox once a specific character length has been
		//reached in a 'prior' textbox.
		if (curr.value.length>(v-1)) {
			nxt.focus();
		}
	}

</script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>

<%end if%>
<%=Information%>
