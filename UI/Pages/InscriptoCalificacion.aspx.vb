Imports EE
Imports Business

Public Class InscriptoCalificacion
    Inherits PaginaAutorizada

    Dim fichaBaseBusiness As New FichaEncuestaBase_Business
    Dim fichaBusiness As New FichaEncuesta_Business

    Dim listaOpciones As New RadioButtonList
    Dim fichaBase As FichaEncuestaBase

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        CargarFicha()
    End Sub

    Protected Overrides Sub TraducirComponentesDinamicos()

    End Sub

    Private Sub CargarFicha()
        fichaBase = fichaBaseBusiness.Obtener(2) 'inscripcion

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

        For Each opcion In fichaBase.Preguntas
            listaOpciones.Items.Add(New ListItem(opcion.Pregunta))
        Next
        encuestaCierre.Controls.Add(listaOpciones)
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
    End Sub

    Private Sub Votar(ByVal sender As System.Object, ByVal e As System.EventArgs)
        Try
            Dim nuevaEncuesta = New FichaEncuesta
            nuevaEncuesta.IDFichaEncuestaBase = fichaBase.ID
            nuevaEncuesta.Fecha = Date.Now
            nuevaEncuesta.RespuestaUnica = listaOpciones.SelectedValue
            nuevaEncuesta.Usuario = usuario.ID
            If fichaBusiness.Crear(nuevaEncuesta) Then
                MensajeOk(lblMensajes)
            Else
                MensajeError(lblMensajes)
            End If
        Catch ex As Exception
            MensajeError(lblMensajes)
        End Try
        CargarFicha()
    End Sub

End Class