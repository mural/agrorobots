Imports Business

Public Class Novedades
    Inherits PaginaGenerica

    Dim novedadesBusiness As New Novedades_Business

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        For Each novedad In novedadesBusiness.Listar()
            Literal1.Text += "<div class='w3-card-4'>"
            Literal1.Text += "<header class='w3-container w3-blue'>"
            Literal1.Text += novedad.Fecha
            Literal1.Text += "</header>"
            Literal1.Text += "<div class='w3-container'>"
            Literal1.Text += novedad.Texto
            Literal1.Text += "</div>"
            Literal1.Text += "</div>"

            Literal1.Text += "<br/><hr/><br/>"
        Next
    End Sub

    Protected Overrides Sub TraducirComponentesDinamicos()

    End Sub
End Class