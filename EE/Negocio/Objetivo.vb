Public Class Objetivo

    Private _id As Integer
    Public Property ID() As Integer
        Get
            Return _id
        End Get
        Set(ByVal value As Integer)
            _id = value
        End Set
    End Property

    Private _descripcion As String
    Public Property Descripcion() As String
        Get
            Return _descripcion
        End Get
        Set(ByVal value As String)
            _descripcion = value
        End Set
    End Property

    Private _cumplido As Boolean
    Public Property Cumplido() As Boolean
        Get
            Return _cumplido
        End Get
        Set(ByVal value As Boolean)
            _cumplido = value
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

    Private _motivo As String
    Public Property Motivo() As String
        Get
            Return _motivo
        End Get
        Set(ByVal value As String)
            _motivo = value
        End Set
    End Property

    Public Sub New(ByVal vID As Integer, ByVal vDescripcion As String, ByVal vCumplido As Boolean, ByVal vFecha As Date, ByVal vMotivo As String)
        Me.ID = vID
        Me.Descripcion = vDescripcion
        Me.Cumplido = vCumplido
        Me.Fecha = vFecha
        Me.Motivo = vMotivo
    End Sub

End Class
