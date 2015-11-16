Imports EE
Imports Business
Imports EE.ElementoAcademico

Public Class ContenidoElementoAcademico
    Inherits PaginaAutorizada

    Dim elementoAcademicoBusiness As New Business.ElementoAcademico_Business
    Dim elementoAcademico As New ElementoAcademico

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        elementoAcademico = Session("elementoSeleccionado")
        If Not (Page.IsPostBack) Then
            CargarElementosAcademicos()
        End If
    End Sub

    Protected Overrides Sub TraducirComponentesDinamicos()
        CargarElementosAcademicos()
        TraducirLoopingControls(Me)
    End Sub

    Private Sub CargarElementosAcademicos()
        Me.GridView1_.DataSource = elementoAcademicoBusiness.ListarPorEstadoAsignadosProfesor(usuario.ID)
        Me.GridView1_.DataBind()
    End Sub

    Protected Sub Edit(ByVal sender As Object, ByVal e As GridViewEditEventArgs)
        GridView1_.EditIndex = e.NewEditIndex
        CargarElementosAcademicos()
    End Sub
    Protected Sub CancelEdit(ByVal sender As Object, ByVal e As GridViewCancelEditEventArgs)
        GridView1_.EditIndex = -1
        CargarElementosAcademicos()
    End Sub
    Protected Sub Update(sender As Object, e As EventArgs) Handles btnEnviar_135.Click
        If Not elementoAcademico Is Nothing Then

            Dim Temas = areaTemas.InnerText
            Dim Criterios = areaCriterios.InnerText
            Dim Duracion = comboDuracion.SelectedValue 'numeros

            Try
                Dim valido = True
                Dim DuracionInt As Integer
                If String.IsNullOrEmpty(Temas) And String.IsNullOrEmpty(Criterios) And String.IsNullOrEmpty(Duracion) And Integer.TryParse(Duracion, DuracionInt) Then
                    valido = False
                    lblMensajes.Text = String.Format(idiomas.GetTranslationById(90016), "")
                    lblMensajes.CssClass = "formError"
                End If
                If valido Then
                    elementoAcademico.Temas = Temas
                    elementoAcademico.CriteriosAprobacion = Criterios
                    elementoAcademico.Duracion = DuracionInt
                    elementoAcademico.Estado = elementoAcademico.EstadoEnumATexto(ElementoAcademicoEnum.ConContenido)

                    If elementoAcademicoBusiness.Actualizar(elementoAcademico) Then
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
            CargarElementosAcademicos()
        End If
    End Sub

    Protected Sub OnPaging(ByVal sender As Object, ByVal e As GridViewPageEventArgs)
        CargarElementosAcademicos()
        GridView1_.PageIndex = e.NewPageIndex
        GridView1_.DataBind()
        lblMensajes.Text = ""
    End Sub

    Protected Sub GridView1_SelectedIndexChanging(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewSelectEventArgs) Handles GridView1_.SelectedIndexChanging
        Dim pageFactor = GridView1_.PageIndex * GridView1_.PageSize
        Session("elementoSeleccionado") = elementoAcademicoBusiness.Listar.ElementAt(pageFactor + e.NewSelectedIndex)
        elementoAcademico = Session("elementoSeleccionado")

        Me.txtNombre.Text = elementoAcademico.Nombre
        Me.lblContenido.Text = elementoAcademico.Contenido
        Me.areaTemas.InnerText = elementoAcademico.Temas
        Me.areaCriterios.InnerText = elementoAcademico.CriteriosAprobacion
    End Sub

    Private Sub Limpiar()
        Me.txtNombre.Text = ""
        Me.lblContenido.Text = ""
        Me.areaTemas.InnerText = ""
        Me.areaCriterios.InnerText = ""
        Session("elementoSeleccionado") = Nothing
    End Sub

End Class