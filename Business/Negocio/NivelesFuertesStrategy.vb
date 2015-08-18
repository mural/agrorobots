Imports MPP
Imports EE

Public Class NivelesFuertesStrategy
    Implements NivelesStrategy

    Private Const MIN = 3.2

    Public Function obtenerNiveles() As List(Of Nivel) Implements NivelesStrategy.obtenerNiveles
        Dim dataNivel As New Nivel_Data
        Dim nivelesFuertes As New List(Of Nivel)
        For Each nivel As Nivel In dataNivel.ObtenerNivelesDeCapacidades
            If nivel.Nivel > MIN Then
                nivelesFuertes.Add(nivel)
            End If
        Next

        Return nivelesFuertes
    End Function
End Class
