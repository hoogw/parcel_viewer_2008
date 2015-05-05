<script>

function Go(v) {
	if (v==1) {document.F.action="custom_parcel_details_Main.aspx";}
	if (v==2) {document.F.action="http://gisweb.msa.saccounty.net/website/ParcelDetails/Parcel_Details_Main.aspx";}

	document.F.submit();

}
</script>

<center>
<form name="F" id="F" target=PDetails method=get>
<input type=button value="Citrus Heights" onclick="Go(1);">&nbsp;&nbsp;
<input type=button value="Sac County" onclick="Go(2);">
<input type=hidden name=APN value="<%=request("APN")%>">
<input type=hidden name=pd value="1">
<input type=hidden name=CS value="1">
<input type=hidden name=VPN value="1">
<input type=hidden name=ds value="<%=server.urldecode("Initial+Catalog%3dGIS%3bServer%3dPWASQL%3bUser+Id%3dgisuser%3bPassword%3dgisuser%3bpooling%3dfalse%3bconnection+timeout%3d120%3b")%>">
</form>
</center>
