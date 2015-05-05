<%if request("ApplicationNum")<>"" then%>
<form name=apnum method=post action="custom_permits_process.aspx" target=_new>
<input type=hidden name=ApplicationNumber value="<%=request("ApplicationNum")%>">
<input type=hidden name=ANOpr value="=">
</form>
<script>

document.apnum.submit();
top.MapFrame.swapLayerVis(top.MapFrame.lyrSS,'windowSS');
</script>
<%else%>
<%if request("StreetNum")<>"" or request("StreetName")<>"" or request("ZIP")<>"" then%>
<form name=apnum method=post action="service_request_process.aspx" target=_new>
<input type=hidden name=SAfld0Name value="RequestStreetNumber">
<input type=hidden name=SAfld0Opr value=" LIKE ">
<input type=hidden name=SAfld0 value="<%=request("StreetNum")%>">
<input type=hidden name=SAfld0Type value='String'>
<input type=hidden name=SAfld1Name value="RequestStreetName">
<input type=hidden name=SAfld1Opr value=" LIKE ">
<input type=hidden name=SAfld1Type value='String'>
<input type=hidden name=SAfld1 value="<%=request("StreetName")%>">
<input type=hidden name=SAfld2Name value="ZIP">
<input type=hidden name=SAfld2Opr value=" LIKE ">
<input type=hidden name=SAfld2 value="<%=request("ZIP")%>">
<input type=hidden name=SAfld2Type value='String'>
<input type=hidden name=FieldCount value=2>
</form>
<script>

document.apnum.submit();
top.MapFrame.swapLayerVis(top.MapFrame.lyrSS,'windowSS');
</script>
<%end if%>


<%end if%>