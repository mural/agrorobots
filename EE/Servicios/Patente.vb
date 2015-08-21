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

    Private _url As String
    Public Property URL() As String
        Get
            Return _url
        End Get
        Set(ByVal value As String)
            _url = value
        End Set
    End Property


    Public Sub New(ByVal id As Integer, ByVal name As String, ByVal desc As String, ByVal control_Id As Integer, ByVal url As String)
        Me.ID = id
        Me.Name = name
        Me.Descripcion = desc
        Me._controId = control_Id
        Me._url = url
    End Sub

    Public Overrides Sub ReturnPatente(ByRef tempList As System.Collections.Generic.List(Of Component))
        tempList.Add(Me)
    End Sub
End Class ' Patente