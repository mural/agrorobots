Option Explicit On
Option Strict On

Public Class Capacidad

    Private _ID As Integer
    Public Property ID() As Integer
        Get
            Return _ID
        End Get
        Set(ByVal Value As Integer)
            _ID = Value
        End Set
    End Property

    Private _desc As String
    Public Property Descripcion() As String
        Get
            Return _desc
        End Get
        Set(ByVal value As String)
            _desc = value
        End Set
    End Property

    Private _nivel As Integer
    Public Property Nivel() As Integer
        Get
            Return _nivel
        End Get
        Set(ByVal value As Integer)
            _nivel = value
        End Set
    End Property

    Public Sub New(ByVal vID As Integer, ByVal vDesc As String)
        Me.ID = vID
        Me.Descripcion = vDesc
    End Sub

    Public Sub New(ByVal vID As Integer, ByVal vDesc As String, ByVal vNivel As Integer)
        Me.ID = vID
        Me.Descripcion = vDesc
        Me.Nivel = vNivel
    End Sub

    Public Sub New()

    End Sub

End Class
