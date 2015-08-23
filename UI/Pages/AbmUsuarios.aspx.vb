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
        ''Dim apellido As CommandField = DirectCast(GridView1.Columns(4), CommandField)
        ''apellido.SelectText = IdiomManager.GetIdiomManager.GetTranslationById(21)
    End Sub

    Private Sub CargarUsuarios()
        Me.GridView1.DataSource = usuario_Business.ObtenerUsuarios
        Me.GridView1.DataBind()
    End Sub

    Private Sub Vaciar()
        txtApellido.Text = ""
        txtNombre.Text = ""
        txtUsername.Text = ""
        txtPassword.Text = ""
        txtConfirmPassword.Text = ""
    End Sub
    
    Protected Sub AddNew(ByVal sender As Object, ByVal e As EventArgs) Handles btnCrear_32.Click
        Dim Apellido = txtApellido.Text
        Dim Nombre = txtNombre.Text
        Dim UserName = txtUsername.Text
        Dim Password = txtPassword.Text
        Dim ConfirmPassword = txtConfirmPassword.Text

        If Not vldUser.IsValid Then
            vldUser.Text = String.Format(IdiomManager.GetIdiomManager.GetTranslationById(90016),
                                         IdiomManager.GetIdiomManager.GetTranslationById(23))
        End If
        If Not vldPassword.IsValid Then
            vldPassword.Text = IdiomManager.GetIdiomManager.GetTranslationById(90030)
        End If

        If Page.IsValid Then
            Try
                Dim nuevoUsuario = New Usuario(True, True, Apellido, 0, Nothing, 0, Nombre, Password, UserName)
                usuario_Business.Alta(nuevoUsuario)

                Vaciar()
            Catch ax As ArgumentException
                If ax.Message.Equals("90028") Then
                    lblMensajes.Text = IdiomManager.GetIdiomManager.GetTranslationById(90028)
                End If
            Catch ex As Exception
                lblMensajes.Text = IdiomManager.GetIdiomManager.GetTranslationById(90012)
            End Try
        End If

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

        Dim borrarUsuario = New Usuario()
        borrarUsuario.ID = lnkRemove.CommandArgument
        usuario_Business.Baja(borrarUsuario)

        GridView1.EditIndex = -1
        CargarUsuarios()
    End Sub

    Protected Sub OnPaging(ByVal sender As Object, ByVal e As GridViewPageEventArgs)
        CargarUsuarios()
        GridView1.PageIndex = e.NewPageIndex
        GridView1.DataBind()
    End Sub

    Protected Sub GridView1_SelectedIndexChanging(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewSelectEventArgs) Handles GridView1.SelectedIndexChanging
        Dim usuarioSeleccionado = usuario_Business.ObtenerUsuarios.ElementAt(e.NewSelectedIndex)
        Me.txtApellido.Text = usuarioSeleccionado.Apellido
    End Sub
End Class