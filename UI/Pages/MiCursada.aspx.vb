Imports EE
Imports Business

Public Class MiCursada
    Inherits PaginaAutorizada

    Dim elementoAcademicoBusiness As New ElementoAcademico_Business
    Dim ctaCteUsuarioBusiness As New CtaCteUsuario_Business
    Dim comprobanteNotaBusiness As New ComprobanteNota_Business

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not (Page.IsPostBack) Then
            CargarCursada()
        End If
    End Sub

    Protected Overrides Sub TraducirComponentesDinamicos()
        CargarCursada()
        TraducirLoopingControls(Me)
    End Sub

    Private Sub CargarCursada()
        Me.GridView1_.DataSource = usuario.ElementosAcademicos
        Me.GridView1_.DataBind()
    End Sub

    Protected Sub OnPaging(ByVal sender As Object, ByVal e As GridViewPageEventArgs)
        CargarCursada()
        GridView1_.PageIndex = e.NewPageIndex
        GridView1_.DataBind()
    End Sub

    Protected Sub Material(ByVal sender As Object, ByVal e As EventArgs)
        Dim link As ImageButton = DirectCast(sender, ImageButton)
        Response.Redirect(PaginasConocidas.VISTA_MATERIAL + "?id=" + link.CommandArgument)
    End Sub

    Protected Sub Examen(ByVal sender As Object, ByVal e As EventArgs)
        Dim link As ImageButton = DirectCast(sender, ImageButton)
        Response.Redirect(PaginasConocidas.EXAMENES_ALUMNOS + "?id=" + link.CommandArgument)
    End Sub

    Protected Sub Foro(ByVal sender As Object, ByVal e As EventArgs)
        Dim link As ImageButton = DirectCast(sender, ImageButton)
        Response.Redirect(PaginasConocidas.FORO + "?id=" + link.CommandArgument)
    End Sub

    Protected Sub Streaming(ByVal sender As Object, ByVal e As EventArgs)
        Dim link As ImageButton = DirectCast(sender, ImageButton)
        Response.Redirect(PaginasConocidas.STREAMING + "?id=" + link.CommandArgument)
    End Sub

    Protected Sub Delete(ByVal sender As Object, ByVal e As EventArgs)
        Dim lnkRemove As LinkButton = DirectCast(sender, LinkButton)
        Dim idElementoAcademico = CInt(lnkRemove.CommandArgument)

        Try
            Dim elementoABorrar As ElementoAcademico
            For Each elemAcademico As ElementoAcademico In usuario.ElementosAcademicos
                If elemAcademico.CodigoAcademico = idElementoAcademico Then
                    elementoABorrar = elemAcademico
                    Exit For
                End If
            Next
            elementoAcademicoBusiness.Desinscribir(usuario.ID, elementoABorrar.CodigoAcademico)
            usuario.ElementosAcademicos.Remove(elementoABorrar)
            ActualizarUsuarioEnSesion(usuario)

            ' nota de credito
            Dim ctacteItemUsuario As New CtaCteItemUsuario
            ctacteItemUsuario.IdUsuario = usuario.ID
            ctacteItemUsuario.Tipo = 2 'Nota de CREDITO
            ctacteItemUsuario.Estado = "EMITIDA"

            Dim comprobanteNota As New ComprobanteNota
            comprobanteNota.Numero = comprobanteNotaBusiness.Listar.Count + 1
            comprobanteNota.Tipo = 2 'Nota de CREDITO
            comprobanteNota.IdUsuario = usuario.ID
            comprobanteNota.FechaEmision = Now

            Dim comprobanteDetalle1 As New ComprobanteNotaDetalle
            comprobanteDetalle1.CodigoProducto = elementoABorrar.CodigoAcademico
            comprobanteDetalle1.Detalle = elementoABorrar.Nombre
            comprobanteDetalle1.Cantidad = 1 'a un solo curso por vez
            Dim precioSinIVA = elementoABorrar.Precio / 1.21 'precio menos IVA
            comprobanteDetalle1.PrecioUnitario = precioSinIVA
            comprobanteDetalle1.Subtotal = precioSinIVA
            comprobanteNota.Items.Add(comprobanteDetalle1)

            Dim subtotal = precioSinIVA
            Dim montoIVA = subtotal * 0.21 'IVA solo
            comprobanteNota.IVA = montoIVA
            comprobanteNota.Subtotal = subtotal
            comprobanteNota.Motivo = "Cancelacion de cursada: " + elementoABorrar.Nombre

            ctacteItemUsuario.Comprobante = comprobanteNota

            ctaCteUsuarioBusiness.Crear(ctacteItemUsuario)
        Catch ex As Exception
            ex.ToString()
        End Try

        RecargarPagina()
    End Sub

End Class