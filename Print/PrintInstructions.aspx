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
'	The purpose of this page is to display instructions related to printing.
'	
'************************************************************************************************************************************
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<TITLE>Print Instructions</TITLE> 
		<!--#include file="../includes/header.aspx"-->
	</HEAD>
	<BODY>
		<CENTER><b>Print Module Instructions</b></CENTER>
		<br>
		<P>This module allows you to print the current map display based on specific 
			selected settings:</P>
		<OL>
			<LI>
			Select the desired paper size by clicking one of the two default radio buttons 
			from the Paper Size section of the Print dialog. Alternately, you may enter a 
			custom paper size by selecting the blank radio button and entering the desired 
			paper dimensions into the text boxes provided
			<LI>
			Select the map scale by clicking one of the two default radio buttons from the 
			Map Scale section of the Print dialog. Alternately, you may enter a custom 
			scale by selecting the blank radio button and entering the desired map scale 
			into the text box provided
			<LI>
			Select the paper orientation by clicking the appropriate radio button from the 
			Orientation section of the Print dialog
			<LI>
			Select whether or not to print the map in color or black/white by clicking the 
			appropriate radio button from the Color Mode of the Print dialog
			<LI>
			Enter a title for the printed map into the Print Title text box of the Print 
			dialog
			<LI>
			Click the Preview icon to preview the printed map
			<LI>
				Click the Print icon to print the map</li>
		</ol>
		<br>
		<b>Note: The following icons are provided for use in the Print Module: </b>
		<ul>
		<LI>
			Zoom In: Zooms in on the map display
		</li>
		<LI>
			Zoom Out: Zooms out on the map display
		</li>
		<LI>Pan: Pans the map display</li>
		<LI>Refresh: Refreshes the map display</li>
		<LI>Preview: Previews the map to be printed</li>
		<LI>Print: Prints the map (must be in preview mode)</li>
		<LI>Save: Saves the map to an external file (must be in preview mode)</li>
		<LI>Change: Exits preview mode in order to allow you to make changes to the map display prior to printing</li>
		</ul>
	</BODY>
</HTML>
