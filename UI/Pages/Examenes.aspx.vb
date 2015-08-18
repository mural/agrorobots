Imports EE

Public Class Examenes
    Inherits System.Web.UI.Page

    Dim usuario As Usuario

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        usuario = Session.Item("user")
        If usuario.Profesor = True Then
            alumno1.Text = "- Pablo Perez"
            alumno2.Text = "- Manuel Garcia"
        End If

    End Sub

End Class