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
' 1) Copy and rename this file as EDITim_Employee.txt, where Employee is the name of your database table
' 2) Using Notepad, do a global search-and-replace of ALL OCCURRENCES (try ctl-h) in this template as follows:
'    -Replace Employee with the database table name
'    -Replace Employee_id with the name of the database table's primary key column
'    -Replace Olivias with the name of your database (eg. xgen): do not include .accdb in the name
'    -Replace Family_name with the name of the first non-primary-key column in the database table 
'    -Replace Given_names with the name of the second non-primary-key column, if applicable  
'    -continue replacing Hire_date through FFFFA for the third through tenth non-primary-key columns, if applicable
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
      Session("SortColumn") = "Employee_id"
      BindSortedData(Session("SortColumn"))
    End If
  End Sub

' ================================================================================
  Sub BindSortedData(sortExpr as String)
        Dim conn as OleDBConnection
        conn = new OleDBConnection("Provider=Microsoft.ACE.OLEDB.12.0;"+ _
        "Data Source=" + Server.MapPath("~") + "/resource/Olivias.accdb")
       Dim sortSQL as String = "SELECT * FROM Employee ORDER BY " & sortExpr 
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
      updateCmd = "Update Employee SET " _
            & "Family_name = @Family_name" _
            & ", Given_names = @Given_names" _
            & ", Hire_date = @Hire_date" _
            & ", Job_type = @Job_type" _
            & ", Salary = @Salary" _
            & ", Commission = @Commission" _
            & ", Department_id = @Department_id" _
            & ", Supervisor_id = @Supervisor_id" _
            & " where format(Employee_id) = "  & """" & CType(e.Item.Cells(2).Controls(0), TextBox).Text  & """"

     Dim conn as OleDBConnection
        conn = new OleDBConnection("Provider=Microsoft.ACE.OLEDB.12.0;"+ _
        "Data Source=" + Server.MapPath("~") + "/resource/Olivias.accdb")
     Dim cmd As OleDbCommand = new OleDbCommand(updateCmd, conn)

     Dim Family_nameParam as New OleDbParameter("@Family_name", OleDbType.VarChar, 50)
      If CType(e.Item.Cells(3).Controls(0), TextBox).Text = "" Then 
      Family_nameParam.Value = System.DBnull.Value
      Else 
      Family_nameParam.Value = CType(e.Item.Cells(3).Controls(0), TextBox).Text
      End If 
      cmd.Parameters.Add(Family_nameParam)

     Dim Given_namesParam as New OleDbParameter("@Given_names", OleDbType.VarChar, 50)
      If CType(e.Item.Cells(4).Controls(0), TextBox).Text = "" Then 
      Given_namesParam.Value = System.DBnull.Value
      Else 
      Given_namesParam.Value = CType(e.Item.Cells(4).Controls(0), TextBox).Text
      End If 
      cmd.Parameters.Add(Given_namesParam)

     Dim Hire_dateParam as New OleDbParameter("@Hire_date", OleDbType.VarChar, 50)
      If CType(e.Item.Cells(5).Controls(0), TextBox).Text = "" Then 
      Hire_dateParam.Value = System.DBnull.Value
      Else 
      Hire_dateParam.Value = CType(e.Item.Cells(5).Controls(0), TextBox).Text
      End If 
      cmd.Parameters.Add(Hire_dateParam)

     Dim Job_typeParam as New OleDbParameter("@Job_type", OleDbType.VarChar, 50)
      If CType(e.Item.Cells(6).Controls(0), TextBox).Text = "" Then 
      Job_typeParam.Value = System.DBnull.Value
      Else 
      Job_typeParam.Value = CType(e.Item.Cells(6).Controls(0), TextBox).Text
      End If 
      cmd.Parameters.Add(Job_typeParam)

     Dim SalaryParam as New OleDbParameter("@Salary", OleDbType.VarChar, 50)
      If CType(e.Item.Cells(7).Controls(0), TextBox).Text = "" Then 
      SalaryParam.Value = System.DBnull.Value
      Else 
      SalaryParam.Value = CType(e.Item.Cells(7).Controls(0), TextBox).Text
      End If 
      cmd.Parameters.Add(SalaryParam)

     Dim CommissionParam as New OleDbParameter("@Commission", OleDbType.VarChar, 50)
      If CType(e.Item.Cells(8).Controls(0), TextBox).Text = "" Then 
      CommissionParam.Value = System.DBnull.Value
      Else 
      CommissionParam.Value = CType(e.Item.Cells(8).Controls(0), TextBox).Text
      End If 
      cmd.Parameters.Add(CommissionParam)

     Dim Department_idParam as New OleDbParameter("@Department_id", OleDbType.VarChar, 50)
      If CType(e.Item.Cells(9).Controls(0), TextBox).Text = "" Then 
      Department_idParam.Value = System.DBnull.Value
      Else 
      Department_idParam.Value = CType(e.Item.Cells(9).Controls(0), TextBox).Text
      End If 
      cmd.Parameters.Add(Department_idParam)

     Dim Supervisor_idParam as New OleDbParameter("@Supervisor_id", OleDbType.VarChar, 50)
      If CType(e.Item.Cells(10).Controls(0), TextBox).Text = "" Then 
      Supervisor_idParam.Value = System.DBnull.Value
      Else 
      Supervisor_idParam.Value = CType(e.Item.Cells(10).Controls(0), TextBox).Text
      End If 
      cmd.Parameters.Add(Supervisor_idParam)

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
      Dim txtEmployee_id As TextBox = e.Item.FindControl("add_Employee_id")
      Dim txtFamily_name As TextBox = e.Item.FindControl("add_Family_name")
      Dim txtGiven_names As TextBox = e.Item.FindControl("add_Given_names")
      Dim txtHire_date As TextBox = e.Item.FindControl("add_Hire_date")
      Dim txtJob_type As TextBox = e.Item.FindControl("add_Job_type")
      Dim txtSalary As TextBox = e.Item.FindControl("add_Salary")
      Dim txtCommission As TextBox = e.Item.FindControl("add_Commission")
      Dim txtDepartment_id As TextBox = e.Item.FindControl("add_Department_id")
      Dim txtSupervisor_id As TextBox = e.Item.FindControl("add_Supervisor_id")

      Dim InsertCmd As String
      'Create the appropriate SQL statement
      InsertCmd = "INSERT INTO Employee (" _
            & " Employee_id" _
            & ", Family_name" _
            & ", Given_names" _
            & ", Hire_date" _
            & ", Job_type" _
            & ", Salary" _
            & ", Commission" _
            & ", Department_id" _
            & ", Supervisor_id" _
            & ") VALUES (" _
            & "@Employee_id"  _
            & ",@Family_name"  _
            & ",@Given_names"  _
            & ",@Hire_date"  _
            & ",@Job_type"  _
            & ",@Salary"  _
            & ",@Commission"  _
            & ",@Department_id"  _
            & ",@Supervisor_id"  _
            & ")"
     Dim conn as OleDBConnection
        conn = new OleDBConnection("Provider=Microsoft.ACE.OLEDB.12.0;"+ _
        "Data Source=" + Server.MapPath("~") + "/resource/Olivias.accdb")
     Dim cmd As OleDbCommand = new OleDbCommand(InsertCmd, conn)

     Dim Employee_idParam as New OleDbParameter("@Employee_id", OleDbType.VarChar, 50)
      If txtEmployee_id.Text = "" Then 
      Employee_idParam.Value = System.DBnull.Value
      Else 
      Employee_idParam.Value = txtEmployee_id.Text
      End If 
      cmd.Parameters.Add(Employee_idParam)

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

     Dim Hire_dateParam as New OleDbParameter("@Hire_date", OleDbType.VarChar, 50)
      If txtHire_date.Text = "" Then 
      Hire_dateParam.Value = System.DBnull.Value
      Else 
      Hire_dateParam.Value = txtHire_date.Text
      End If 
      cmd.Parameters.Add(Hire_dateParam)

     Dim Job_typeParam as New OleDbParameter("@Job_type", OleDbType.VarChar, 50)
      If txtJob_type.Text = "" Then 
      Job_typeParam.Value = System.DBnull.Value
      Else 
      Job_typeParam.Value = txtJob_type.Text
      End If 
      cmd.Parameters.Add(Job_typeParam)

     Dim SalaryParam as New OleDbParameter("@Salary", OleDbType.VarChar, 50)
      If txtSalary.Text = "" Then 
      SalaryParam.Value = System.DBnull.Value
      Else 
      SalaryParam.Value = txtSalary.Text
      End If 
      cmd.Parameters.Add(SalaryParam)

     Dim CommissionParam as New OleDbParameter("@Commission", OleDbType.VarChar, 50)
      If txtCommission.Text = "" Then 
      CommissionParam.Value = System.DBnull.Value
      Else 
      CommissionParam.Value = txtCommission.Text
      End If 
      cmd.Parameters.Add(CommissionParam)

     Dim Department_idParam as New OleDbParameter("@Department_id", OleDbType.VarChar, 50)
      If txtDepartment_id.Text = "" Then 
      Department_idParam.Value = System.DBnull.Value
      Else 
      Department_idParam.Value = txtDepartment_id.Text
      End If 
      cmd.Parameters.Add(Department_idParam)

     Dim Supervisor_idParam as New OleDbParameter("@Supervisor_id", OleDbType.VarChar, 50)
      If txtSupervisor_id.Text = "" Then 
      Supervisor_idParam.Value = System.DBnull.Value
      Else 
      Supervisor_idParam.Value = txtSupervisor_id.Text
      End If 
      cmd.Parameters.Add(Supervisor_idParam)

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
     Dim deleteCmd As String = "DELETE from Employee " & _ 
       "where format(Employee_id)= " & """" & SelectedPK & """"
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
                "confirm('Are you sure you want to delete Employee_id=" & _
                DataBinder.Eval(e.Item.DataItem, "Employee_id") & "?')"    
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
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <p align="center"><b><font size="5" color="#000000">Edit Employees</font></b></p>

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
  DataKeyField="Employee_id"
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

      <asp:TemplateColumn HeaderText="Employee_id">
        <HeaderTemplate><asp:LinkButton CommandName="Sort" CommandArgument="Employee_id" ID="btnSortEmployee_id" Runat="Server">Employee_id</asp:LinkButton></HeaderTemplate>
        <FooterTemplate><asp:TextBox ID="add_Employee_id" Columns="5" Runat="Server" /></FooterTemplate>
        <ItemTemplate><%# Container.DataItem("Employee_id") %></ItemTemplate>
        <EditItemTemplate><asp:TextBox ID="Employee_id" Columns="5" Text='<%# Container.DataItem("Employee_id") %>' Runat="server" /></EditItemTemplate>
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

      <asp:TemplateColumn HeaderText="Hire_date">
        <HeaderTemplate><asp:LinkButton CommandName="Sort" CommandArgument="Hire_date" ID="btnSortHire_date" Runat="Server">Hire_date</asp:LinkButton></HeaderTemplate>
        <FooterTemplate><asp:TextBox ID="add_Hire_date" Columns="5" Runat="Server" /></FooterTemplate>
        <ItemTemplate><%# Container.DataItem("Hire_date") %></ItemTemplate>
        <EditItemTemplate><asp:TextBox ID="Hire_date" Columns="5" Text='<%# Container.DataItem("Hire_date") %>' Runat="server" /></EditItemTemplate>
      </asp:TemplateColumn>

      <asp:TemplateColumn HeaderText="Job_type">
        <HeaderTemplate><asp:LinkButton CommandName="Sort" CommandArgument="Job_type" ID="btnSortJob_type" Runat="Server">Job_type</asp:LinkButton></HeaderTemplate>
        <FooterTemplate><asp:TextBox ID="add_Job_type" Columns="5" Runat="Server" /></FooterTemplate>
        <ItemTemplate><%# Container.DataItem("Job_type") %></ItemTemplate>
        <EditItemTemplate><asp:TextBox ID="Job_type" Columns="5" Text='<%# Container.DataItem("Job_type") %>' Runat="server" /></EditItemTemplate>
      </asp:TemplateColumn>

      <asp:TemplateColumn HeaderText="Salary">
        <HeaderTemplate><asp:LinkButton CommandName="Sort" CommandArgument="Salary" ID="btnSortSalary" Runat="Server">Salary</asp:LinkButton></HeaderTemplate>
        <FooterTemplate><asp:TextBox ID="add_Salary" Columns="5" Runat="Server" /></FooterTemplate>
        <ItemTemplate><%# Container.DataItem("Salary") %></ItemTemplate>
        <EditItemTemplate><asp:TextBox ID="Salary" Columns="5" Text='<%# Container.DataItem("Salary") %>' Runat="server" /></EditItemTemplate>
      </asp:TemplateColumn>

      <asp:TemplateColumn HeaderText="Commission">
        <HeaderTemplate><asp:LinkButton CommandName="Sort" CommandArgument="Commission" ID="btnSortCommission" Runat="Server">Commission</asp:LinkButton></HeaderTemplate>
        <FooterTemplate><asp:TextBox ID="add_Commission" Columns="5" Runat="Server" /></FooterTemplate>
        <ItemTemplate><%# Container.DataItem("Commission") %></ItemTemplate>
        <EditItemTemplate><asp:TextBox ID="Commission" Columns="5" Text='<%# Container.DataItem("Commission") %>' Runat="server" /></EditItemTemplate>
      </asp:TemplateColumn>

      <asp:TemplateColumn HeaderText="Department_id">
        <HeaderTemplate><asp:LinkButton CommandName="Sort" CommandArgument="Department_id" ID="btnSortDepartment_id" Runat="Server">Department_id</asp:LinkButton></HeaderTemplate>
        <FooterTemplate><asp:TextBox ID="add_Department_id" Columns="5" Runat="Server" /></FooterTemplate>
        <ItemTemplate><%# Container.DataItem("Department_id") %></ItemTemplate>
        <EditItemTemplate><asp:TextBox ID="Department_id" Columns="5" Text='<%# Container.DataItem("Department_id") %>' Runat="server" /></EditItemTemplate>
      </asp:TemplateColumn>

      <asp:TemplateColumn HeaderText="Supervisor_id">
        <HeaderTemplate><asp:LinkButton CommandName="Sort" CommandArgument="Supervisor_id" ID="btnSortSupervisor_id" Runat="Server">Supervisor_id</asp:LinkButton></HeaderTemplate>
        <FooterTemplate><asp:TextBox ID="add_Supervisor_id" Columns="5" Runat="Server" /></FooterTemplate>
        <ItemTemplate><%# Container.DataItem("Supervisor_id") %></ItemTemplate>
        <EditItemTemplate><asp:TextBox ID="Supervisor_id" Columns="5" Text='<%# Container.DataItem("Supervisor_id") %>' Runat="server" /></EditItemTemplate>
      </asp:TemplateColumn>


   </Columns>
</asp:datagrid>
    <br />
<Center><a align="center" class="mis311-hoverbutton" href="maintenance.aspx">BACK</a></center>
</asp:Content>
