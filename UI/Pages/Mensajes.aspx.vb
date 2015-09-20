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
        If Not Page.IsPostBack Then
            CargarUsuarios()
        End If
    End Sub

    Protected Overrides Sub TraducirComponentesDinamicos()
        CargarMensajes()
        TraducirLoopingControls(Me)
    End Sub

    Private Sub CargarUsuarios()
        'cargar combo usuarios
        comboUsuarios.Items.Clear()
        For Each usuarioCombo In usuario_Business.ObtenerUsuarios(False)
            If Not usuarioCombo.Admin Then
                comboUsuarios.Items.Add(New ListItem(usuarioCombo.Nombre, usuarioCombo.ID))
            End If
        Next
    End Sub

    Private Sub CargarMensajes()
        If usuario.Admin Then
            Me.GridView1_.DataSource = mensajes_Business.ObtenerMensajesDeAdmin()
        Else
            Me.GridView1_.DataSource = mensajes_Business.ObtenerMensajesPorUsuario(usuario.ID)
        End If

        Me.GridView1_.DataBind()

        If usuario.Admin Then
            For Each row In Me.GridView1_.Rows
                Dim emisorLabel = DirectCast(row.FindControl("lblEmisor"), Label)
                If emisorLabel.Text.Contains("Administrador") Then
                    DirectCast(row.FindControl("lnkSeleccionar_801"), LinkButton).Visible = False
                End If
            Next
        Else
            Me.GridView1_.Columns(2).Visible = False 'email emisor
            Me.GridView1_.Columns(Me.GridView1_.Columns.Count - 1).Visible = False ' seleccionar
        End If
    End Sub

    Protected Sub btnEnviar_135_Click(sender As Object, e As EventArgs) Handles btnEnviar_135.Click
        If Page.IsValid Then
            Try
                If usuario.Admin Then
                    mensajes_Business.EnviarMensajeDeAdmin(comboUsuarios.SelectedValue, txtMensaje_701.Text)
                Else
                    mensajes_Business.EnviarMensajeAAdmin(usuario.ID, usuario.Email, txtMensaje_701.Text)
                End If
                lblMensajes.Text = idiomas.GetTranslationById(709) 'Se envió el mensaje.
                txtMensaje_701.Text = ""
            Catch ex As Exception
                lblMensajes.Text = idiomas.GetTranslationById(90045) 'No se pudo procesar la solicitud.
            End Try
        End If
    End Sub

    Protected Sub OnPaging(ByVal sender As Object, ByVal e As GridViewPageEventArgs)
        CargarMensajes()
        GridView1_.PageIndex = e.NewPageIndex
        GridView1_.DataBind()
    End Sub

    Protected Sub Delete(ByVal sender As Object, ByVal e As EventArgs)
        Dim lnkRemove As LinkButton = DirectCast(sender, LinkButton)

        mensajes_Business.BorrarMensaje(lnkRemove.CommandArgument)

        GridView1_.EditIndex = -1
        CargarMensajes()
    End Sub

    Protected Sub GridView1_SelectedIndexChanging(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewSelectEventArgs) Handles GridView1_.SelectedIndexChanging
        Dim emisorLabel = DirectCast(Me.GridView1_.Rows.Item(e.NewSelectedIndex).FindControl("lblEmisor"), Label)

        Me.comboUsuarios.ClearSelection()
        Me.comboUsuarios.Items.FindByText(emisorLabel.Text).Selected = True
    End Sub

End Class