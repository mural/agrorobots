Imports EE
Imports Business

Public Class AbmComprobantes
    Inherits PaginaAutorizada

    Dim ctaCteUsuarioBusiness As New Business.CtaCteUsuario_Business
    Dim comprobanteBusiness As New Business.Comprobante_Business
    Dim comprobanteNotaBusiness As New Business.ComprobanteNota_Business
    Dim comprobantesHelper As New ComprobantesHelper
    Dim usuarioBusiness As New Usuario_Business

    Dim itemsComprobante As List(Of ComprobanteDetalleGenerico)

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        itemsComprobante = Session("itemsComprobante")
        If itemsComprobante Is Nothing Then
            itemsComprobante = New List(Of ComprobanteDetalleGenerico)
        End If
        If Not (Page.IsPostBack) Then
            CargarMovimientos()
            CargarTipos()
            CargarItems()
            CargarUsuarios()

            comboTipos_SelectedIndexChanged(sender, e)
        End If
    End Sub

    Protected Overrides Sub TraducirComponentesDinamicos()
        CargarMovimientos()
        CargarItems()
        TraducirLoopingControls(Me)
    End Sub

    Private Sub CargarMovimientos()
        Me.GridView1_.DataSource = ctaCteUsuarioBusiness.Listar
        Me.GridView1_.DataBind()
    End Sub


    Private Sub CargarItems()
        Me.GridViewItems.DataSource = itemsComprobante
        Me.GridViewItems.DataBind()
    End Sub

    Private Sub CargarTipos()
        comboTipos.Items.Add(New ListItem("Factura B", "1"))
        comboTipos.Items.Add(New ListItem("Nota de Credito", "2"))
        comboTipos.Items.Add(New ListItem("Nota de Debito", "3"))
    End Sub

    Private Sub CargarUsuarios()
        'cargar combo usuarios
        comboUsuarios.Items.Clear()
        For Each usuarioCombo In usuarioBusiness.ObtenerUsuarios(False)
            If Not usuarioCombo.Admin Then
                comboUsuarios.Items.Add(New ListItem(usuarioCombo.Nombre, usuarioCombo.ID))
            End If
        Next
    End Sub

    Public Function ObtenerTipo(ByVal IDCtaCte As Integer) As String
        Return comprobantesHelper.ObtenerTipo(IDCtaCte)
    End Function

    Public Function ObtenerDetalle(ByVal IDCtaCte As Integer) As String
        Return comprobantesHelper.ObtenerDetalle(IDCtaCte)
    End Function

    Public Function ObtenerMontoTotal(ByVal IDCtaCte As Integer) As String
        Return comprobantesHelper.ObtenerMontoTotal(IDCtaCte)
    End Function

    Protected Sub PDF(ByVal sender As Object, ByVal e As EventArgs)
        Dim link As ImageButton = DirectCast(sender, ImageButton)
        Dim IDCtaCte = CInt(link.CommandArgument)

        comprobantesHelper.PDF(IDCtaCte, Response, Server)
    End Sub

    Protected Sub OnPaging(ByVal sender As Object, ByVal e As GridViewPageEventArgs)
        CargarMovimientos()
        GridView1_.PageIndex = e.NewPageIndex
        GridView1_.DataBind()
        lblMensajes.Text = ""
    End Sub

    Protected Sub btnCrear_32_Click(sender As Object, e As EventArgs) Handles btnCrear_32.Click
        Dim descripcionDeMotivo = areaContenido.InnerText

        Try
            Dim valido = True
            If itemsComprobante.Count = 0 Then
                valido = False
            End If
            If Not Me.comboTipos.SelectedValue = "1" And String.IsNullOrEmpty(descripcionDeMotivo) Then
                valido = False
                lblMensajes.Text = String.Format(idiomas.GetTranslationById(90016), "")
                lblMensajes.CssClass = "formError"
            End If
            If valido Then
                Dim ctacteItemUsuario As New CtaCteItemUsuario
                ctacteItemUsuario.IdUsuario = CInt(comboUsuarios.SelectedValue)

                Dim comprobanteNota = Nothing

                If Me.comboTipos.SelectedValue = "1" Then
                    ctacteItemUsuario.Tipo = 1 'Factura B
                    ctacteItemUsuario.Estado = "NO_PAGO"
                    comprobanteNota = New Comprobante
                    comprobanteNota.Tipo = 1
                    comprobanteNota.Sucursal = 1 'ONLINE
                    comprobanteNota.FechaVencimiento = Date.Today.AddDays(10)
                ElseIf Me.comboTipos.SelectedValue = "2" Then
                    ctacteItemUsuario.Tipo = 2 'Nota de CREDITO
                    ctacteItemUsuario.Estado = "EMITIDA"
                    comprobanteNota = New ComprobanteNota
                    comprobanteNota.Tipo = 2
                    comprobanteNota.Motivo = descripcionDeMotivo
                Else
                    ctacteItemUsuario.Tipo = 3 'Nota de DEBITO
                    ctacteItemUsuario.Estado = "EMITIDA"
                    comprobanteNota = New ComprobanteNota
                    comprobanteNota.Tipo = 3
                    comprobanteNota.Motivo = descripcionDeMotivo
                End If

                comprobanteNota.Numero = comprobanteNotaBusiness.Listar.Count + 1
                comprobanteNota.IdUsuario = CInt(comboUsuarios.SelectedValue)
                comprobanteNota.FechaEmision = Now
                comprobanteNota.Items.AddRange(itemsComprobante)

                Dim subtotal = 0
                For Each elemento As ComprobanteDetalleGenerico In itemsComprobante
                    elemento.ID = 0 'asi los crea
                    subtotal += elemento.PrecioUnitario
                Next
                Dim montoIVA As Decimal = subtotal * 0.20999999999999999 'IVA solo
                comprobanteNota.IVA = montoIVA
                comprobanteNota.Subtotal = subtotal

                ctacteItemUsuario.Comprobante = comprobanteNota
                ctaCteUsuarioBusiness.Crear(ctacteItemUsuario)

                Limpiar()
            End If
        Catch ex As Exception
            MensajeError(lblMensajes)
        End Try

        GridView1_.EditIndex = -1
        CargarMovimientos()
    End Sub

    Private Sub Limpiar()
        areaContenido.InnerText = ""
        lblMensajes.Text = ""
        Session("itemsComprobante") = Nothing
        CargarItems()
    End Sub

    Protected Sub NuevoItem(ByVal sender As Object, ByVal e As EventArgs)
        Dim detalle = Me.txtDetalleItem.Text

        Try
            Dim valido = True
            If String.IsNullOrEmpty(detalle) Then
                valido = False
                lblMensajes.Text = String.Format(idiomas.GetTranslationById(90016), "")
                lblMensajes.CssClass = "formError"
            End If
            If valido Then
                Dim comprobanteDetalle1 = Nothing
                If Me.comboTipos.SelectedValue = "1" Then
                    comprobanteDetalle1 = New ComprobanteDetalle
                Else
                    comprobanteDetalle1 = New ComprobanteNotaDetalle
                End If
                Dim random As New Random
                comprobanteDetalle1.ID = random.Next
                comprobanteDetalle1.CodigoProducto = 1
                comprobanteDetalle1.Detalle = detalle
                comprobanteDetalle1.Cantidad = 1
                comprobanteDetalle1.PrecioUnitario = 1000 'precio sin IVA
                comprobanteDetalle1.Subtotal = comprobanteDetalle1.Cantidad * comprobanteDetalle1.PrecioUnitario
                itemsComprobante.Add(comprobanteDetalle1)
                Session("itemsComprobante") = itemsComprobante
                itemsComprobante = Session("itemsComprobante")

                Me.txtDetalleItem.Text = ""
            End If
        Catch ex As Exception
            MensajeError(lblMensajes)
        End Try

        GridViewItems.EditIndex = -1
        CargarItems()
    End Sub

    Protected Sub Edit(ByVal sender As Object, ByVal e As GridViewEditEventArgs)
        GridViewItems.EditIndex = e.NewEditIndex
        CargarItems()
    End Sub
    Protected Sub CancelEdit(ByVal sender As Object, ByVal e As GridViewCancelEditEventArgs)
        GridViewItems.EditIndex = -1
        CargarItems()
    End Sub
    Protected Sub Update(ByVal sender As Object, ByVal e As GridViewUpdateEventArgs)
        Dim IDItem As String = DirectCast(GridViewItems.Rows(e.RowIndex) _
                             .FindControl("lblID"), Label).Text
        Dim detalleItem As String = DirectCast(GridViewItems.Rows(e.RowIndex) _
                                     .FindControl("txtDetalle"), TextBox).Text
        Dim precioUnitario As String = DirectCast(GridViewItems.Rows(e.RowIndex) _
                             .FindControl("txtPrecioUnitario"), TextBox).Text
        Dim precioUnitarioInt As Integer = 1

        Try
            Dim valido = True
            If String.IsNullOrEmpty(detalleItem) Or String.IsNullOrEmpty(precioUnitario) Then
                valido = False
            End If
            If valido Then
                If Integer.TryParse(precioUnitario, precioUnitarioInt) Then
                    If CInt(precioUnitarioInt) <= 0 Then
                        valido = False
                    End If
                Else
                    valido = False
                End If
            End If
            If valido Then
                'actualizar elemento de sesion
                Dim nuevoItemsDetalle As New List(Of ComprobanteDetalleGenerico)
                For Each elemento As ComprobanteDetalleGenerico In itemsComprobante
                    If elemento.ID = IDItem Then
                        'actualizo datos en este item
                        elemento.CodigoProducto = 1
                        elemento.Detalle = detalleItem
                        elemento.Cantidad = 1
                        elemento.PrecioUnitario = precioUnitarioInt 'precio sin IVA
                        elemento.Subtotal = elemento.Cantidad * elemento.PrecioUnitario
                    End If
                    nuevoItemsDetalle.Add(elemento)
                Next
                Session("itemsComprobante") = nuevoItemsDetalle
                itemsComprobante = Session("itemsComprobante")
            End If
        Catch ex As Exception
            MensajeError(lblMensajes)
        End Try

        GridViewItems.EditIndex = -1
        CargarItems()
    End Sub

    Protected Sub BorrarItem(ByVal sender As Object, ByVal e As EventArgs)
        Dim lnkRemove As LinkButton = DirectCast(sender, LinkButton)
        Dim IDItem = CInt(lnkRemove.CommandArgument)
        'quitar elemento de sesion
        Dim nuevoItemsDetalle As New List(Of ComprobanteDetalleGenerico)
        For Each elemento As ComprobanteDetalleGenerico In itemsComprobante
            If Not elemento.ID = IDItem Then
                nuevoItemsDetalle.Add(elemento)
            End If
        Next
        Session("itemsComprobante") = nuevoItemsDetalle
        itemsComprobante = Session("itemsComprobante")

        GridViewItems.EditIndex = -1
        CargarItems()
    End Sub

    Protected Sub comboTipos_SelectedIndexChanged(sender As Object, e As EventArgs) Handles comboTipos.SelectedIndexChanged
        desc_185.Visible = False
        areaContenido.Visible = False

        If Me.comboTipos.SelectedValue = "1" Then
            desc_185.Visible = False
            areaContenido.Visible = False
        ElseIf Me.comboTipos.SelectedValue = "2" Then
            desc_185.Visible = True
            areaContenido.Visible = True
        Else 'nota de debito
            desc_185.Visible = True
            areaContenido.Visible = True
        End If
    End Sub
End Class