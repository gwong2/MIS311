<%@ Page Title="" Language="VB" MasterPageFile="~/MasterPage.master" validateRequest="false" %>

<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Web" %>
<%@ Import Namespace="System.Web.UI" %>
<%@ Import Namespace="System.Web.UI.WebControls" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.OleDb" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Configuration" %>


<script language="VB" runat="server">
    '
    ' Instructions for programmer: 
    ' This program produces a datagrid that lists data from one MSAccess database table or query.  
    ' This datagrid only lists data: it does not allow updating, deleting, inserting or sorting 
    '
    ' This template can be installed in a web-server folder that serves IIS asp.net applications
    ' and allows OLEDB connection to MSAccess databases imbedded in web-folders.
    '
    ' Before running this program, 
    ' 1) Copy and re-name this file as LISTim_product_type.txt, where product_type is the name of your database table
    ' 2) Using Notepad, do a global search-and-replace of ALL OCCURRENCES (try ctl-h) in this template as follows:
    '    -Replace product_type with the database table name
    '    -Replace product_type_code with the name of the database table's primary key column
    '    -Replace Olivias with the name of your database (eg. Olivias): do not include .accdb in the name
    ' 3) Import your modified template to the web-site sub-directory where it will be executed.  
    ' 4) Rename the imported template by changing the suffix (.txt) to .aspx.  It is now ready to run.
    ' 
    ' ================================================================================
    Sub Page_Load(src As Object, e As EventArgs)
        If Not IsPostBack Then
            BindSortedData("product_type_code")
        End If
    End Sub

    ' ================================================================================
    Sub BindSortedData(sortExpr As String)
        Dim conn As OleDBConnection
        conn = New OleDbConnection("Provider=Microsoft.ACE.OLEDB.12.0;" + _
        "Data Source=" + Server.MapPath("~") + "/resource/Olivias.accdb")
        Dim sortSQL As String = "SELECT * FROM product_type ORDER BY " & sortExpr
        Dim SortCommand As New OleDbCommand(sortSQL, conn)
        conn.Open()
        _gd1.DataSource = SortCommand.ExecuteReader(CommandBehavior.CloseConnection)
        _gd1.DataBind()
    End Sub

    ' ================================================================================

</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <p align="center"><b><font size="5" color="#000000">View Product Types</font></b></p>

<asp:datagrid id="_gd1" runat=server AutoGenerateColumns="True" 
  GridLines=None
  CellSpacing=2
  Font-Name=Oswald Font-Size=8pt
  HeaderStyle-BackColor="#959595"
  FooterStyle-BackColor="#959595"
  ShowFooter=true
  ItemStyle-BackColor=white
  CellPadding=2
  Align="center">
</asp:datagrid>

</asp:Content>

