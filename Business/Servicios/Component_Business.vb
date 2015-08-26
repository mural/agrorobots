Option Explicit On
Option Strict On

Imports MPP
Imports EE

Public Class Component_Business
    Public Sub ObtenerPermisosDeFamilia(ByRef obj As Component)
        Dim compData As New Component_Data
        compData.ObtenerComponents(obj)
    End Sub

    Public Sub ObtenerComponentsOfUser(ByRef obj As Usuario)
        Dim compData As New Component_Data
        obj.RemoveAllComponents()
        compData.ObtenerComponentsOfUser(obj)
        compData = Nothing
    End Sub

    Public Function ObtenerPatentes() As System.Collections.Generic.List(Of Patente)
        Dim compData As New Component_Data
        Dim patentes As New List(Of Patente)
        For Each componente As Component In compData.ObtenerAllComponentes()
            If TypeOf componente Is Patente Then
                patentes.Add(CType(componente, Patente))
            End If
        Next
        Return patentes
    End Function

    Public Function ObtenerPatentesDisponiblesPorFamilia(ByVal idFamilia As Integer) As System.Collections.Generic.List(Of Patente)
        Dim compData As New Component_Data
        Dim patentes As New List(Of Patente)
        For Each componente As Component In compData.ObtenerAllComponentes()
            If TypeOf componente Is Patente Then
                If DirectCast(componente, Patente).ControlID.Equals(idFamilia) Then
                    patentes.Add(CType(componente, Patente))
                End If
            End If
        Next
        Return patentes
    End Function
End Class