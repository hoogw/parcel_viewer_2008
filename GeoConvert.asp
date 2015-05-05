<% @Language = "JScript" %>
<!-- #include file = "GeoConvert.inc" --><%
Response.ContentType = "text/plain" ;

function postText(strURL,data)
{
    var strResult;
    var WinHttpReq;
	try
	{
		// Create the Newer version of WinHTTPRequest ActiveX Object.
		WinHttpReq = new ActiveXObject("WinHttp.WinHttpRequest.5.1");
	}
	catch (objError)
	{
		strResult = objError + "\n"
		strResult += "WinHTTP returned error: " + 
				(objError.number & 0xFFFF).toString() + "\n\n";
		strResult += objError.description;
		
		try
		{
			// Since we failed try the older version
			// Create the WinHTTPRequest ActiveX Object.
			WinHttpReq = new ActiveXObject("WinHttp.WinHttpRequest.5");
		}
		catch (objError)
		{
			strResult = objError + "\n"
			strResult += "WinHTTP returned error: " + 
				(objError.number & 0xFFFF).toString() + "\n\n";
			strResult += objError.description;
		}
	}
      
	try
	{	    
        //  Create an HTTP request.
        var temp = WinHttpReq.Open("POST", strURL, false);

        //  Send the HTTP request.
        WinHttpReq.Send(data);
        
        //  Retrieve the response text.
        strResult = WinHttpReq.ResponseText;
    }
    catch (objError)
    {
        strResult = objError + "\n"
        strResult += "WinHTTP returned error: " + 
            (objError.number & 0xFFFF).toString() + "\n\n";
        strResult += objError.description;
    }
    
    //  Return the response text.
    return strResult;
}

    var stuff = "" ;
    var data = "" ;
    var debugInfo = "" ;

    // Going to LAT/LON?
    if ( Request.Form("LatLon") == "1" ) {

    	// From coordinate system ...
	data = "srcSys=" + escape( Request.Form("srcSys") );
	data += "&srcSubSys=" + escape( Request.Form("srcSubSys") );
	data += "&srcDatum=" + escape( Request.Form("srcDatum") );
	data += "&srcUnits=" + escape( Request.Form("srcUnits") );

	data += "&ptx=" + Request.Form("ptX") ;
	data += "&pty=" + Request.Form("ptY") ;

	// To lat/lon ...
	data += "&LatLon" ;

	debugInfo += "DEBUG FROM GEOCONVERT.ASP...  to lat/lon..." + Request.Form("LatLon") + "\n" ;
    }
    else {
        // Going FROM lat/lon ...
	data = "srcSys=" + escape( 'Geodetic Latitude / Longitude' );
	data += "&srcSubsys=" + escape( 'Latitude / Longitude' );
	data += "&srcDatum=" + escape( 'WGS 1984' );
	data += "&srcUnits=" + escape( 'Meters' );

	data += "&ptx=" + Request.Form("ptx") ;
	data += "&pty=" + Request.Form("pty") ;

	// to coordinate system ...
	data += "&dstSys=" + escape( Request.Form("dstSys") );
	data += "&dstSubsys=" + escape( Request.Form("dstSubSys") );
	data += "&dstDatum=" + escape( Request.Form("dstDatum") );
	data += "&dstUnits=" + escape( Request.Form("dstUnits") );

	// Debug:
	debugInfo += "DEBUG FROM GEOCCONVERT.ASP... *FROM* lat/lon..." ;
	debugInfo += "\ninput x = " + Request.Form("ptx") ;
	debugInfo += "\ninput y = " + Request.Form("pty") ;
	debugInfo += "\n" ;
    }

    stuff += postText( NiwConverter , data );

    Response.Write( stuff );
    Response.Write( "\n\nSent data:\n" );
    Response.Write( data );
    Response.Write( "\n\nDebug info:\n" );
    Response.Write( debugInfo );
%>
