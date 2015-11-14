Imports EE
Imports Business

Public Class InscriptoCalificacion
    Inherits PaginaAutorizada

    Dim fichaBaseBusiness As New FichaEncuestaBase_Business
    Dim fichaBusiness As New FichaEncuesta_Business

    Dim fichaBase As FichaEncuestaBase
    Dim respuestas As New List(Of RadioButtonList)

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        CargarFicha()
    End Sub

    Protected Overrides Sub TraducirComponentesDinamicos()

    End Sub

    Private Sub CargarFicha()
        Try
            Dim fichas = fichaBaseBusiness.ListarFichas
            Dim cantidad = fichas.Count
            Dim random As New Random
            Dim numeroAzar = random.Next(cantidad)

            fichaBase = fichas(numeroAzar)

            encuestaInicio.Controls.Clear()
            encuestaCierre.Controls.Clear()

            Dim descripcionInicio = New LiteralControl()
            descripcionInicio.Text = ""
            descripcionInicio.Text += "<div class='w3-card-4'>"
            descripcionInicio.Text += "<header class='w3-container w3-blue'>"
            descripcionInicio.Text += fichaBase.Descripcion
            descripcionInicio.Text += "</header>"
            descripcionInicio.Text += "<div class='w3-container'>"
            encuestaInicio.Controls.Add(descripcionInicio)

            For Each pregunta In fichaBase.Preguntas
                encuestaCierre.Controls.Add(New LiteralControl(pregunta.Pregunta))
                Dim listaOpciones As New RadioButtonList
                listaOpciones.ID = pregunta.ID
                listaOpciones.Items.Add(New ListItem("Muy mala", 1))
                listaOpciones.Items.Add(New ListItem("Mala", 2))
                listaOpciones.Items.Add(New ListItem("Buena", 3))
                listaOpciones.Items.Add(New ListItem("Muy buena", 4))
                listaOpciones.Items.Add(New ListItem("Excelente", 5))
                encuestaCierre.Controls.Add(listaOpciones)
                respuestas.Add(listaOpciones)
            Next
            Dim submit As New Button()
            submit.Text = idiomas.GetTranslationById(135) 'enviar
            submit.CssClass = "w3-btn w3-khaki"
            AddHandler submit.Click, AddressOf Me.Votar
            encuestaCierre.Controls.Add(submit)

            Dim descripcionCierre = New LiteralControl()
            descripcionCierre.Text = ""
            descripcionCierre.Text += "</div>"
            descripcionCierre.Text += "</div>"
            descripcionCierre.Text += "<br/><hr/><br/>"
            encuestaCierre.Controls.Add(descripcionCierre)

        Catch ex As Exception
            MensajeError(lblMensajes)
        End Try
    End Sub

    Private Sub Votar(ByVal sender As System.Object, ByVal e As System.EventArgs)
        Try
            Dim nuevaFicha = New FichaEncuesta
            nuevaFicha.IDFichaEncuestaBase = fichaBase.ID
            nuevaFicha.Fecha = Date.Now
            nuevaFicha.RespuestaUnica = ""
            For Each respuestaElegida In respuestas
                Dim respuesta As New FichaEncuestaRespuesta
                respuesta.Respuesta = respuestaElegida.SelectedValue
                respuesta.IDPregunta = respuestaElegida.ID 'ID original de la pregunta
                nuevaFicha.Respuestas.Add(respuesta)
            Next
            nuevaFicha.Usuario = usuario.ID
            If fichaBusiness.Crear(nuevaFicha) Then
                MensajeOk(lblMensajes)
            Else
                MensajeError(lblMensajes)
            End If
        Catch ex As Exception
            MensajeError(lblMensajes)
        End Try

        Response.Redirect(PaginasConocidas.CUENTA_CORRIENTE)
    End Sub

End Class