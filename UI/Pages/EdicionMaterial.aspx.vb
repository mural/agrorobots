
Imports EE
Imports Business
Imports EE.ElementoAcademico

Public Class EdicionMaterial
    Inherits PaginaAutorizada

    Dim elementoAcademicoBusiness As New Business.ElementoAcademico_Business

    Dim idElementoAcademico As String
    Dim materialBusiness As New MaterialDeEstudio_Business
    Dim materialDeEstudio As New MaterialDeEstudio

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        idElementoAcademico = Request.QueryString("id")
        Dim idElementoAcademicoInt As Integer
        If Not String.IsNullOrEmpty(idElementoAcademico) And Integer.TryParse(idElementoAcademico, idElementoAcademicoInt) And Not elementoAcademicoBusiness.Obtener(idElementoAcademicoInt) Is Nothing Then
            CargarMateriales()
        Else
            Response.Redirect(PaginasConocidas.HOME)
        End If
        materialDeEstudio = Session("materialDeEstudio")
        If Not (Page.IsPostBack) Then
            CargarTipos()
        End If
    End Sub

    Protected Overrides Sub TraducirComponentesDinamicos()
        CargarMateriales()
        TraducirLoopingControls(Me)
    End Sub

    Private Sub CargarMateriales()
        Me.GridView1_.DataSource = materialBusiness.ListarPorElementoAcademico(CInt(idElementoAcademico))
        Me.GridView1_.DataBind()
    End Sub

    Private Sub CargarTipos()
        comboTipos.Items.Add(New ListItem("Texto HTML", "HTML"))
        comboTipos.Items.Add(New ListItem("PDF", "PDF"))
        comboTipos.Items.Add(New ListItem("Video", "VIDEO"))
    End Sub

    Protected Sub Update(sender As Object, e As EventArgs) Handles btnActualizar_405.Click
        If Not materialDeEstudio Is Nothing Then

            Dim Tipo = Me.comboTipos.SelectedValue
            Dim Detalle = Me.txtDetalle.Text
            Dim Contenido = areaContenido.InnerText
            Dim Activo = True
            Dim FechaInicio = Date.ParseExact(txtFechaMax.Value, "MM/dd/yyyy", Nothing)
            Dim archivo As FileUpload = CType(pdfUpload, FileUpload)
            Dim archivoByte As Byte() = Nothing
            If archivo.HasFile AndAlso Not archivo.PostedFile Is Nothing Then
                Dim File As HttpPostedFile = pdfUpload.PostedFile
                archivoByte = New Byte(File.ContentLength - 1) {}
                'force the control to load data in array
                File.InputStream.Read(archivoByte, 0, File.ContentLength)
            End If

            Try
                Dim valido = True
                If String.IsNullOrEmpty(Detalle) And String.IsNullOrEmpty(Contenido) Then
                    valido = False
                    lblMensajes.Text = String.Format(idiomas.GetTranslationById(90016), "")
                    lblMensajes.CssClass = "formError"
                End If
                If valido Then
                    materialDeEstudio.Tipo = Tipo
                    materialDeEstudio.Detalle = Detalle
                    materialDeEstudio.Contenido = Contenido
                    materialDeEstudio.Activo = Activo
                    materialDeEstudio.FechaMaxVisita = FechaInicio
                    materialDeEstudio.Archivo = archivoByte

                    If materialBusiness.Actualizar(materialDeEstudio) Then
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
            CargarMateriales()
        End If

        Interaction.MsgBox("Ok!", MsgBoxStyle.Information)
    End Sub

    Protected Sub Delete(ByVal sender As Object, ByVal e As EventArgs)
        Dim lnkRemove As LinkButton = DirectCast(sender, LinkButton)

        materialBusiness.Borrar(lnkRemove.CommandArgument)

        GridView1_.EditIndex = -1
        CargarMateriales()
    End Sub

    Protected Sub OnPaging(ByVal sender As Object, ByVal e As GridViewPageEventArgs)
        CargarMateriales()
        GridView1_.PageIndex = e.NewPageIndex
        GridView1_.DataBind()
        lblMensajes.Text = ""
    End Sub

    Protected Sub btnCrear_32_Click(sender As Object, e As EventArgs) Handles btnCrear_32.Click
        Dim Tipo = Me.comboTipos.SelectedValue
        Dim Detalle = Me.txtDetalle.Text
        Dim Contenido = areaContenido.InnerText
        Dim Activo = True
        Dim FechaInicio = Date.ParseExact(txtFechaMax.Value, "MM/dd/yyyy", Nothing)

        Dim archivo As FileUpload = CType(pdfUpload, FileUpload)
        Dim archivoByte As Byte() = Nothing
        If archivo.HasFile AndAlso Not archivo.PostedFile Is Nothing Then
            Dim File As HttpPostedFile = pdfUpload.PostedFile
            archivoByte = New Byte(File.ContentLength - 1) {}
            'force the control to load data in array
            File.InputStream.Read(archivoByte, 0, File.ContentLength)
        End If

        Try
            Dim valido = True
            If String.IsNullOrEmpty(Detalle) And String.IsNullOrEmpty(Contenido) Then
                valido = False
                lblMensajes.Text = String.Format(idiomas.GetTranslationById(90016), "")
                lblMensajes.CssClass = "formError"
            End If
            If valido Then
                Dim materialDeEstudio As New MaterialDeEstudio
                materialDeEstudio.IdElementoAcademico = idElementoAcademico
                materialDeEstudio.Tipo = Tipo
                materialDeEstudio.Detalle = Detalle
                materialDeEstudio.Contenido = Contenido
                materialDeEstudio.Activo = Activo
                materialDeEstudio.FechaMaxVisita = FechaInicio
                materialDeEstudio.Archivo = archivoByte

                If materialBusiness.Crear(materialDeEstudio) Then
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
        CargarMateriales()
    End Sub

    Protected Sub GridView1_SelectedIndexChanging(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewSelectEventArgs) Handles GridView1_.SelectedIndexChanging
        Dim pageFactor = GridView1_.PageIndex * GridView1_.PageSize
        Session("materialDeEstudio") = materialBusiness.ListarPorElementoAcademico(idElementoAcademico).ElementAt(pageFactor + e.NewSelectedIndex)
        materialDeEstudio = Session("materialDeEstudio")

        Me.comboTipos.SelectedValue = materialDeEstudio.Tipo
        Me.txtDetalle.Text = materialDeEstudio.Detalle
        Me.areaContenido.InnerText = materialDeEstudio.Contenido
        Me.txtFechaMax.Value = materialDeEstudio.FechaMaxVisita.ToString("MM/dd/yyyy")
    End Sub

    Private Sub Limpiar()
        Me.comboTipos.SelectedValue = "HTML"
        Me.txtDetalle.Text = ""
        Me.areaContenido.InnerText = ""
        Me.txtFechaMax.Value = ""
        Session("materialDeEstudio") = Nothing
    End Sub

    Protected Sub comboTipos_SelectedIndexChanged(sender As Object, e As EventArgs) Handles comboTipos.SelectedIndexChanged
        If Me.comboTipos.SelectedValue = "HTML" Then
            pdfUpload.Enabled = False
            txtLink.Enabled = False
        ElseIf Me.comboTipos.SelectedValue = "PDF" Then
            pdfUpload.Enabled = True
            txtLink.Enabled = False
        Else 'video link
            pdfUpload.Enabled = False
            txtLink.Enabled = True
        End If
    End Sub
End Class
