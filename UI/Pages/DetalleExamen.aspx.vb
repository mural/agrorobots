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

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        idExamenBase = Request.QueryString("id")
        Dim idElementoAcademicoInt As Integer
        If Not String.IsNullOrEmpty(idExamenBase) And Integer.TryParse(idExamenBase, idElementoAcademicoInt) And Not examenBaseBusiness.Obtener(idElementoAcademicoInt) Is Nothing Then
            CargarExamen()
        Else
            Response.Redirect(PaginasConocidas.HOME)
        End If
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
            Dim nuevoExamen = New Examen
            nuevoExamen.IdExamenBase = examenBase.ID
            nuevoExamen.Fecha = Date.Now
            nuevoExamen.IdAlumno = usuario.ID
            nuevoExamen.Nota = -1 'sin corregir

            For Each respuestaElegida In respuestas
                Dim respuesta As New ExamenRespuesta
                respuesta.Respuesta = respuestaElegida.Text
                respuesta.IDPregunta = respuestaElegida.ID 'ID original de la pregunta
                nuevoExamen.Respuestas.Add(respuesta)
            Next
            If examenBusiness.Crear(nuevoExamen) Then
                MensajeOk(lblMensajes)
            Else
                MensajeError(lblMensajes)
            End If
        Catch ex As Exception
            MensajeError(lblMensajes)
        End Try

        Response.Redirect(PaginasConocidas.MI_CURSADA)
    End Sub


End Class