Imports EE
Imports Business

Public Class ExamenCorreccion
    Inherits PaginaAutorizada

    Dim examenBaseBusiness As New ExamenBase_Business
    Dim examenBusiness As New Examen_Business
    Dim examenRespuestaBusiness As New ExamenRespuesta_Business

    Dim examenBase As ExamenBase
    Dim examen As Examen

    Dim idExamen As String

    Dim nota As New TextBox()

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        idExamen = Request.QueryString("id")
        Dim idElementoAcademicoInt As Integer
        If Not String.IsNullOrEmpty(idExamen) And Integer.TryParse(idExamen, idElementoAcademicoInt) And Not examenBusiness.Obtener(idElementoAcademicoInt) Is Nothing Then
            CargarExamen()
        Else
            Response.Redirect(PaginasConocidas.HOME)
        End If
    End Sub

    Protected Overrides Sub TraducirComponentesDinamicos()

    End Sub

    Private Sub CargarExamen()
        examen = examenBusiness.Obtener(CInt(idExamen))
        examenBase = examenBaseBusiness.Obtener(CInt(examen.IdExamenBase))

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
            Dim respuesta = examenRespuestaBusiness.ObtenerPorPregunta(pregunta.ID)
            examenCierre.Controls.Add(New LiteralControl(" - " + respuesta + "<br/><br/>"))
        Next

        examenCierre.Controls.Add(New LiteralControl(idiomas.GetTranslationById(169))) 'nota
        nota.ID = "notaExamen"
        examenCierre.Controls.Add(nota)

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
            examen.Nota = nota.Text
            If examenBusiness.Actualizar(examen) Then
                MensajeOk(lblMensajes)
            Else
                MensajeError(lblMensajes)
            End If
        Catch ex As Exception
            MensajeError(lblMensajes)
        End Try

        Response.Redirect(PaginasConocidas.MIS_CLASES)
    End Sub

End Class