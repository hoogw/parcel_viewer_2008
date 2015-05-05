<%@ Page Language="vb" AutoEventWireup="false" Codebehind="BookmarkInstructions.aspx.vb" Inherits="dotNETViewer.BookmarkInstructions"%>
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
'	The purpose of this page is to display instructions related to bookmarking.
'
'************************************************************************************************************************************
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
  <HEAD>
    <TITLE>Bookmark Instructions</TITLE>
		<!--#include file="../includes/header.aspx"-->
  </HEAD>

  <BODY MS_POSITIONING="GridLayout">
		<TABLE height="244" cellSpacing="0" cellPadding="0" width=95% border="0" ms_2d_layout="TRUE">
			<TR vAlign="top">
				<TD width="10" height="15"></TD>
				<TD width="40"></TD>
				<TD width="1245"></TD>
			</TR>
			<TR vAlign="top">
				<TD height="38"></TD>
				<TD colSpan="2" align=center>
					<FONT class="ssHdr1">Bookmark Instructions</FONT>
				</TD>
			</TR>
			<TR vAlign="top">
				<TD colSpan="2" height="191"></TD>
				<TD>
				<FONT class=SSRow1>A bookmark can be created to capture all settings that are in the map view.  These settings can include: layer visibility, highlighted features, search results, buffer results, measure distance/ area, and drawing tool objects.</FONT>
					<OL>

<LI>Click on ‘Create a Bookmark’ when ready to capture desired map view.  This will move the process to the ‘Create a Bookmark’ screen.  First, enter the UserName and the Bookmark Name in the input boxes to the right.  Next, enter the Expiration Date for when the Bookmark will no longer be needed.  Click the drop down box for the year, and then click on the day in the calendar below.  Third, click on either ‘Public’ or ‘Private’.  If ‘Public’ is clicked, it will make the bookmarked map available for all users to view.  If ‘Private’ is clicked, it will require the user to enter the ‘UserName’ in order for accessing the bookmarked map.  After all above information is complete, click ‘Submit’.  This will move the process to the ‘Bookmark Creation’ screen.  This screen will tell the user if the creation was successful or not, and it will also provide the UserName and the Bookmark Name. Last, click on ‘Start Over’ to return to the ‘Bookmarks’ screen.  </li>
<LI>To view public bookmarks, simply click on the drop down arrow and select the desired bookmark name.  To view private bookmarks, enter a username, and then click on the ‘Look Up’ tab.  Then click on the drop down arrow below and choose one of the bookmarks available.  </li>
<LI>Click on ‘Delete a Bookmark’ when ready to delete a private bookmark when it is no longer needed.  This will move the process to the ‘Delete a Bookmark’ screen.  Enter the username, click on the ‘Look Up’ tab, and then click the drop down arrow below to select the bookmark to delete.  Then click ‘Delete’.  Next, repeat the process to delete more bookmarks, or click ‘Back’ to return to the ‘Bookmarks’ screen. </li>
</ol>
</TD>
</TR>

			<TR vAlign="top">
				<TD height="38"></TD>
				<TD colSpan="2" align=center>
					<FONT class="ssHdr1">Bookmark Drawing Tools Instructions</FONT>
				</TD>
			</TR>

			<TR vAlign="top">
				<TD colSpan="2" height="191"></TD>
				<TD>
				<FONT class=SSRow1>Bookmark drawing tools can be used to add custom drawings to the map view before the creation of a bookmark.  If a bookmark has already been created and the user wishes to add drawings to that same view, a new bookmark must be created with a different name.</FONT>
					<OL>
<LI>Click on the ‘Drawing Tools’ tab located on the ‘Bookmarks’ screen.  This will move the process to the ‘Bookmark Drawing Tools’ screen.  The drawing tools consist of 5 objects that can be created and applied to the map; point or line, polygon, circle, and text label.     </li>
<LI>To place a point or draw a line on the map, select the ‘Point or Line’ object.  When placing a point, select a point on the map and then click on the ‘Complete’ tab.  Note: the ‘Complete’ tab must be clicked after each point is placed or multiple points will become a line.  When drawing a line, select more than one point on the map and then click on the ‘Complete’ tab.  </li>
<LI>To place a polygon on the map, select the ‘Polygon’ object.  Then select at least three points on the map and click ‘Close Polygon’ when finished.  </li>
<LI>To place a circle on the map, select the ‘Circle’ object.  Then select a point on the map where the center of the circle will be.  Then enter the radius value in the input box and click ‘Complete’.      </li>
<LI>To place a text label on the map, select the ‘Text Label’ object.  Then select a point on the map where the text label will be placed.  Next, enter text in the input box and click ‘Complete’.      </li>
<LI>To clear the map view of all drawing objects, click on the ‘Restart’ tab.</li>
<LI>When finished adding drawing objects, a bookmark must be created to save the drawings on the map view.  Click on ‘Close Window’ and return to the ‘Bookmarks’ screen and proceed in creating a bookmark.  </li>
</ol>
</TD>
</TR>
</TABLE>

  </BODY>
</HTML>
