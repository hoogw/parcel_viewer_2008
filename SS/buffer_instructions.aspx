<%@ Page CodeBehind="buffer_instructions.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="dotNETViewer.buffer_instructions" %>
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
'	The purpose of this page is to provide the HTML interface to display instructions pertaining to buffering.
'
'************************************************************************************************************************************
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<TITLE>buffer_instructions</TITLE> 
		<!--#include file="../includes/header.aspx"-->
	</HEAD>
	<BODY>
		<U>
			<P><FONT class="ssmsg1">BUFFER TOOL INSTRUCTIONS</FONT><BR>
		</U>
		<%if DispML then%>
		(mailing labels tips below)
		<%end if%>
		</P><U></U> <FONT class="ssmsg2">
		<OL>
<LI>Choose the desired 'Selection Layer'. This determines which spatial feature you'll buffer around. </li>
<LI>Choose the desired 'Selection Type'. This determines how you will select the spatial features from the specified layer. For example, if the 'Selection Layer' is 'Parcels', and the 'Selection Type' is 'Line', then you must draw a line on the map with the mouse. Every 'Parcel' that is intersected by the line will be selected. If the 'Selection Layer' is 'Parcels', and the 'Selection Type' is 'Polygon', then you must draw a polygon on the map with the mouse. Every 'Parcel' that is contained within or intersected by the polygon will be selected. </li>
<LI>Click on 'Complete & Select' This moves the process to the second screen and allows you to select a 'Set' of graphical features off of the map. </li>
<LI>Choose the 'Buffer Distance'. This determines the buffer distance around the selected 'Set'. </li>
<LI>Choose the 'Buffer Layer'. This determines which layer to query within the buffer area. For example, the selected 'Set' can be a 'Street Centerline' and the 'Buffer Layer' can be 'Parcels'. They do not have to be the same. </li>
<LI>Choose ‘Display Fields'. Using your mouse and the shift/ctrl keys, select one or many fields from 'Display Fields' to display in the results table. The results can be printed or downloaded in CSV (comma separated value) file format for use in other software such as word processors or spreadsheets. </li>
<LI>Click the 'Buffer' button to execute the buffer process.</li>
			</ol>
		</FONT>
		<%if DispML then%>
		<FONT class="ssmsg1">MAILING LABELS</FONT><br>
		<br>
		<FONT class="ssmsg2">
			<OL>
<LI>If 'Parcels' was selected as the 'Buffer Layer', a Mailing Labels option will appear at the bottom of the results table. You may be required to scroll down to bring it into view. Mailing labels can be generated for Resident/Situs Address, Property Owner Address, or both. If both is selected, redundant addresses will be filtered out (an owner residing at the Situs Address, will have only one label). </li>
<LI>When clicking on the Mailing labels 'Continue' button, a new window is created and Mailing Labels are presented. The labels are configured for printout on Avery 5160 Mailing Label sheets. When clicking on the Mailing labels 'CSV Download' button, a new .csv file is created and can be downloaded to a local drive. </li>
			</ol>
			<P><b>TIP - MAILING LABELS FOR USER DEFINED AREA</b>:
				<br>
				<br>
To generate a mailing list for a selected polygon area only (no buffer), perform the following: 
				<br>
				<OL>
<LI>Use the 'Polygon' option for the 'Selection Type', 'Parcels' for the 'Selection Layer'. </li>
<LI>Click on the map to draw your polygon area of interest, then, choose 'Complete & Select'. </li>
<LI>Select '0' for 'Buffer Distance' , 'Parcels' for 'Buffer Layer', Accept the defaults for 'Display Fields', and click on the 'Buffer' button. </li>
<LI>Scroll down to bottom of the results table and select the desired mailing label options. </li>
						<P></P>
		</FONT></LI></OL>
		<br>
		<br>
		<%end if%>
	</BODY>
</HTML>
