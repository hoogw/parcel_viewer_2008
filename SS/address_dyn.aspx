<%@ Page Language="vb" AutoEventWireup="false" Codebehind="address_dyn.aspx.vb" Inherits="dotNETViewer.address_dyn" %>
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
'	hideLoadingLyr() - In the body's onload clause, this javascript function is executed.  This function resides in nav.js and the
'	purpose of this function is to hide the layer which houses the loading image.
'
'	The purpose of this page is to provide the HTML interface to dynamically search on an address.  This search page does NOT utilize
'	the search_all.aspx page - it has its own custom processing page.
'
'************************************************************************************************************************************
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<TITLE>Address Input Form</TITLE>
		<%
On Error Resume Next
%>
		<style type="text/css" title=""> body { font-family: helvetica, arial; font-size: small; }
	</style>
		<script language='JavaScript' type='text/javascript'>
<!--

// Works best on IE, have done only limited work in porting to Netscape

// Array (partial) of Toowoomba Street Names
var Names = new Array(<%=Addresses%>);

/*
	Array (partial) of intersecting streets matching each element of the Names array
	eg Zupps Road intersects with Names[1146], Names[1309] and Names[300]
	This obviously won't work because the Names array is not complete but I've left it in the
	original state to convey the principal.
	To patch it to work, just change all numbers below randomly up to 13.
*/
var XSect = new Array(
 "1146,1309,300",
 "1520",
 "1185,1175",
 "855,462",
 "1252",
 "477,843,524,1491,827,612",
 "109,197",
 "797,69",
 "543,554,1286",
 "228,81,485,1345,1316,1031,1197,225",
 "477,1289,769,619,517,805,67",
 "103,883,235,162",
 "165,839,1402,117,72",
 "655,208,718,956,266,895,389,617,1249,1035,1395,63,1242,1109"
 );

/*
	Feature id's of the intersection polygon.
	Relates to each index and entry of the XSect array
*/
var Fids = new Array(
 "42288,42290,43126",
 "35064",
 "46767,46905",
 "30171,30516",
 "39514",
 "5989,5989,6012,6025,6026,6042",
 "4481,4483",
 "8343,8382",
 "44252,44254,44518",
 "18661,18682,18684,27923,27925,27927,27927,27927",
 "5947,6785,6786,6813,6843,13487,43602",
 "21199,21199,21626,21628",
 "7535,8303,8305,47347,47349",
 "28246,28311,28311,39602,39604,39606,39608,40094,40397,40397,40399,40401,40404,48676"
 );

// remove all values from an html SELECT (ie a list) object
function emptyList( list ) {
	while( list.options.length > 0 )
		list.options.remove(0);

	/* // for Netscape
	while( list.options.length > 0 ) {
		list.options[list.options.length-1] = null;
	}
	*/
}

