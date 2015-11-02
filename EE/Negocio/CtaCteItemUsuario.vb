Public Class CtaCteItemUsuario

    Public Property ID As Integer '(int, not null)
    Public Property IdUsuario As Integer '(int, null)
    Public Property IdComprobante As Integer '(int, null)
    Public Property Tipo As Integer '(int, null)
    Public Property Estado As String '(varchar(50), null)
    Public Property Comprobante As ComprobanteGenerico
    Public Property Usuario As Usuario
End Class
