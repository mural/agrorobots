Option Explicit On
Option Strict On

Public Class Usuario

    Private _Activo As Boolean
    Private _Admin As Boolean
    Private _Apellido As String
    Private _Familias As New List(Of Component)
    Private _ID As Integer
    Private _Idioma As Idioma
    Private _Intentos As Integer
    Private _Nombre As String
    Private _Password As String
    Private _Usuario As String


    Public Property Activo() As Boolean
        Get
            Return _Activo
        End Get
        Set(ByVal Value As Boolean)
            _Activo = Value
        End Set
    End Property

    Public Property Admin() As Boolean
        Get
            Return _Admin
        End Get
        Set(ByVal Value As Boolean)
            _Admin = Value
        End Set
    End Property

    Public Property Apellido() As String
        Get
            Return _Apellido
        End Get
        Set(ByVal Value As String)
            _Apellido = Value
        End Set
    End Property

    Public Sub AddComponent(ByRef comp As Component)
        Me._Familias.Add(comp)
        Me.PermissionsModified = True
    End Sub

    Public ReadOnly Property GetFamilias() As List(Of Component)
        Get
            Return Me._Familias
        End Get
    End Property

    Public Function GetOnlyPatentes() As List(Of Component)
        Dim lst As New List(Of Component)
        For Each x As Component In Me._Familias
            x.ReturnPatente(lst)
        Next

        Return lst
    End Function

    Public Sub RemoveComponent(ByRef o As Component)
        Me._Familias.Remove(o)
    End Sub

    Public Sub RemoveAllComponents()
        Me._Familias.Clear()
    End Sub

    Public Property ID() As Integer
        Get
            Return _ID
        End Get
        Set(ByVal Value As Integer)
            _ID = Value
        End Set
    End Property

    Public Property Idioma() As Idioma
        Get
            Return _Idioma
        End Get

        Set(value As Idioma)
            _Idioma = value
        End Set
    End Property

    Public Sub SetLanguage(ByVal Value As Idioma)
        _Idioma = Value
        RaiseEvent IdiomChanged()
    End Sub


    Public Property Intentos() As Integer
        Get
            Return _Intentos
        End Get
        Set(ByVal Value As Integer)
            _Intentos = Value
        End Set
    End Property

    Public Property Nombre() As String
        Get
            Return _Nombre
        End Get
        Set(ByVal Value As String)
            _Nombre = Value
        End Set
    End Property

    Public Property Password() As String
        Get
            Return _Password
        End Get
        Set(ByVal Value As String)
            _Password = Value
        End Set
    End Property

    Public Property UserName() As String
        Get
            Return _Usuario
        End Get
        Set(ByVal Value As String)
            _Usuario = Value
        End Set
    End Property

    Private _permissionModified As Boolean
    Public Property PermissionsModified() As Boolean
        Get
            Return _permissionModified
        End Get
        Set(ByVal value As Boolean)
            _permissionModified = value
        End Set
    End Property

    Public Event IdiomChanged()

    Public Sub New()

    End Sub
    Public Sub New(ByVal IsActive As Boolean, ByVal IsAdmin As Boolean, ByVal ape As String, ByVal id As Integer, ByVal idiom As Idioma, ByVal intentos As Integer, ByVal name As String, ByVal pass As String, ByVal username As String)
        Me.Activo = IsActive
        Me.Admin = IsAdmin
        Me.Apellido = ape
        Me.ID = id
        Me.SetLanguage(idiom)
        Me.Intentos = intentos
        Me.Nombre = name
        Me.Password = pass
        Me.UserName = username
    End Sub

End Class ' Usuario