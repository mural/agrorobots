﻿
Public Class ComprobanteGenerico
    Public Property ID As Integer '(int, not null)
    Public Property Numero As Integer '(int, null)
    Public Property Tipo As Integer '(int, null)
    Public Property IdUsuario As Integer '(int, null)
    Public Property FechaEmision As Date '(date, null)
    Public Property Subtotal As Decimal '(decimal(18,2), null)
    Public Property IVA As Decimal '(decimal(18,2), null)
    Public Property Items As List(Of ComprobanteDetalleGenerico)
    Public Property Usuario As Usuario

    Public ReadOnly Property Total As Decimal
        Get
            Return Subtotal + IVA
        End Get
    End Property

    Public Sub New()
        Me.Items = New List(Of ComprobanteDetalleGenerico)
    End Sub
End Class