// add an option to an html SELECT (list) object
function addToList( list, text, value ) {

	var newOption = document.createElement("OPTION");
	newOption.text = text;
	newOption.value = value;
	list.add( newOption, 0 );

	/* // for Netscape
	var newOption = new Option( text, value );
	list.options[list.options.length] = newOption;
	*/
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function changeList() {
	var index;
	var stub = document.theForm.theStreet.value.toUpperCase();
	var len = stub.length;
	var list1 = document.theForm.streetList1

// clear the options
	emptyList( list1 );

// check if the stub field is empty
	if( stub == "" ) {
		return;
	}

// refill the list based on the stub
	for (index in Names) {
		if( Names[index].substring( 0, len ) == stub )
			addToList( list1, Names[index], index );
	}

}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function selectStreet() {
	var theOption = document.theForm.streetList1.options(document.theForm.streetList1.selectedIndex)
	document.theForm.theStreet.value = theOption.text;
	showIntersections( theOption.value );
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function showIntersections( nameIndex) {
	var index;
	var item;
	var list2 = document.theForm.streetList2

// clear the options
	emptyList( list2 );

// index = -1 just force a clear list and returns
	if( nameIndex < 0 )
		return;

	var intString = XSect[nameIndex];
	var intList = intString.split( "," );
	var fidString = Fids[nameIndex];
	var fidList = fidString.split( "," );

// refill the list
	for (item in intList) {
		var index = parseInt(intList[item])
		addToList( list2, Names[index], fidList[item] );
	}
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function find() {
	var f = document.theForm;
	var theNumber = "";
	var theSuffix = "";
	var theStreet = "";
	var theLot = "";
	var thePlan = "";

	theNumber = f.theNumber.value;
	theSuffix = f.theSuffix.value;
	theStreet = f.theStreet.value;
	theLot = f.theLot.value;
	thePlan = f.thePlan.value;

	// check to see what information we have and then make a judgement on what to search for

	if( f.streetList2.selectedIndex >= 0 && theStreet != "") {
	// were are looking for an intersection
		t.getIntersection( f.streetList2.options(f.streetList2.selectedIndex).value );
		return;
	}

	// must now have at least a street or a plan number
	if ( theStreet == "" && thePlan == "" ) {
		alert("Please enter a MINIMUM of Street Name OR a Survey Plan Number.");
		return;
	}

	// do a couple of nonsense checks
	if( theStreet != "" && thePlan != "" ) {
		alert("Can't search for a Street Name AND a Survey Plan Number at the same time.");
		return;
	}

	if( (theNumber != "" || theSuffix != "") && (theLot != "" || thePlan != "") ) {
		alert("Can't search for Street Address AND Survey Plan details at the same time.");
		return;
	}

	if( (theNumber != "" && isNaN(parseInt(theNumber))) ||
		(theLot != "" && isNaN(parseInt(theLot))) ) {
		alert( "Can't search if the house or lot number is not a number." );
		return;
	}

	if( theSuffix != "" && !isNaN(parseInt(theSuffix)) ) {
		alert( "Can't search is the suffix contains a number." );
		return;
	}

	if( thePlan != "" && !isNaN(parseInt(thePlan)) ) {
		alert( "Can't search is the survey plan is not properly formatted (does not contain a number)." );
		return;
	}

	// check to see if only one enrty if first street list
	if( f.streetList1.options.length == 1 )
		theStreet = f.streetList1.options[0].text;

	// have enough information to do a search
	t.getAddress( theNumber, theSuffix, theLot, thePlan, theStreet );
}

//-->
		</script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>
		<script language='JavaScript' type='text/javascript'>
	function sendAddress(Value1,Value2) {
		top.MapFrame.positionLoadingLyr();
		document.location = "../Custom/custom_srch_address.asp?Num1=" + Value1 + "&StreetName=" + Value2 + "&ds=<%=Server.UrlEncode(Application("dbSource"))%>";
	}	

		</script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>
		<!--#include file="../includes/header.aspx"-->
	</HEAD>
	<BODY leftmargin="20" onload="top.MapFrame.hideLoadingLyr()">
		<FORM name="theForm" action="javascript:sendAddress(theForm.stno.value,theForm.theStreet.value);" method="post">
			<FONT class="SSHdr1">Please enter the following information</FONT><br>
			<br>
			<P>House Number:<br>
				<input type="text" name="stno" size="24"><br>
				Street Name:<br>
				<input type="text" name="theStreet" size="24" onKeyUp="changeList()" onKeyPress="if(self.event.keyCode==8){changeList()}"><br>
				<br>
				<select  class=HTMLFrmObjects  name="streetList1" size="6" onClick="selectStreet()">
				</select>
				<input type="submit" value="Find Addresses" name="submit"><br>
				<br>
			</P>
		</FORM>
		<FONT class="SSMsg2">Please enter the first one or more letters of the street name 
			you are searching for. A dynamic list of street names will be created based on 
			your entry and you may then select the appropriate street from that list. If 
			you know the street number you are looking for, enter that in the 'House 
			Number' box. Finally select the 'Find Addresses' button to view a list of 
			candidate addresses.</FONT><br>
		<br>
		<a href="address.aspx">Click Here</a> to return to the standard address search.
	</BODY>
</HTML>
