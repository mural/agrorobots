Imports EE
Imports Business

Public Class AbmFichas
    Inherits PaginaAutorizada

    Dim fichaEncuestaBaseBusiness As New Business.FichaEncuestaBase_Business
    Dim fichaEncuestaPreguntaBusiness As New Business.FichaEncuestaPregunta_Business

    Dim fichaBase As FichaEncuestaBase

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        fichaBase = Session("fichaSeleccionada")
        If Not (Page.IsPostBack) Then
            CargarFichas()
            CargarPreguntas()
        End If
    End Sub

    Protected Overrides Sub TraducirComponentesDinamicos()
        CargarFichas()
        TraducirLoopingControls(Me)
    End Sub

    Private Sub CargarFichas()
        Me.GridView1_.DataSource = fichaEncuestaBaseBusiness.ListarFichas
        Me.GridView1_.DataBind()
    End Sub

    Private Sub CargarPreguntas()
        If Not fichaBase Is Nothing Then
            Me.GridViewPreguntas.DataSource = fichaEncuestaPreguntaBusiness.ListarPorFicha(fichaBase.ID)
        End If
        Me.GridViewPreguntas.DataBind()
    End Sub

    Protected Sub Update(sender As Object, e As EventArgs) Handles btnActualizar_405.Click
        If Not fichaBase Is Nothing Then

            Dim descripcion = areaContenido.InnerText
            Dim img As FileUpload = CType(imgUpload, FileUpload)
            Dim imgByte As Byte() = Nothing
            If img.HasFile AndAlso Not img.PostedFile Is Nothing Then
                Dim File As HttpPostedFile = imgUpload.PostedFile
                imgByte = New Byte(File.ContentLength - 1) {}
                'force the control to load data in array
                File.InputStream.Read(imgByte, 0, File.ContentLength)
            End If

            Try
                Dim valido = True
                If String.IsNullOrEmpty(descripcion) Then
                    valido = False
                    lblMensajes.Text = String.Format(idiomas.GetTranslationById(90016), "")
                    lblMensajes.CssClass = "formError"
                End If
                If valido Then
                    fichaBase.Descripcion = descripcion
                    If Not imgByte Is Nothing Then
                        fichaBase.Foto = imgByte
                    End If

                    If fichaEncuestaBaseBusiness.Actualizar(fichaBase) Then
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
            CargarFichas()
        End If
    End Sub

    Protected Sub Delete(ByVal sender As Object, ByVal e As EventArgs)
        Dim lnkRemove As LinkButton = DirectCast(sender, LinkButton)

        fichaEncuestaBaseBusiness.Borrar(lnkRemove.CommandArgument)

        GridView1_.EditIndex = -1
        CargarFichas()
    End Sub

    Protected Sub OnPaging(ByVal sender As Object, ByVal e As GridViewPageEventArgs)
        CargarFichas()
        GridView1_.PageIndex = e.NewPageIndex
        GridView1_.DataBind()
        lblMensajes.Text = ""
    End Sub

    Protected Sub btnCrear_32_Click(sender As Object, e As EventArgs) Handles btnCrear_32.Click
        Dim descripcion = areaContenido.InnerText

        Dim imgByte As Byte() = Nothing
        If imgUpload.HasFile AndAlso Not imgUpload.PostedFile Is Nothing Then
            Dim File As HttpPostedFile = imgUpload.PostedFile
            imgByte = New Byte(File.ContentLength - 1) {}
            'force the control to load data in array
            File.InputStream.Read(imgByte, 0, File.ContentLength)
        End If

        Try
            Dim valido = True
            If String.IsNullOrEmpty(descripcion) Then
                valido = False
                lblMensajes.Text = String.Format(idiomas.GetTranslationById(90016), "")
                lblMensajes.CssClass = "formError"
            End If
            If valido Then
                Dim fichaBaseNueva As New FichaEncuestaBase
                fichaBaseNueva.ID = 0
                fichaBaseNueva.Descripcion = descripcion
                If Not imgByte Is Nothing Then
                    fichaBaseNueva.Foto = imgByte
                End If
                fichaBaseNueva.Tipo = "F" 'enum?

                If fichaEncuestaBaseBusiness.Crear(fichaBaseNueva) Then
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
        CargarFichas()
    End Sub

    Protected Sub GridView1_SelectedIndexChanging(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewSelectEventArgs) Handles GridView1_.SelectedIndexChanging
        Dim pageFactor = GridView1_.PageIndex * GridView1_.PageSize
        Session("fichaSeleccionada") = fichaEncuestaBaseBusiness.ListarFichas.ElementAt(pageFactor + e.NewSelectedIndex)
        fichaBase = Session("fichaSeleccionada")

        Me.areaContenido.InnerText = fichaBase.Descripcion
    End Sub

    Private Sub Limpiar()
        areaContenido.InnerText = ""
        'imagen
        Session("fichaSeleccionada") = Nothing
    End Sub

    Protected Sub NuevaPregunta(ByVal sender As Object, ByVal e As EventArgs)


        CargarPreguntas()
    End Sub

    Protected Sub Edit(ByVal sender As Object, ByVal e As GridViewEditEventArgs)
        GridView1_.EditIndex = e.NewEditIndex
        CargarPreguntas()
    End Sub
    Protected Sub CancelEdit(ByVal sender As Object, ByVal e As GridViewCancelEditEventArgs)
        GridView1_.EditIndex = -1
        CargarPreguntas()
    End Sub
    Protected Sub Update(ByVal sender As Object, ByVal e As GridViewUpdateEventArgs)

    End Sub

    Protected Sub BorrarPregunta(ByVal sender As Object, ByVal e As EventArgs)
        Dim lnkRemove As LinkButton = DirectCast(sender, LinkButton)

        fichaEncuestaPreguntaBusiness.Borrar(lnkRemove.CommandArgument)

        GridView1_.EditIndex = -1
        CargarPreguntas()
    End Sub
End Class