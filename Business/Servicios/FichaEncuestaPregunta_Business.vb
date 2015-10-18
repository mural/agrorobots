Imports EE
Imports MPP

Public Class FichaEncuestaPregunta_Business
    Inherits Business(Of FichaEncuestaPregunta)

    Sub New()
        Me.mapperGenerico = New FichaEncuestaPregunta_Mapper
    End Sub

    Public Function ListarPorFicha(ByVal idFicha As Integer) As List(Of FichaEncuestaPregunta)
        Dim preguntas = New List(Of FichaEncuestaPregunta)
        For Each pregunta In mapperGenerico.Listar()
            If pregunta.IDFichaEncuestaBase = idFicha Then
                preguntas.Add(pregunta)
            End If
        Next
        Return preguntas
    End Function

End Class
