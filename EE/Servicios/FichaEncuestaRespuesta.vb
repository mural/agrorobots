Public Class FichaEncuestaRespuesta

    Public Property ID As Integer '(int, not null)
    Public Property IDFichaEncuesta As Integer '(int, not null)
    Public Property IDPregunta As Integer '(int, not null)
    Public Property Respuesta As String '(varchar(max), null)
End Class
