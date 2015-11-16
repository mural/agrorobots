Imports EE
Imports Business
Imports System.Web.UI.DataVisualization.Charting

Public Class Ganancias
    Inherits PaginaAutorizada

    Dim comprobanteBusiness As New Comprobante_Business

    Dim ElementoAcademico_Business As New ElementoAcademico_Business
    Dim Usuario_Business As New Usuario_Business

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        CargarGanancias()
        Resultado.Visible = False 'lo uso para copiarlo
    End Sub

    Protected Overrides Sub TraducirComponentesDinamicos()
    End Sub

    Private Sub CargarGanancias()
        encuestasPanel.Controls.Clear()

        ''GENERALES
        Dim descripcionInicio = New LiteralControl()
        descripcionInicio.Text = ""
        descripcionInicio.Text += "<div class='w3-card-4'>"
        descripcionInicio.Text += "<header class='w3-container w3-blue'>"
        descripcionInicio.Text += "Generales"
        descripcionInicio.Text += "</header>"
        descripcionInicio.Text += "<div class='w3-container'>"
        encuestasPanel.Controls.Add(descripcionInicio)

        'muestro resultados
        Dim resultadosG As New List(Of GeneralesResultado)
        resultadosG.Add(New GeneralesResultado With {.Concepto = "Cursos", .Valor = ElementoAcademico_Business.Listar.Count})
        resultadosG.Add(New GeneralesResultado With {.Concepto = "Profesores", .Valor = Usuario_Business.ObtenerProfesores.Count})
        resultadosG.Add(New GeneralesResultado With {.Concepto = "Alumnos", .Valor = Usuario_Business.ObtenerAlumnos.Count})

        Dim nuevoResultado As New Chart
        nuevoResultado.Width = 550
        nuevoResultado.Series.Add("Categories")
        nuevoResultado.ChartAreas.Add("MainChartArea")

        nuevoResultado.Series("Categories").XValueMember = "Concepto"
        nuevoResultado.Series("Categories").YValueMembers = "Valor"
        nuevoResultado.DataSource = resultadosG
        nuevoResultado.DataBind()
        encuestasPanel.Controls.Add(nuevoResultado)

        Dim descripcionCierre = New LiteralControl()
        descripcionCierre.Text = ""
        descripcionCierre.Text += "</div>"
        descripcionCierre.Text += "</div>"
        descripcionCierre.Text += "<br/><hr/><br/>"
        encuestasPanel.Controls.Add(descripcionCierre)


        ''ANUALES
        descripcionInicio = New LiteralControl()
        descripcionInicio.Text = ""
        descripcionInicio.Text += "<div class='w3-card-4'>"
        descripcionInicio.Text += "<header class='w3-container w3-blue'>"
        descripcionInicio.Text += "Anuales"
        descripcionInicio.Text += "</header>"
        descripcionInicio.Text += "<div class='w3-container'>"
        encuestasPanel.Controls.Add(descripcionInicio)

        'muestro resultados
        Dim resultados As New List(Of GananciasResultado)
        'For Each opcion In comprobanteBusiness.Listar
        resultados.Add(New GananciasResultado With {.Periodo = "2015"})
        'Next
        For Each comprobante In comprobanteBusiness.Listar
            For Each gananciasResultado In resultados
                gananciasResultado.Monto += comprobante.Subtotal
            Next
        Next

        nuevoResultado = New Chart
        nuevoResultado.Width = 550
        nuevoResultado.Series.Add("Categories")
        nuevoResultado.ChartAreas.Add("MainChartArea")

        nuevoResultado.Series("Categories").XValueMember = "Periodo"
        nuevoResultado.Series("Categories").YValueMembers = "Monto"
        nuevoResultado.DataSource = resultados
        nuevoResultado.DataBind()
        encuestasPanel.Controls.Add(nuevoResultado)

        descripcionCierre = New LiteralControl()
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
        resultados = New List(Of GananciasResultado)
        resultados.Add(New GananciasResultado With {.Periodo = "Enero"})
        resultados.Add(New GananciasResultado With {.Periodo = "Febrero"})
        resultados.Add(New GananciasResultado With {.Periodo = "Marzo"})
        resultados.Add(New GananciasResultado With {.Periodo = "Abril"})
        resultados.Add(New GananciasResultado With {.Periodo = "Mayo"})
        resultados.Add(New GananciasResultado With {.Periodo = "Junio"})
        resultados.Add(New GananciasResultado With {.Periodo = "Julio"})
        resultados.Add(New GananciasResultado With {.Periodo = "Agosto"})
        resultados.Add(New GananciasResultado With {.Periodo = "Septiembre"})
        resultados.Add(New GananciasResultado With {.Periodo = "Octubre"})
        resultados.Add(New GananciasResultado With {.Periodo = "Noviembre"})
        resultados.Add(New GananciasResultado With {.Periodo = "Diciembre"})

        For Each comprobante In comprobanteBusiness.Listar
            resultados(comprobante.FechaEmision.Month - 1).Monto += comprobante.Subtotal
        Next

        nuevoResultado = New Chart
        nuevoResultado.Width = 550
        nuevoResultado.Series.Add("Categories")
        nuevoResultado.ChartAreas.Add("MainChartArea")

        nuevoResultado.Series("Categories").XValueMember = "Periodo"
        nuevoResultado.Series("Categories").YValueMembers = "Monto"
        nuevoResultado.DataSource = resultados
        nuevoResultado.DataBind()
        encuestasPanel.Controls.Add(nuevoResultado)

        descripcionCierre = New LiteralControl()
        descripcionCierre.Text = ""
        descripcionCierre.Text += "</div>"
        descripcionCierre.Text += "</div>"
        descripcionCierre.Text += "<br/><hr/><br/>"
        encuestasPanel.Controls.Add(descripcionCierre)


        ''SEMANALES
        descripcionInicio = New LiteralControl()
        descripcionInicio.Text = ""
        descripcionInicio.Text += "<div class='w3-card-4'>"
        descripcionInicio.Text += "<header class='w3-container w3-blue'>"
        descripcionInicio.Text += "Semanales"
        descripcionInicio.Text += "</header>"
        descripcionInicio.Text += "<div class='w3-container'>"
        encuestasPanel.Controls.Add(descripcionInicio)

        'muestro resultados
        resultados = New List(Of GananciasResultado)
        resultados.Add(New GananciasResultado With {.Periodo = "Semana 1"})
        resultados.Add(New GananciasResultado With {.Periodo = "Semana 2"})
        resultados.Add(New GananciasResultado With {.Periodo = "Semana 3"})
        resultados.Add(New GananciasResultado With {.Periodo = "Semana 4"})
        resultados.Add(New GananciasResultado With {.Periodo = "Semana 5"})
        resultados.Add(New GananciasResultado With {.Periodo = "Semana 6"})

        For Each comprobante In comprobanteBusiness.Listar
            Dim diaDelAno = comprobante.FechaEmision.DayOfYear
            Dim difEnDiasConHoy = Date.Now.DayOfYear - diaDelAno
            Dim semana As Integer = 0
            Select Case difEnDiasConHoy
                Case 0 To 7
                    semana = 1
                Case 8 To 14
                    semana = 2
                Case 15 To 21
                    semana = 3
                Case 22 To 27
                    semana = 4
                Case 28 To 34
                    semana = 5
                Case 35 To 41
                    semana = 6
            End Select
            If semana > 0 Then
                resultados(semana).Monto += comprobante.Subtotal
            End If
        Next

        nuevoResultado = New Chart
        nuevoResultado.Width = 550
        nuevoResultado.Series.Add("Categories")
        nuevoResultado.ChartAreas.Add("MainChartArea")

        nuevoResultado.Series("Categories").XValueMember = "Periodo"
        nuevoResultado.Series("Categories").YValueMembers = "Monto"
        nuevoResultado.DataSource = resultados
        nuevoResultado.DataBind()
        encuestasPanel.Controls.Add(nuevoResultado)

        descripcionCierre = New LiteralControl()
        descripcionCierre.Text = ""
        descripcionCierre.Text += "</div>"
        descripcionCierre.Text += "</div>"
        descripcionCierre.Text += "<br/><hr/><br/>"
        encuestasPanel.Controls.Add(descripcionCierre)


        ''DIARIAS
        descripcionInicio = New LiteralControl()
        descripcionInicio.Text = ""
        descripcionInicio.Text += "<div class='w3-card-4'>"
        descripcionInicio.Text += "<header class='w3-container w3-blue'>"
        descripcionInicio.Text += "Diarias"
        descripcionInicio.Text += "</header>"
        descripcionInicio.Text += "<div class='w3-container'>"
        encuestasPanel.Controls.Add(descripcionInicio)

        'muestro resultados
        resultados = New List(Of GananciasResultado)
        'resultados.Add(New GananciasResultado With {.Periodo = "Dia 1"})
        For index = 1 To 7
            resultados.Add(New GananciasResultado With {.Periodo = Date.Now.AddDays(-index).DayOfWeek.ToString + CStr(Date.Now.AddDays(-index).Day)})
        Next


        For Each comprobante In comprobanteBusiness.Listar
            Dim diaDelAno = comprobante.FechaEmision.DayOfYear
            Dim difEnDiasConHoy = Date.Now.DayOfYear - diaDelAno
            Dim dia As Integer = 0
            Select Case difEnDiasConHoy
                Case 0
                    dia = 1
                Case 1
                    dia = 2
                Case 2
                    dia = 3
                Case 3
                    dia = 4
                Case 4
                    dia = 5
                Case 5
                    dia = 6
                Case 6
                    dia = 7
            End Select
            If dia > 0 And dia < 7 Then
                resultados(dia).Monto += comprobante.Subtotal
            End If
        Next

        nuevoResultado = New Chart
        nuevoResultado.Width = 550
        nuevoResultado.Series.Add("Categories")
        nuevoResultado.ChartAreas.Add("MainChartArea")

        nuevoResultado.Series("Categories").XValueMember = "Periodo"
        nuevoResultado.Series("Categories").YValueMembers = "Monto"
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