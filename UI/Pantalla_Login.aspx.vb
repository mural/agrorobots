﻿Imports System.Data.SqlClient
Imports Business
Imports Business.Idiomas
Imports EE

Public Class Principal
    Inherits PaginaGenerica

    Dim loginBusiness As New Business.Login
    Shared User_logueado As String
    Dim mis_Parametros As New List(Of Parameter)
    Dim usuarioEntrante As New Usuario

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) Handles Me.Load
        CargarIdiomaSeleccionado()

        Dim usuario = Session.Item("user")
        If Not usuario Is Nothing Then 'envio a la pagina principal
            FormsAuthentication.RedirectFromLoginPage(username.Text, False)
        Else
            'vienen parametros en la URL ?
            Dim usuarioActivar As String
            usuarioActivar = Request.QueryString("usuarioactivar")
            If Not String.IsNullOrEmpty(usuarioActivar) Then 'activacion de usuario y auto login
                If loginBusiness.activarUsuario(usuarioActivar) Then
                    CType(Master.FindControl("Resultado"), Label).Text = idiomas.GetTranslationById(68) 'Usuario activado, ingrese al sistema.
                Else
                    CType(Master.FindControl("Resultado"), Label).Text = idiomas.GetTranslationById(69) 'Error al activar el usuario.
                End If
            End If
        End If
    End Sub

    Protected Overrides Sub TraducirComponentesDinamicos()

    End Sub

    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As EventArgs) Handles Submit_500.Click
        usuarioEntrante.UserName = username.Text
        usuarioEntrante.Password = password.Text

        Try
            loginBusiness.LogearUsuario(usuarioEntrante)

            Session.Add("user", usuarioEntrante)
            IdiomManager.GetIdiomManager.CargarTraduccionesByUsuario(usuarioEntrante.Idioma)
            FormsAuthentication.RedirectFromLoginPage(usuarioEntrante.Apellido, False)
        Catch no As NoActivoException
            CType(Master.FindControl("Resultado"), Label).Text = idiomas.GetTranslationById(73) 'Usuario no activado, revise su email.
        Catch inte As IntentosLoginException
            'Intentos de Login superados       'recupere su clave
            CType(Master.FindControl("Resultado"), Label).Text = idiomas.GetTranslationById(70) + ", <a href='Cuenta/RecuperarClave.aspx'>" +
                idiomas.GetTranslationById(71) + "</a>"
        Catch ex As Exception
            CType(Master.FindControl("Resultado"), Label).Text = idiomas.GetTranslationById(90048) 'Datos invalidos
            'Datos.Text = ex.Message + " --- " + ex.StackTrace.ToString()
        End Try

    End Sub

End Class