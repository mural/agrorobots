Imports Business

Public Class Mensajes
    Inherits PaginaGenerica

    Dim mensajes_Business As New Mensaje_Business
    Dim familia_Business As New Familia_Business
    Dim usuario_Business As New Usuario_Business

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If usuario.Admin Then
            lblTitulo.Text = idiomas.GetTranslationById(704)
            comboUsuarios.Visible = True
        Else
            lblTitulo.Text = idiomas.GetTranslationById(703)
            comboUsuarios.Visible = False
        End If
        CargarUsuarios()
    End Sub

    Protected Overrides Sub TraducirComponentesDinamicos()
        CargarMensajes()
        TraducirLoopingControls(Me)
    End Sub

    Private Sub CargarUsuarios()
        'cargar combo usuarios
        For Each usuarioCombo In usuario_Business.ObtenerUsuarios(False)
            If Not usuarioCombo.Admin Then
                comboUsuarios.Items.Add(usuarioCombo.Nombre)
            End If
        Next
        comboUsuarios.SelectedIndex = 0
    End Sub

    Private Sub CargarMensajes()
        If usuario.Admin Then
            Me.GridView1_.DataSource = mensajes_Business.ObtenerMensajesDeAdmin()
        Else
            Me.GridView1_.DataSource = mensajes_Business.ObtenerMensajesPorUsuario(usuario.ID)
        End If

        Me.GridView1_.DataBind()
    End Sub

    Protected Sub btnEnviar_135_Click(sender As Object, e As EventArgs) Handles btnEnviar_135.Click
        Try
            If usuario.Admin Then
                mensajes_Business.EnviarMensajeDeAdmin(comboUsuarios.SelectedValue, txtMensaje_701.Text)
            Else
                mensajes_Business.EnviarMensajeAAdmin(usuario.ID, txtMensaje_701.Text)
            End If
            lblMensajes.Text = idiomas.GetTranslationById(709) 'Se envió el mensaje.
        Catch ex As Exception
            lblMensajes.Text = idiomas.GetTranslationById(90045) 'No se pudo procesar la solicitud.
        End Try
    End Sub

    Protected Sub OnPaging(ByVal sender As Object, ByVal e As GridViewPageEventArgs)
        CargarMensajes()
        GridView1_.PageIndex = e.NewPageIndex
        GridView1_.DataBind()
    End Sub

    Protected Sub Delete(ByVal sender As Object, ByVal e As EventArgs)
        'Dim lnkRemove As LinkButton = DirectCast(sender, LinkButton)

        'Dim borrarUsuario = New Usuario()
        'borrarUsuario.ID = lnkRemove.CommandArgument
        'usuario_Business.Baja(borrarUsuario)

        'Vaciar()

        'GridView1_.EditIndex = -1
        'CargarUsuarios()
    End Sub

    Protected Sub GridView1_SelectedIndexChanging(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewSelectEventArgs) Handles GridView1_.SelectedIndexChanging
        Dim emisorLabel = DirectCast(Me.GridView1_.HeaderRow.FindControl("lblEmisor"), Label)

        Me.comboUsuarios.SelectedValue = emisorLabel.Text
    End Sub
End Class