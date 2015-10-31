Public Class Comentario

    Public Property ID As Integer '(int, not null)
    Public Property IdUsuario As Integer '(int, null)
    Public Property IdElementoAcademico As Integer '(int, null)
    Public Property Comentario As String '(varchar(255), null)
    Public Property Fecha As DateTime '(datetime, null)

    Public Property Usuario As Usuario '(int, null)

End Class
