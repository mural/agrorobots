Imports System.Web.SessionState
Imports Business.Idiomas
Imports EE

Public Class Global_asax
    Inherits System.Web.HttpApplication

    Protected idiomas As IdiomManager

    Sub Application_Start(ByVal sender As Object, ByVal e As EventArgs)
        ' Se desencadena al iniciar la aplicación

        idiomas = IdiomManager.GetIdiomManager
        'Cargo el espanol por defecto
        idiomas.CargarTraduccionesByUsuario(New Idioma(1, "-"))
    End Sub

    Sub Session_Start(ByVal sender As Object, ByVal e As EventArgs)
        ' Se desencadena al iniciar la sesión
    End Sub

    Sub Application_BeginRequest(ByVal sender As Object, ByVal e As EventArgs)
        ' Se desencadena al comienzo de cada solicitud
    End Sub

    Sub Application_AuthenticateRequest(ByVal sender As Object, ByVal e As EventArgs)
        ' Se desencadena al intentar autenticar el uso
    End Sub

    Sub Application_Error(ByVal sender As Object, ByVal e As EventArgs)
        ' Se desencadena cuando se produce un error
        Dim serverError As HttpException = Server.GetLastError()
        If Not serverError Is Nothing Then
            Dim errorCode = serverError.GetHttpCode()
            If 404 = errorCode Then
                Server.ClearError()
                Server.Transfer(PaginasConocidas.LOGIN + "?error=404")
            End If
            'If 500 = errorCode Then
            '    Server.ClearError()
            '    Server.Transfer(PaginasConocidas.HOME + "?error=500")
            'End If
        End If

    End Sub

    Sub Session_End(ByVal sender As Object, ByVal e As EventArgs)
        ' Se desencadena cuando finaliza la sesión
    End Sub

    Sub Application_End(ByVal sender As Object, ByVal e As EventArgs)
        ' Se desencadena cuando finaliza la aplicación
    End Sub

End Class