Public Class ExamenMateria
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub rendirExamen(sender As Object, e As EventArgs) Handles rendir.Click
        Response.Redirect("DetalleExamen.aspx")
    End Sub
End Class