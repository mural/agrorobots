Imports EE
Imports Business

Public Class Inscripcion
    Inherits PaginaAutorizada

    Dim tarjetaBusiness As New Tarjeta_Business
    Dim elementoAcademicoBusiness As New ElementoAcademico_Business
    Dim carritoSesion As List(Of ElementoAcademico)
    Dim ctaCteUsuarioBusiness As New CtaCteUsuario_Business
    Dim comprobanteBusiness As New Comprobante_Business

    Public Shared Property NumeroTarjetaGuardada As String = ""
    Public Shared Property NombreTarjetaGuardada As String = ""
    Public Shared Property FechaTarjetaGuardada As String = ""

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
            formaDePagoList.SelectedIndex = 1 'tarjeta

            'tarjeta guardada ?
            If Not tarjetaBusiness.ObtenerTarjetaDeUsuario(usuario.ID) Is Nothing Then
                Dim tarjeta = tarjetaBusiness.ObtenerTarjetaDeUsuario(usuario.ID)
                NumeroTarjetaGuardada = tarjeta.Numero
                NombreTarjetaGuardada = tarjeta.Nombre
                FechaTarjetaGuardada = CStr(tarjeta.Expiracion.Month) + " / " + CStr(tarjeta.Expiracion.Year)
            Else
                NumeroTarjetaGuardada = ""
                NombreTarjetaGuardada = ""
                FechaTarjetaGuardada = ""
            End If
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
        Else
            'tarjeta
            Dim tarjeta As New Tarjeta
            tarjeta.IdUsuario = usuario.ID
            tarjeta.Tipo = UCase(inputTipoTarjetaHidden.Value)
            tarjeta.Numero = inputNumeroTarjetaHidden.Value
            tarjeta.Nombre = inputNombreTarjetaHidden.Value
            'tarjeta.Expiracion = inputVtoTarjetaHidden.Value
            tarjeta.Expiracion = Now
            If cbxGuardarTarjeta.Checked Then
                tarjetaBusiness.GuardarTarjeta(tarjeta)
            Else
                tarjetaBusiness.BorrarPorUsuario(usuario.ID)
            End If
        End If
        ctacteItemUsuario.Tipo = 1 'Factura B
        ctacteItemUsuario.Estado = estado

        Dim comprobante As New Comprobante
        comprobante.Numero = comprobanteBusiness.Listar.Count + 1
        comprobante.Sucursal = 1 'ONLINE
        comprobante.Tipo = 1 'B
        comprobante.IdUsuario = usuario.ID
        comprobante.FechaEmision = Now
        comprobante.FechaVencimiento = Date.Today.AddDays(10)
        Dim subtotal As Decimal = 0

        For Each elementoAcademico As ElementoAcademico In carritoSesion
            elementoAcademicoBusiness.Inscribir(usuario.ID, elementoAcademico.CodigoAcademico, estado = "PAGO")
            usuario.ElementosAcademicos = elementoAcademicoBusiness.ObtenerPorAlumno(usuario.ID)

            Dim comprobanteDetalle1 As New ComprobanteDetalle
            comprobanteDetalle1.CodigoProducto = elementoAcademico.CodigoAcademico
            comprobanteDetalle1.Detalle = elementoAcademico.Nombre
            comprobanteDetalle1.Cantidad = 1 'a un solo curso por vez
            Dim precioSinIVA = elementoAcademico.Precio / 1.21 'precio menos IVA
            comprobanteDetalle1.PrecioUnitario = precioSinIVA
            comprobanteDetalle1.Subtotal = precioSinIVA
            subtotal += precioSinIVA 'sumo los precios sin IVA

            comprobante.Items.Add(comprobanteDetalle1)
        Next

        ActualizarUsuarioEnSesion(usuario)

        Dim montoIVA = subtotal * 0.21 'IVA solo
        comprobante.IVA = montoIVA
        comprobante.Subtotal = subtotal
        ctacteItemUsuario.Comprobante = comprobante

        If ctaCteUsuarioBusiness.Crear(ctacteItemUsuario) Then
            MensajeOk(lblMensajes)

            'vaciar carrito
            Dim nuevoCarrito As New List(Of ElementoAcademico)
            Session("carrito") = nuevoCarrito

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