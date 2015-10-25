Public Class ExamenBasePregunta

    Public Property ID As Integer '(int, not null)
    Public Property IdExamenBase As Integer '(int, null)
    Public Property Pregunta As String '(varchar(255), null)

    Public Property Opciones As List(Of ExamenBasePreguntaOpcion)

    Sub New()
        Opciones = New List(Of ExamenBasePreguntaOpcion)
    End Sub
End Class

