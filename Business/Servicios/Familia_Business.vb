Option Explicit On
Option Strict On

Imports MPP
Imports EE

Public Class Familia_Business
    Public Function Alta(ByRef obj As Familia) As Boolean
        Dim famData As New Familia_Data
        Try
            famData.Alta(obj)
        Catch ex As Exception
            Return False
        End Try
        Return True
    End Function

    Public Function Baja(ByVal ID As Integer) As Boolean
        Dim famData As New Familia_Data
        Return famData.Baja(ID)
    End Function

    Public Sub Consulta(ByRef obj As Familia)
        Dim comp As New Component_Business
        comp.ObtenerPermisosDeFamilia(DirectCast(obj, Component))

    End Sub

    Public Function Modificacion(ByVal obj As Familia) As Boolean
        Dim famData As New Familia_Data
        Try
            famData.ModificarComp(obj)
        Catch ex As Exception
            Return False
        End Try
        Return True
    End Function

    Public Function ObtenerFamilias() As List(Of Familia)
        Dim FamData As New Familia_Data
        Return FamData.ObtenerFamilias
    End Function

End Class