Public Class Foro
    Public Property ID As Integer '(int, not null)
    Public Property IdElementoAcademico As Integer '(int, null)
    Public Property IdUsuario As Integer '(int, null)
    Public Property Fecha As DateTime '(datetime, null)
    Public Property Comentario As String '(varchar(255), null)
    Public Property EsProfesor As Boolean '(bit, null)

    Public Property Usuario As Usuario 
End Class
