﻿Public Class ComprobanteDetalleGenerico

    Public Property ID As Integer '(int, not null)
    Public Property CodigoProducto As Integer '(int, null)
    Public Property Detalle As String '(varchar(max), null)
    Public Property Cantidad As Integer '(int, null)
    Public Property PrecioUnitario As Decimal '(decimal(18,2), null)
    Public Property Subtotal As Decimal '(decimal(18,2), null)
End Class
