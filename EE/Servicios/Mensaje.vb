
Public Class Mensaje

    Private _id As Integer
    Public Property ID() As Integer
        Get
            Return _id
        End Get
        Set(ByVal value As Integer)
            _id = value
        End Set
    End Property

    Private _contenido As String
    Public Property Contenido() As String
        Get
            Return _contenido
        End Get
        Set(ByVal value As String)
            _contenido = value
        End Set
    End Property

    Private _usuarioEmisor As Integer
    Public Property UsuarioEmisor() As Integer
        Get
            Return _usuarioEmisor
        End Get
        Set(ByVal value As Integer)
            _usuarioEmisor = value
        End Set
    End Property

    Private _nombreEmisor As String
    Public Property NombreEmisor() As String
        Get
            Return _nombreEmisor
        End Get
        Set(ByVal value As String)
            _nombreEmisor = value
        End Set
    End Property

    Private _emailEmisor As String
    Public Property EmailEmisor() As String
        Get
            Return _emailEmisor
        End Get
        Set(ByVal value As String)
            _emailEmisor = value
        End Set
    End Property


    Private _rolEmisor As Integer
    Public Property RolEmisor() As Integer
        Get
            Return _rolEmisor
        End Get
        Set(ByVal value As Integer)
            _rolEmisor = value
        End Set
    End Property

    Private _usuarioReceptor As Integer
    Public Property UsuarioReceptor() As Integer
        Get
            Return _usuarioReceptor
        End Get
        Set(ByVal value As Integer)
            _usuarioReceptor = value
        End Set
    End Property

    Private _emailReceptor As String
    Public Property EmailReceptor() As String
        Get
            Return _emailReceptor
        End Get
        Set(ByVal value As String)
            _emailReceptor = value
        End Set
    End Property


    Private _rolReceptor As Integer
    Public Property RolReceptor() As Integer
        Get
            Return _rolReceptor
        End Get
        Set(ByVal value As Integer)
            _rolReceptor = value
        End Set
    End Property

    Private _broadcast As Boolean
    Public Property Broadcast() As Boolean
        Get
            Return _broadcast
        End Get
        Set(ByVal value As Boolean)
            _broadcast = value
        End Set
    End Property

    Private _idConversacion As Integer
    Public Property IdConversacion() As Integer
        Get
            Return _idConversacion
        End Get
        Set(ByVal value As Integer)
            _idConversacion = value
        End Set
    End Property

    Private _leidoEmisor As Boolean
    Public Property LeidoEmisor() As Boolean
        Get
            Return _leidoEmisor
        End Get
        Set(ByVal value As Boolean)
            _leidoEmisor = value
        End Set
    End Property

    Private _leidoReceptor As Boolean
    Public Property LeidoReceptor() As Boolean
        Get
            Return _leidoReceptor
        End Get
        Set(ByVal value As Boolean)
            _leidoReceptor = value
        End Set
    End Property

    Private _fecha As Date
    Public Property Fecha() As Date
        Get
            Return _fecha
        End Get
        Set(ByVal value As Date)
            _fecha = value
        End Set
    End Property

    Private _borradoEmisor As Boolean
    Public Property BorradoEmisor() As Boolean
        Get
            Return _borradoEmisor
        End Get
        Set(ByVal value As Boolean)
            _borradoEmisor = value
        End Set
    End Property

    Private _borradoReceptor As Boolean
    Public Property BorradoReceptor() As Boolean
        Get
            Return _borradoReceptor
        End Get
        Set(ByVal value As Boolean)
            _borradoReceptor = value
        End Set
    End Property

    Private _chat As Boolean
    Public Property Chat() As Boolean
        Get
            Return _chat
        End Get
        Set(ByVal value As Boolean)
            _chat = value
        End Set
    End Property

    Sub New()
        Me._id = 0
        Me._contenido = ""
        Me._emailEmisor = ""
        Me._emailReceptor = ""
        Me._leidoEmisor = True
        Me._leidoReceptor = False
    End Sub

    Public Sub New(ByVal ID As Integer, ByVal Contenido As String, ByVal UsuarioEmisor As Integer, ByVal EmailEmisor As String,
                   ByVal RolEmisor As Integer, ByVal UsuarioReceptor As Integer, ByVal EmailReceptor As String,
                   ByVal RolReceptor As Integer, ByVal Broadcast As Boolean, ByVal IdConversacion As Integer,
                   ByVal LeidoEmisor As Boolean, ByVal LeidoReceptor As Boolean, ByVal Fecha As Date,
                   ByVal BorradoEmisor As Boolean, ByVal BorradoReceptor As Boolean, ByVal Chat As Boolean)
        Me._id = ID
        Me._contenido = Contenido
        Me._usuarioEmisor = UsuarioEmisor
        Me._emailEmisor = EmailEmisor
        Me._rolEmisor = RolEmisor
        Me._usuarioReceptor = UsuarioReceptor
        Me._emailReceptor = EmailReceptor
        Me._rolReceptor = RolReceptor
        Me._broadcast = Broadcast
        Me._idConversacion = IdConversacion
        Me._leidoEmisor = LeidoEmisor
        Me._leidoReceptor = LeidoReceptor
        Me._fecha = Fecha
        Me._borradoEmisor = BorradoEmisor
        Me._borradoReceptor = BorradoReceptor
        Me._chat = Chat
    End Sub

End Class
