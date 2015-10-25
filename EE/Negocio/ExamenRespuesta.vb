Public Class ExamenRespuesta
    Public Property ID As Integer '(int, not null)
    Public Property IdPregunta As Integer '(int, null)
    Public Property IdExamen As Integer '(int, null)
    Public Property IdOpcion As Integer '(int, null)
    Public Property Respuesta As String '(varchar(255), null)
End Class
