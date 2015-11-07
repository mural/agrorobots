Imports EE
Imports MPP

Public Class Novedades_Business
    Inherits Business(Of Novedades)

    Sub New()
        Me.mapperGenerico = New Novedades_Mapper
    End Sub

    Public Overrides Function Listar() As List(Of Novedades)
        Dim listaNovedades As New List(Of Novedades)
        Dim fechaHoy = Date.Now
        For Each novedad In mapperGenerico.Listar()
            If fechaHoy > novedad.FechaInicio And fechaHoy < novedad.FechaFin Then
                listaNovedades.Add(novedad)
            End If
        Next
        Return listaNovedades
    End Function

End Class
