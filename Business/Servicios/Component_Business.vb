Option Explicit On
Option Strict On

Imports MPP
Imports EE

Public Class Component_Business
    Public Sub ObtenerComponents(ByRef obj As Component)
        Dim compData As New Component_Data
        compData.ObtenerComponents(obj)
    End Sub

    Public Sub ObtenerComponentsOfUser(ByRef obj As Usuario)
        Dim compData As New Component_Data
        compData.ObtenerComponentsOfUser(obj)
        compData = Nothing
    End Sub

    Public Function ObtenerAllComponentes() As System.Collections.Generic.List(Of Component)
        Dim compData As New Component_Data
        Return compData.ObtenerAllComponentes()
    End Function
End Class