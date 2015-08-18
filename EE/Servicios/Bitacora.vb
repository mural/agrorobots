Public Class Bitacora
    Private _id As Long
    Private _usu As String
    Private _type As String
    Private _fecha As DateTime
    Private _detalle As String

    Property Id() As Long
        Get
            Return _id
        End Get
        Set(ByVal value As Long)
            _id = value
        End Set
    End Property

    Property Usuario() As String
        Get
            Return _usu
        End Get
        Set(ByVal value As String)
            _usu = value
        End Set
    End Property

    Property Tipo() As String
        Get
            Return _type
        End Get
        Set(ByVal value As String)
            _type = value
        End Set
    End Property

    Property Detalle() As String
        Get
            Return _detalle
        End Get
        Set(ByVal value As String)
            _detalle = value
        End Set
    End Property

    Property Fecha() As DateTime
        Get
            Return _fecha
        End Get
        Set(ByVal value As DateTime)
            _fecha = value
        End Set
    End Property

    Public Sub New(ByVal vid As Long, ByVal vUsu As String, ByVal vTipo As String, ByVal vFecha As DateTime, ByVal vDetalle As String)
        Me.Detalle = vDetalle
        Me.Id = vid
        Me.Tipo = vTipo
        Me.Usuario = vUsu
        Me.Fecha = vFecha
    End Sub
End Class
