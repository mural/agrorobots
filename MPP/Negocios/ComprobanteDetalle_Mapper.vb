Imports EE

Public Class ComprobanteDetalle_Mapper
    Inherits Mapper(Of ComprobanteDetalle)

    Public Sub New()
    End Sub

    Public Overrides Sub OBJaHASH(ByRef obj As ComprobanteDetalle, ByRef Item As Hashtable)
        hdatos.Add("@ID", obj.ID)
        hdatos.Add("@IdComprobante", obj.IdComprobante)
        hdatos.Add("@CodigoProducto", obj.CodigoProducto)
        hdatos.Add("@Detalle", obj.Detalle)
        hdatos.Add("@Cantidad", obj.Cantidad)
        hdatos.Add("@PrecioUnitario", obj.PrecioUnitario)
        hdatos.Add("@Subtotal", obj.Subtotal)
    End Sub

    Public Overrides Function Actualizar(ByRef obj As ComprobanteDetalle, Optional ByVal insertar As Boolean = False) As Boolean
        Return Actualizar(obj, "ComprobanteDetalleActualizar")
    End Function

    Public Overrides Sub DSaEE(ByRef objNuevo As ComprobanteDetalle, ByRef Item As DataRow)
        objNuevo.ID = CInt(Item("ID"))
        objNuevo.IdComprobante = CInt(Item("IdComprobante"))
        objNuevo.CodigoProducto = CInt(Item("CodigoProducto"))
        objNuevo.Detalle = CStr(Item("Detalle"))
        objNuevo.Cantidad = CInt(Item("Cantidad"))
        objNuevo.PrecioUnitario = CDec(Item("PrecioUnitario"))
        objNuevo.Subtotal = CDec(Item("Subtotal"))
    End Sub

    Public Overrides Function Obtener(ByVal codigoAcademico As Integer) As ComprobanteDetalle
        Return Obtener(codigoAcademico, "ComprobanteDetalleObtener")
    End Function

    Public Overrides Function Listar() As List(Of ComprobanteDetalle)
        Return Listar("ComprobanteDetalleListar")
    End Function

    Public Overloads Overrides Function Borrar(id As Integer) As Boolean
        Return Borrar(id, "ComprobanteDetalleBorrar")
    End Function
End Class
