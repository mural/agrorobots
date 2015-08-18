Imports MPP
Imports EE

Public Class NivelesDebilesStrategy
    Implements NivelesStrategy

    Private Const MAX = 2.8

    Public Function obtenerNiveles() As List(Of Nivel) Implements NivelesStrategy.obtenerNiveles
        Dim dataNivel As New Nivel_Data
        Dim nivelesDebiles As New List(Of Nivel)
        For Each nivel As Nivel In dataNivel.ObtenerNivelesDeCapacidades
            If nivel.Nivel < MAX Then
                nivelesDebiles.Add(nivel)
            End If
        Next

        Return nivelesDebiles
    End Function
End Class
