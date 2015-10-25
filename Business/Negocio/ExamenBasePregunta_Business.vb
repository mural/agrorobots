Imports EE
Imports MPP

Public Class ExamenBasePregunta_Business
    Inherits Business(Of ExamenBasePregunta)

    Sub New()
        Me.mapperGenerico = New ExamenBasePregunta_Mapper
    End Sub

    Public Function ListarPorExamen(ByVal idExamen As Integer) As List(Of ExamenBasePregunta)
        Dim preguntas = New List(Of ExamenBasePregunta)
        For Each pregunta In mapperGenerico.Listar()
            If pregunta.IdExamenBase = idExamen Then
                preguntas.Add(pregunta)
            End If
        Next
        Return preguntas
    End Function

End Class
