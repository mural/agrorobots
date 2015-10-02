Imports Business

Public Class Contacto
    Inherits PaginaGenerica

    Dim mensajes_Business As New Mensaje_Business

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Overrides Sub TraducirComponentesDinamicos()

    End Sub

    Protected Sub btnEnviar_135_Click(sender As Object, e As EventArgs) Handles btnEnviar_135.Click
        If Page.IsValid Then
            Try
                mensajes_Business.EnviarMensajeAAdmin(0, email.Text, txtMensaje_701.Text)

                lblMensajes.Text = idiomas.GetTranslationById(709) 'Se envió el mensaje.
                txtMensaje_701.Text = ""
            Catch ex As Exception
                lblMensajes.Text = idiomas.GetTranslationById(90045) 'No se pudo procesar la solicitud.
            End Try
        End If
    End Sub
End Class