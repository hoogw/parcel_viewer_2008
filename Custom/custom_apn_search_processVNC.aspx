<%@ Page aspcompat=true %>
<%@ Import Namespace=System.Data %>
<%@ Import Namespace=System.Data.OleDB %>
<%@ Import Namespace=obout_ASPTreeView_XP_NET %>

<html>
<head>
<title>DB Input Form</title>

<!--#include file="../includes/Header.aspx"-->

<style>
	.btnNAV {	font-size: 13px;
				font-weight: bold;
				background-color: #E8F0EB;
	 }
</style>
	
</head>

<script>
	function ob_all(exp) {
		var i, e, lensrc, s
		for (i=0; i<document.images.length; i++) {
			e = document.images[i];
			lensrc = (e.src.length - 8);
			s = e.src.substr(lensrc, 8);
			if (exp == 1) {
				if ((s == "usik.gif") || (s == "ik_l.gif")) {
					e.click();
				}
			}
			else
				if ((s == "inus.gif") || (s == "us_l.gif")) {
					e.click();
				}
			}
	}

</script>

<% 

    'On Error Resume Next

	response.expires = -7 
Const CSVMax = 5000


    dim APN
    Dim strSQL
    Dim intFieldCount 
    Dim i as integer
    dim j as integer
    Dim reccount 
    Dim thisvalue
    Dim n 
    Dim WhereClauseValid 
    Dim IDValue 
    Dim CustLayer 
    Dim idx
    Dim ColourScheme
    Dim StartOverASP
    Dim FieldNamestoDisplay
    Dim FieldNamestoDisplayLONG
    dim FindInArray
	dim DS,DT,nRecCount,nPageCount,nPage
	dim nStart, nEnd
	Dim FirstRec as string
	dim idAlliFrame
	Dim MaxRecordsPerPage
    Dim DateNow
    Dim strFileName As String
        Dim oTree As New Tree
        Dim html As String

            oTree.Width = "100%"
            oTree.TreeIcons_Path = "../includes/tree"
            oTree.TreeStyle_Path = "../includes/tree"
            oTree.SelectedNode_Id = ""
            oTree.SelectedNode_Background_Color = "aaceeb"
            oTree.SelectedNode_Border = "1px solid #aaceeb"


	MaxRecordsPerPage=50

	if request("lyr")<> "" then
		session("lyr") = request("lyr")
	end if

	if request("idall")="true" then
		idAlliFrame=true
	else
		idAlliFrame=false
	end if

	'Save Search var's
	session("Search_APN1") = trim(request.form("APN1"))
	session("Search_APN2") = trim(request.form("APN2"))

	'Important''''''''''''''''''''''''''''''''
	session("lyr")="1"
	session("Fld_DB")="APN"
	session("Fld_SHP")="APN"
	session("Fld_DBNAMES")="APN,SITUS" ',NAME_1
	session("Fld_DBNamesLong") = "Parcel ID,Address,Site Use,Beds, Baths,Improvement SF,Sales Price,Quality Class,District,Neighborhood,Cluster,Document Date,Zone,Fam/Den, Basement, Por, Gar, Carpet, FP, Deck, Dock RTS, ADDN.A, ADDN.2, EN.Pat, Pool"
	session("ds")="Provider=SQLOLEDB.1;" & Application("dbSource")
	session("DBTbl")="Parcels"
	''''''''''''''''''''''''''''''''''''''''''

	if session("ds") = "" then
		response.write ("Invalid data source")
		response.end
	end if

	
    FieldNamestoDisplay=split(session("Fld_DBNAMES"),",")
    FieldNamestoDisplayLONG=split(session("Fld_DBNamesLong"),",")
    
    ColourScheme=Application("ColourScheme")
	StartOverASP= session("StartOverASP")
    
