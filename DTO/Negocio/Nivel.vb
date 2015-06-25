Option Explicit On
Option Strict On

Public Class Nivel

    Private _ID As Integer
    Public Property ID() As Integer
        Get
            Return _ID
        End Get
        Set(ByVal Value As Integer)
            _ID = Value
        End Set
    End Property

    Private _nombre As String
    Public Property Nombre() As String
        Get
            Return _nombre
        End Get
        Set(ByVal value As String)
            _nombre = value
        End Set
    End Property

    Private _nivel As Double
    Public Property Nivel() As Double
        Get
            Return _nivel
        End Get
        Set(ByVal value As Double)
            _nivel = value
        End Set
    End Property

    Public Sub New(ByVal vID As Integer, ByVal vName As String, ByVal vNivel As Double)
        Me.ID = vID
        Me.Nombre = vName
        Me.Nivel = vNivel
    End Sub

    Public Sub New()

    End Sub

End Class
