Imports EE
Imports Business
Imports System.Web.UI.DataVisualization.Charting

Public Class GananciasComparativas
    Inherits PaginaAutorizada

    Dim comprobanteBusiness As New Comprobante_Business

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not (Page.IsPostBack) Then
            CargarCombos()
        End If

        CargarGanancias()
        Resultado.Visible = False 'lo uso para copiarlo
    End Sub

    Protected Overrides Sub TraducirComponentesDinamicos()
    End Sub

    Private Sub CargarCombos()
        comboAno1.Items.Add(New ListItem("2015", "2015"))
        'comboAno1.Items.Add(New ListItem("2014", "2014"))

        comboAno2.Items.Add(New ListItem("2015", "2015"))
        'comboAno2.Items.Add(New ListItem("2014", "2014"))

        comboMes1.Items.Add(New ListItem("Enero", "1"))
        comboMes1.Items.Add(New ListItem("Febrero", "2"))
        comboMes1.Items.Add(New ListItem("Marzo", "3"))
        comboMes1.Items.Add(New ListItem("Abril", "4"))
        comboMes1.Items.Add(New ListItem("Mayo", "5"))
        comboMes1.Items.Add(New ListItem("Junio", "6"))
        comboMes1.Items.Add(New ListItem("Julio", "7"))
        comboMes1.Items.Add(New ListItem("Agosto", "8"))
        comboMes1.Items.Add(New ListItem("Septiembre", "9"))
        comboMes1.Items.Add(New ListItem("Octubre", "10"))
        comboMes1.Items.Add(New ListItem("Noviembre", "11"))
        comboMes1.Items.Add(New ListItem("Diciembre", "12"))

        comboMes2.Items.Add(New ListItem("Enero", "1"))
        comboMes2.Items.Add(New ListItem("Febrero", "2"))
        comboMes2.Items.Add(New ListItem("Marzo", "3"))
        comboMes2.Items.Add(New ListItem("Abril", "4"))
        comboMes2.Items.Add(New ListItem("Mayo", "5"))
        comboMes2.Items.Add(New ListItem("Junio", "6"))
        comboMes2.Items.Add(New ListItem("Julio", "7"))
        comboMes2.Items.Add(New ListItem("Agosto", "8"))
        comboMes2.Items.Add(New ListItem("Septiembre", "9"))
        comboMes2.Items.Add(New ListItem("Octubre", "10"))
        comboMes2.Items.Add(New ListItem("Noviembre", "11"))
        comboMes2.Items.Add(New ListItem("Diciembre", "12"))

        comboMes1.SelectedValue = "9"
        comboMes2.SelectedValue = "10"
    End Sub

    Private Sub CargarGanancias()
        encuestasPanel.Controls.Clear()

        ''MENSUALES
        Dim descripcionInicio = New LiteralControl()
        descripcionInicio.Text = ""
        descripcionInicio.Text += "<div class='w3-card-4'>"
        descripcionInicio.Text += "<header class='w3-container w3-blue'>"
        descripcionInicio.Text += "Mensuales"
        descripcionInicio.Text += "</header>"
        descripcionInicio.Text += "<div class='w3-container'>"
        encuestasPanel.Controls.Add(descripcionInicio)

        'muestro resultados
        Dim resultados As New List(Of GananciasResultado)
        resultados.Add(New GananciasResultado With {.Periodo = comboMes1.SelectedItem.Text})
        resultados.Add(New GananciasResultado With {.Periodo = comboMes2.SelectedItem.Text})

        For Each comprobante In comprobanteBusiness.Listar
            If comprobante.FechaEmision.Month = comboMes1.SelectedValue Then
                resultados(0).Monto += comprobante.Subtotal
            End If
            If comprobante.FechaEmision.Month = comboMes2.SelectedValue Then
                resultados(1).Monto += comprobante.Subtotal
            End If
        Next

        Dim nuevoResultado As New Chart
        nuevoResultado.Width = 550
        nuevoResultado.Series.Add("Categories")
        nuevoResultado.ChartAreas.Add("MainChartArea")

        nuevoResultado.Series("Categories").XValueMember = "Periodo"
        nuevoResultado.Series("Categories").YValueMembers = "Monto"
        nuevoResultado.DataSource = resultados
        nuevoResultado.DataBind()
        encuestasPanel.Controls.Add(nuevoResultado)

        Dim descripcionCierre = New LiteralControl()
        descripcionCierre.Text = ""
        descripcionCierre.Text += "</div>"
        descripcionCierre.Text += "</div>"
        descripcionCierre.Text += "<br/><hr/><br/>"
        encuestasPanel.Controls.Add(descripcionCierre)

    End Sub

    Protected Sub comparar_51_Click(sender As Object, e As EventArgs) Handles comparar_51.Click
        CargarGanancias()
    End Sub
End Class