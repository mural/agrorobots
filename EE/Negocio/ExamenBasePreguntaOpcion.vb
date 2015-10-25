Public Class ExamenBasePreguntaOpcion
    Public Property Id As Integer '(int, not null)
    Public Property IdExamenBasePregunta As Integer '(int, null)
    Public Property Opcion As String '(varchar(255), null)
    Public Property Correcta As Boolean '(bit, null)
End Class

