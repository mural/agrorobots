Public Class ExamenBase

    Public Property ID As Integer '(int, not null)
    Public Property IdElementoAcademico As Integer '(int, null)
    Public Property Detalle As String '(varchar(255), null)
    Public Property Tipo As String '(varchar(50), null)
    Public Property Activo As Boolean '(bit, null)

    Public Property Preguntas As List(Of ExamenBasePregunta)

    Sub New()
        Preguntas = New List(Of ExamenBasePregunta)
    End Sub
End Class
