Imports Business

Public Class Novedades
    Inherits PaginaGenerica

    Dim novedadesBusiness As New Novedades_Business
    Dim categoriaTemaBusiness As New CategoriaTema_Business

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            CargarTemas()
            CargarNovedades()
        End If
    End Sub

    Protected Overrides Sub TraducirComponentesDinamicos()

    End Sub

    Protected Sub CargarTemas()
            comboTipos.Items.Add(New ListItem("-----", -1))
        For Each categoriaTema In categoriaTemaBusiness.Listar()
            comboTipos.Items.Add(New ListItem(categoriaTema.Nombre, categoriaTema.ID))
        Next
    End Sub

    Protected Sub CargarNovedades()
        contenidoNovedades.Text = ""
        For Each novedad In novedadesBusiness.Listar()
            If comboTipos.SelectedValue = -1 Or comboTipos.SelectedValue = novedad.IDCategoriaTema Then
                contenidoNovedades.Text += "<div class='w3-card-4'>"
                contenidoNovedades.Text += "<header class='w3-container w3-blue'>"
                contenidoNovedades.Text += novedad.Fecha
                contenidoNovedades.Text += "</header>"
                contenidoNovedades.Text += "<div class='w3-container'>"
                contenidoNovedades.Text += novedad.Texto
                contenidoNovedades.Text += "</div>"
                contenidoNovedades.Text += "</div>"
                contenidoNovedades.Text += "<br/><hr/><br/>"
            End If
        Next
    End Sub

    Protected Sub comboTipos_SelectedIndexChanged(sender As Object, e As EventArgs) Handles comboTipos.SelectedIndexChanged
        CargarNovedades()
    End Sub
End Class