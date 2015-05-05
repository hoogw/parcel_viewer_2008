<script>
var objCurrTool=top.MapFrame.findObj('CurrTool');
if (objCurrTool.value==26) {
	document.location="custom_permits_brief.aspx?APN=<%=request("APN")%>";
}
if (objCurrTool.value==27) {
	document.location="custom_project_history.aspx?APN=<%=request("APN")%>";
}
</script>

<%
	Dim MiniSrchPage
	Dim F1Size
	
	MiniSrchPage=""
	F1Size=0
	select case ucase(trim(request("s")))
	case "ADDY"
		MiniSrchPage="custom_address_search_brief.aspx"
		F1Size=50
	case "OWNER"
		MiniSrchPage="custom_owner_search_brief.aspx"
		F1Size=50
	case "APN"
		MiniSrchPage="custom_APN_search_brief.aspx"
		F1Size=50
	case else
		MiniSrchPage="ss_blank.html"
		F1Size=0
	end select
%>

<FRAMESET ROWS="<%=F1Size%>,50,*" ID="MainFrameSet" BORDER="1" FRAMESPACING="0" SCROLLING="YES">
	<FRAME SRC="<%=MiniSrchPage%>" NAME="SrchPD" BORDER="2" FRAMEBORDER="yes" SCROLLING="NO">
	<FRAME SRC="PDHeader.aspx?APN=<%=request("APN")%>" NAME="PDHeader" BORDER="0" FRAMEBORDER="No" SCROLLING="NO">
	<FRAME SRC="custom_parcel_details_Main.aspx?APN=<%=request("APN")%>" NAME="PDetails" BORDER="0" FRAMEBORDER="No" SCROLLING="YES">
		<NOFRAMES>
			Your Browser does not support frames!
		</NOFRAMES>
</FRAMESET>
