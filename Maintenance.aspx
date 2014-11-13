<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/MasterPage.Master" CodeBehind="Maintenance.aspx.vb" Inherits="OMAS_website.WebForm1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="CSS/mis311-hoverbutton.css" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <p>
        <center>
        <a class="mis311-hoverbutton" href="customer-edit.aspx">EDIT CUSTOMERS</a>
            <br />
            <br />
        <a class="mis311-hoverbutton" href="employee-edit.aspx">EDIT EMPLOYEES</a>
            <br />
            <br />
        <a class="mis311-hoverbutton" href="product-edit.aspx">EDIT PRODUCTS</a>
            <br />
            <br />
            <a align="center" class="mis311-hoverbutton" href="staff.aspx">BACK</a><br />
            <br />
            </center>
    </p>
</asp:Content>
