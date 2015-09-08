Option Explicit On
Option Strict On

Public Class Idioma_Control

    Private _ID As Integer
    Private _ControId As Integer
    Private _Idioma As Idioma
    Private _Traduccion As String
    Private _Original As String

    Public Property ID() As Integer
        Get
            Return _ID
        End Get
        Set(ByVal Value As Integer)
            _ID = Value
        End Set
    End Property

    Public Property Control_ID() As Integer
        Get
            Return _ControId
        End Get
        Set(ByVal value As Integer)
            _ControId = value
        End Set
    End Property

    Public Property Idioma() As Idioma
        Get
            Return _Idioma
        End Get
        Set(ByVal Value As Idioma)
            _Idioma = Value
        End Set
    End Property

    Public Property Traduccion() As String
        Get
            Return _Traduccion
        End Get
        Set(ByVal Value As String)
            _Traduccion = Value
        End Set
    End Property

    Public Property Original() As String
        Get
            Return _Original
        End Get
        Set(ByVal Value As String)
            _Original = Value
        End Set
    End Property


    Public Sub New(ByVal id As Integer, ByVal CtrlId As Integer, ByRef Idiom As Idioma, ByVal Translation As String)
        Me._ID = id
        Me.Control_ID = CtrlId
        Me.Idioma = Idiom
        Me.Traduccion = Translation
    End Sub
End Class