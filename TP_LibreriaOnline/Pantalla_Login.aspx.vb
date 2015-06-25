Imports System.Data.SqlClient
Imports Business
Imports DTO

Public Class Principal
    Inherits System.Web.UI.Page

    Dim loginBusiness As New Business.Login
    Dim usuario As New Usuario
    Dim mailAdmin As String = "<a href=""mailto:admin@mesaredonda.com?Subject=Libreria"">admnistrador</a>"

    Shared User_logueado As String
    Dim mis_Parametros As New List(Of Parameter)
    Shared conexion As New SqlConnection("Data Source=.\;Initial Catalog=LPPA_LibreriaOnline;Integrated Security=True")

    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As EventArgs) Handles Submit.Click
        usuario.UserName = TBX_NombreUsuario.Text
        usuario.Password = TBX_Contraseña.Text

        If usuario.UserName.Contains("lumno") Then
            usuario.Alumno = True
        End If
        If usuario.UserName.Contains("prof") Then
            usuario.Profesor = True
        End If
        If usuario.UserName.Contains("empleado") Then
            usuario.EmpleadoAdm = True
        End If
        If usuario.UserName.Contains("director") Then
            usuario.Director = True
        End If
        Try
            'loginBusiness.LogearUsuario(usuario)
            Session.Add("user", usuario)
            FormsAuthentication.RedirectFromLoginPage(TBX_NombreUsuario.Text, False)
        Catch inte As IntentosLoginException
            Resultado.Text = "Intentos de Login superados, contacte al " + mailAdmin
        Catch ex As Exception
            Resultado.Text = "Datos invalidos"
        End Try

    End Sub

    Protected Sub OlvidoClave_Click(ByVal sender As Object, ByVal e As EventArgs) Handles OlvidoClave.Click
        Resultado.Text = "Contacte al " + mailAdmin + " por otra clave"

    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) Handles Me.Load
        'administrador.

    End Sub
End Class