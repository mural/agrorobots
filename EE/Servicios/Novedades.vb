Public Class Novedades
    Public Property ID As Integer '(int, not null)
    Public Property Texto As String '(varchar(max), null)
    Public Property Foto() As Byte() '(image, null)
    Public Property Fecha As DateTime '(datetime, null)
    Public Property IDCategoriaTema As Integer '(int, null)
    Public Property FechaInicio As Date
    Public Property FechaFin As Date

End Class
