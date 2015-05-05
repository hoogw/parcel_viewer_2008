<%@ Page %>
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
'	The purpose of this page is to provide a common point for Search facilitation pages.  This page is always called with the address
'	line variable "w".  This page is usually called in tandum with the ss_wait page so the user sees a "please wait" page, and while
'	they are waiting, this common interface page is processing their request.  For example, w=1 means that the user will be waiting
'	for the address.aspx page to pop-up onto their screen.
'
'************************************************************************************************************************************


Dim Rpt as Integer
Rpt = CInt(Application("CReportType"))
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<FRAMESET rows="*" BORDER="0" FRAMESPACING="0" NORESIZE>
			<%
	select case (Request("w"))
		case 1: response.Write ("<FRAME SRC='address.aspx' NAME='Bdy' BORDER='1' FRAMEBORDER='YES' SCROLLING='Yes'>")
		case 2: response.Write ("<FRAME SRC='owner.aspx' NAME='Bdy' BORDER='1' FRAMEBORDER='YES' SCROLLING='Yes'>")
		case 3: response.Write ("<FRAME SRC='parcel_id.aspx' NAME='Bdy' BORDER='1' FRAMEBORDER='YES' SCROLLING='Yes'>")
		case 4: response.Write ("<FRAME SRC='../Custom/custom_landmark.asp?ds=" & Application("dbsource") & "&CS=1' NAME='Bdy' BORDER='1' FRAMEBORDER='YES' SCROLLING='Yes'>")
		case 5: response.Write ("<FRAME SRC='intersection.aspx' NAME='Bdy' BORDER='1' FRAMEBORDER='YES' SCROLLING='Yes'>")
		case 6: response.Write ("<FRAME SRC='parcel_details.aspx?apn=" & request("apn") & "' NAME='Bdy' BORDER='1' FRAMEBORDER='YES' SCROLLING='Yes'>")
		case 20: response.Write ("<FRAME SRC='extract_step1.aspx' NAME='Bdy' BORDER='1' FRAMEBORDER='YES' SCROLLING='Yes'>")
		case 30: response.Write ("<FRAME SRC='..\EconDev\search.aspx?z=1&i=0' NAME='Bdy' BORDER='1' FRAMEBORDER='YES' SCROLLING='Yes'>")
		case 31: response.Write ("<FRAME SRC='..\SimpleGUI\default.aspx' NAME='Bdy' BORDER='1' FRAMEBORDER='YES' SCROLLING='Yes'>")
		case 40:
		if Rpt = 1 then
			response.Write ("<FRAME SRC='../Custom/" & Application("CReportURL") & "' NAME='Bdy' BORDER='1' FRAMEBORDER='YES' SCROLLING='Yes'>")
		else
			response.Write ("<FRAME SRC='" & Application("CReportURL") & "' NAME='Bdy' BORDER='1' FRAMEBORDER='YES' SCROLLING='Yes'>")
		end if
		case else: response.Write ("<FRAME SRC='#' NAME='Bdy' BORDER='1' FRAMEBORDER='YES' SCROLLING='NO'>")
	end select
%>
		</FRAMESET>
		<NOFRAMES>
			Your Browser does not support frames!
		</NOFRAMES>
	</FRAMESET>
</HTML>
