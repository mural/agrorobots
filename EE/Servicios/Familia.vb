﻿Option Explicit On
Option Strict On

Public Class Familia
    Inherits Component

    Private _comps As New List(Of Component)

    Public Sub AddComponent(ByRef obj As Component)
        Me._comps.Add(obj)
    End Sub

    Public Sub RemoveComponent(ByRef obj As Component)
        Me._comps.Remove(obj)
    End Sub

    Public Sub NuevosPermisos(ByRef permisos As List(Of Component))
        Me._comps.Clear()
        Me._comps.AddRange(permisos)
    End Sub

    Public Overrides Sub ReturnPatente(ByRef tempList As System.Collections.Generic.List(Of Component))
        For Each obj As Component In Me._comps
            obj.ReturnPatente(tempList)
        Next
    End Sub

    Public Sub New(ByVal id As Integer, ByVal name As String, ByVal descripcion As String)
        Me.ID = id
        Me.Name = name
        Me.Descripcion = descripcion
    End Sub

    Public Function GetComponents() As List(Of Component)
        Return Me._comps
    End Function

End Class ' Familia