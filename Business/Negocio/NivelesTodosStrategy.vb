Imports MPP
Imports EE

Public Class NivelesTodosStrategy
    Implements NivelesStrategy

    Public Function obtenerNiveles() As List(Of Nivel) Implements NivelesStrategy.obtenerNiveles
        Dim dataNivel As New Nivel_Data
        Dim nivelesFuertes As New List(Of Nivel)
        For Each nivel As Nivel In dataNivel.ObtenerNivelesDeCapacidades
                nivelesFuertes.Add(nivel)
        Next

        Return nivelesFuertes
    End Function
End Class
