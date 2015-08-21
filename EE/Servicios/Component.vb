Option Explicit On
Option Strict On

Public MustInherit Class Component

    Private _Desc As String
    Private _ID As Integer
    Private _name As String
    Private _display As String

    Public Property Descripcion() As String
        Get
            Return _Desc
        End Get
        Set(ByVal Value As String)
            _Desc = Value
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

    Public Property Name() As String
        Get
            Return _name
        End Get
        Set(ByVal Value As String)
            _name = Value
        End Set
    End Property

    Public Property Display() As String
        Get
            Return _display
        End Get
        Set(ByVal value As String)
            _display = value
        End Set
    End Property

    Public MustOverride Sub ReturnPatente(ByRef tempList As List(Of Component))

End Class ' Component