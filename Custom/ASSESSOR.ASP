<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>

<head>
<title>Untitled</title>

</head>

<frameset rows="94%,1">
<frameset cols="150,*">
<noframes>
<body>

<%

session("theNum") = request.querystring("IDValue")

%>

<!-- frames -->

</body>
</noframes>
<frame name="ASSESSOR1" src="ASSESSOR1.ASP" marginwidth="10" marginheight="10" scrolling="no" frameborder="0" noresize>
<frame name="ASSESSOR2" src="ASSESSOR2.ASP" marginwidth="10" marginheight="10" scrolling="auto" frameborder="0">
</frameset>
<frameset cols="43%,*">
<frame name src marginwidth="10" marginheight="10" scrolling="auto" frameborder="0">
<frame name src marginwidth="10" marginheight="10" scrolling="auto" frameborder="0">
</frameset>
</frameset>

</html>
