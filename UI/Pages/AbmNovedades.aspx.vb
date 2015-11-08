Imports EE
Imports Business

Public Class AbmNovedades
    Inherits PaginaAutorizada

    Dim novedadesBusiness As New Business.Novedades_Business
    Dim categoriaTemaBusiness As New CategoriaTema_Business

    Dim novedadSeleccionada As EE.Novedades

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        novedadSeleccionada = Session("novedadSeleccionada")
        If Not (Page.IsPostBack) Then
            CargarNovedades()
            CargarTemas()
        End If
    End Sub

    Protected Overrides Sub TraducirComponentesDinamicos()
        CargarNovedades()
        TraducirLoopingControls(Me)
    End Sub

    Private Sub CargarNovedades()
        Me.GridView1_.DataSource = novedadesBusiness.ListarSinFiltros
        Me.GridView1_.DataBind()
    End Sub

    Public Function ObtenerTema(ByVal idTema As Integer) As String
        Return categoriaTemaBusiness.Obtener(idTema).Nombre
    End Function

    Protected Sub CargarTemas()
        comboTipos.Items.Clear()
        For Each categoriaTema In categoriaTemaBusiness.Listar()
            comboTipos.Items.Add(New ListItem(categoriaTema.Nombre, categoriaTema.ID))
        Next
    End Sub

    Protected Sub Update(sender As Object, e As EventArgs) Handles btnActualizar_405.Click
        If Not novedadSeleccionada Is Nothing Then
            Dim Tema As Integer = comboTipos.SelectedValue
            Dim textoHTML = areaHTML.InnerText

            Dim imgByte As Byte() = Nothing
            If imgUpload.HasFile AndAlso Not imgUpload.PostedFile Is Nothing Then
                Dim File As HttpPostedFile = imgUpload.PostedFile
                imgByte = New Byte(File.ContentLength - 1) {}
                'force the control to load data in array
                File.InputStream.Read(imgByte, 0, File.ContentLength)
            End If

            Dim FechaInicio = Date.ParseExact(txtFechaInicio.Value, "MM/dd/yyyy", Nothing)
            Dim FechaFin = Date.ParseExact(txtFechaFin.Value, "MM/dd/yyyy", Nothing)

            Try
                Dim valido = True
                If String.IsNullOrEmpty(textoHTML) Then
                    valido = False
                    lblMensajes.Text = String.Format(idiomas.GetTranslationById(90016), "")
                    lblMensajes.CssClass = "formError"
                End If
                If valido Then
                    novedadSeleccionada.Texto = textoHTML
                    If Not imgByte Is Nothing Then
                        novedadSeleccionada.Foto = imgByte
                    End If
                    novedadSeleccionada.Fecha = Date.Now
                    novedadSeleccionada.IDCategoriaTema = Tema
                    novedadSeleccionada.FechaInicio = FechaInicio
                    novedadSeleccionada.FechaFin = FechaFin

                    novedadesBusiness.Actualizar(novedadSeleccionada)
                    MensajeOk(lblMensajes)
                End If
            Catch ex As Exception
                MensajeError(lblMensajes)
            End Try

            GridView1_.EditIndex = -1
            CargarNovedades()
        End If
    End Sub

    Protected Sub Delete(ByVal sender As Object, ByVal e As EventArgs)
        Dim lnkRemove As LinkButton = DirectCast(sender, LinkButton)

        novedadesBusiness.Borrar(lnkRemove.CommandArgument)

        GridView1_.EditIndex = -1
        CargarNovedades()
    End Sub

    Protected Sub OnPaging(ByVal sender As Object, ByVal e As GridViewPageEventArgs)
        CargarNovedades()
        GridView1_.PageIndex = e.NewPageIndex
        GridView1_.DataBind()
        lblMensajes.Text = ""
    End Sub

    Protected Sub btnCrear_32_Click(sender As Object, e As EventArgs) Handles btnCrear_32.Click
        Dim Tema As Integer = comboTipos.SelectedValue
        Dim textoHTML = areaHTML.InnerText

        Dim imgByte As Byte() = Nothing
        If imgUpload.HasFile AndAlso Not imgUpload.PostedFile Is Nothing Then
            Dim File As HttpPostedFile = imgUpload.PostedFile
            imgByte = New Byte(File.ContentLength - 1) {}
            'force the control to load data in array
            File.InputStream.Read(imgByte, 0, File.ContentLength)
        End If

        Dim FechaInicio = Date.ParseExact(txtFechaInicio.Value, "MM/dd/yyyy", Nothing)
        Dim FechaFin = Date.ParseExact(txtFechaFin.Value, "MM/dd/yyyy", Nothing)

        Try
            Dim valido = True
            If String.IsNullOrEmpty(textoHTML) Then
                valido = False
                lblMensajes.Text = String.Format(idiomas.GetTranslationById(90016), "")
                lblMensajes.CssClass = "formError"
            End If
            If valido Then
                Dim novedadNueva As New EE.Novedades
                novedadNueva.ID = 0
                novedadNueva.Texto = textoHTML
                If Not imgByte Is Nothing Then
                    novedadNueva.Foto = imgByte
                End If
                novedadNueva.Fecha = Date.Now
                novedadNueva.IDCategoriaTema = Tema
                novedadNueva.FechaInicio = FechaInicio
                novedadNueva.FechaFin = FechaFin

                novedadesBusiness.Crear(novedadNueva)
                MensajeOk(lblMensajes)

                areaHTML.InnerText = ""
            End If
        Catch ex As Exception
            MensajeError(lblMensajes)
        End Try

        GridView1_.EditIndex = -1
        CargarNovedades()
    End Sub

    Protected Sub GridView1_SelectedIndexChanging(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewSelectEventArgs) Handles GridView1_.SelectedIndexChanging
        Dim pageFactor = GridView1_.PageIndex * GridView1_.PageSize
        Session("novedadSeleccionada") = novedadesBusiness.ListarSinFiltros.ElementAt(pageFactor + e.NewSelectedIndex)
        novedadSeleccionada = Session("novedadSeleccionada")

        Me.comboTipos.SelectedValue = novedadSeleccionada.IDCategoriaTema
        Me.areaHTML.InnerText = novedadSeleccionada.Texto
        Me.txtFechaInicio.Value = novedadSeleccionada.FechaInicio.ToString("MM/dd/yyyy")
        Me.txtFechaFin.Value = novedadSeleccionada.FechaFin.ToString("MM/dd/yyyy")

    End Sub

End Class