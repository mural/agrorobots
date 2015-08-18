Option Explicit On
Option Strict On

Imports MPP
Imports EE

Public Class Familia_Business
    Public Sub Alta(ByRef obj As Familia)
        Dim famData As New Familia_Data
        famData.Alta(obj)
    End Sub

    Public Sub Baja(ByVal obj As Familia)
        Dim famData As New Familia_Data
        famData.Baja(obj)
    End Sub

    Public Sub Consulta(ByRef obj As Familia)
        Dim comp As New Component_Business
        comp.ObtenerComponents(DirectCast(obj, Component))

    End Sub

    Public Sub Modificacion(ByVal obj As Familia)
        Dim famData As New Familia_Data
        famData.ModificarComp(obj)
    End Sub

    Public Function ObtenerFamilias() As List(Of Familia)
        Dim FamData As New Familia_Data
        Return FamData.ObtenerFamilias
    End Function

End Class