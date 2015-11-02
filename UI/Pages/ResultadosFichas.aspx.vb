Imports EE
Imports Business
Imports System.Web.UI.DataVisualization.Charting

Public Class ResultadosFichas
    Inherits PaginaAutorizada

    Dim fichaBaseBusiness As New FichaEncuestaBase_Business
    Dim fichaBusiness As New FichaEncuesta_Business
    Dim fichaEncuestaRespuestaBusiness As New FichaEncuestaRespuesta_Business

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        CargarEncuesta()
        Resultado.Visible = False 'lo uso para copiarlo
    End Sub

    Protected Overrides Sub TraducirComponentesDinamicos()
    End Sub

    Private Sub CargarEncuesta()
        encuestasPanel.Controls.Clear()

        For Each fichaBase In fichaBaseBusiness.ListarFichas

            Dim descripcionInicio = New LiteralControl()
            descripcionInicio.Text = ""
            descripcionInicio.Text += "<div class='w3-card-4'>"
            descripcionInicio.Text += "<header class='w3-container w3-blue'>"
            descripcionInicio.Text += fichaBase.Descripcion
            descripcionInicio.Text += "</header>"
            descripcionInicio.Text += "<div class='w3-container'>"
            encuestasPanel.Controls.Add(descripcionInicio)

            'muestro resultados

            Dim resultados As New List(Of FichaEncuestaResultado)
            For Each opcion In fichaBase.Preguntas
                resultados.Add(New FichaEncuestaResultado With {.IdPregunta = opcion.ID, .Opcion = opcion.Pregunta})
            Next
            For Each fichaPregunta In fichaEncuestaRespuestaBusiness.Listar
                For Each fichaResultado In resultados
                    If fichaPregunta.IDPregunta = fichaResultado.IdPregunta Then
                        Dim respuesta As Integer
                        If Integer.TryParse(fichaPregunta.Respuesta, respuesta) Then
                            fichaResultado.Votos += 1
                            fichaResultado.Acumulado += respuesta
                        End If
                    End If
                Next
            Next

            For Each fichaResultado In resultados
                fichaResultado.Promedio = fichaResultado.Acumulado / fichaResultado.Votos
            Next

            Dim nuevoResultado As New Chart
            nuevoResultado.Series.Add("Categories")
            nuevoResultado.ChartAreas.Add("MainChartArea")

            nuevoResultado.Series("Categories").XValueMember = "Opcion"
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
        Next
    End Sub
End Class