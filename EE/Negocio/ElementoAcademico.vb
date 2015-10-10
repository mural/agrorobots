Public Class ElementoAcademico
    Public Property CodigoAcademico As Integer '(int, not null)
    Public Property Comentario As String '(varchar(255), null)
    Public Property Contenido As String '(varchar(255), null)
    Public Property CriteriosAprobacion As String '(varchar(255), null)
    Public Property Descripcion As String '(varchar(255), null)
    Public Property Duracion As Integer '(int, null)
    Public Property FechaInicio As DateTime '(date, null)
    Public Property Nombre As String '(varchar(100), null)
    Public Property Temas As String '(varchar(255), null)
    Public Property Cupo As Integer '(int, null)
    Public Property Clases As Integer '(int, null)
    Public Property Precio As Decimal '(decimal(18,2), null)
    Public Property Imagen() As Byte()

End Class
