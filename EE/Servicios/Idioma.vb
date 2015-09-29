Option Explicit On
Option Strict On

Public Class Idioma
    Private _desc As String
    Private _ID As Integer
    Private _code As String

    Public Property Descripcion() As String
        Get
            Return _desc
        End Get
        Set(ByVal Value As String)
            _desc = Value
        End Set
    End Property

    Public Property ID() As Integer
        Get
            Return _ID
        End Get
        Set(ByVal Value As Integer)
            _ID = Value
        End Set
    End Property

    Public Property Codigo() As String
        Get
            Return _code
        End Get
        Set(ByVal Value As String)
            _code = Value
        End Set
    End Property

    Public Sub New(ByVal id As Integer, ByVal desc As String, ByVal code As String)
        Me._ID = id
        Me._desc = desc
        Me._code = code
    End Sub
End Class
