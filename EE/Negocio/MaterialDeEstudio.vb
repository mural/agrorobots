Public Class MaterialDeEstudio

    Public Property ID As Integer
    Public Property IdElementoAcademico As Integer
    Public Property Tipo As String '(varchar(50), null)
    Public Property Detalle As String '(varchar(50), null)
    Public Property Contenido As String '(varchar(max), null)
    Public Property Activo As Boolean '(bit, null)
    Public Property FechaMaxVisita As Date
End Class
