Imports EE
Imports Business

Public Class Inscripcion
    Inherits PaginaAutorizada

    Dim elementoAcademicoBusiness As New ElementoAcademico_Business
    Dim idElementoAcademico As String
    Dim carritoSesion As List(Of ElementoAcademico)

    Dim ctaCteUsuarioBusiness As New CtaCteUsuario_Business

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        carritoSesion = Session("carrito")
        If carritoSesion Is Nothing Then
            Response.Redirect(PaginasConocidas.HOME)
        End If
        If Not Page.IsPostBack Then
            CargarCarrito()

            'combo pago
            formaDePagoList.Items.Clear()
            formaDePagoList.Items.Add(New ListItem(idiomas.GetTranslationById(122), "Efectivo"))
            formaDePagoList.Items.Add(New ListItem(idiomas.GetTranslationById(123), "Tarjeta"))
        End If
    End Sub

    Protected Overrides Sub TraducirComponentesDinamicos()

    End Sub

    Private Sub CargarCarrito()
        Me.GridView1_.DataSource = carritoSesion
        Me.GridView1_.DataBind()

        Dim precioTotal As Integer
        For Each elemento In carritoSesion
            precioTotal += elemento.Precio
        Next
        lblPrecio.Text = precioTotal
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
        comprobanteDetalle1.Detalle = carritoSesion(0).Nombre
        comprobanteDetalle1.Cantidad = 1
        comprobanteDetalle1.PrecioUnitario = carritoSesion(0).Precio
        comprobanteDetalle1.Subtotal = carritoSesion(0).Precio 'calcular
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