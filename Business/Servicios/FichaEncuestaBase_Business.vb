Imports EE
Imports MPP

Public Class FichaEncuestaBase_Business
    Inherits Business(Of FichaEncuestaBase)

    Sub New()
        Me.mapperGenerico = New FichaEncuestaBase_Mapper
    End Sub

    Public Function ListarEncuestas(activa As Boolean) As List(Of FichaEncuestaBase)
        Dim encuestas = New List(Of FichaEncuestaBase)
        Dim fechaHoy = Date.Now
        For Each encuesta In mapperGenerico.Listar()
            If encuesta.Tipo.Equals("E") And fechaHoy > encuesta.FechaInicio And fechaHoy < encuesta.FechaFin Then
                If activa And encuesta.Activa = True Then
                    encuestas.Add(encuesta)
                ElseIf Not activa Then
                    encuestas.Add(encuesta)
                End If
            End If
        Next
        Return encuestas
    End Function

    Public Function ListarFichas(activa As Boolean) As List(Of FichaEncuestaBase)
        Dim fichas = New List(Of FichaEncuestaBase)
        Dim fechaHoy = Date.Now
        For Each ficha In mapperGenerico.Listar()
            If ficha.Tipo.Equals("F") And fechaHoy > ficha.FechaInicio And fechaHoy < ficha.FechaFin Then
                If activa And ficha.Activa = True Then
                    fichas.Add(ficha)
                ElseIf Not activa Then
                    fichas.Add(ficha)
                End If
            End If
        Next
        Return fichas
    End Function

End Class
