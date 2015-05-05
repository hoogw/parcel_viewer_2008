<%@ Page Language="vb" AutoEventWireup="false" Codebehind="BM_Main.aspx.vb" Inherits="dotNETViewer.BM_Main"%>
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
'	The purpose of this page is to provide the main HTML interface to bookmarks.  A user can view public bookmarks, view private book
'	marks (when they provide a username and click on the Lookup button), a link to bookmark instructions, and buttons to allow
'	the user to open up the bookmark drawing tools floating window, create a bookmark, and delete a bookmark.
'
'	Variables of interest (form and request variables):
'	myapp - not used anymore - this was for My WQ Viewer
'	EconDev - there is some special Econ Dev code in here - HTML blocks to be displayed only if the app type is Econ Dev.
'	VenturaCounty - there is some special Ventura County code in here - HTML blocks to be displayed only if the client is Ventura.
'	
'************************************************************************************************************************************
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<TITLE>Bookmark</TITLE> 
		<!--#include file="../includes/header.aspx"-->
	</HEAD>
	<BODY onload="try {document.BMForm.BMUserID.focus();} catch(e){};">
		<script language='JavaScript' type='text/javascript'>
			
			function CreateBM() {
				//Redirects the floating window to BM_Create - allowing a user to create a bookmark.
				document.location="BM_Create.aspx";
			}

			function DeleteBM() {
				//Redirects the floating window to BM_Delete - allowing theu ser to delete a bookmark.
				document.location="BM_Delete.aspx";
			}
			
			function LookupPrivateBM() {
				//Upon clicking on the lookup button, this submits the BMForm to BM_Main.aspx - which looks up the private bookmarks
				//give the username.
				document.BMForm.submit();
			}
			
		</script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>
		<%if Go="" then%>
		<FORM id="BMForm" name="BMForm" runat="server">
			<input type=hidden id=AppURL value="http://<%=strURL%>" NAME="AppURL"> 
			<!--- MUST HAVE pv_init --->
			<TABLE width="100%" cellpadding="3" cellspacing="0" border="0">
				<TR>
					<TD colspan="2" align="center"><FONT class="sshdr1">Bookmarks</FONT><br>
						<hr>
					</TD>
				</TR>
				<%if request("myapp")<>"" then%>
				<TR>
					<TD>&nbsp;</TD>
					<TD><FONT class="ssmsg2">Please select a public or private bookmark. Upon selecting a 
							bookmark, you will be forwarded to the Water Quality application with your 
							bookmark settings.</FONT></TD>
				</TR>
				<TR>
					<TD colspan="2"><hr>
					</TD>
				</TR>
				<%end if%>
				<TR>
					<TD width="100"><FONT class="ssmsg2">Public</FONT></TD>
					<TD><asp:DropDownList cssclass=HTMLFrmObjects  ID="BMPublic" Visible="True" AutoPostBack="True" Runat="server" Width="150"></asp:DropDownList></TD>
				</TR>
				<TR>
					<TD colspan="2">&nbsp;</TD>
				</TR>
				<TR>
					<TD><FONT class="ssmsg2">Private</FONT></TD>
					<TD><asp:TextBox cssclass=HTMLFrmObjects ID="BMUserID" Runat="server" MaxLength="20" Width="100"></asp:TextBox>&nbsp;<input type="button" class=Btn id="LookUP" value="Look Up" onclick="LookupPrivateBM();"></TD>
				</TR>
				<TR>
					<TD>&nbsp;</TD>
					<TD><asp:DropDownList cssclass=HTMLFrmObjects  ID="BMPrivate" Visible="True" AutoPostBack="True" Runat="server" Width="150"></asp:DropDownList></TD>
				</TR>
				<%if Application("ClientName") = "VenturaCounty" then%>
				<TR>
					<TD>&nbsp;</TD>
					<TD><asp:RadioButton ID="optExtentOnly" GroupName=EL Runat="server" value=1 Text="Extent Only"></asp:RadioButton><br>
						<asp:RadioButton ID="optLayersOnly" GroupName=EL Runat="server" value=2 Text="Layers Only"></asp:RadioButton><br>
						<asp:RadioButton ID="optAll" GroupName=EL Runat="server" value=3 Text="Full Render" Checked></asp:RadioButton><br>
					</TD>
				</TR>
				<%end if%>
				<TR>
					<TD colspan="2"><hr>
					</TD>
				</TR>
				<%if request("myapp") <> "1" then%>
				<TR>
					<TD colspan="2" align="center"><a href='javascript:Instr();'>Bookmark Instructions</a>
					</TD>
				</TR>
				<%else%>
				<TR>
					<TD colspan="2" align="center"><b>What is 'My Water Quality Viewer'?</b><br>
						If you have created a pre-defined bookmark,
						<br>
						you can use this bookmark as a starting point into the<br>
						Water Quality viewer.
						<br>
						Otherwise <a href='javascript:history.go(-1);'>Click Here</a> to start 
						over.</B>
					</TD>
				</TR>
				<%end if%>
			</TABLE>
			<%if ((Application("AppType") = "EconDev" and  Session("EDBMAccess")="Admin") OR Application("AppType") <> "EconDev") AND request("myapp")="" then%>
			<TABLE width="100%" cellpadding="6" cellspacing="0" border="0">
				<TR bgcolor="#bbbbbb">
					<TD align="center"><input type="button" class=Btn onclick="top.MapFrame.ShowDrawing();" value="Drawing Tools"></TD>
				</TR>
			</TABLE>
			<br>
			<TABLE width="100%" cellpadding="6" cellspacing="0" border="0">
				<TR bgcolor="#bbbbbb">
					<TD align="center" colspan="2"><input type="button" class=Btn onclick="CreateBM();" value="Create a Bookmark" style="WIDTH:200px"><br>
						<input type="button" class=Btn onclick="DeleteBM();" value="Delete a Bookmark" style="WIDTH:200px"></TD>
				</TR>
			</TABLE>
			<%end if%>
			<%if (Application("AppType")<>"EconDev") then%>
			<%else%>
			<TABLE width="100%" cellpadding="3" cellspacing="0" border="0">
				<TR>
					<TD colspan="2">&nbsp;</TD>
				</TR>
				<%if request("m")=1 then%>
				<TR>
					<TD colspan="2" align="center"><a href='BM_Login.aspx?a=li'>Admin Login</a>
					</TD>
				</TR>
				<%end if%>
				<TR>
					<TD colspan="2" align="center"><a href="BM_Login.aspx?a=lo">Log Out</a><br>
					</TD>
				</TR>
			</TABLE>
			<%end if%>
		</FORM>
		<%end if%>
		<script language='JavaScript' type='text/javascript'>
		function Instr() { 
			//Display bookmark instructions based upon the client name - more customization stuff here!
			<%if application("ClientName")="InlandEmpire" then%>
				top.fwinURL[0]="EconDev/EDInstructions.aspx?ID=Bookmark";
			<%else%>
				top.fwinURL[0]="Bookmark/BookmarkInstructions.aspx"; 
			<%end if%>
			var objTMP=top.MapFrame.findObj("iFramecontactinfoLayer",top.MapFrame.document);
			top.MapFrame.ChangeiFrameURL(objTMP,"Instructions","yes",1);
		}
		</script><noscript><b>Javascript MUST be enabled on your browser</b></noscript>
	</BODY>
</HTML>
