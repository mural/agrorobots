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

    Dim nota As New DropDownList
    Dim comentario As New TextBox
    Dim audio As New FileUpload
    Dim audioValidator As New RegularExpressionValidator

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
            Dim respuesta = examenRespuestaBusiness.ObtenerPorPregunta(pregunta.ID, examen.ID)
            examenCierre.Controls.Add(New LiteralControl(" - " + respuesta + "<br/><br/>"))
        Next

        examenCierre.Controls.Add(New LiteralControl(idiomas.GetTranslationById(169))) 'nota
        nota.ID = "notaExamen"
        nota.Items.Add(New ListItem("1", "1"))
        nota.Items.Add(New ListItem("2", "2"))
        nota.Items.Add(New ListItem("3", "3"))
        nota.Items.Add(New ListItem("4", "4"))
        nota.Items.Add(New ListItem("5", "5"))
        nota.Items.Add(New ListItem("6", "6"))
        nota.Items.Add(New ListItem("7", "7"))
        nota.Items.Add(New ListItem("8", "8"))
        nota.Items.Add(New ListItem("9", "9"))
        nota.Items.Add(New ListItem("10", "10"))
        nota.SelectedIndex = 4
        examenCierre.Controls.Add(nota)

        comentario.ID = "comentarioExamen"
        comentario.Rows = 2
        comentario.MaxLength = 100
        examenCierre.Controls.Add(comentario)

        Dim audioCierre = New LiteralControl()
        audioCierre.Text += "<br/>WMA "
        examenCierre.Controls.Add(audioCierre)
        audio.ID = "audioExamen"
        examenCierre.Controls.Add(audio)

        audioValidator.ID = "validarAudio"
        audioValidator.ErrorMessage = "*"
        audioValidator.ControlToValidate = "audioExamen"
        audioValidator.ValidationExpression = "(.*).(.wma|.WMA)$"
        audioValidator.EnableClientScript = False
        audioValidator.Display = ValidatorDisplay.Dynamic
        audioValidator.CssClass = "formError"
        examenCierre.Controls.Add(audioValidator)

        Dim espacio1 = New LiteralControl()
        espacio1.Text += "<br/><br/>"
        examenCierre.Controls.Add(espacio1)

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
        If Page.IsValid Then

            Try
                examen.Nota = CInt(nota.SelectedValue)
                examen.Comentario = comentario.Text

                Try
                    Dim archivo As FileUpload = CType(audio, FileUpload)
                    Dim archivoByte As Byte() = Nothing
                    If archivo.HasFile AndAlso Not archivo.PostedFile Is Nothing Then
                        Dim File As HttpPostedFile = audio.PostedFile
                        archivoByte = New Byte(File.ContentLength - 1) {}
                        'force the control to load data in array
                        File.InputStream.Read(archivoByte, 0, File.ContentLength)
                    End If
                    examen.Audio = archivoByte
                Catch ex As Exception

                End Try

                If examenBusiness.Actualizar(examen) Then
                    MensajeOk(lblMensajes)
                Else
                    MensajeError(lblMensajes)
                End If
            Catch ex As Exception
                MensajeError(lblMensajes)
            End Try

            Response.Redirect(PaginasConocidas.MIS_CLASES)

        End If
    End Sub

End Class