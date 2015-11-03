Imports EE
Imports Business
Imports System.Web.UI.DataVisualization.Charting

Public Class EstadisticasRespuesta
    Inherits PaginaAutorizada

    Dim mensajesBussines As New Mensaje_Business

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        CargarTiempos()
        Resultado.Visible = False 'lo uso para copiarlo
    End Sub

    Protected Overrides Sub TraducirComponentesDinamicos()
    End Sub

    Private Sub CargarTiempos()
        encuestasPanel.Controls.Clear()

        ''MENSUALES
        Dim descripcionInicio = New LiteralControl()
        descripcionInicio.Text = ""
        descripcionInicio.Text += "<div class='w3-card-4'>"
        descripcionInicio.Text += "<header class='w3-container w3-blue'>"
        descripcionInicio.Text += "Mensajes enviados"
        descripcionInicio.Text += "</header>"
        descripcionInicio.Text += "<div class='w3-container'>"
        encuestasPanel.Controls.Add(descripcionInicio)

        'muestro resultados
        Dim resultados As New List(Of TiemposRespuestaResultado)
        resultados.Add(New TiemposRespuestaResultado With {.Origen = "Usuarios"})
        resultados.Add(New TiemposRespuestaResultado With {.Origen = "Empleados"})

        Dim mensajesTotales = mensajesBussines.Listar.Count
        Dim mensajesDeAdmin = mensajesBussines.ObtenerMensajesDeAdmin.Count
        Dim mensajesDeUsuarios = mensajesTotales - mensajesDeAdmin
        resultados(0).Mensajes += mensajesDeUsuarios
        resultados(1).Mensajes += mensajesDeAdmin

        Dim nuevoResultado As New Chart
        nuevoResultado.Width = 550
        nuevoResultado.Series.Add("Categories")
        nuevoResultado.ChartAreas.Add("MainChartArea")

        nuevoResultado.Series("Categories").XValueMember = "Origen"
        nuevoResultado.Series("Categories").YValueMembers = "Mensajes"
        nuevoResultado.DataSource = resultados
        nuevoResultado.DataBind()
        encuestasPanel.Controls.Add(nuevoResultado)

        Dim descripcionCierre = New LiteralControl()
        descripcionCierre.Text = ""
        descripcionCierre.Text += "</div>"
        descripcionCierre.Text += "</div>"
        descripcionCierre.Text += "<br/><hr/><br/>"
        encuestasPanel.Controls.Add(descripcionCierre)


        ''TIEMPO PROMEDIO
        descripcionInicio = New LiteralControl()
        descripcionInicio.Text = ""
        descripcionInicio.Text += "<div class='w3-card-4'>"
        descripcionInicio.Text += "<header class='w3-container w3-blue'>"
        descripcionInicio.Text += "Tiempo promedio de respuesta"
        descripcionInicio.Text += "</header>"
        descripcionInicio.Text += "<div class='w3-container'>"
        encuestasPanel.Controls.Add(descripcionInicio)

        'muestro resultados
        resultados = New List(Of TiemposRespuestaResultado)
        resultados.Add(New TiemposRespuestaResultado With {.Origen = "(min.)"})

        Dim tiempoPromedio = 0
        For Each mensaje In mensajesBussines.ObtenerMensajesDeAdmin
            tiempoPromedio += mensaje.Fecha.Minute
        Next
        resultados(0).TiempoPromedio = tiempoPromedio / mensajesDeAdmin

        nuevoResultado = New Chart
        nuevoResultado.Width = 550
        nuevoResultado.Series.Add("Categories")
        nuevoResultado.ChartAreas.Add("MainChartArea")

        nuevoResultado.Series("Categories").XValueMember = "Origen"
        nuevoResultado.Series("Categories").YValueMembers = "TiempoPromedio"
        nuevoResultado.DataSource = resultados
        nuevoResultado.DataBind()
        encuestasPanel.Controls.Add(nuevoResultado)

        descripcionCierre = New LiteralControl()
        descripcionCierre.Text = ""
        descripcionCierre.Text += "</div>"
        descripcionCierre.Text += "</div>"
        descripcionCierre.Text += "<br/><hr/><br/>"
        encuestasPanel.Controls.Add(descripcionCierre)
    End Sub

End Class