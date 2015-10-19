Public Class FichaEncuesta

    Public Property ID As Integer '(int, not null)
    Public Property IDFichaEncuestaBase As Integer '(int, not null)
    Public Property Fecha As DateTime '(datetime, null)
    Public Property Usuario As String '(int, null)
    Public Property Email As String '(varchar(50), null)
    Public Property Sesion As String '(varchar(max), null)
    Public Property RespuestaUnica As String '(varchar(max), null)

    Public Property Respuestas As List(Of FichaEncuestaRespuesta)

    Sub New()
        Respuestas = New List(Of FichaEncuestaRespuesta)
    End Sub

End Class