%>
<body leftmargin="5" onload="top.HaltLYRHide=0; top.MapFrame.hideLoadingLyr();">

		<script language="javascript">

			////Usually used for Search by Address, Owner, APN
			
			//If zooming to and displaying parcel details, use the function below AND rename the function above to SendValue2
			function SendValue(fnd,APN,QL) {
				top.MapFrame.positionLoadingLyr();
				top.MapFrame.clearBufUrl(1);
				var url = "SS/parcel_details.aspx?APN=" + APN
				top.MapFrame.url = "";
				top.MapFrame.SSRefreshMap(APN,url);
			}

		</script>

	<center><input type=button class=Btn onclick='window.print();' Value="Print List">&nbsp;&nbsp;<input type=button class=Btn onclick='top.MapFrame.SaveMap()' Value="Print Map">
	<br><input type=button class=Btn onclick="top.MapFrame.GoSimpleGUIiFrameRight('custom/searchmain.aspx');" Value='New Search'><br><br></center>
        <center><input type=button class=Btn value='Clear Previous Comp' onclick="top.APNRepository='';chk(0);"></center><br>
<%


'strSQL = "Select " & session("Fld_DBNAMES") & " from " & Trim(session("DBTbl")) & " where "


    If Trim(Request.Form("QueryString")) = "" Then
	if trim(session("APNList"))<> "" then
		dim APNList as string

		APNList=trim(session("APNList"))
		session("APLIst")=""

		strSQL = "SELECT APN, Situs,Site_Use,beds,baths,sq_ft_i,sale_price,QC,dist,ngh,CL,DOC_DT,zone,fam_den,bsmt_a,por_a,gar_a,carpt_a,fp,deck_a,DOCK_FAC,addn_1a,addn_2a,en_pat_a,Pool_a FROM " & Trim(session("DBTbl")) & " WHERE APN in (" & APNList & ") ORDER BY APN"
	else
		if trim(request.form("SAfld0")) <> "" then
			strSQL = Trim(CStr(Request.Form("SAfld0Name"))) & " like '" & Trim(CStr(Request.Form("SAfld0"))) + "%' "
		end if
		if trim(request.form("SAfld1")) <> "" then
			strSQL = Trim(CStr(Request.Form("SAfld0Name"))) & " >= '" & Trim(CStr(Request.Form("SAfld0"))) + "' AND "
			strSQL &= Trim(CStr(Request.Form("SAfld1Name"))) & " <= '" & Trim(CStr(Request.Form("SAfld1"))) + "' "
		end if

'		strSQL = "Select " & session("Fld_DBNAMES") & " from " & Trim(session("DBTbl")) & " where " & strSQL & " ORDER BY APN"
		strSQL = "SELECT APN, Situs,Site_Use,beds,baths,sq_ft_i,sale_price,QC,dist,ngh,CL,DOC_DT,zone,fam_den,bsmt_a,por_a,gar_a,carpt_a,fp,deck_a,DOCK_FAC,addn_1a,addn_2a,en_pat_a,Pool_a FROM " & Trim(session("DBTbl")) & " WHERE " & strSQL & " ORDER BY APN"
	end if
    Else
        strSQL = Trim(Request.Form("QueryString"))
    End If	

	response.write ("<!--- SQL: " & strSQL & " --->")


    Dim pConn As OleDbConnection
    Dim pAdapter As OleDbDataAdapter
	dim tmpDS
	
    If InStr(UCase(session("ds")), "PROVIDER") > 0 Then
        tmpDS = session("ds")
    Else
        tmpDS = "Provider=SQLOLEDB.1;" & session("ds")
    End If

    pConn = New OleDbConnection(tmpDS)
    pConn.Open()

	if cint(err.number)<>0 or cstr(err.description) <> "" then
		response.write ("Error with DB Connection String: " & cint(err.number) & " - " & cstr(err.description) & "<br>")
		response.write ("<script>top.HaltLYRHide=0; top.MapFrame.hideLoadingLyr();</script>")
		response.end
	end if
	
    pAdapter = New OleDbDataAdapter(strSQL,pConn)

	DS = New DataSet
	pAdapter.Fill(DS)

	DT = DS.Tables(0)

	nRecCount = DT.Rows.Count

	If nRecCount = 0 Then
		' Clean up
		' Do the no results HTML here
		Response.Write("No Items found.<br><br>")
