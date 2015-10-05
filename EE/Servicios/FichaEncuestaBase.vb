Public Class FichaEncuestaBase

    Public Property ID As Integer '(int, not null)
    Public Property Foto() As Byte '(image, null)
    Public Property Tipo As String '(varchar(10), null)
    Public Property Descripcion As String '(varchar(max), null)
End Class
