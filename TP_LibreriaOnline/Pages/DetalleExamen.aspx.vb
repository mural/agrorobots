Public Class DetalleExamen
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub finalizarExamen(sender As Object, e As EventArgs) Handles finalizar.Click
        Response.Redirect("ExamenMateria.aspx")
    End Sub
End Class