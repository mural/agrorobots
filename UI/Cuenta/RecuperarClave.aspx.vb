﻿Imports EE

Public Class RecuperarClave
    Inherits PaginaGenerica

    Dim loginBusiness As New Business.Login

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        idiomas.CargarTraduccionesByUsuario(New Idioma(1, "Español"))
    End Sub

    Protected Overrides Sub TraducirComponentesDinamicos()

    End Sub

    Protected Sub btnRecuperar_490_Click(sender As Object, e As EventArgs) Handles btnRecuperar_490.Click
        Dim nuevaClave = loginBusiness.recuperarClave(usuarioRecuperar.Text, emailRecuperar.Text)
        If Not String.IsNullOrEmpty(nuevaClave) Then
            If emailClave(nuevaClave) Then
                CType(Master.FindControl("Resultado"), Label).Text = idiomas.GetTranslationById(64) 'Email enviado, verifique su casilla
            Else
                CType(Master.FindControl("Resultado"), Label).Text = idiomas.GetTranslationById(65) 'Error de envio de email.
            End If
        Else
            CType(Master.FindControl("Resultado"), Label).Text = idiomas.GetTranslationById(90047) 'Error, no coinciden los datos con nuestros registros."
        End If
    End Sub

    Protected Function emailClave(ByVal claveNueva As String) As Boolean
        Dim asunto = idiomas.GetTranslationById(66) 'Recuperacion de clave de Agrorobots E-Learning
        'Se creo una nueva clave, ingrese al sistema y cambiela por una que recuerde. Su nueva clave es:
        Dim cuerpo = idiomas.GetTranslationById(67) + " " + claveNueva

        Return EmailManager.EnviarEmail(Server, emailRecuperar.Text, asunto, cuerpo)
    End Function
End Class