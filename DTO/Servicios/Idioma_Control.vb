Option Explicit On
Option Strict On

Public Class Idioma_Control

    Private _ControId As Integer
    Private _Idioma As Idioma
    Private _Traduccion As String

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


    Public Sub New(ByVal CtrlId As Integer, ByRef Idiom As Idioma, ByVal Translation As String)
        Me.Control_ID = CtrlId
        Me.Idioma = Idiom
        Me.Traduccion = Translation
    End Sub
End Class