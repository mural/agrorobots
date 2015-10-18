Imports EE
Imports MPP

Public Class FichaEncuestaBase_Business
    Inherits Business(Of FichaEncuestaBase)

    Sub New()
        Me.mapperGenerico = New FichaEncuestaBase_Mapper
    End Sub

    Public Function ListarEncuestas() As List(Of FichaEncuestaBase)
        Dim fichas = New List(Of FichaEncuestaBase)
        For Each ficha In mapperGenerico.Listar()
            If ficha.Tipo.Equals("E") Then
                fichas.Add(ficha)
            End If
        Next
        Return fichas
    End Function

    Public Function ListarFichas() As List(Of FichaEncuestaBase)
        Dim fichas = New List(Of FichaEncuestaBase)
        For Each ficha In mapperGenerico.Listar()
            If ficha.Tipo.Equals("F") Then
                fichas.Add(ficha)
            End If
        Next
        Return fichas
    End Function

End Class
