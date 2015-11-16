Imports EE
Imports Business

Public Class DetalleExamen
    Inherits PaginaAutorizada

    Dim examenBaseBusiness As New ExamenBase_Business
    Dim examenBusiness As New Examen_Business
    Dim usuarioBusiness As New Usuario_Business
    Dim examenBase As ExamenBase
    Dim respuestas As New List(Of TextBox)
    Dim idExamenBase As String

    Dim TargetDT As DateTime
    Dim CountDownFrom As TimeSpan
    Dim rindiendo As Boolean = False
    Dim examenEnCurso As Examen

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        idExamenBase = Request.QueryString("id")
        Dim idExamenBaseInt As Integer
        'If Not Page.IsPostBack Then
        CargarExamen()

        If Not String.IsNullOrEmpty(idExamenBase) And Integer.TryParse(idExamenBase, idExamenBaseInt) And Not examenBaseBusiness.Obtener(idExamenBaseInt) Is Nothing Then
            For Each examen In examenBusiness.ListarPorElementoAcademicoYAlumnoTodos(examenBase.IdElementoAcademico, usuario.ID)
                If examen.Finalizado = False Then 'estoy rindiendo
                    rindiendo = True
                    examenEnCurso = examen
                End If
            Next
            If Not rindiendo Then
                Dim nuevoExamen = New Examen
                nuevoExamen.IdExamenBase = examenBase.ID
                nuevoExamen.Fecha = Date.Now.AddMinutes(10)
                nuevoExamen.IdAlumno = usuario.ID
                nuevoExamen.Nota = -1 'sin corregir
                nuevoExamen.Finalizado = False
                examenBusiness.Crear(nuevoExamen)

                'busco el examen recien creado
                For Each examen In examenBusiness.ListarPorElementoAcademicoYAlumnoTodos(examenBase.IdElementoAcademico, usuario.ID)
                    If examen.Fecha > Date.Now Then
                        rindiendo = True
                        examenEnCurso = examen
                    End If
                Next
            End If

            'inicio countdown
            CountDownFrom = TimeSpan.FromMinutes(examenEnCurso.Fecha.Subtract(Date.Now).TotalMinutes)
            If CountDownFrom.TotalMilliseconds > 0 Then 'me queda tiempo
                TargetDT = DateTime.Now.Add(CountDownFrom)
                Session("tiempoRestante") = TargetDT
                TimerExamen.Interval = 1000
                TimerExamen.Enabled = True
            Else
                Finalizar(sender, e)
                Response.Redirect(PaginasConocidas.MI_CURSADA) 'se acabo el tiempo
            End If
        Else
            Response.Redirect(PaginasConocidas.HOME)
        End If
        'End If
    End Sub

    Protected Overrides Sub TraducirComponentesDinamicos()

    End Sub

    Private Sub CargarExamen()
        examenBase = examenBaseBusiness.Obtener(CInt(idExamenBase)) 'inscripcion

        examenInicio.Controls.Clear()
        examenCierre.Controls.Clear()

        Dim descripcionInicio = New LiteralControl()
        descripcionInicio.Text = ""
        descripcionInicio.Text += "<div class='w3-card-4'>"
        descripcionInicio.Text += "<header class='w3-container w3-blue'>"
        descripcionInicio.Text += examenBase.Detalle
        descripcionInicio.Text += "</header>"
        descripcionInicio.Text += "<div class='w3-container'>"
        examenInicio.Controls.Add(descripcionInicio)

        For Each pregunta In examenBase.Preguntas
            examenCierre.Controls.Add(New LiteralControl(" " + pregunta.Pregunta + "<br/>"))
            Dim respuesta As New TextBox
            respuesta.ID = pregunta.ID
            respuesta.Rows = 2
            respuesta.MaxLength = 100
            examenCierre.Controls.Add(respuesta)
            respuestas.Add(respuesta)
            examenCierre.Controls.Add(New LiteralControl("<br/><br/>"))
        Next
        Dim submit As New Button()
        submit.Text = idiomas.GetTranslationById(135) 'enviar
        submit.CssClass = "w3-btn w3-khaki"
        AddHandler submit.Click, AddressOf Me.Finalizar
        examenCierre.Controls.Add(submit)

        Dim descripcionCierre = New LiteralControl()
        descripcionCierre.Text = ""
        descripcionCierre.Text += "</div>"
        descripcionCierre.Text += "</div>"
        descripcionCierre.Text += "<br/><hr/><br/>"
        examenCierre.Controls.Add(descripcionCierre)
    End Sub

    Private Sub Finalizar(ByVal sender As System.Object, ByVal e As System.EventArgs)
        Try
            TimerExamen.Enabled = False

            examenEnCurso.Finalizado = True

            For Each respuestaElegida In respuestas
                Dim respuesta As New ExamenRespuesta
                respuesta.Respuesta = respuestaElegida.Text
                respuesta.IdPregunta = respuestaElegida.ID 'ID original de la pregunta
                examenEnCurso.Respuestas.Add(respuesta)
            Next
            If examenBusiness.Actualizar(examenEnCurso) Then
                MensajeOk(lblMensajes)
            Else
                MensajeError(lblMensajes)
            End If
        Catch ex As Exception
            MensajeError(lblMensajes)
        End Try

        Response.Redirect(PaginasConocidas.MI_CURSADA)
    End Sub


    Protected Sub TimerExamen_Tick(sender As Object, e As EventArgs) Handles TimerExamen.Tick
        Try
        Dim ts As TimeSpan = Session("tiempoRestante").Subtract(DateTime.Now)
        If ts.TotalMilliseconds > 0 Then
            lblTiempo.Text = ts.ToString("mm\:ss")
        Else
            lblTiempo.Text = "00:00"
            TimerExamen.Enabled = False
            'finalizar examen sino finalizo
            Finalizar(sender, e)
            Session("tiempoRestante") = Nothing
            End If
        Catch ex As Exception
            ex.ToString()
        End Try
    End Sub
End Class