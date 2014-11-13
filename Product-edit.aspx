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
' This program produces a datagrid that displays data from one MSAccess database table or query.  
' This datagrid allows updating, deleting and inserting of rows, as well as sorting of grid-contents by column 
'
' This template can be installed in a web-server folder that serves IIS asp.net applications
' and allows OLEDB connection to MSAccess databases imbedded in web-folders with update-prevention disabled.
'
' Before running this program, 
' 1) Copy and rename this file as EDITim_Product.txt, where Product is the name of your database table
' 2) Using Notepad, do a global search-and-replace of ALL OCCURRENCES (try ctl-h) in this template as follows:
'    -Replace Product with the database table name
'    -Replace Product_id with the name of the database table's primary key column
'    -Replace Olivias with the name of your database (eg. xgen): do not include .accdb in the name
'    -Replace Description with the name of the first non-primary-key column in the database table 
'    -Replace Model_name with the name of the second non-primary-key column, if applicable  
'    -continue replacing Manufacturer_name through FFFFA for the third through tenth non-primary-key columns, if applicable
' 3) Remove entirely all remaining lines/sections of code that contain FFFF, as these will not run and are unnecessary 
'
' 4) Install foreign-key-lookup links to web-pages that show the parent-table:
'    Choose one foreign key column from this page's database table
'    Modify the code below by changing PTABPTAB to the name of the foreign key column's parent-table
'    Copy the code (including the blank in col2 and including the final >, but excluding carriage-return)
'    and paste it immediately before both the </HeaderTemplate> and the </FooterTemplate> tags 
'    in the "template column" code for the foreign key column (near the bottom of this program)... 
' <a href="LISTim_PTABPTAB.aspx">^</a>
'
' 5) To widen text-boxes on the datagrid's footer and rows-being-updated:
'    look for the text Columns="5" in the template column of your choice (it occurs twice)
'    change the 5 to something larger (in both occurrences) 
' 
' 6) Import this into your FrontPage folder, rename the file suffix from .txt to .aspx and execute.  
' 
' ================================================================================
  Sub Page_Load(src As Object, e As EventArgs)   
    If Not IsPostBack Then
      Session("SortColumn") = "Product_id"
      BindSortedData(Session("SortColumn"))
    End If
  End Sub

' ================================================================================
  Sub BindSortedData(sortExpr as String)
        Dim conn as OleDBConnection
        conn = new OleDBConnection("Provider=Microsoft.ACE.OLEDB.12.0;"+ _
        "Data Source=" + Server.MapPath("~") + "/resource/Olivias.accdb")
       Dim sortSQL as String = "SELECT * FROM Product ORDER BY " & sortExpr 
       Dim SortCommand as New OleDbCommand(sortSQL, conn)
       conn.Open()
       _gd1.DataSource = SortCommand.ExecuteReader(CommandBehavior.CloseConnection)
       _gd1.DataBind()	
  End Sub

' ================================================================================
  Sub gd1_Sort(sender as Object, e as DataGridSortCommandEventArgs)
     Session("SortColumn") = e.SortExpression
     BindSortedData(Session("SortColumn"))
  End Sub 

' ================================================================================
  Sub gd1_Edit(sender As Object, e As DataGridCommandEventArgs)  
    _gd1.ShowFooter = False
    _gd1.EditItemIndex = e.Item.ItemIndex
     BindSortedData(Session("SortColumn"))
  End Sub

' ================================================================================
  Sub gd1_Cancel(sender As Object, e As DataGridCommandEventArgs)  
    _gd1.ShowFooter = True
    _gd1.EditItemIndex = -1
     BindSortedData(Session("SortColumn"))
  End Sub

