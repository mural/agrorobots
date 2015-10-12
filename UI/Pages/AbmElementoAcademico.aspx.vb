﻿Imports EE
Imports Business
Imports EE.ElementoAcademico

Public Class AbmElementoAcademico
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
    Protected Sub Update(sender As Object, e As EventArgs) Handles btnActualizar_405.Click
        If Not elementoAcademico Is Nothing Then

            Dim Nombre = txtNombre.Text
            Dim Contenido = areaContenido.InnerText
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
                If String.IsNullOrEmpty(Nombre) And String.IsNullOrEmpty(Contenido) Then
                    valido = False
                    lblMensajes.Text = String.Format(idiomas.GetTranslationById(90016), "")
                    lblMensajes.CssClass = "formError"
                End If
                If valido Then
                    elementoAcademico.Nombre = Nombre
                    elementoAcademico.Contenido = Contenido
                    If Not imgByte Is Nothing Then
                        elementoAcademico.Imagen = imgByte
                    End If
                    elementoAcademico.Estado = elementoAcademico.EstadoEnumATexto(ElementoAcademicoEnum.SinContenido)

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
        Dim nombre = Me.txtNombre.Text
        Dim contenido = areaContenido.InnerText

        Dim imgByte As Byte() = Nothing
        If imgUpload.HasFile AndAlso Not imgUpload.PostedFile Is Nothing Then
            Dim File As HttpPostedFile = imgUpload.PostedFile
            imgByte = New Byte(File.ContentLength - 1) {}
            'force the control to load data in array
            File.InputStream.Read(imgByte, 0, File.ContentLength)
        End If

        Try
            Dim valido = True
            If String.IsNullOrEmpty(nombre) And String.IsNullOrEmpty(contenido) Then
                valido = False
                lblMensajes.Text = String.Format(idiomas.GetTranslationById(90016), "")
                lblMensajes.CssClass = "formError"
            End If
            If valido Then
                Dim elementoAcademico As New ElementoAcademico
                elementoAcademico.CodigoAcademico = 0
                elementoAcademico.Nombre = nombre
                elementoAcademico.Contenido = contenido
                If Not imgByte Is Nothing Then
                    elementoAcademico.Imagen = imgByte
                End If
                elementoAcademico.Estado = "SIN CONTENIDO" 'enum?

                If elementoAcademicoBusiness.Crear(elementoAcademico) Then
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
    End Sub

    Protected Sub GridView1_SelectedIndexChanging(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewSelectEventArgs) Handles GridView1_.SelectedIndexChanging
        Dim pageFactor = GridView1_.PageIndex * GridView1_.PageSize
        Session("elementoSeleccionado") = elementoAcademicoBusiness.Listar.ElementAt(pageFactor + e.NewSelectedIndex)
        elementoAcademico = Session("elementoSeleccionado")

        Me.txtNombre.Text = elementoAcademico.Nombre
        Me.areaContenido.InnerText = elementoAcademico.Contenido
    End Sub

    Private Sub Limpiar()
        Me.txtNombre.Text = ""
        areaContenido.InnerText = ""
        'imagen
        Session("elementoSeleccionado") = Nothing
    End Sub

End Class