﻿<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/MasterPage.Master" CodeBehind="Test.aspx.vb" Inherits="OMAS_website.Test" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<!DOCTYPE html>
    <html>
<head>
    <title>Tabbed Content</title>
    <script src="tabcontent.js" type="text/javascript"></script>
    <link href="css/tabcontent.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <div style="width: 500px; margin: 0 auto; padding: 120px 0 40px;">
        <ul class="tabs" data-persist="true">
            <li><a href="#view1">Lorem</a></li>
            <li><a href="#view2">Using other templates</a></li>
            <li><a href="#view3">Advanced</a></li>
        </ul>
        <div class="tabcontents">
            <div id="view1">
                <b>Lorem Issum</b>
                <p>Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit...</p>
                
            </div>
            <div id="view2">
                <b>Switch to other templates</b>
                <p>Open this page with Notepad, and update the CSS link to:</P>
                <p>template1 ~ 6.</p>                
            </div>
            <div id="view3">
                <b>Advanced</b>
                <p>If you expect a more feature-rich version of the tabber, you can use the advanced version of the script, 
                    <a href="http://www.menucool.com/jquery-tabs">McTabs - jQuery Tabs</a>:</p>
                <ul>
                    <li>URL support: a hash id in the URL can select a tab</li>
                    <li>Bookmark support: select a tab via bookmark anchor</li>
                    <li>Select tabs by mouse over</li>
                    <li>Auto advance</li>
                    <li>Smooth transitional effect</li>
                    <li>Content can retrieved from other documents or pages through Ajax</li>
                    <li>... and more</li>     
                </ul>
            </div>
        </div>
    </div>
</body>
</html>
</asp:Content>