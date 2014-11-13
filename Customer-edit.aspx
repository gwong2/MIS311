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
' 1) Copy and rename this file as EDITim_Customer.txt, where Customer is the name of your database table
' 2) Using Notepad, do a global search-and-replace of ALL OCCURRENCES (try ctl-h) in this template as follows:
'    -Replace Customer with the database table name
'    -Replace Customer_id with the name of the database table's primary key column
'    -Replace Olivias with the name of your database (eg. xgen): do not include .accdb in the name
'    -Replace Max_credit_limit with the name of the first non-primary-key column in the database table 
'    -Replace Family_name with the name of the second non-primary-key column, if applicable  
'    -continue replacing Given_names through FFFFA for the third through tenth non-primary-key columns, if applicable
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
      Session("SortColumn") = "Customer_id"
      BindSortedData(Session("SortColumn"))
    End If
  End Sub

' ================================================================================
  Sub BindSortedData(sortExpr as String)
        Dim conn as OleDBConnection
        conn = new OleDBConnection("Provider=Microsoft.ACE.OLEDB.12.0;"+ _
        "Data Source=" + Server.MapPath("~") + "/resource/Olivias.accdb")
       Dim sortSQL as String = "SELECT * FROM Customer ORDER BY " & sortExpr 
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
      updateCmd = "Update Customer SET " _
            & "Max_credit_limit = @Max_credit_limit" _
            & ", Family name = @Family_name" _
            & ", Given names = @Given_names" _
            & ", Phone number = @Phone_number" _
            & ", Address = @Address" _
            & ", Municipality = @Municipality" _
            & ", Province code = @Province_code" _
            & ", Postal code = @Postal_code" _
            & ", Rep employee id = @Rep_employee_id" _
            & " where format(Customer_id) = "  & """" & CType(e.Item.Cells(2).Controls(0), TextBox).Text  & """"

     Dim conn as OleDBConnection
        conn = new OleDBConnection("Provider=Microsoft.ACE.OLEDB.12.0;"+ _
        "Data Source=" + Server.MapPath("~") + "/resource/Olivias.accdb")
     Dim cmd As OleDbCommand = new OleDbCommand(updateCmd, conn)

     Dim Max_credit_limitParam as New OleDbParameter("@Max_credit_limit", OleDbType.VarChar, 50)
      If CType(e.Item.Cells(3).Controls(0), TextBox).Text = "" Then 
      Max_credit_limitParam.Value = System.DBnull.Value
      Else 
      Max_credit_limitParam.Value = CType(e.Item.Cells(3).Controls(0), TextBox).Text
      End If 
      cmd.Parameters.Add(Max_credit_limitParam)

     Dim Family_nameParam as New OleDbParameter("@Family_name", OleDbType.VarChar, 50)
      If CType(e.Item.Cells(4).Controls(0), TextBox).Text = "" Then 
      Family_nameParam.Value = System.DBnull.Value
      Else 
      Family_nameParam.Value = CType(e.Item.Cells(4).Controls(0), TextBox).Text
      End If 
      cmd.Parameters.Add(Family_nameParam)

     Dim Given_namesParam as New OleDbParameter("@Given_names", OleDbType.VarChar, 50)
      If CType(e.Item.Cells(5).Controls(0), TextBox).Text = "" Then 
      Given_namesParam.Value = System.DBnull.Value
      Else 
      Given_namesParam.Value = CType(e.Item.Cells(5).Controls(0), TextBox).Text
      End If 
      cmd.Parameters.Add(Given_namesParam)

     Dim Phone_numberParam as New OleDbParameter("@Phone_number", OleDbType.VarChar, 50)
      If CType(e.Item.Cells(6).Controls(0), TextBox).Text = "" Then 
      Phone_numberParam.Value = System.DBnull.Value
      Else 
      Phone_numberParam.Value = CType(e.Item.Cells(6).Controls(0), TextBox).Text
      End If 
      cmd.Parameters.Add(Phone_numberParam)

     Dim AddressParam as New OleDbParameter("@Address", OleDbType.VarChar, 50)
      If CType(e.Item.Cells(7).Controls(0), TextBox).Text = "" Then 
      AddressParam.Value = System.DBnull.Value
      Else 
      AddressParam.Value = CType(e.Item.Cells(7).Controls(0), TextBox).Text
      End If 
      cmd.Parameters.Add(AddressParam)

     Dim MunicipalityParam as New OleDbParameter("@Municipality", OleDbType.VarChar, 50)
      If CType(e.Item.Cells(8).Controls(0), TextBox).Text = "" Then 
      MunicipalityParam.Value = System.DBnull.Value
      Else 
      MunicipalityParam.Value = CType(e.Item.Cells(8).Controls(0), TextBox).Text
      End If 
      cmd.Parameters.Add(MunicipalityParam)

     Dim Province_codeParam as New OleDbParameter("@Province_code", OleDbType.VarChar, 50)
      If CType(e.Item.Cells(9).Controls(0), TextBox).Text = "" Then 
      Province_codeParam.Value = System.DBnull.Value
      Else 
      Province_codeParam.Value = CType(e.Item.Cells(9).Controls(0), TextBox).Text
      End If 
      cmd.Parameters.Add(Province_codeParam)

     Dim Postal_codeParam as New OleDbParameter("@Postal_code", OleDbType.VarChar, 50)
      If CType(e.Item.Cells(10).Controls(0), TextBox).Text = "" Then 
      Postal_codeParam.Value = System.DBnull.Value
      Else 
      Postal_codeParam.Value = CType(e.Item.Cells(10).Controls(0), TextBox).Text
      End If 
      cmd.Parameters.Add(Postal_codeParam)

     Dim Rep_employee_idParam as New OleDbParameter("@Rep_employee_id", OleDbType.VarChar, 50)
      If CType(e.Item.Cells(11).Controls(0), TextBox).Text = "" Then 
      Rep_employee_idParam.Value = System.DBnull.Value
      Else 
      Rep_employee_idParam.Value = CType(e.Item.Cells(11).Controls(0), TextBox).Text
      End If 
      cmd.Parameters.Add(Rep_employee_idParam)

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
      Dim txtCustomer_id As TextBox = e.Item.FindControl("add_Customer_id")
      Dim txtMax_credit_limit As TextBox = e.Item.FindControl("add_Max_credit_limit")
      Dim txtFamily_name As TextBox = e.Item.FindControl("add_Family_name")
      Dim txtGiven_names As TextBox = e.Item.FindControl("add_Given_names")
      Dim txtPhone_number As TextBox = e.Item.FindControl("add_Phone_number")
      Dim txtAddress As TextBox = e.Item.FindControl("add_Address")
      Dim txtMunicipality As TextBox = e.Item.FindControl("add_Municipality")
      Dim txtProvince_code As TextBox = e.Item.FindControl("add_Province_code")
      Dim txtPostal_code As TextBox = e.Item.FindControl("add_Postal_code")
      Dim txtRep_employee_id As TextBox = e.Item.FindControl("add_Rep_employee_id")

      Dim InsertCmd As String
      'Create the appropriate SQL statement
      InsertCmd = "INSERT INTO Customer (" _
            & " Customer_id" _
            & ", Max_credit_limit" _
            & ", Family_name" _
            & ", Given_names" _
            & ", Phone_number" _
            & ", Address" _
            & ", Municipality" _
            & ", Province_code" _
            & ", Postal_code" _
            & ", Rep_employee_id" _
            & ") VALUES (" _
            & "@Customer_id"  _
            & ",@Max_credit_limit"  _
            & ",@Family_name"  _
            & ",@Given_names"  _
            & ",@Phone_number"  _
            & ",@Address"  _
            & ",@Municipality"  _
            & ",@Province_code"  _
            & ",@Postal_code"  _
            & ",@Rep_employee_id"  _
            & ")"
     Dim conn as OleDBConnection
        conn = new OleDBConnection("Provider=Microsoft.ACE.OLEDB.12.0;"+ _
        "Data Source=" + Server.MapPath("~") + "/resource/Olivias.accdb")
     Dim cmd As OleDbCommand = new OleDbCommand(InsertCmd, conn)

     Dim Customer_idParam as New OleDbParameter("@Customer_id", OleDbType.VarChar, 50)
      If txtCustomer_id.Text = "" Then 
      Customer_idParam.Value = System.DBnull.Value
      Else 
      Customer_idParam.Value = txtCustomer_id.Text
      End If 
      cmd.Parameters.Add(Customer_idParam)

     Dim Max_credit_limitParam as New OleDbParameter("@Max_credit_limit", OleDbType.VarChar, 50)
      If txtMax_credit_limit.Text = "" Then 
      Max_credit_limitParam.Value = System.DBnull.Value
      Else 
      Max_credit_limitParam.Value = txtMax_credit_limit.Text
      End If 
      cmd.Parameters.Add(Max_credit_limitParam)

     Dim Family_nameParam as New OleDbParameter("@Family_name", OleDbType.VarChar, 50)
      If txtFamily_name.Text = "" Then 
      Family_nameParam.Value = System.DBnull.Value
      Else 
      Family_nameParam.Value = txtFamily_name.Text
      End If 
      cmd.Parameters.Add(Family_nameParam)

     Dim Given_namesParam as New OleDbParameter("@Given_names", OleDbType.VarChar, 50)
      If txtGiven_names.Text = "" Then 
      Given_namesParam.Value = System.DBnull.Value
      Else 
      Given_namesParam.Value = txtGiven_names.Text
      End If 
      cmd.Parameters.Add(Given_namesParam)

     Dim Phone_numberParam as New OleDbParameter("@Phone_number", OleDbType.VarChar, 50)
      If txtPhone_number.Text = "" Then 
      Phone_numberParam.Value = System.DBnull.Value
      Else 
      Phone_numberParam.Value = txtPhone_number.Text
      End If 
      cmd.Parameters.Add(Phone_numberParam)

     Dim AddressParam as New OleDbParameter("@Address", OleDbType.VarChar, 50)
      If txtAddress.Text = "" Then 
      AddressParam.Value = System.DBnull.Value
      Else 
      AddressParam.Value = txtAddress.Text
      End If 
      cmd.Parameters.Add(AddressParam)

     Dim MunicipalityParam as New OleDbParameter("@Municipality", OleDbType.VarChar, 50)
      If txtMunicipality.Text = "" Then 
      MunicipalityParam.Value = System.DBnull.Value
      Else 
      MunicipalityParam.Value = txtMunicipality.Text
      End If 
      cmd.Parameters.Add(MunicipalityParam)

     Dim Province_codeParam as New OleDbParameter("@Province_code", OleDbType.VarChar, 50)
      If txtProvince_code.Text = "" Then 
      Province_codeParam.Value = System.DBnull.Value
      Else 
      Province_codeParam.Value = txtProvince_code.Text
      End If 
      cmd.Parameters.Add(Province_codeParam)

     Dim Postal_codeParam as New OleDbParameter("@Postal_code", OleDbType.VarChar, 50)
      If txtPostal_code.Text = "" Then 
      Postal_codeParam.Value = System.DBnull.Value
      Else 
      Postal_codeParam.Value = txtPostal_code.Text
      End If 
      cmd.Parameters.Add(Postal_codeParam)

     Dim Rep_employee_idParam as New OleDbParameter("@Rep_employee_id", OleDbType.VarChar, 50)
      If txtRep_employee_id.Text = "" Then 
      Rep_employee_idParam.Value = System.DBnull.Value
      Else 
      Rep_employee_idParam.Value = txtRep_employee_id.Text
      End If 
      cmd.Parameters.Add(Rep_employee_idParam)

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
     Dim SelectedPK as String = _gd1.DataKeys(e.Item.ItemIndex)
     Dim deleteCmd As String = "DELETE from Customer " & _ 
       "where format(Customer_id)= " & """" & SelectedPK & """"
     Dim conn as OleDBConnection
        conn = new OleDBConnection("Provider=Microsoft.ACE.OLEDB.12.0;"+ _
        "Data Source=" + Server.MapPath("~") + "/resource/Olivias.accdb")
     Dim cmd As OleDbCommand = new OleDbCommand(deleteCmd, conn)
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
                "confirm('Are you sure you want to delete Customer_id=" & _
                DataBinder.Eval(e.Item.DataItem, "Customer_id") & "?')"    
    End If
  End Sub

