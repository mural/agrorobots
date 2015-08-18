Imports EE
Imports Business

Public Class Bitacora
    Inherits System.Web.UI.Page

    Dim usuario As Usuario

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        usuario = Session.Item("user")
        If usuario.Admin = False Then
            Response.Redirect("Pantalla_Principal.aspx")
        End If

    End Sub

End Class