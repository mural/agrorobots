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
            Dim valida = True
            If Not comboTipos.SelectedValue = -1 And Not comboTipos.SelectedValue = novedad.IDCategoriaTema Then
                valida = False
            End If
            If Not Application("filtroNovedadesFin") = Nothing And novedad.Fecha > Application("filtroNovedadesFin") Then
                valida = False
            End If
            If Not Application("filtroNovedadesInicio") = Nothing And novedad.Fecha < Application("filtroNovedadesInicio") Then
                valida = False
            End If
            If valida Then
                contenidoNovedades.Text += "<div class='w3-card-4'>"
                contenidoNovedades.Text += "<header class='w3-container w3-blue'>"
                contenidoNovedades.Text += categoriaTemaBusiness.Obtener(novedad.IDCategoriaTema).Nombre
                contenidoNovedades.Text += " - ("
                contenidoNovedades.Text += novedad.Fecha
                contenidoNovedades.Text += ")"
                contenidoNovedades.Text += "</header>"
                contenidoNovedades.Text += "<div class='w3-container'>"
                If Not novedad.Foto Is Nothing Then
                    contenidoNovedades.Text += "<img class='imagenMediana imagenMasSeparada fl_left w3-circle' src='"
                    contenidoNovedades.Text += ObtenerImagen(novedad.Foto)
                    contenidoNovedades.Text += "'/>"
                End If
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

    Protected Sub filtrarFechas_Click(sender As Object, e As EventArgs) Handles filtrarFechas.Click
        Try
            Dim FechaInicio = Date.ParseExact(txtFechaInicio.Value, "MM/dd/yyyy", Nothing)
            Application("filtroNovedadesInicio") = FechaInicio
        Catch ex As Exception
            Application("filtroNovedadesInicio") = Nothing
        End Try
        Try
            Dim FechaFin = Date.ParseExact(txtFechaFin.Value, "MM/dd/yyyy", Nothing)
            Application("filtroNovedadesFin") = FechaFin
        Catch ex As Exception
            Application("filtroNovedadesFin") = Nothing
        End Try

        CargarNovedades()
    End Sub

    Protected Sub limpiar_36_Click(sender As Object, e As EventArgs) Handles limpiar_36.Click
        comboTipos.SelectedValue = -1

        Application("filtroNovedadesInicio") = Nothing
        txtFechaInicio.Value = ""
        Application("filtroNovedadesInicio") = Nothing
        txtFechaFin.Value = ""

        CargarNovedades()
    End Sub
End Class