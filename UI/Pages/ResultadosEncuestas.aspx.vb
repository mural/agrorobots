Imports EE
Imports Business
Imports System.Web.UI.DataVisualization.Charting

Public Class ResultadosEncuestas
    Inherits PaginaAutorizada

    Dim encuestaBaseBusiness As New FichaEncuestaBase_Business
    Dim encuestaBusiness As New FichaEncuesta_Business

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        CargarEncuesta()
        Resultado.Visible = False 'lo uso para copiarlo
    End Sub

    Protected Overrides Sub TraducirComponentesDinamicos()
    End Sub

    Private Sub CargarEncuesta()
        encuestasPanel.Controls.Clear()

        For Each encuestaBase In encuestaBaseBusiness.ListarEncuestas

            Dim descripcionInicio = New LiteralControl()
            descripcionInicio.Text = ""
            descripcionInicio.Text += "<div class='w3-card-4'>"
            descripcionInicio.Text += "<header class='w3-container w3-blue'>"
            descripcionInicio.Text += encuestaBase.Descripcion
            descripcionInicio.Text += "</header>"
            descripcionInicio.Text += "<div class='w3-container'>"
            encuestasPanel.Controls.Add(descripcionInicio)

            'muestro resultados

            Dim resultados As New List(Of FichaEncuestaResultado)
            For Each opcion In encuestaBase.Preguntas
                resultados.Add(New FichaEncuestaResultado With {.Opcion = opcion.Pregunta})
            Next
            For Each encuesta In encuestaBusiness.Listar
                For Each encuestaResultado In resultados
                    If encuesta.RespuestaUnica = encuestaResultado.Opcion Then
                        encuestaResultado.Votos += 1
                    End If
                Next
            Next

            Dim nuevoResultado As New Chart
            nuevoResultado.Series.Add("Categories")
            nuevoResultado.ChartAreas.Add("MainChartArea")

            nuevoResultado.Series("Categories").XValueMember = "Opcion"
            nuevoResultado.Series("Categories").YValueMembers = "Votos"
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