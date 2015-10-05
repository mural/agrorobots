Public Class FichaEncuesta

    Public Property ID As Integer '(int, not null)
    Public Property IDFichaEncuestaBase As Integer '(int, not null)
    Public Property Fecha As DateTime '(datetime, null)
    Public Property Usuario As Integer '(int, null)
    Public Property Email As String '(varchar(50), null)
    Public Property Sesion As String '(varchar(max), null)
    Public Property RespuestaUnica As String '(varchar(max), null)
End Class

