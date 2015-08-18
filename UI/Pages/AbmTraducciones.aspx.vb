Imports EE

Public Class AbmTraducciones
    Inherits System.Web.UI.Page

    Dim idioma_Control_Business As New Business.Idioma_Control_Business
    Dim usuario As Usuario

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        usuario = Session.Item("user")
        If Not (Page.IsPostBack) Then
            CargarIdiomas()
        End If
    End Sub

    Private Sub CargarIdiomas()
        Me.GridView1.DataSource = idioma_Control_Business.GetIdiomsByID(usuario.Idioma())
        Me.GridView1.DataBind()
    End Sub

    Protected Sub AddNewCustomer(ByVal sender As Object, ByVal e As EventArgs)
        'Dim CustomerID As String = DirectCast(GridView1.FooterRow _
        '             .FindControl("txtCustomerID"), TextBox).Text
        'Dim Name As String = DirectCast(GridView1 _
        '             .FooterRow.FindControl("txtContactName"), TextBox).Text
        'Dim Company As String = DirectCast(GridView1 _
        '             .FooterRow.FindControl("txtCompany"), TextBox).Text
        'Dim con As New SqlConnection(strConnString)
        'Dim cmd As New SqlCommand()
        'cmd.CommandType = CommandType.Text
        'cmd.CommandText = "insert into customers(CustomerID, ContactName, " & _
        '     "CompanyName) values(@CustomerID, @ContactName, @CompanyName);" & _
        '     "select CustomerID,ContactName,CompanyName from customers"
        'cmd.Parameters.Add("@CustomerID", SqlDbType.VarChar).Value = CustomerID
        'cmd.Parameters.Add("@ContactName", SqlDbType.VarChar).Value = Name
        'cmd.Parameters.Add("@CompanyName", SqlDbType.VarChar).Value = Company
        'GridView1.DataSource = GetData(cmd)
        'GridView1.DataBind()
    End Sub

    Protected Sub EditCustomer(ByVal sender As Object, ByVal e As GridViewEditEventArgs)
        GridView1.EditIndex = e.NewEditIndex
        CargarIdiomas()
    End Sub
    Protected Sub CancelEdit(ByVal sender As Object, ByVal e As GridViewCancelEditEventArgs)
        GridView1.EditIndex = -1
        CargarIdiomas()
    End Sub
    Protected Sub Update(ByVal sender As Object, ByVal e As GridViewUpdateEventArgs)
        Dim ID As String = DirectCast(GridView1.Rows(e.RowIndex) _
                                     .FindControl("lblID"), Label).Text
        Dim Traduccion As String = DirectCast(GridView1.Rows(e.RowIndex) _
                                     .FindControl("txtTraduccionName"), TextBox).Text

        'Dim con As New SqlConnection(strConnString)
        'Dim cmd As New SqlCommand()
        'cmd.CommandType = CommandType.Text
        'cmd.CommandText = "update customers set ContactName=@ContactName," _
        '& "CompanyName=@CompanyName where CustomerID=@CustomerID;" _
        '& "select CustomerID,ContactName,CompanyName from customers"
        'cmd.Parameters.Add("@CustomerID", SqlDbType.VarChar).Value = CustomerID
        'cmd.Parameters.Add("@ContactName", SqlDbType.VarChar).Value = Name
        'cmd.Parameters.Add("@CompanyName", SqlDbType.VarChar).Value = Company

        idioma_Control_Business.UpdateIdiomaById(ID, Traduccion)

        GridView1.EditIndex = -1
        CargarIdiomas()
    End Sub

    Protected Sub DeleteCustomer(ByVal sender As Object, ByVal e As EventArgs)
        'Dim lnkRemove As LinkButton = DirectCast(sender, LinkButton)
        'Dim con As New SqlConnection(strConnString)
        'Dim cmd As New SqlCommand()
        'cmd.CommandType = CommandType.Text
        'cmd.CommandText = "delete from customers where " & _
        '"CustomerID=@CustomerID;" & _
        '"select CustomerID,ContactName,CompanyName from customers"
        'cmd.Parameters.Add("@CustomerID", SqlDbType.VarChar).Value _
        '    = lnkRemove.CommandArgument
        'GridView1.DataSource = GetData(cmd)
        'GridView1.DataBind()
    End Sub

    Protected Sub OnPaging(ByVal sender As Object, ByVal e As GridViewPageEventArgs)
        CargarIdiomas()
        GridView1.PageIndex = e.NewPageIndex
        GridView1.DataBind()
    End Sub


End Class