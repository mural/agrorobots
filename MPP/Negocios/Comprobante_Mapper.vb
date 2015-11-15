Imports EE

Public Class Comprobante_Mapper
    Inherits Mapper(Of Comprobante)

    Dim usuarioMapper As New Usuario_Data
    Dim comprobanteDetalleMapper As New ComprobanteDetalle_Mapper
    Public Property IdComprobante As Integer

    Public Sub New()
    End Sub

    Public Overrides Function Insertar(ByRef obj As Comprobante) As Boolean
        Preparar()

        Me.Transaccion = AccionTransaccion.Iniciar
        Dim resultado = Actualizar(obj, True)
        IdComprobante = oDatos.RespuestaEscritura

        If resultado Then 'si salio bien la escritura anterior
            comprobanteDetalleMapper.Transaccion = AccionTransaccion.Continuar
            For i = 0 To obj.Items.Count - 1
                Dim itemDetalle As ComprobanteDetalle = obj.Items(i)
                itemDetalle.IdComprobante = IdComprobante
                If i = obj.Items.Count - 1 Then
                    comprobanteDetalleMapper.Transaccion = AccionTransaccion.Cerrar
                End If
                resultado = comprobanteDetalleMapper.Insertar(itemDetalle)
            Next
        End If
        Return resultado
    End Function

    Public Overrides Sub OBJaHASH(ByRef obj As Comprobante, ByRef Item As Hashtable)
        hdatos.Add("@ID", obj.ID)
        hdatos.Add("@Numero", obj.Numero)
        hdatos.Add("@Sucursal", obj.Sucursal)
        hdatos.Add("@Tipo", obj.Tipo)
        hdatos.Add("@IdUsuario", obj.IdUsuario)
        hdatos.Add("@FechaEmision", obj.FechaEmision)
        hdatos.Add("@FechaVencimiento", obj.FechaVencimiento)
        hdatos.Add("@Subtotal", obj.Subtotal)
        hdatos.Add("@IVA", obj.IVA)
    End Sub

    Public Overrides Function Actualizar(ByRef obj As Comprobante, Optional ByVal insertar As Boolean = False) As Boolean
        Return Actualizar(obj, "ComprobanteActualizar")
    End Function

    Public Overrides Sub DSaEE(ByRef objNuevo As Comprobante, ByRef Item As DataRow)
        objNuevo.ID = CInt(Item("ID"))
        objNuevo.Numero = CInt(Item("Numero"))
        objNuevo.Sucursal = CInt(Item("Sucursal"))
        objNuevo.Tipo = CStr(Item("Tipo"))
        objNuevo.IdUsuario = CInt(Item("IdUsuario"))
        objNuevo.FechaEmision = CDate(Item("FechaEmision"))
        objNuevo.FechaVencimiento = CDate(Item("FechaVencimiento"))
        objNuevo.Subtotal = CDec(Item("Subtotal"))
        objNuevo.IVA = CDec(Item("IVA"))
    End Sub

    Public Overrides Function Obtener(ByVal idComprobante As Integer) As Comprobante
        Dim comprobante As Comprobante = Obtener(idComprobante, "ComprobanteObtener")
        Try
            For Each comprobanteDetalle In comprobanteDetalleMapper.Listar
                If comprobanteDetalle.IdComprobante = idComprobante Then
                    comprobante.Items.Add(comprobanteDetalle)
                End If
            Next
            comprobante.Usuario = usuarioMapper.ConsultarPorId(comprobante.IdUsuario)
        Catch ex As Exception
            ex.ToString()
        End Try
        Return comprobante
    End Function

    Public Overrides Function Listar() As List(Of Comprobante)
        Return Listar("ComprobanteListar")
    End Function

    Public Overloads Overrides Function Borrar(id As Integer) As Boolean
        Return Borrar(id, "ComprobanteBorrar")
    End Function
End Class
