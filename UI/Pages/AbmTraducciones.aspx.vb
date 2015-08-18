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

    Protected Sub AddNew(ByVal sender As Object, ByVal e As EventArgs)
        Dim IdiomaID As String = DirectCast(GridView1.FooterRow _
             .FindControl("txtIdiomaID"), TextBox).Text
        Dim Traduccion As String = DirectCast(GridView1.FooterRow _
                     .FindControl("txtTraduccion"), TextBox).Text
        Dim ControlID As String = DirectCast(GridView1.FooterRow _
             .FindControl("txtControl"), TextBox).Text

        idioma_Control_Business.CrearTraduccion(IdiomaID, Traduccion, ControlID)

        GridView1.EditIndex = -1
        CargarIdiomas()
    End Sub

    Protected Sub Edit(ByVal sender As Object, ByVal e As GridViewEditEventArgs)
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

        idioma_Control_Business.UpdateIdiomaById(ID, Traduccion)

        GridView1.EditIndex = -1
        CargarIdiomas()
    End Sub

    Protected Sub Delete(ByVal sender As Object, ByVal e As EventArgs)
        Dim lnkRemove As LinkButton = DirectCast(sender, LinkButton)

        idioma_Control_Business.BorrarTraduccion(lnkRemove.CommandArgument)

        GridView1.EditIndex = -1
        CargarIdiomas()
    End Sub

    Protected Sub OnPaging(ByVal sender As Object, ByVal e As GridViewPageEventArgs)
        CargarIdiomas()
        GridView1.PageIndex = e.NewPageIndex
        GridView1.DataBind()
    End Sub


End Class