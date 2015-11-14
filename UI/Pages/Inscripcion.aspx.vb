Imports EE
Imports Business
Imports System.Net

Public Class Inscripcion
    Inherits PaginaAutorizada

    Dim tarjetaBusiness As New Tarjeta_Business
    Dim elementoAcademicoBusiness As New ElementoAcademico_Business
    Dim carritoSesion As List(Of ElementoAcademico)
    Dim ctaCteUsuarioBusiness As New CtaCteUsuario_Business
    Dim comprobanteBusiness As New Comprobante_Business
    Dim comprobanteNotaBusiness As New ComprobanteNota_Business

    Public Shared Property NumeroTarjetaGuardada As String = ""
    Public Shared Property NombreTarjetaGuardada As String = ""
    Public Shared Property FechaTarjetaGuardada As String = ""

    Dim precioTotal As Integer
    Dim notaCreditoAccion As String

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        carritoSesion = Session("carrito")
        If carritoSesion Is Nothing Then
            Response.Redirect(PaginasConocidas.HOME)
        End If
        For Each elemento In carritoSesion
            precioTotal += elemento.Precio
        Next
        If Not Page.IsPostBack Then
            CargarCarrito()

            'combo pago
            formaDePagoList.Items.Clear()
            formaDePagoList.Items.Add(New ListItem(" " + idiomas.GetTranslationById(122), "Efectivo"))
            formaDePagoList.Items.Add(New ListItem(" " + idiomas.GetTranslationById(123), "Tarjeta"))
            formaDePagoList.Items.Add(New ListItem(" " + idiomas.GetTranslationById(188), "NotaCredito"))
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

            'combo notas de credito
            comboNotasCredito.Items.Clear()
            For Each notaCredito In comprobanteNotaBusiness.Listar
                comboNotasCredito.Items.Add(New ListItem(Helper.StripTags(notaCredito.Motivo) + ": $" + CStr((notaCredito.Subtotal + notaCredito.IVA)), notaCredito.ID))
            Next
        End If
    End Sub

    Protected Overrides Sub TraducirComponentesDinamicos()

    End Sub

    Private Sub CargarCarrito()
        Me.GridView1_.DataSource = carritoSesion
        Me.GridView1_.DataBind()
        lblPrecio.Text = precioTotal.ToString
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

        Dim montoIVA = subtotal * 0.20999999999999999 'IVA solo
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
        notaCreditoEstado.Text = ""
        comboNotasCredito.Enabled = False

        If formaDePagoList.SelectedValue.Equals("Efectivo") Then
            'a pagar
        ElseIf formaDePagoList.SelectedValue.Equals("Tarjeta") Then
            'tarjeta
        ElseIf formaDePagoList.SelectedValue.Equals("NotaCredito") Then
            comboNotasCredito.Enabled = True
            comboNotasCredito_SelectedIndexChanged(sender, e)
        End If
    End Sub

    Protected Sub comboNotasCredito_SelectedIndexChanged(sender As Object, e As EventArgs) Handles comboNotasCredito.SelectedIndexChanged
        Dim notaSeleccionada = comprobanteNotaBusiness.Obtener(comboNotasCredito.SelectedValue)
        Dim valorNota = (notaSeleccionada.Subtotal + notaSeleccionada.IVA)
        If valorNota > precioTotal Then 'sobra para pagar
            notaCreditoEstado.Text = "El monto sobrante quedara para su uso."
            notaCreditoAccion = "SOBRA"
        ElseIf valorNota = precioTotal Then 'alcanza justo para pagar
            notaCreditoEstado.Text = "Alcanza justo para pagar."
            notaCreditoAccion = "JUSTO"
        ElseIf valorNota < precioTotal Then 'no alcanza para pagar
            notaCreditoEstado.Text = "No alcanza para pagar, complete los datos de la tarjeta de credito por el monto faltante."
            notaCreditoAccion = "MENOR"
        End If
    End Sub
End Class