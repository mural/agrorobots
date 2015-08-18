Option Explicit On
Option Strict On

Imports EE
Imports System.Transactions
Imports MPP

Public Class Capacidad_Business
    Public m_Capacidad_Data As Capacidad_Data

    Public Function ObtenerCapacidades() As List(Of Capacidad)
        Dim dataCapacidad As New Capacidad_Data
        Return dataCapacidad.ObtenerCapacidades
    End Function

    Public Function ObtenerCapacidadesPorPerfil(ByVal idPerfil As Integer) As List(Of Capacidad)
        Dim dataCapacidad As New Capacidad_Data
        Return dataCapacidad.ObtenerCapacidadesPorPerfil(idPerfil)
    End Function

    Public Function ObtenerCapacidadPorPerfilYTipo(ByVal idPerfil As Integer, ByVal tipoCapacidad As String) As Capacidad
        Dim capacidad = New Capacidad
        For Each capacidadPerfil As Capacidad In ObtenerCapacidadesPorPerfil(idPerfil)
            If tipoCapacidad.Contains(capacidadPerfil.Descripcion) Then
                capacidad = capacidadPerfil
            End If
        Next

        Dim dataCapacidad As New Capacidad_Data
        Return capacidad
    End Function

End Class