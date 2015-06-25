Public Class Perfil

    Private _ID As String
    Public Property ID() As String
        Get
            Return _ID
        End Get
        Set(ByVal value As String)
            _ID = value
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

    Private _apellido As String
    Public Property Apellido() As String
        Get
            Return _apellido
        End Get
        Set(ByVal value As String)
            _apellido = value
        End Set
    End Property

    Private _email As String
    Public Property Email() As String
        Get
            Return _email
        End Get
        Set(ByVal value As String)
            _email = value
        End Set
    End Property

    Private _capacidades As List(Of Capacidad)
    Public Property Capacidades() As List(Of Capacidad)
        Get
            Return _capacidades
        End Get
        Set(ByVal value As List(Of Capacidad))
            _capacidades = value
        End Set
    End Property


    Public Sub New(ByVal vID As Integer, ByVal vNombre As String, ByVal vApellido As String, ByVal vEmail As String, ByRef vCapacidades As List(Of Capacidad))
        Me.ID = vID
        Me.Nombre = vNombre
        Me.Apellido = vApellido
        Me.Email = vEmail
        Me.Capacidades = vCapacidades
    End Sub

End Class
