Public Class RecuperarClave
    Inherits PaginaGenerica

    Dim loginBusiness As New Business.Login

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Overrides Sub TraducirComponentesDinamicos()

    End Sub

    Protected Sub btnRecuperar_490_Click(sender As Object, e As EventArgs) Handles btnRecuperar_490.Click
        Dim nuevaClave = loginBusiness.recuperarClave(usuarioRecuperar.Text, emailRecuperar.Text)
        If Not String.IsNullOrEmpty(nuevaClave) Then
            Dim asunto = "Recuperacion de clave de Agrorobots E-Learning"
            Dim cuerpo = "Se creo una nueva clave, ingrese al sistema y cambiela por una que recuerde. Su nueva clave es: " + nuevaClave
            If EmailManager.EnviarEmail(Server, emailRecuperar.Text, asunto, cuerpo) Then
                Resultado.Text = "Email enviado, verifique su casilla"
            Else
                Resultado.Text = "Error de envio, use este link ?"
            End If
        Else
            Resultado.Text = "Error, no coinciden los datos."
        End If
    End Sub
End Class