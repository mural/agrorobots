Imports EE
Imports Business

Public Class AbmElementoAcademico
    Inherits PaginaAutorizada

    Dim elementoAcademicoBusiness As New Business.ElementoAcademico_Business
    Dim elementoAcademico As New ElementoAcademico

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not (Page.IsPostBack) Then
            CargarElementosAcademicos()
        End If
    End Sub

    Protected Overrides Sub TraducirComponentesDinamicos()
        CargarElementosAcademicos()
        TraducirLoopingControls(Me)
    End Sub

    Private Sub CargarElementosAcademicos()
        Me.GridView1_.DataSource = elementoAcademicoBusiness.Listar
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
    Protected Sub Update(ByVal sender As Object, ByVal e As GridViewUpdateEventArgs)
        'Dim ID As String = DirectCast(GridView1_.Rows(e.RowIndex).FindControl("lblID"), Label).Text
        'Dim Texto As String = DirectCast(GridView1_.Rows(e.RowIndex).FindControl("txtTexto"), TextBox).Text
        'Dim Tema As Integer = DirectCast(GridView1_.Rows(e.RowIndex).FindControl("comboTipos"), DropDownList).SelectedValue

        'Dim img As FileUpload = CType(imgUpload, FileUpload)
        'Dim imgByte As Byte() = Nothing
        'If img.HasFile AndAlso Not img.PostedFile Is Nothing Then
        '    Dim File As HttpPostedFile = imgUpload.PostedFile
        '    imgByte = New Byte(File.ContentLength - 1) {}
        '    'force the control to load data in array
        '    File.InputStream.Read(imgByte, 0, File.ContentLength)
        'End If

        'Try
        '    Dim valido = True
        '    If String.IsNullOrEmpty(Texto) Then
        '        valido = False
        '        lblMensajes.Text = String.Format(idiomas.GetTranslationById(90016), "")
        '        lblMensajes.CssClass = "formError"
        '    End If
        '    If valido Then
        '        Dim novedad As New EE.Novedades
        '        novedad.ID = CType(ID, Integer)
        '        novedad.Texto = Texto
        '        If Not imgByte Is Nothing Then
        '            novedad.Foto = imgByte
        '        End If
        '        novedad.Fecha = Date.Now
        '        novedad.IDCategoriaTema = Tema

        '        novedadesBusiness.Actualizar(novedad)
        '        MensajeOk(lblMensajes)
        '    End If
        'Catch ex As Exception
        '    MensajeError(lblMensajes)
        'End Try

        'GridView1_.EditIndex = -1
        'CargarElementosAcademicos()
    End Sub

    Protected Sub Delete(ByVal sender As Object, ByVal e As EventArgs)
        Dim lnkRemove As LinkButton = DirectCast(sender, LinkButton)

        elementoAcademicoBusiness.Borrar(lnkRemove.CommandArgument)

        GridView1_.EditIndex = -1
        CargarElementosAcademicos()
    End Sub

    Protected Sub OnPaging(ByVal sender As Object, ByVal e As GridViewPageEventArgs)
        CargarElementosAcademicos()
        GridView1_.PageIndex = e.NewPageIndex
        GridView1_.DataBind()
        lblMensajes.Text = ""
    End Sub

    Protected Sub btnCrear_32_Click(sender As Object, e As EventArgs) Handles btnCrear_32.Click
        'Dim Tema As Integer = comboTipos.SelectedValue
        'Dim textoHTML = areaHTML.InnerText

        'Dim imgByte As Byte() = Nothing
        'If imgUpload.HasFile AndAlso Not imgUpload.PostedFile Is Nothing Then
        '    Dim File As HttpPostedFile = imgUpload.PostedFile
        '    imgByte = New Byte(File.ContentLength - 1) {}
        '    'force the control to load data in array
        '    File.InputStream.Read(imgByte, 0, File.ContentLength)
        'End If

        'Try
        '    Dim valido = True
        '    If String.IsNullOrEmpty(textoHTML) Then
        '        valido = False
        '        lblMensajes.Text = String.Format(idiomas.GetTranslationById(90016), "")
        '        lblMensajes.CssClass = "formError"
        '    End If
        '    If valido Then
        '        Dim novedad As New EE.Novedades
        '        novedad.ID = 0
        '        novedad.Texto = textoHTML
        '        If Not imgByte Is Nothing Then
        '            novedad.Foto = imgByte
        '        End If
        '        novedad.Fecha = Date.Now
        '        novedad.IDCategoriaTema = Tema

        '        novedadesBusiness.Crear(novedad)
        '        MensajeOk(lblMensajes)

        '        areaHTML.InnerText = ""
        '    End If
        'Catch ex As Exception
        '    MensajeError(lblMensajes)
        'End Try

        'GridView1_.EditIndex = -1
        'CargarElementosAcademicos()
    End Sub
End Class