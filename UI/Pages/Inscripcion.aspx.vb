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
    Dim notaCreditoAccion As String = ""

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        carritoSesion = Session("carrito")
        If carritoSesion Is Nothing Then
            Response.Redirect(PaginasConocidas.HOME)
        End If

        notaCreditoEstado.Text = ""
        notaCreditoAccion = Session("notaCreditoAccion")
        If notaCreditoAccion Is Nothing Then
            notaCreditoAccion = ""
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
            For Each notaCredito In comprobanteNotaBusiness.ListarNotasDeCreditoNoSaldadasPorUsuario(usuario.ID)
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
        Try
            Dim valido = True
            If formaDePagoList.SelectedValue.Equals("Efectivo") Or (formaDePagoList.SelectedValue.Equals("NotaCredito") And Not notaCreditoAccion.Equals("NO_ALCANZA")) Then
                'no se valida tarjeta
                If formaDePagoList.SelectedValue.Equals("NotaCredito") And notaCreditoAccion.Equals("") Then
                    valido = False
                End If
            Else
                'valido datos de tarjeta
                valido = ValidarTrjeta.IsValidNumber(inputNumeroTarjetaHidden.Value) 'numero
                If valido Then
                    'nombre
                    valido = Validaciones.EsSoloLetras(inputNombreTarjetaHidden.Value)
                End If
                If valido Then
                    'fecha vto
                    Try
                        Dim fecha = Date.ParseExact(inputVtoTarjetaHidden.Value, "MM / yyyy", Nothing)
                        If valido And (fecha < Date.Now Or fecha > Date.Now.AddYears(25)) Then
                            valido = False
                        End If
                    Catch ex As Exception
                        valido = False
                    End Try
                End If
                If valido Then
                    'codigo
                    valido = Validaciones.EsSoloNumeros(inputCodTarjetaHidden.Value)
                End If
            End If

            If valido Then
                Dim ctacteItemUsuario As New CtaCteItemUsuario
                ctacteItemUsuario.IdUsuario = usuario.ID
                Dim estado = "PAGO" 'tarjeta o nota de credito
                If formaDePagoList.SelectedValue.Equals("Efectivo") Then
                    estado = "NO_PAGO"
                ElseIf formaDePagoList.SelectedValue.Equals("Tarjeta") Or notaCreditoAccion.Equals("NO_ALCANZA") Then
                    'tarjeta
                    Dim tarjeta As New Tarjeta
                    tarjeta.IdUsuario = usuario.ID
                    tarjeta.Tipo = UCase(inputTipoTarjetaHidden.Value)
                    tarjeta.Numero = inputNumeroTarjetaHidden.Value
                    tarjeta.Nombre = inputNombreTarjetaHidden.Value
                    tarjeta.Expiracion = inputVtoTarjetaHidden.Value
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

                    If formaDePagoList.SelectedValue.Equals("NotaCredito") Then
                        If notaCreditoAccion.Equals("SOBRA") Then
                            'actualizo el valor de la nota de credito
                            Dim comprobanteNotaCredito = comprobanteNotaBusiness.Obtener(comboNotasCredito.SelectedValue)
                            comprobanteNotaCredito.Motivo = comprobanteNotaCredito.Motivo + " (-)"

                            Dim nuevoTotal = comprobanteNotaCredito.Subtotal + comprobanteNotaCredito.IVA - precioTotal

                            Dim comprobanteDetalle1 As New ComprobanteNotaDetalle
                            comprobanteDetalle1.IdComprobanteNota = comprobanteNotaCredito.ID
                            comprobanteDetalle1.CodigoProducto = 0
                            comprobanteDetalle1.Detalle = "Descuento pago"
                            comprobanteDetalle1.Cantidad = 1 'a un solo curso por vez
                            comprobanteDetalle1.PrecioUnitario = -(precioTotal / 1.21) 'total menos IVA
                            comprobanteDetalle1.Subtotal = -(precioTotal / 1.21) 'total menos IVA
                            comprobanteNotaCredito.Items.Add(comprobanteDetalle1)

                            comprobanteNotaCredito.Subtotal = nuevoTotal / 1.21 'total menos IVA
                            comprobanteNotaCredito.IVA = comprobanteNotaCredito.Subtotal * 0.20999999999999999
                            comprobanteNotaBusiness.Actualizar(comprobanteNotaCredito)
                        ElseIf notaCreditoAccion.Equals("JUSTO") Then
                            'actualizo el estado de la nota de credito en la cuenta corriente
                            Dim cuentaCte = ctaCteUsuarioBusiness.ObtenerPorUsuarioYComprobante(usuario.ID, comboNotasCredito.SelectedValue)
                            cuentaCte.Estado = "SALDADA"
                            ctaCteUsuarioBusiness.Actualizar(cuentaCte)
                        End If
                    End If

                    'vaciar carrito
                    Dim nuevoCarrito As New List(Of ElementoAcademico)
                    Session("carrito") = nuevoCarrito

                    Response.Redirect(PaginasConocidas.INSCRIPTO_CALIFICAR)
                Else
                    MensajeError(lblMensajes)
                End If

            Else 'tarjeta NO valida 
                MensajeError(lblMensajes, "Tarjeta no valida")
                formaDePagoList.SelectedIndex = 1 'tarjeta
            End If
        Catch ex As Exception
            MensajeError(lblMensajes)
            formaDePagoList.SelectedIndex = 1 'tarjeta
        End Try
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
        If Not comboNotasCredito.SelectedValue.Equals("") Then
            Dim notaSeleccionada = comprobanteNotaBusiness.Obtener(comboNotasCredito.SelectedValue)
            Dim valorNota = (notaSeleccionada.Subtotal + notaSeleccionada.IVA)
            If valorNota > precioTotal Then 'sobra para pagar
                notaCreditoEstado.Text = "El monto sobrante quedara para su posterior uso."
                notaCreditoAccion = "SOBRA"
            ElseIf valorNota = precioTotal Then 'alcanza justo para pagar
                notaCreditoEstado.Text = "Alcanza justo para pagar."
                notaCreditoAccion = "JUSTO"
            ElseIf valorNota < precioTotal Then 'no alcanza para pagar
                notaCreditoEstado.Text = "No alcanza para pagar, complete los datos de la tarjeta de credito por el monto faltante de $" + CStr(precioTotal - valorNota)
                notaCreditoAccion = "NO_ALCANZA"
            End If
            Session("notaCreditoAccion") = notaCreditoAccion
        Else
            notaCreditoEstado.Text = "No dispone de una Nota de Credito para utilizar."
        End If
    End Sub
End Class