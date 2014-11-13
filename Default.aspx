<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/MasterPage.Master" CodeBehind="Default.aspx.vb" Inherits="OMAS_website._Default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .newStyle3 {
            height: 200px;
            width: auto;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.0/jquery.min.js"></script>
    <script src="sss/sss.js"></script>
    <script src="sss/sss.min.js"></script>
    <link rel="stylesheet" href="css/sss.css" type="text/css" media="all">

    <script>
        jQuery(function ($) {
            $('.slider').sss({
                slideShow: true, // Set to false to prevent SSS from automatically animating.
                startOn: 0, // Slide to display first. Uses array notation (0 = first slide).
                transition: 600, // Length (in milliseconds) of the fade transition.
                speed: 5000, // Slideshow speed in milliseconds.
                showNav: true // Set to false to hide navigation arrows.
            });
        });
    </script>
</head>
<br />
<center>
<div class="slider">
    <img src="images/banner1.jpg" />
    <img src="images/banner2.jpg" />
    <img src="images/banner3.jpg" />
    <img src="images/Banner4.jpg" />
    <img src="images/banner5.jpg" />
</div>
    </center>
</html>
</asp:Content>

