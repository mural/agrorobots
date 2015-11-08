﻿Imports EE
Imports Business

Public Class CarrerasDetalle
    Inherits PaginaGenerica

    Dim elementoAcademico_Business As New ElementoAcademico_Business
    Dim idElementoAcademico As String
    Dim elementoAcademico As ElementoAcademico

    Dim comentariosBusiness As New Comentarios_Business

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        idElementoAcademico = Request.QueryString("id")
        Dim idElementoAcademicoInt As Integer
        If Not String.IsNullOrEmpty(idElementoAcademico) And Integer.TryParse(idElementoAcademico, idElementoAcademicoInt) And Not elementoAcademico_Business.Obtener(idElementoAcademicoInt) Is Nothing Then
            CargarElementoAcademico()
            CargarComentarios()
        Else
            Response.Redirect(PaginasConocidas.HOME)
        End If
        If UsuarioLogueado() Then
            panelComentario.Visible = True
        Else
            panelComentario.Visible = False
        End If
    End Sub

    Private Sub CargarElementoAcademico()
        Try
            elementoAcademico = elementoAcademico_Business.Obtener(CInt(idElementoAcademico))

            navActual.Text = elementoAcademico.Nombre
            lblTitulo.Text = elementoAcademico.Nombre
            lblDescripcion.Text = elementoAcademico.Descripcion
            lblDuracion.Text = elementoAcademico.Duracion
            lblClases.Text = elementoAcademico.Clases
            lblPrecio.Text = elementoAcademico.Precio
            lblCupo.Text = elementoAcademico.Cupo
            lblFechaInicio.Text = elementoAcademico.FechaInicio
        Catch e As Exception
        End Try
    End Sub

    Private Sub CargarComentarios()
        Me.GridComentarios.DataSource = comentariosBusiness.ListarPorElementoAcademico(CInt(idElementoAcademico))
        Me.GridComentarios.DataBind()
    End Sub

    Protected Overrides Sub TraducirComponentesDinamicos()

    End Sub

    Protected Sub inscribirse_Click(sender As Object, e As EventArgs) Handles inscribirse_118.Click
        'comprobar sesion
        If UsuarioLogueado() Then
            'hay cupo ?
            If elementoAcademico.Cupo > 0 Then
                'ver que no este inscripto
                Dim elementoABuscar As ElementoAcademico = Nothing
                For Each elemAcademico As ElementoAcademico In usuario.ElementosAcademicos
                    If elemAcademico.CodigoAcademico = elementoAcademico.CodigoAcademico Then
                        elementoABuscar = elemAcademico
                        Exit For
                    End If
                Next
                If Not elementoABuscar Is Nothing Then
                    MensajeError(lblMensajes, idiomas.GetTranslationById(183)) 'Ya esta inscripto
                Else
                    'agrego al carrito
                    Dim carritoSesion As List(Of ElementoAcademico) = Session("carrito")
                    If carritoSesion Is Nothing Then
                        carritoSesion = New List(Of ElementoAcademico)
                    End If
                    If Not carritoSesion.Contains(elementoAcademico) Then
                        carritoSesion.Add(elementoAcademico)
                    End If
                    Session("carrito") = carritoSesion
                    Response.Redirect(PaginasConocidas.CARRITO)
                End If
            Else
                MensajeError(lblMensajes, idiomas.GetTranslationById(184)) 'No hay cupo
            End If
        Else
            Response.Redirect(PaginasConocidas.LOGIN + "?inscribir=" + idElementoAcademico)
        End If
    End Sub

    Protected Sub Comentar_135_Click(sender As Object, e As EventArgs) Handles Comentar_135.Click
        Dim comentarioNuevo = New Comentario
        comentarioNuevo.IdUsuario = usuario.ID
        comentarioNuevo.IdElementoAcademico = CInt(idElementoAcademico)
        comentarioNuevo.Comentario = comentario.Text
        comentarioNuevo.Fecha = Date.Now
        comentariosBusiness.Crear(comentarioNuevo)

        RecargarPagina()
    End Sub
End Class