Imports EE
Imports Business
Imports EE.ElementoAcademico

Public Class EdicionExamen
    Inherits PaginaAutorizada

    Dim elementoAcademicoBusiness As New Business.ElementoAcademico_Business
    Dim idElementoAcademico As String

    Dim examenBaseBusiness As New Business.ExamenBase_Business
    Dim examenBasePreguntaBusiness As New Business.ExamenBasePregunta_Business
    Dim examenBase As ExamenBase

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        examenBase = Session("examenSeleccionado")
        idElementoAcademico = Request.QueryString("id")
        Dim idElementoAcademicoInt As Integer
        If Not String.IsNullOrEmpty(idElementoAcademico) And Integer.TryParse(idElementoAcademico, idElementoAcademicoInt) And Not elementoAcademicoBusiness.Obtener(idElementoAcademicoInt) Is Nothing Then
            If Not (Page.IsPostBack) Then
                CargarExamenes()
                CargarPreguntas()
            End If
        Else
            Response.Redirect(PaginasConocidas.HOME)
        End If
        If Not examenBase Is Nothing Then
            Me.txtPregunta.Enabled = True
            Me.btnAdd_5.Enabled = True
        End If
    End Sub

    Protected Overrides Sub TraducirComponentesDinamicos()
        CargarExamenes()
        TraducirLoopingControls(Me)
    End Sub

    Private Sub CargarExamenes()
        Me.GridView1_.DataSource = examenBaseBusiness.ListarPorElementoAcademico(CInt(idElementoAcademico), False)
        Me.GridView1_.DataBind()
    End Sub

    Private Sub CargarPreguntas()
        If Not examenBase Is Nothing Then
            Me.GridViewPreguntas.DataSource = examenBasePreguntaBusiness.ListarPorExamen(examenBase.ID)
        End If
        Me.GridViewPreguntas.DataBind()
    End Sub

    Protected Sub Update(sender As Object, e As EventArgs) Handles btnActualizar_405.Click
        If Not examenBase Is Nothing Then

            Dim descripcion = areaContenido.InnerText

            Try
                Dim valido = True
                If String.IsNullOrEmpty(descripcion) Then
                    valido = False
                    lblMensajes.Text = String.Format(idiomas.GetTranslationById(90016), "")
                    lblMensajes.CssClass = "formError"
                End If
                If valido Then
                    examenBase.Detalle = descripcion
                    examenBase.Activo = Me.cbxActivo.Checked
                    examenBase.Tipo = comboTipos.SelectedValue
                    examenBase.IdElementoAcademico = idElementoAcademico

                    If examenBaseBusiness.Actualizar(examenBase) Then
                        MensajeOk(lblMensajes)

                        Limpiar()
                    Else
                        MensajeError(lblMensajes)
                    End If
                End If
            Catch ex As Exception
                MensajeError(lblMensajes)
            End Try

            GridView1_.EditIndex = -1
            CargarExamenes()
        End If
    End Sub

    Protected Sub Delete(ByVal sender As Object, ByVal e As EventArgs)
        Dim lnkRemove As LinkButton = DirectCast(sender, LinkButton)

        examenBaseBusiness.Borrar(lnkRemove.CommandArgument)

        GridView1_.EditIndex = -1
        CargarExamenes()
    End Sub

    Protected Sub OnPaging(ByVal sender As Object, ByVal e As GridViewPageEventArgs)
        CargarExamenes()
        GridView1_.PageIndex = e.NewPageIndex
        GridView1_.DataBind()
        lblMensajes.Text = ""
    End Sub

    Protected Sub btnCrear_32_Click(sender As Object, e As EventArgs) Handles btnCrear_32.Click
        Dim descripcion = areaContenido.InnerText
        Try
            Dim valido = True
            If String.IsNullOrEmpty(descripcion) Then
                valido = False
                lblMensajes.Text = String.Format(idiomas.GetTranslationById(90016), "")
                lblMensajes.CssClass = "formError"
            End If
            If valido Then
                Dim examenBaseNueva As New ExamenBase
                examenBaseNueva.Detalle = descripcion
                examenBaseNueva.Activo = Me.cbxActivo.Checked
                examenBaseNueva.Tipo = comboTipos.SelectedValue
                examenBaseNueva.TiempoMax = 30 'media hora para todos
                examenBaseNueva.IdElementoAcademico = idElementoAcademico

                If examenBaseBusiness.Crear(examenBaseNueva) Then
                    MensajeOk(lblMensajes)

                    Limpiar()
                Else
                    MensajeError(lblMensajes)
                End If
            End If
        Catch ex As Exception
            MensajeError(lblMensajes)
        End Try

        GridView1_.EditIndex = -1
        CargarExamenes()
    End Sub

    Protected Sub GridView1_SelectedIndexChanging(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewSelectEventArgs) Handles GridView1_.SelectedIndexChanging
        Dim ID = CInt(DirectCast(GridView1_.Rows(e.NewSelectedIndex).FindControl("lblId"), Label).Text)
        Session("examenSeleccionado") = examenBaseBusiness.Obtener(ID)
        examenBase = Session("examenSeleccionado")

        Me.areaContenido.InnerText = examenBase.Detalle
        Me.comboTipos.SelectedValue = examenBase.Tipo
        Me.cbxActivo.Checked = examenBase.Activo

        Me.txtPregunta.Enabled = True
        Me.btnAdd_5.Enabled = True
        CargarPreguntas()
    End Sub

    Private Sub Limpiar()
        areaContenido.InnerText = ""
        Session("examenSeleccionado") = Nothing
    End Sub

    Protected Sub NuevaPregunta(ByVal sender As Object, ByVal e As EventArgs)
        Dim pregunta = Me.txtPregunta.Text

        Try
            Dim valido = True
            If String.IsNullOrEmpty(pregunta) Then
                valido = False
                lblMensajes.Text = String.Format(idiomas.GetTranslationById(90016), "")
                lblMensajes.CssClass = "formError"
            End If
            If valido Then
                Dim preguntaNueva As New ExamenBasePregunta
                preguntaNueva.ID = 0
                preguntaNueva.IdExamenBase = examenBase.ID
                preguntaNueva.Pregunta = pregunta

                If examenBasePreguntaBusiness.Crear(preguntaNueva) Then
                    MensajeOk(lblMensajes)
                    Me.txtPregunta.Text = ""
                Else
                    MensajeError(lblMensajes)
                End If
            End If
        Catch ex As Exception
            MensajeError(lblMensajes)
        End Try

        GridViewPreguntas.EditIndex = -1
        CargarPreguntas()
    End Sub

    Protected Sub Edit(ByVal sender As Object, ByVal e As GridViewEditEventArgs)
        GridViewPreguntas.EditIndex = e.NewEditIndex
        CargarPreguntas()
    End Sub
    Protected Sub CancelEdit(ByVal sender As Object, ByVal e As GridViewCancelEditEventArgs)
        GridViewPreguntas.EditIndex = -1
        CargarPreguntas()
    End Sub
    Protected Sub Update(ByVal sender As Object, ByVal e As GridViewUpdateEventArgs)
        Dim IDPregunta As String = DirectCast(GridViewPreguntas.Rows(e.RowIndex) _
                             .FindControl("lblID"), Label).Text
        Dim pregunta As String = DirectCast(GridViewPreguntas.Rows(e.RowIndex) _
                                     .FindControl("txtPregunta"), TextBox).Text

        Try
            Dim valido = True
            If String.IsNullOrEmpty(pregunta) Then
                valido = False
                lblMensajes.Text = String.Format(idiomas.GetTranslationById(90016), "")
                lblMensajes.CssClass = "formError"
            End If
            If valido Then
                Dim preguntaModificada As New ExamenBasePregunta
                preguntaModificada.ID = IDPregunta
                preguntaModificada.IdExamenBase = examenBase.ID
                preguntaModificada.Pregunta = pregunta

                If examenBasePreguntaBusiness.Actualizar(preguntaModificada) Then
                    MensajeOk(lblMensajes)
                    Me.txtPregunta.Text = ""
                Else
                    MensajeError(lblMensajes)
                End If
            End If
        Catch ex As Exception
            MensajeError(lblMensajes)
        End Try

        GridViewPreguntas.EditIndex = -1
        CargarPreguntas()
    End Sub

    Protected Sub BorrarPregunta(ByVal sender As Object, ByVal e As EventArgs)
        Dim lnkRemove As LinkButton = DirectCast(sender, LinkButton)

        examenBasePreguntaBusiness.Borrar(lnkRemove.CommandArgument)

        GridViewPreguntas.EditIndex = -1
        CargarPreguntas()
    End Sub
End Class