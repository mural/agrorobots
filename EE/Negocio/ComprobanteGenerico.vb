
Public Class ComprobanteGenerico
    Public Property ID As Integer '(int, not null)
    Public Property Numero As Integer '(int, null)
    Public Property Tipo As Integer '(int, null)
    Public Property IdUsuario As Integer '(int, null)
    Public Property FechaEmision As DateTime '(date, null)
    Public Property Subtotal As Decimal '(decimal(18,2), null)
    Public Property IVA As Decimal '(decimal(18,2), null)
    Public Property Items As List(Of ComprobanteDetalle)

    Public Sub New()
        Me.Items = New List(Of ComprobanteDetalle)
    End Sub
End Class