' ================================================================================
  Sub gd1_Update(sender As Object, e As DataGridCommandEventArgs)
    _gd1.ShowFooter = True
    Dim updateCmd As String
      updateCmd = "Update Product SET " _
            & "Description = @Description" _
            & ", Model_name = @Model_name" _
            & ", Manufacturer_name = @Manufacturer_name" _
            & ", Product_type_code = @Product_type_code" _
            & ", Manufacturer_SRP = @Manufacturer_SRP" _
            & ", In_stock_quantity = @In_stock_quantity" _
            & " where format(Product_id) = "  & """" & CType(e.Item.Cells(2).Controls(0), TextBox).Text  & """"

     Dim conn as OleDBConnection
        conn = New OleDBConnection("Provider=Microsoft.ACE.OLEDB.12.0;" + _
        "Data Source=" + Server.MapPath("~") + "/resource/Olivias.accdb")
        Dim cmd As OleDbCommand = New OleDbCommand(updateCmd, conn)

        Dim DescriptionParam As New OleDbParameter("@Description", OleDbType.VarChar, 50)
        If CType(e.Item.Cells(3).Controls(0), TextBox).Text = "" Then
            DescriptionParam.Value = System.DBnull.Value
        Else
            DescriptionParam.Value = CType(e.Item.Cells(3).Controls(0), TextBox).Text
        End If
        cmd.Parameters.Add(DescriptionParam)

        Dim Model_nameParam As New OleDbParameter("@Model_name", OleDbType.VarChar, 50)
        If CType(e.Item.Cells(4).Controls(0), TextBox).Text = "" Then
            Model_nameParam.Value = System.DBnull.Value
        Else
            Model_nameParam.Value = CType(e.Item.Cells(4).Controls(0), TextBox).Text
        End If
        cmd.Parameters.Add(Model_nameParam)

        Dim Manufacturer_nameParam As New OleDbParameter("@Manufacturer_name", OleDbType.VarChar, 50)
        If CType(e.Item.Cells(5).Controls(0), TextBox).Text = "" Then
            Manufacturer_nameParam.Value = System.DBnull.Value
        Else
            Manufacturer_nameParam.Value = CType(e.Item.Cells(5).Controls(0), TextBox).Text
        End If
        cmd.Parameters.Add(Manufacturer_nameParam)

        Dim Product_type_codeParam As New OleDbParameter("@Product_type_code", OleDbType.VarChar, 50)
        If CType(e.Item.Cells(6).Controls(0), TextBox).Text = "" Then
            Product_type_codeParam.Value = System.DBnull.Value
        Else
            Product_type_codeParam.Value = CType(e.Item.Cells(6).Controls(0), TextBox).Text
        End If
        cmd.Parameters.Add(Product_type_codeParam)

        Dim Manufacturer_SRPParam As New OleDbParameter("@Manufacturer_SRP", OleDbType.VarChar, 50)
        If CType(e.Item.Cells(7).Controls(0), TextBox).Text = "" Then
            Manufacturer_SRPParam.Value = System.DBnull.Value
        Else
            Manufacturer_SRPParam.Value = CType(e.Item.Cells(7).Controls(0), TextBox).Text
        End If
        cmd.Parameters.Add(Manufacturer_SRPParam)

        Dim In_stock_quantityParam As New OleDbParameter("@In_stock_quantity", OleDbType.VarChar, 50)
        If CType(e.Item.Cells(8).Controls(0), TextBox).Text = "" Then
            In_stock_quantityParam.Value = System.DBnull.Value
        Else
            In_stock_quantityParam.Value = CType(e.Item.Cells(8).Controls(0), TextBox).Text
        End If
        cmd.Parameters.Add(In_stock_quantityParam)


        Try
            conn.Open()
            cmd.ExecuteNonQuery()
            '      response.write(updateCmd) 
            _gd1.EditItemIndex = -1
        Finally
            conn.Dispose()
        End Try

        BindSortedData(Session("SortColumn"))
    End Sub
    ' ================================================================================
    Sub gd1_Insert(sender As Object, _
                           e As DataGridCommandEventArgs)
        If e.CommandName = "Insert" Then
            Dim txtProduct_id As TextBox = e.Item.FindControl("add_Product_id")
            Dim txtDescription As TextBox = e.Item.FindControl("add_Description")
            Dim txtModel_name As TextBox = e.Item.FindControl("add_Model_name")
            Dim txtManufacturer_name As TextBox = e.Item.FindControl("add_Manufacturer_name")
            Dim txtProduct_type_code As TextBox = e.Item.FindControl("add_Product_type_code")
            Dim txtManufacturer_SRP As TextBox = e.Item.FindControl("add_Manufacturer_SRP")
            Dim txtIn_stock_quantity As TextBox = e.Item.FindControl("add_In_stock_quantity")

            Dim InsertCmd As String
            'Create the appropriate SQL statement
            InsertCmd = "INSERT INTO Product (" _
                  & " Product_id" _
                  & ", Description" _
                  & ", Model_name" _
                  & ", Manufacturer_name" _
                  & ", Product_type_code" _
                  & ", Manufacturer_SRP" _
                  & ", In_stock_quantity" _
                  & ") VALUES (" _
                  & "@Product_id" _
                  & ",@Description" _
                  & ",@Model_name" _
                  & ",@Manufacturer_name" _
                  & ",@Product_type_code" _
                  & ",@Manufacturer_SRP" _
                  & ",@In_stock_quantity" _
                  & ")"
            Dim conn As OleDBConnection
            conn = New OleDBConnection("Provider=Microsoft.ACE.OLEDB.12.0;" + _
            "Data Source=" + Server.MapPath("~") + "/resource/Olivias.accdb")
            Dim cmd As OleDbCommand = New OleDbCommand(InsertCmd, conn)

            Dim Product_idParam As New OleDbParameter("@Product_id", OleDbType.VarChar, 50)
            If txtProduct_id.Text = "" Then
                Product_idParam.Value = System.DBnull.Value
            Else
                Product_idParam.Value = txtProduct_id.Text
            End If
            cmd.Parameters.Add(Product_idParam)

            Dim DescriptionParam As New OleDbParameter("@Description", OleDbType.VarChar, 50)
            If txtDescription.Text = "" Then
                DescriptionParam.Value = System.DBnull.Value
            Else
                DescriptionParam.Value = txtDescription.Text
            End If
            cmd.Parameters.Add(DescriptionParam)

            Dim Model_nameParam As New OleDbParameter("@Model_name", OleDbType.VarChar, 50)
            If txtModel_name.Text = "" Then
                Model_nameParam.Value = System.DBnull.Value
            Else
                Model_nameParam.Value = txtModel_name.Text
            End If
            cmd.Parameters.Add(Model_nameParam)

            Dim Manufacturer_nameParam As New OleDbParameter("@Manufacturer_name", OleDbType.VarChar, 50)
            If txtManufacturer_name.Text = "" Then
                Manufacturer_nameParam.Value = System.DBnull.Value
            Else
                Manufacturer_nameParam.Value = txtManufacturer_name.Text
            End If
            cmd.Parameters.Add(Manufacturer_nameParam)

            Dim Product_type_codeParam As New OleDbParameter("@Product_type_code", OleDbType.VarChar, 50)
            If txtProduct_type_code.Text = "" Then
                Product_type_codeParam.Value = System.DBnull.Value
            Else
                Product_type_codeParam.Value = txtProduct_type_code.Text
            End If
            cmd.Parameters.Add(Product_type_codeParam)

            Dim Manufacturer_SRPParam As New OleDbParameter("@Manufacturer_SRP", OleDbType.VarChar, 50)
            If txtManufacturer_SRP.Text = "" Then
                Manufacturer_SRPParam.Value = System.DBnull.Value
            Else
                Manufacturer_SRPParam.Value = txtManufacturer_SRP.Text
            End If
            cmd.Parameters.Add(Manufacturer_SRPParam)

            Dim In_stock_quantityParam As New OleDbParameter("@In_stock_quantity", OleDbType.VarChar, 50)
            If txtIn_stock_quantity.Text = "" Then
                In_stock_quantityParam.Value = System.DBnull.Value
            Else
                In_stock_quantityParam.Value = txtIn_stock_quantity.Text
            End If
            cmd.Parameters.Add(In_stock_quantityParam)

            Try
                conn.Open()
                cmd.ExecuteNonQuery()
                '      response.write(InsertCmd) 
                _gd1.EditItemIndex = -1
            Finally
                conn.Dispose()
            End Try
            BindSortedData(Session("SortColumn"))
        End If
    End Sub

    ' ================================================================================
    Sub gd1_Delete(sender As Object, _
                           e As DataGridCommandEventArgs)
        _gd1.ShowFooter = True
        Dim SelectedPK As String = _gd1.DataKeys(e.Item.ItemIndex)
        Dim deleteCmd As String = "DELETE from Product " & _
          "where format(Product_id)= " & """" & SelectedPK & """"
        Dim conn As OleDBConnection
        conn = New OleDBConnection("Provider=Microsoft.ACE.OLEDB.12.0;" + _
        "Data Source=" + Server.MapPath("~") + "/resource/Olivias.accdb")
        Dim cmd As OleDbCommand = New OleDbCommand(deleteCmd, conn)
        Try
            conn.Open()
            cmd.ExecuteNonQuery()
            '      response.write(deleteCmd) 
            _gd1.EditItemIndex = -1
        Finally
            conn.Dispose()
        End Try
        BindSortedData(Session("SortColumn"))
    End Sub