'        response.write ("&nbsp;<input type=button class=Btn onclick=""document.location='" & StartOverASP & "'"" Value=""Start Over"">&nbsp;")
		Response.End 
		' Done
	End If

	nPageCount = nRecCount \ MaxRecordsPerPage
	If nRecCount Mod MaxRecordsPerPage > 0 Then
		nPageCount += 1
	End If

	nPage = Convert.ToInt32(Request.QueryString("n"))
	If nPage < 1 Or nPage > nPageCount Then
		nPage = 1
	End If
	
	n=(nPage-1)*MaxRecordsPerPage

	nStart = MaxRecordsPerPage * (nPage - 1)
	nEnd = nStart + MaxRecordsPerPage - 1

	If nEnd > nRecCount - 1 Then
		nEnd = nRecCount - 1
	End If

    If Err.Number = 0 Then

	response.write ("<form name=R id=R method=post>")
        response.write ("<TABLE border='0' cellspacing='1' cellpadding='2' width=100% ><TR>")

		response.write ("<TH class=tblHdr width=20% ><input type=checkbox name=cmain onclick='chk(this.checked);'></TH>")
		response.write ("<TH class=tblHdr width=25% >Parcel ID</TH>")
		response.write ("<TH class=tblHdr width=65% >Address</TH>")
