Imports EE
Imports Business
Imports Business.Idiomas

Public Class AbmUsuario
    Inherits PaginaGenerica

    Public usuario_Business As New Usuario_Business
    Dim usuarioSeleccionado As Usuario
    Dim familiaSeleccionada As Integer = 0

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        usuarioSeleccionado = Session("usuarioSeleccionado")
        If Not (Page.IsPostBack) Then
            CargarUsuarios()
        End If
    End Sub

    Protected Overrides Sub TraducirComponentesDinamicos()
        CargarUsuarios()
        TraducirLoopingControls(Me)
    End Sub

    Private Sub CargarUsuarios()
        Me.GridView1_.DataSource = usuario_Business.ObtenerUsuarios(True)
        Me.GridView1_.DataBind()
    End Sub

    Private Sub Vaciar()
        txtApellido.Text = ""
        txtNombre.Text = ""
        txtUsername.Text = ""
        txtPassword.Text = ""
        txtConfirmPassword.Text = ""
        Session("usuarioSeleccionado") = Nothing
        lblMensajes.Text = ""
        LimpiarValidaciones()
    End Sub

    Private Sub LimpiarValidaciones()
        vldApellido.IsValid = True
        vldNombre.IsValid = True
        vldUser.IsValid = True
        vldPassword.IsValid = True
        vldConfirmPassword.IsValid = True
        vldPasswordMatch.IsValid = True
    End Sub

    Private Sub ValidacionesGenericas()
        If Not vldApellido.IsValid Then
            vldApellido.Text = String.Format(IdiomManager.GetIdiomManager.GetTranslationById(90016),
                                         IdiomManager.GetIdiomManager.GetTranslationById(21))
        End If
        If Not vldNombre.IsValid Then
            vldNombre.Text = String.Format(IdiomManager.GetIdiomManager.GetTranslationById(90016),
                                         IdiomManager.GetIdiomManager.GetTranslationById(22))
        End If
        If Not vldUser.IsValid Then
            vldUser.Text = String.Format(IdiomManager.GetIdiomManager.GetTranslationById(90016),
                                         IdiomManager.GetIdiomManager.GetTranslationById(23))
        End If
    End Sub

    Protected Sub AddNew(ByVal sender As Object, ByVal e As EventArgs) Handles btnCrear_32.Click
        Dim Apellido = txtApellido.Text
        Dim Nombre = txtNombre.Text
        Dim UserName = txtUsername.Text
        Dim Password = txtPassword.Text
        Dim ConfirmPassword = txtConfirmPassword.Text

        lblMensajes.Text = ""
        ValidacionesGenericas()

        If Not vldPassword.IsValid Then
            vldPassword.Text = String.Format(IdiomManager.GetIdiomManager.GetTranslationById(90016),
                                         IdiomManager.GetIdiomManager.GetTranslationById(27))
        End If
        If Not vldConfirmPassword.IsValid Then
            vldConfirmPassword.Text = String.Format(IdiomManager.GetIdiomManager.GetTranslationById(90016),
                                         IdiomManager.GetIdiomManager.GetTranslationById(28))
        End If
        If Not vldPasswordMatch.IsValid Then
            vldPasswordMatch.Text = IdiomManager.GetIdiomManager.GetTranslationById(90030)
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

        GridView1_.EditIndex = -1
        CargarUsuarios()
    End Sub

    Protected Sub Update(ByVal sender As Object, ByVal e As EventArgs) Handles btnActualizar_405.Click
        If Not usuarioSeleccionado Is Nothing Then

            Dim Apellido = txtApellido.Text
            Dim Nombre = txtNombre.Text
            Dim UserName = txtUsername.Text
            Dim Password = txtPassword.Text
            Dim ConfirmPassword = txtConfirmPassword.Text

            lblMensajes.Text = ""
            ValidacionesGenericas()
            vldPassword.IsValid = True
            vldConfirmPassword.IsValid = True
            vldPasswordMatch.IsValid = True

            If Page.IsValid Then
                Try
                    usuarioSeleccionado.Apellido = Apellido
                    usuarioSeleccionado.Nombre = Nombre
                    usuario_Business.Modificacion(usuarioSeleccionado)

                    Vaciar()
                Catch ex As Exception
                    lblMensajes.Text = IdiomManager.GetIdiomManager.GetTranslationById(90012)
                End Try
            End If

            GridView1_.EditIndex = -1
            CargarUsuarios()
        Else
            LimpiarValidaciones()
            lblMensajes.Text = IdiomManager.GetIdiomManager.GetTranslationById(90035)
        End If
    End Sub

    Protected Sub Delete(ByVal sender As Object, ByVal e As EventArgs)
        Dim lnkRemove As LinkButton = DirectCast(sender, LinkButton)

        Dim borrarUsuario = New Usuario()
        borrarUsuario.ID = lnkRemove.CommandArgument
        usuario_Business.Baja(borrarUsuario)

        Vaciar()

        GridView1_.EditIndex = -1
        CargarUsuarios()
    End Sub

    Protected Sub OnPaging(ByVal sender As Object, ByVal e As GridViewPageEventArgs)
        CargarUsuarios()
        GridView1_.PageIndex = e.NewPageIndex
        GridView1_.DataBind()
    End Sub

    Protected Sub GridView1_SelectedIndexChanging(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewSelectEventArgs) Handles GridView1_.SelectedIndexChanging
        Dim pageFactor = GridView1_.PageIndex * GridView1_.PageSize
        Session("usuarioSeleccionado") = usuario_Business.ObtenerUsuarios(False).ElementAt(pageFactor + e.NewSelectedIndex)
        usuarioSeleccionado = Session("usuarioSeleccionado")
        Me.txtApellido.Text = usuarioSeleccionado.Apellido
        Me.txtNombre.Text = usuarioSeleccionado.Nombre
        Me.txtUsername.Text = usuarioSeleccionado.UserName
        Me.cbxActivo.Checked = usuarioSeleccionado.Activo
        Me.cbxAdmin.Checked = usuarioSeleccionado.Admin
        Me.lstbFamilia.SelectedValue = usuarioSeleccionado.GetFamilias(0).Name
        Me.txtPassword.Text = "-"
        Me.txtConfirmPassword.Text = "-"
    End Sub

    Protected Sub btnLimpiar_36_Click(sender As Object, e As EventArgs) Handles btnLimpiar_36.Click
        Vaciar()
    End Sub
End Class