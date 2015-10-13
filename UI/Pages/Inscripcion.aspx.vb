Imports EE
Imports Business

Public Class Inscripcion
    Inherits PaginaAutorizada

    Dim elementoAcademicoBusiness As New ElementoAcademico_Business
    Dim idElementoAcademico As String
    Dim elementoAcademico As ElementoAcademico

    Dim ctaCteUsuarioBusiness As New CtaCteUsuario_Business

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        idElementoAcademico = Request.QueryString("id")
        Dim idElementoAcademicoInt As Integer
        If Not String.IsNullOrEmpty(idElementoAcademico) And Integer.TryParse(idElementoAcademico, idElementoAcademicoInt) And Not elementoAcademicoBusiness.Obtener(idElementoAcademicoInt) Is Nothing Then
            CargarElementoAcademico()
        Else
            Response.Redirect(PaginasConocidas.HOME)
        End If

        If Not Page.IsPostBack Then
            'combo pago
            formaDePagoList.Items.Clear()
            formaDePagoList.Items.Add(New ListItem(idiomas.GetTranslationById(122), "Efectivo"))
            formaDePagoList.Items.Add(New ListItem(idiomas.GetTranslationById(123), "Tarjeta"))
        End If
    End Sub

    Protected Overrides Sub TraducirComponentesDinamicos()

    End Sub

    Private Sub CargarElementoAcademico()
        Try
            elementoAcademico = elementoAcademicoBusiness.Obtener(CInt(idElementoAcademico))

            nav_curso.Text = elementoAcademico.Nombre
            nav_curso_link.HRef = PaginasConocidas.CATALOGO_DETALLE + "?id=" + idElementoAcademico

            lblNombre.Text = elementoAcademico.Nombre
            lblPrecio.Text = elementoAcademico.Precio
        Catch e As Exception
        End Try
    End Sub

    Protected Sub inscribirse_118_Click(sender As Object, e As EventArgs) Handles inscribirse_118.Click
        Dim ctacteItemUsuario As New CtaCteItemUsuario
        ctacteItemUsuario.IdUsuario = usuario.ID
        Dim estado = "PAGO" 'tarjeta
        If formaDePagoList.SelectedValue.Equals("Efectivo") Then
            estado = "NO_PAGO"
        End If
        ctacteItemUsuario.Tipo = 1 'B
        ctacteItemUsuario.Estado = estado

        Dim comprobante As New Comprobante
        comprobante.Numero = 1
        comprobante.Sucursal = 1
        comprobante.Tipo = 1 'B
        comprobante.IdUsuario = usuario.ID
        comprobante.FechaEmision = Now
        comprobante.FechaVencimiento = Date.Today.AddDays(10)
        Dim subtotal As Decimal = 0

        Dim comprobanteDetalle1 As New ComprobanteDetalle
        comprobanteDetalle1.CodigoProducto = idElementoAcademico
        comprobanteDetalle1.Detalle = elementoAcademico.Nombre
        comprobanteDetalle1.Cantidad = 1
        comprobanteDetalle1.PrecioUnitario = elementoAcademico.Precio
        comprobanteDetalle1.Subtotal = elementoAcademico.Precio 'calcular
        subtotal += comprobanteDetalle1.Subtotal

        comprobante.Items.Add(comprobanteDetalle1)
        comprobante.Subtotal = subtotal
        ctacteItemUsuario.Comprobante = comprobante

        If ctaCteUsuarioBusiness.Crear(ctacteItemUsuario) Then
            MensajeOk(lblMensajes)
            'agregar a usuario ?

            Response.Redirect(PaginasConocidas.INSCRIPTO_CALIFICAR)
        Else
            MensajeError(lblMensajes)
        End If
    End Sub


    Protected Sub formaDePagoList_SelectedIndexChanged(sender As Object, e As EventArgs) Handles formaDePagoList.SelectedIndexChanged
        If formaDePagoList.SelectedValue.Equals("Efectivo") Then
            panelTarjeta.Visible = False
        Else 'tarjeta
            panelTarjeta.Visible = True
        End If
    End Sub
End Class