' ================================================================================

</script>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
    .newStyle3 {
        position: inherit;
        }
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
</style>
    <link href="CSS/mis311-hoverbutton.css" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <p  align="center"><b><font size="5" color="#000000" >Edit Customers</font></b><i> </i></p>

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
  DataKeyField="Customer_id"
        OnItemDataBound="gd1_ItemDataBound"
        OnSortCommand="gd1_Sort" style="position: relative; top: -3px; left: -1px">
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

      <asp:TemplateColumn HeaderText="Customer_id">
        <HeaderTemplate><asp:LinkButton CommandName="Sort" CommandArgument="Customer_id" ID="btnSortCustomer_id" Runat="Server">Customer_id</asp:LinkButton></HeaderTemplate>
        <FooterTemplate><asp:TextBox ID="add_Customer_id" Columns="5" Runat="Server" /></FooterTemplate>
        <ItemTemplate><%# Container.DataItem("Customer_id") %></ItemTemplate>
        <EditItemTemplate><asp:TextBox ID="Customer_id" Columns="5" Text='<%# Container.DataItem("Customer_id") %>' Runat="server" /></EditItemTemplate>
      </asp:TemplateColumn>

      <asp:TemplateColumn HeaderText="Max_credit_limit">
        <HeaderTemplate><asp:LinkButton CommandName="Sort" CommandArgument="Max_credit_limit" ID="btnSortMax_credit_limit" Runat="Server">Max_credit_limit</asp:LinkButton></HeaderTemplate>
        <FooterTemplate><asp:TextBox ID="add_Max_credit_limit" Columns="5" Runat="Server" /></FooterTemplate>
        <ItemTemplate><%# Container.DataItem("Max_credit_limit") %></ItemTemplate>
        <EditItemTemplate><asp:TextBox ID="Max_credit_limit" Columns="5" Text='<%# Container.DataItem("Max_credit_limit") %>' Runat="server" /></EditItemTemplate>
      </asp:TemplateColumn>

      <asp:TemplateColumn HeaderText="Family_name">
        <HeaderTemplate><asp:LinkButton CommandName="Sort" CommandArgument="Family_name" ID="btnSortFamily_name" Runat="Server">Family_name</asp:LinkButton></HeaderTemplate>
        <FooterTemplate><asp:TextBox ID="add_Family_name" Columns="5" Runat="Server" /></FooterTemplate>
        <ItemTemplate><%# Container.DataItem("Family_name") %></ItemTemplate>
        <EditItemTemplate><asp:TextBox ID="Family_name" Columns="5" Text='<%# Container.DataItem("Family_name") %>' Runat="server" /></EditItemTemplate>
      </asp:TemplateColumn>

      <asp:TemplateColumn HeaderText="Given_names">
        <HeaderTemplate><asp:LinkButton CommandName="Sort" CommandArgument="Given_names" ID="btnSortGiven_names" Runat="Server">Given_names</asp:LinkButton></HeaderTemplate>
        <FooterTemplate><asp:TextBox ID="add_Given_names" Columns="5" Runat="Server" /></FooterTemplate>
        <ItemTemplate><%# Container.DataItem("Given_names") %></ItemTemplate>
        <EditItemTemplate><asp:TextBox ID="Given_names" Columns="5" Text='<%# Container.DataItem("Given_names") %>' Runat="server" /></EditItemTemplate>
      </asp:TemplateColumn>

      <asp:TemplateColumn HeaderText="Phone_number">
        <HeaderTemplate><asp:LinkButton CommandName="Sort" CommandArgument="Phone_number" ID="btnSortPhone_number" Runat="Server">Phone_number</asp:LinkButton></HeaderTemplate>
        <FooterTemplate><asp:TextBox ID="add_Phone_number" Columns="5" Runat="Server" /></FooterTemplate>
        <ItemTemplate><%# Container.DataItem("Phone_number") %></ItemTemplate>
        <EditItemTemplate><asp:TextBox ID="Phone_number" Columns="5" Text='<%# Container.DataItem("Phone_number") %>' Runat="server" /></EditItemTemplate>
      </asp:TemplateColumn>

      <asp:TemplateColumn HeaderText="Address">
        <HeaderTemplate><asp:LinkButton CommandName="Sort" CommandArgument="Address" ID="btnSortAddress" Runat="Server">Address</asp:LinkButton></HeaderTemplate>
        <FooterTemplate><asp:TextBox ID="add_Address" Columns="5" Runat="Server" /></FooterTemplate>
        <ItemTemplate><%# Container.DataItem("Address") %></ItemTemplate>
        <EditItemTemplate><asp:TextBox ID="Address" Columns="5" Text='<%# Container.DataItem("Address") %>' Runat="server" /></EditItemTemplate>
      </asp:TemplateColumn>

      <asp:TemplateColumn HeaderText="Municipality">
        <HeaderTemplate><asp:LinkButton CommandName="Sort" CommandArgument="Municipality" ID="btnSortMunicipality" Runat="Server">Municipality</asp:LinkButton></HeaderTemplate>
        <FooterTemplate><asp:TextBox ID="add_Municipality" Columns="5" Runat="Server" /></FooterTemplate>
        <ItemTemplate><%# Container.DataItem("Municipality") %></ItemTemplate>
        <EditItemTemplate><asp:TextBox ID="Municipality" Columns="5" Text='<%# Container.DataItem("Municipality") %>' Runat="server" /></EditItemTemplate>
      </asp:TemplateColumn>

      <asp:TemplateColumn HeaderText="Province_code">
        <HeaderTemplate><asp:LinkButton CommandName="Sort" CommandArgument="Province_code" ID="btnSortProvince_code" Runat="Server">Province_code</asp:LinkButton></HeaderTemplate>
        <FooterTemplate><asp:TextBox ID="add_Province_code" Columns="5" Runat="Server" /></FooterTemplate>
        <ItemTemplate><%# Container.DataItem("Province_code") %></ItemTemplate>
        <EditItemTemplate><asp:TextBox ID="Province_code" Columns="5" Text='<%# Container.DataItem("Province_code") %>' Runat="server" /></EditItemTemplate>
      </asp:TemplateColumn>

      <asp:TemplateColumn HeaderText="Postal_code">
        <HeaderTemplate><asp:LinkButton CommandName="Sort" CommandArgument="Postal_code" ID="btnSortPostal_code" Runat="Server">Postal_code</asp:LinkButton></HeaderTemplate>
        <FooterTemplate><asp:TextBox ID="add_Postal_code" Columns="5" Runat="Server" /></FooterTemplate>
        <ItemTemplate><%# Container.DataItem("Postal_code") %></ItemTemplate>
        <EditItemTemplate><asp:TextBox ID="Postal_code" Columns="5" Text='<%# Container.DataItem("Postal_code") %>' Runat="server" /></EditItemTemplate>
      </asp:TemplateColumn>

      <asp:TemplateColumn HeaderText="Rep_employee_id">
        <HeaderTemplate><asp:LinkButton CommandName="Sort" CommandArgument="Rep_employee_id" ID="btnSortRep_employee_id" Runat="Server">Rep_employee_id</asp:LinkButton><a href="employee-view.aspx">^</a> </HeaderTemplate>
        <FooterTemplate><asp:TextBox ID="add_Rep_employee_id" Columns="5" Runat="Server" /><a href="employee-view.aspx">^</a></FooterTemplate>
        <ItemTemplate><%# Container.DataItem("Rep_employee_id") %></ItemTemplate>
        <EditItemTemplate><asp:TextBox ID="Rep_employee_id" Columns="5" Text='<%# Container.DataItem("Rep_employee_id") %>' Runat="server" /></EditItemTemplate>
      </asp:TemplateColumn>

   </Columns>
</asp:datagrid>
    <br />
<Center><a align="center" class="mis311-hoverbutton" href="maintenance.aspx">BACK</a></center>
</asp:Content>
