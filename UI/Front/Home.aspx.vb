Imports EE
Imports Business
Imports System.Web.UI.DataVisualization.Charting

Public Class Home
    Inherits PaginaGenerica

    Dim encuestaBaseBusiness As New FichaEncuestaBase_Business
    Dim encuestaBusiness As New FichaEncuesta_Business

    Dim listaOpciones As New RadioButtonList

    Dim encuestaBase As FichaEncuestaBase
    Dim idSesion
    Dim voto = False

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        idSesion = Session.SessionID
        CargarEncuesta()
    End Sub

    Protected Overrides Sub TraducirComponentesDinamicos()

    End Sub

    Private Sub CargarEncuesta()
        encuestaInicio.Controls.Clear()
        encuestaCierre.Controls.Clear()

        Try
            Dim encuestas = encuestaBaseBusiness.ListarEncuestas(True)
            Dim cantidad = encuestas.Count
            Dim random As New Random
            Dim numeroAzar = random.Next(cantidad)

            encuestaBase = encuestas(numeroAzar)
            'ver si ya voto en esta encuesta
            For Each encuesta In encuestaBusiness.Listar
                If encuestaBase.ID = encuesta.IDFichaEncuestaBase And encuesta.Sesion = idSesion Then
                    voto = True
                    Exit For
                End If
            Next

            tituloEncuesta.Text = encuestaBase.Descripcion

            Dim descripcionInicio = New LiteralControl()
            descripcionInicio.Text = ""
            descripcionInicio.Text += "<div class='w3-card-4'>"
            descripcionInicio.Text += "<div class='w3-container'>"
            encuestaInicio.Controls.Add(descripcionInicio)

            If Not voto Then 'armo encuesta
                Resultado.Visible = False
                For Each opcion In encuestaBase.Preguntas
                    listaOpciones.Items.Add(New ListItem(" " + opcion.Pregunta))
                Next
                encuestaCierre.Controls.Add(listaOpciones)
                Dim submit As New Button()
                submit.Text = idiomas.GetTranslationById(110)
                submit.CssClass = "w3-btn w3-khaki"
                AddHandler submit.Click, AddressOf Me.Votar
                encuestaCierre.Controls.Add(submit)
            Else
                'muestro resultados
                Resultado.Visible = True
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

                Resultado.Series("Categories").XValueMember = "Opcion"
                Resultado.Series("Categories").YValueMembers = "Votos"
                Resultado.DataSource = resultados
                Resultado.DataBind()
                'encuestas.Controls.Add(submit)
            End If

            Dim descripcionCierre = New LiteralControl()
            descripcionCierre.Text = ""
            descripcionCierre.Text += "</div>"
            descripcionCierre.Text += "</div>"
            encuestaCierre.Controls.Add(descripcionCierre)
        Catch ex As Exception
            tituloEncuesta.Text = idiomas.GetTranslationById(180) 'No hay encuestas disponibles
            Resultado.Visible = False
        End Try
    End Sub

    Private Sub Votar(ByVal sender As System.Object, ByVal e As System.EventArgs)
        Try
            Dim nuevaEncuesta = New FichaEncuesta
            nuevaEncuesta.IDFichaEncuestaBase = encuestaBase.ID
            nuevaEncuesta.Fecha = Date.Now
            nuevaEncuesta.RespuestaUnica = listaOpciones.SelectedValue
            nuevaEncuesta.Sesion = idSesion  'mejor una cookie
            If encuestaBusiness.Crear(nuevaEncuesta) Then
                'MensajeOk(lblMensajes)
            Else
                'MensajeError(lblMensajes)
            End If
        Catch ex As Exception
            'MensajeError(lblMensajes)
        End Try
        CargarEncuesta()
    End Sub

End Class