' ================================================================================
  Sub gd1_ItemDataBound(sender as Object, e as DataGridItemEventArgs)
    ' First, make sure we're NOT dealing with a Header or Footer row
    If e.Item.ItemType <> ListItemType.Header AND _
         e.Item.ItemType <> ListItemType.Footer then
      'Now, reference the LinkButton control the Delete ButtonColumn was referenced to 
      Dim deleteButton as LinkButton = e.Item.Cells(1).Controls(1)
      'We can now add the onclick event handler
      deleteButton.Attributes("onclick") = "javascript:return " & _
                "confirm('Are you sure you want to delete Product_id=" & _
                DataBinder.Eval(e.Item.DataItem, "Product_id") & "?')"    
    End If
  End Sub

' ================================================================================

</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <link href="CSS/mis311-hoverbutton.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
    a:link {
    color: #000000;
}

/* visited link */
a:visited {
    color: #000000;
}

/* mouse over link */
a:hover {
    color: #FF00FF;
}

/* selected link */
a:active {
    color: #000000;
}
        .auto-style12 {
            font-weight: bold;
            background-color: #000000;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <p align="center"><font size="5" color="#000000"><span>Edit Products</span></font></p>

<asp:datagrid id="_gd1" runat=server AutoGenerateColumns="False" AllowSorting="True"
  GridLines=None
  CellSpacing=2
  Font-Name=Oswald Font-Size=8pt
  HeaderStyle-BackColor="#959595"
  FooterStyle-BackColor="#959595"
  ShowFooter=true
  ItemStyle-BackColor=white
  CellPadding=2
  Align="center"
      OnItemCommand="gd1_Insert"
  OnEditCommand="gd1_Edit"
  OnCancelCommand="gd1_Cancel"
  OnDeleteCommand="gd1_Delete"
  OnUpdateCommand="gd1_Update"
  DataKeyField="Product_id"
        OnItemDataBound="gd1_ItemDataBound"
        OnSortCommand="gd1_Sort">
  <Columns>
	<asp:EditCommandColumn ButtonType="LinkButton" UpdateText="Update" CancelText="Cancel" EditText="Edit"></asp:EditCommandColumn>
      <asp:TemplateColumn >
        <FooterTemplate>
          <asp:LinkButton CommandName="Insert" Text="Add" ID="btnAdd" Runat="server" />
        </FooterTemplate>
        <ItemTemplate>
          <asp:LinkButton CommandName="Delete" Text="Delete" ID="btnDel" Runat="server" />
        </ItemTemplate>
      </asp:TemplateColumn>

      <asp:TemplateColumn HeaderText="Product_id">
        <HeaderTemplate><asp:LinkButton CommandName="Sort" CommandArgument="Product_id" ID="btnSortProduct_id" Runat="Server">Product_id</asp:LinkButton></HeaderTemplate>
        <FooterTemplate><asp:TextBox ID="add_Product_id" Columns="5" Runat="Server" /></FooterTemplate>
        <ItemTemplate><%# Container.DataItem("Product_id") %></ItemTemplate>
        <EditItemTemplate><asp:TextBox ID="Product_id" Columns="5" Text='<%# Container.DataItem("Product_id") %>' Runat="server" /></EditItemTemplate>
      </asp:TemplateColumn>

      <asp:TemplateColumn HeaderText="Description">
        <HeaderTemplate><asp:LinkButton CommandName="Sort" CommandArgument="Description" ID="btnSortDescription" Runat="Server">Description</asp:LinkButton></HeaderTemplate>
        <FooterTemplate><asp:TextBox ID="add_Description" Columns="5" Runat="Server" /></FooterTemplate>
        <ItemTemplate><%# Container.DataItem("Description") %></ItemTemplate>
        <EditItemTemplate><asp:TextBox ID="Description" Columns="5" Text='<%# Container.DataItem("Description") %>' Runat="server" /></EditItemTemplate>
      </asp:TemplateColumn>

      <asp:TemplateColumn HeaderText="Model_name">
        <HeaderTemplate><asp:LinkButton CommandName="Sort" CommandArgument="Model_name" ID="btnSortModel_name" Runat="Server">Model_name</asp:LinkButton></HeaderTemplate>
        <FooterTemplate><asp:TextBox ID="add_Model_name" Columns="5" Runat="Server" /></FooterTemplate>
        <ItemTemplate><%# Container.DataItem("Model_name") %></ItemTemplate>
        <EditItemTemplate><asp:TextBox ID="Model_name" Columns="5" Text='<%# Container.DataItem("Model_name") %>' Runat="server" /></EditItemTemplate>
      </asp:TemplateColumn>

      <asp:TemplateColumn HeaderText="Manufacturer_name">
        <HeaderTemplate><asp:LinkButton CommandName="Sort" CommandArgument="Manufacturer_name" ID="btnSortManufacturer_name" Runat="Server">Manufacturer_name</asp:LinkButton></HeaderTemplate>
        <FooterTemplate><asp:TextBox ID="add_Manufacturer_name" Columns="5" Runat="Server" /></FooterTemplate>
        <ItemTemplate><%# Container.DataItem("Manufacturer_name") %></ItemTemplate>
        <EditItemTemplate><asp:TextBox ID="Manufacturer_name" Columns="5" Text='<%# Container.DataItem("Manufacturer_name") %>' Runat="server" /></EditItemTemplate>
      </asp:TemplateColumn>

      <asp:TemplateColumn HeaderText="Product_type_code">
        <HeaderTemplate><asp:LinkButton CommandName="Sort" CommandArgument="Product_type_code" ID="btnSortProduct_type_code" Runat="Server">Product_type_code</asp:LinkButton><a href="product_type-view-lookup.aspx">^</a> </HeaderTemplate>
        <FooterTemplate><asp:TextBox ID="add_Product_type_code" Columns="5" Runat="Server" /><a href="product_type-view-lookup.aspx">^</a> </FooterTemplate>
        <ItemTemplate><%# Container.DataItem("Product_type_code") %></ItemTemplate>
        <EditItemTemplate><asp:TextBox ID="Product_type_code" Columns="5" Text='<%# Container.DataItem("Product_type_code") %>' Runat="server" /></EditItemTemplate>
      </asp:TemplateColumn>

      <asp:TemplateColumn HeaderText="Manufacturer_SRP">
        <HeaderTemplate><asp:LinkButton CommandName="Sort" CommandArgument="Manufacturer_SRP" ID="btnSortManufacturer_SRP" Runat="Server">Manufacturer_SRP</asp:LinkButton></HeaderTemplate>
        <FooterTemplate><asp:TextBox ID="add_Manufacturer_SRP" Columns="5" Runat="Server" /></FooterTemplate>
        <ItemTemplate><%# Container.DataItem("Manufacturer_SRP") %></ItemTemplate>
        <EditItemTemplate><asp:TextBox ID="Manufacturer_SRP" Columns="5" Text='<%# Container.DataItem("Manufacturer_SRP") %>' Runat="server" /></EditItemTemplate>
      </asp:TemplateColumn>

      <asp:TemplateColumn HeaderText="In_stock_quantity">
        <HeaderTemplate><asp:LinkButton CommandName="Sort" CommandArgument="In_stock_quantity" ID="btnSortIn_stock_quantity" Runat="Server">In_stock_quantity</asp:LinkButton></HeaderTemplate>
        <FooterTemplate><asp:TextBox ID="add_In_stock_quantity" Columns="5" Runat="Server" /></FooterTemplate>
        <ItemTemplate><%# Container.DataItem("In_stock_quantity") %></ItemTemplate>
        <EditItemTemplate><asp:TextBox ID="In_stock_quantity" Columns="5" Text='<%# Container.DataItem("In_stock_quantity") %>' Runat="server" /></EditItemTemplate>
      </asp:TemplateColumn>

   </Columns>
</asp:datagrid>
    <br />
<Center><a align="center" class="mis311-hoverbutton" href="maintenance.aspx">BACK</a></center>
</asp:Content>
