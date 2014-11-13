<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/MasterPage.Master" CodeBehind="Staff.aspx.vb" Inherits="OMAS_website.Staff" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="CSS/mis311-marquee.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        .newStyle3 {
            margin-left:auto;
            margin-right: auto;
        }
    </style>
    <link href="CSS/mis311-hoverbutton.css" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <br />
    <marquee class="?????" direction="left" behavior="scroll" scrollamount="5">Remember to SMILE! :) Today is another wonderful day at OMAS!</marquee>
    <div class="newStyle3">
    <h1 style="margin-left: 80px">Important to Note</h1>
    <p style="margin-left: 120px">
        • Sign up for the Christmas Party by November 31, 2014</p>
        <p style="margin-left: 160px">
            • We will be using Elfster for a gift exchange, please sign up <a href="http://www.elfster.com/">here</a>.</p>
    <p style="margin-left: 120px">
        • Please make sure to give customer recipt, we have had issues with returns lately.</p>
        <p style="margin-left: 120px">
            • Make sure to email <a href="mailto:schedule@omas.ca">schedule@OMAS.ca</a> if you require time off!</p>
    <h1 style="margin-left: 80px">Employee News</h1>
    <p style="margin-left: 80px">
        02/11/14 - New coffee maker in the lunch room
    </p>
    <p style="margin-left: 80px">
        05/11/14 - Congratulations to Tessie and Victor on their 5 year anniversary!</p>
    <p style="margin-left: 80px">
        05/11/14 - The debit card machine will be having updates from 5 AM - 6 AM on November 11, 2014.
    </p>
    <p>
        &nbsp;</p>
    <p>
    </p>
    <center>
        <a align="center" class="mis311-hoverbutton" href="maintenance.aspx">MAINTENANCE</a></center>
    </p>
        <br />
       <center> <a align="center"><img src="http://www.quick-counter.net/aip.php?tp=bb&tz=America%2FEdmonton" border="0" /></a> </center>

    <p>
        &nbsp;</p>
    </div>
</asp:Content>