'		response.write ("<TH class=tblHdr>Owner</TH>")
        response.write ("</TR></table>")

        reccount = 0
        n = CInt(Request("n"))
		CustLayer = Trim(CStr(session("Lyr")))

	For i = nStart To nEnd
            If (reccount / 2 = reccount \ 2) Then
                html="<TABLE border='0' cellspacing='1' cellpadding='2' width=100% ><TR valign=top class=tblRow1 width=98% >"
            Else
                html="<TABLE border='0' cellspacing='1' cellpadding='2' width=100% ><TR valign=top class=tblRow2 with=98% >"
            End If

            n = n + 1
            reccount = reccount + 1

            For j = 0 To ubound(FieldNamestoDisplay)
				if isDBNull(DT.Rows(i)(j))=false then
					
					thisvalue = Trim(CStr(DT.Rows(i)(j)))

					If Trim(thisvalue) = "" Then
						thisvalue =  "&nbsp;"
					End If
				
					select case j
					case 0
						'html &= "<td align=center><input type=checkbox name='Sel' value='" & thisvalue  & "'></td><TD width=85><center><a href=javascript:SendValue(""" & Trim(CStr(session("Fld_SHP"))) & """,""" & thisvalue & """,""" & CustLayer & """);>" & thisvalue & "</a></center></TD>"
						html &= "<td align=center ><input type=checkbox name='Sel' value='" & thisvalue  & "'></td><TD width=85><center><a href=javascript:SendValue(""" & Trim(CStr(session("Fld_SHP"))) & """,""" & thisvalue & """,""" & CustLayer & """);>" & thisvalue & "</a></center></TD>"
						FirstRec = "SendValue(""" & Trim(CStr(session("Fld_SHP"))) & """,""" & thisvalue & """,""" & CustLayer & """)"
						APN=thisvalue
					case 1
						html &= "<TD align=left >" & thisvalue & "</TD>"
					case 2
						html &= "<TD align=left  >" & thisvalue & "</TD>"
					end select

				else
					response.write ("<td>&nbsp;</td>")
				end if
            Next

        html &= "</TR></table>"
	session("tree")=1

		oTree.Add("root", "a" & i, html) ', False, "")

'''''Parcel Details - inline

            html="<TABLE border='1' cellspacing='1' cellpadding='2' bordercolor=black width=95% ><tr><td><TABLE border='0' cellspacing='1' cellpadding='2' width=100% >"

            For j = 0 To ubound(FieldNamestoDisplayLONG)
		if isDBNull(DT.Rows(i)(j))=false then
					
			thisvalue = Trim(CStr(DT.Rows(i)(j)))

			If Trim(thisvalue) = "" Then
				thisvalue =  "&nbsp;"
			End If

			html &= "<tr><TD align=left >" & FieldNamestoDisplayLONG(j) & "</td><td>" & thisvalue & "</TD></tr>"
		end if
            Next

        html &= "</TR></table></td></tr></table>"
	
	oTree.Add("a" & i, "b" & n, html)

        next

	response.write (oTree.HTML())

'        response.write ("</TABLE><br><br></form>")
        response.write ("<br><br></form>")

        response.write ("<center><input type=button class=Btn value='Comp' onclick=""SendComp('" &Trim(CStr(session("Fld_SHP"))) & "','" & CustLayer & "');"">&nbsp;<input type=button class=Btn value='Clear Comps' onclick=""top.APNRepository='';chk(0);""></center><br>")

		response.write ("<script language='javascript'>function NPRecords(i) { ProcessChecked(); document.Qry.action=""" & request.url.segments(ubound(request.url.segments)) & "?n="" + i; top.HaltLYRHide=1; top.MapFrame.positionLoadingLyr(); document.Qry.submit(); }</script>")

		response.write ("<form><center>")
		' First page
		if (nPage)>1 then
			response.write ("<input class=btnNAV type=button value=' << ' onclick=""javascript:NPRecords(1)"">&nbsp;")
		end if
		' Previous page
		if (nPage-1)>0 then
			response.write ("<input class=btnNAV type=button value=' < ' onclick=""javascript:NPRecords(" & (nPage - 1).ToString() & ")"">&nbsp;")
		end if

        response.write ("&nbsp;<input class=btnNAV type=button value='Start Over' onclick=""document.location='" & StartOverASP & "'"">&nbsp;")

		' Next page
		if (nPage+1)<=nPageCount.toString then
			response.write ("<input class=btnNAV type=button value=' > ' onclick=""javascript:NPRecords(" & (nPage + 1).ToString() & ")"">&nbsp;")
		end if
		' Last page
		if (nPage)<nPageCount.ToString() then
			response.write ("<input class=btnNAV type=button value=' >> ' onclick=""javascript:NPRecords(" & nPageCount.ToString() & ")"">")
		end if

		response.write ("</form>Page <b>" & nPage & "</b> of <b>" & nPageCount.ToString() & "</b><br>")
		response.Write ("(" & nRecCount.ToString() & " total records)<br></center>")
		session("QueryTTLRecords")=nRecCount.ToString()
    Else
        response.write ("No data found on the selected layers in the selected area.<br><br>")
        response.write ("&nbsp;<input type=button class=Btn onclick=""document.location='" & StartOverASP & "'"" Value=""Start Over"">&nbsp;")
    End If

    Err.Clear()

	if reccount=1 then
		response.write ("<script>" & FirstRec & "</script>")
	else
		if (nRecCount.ToString()<=CSVMax) then
			session("CSVFields")=session("Fld_DBNamesLong")
			session("CSVSQL")=strSQL

		        response.write ("<br><hr><a href='csv.aspx'>Click Here</a> to download this list as a CSV file.<hr><br><br><br>")
		end if
	end if

	session("SearchResultsURL")=Request.url.tostring
	session("SearchResultsQ")=server.UrlEncode(strSQL)

%>

		<script language="javascript">

			function SendComp(fnd,QL) {

				ProcessChecked();
				top.MapFrame.positionLoadingLyr();
				top.MapFrame.clearBufUrl(1);
				document.location = "custom_parcel_identify.aspx?APN=" + top.APNRepository + "&m=z";

			}
			function ProcessChecked() {
<%for i = 0 to reccount-1%>if (document.R.Sel[<%=i%>].checked) {top.APNRepository = top.APNRepository + document.R.Sel[<%=i%>].value + ","}
<%next%>
			}


			ob_all(0);

	function chk(v) {
<%for i = 0 to reccount-1%>document.R.Sel[<%=i%>].checked=v;
<%next%>
	}
		</script>


		<form name="Qry" method=post ID="Form1">
		<input type=hidden name="QueryString" value="<%=strSQL%>">
		</form>
		
</body>
