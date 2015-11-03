Imports EE
Imports Business
Imports System.Web.UI.DataVisualization.Charting

Public Class Satisfaccion
    Inherits PaginaAutorizada

    Dim fichaBaseBusiness As New FichaEncuestaBase_Business
    Dim fichaBusiness As New FichaEncuesta_Business
    Dim fichaEncuestaRespuestaBusiness As New FichaEncuestaRespuesta_Business

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        CargarSatisfaccion()
        Resultado.Visible = False 'lo uso para copiarlo
    End Sub

    Protected Overrides Sub TraducirComponentesDinamicos()
    End Sub

    Private Sub CargarSatisfaccion()
        encuestasPanel.Controls.Clear()

        ''ANUALES
        Dim descripcionInicio = New LiteralControl()
        descripcionInicio.Text = ""
        descripcionInicio.Text += "<div class='w3-card-4'>"
        descripcionInicio.Text += "<header class='w3-container w3-blue'>"
        descripcionInicio.Text += "Anuales"
        descripcionInicio.Text += "</header>"
        descripcionInicio.Text += "<div class='w3-container'>"
        encuestasPanel.Controls.Add(descripcionInicio)

        'muestro resultados
        Dim resultados As New List(Of SatisfaccionResultado)
        resultados.Add(New SatisfaccionResultado With {.Periodo = "2015"})

        For Each fichaBase In fichaBaseBusiness.ListarFichas
            For Each fichaPregunta In fichaEncuestaRespuestaBusiness.Listar
                Dim respuesta As Integer
                If Integer.TryParse(fichaPregunta.Respuesta, respuesta) Then
                    Try
                        Dim fichaCompleta = fichaBusiness.Obtener(fichaPregunta.IDFichaEncuesta)
                        resultados(Date.Now.Year - fichaCompleta.Fecha.Year).Votos += 1
                        resultados(Date.Now.Year - fichaCompleta.Fecha.Year).Acumulado += respuesta
                    Catch ex As Exception
                    End Try
                End If
            Next
        Next

        For Each fichaResultado In resultados
            fichaResultado.Promedio = fichaResultado.Acumulado / fichaResultado.Votos
        Next

        Dim nuevoResultado As New Chart
        nuevoResultado.Width = 550
        nuevoResultado.Series.Add("Categories")
        nuevoResultado.ChartAreas.Add("MainChartArea")

        nuevoResultado.Series("Categories").XValueMember = "Periodo"
        nuevoResultado.Series("Categories").YValueMembers = "Promedio"
        nuevoResultado.DataSource = resultados
        nuevoResultado.DataBind()
        encuestasPanel.Controls.Add(nuevoResultado)

        Dim descripcionCierre = New LiteralControl()
        descripcionCierre.Text = ""
        descripcionCierre.Text += "</div>"
        descripcionCierre.Text += "</div>"
        descripcionCierre.Text += "<br/><hr/><br/>"
        encuestasPanel.Controls.Add(descripcionCierre)


        ''MENSUALES
        descripcionInicio = New LiteralControl()
        descripcionInicio.Text = ""
        descripcionInicio.Text += "<div class='w3-card-4'>"
        descripcionInicio.Text += "<header class='w3-container w3-blue'>"
        descripcionInicio.Text += "Mensuales"
        descripcionInicio.Text += "</header>"
        descripcionInicio.Text += "<div class='w3-container'>"
        encuestasPanel.Controls.Add(descripcionInicio)

        'muestro resultados
        resultados = New List(Of SatisfaccionResultado)
        resultados.Add(New SatisfaccionResultado With {.Periodo = "Enero"})
        resultados.Add(New SatisfaccionResultado With {.Periodo = "Febrero"})
        resultados.Add(New SatisfaccionResultado With {.Periodo = "Marzo"})
        resultados.Add(New SatisfaccionResultado With {.Periodo = "Abril"})
        resultados.Add(New SatisfaccionResultado With {.Periodo = "Mayo"})
        resultados.Add(New SatisfaccionResultado With {.Periodo = "Junio"})
        resultados.Add(New SatisfaccionResultado With {.Periodo = "Julio"})
        resultados.Add(New SatisfaccionResultado With {.Periodo = "Agosto"})
        resultados.Add(New SatisfaccionResultado With {.Periodo = "Septiembre"})
        resultados.Add(New SatisfaccionResultado With {.Periodo = "Octubre"})
        resultados.Add(New SatisfaccionResultado With {.Periodo = "Noviembre"})
        resultados.Add(New SatisfaccionResultado With {.Periodo = "Diciembre"})

        For Each fichaBase In fichaBaseBusiness.ListarFichas
            For Each fichaPregunta In fichaEncuestaRespuestaBusiness.Listar
                Dim respuesta As Integer
                If Integer.TryParse(fichaPregunta.Respuesta, respuesta) Then
                    Try
                        Dim fichaCompleta = fichaBusiness.Obtener(fichaPregunta.IDFichaEncuesta)
                        resultados(fichaCompleta.Fecha.Month - 1).Votos += 1
                        resultados(fichaCompleta.Fecha.Month - 1).Acumulado += respuesta
                    Catch ex As Exception
                    End Try
                End If
            Next
        Next

        For Each fichaResultado In resultados
            fichaResultado.Promedio = fichaResultado.Acumulado / fichaResultado.Votos
        Next

        nuevoResultado = New Chart
        nuevoResultado.Width = 550
        nuevoResultado.Series.Add("Categories")
        nuevoResultado.ChartAreas.Add("MainChartArea")

        nuevoResultado.Series("Categories").XValueMember = "Periodo"
        nuevoResultado.Series("Categories").YValueMembers = "Promedio"
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