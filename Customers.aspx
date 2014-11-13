<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/MasterPage.Master" CodeBehind="Customers.aspx.vb" Inherits="OMAS_website.Customers" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
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
    <br />
<center>
<div class="slider">
    <img src="images/customer1.jpg" />
    <img src="images/customer2.jpg" />
    <img src="images/customer3.jpg" />
    <img src="images/customer4.jpg" />
    <img src="images/customer5.jpg" />
</div>
    </center>
     <div>
        <p style="margin-left: 40px""margin-right: 40px">
            &nbsp;</p>
         <h2 style="margin-left: 40px""margin-right: 40px">
             Summer Adventure Contest</h2>
         <p style="margin-left: 40px""margin-right: 40px">
            We've had some excellent submissions for our "Summer Adventure Contest"! Above are the photos from the 5 finalists! We will be selecting a winner on November 28, 2014. Stay tuned!
            </p>
        <p style="margin-left: 80px""margin-right: 80px">
            Finalists:
            </p>
        <p style="margin-left: 120px""margin-right: 120px">
            • Dennis Reid - Old, Alberta
            </p>
        <p style="margin-left: 120px""margin-right: 120px">
            • Christina Webb - Kelowna, BC 
            </p>
        <p style="margin-left: 120px""margin-right: 120px">
            • Danny Folds - Calgary, Alberta
            </p>
        <p style="margin-left: 120px""margin-right: 120px">
            • The Simpson Family - Edmonton, Alberta
            </p>
        <p style="margin-left: 120px""margin-right: 120px">
            • The Juarez Family - Vernon, BC
        </p>
         <h2 style="margin-left: 40px""margin-right: 40px">
             About Us</h2>
         <p class="MsoNormal" style="margin-left: 40px""margin-right: 40px">
             <span lang="EN-CA" style="font-size:12pt">Olivia’s Mountain Adventure Store has been serving outdoor enthusiasts in Banff, Alberta since 1968.<span style="mso-spacerun:yes">&nbsp; </span>Originally, Olivia’s specialized in expedition services and climbing gear, but they recently expanded to carry complete lines of camping equipment and outdoor-clothing.<span style="mso-spacerun:yes">&nbsp; </span>Although not as large as competing stores in bigger cities, they have developed a growing customer base due to their expertise in providing “mountain adventures” to a variety of remote locations in unpredictable weather conditions.<span style="mso-spacerun:yes">&nbsp; </span><o:p></o:p></span>
         </p>
         <p style="margin-left: 40px""margin-right: 40px">
             &nbsp;</p>
    </div>
</html>
</asp:Content>
