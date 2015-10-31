Public Class Examen
    Public Property ID As Integer '(int, not null)
    Public Property IdExamenBase As Integer '(int, null)
    Public Property Fecha As DateTime '(date, null)
    Public Property IdAlumno As Integer '(int, null)
    Public Property Nota As Decimal '(decimal(2,0), null)

    Public Property Respuestas As List(Of ExamenRespuesta)

    Sub New()
        Respuestas = New List(Of ExamenRespuesta)
    End Sub
End Class
