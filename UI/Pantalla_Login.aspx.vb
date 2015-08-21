Imports System.Data.SqlClient
Imports Business
Imports EE

Public Class Principal
    Inherits System.Web.UI.Page

    Dim loginBusiness As New Business.Login
    Dim usuario As New Usuario
    Dim mailAdmin As String = "<a href=""mailto:admin@agrorobots.com?Subject=Contacto"">administrador</a>"

    Shared User_logueado As String
    Dim mis_Parametros As New List(Of Parameter)

    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As EventArgs) Handles Submit.Click
        usuario.UserName = username.Text
        usuario.Password = password.Text

        Try
            loginBusiness.LogearUsuario(usuario)

            Session.Add("user", usuario)
            IdiomManager.GetIdiomManager.CargarTraduccionesByUsuario(usuario.Idioma)
            FormsAuthentication.RedirectFromLoginPage(username.Text, False)
        Catch inte As IntentosLoginException
            Resultado.Text = "Intentos de Login superados, contacte al " + mailAdmin
        Catch ex As Exception
            Resultado.Text = "Datos invalidos"
            Datos.Text = ex.Message + " --- " + ex.StackTrace.ToString()
        End Try

    End Sub

    Protected Sub OlvidoClave_Click(ByVal sender As Object, ByVal e As EventArgs) Handles OlvidoClave.Click
        Resultado.Text = "Contacte al " + mailAdmin + " por otra clave"
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) Handles Me.Load
        'administrador.
        Dim usuario = Session.Item("user")
        If Not usuario Is Nothing Then
            FormsAuthentication.RedirectFromLoginPage(username.Text, False)
        End If
    End Sub
End Class