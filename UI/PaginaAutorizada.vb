Imports EE
Imports Business

Public MustInherit Class PaginaAutorizada
    Inherits PaginaGenerica

    Dim componentBusiness As New Component_Business

    Protected Sub ValidacionPermisos(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'hay sesion?
        If Not UsuarioLogueado() Then
            FormsAuthentication.SignOut()
            Response.Redirect("/Pantalla_Login.aspx")
        End If

        'validar pagina
        Dim valido As Boolean = False
        For Each patente As Patente In usuario.GetOnlyPatentes()
            If patente.URL.Equals(Request.Url.Segments(2)) Then
                valido = True
                Exit For
            End If
        Next
        For Each patenteGenerica As Patente In componentBusiness.ObtenerPatentes
            If patenteGenerica.ControlID = 0 And patenteGenerica.URL.Equals(Request.Url.Segments(2)) Then
                valido = True
                Exit For
            End If
        Next
        If Not valido Then
            Response.Redirect("/Pages/SinPermisos.aspx")
        End If
    End Sub

End Class
