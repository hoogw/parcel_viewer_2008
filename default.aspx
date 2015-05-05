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
'   The purpose of this page is to redirect to the initialization page pv_init.aspx.
'
'	For the County of Sacramento, the load balancing variable "g" is tested to see if it exists on the URL line.  If not, we
'	redirect back to the GIS Apps Intranet page.
'
'************************************************************************************************************************************
%>
<%
On Error Resume Next

if Application("ClientName")="SacCounty" then

	if trim(request("g")) <> "1" then
		response.redirect("http://gis.pwa.saccounty.net/GisApps.htm?abs=1")
	end if
end if
%>

<%
dim URL, params, i

URL="pv_init.aspx?"
params=""

For i = 0 To Request.QueryString.Count
    If Trim(Request.QueryString.Keys.Item(i)) <> "" Then
        If Trim(params) <> "" Then
            params &= "&"
        End If
            params &= trim(request.querystring.allkeys(i)) & "=" & trim(request(Trim(Request.QueryString.Keys.Item(i))))
    End If
Next

response.redirect (URL & params)
%>
