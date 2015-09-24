Imports EE

Public MustInherit Class PaginaAutorizada
    Inherits PaginaGenerica

    Protected Sub ValidacionPermisos(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'hay sesion?
        If usuario Is Nothing Then
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
        For Each paginaPermitida As String In PaginasPermitidas.GetInstance.GetPaginasPermitidas
            If paginaPermitida.Equals(Request.Url.Segments(2)) Then
                valido = True
                Exit For
            End If
        Next
        If Not valido Then
            Response.Redirect("SinPermisos.aspx")
        End If
    End Sub

End Class
