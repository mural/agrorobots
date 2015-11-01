Imports EE
Imports MPP

Public Class FichaEncuestaPregunta_Business
    Inherits Business(Of FichaEncuestaPregunta)

    Sub New()
        Me.mapperGenerico = New FichaEncuestaPregunta_Mapper
    End Sub

    Public Function ListarPorBase(ByVal idBase As Integer) As List(Of FichaEncuestaPregunta)
        Dim preguntas = New List(Of FichaEncuestaPregunta)
        For Each pregunta In mapperGenerico.Listar()
            If pregunta.IDFichaEncuestaBase = idBase Then
                preguntas.Add(pregunta)
            End If
        Next
        Return preguntas
    End Function

End Class
