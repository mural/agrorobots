Option Explicit On
Option Strict On

Public Class Patente
    Inherits Component

    Private _controId As Integer
    Public ReadOnly Property ControlID() As Integer
        Get
            Return _controId
        End Get
    End Property

    Public Sub New(ByVal id As Integer, ByVal name As String, ByVal desc As String, ByVal control_Id As Integer)
        Me.ID = id
        Me.Name = name
        Me.Descricion = desc
        Me._controId = control_Id
    End Sub

    Public Overrides Sub ReturnPatente(ByRef tempList As System.Collections.Generic.List(Of Component))
        tempList.Add(Me)
    End Sub
End Class ' Patente