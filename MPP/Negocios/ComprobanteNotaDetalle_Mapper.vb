Imports EE

Public Class ComprobanteNotaDetalle_Mapper

    Inherits Mapper(Of ComprobanteNotaDetalle)

    Public Sub New()
    End Sub

    Public Overrides Sub OBJaHASH(ByRef obj As ComprobanteNotaDetalle, ByRef Item As Hashtable)
        hdatos.Add("@ID", obj.ID)
        hdatos.Add("@IdComprobanteNota", obj.IdComprobanteNota)
        hdatos.Add("@CodigoProducto", obj.CodigoProducto)
        hdatos.Add("@Detalle", obj.Detalle)
        hdatos.Add("@Cantidad", obj.Cantidad)
        hdatos.Add("@PrecioUnitario", obj.PrecioUnitario)
        hdatos.Add("@Subtotal", obj.Subtotal)
    End Sub

    Public Overrides Function Actualizar(ByRef obj As ComprobanteNotaDetalle, Optional ByVal insertar As Boolean = False) As Boolean
        Return Actualizar(obj, "ComprobanteNotaDetalleActualizar")
    End Function

    Public Overrides Sub DSaEE(ByRef objNuevo As ComprobanteNotaDetalle, ByRef Item As DataRow)
        objNuevo.ID = CInt(Item("ID"))
        objNuevo.IdComprobanteNota = CInt(Item("IdComprobanteNota"))
        objNuevo.CodigoProducto = CInt(Item("CodigoProducto"))
        objNuevo.Detalle = CStr(Item("Detalle"))
        objNuevo.Cantidad = CInt(Item("Cantidad"))
        objNuevo.PrecioUnitario = CDec(Item("PrecioUnitario"))
        objNuevo.Subtotal = CDec(Item("Subtotal"))
    End Sub

    Public Overrides Function Obtener(ByVal codigoAcademico As Integer) As ComprobanteNotaDetalle
        Return Obtener(codigoAcademico, "ComprobanteNotaDetalleObtener")
    End Function

    Public Overrides Function Listar() As List(Of ComprobanteNotaDetalle)
        Return Listar("ComprobanteNotaDetalleListar")
    End Function

    Public Overloads Overrides Function Borrar(id As Integer) As Boolean
        Return Borrar(id, "ComprobanteNotaDetalleBorrar")
    End Function
End Class
