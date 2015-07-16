Public Class NuevaCarrera
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub revision_Click(sender As Object, e As EventArgs) Handles revision.Click
        Response.Redirect("RevisionCarrera.aspx")
    End Sub
End Class