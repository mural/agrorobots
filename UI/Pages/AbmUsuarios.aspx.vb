Imports EE
Imports Business

Public Class AbmUsuario
    Inherits PaginaGenerica

    Dim usuario_Business As New Usuario_Business
    Dim usuario As Usuario
    Dim familiaSeleccionada As Integer = 0

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        usuario = Session.Item("user")
        If Not (Page.IsPostBack) Then
            CargarUsuarios()
        End If
    End Sub

    Protected Overrides Sub TraducirCustomizado()
        'Dim cfedit As CommandField = DirectCast(GridView1.Columns(3), CommandField)
        'cfedit.SelectText = IdiomManager.GetIdiomManager.GetTranslationById(801)
    End Sub

    Private Sub CargarUsuarios()
        Me.GridView1.DataSource = usuario_Business.ObtenerUsuarios
        Me.GridView1.DataBind()
    End Sub
    
    Protected Sub AddNew(ByVal sender As Object, ByVal e As EventArgs)
        Dim IdiomaID As String = DirectCast(GridView1.FooterRow _
             .FindControl("txtIdiomaID"), TextBox).Text
        Dim Traduccion As String = DirectCast(GridView1.FooterRow _
                     .FindControl("txtTraduccion"), TextBox).Text
        Dim ControlID As String = DirectCast(GridView1.FooterRow _
             .FindControl("txtControl"), TextBox).Text

        Dim nuevoUsuario = New Usuario()
        usuario_Business.Alta(nuevoUsuario)

        GridView1.EditIndex = -1
        CargarUsuarios()
    End Sub

    Protected Sub Edit(ByVal sender As Object, ByVal e As GridViewEditEventArgs)
        GridView1.EditIndex = e.NewEditIndex
        CargarUsuarios()
    End Sub
    Protected Sub CancelEdit(ByVal sender As Object, ByVal e As GridViewCancelEditEventArgs)
        GridView1.EditIndex = -1
        CargarUsuarios()
    End Sub
    Protected Sub Update(ByVal sender As Object, ByVal e As GridViewUpdateEventArgs)
        Dim ID As String = DirectCast(GridView1.Rows(e.RowIndex) _
                                     .FindControl("lblID"), Label).Text
        Dim Traduccion As String = DirectCast(GridView1.Rows(e.RowIndex) _
                                     .FindControl("txtTraduccionName"), TextBox).Text

        Dim modificadoUsuario = New Usuario()
        usuario_Business.Modificacion(modificadoUsuario)

        GridView1.EditIndex = -1
        CargarUsuarios()
    End Sub

    Protected Sub Delete(ByVal sender As Object, ByVal e As EventArgs)
        Dim lnkRemove As LinkButton = DirectCast(sender, LinkButton)

        'idioma_Control_Business.BorrarTraduccion(lnkRemove.CommandArgument)
        Dim borrarUsuario = New Usuario()
        usuario_Business.Modificacion(borrarUsuario)

        GridView1.EditIndex = -1
        CargarUsuarios()
    End Sub

    Protected Sub OnPaging(ByVal sender As Object, ByVal e As GridViewPageEventArgs)
        CargarUsuarios()
        GridView1.PageIndex = e.NewPageIndex
        GridView1.DataBind()
    End Sub

End Class