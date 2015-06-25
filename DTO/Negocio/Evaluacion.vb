Public Class Evaluacion

    Public Enum Evaluacion_Estado
        Iniciada = 1
        Enviada = 2
        Evaluada = 3
    End Enum

    Private _id As Integer
    Public Property ID() As Integer
        Get
            Return _id
        End Get
        Set(ByVal value As Integer)
            _id = value
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

    Private _estado As EstadoEvaluacion
    Public Property Estado() As EstadoEvaluacion
        Get
            Return _estado
        End Get
        Set(ByVal value As EstadoEvaluacion)
            _estado = value
        End Set
    End Property

    Private _ID_Evaluador As Integer
    Public Property ID_Evaluador() As Integer
        Get
            Return _ID_Evaluador
        End Get
        Set(ByVal value As Integer)
            _ID_Evaluador = value
        End Set
    End Property

    Private _NombreEvaluado As String
    Public Property NombreEvaluado() As String
        Get
            Return _NombreEvaluado
        End Get
        Set(ByVal value As String)
            _NombreEvaluado = value
        End Set
    End Property

    Private _ID_Evaluado As Integer
    Public Property ID_Evaluado() As Integer
        Get
            Return _ID_Evaluado
        End Get
        Set(ByVal value As Integer)
            _ID_Evaluado = value
        End Set
    End Property

    Sub New()
        Me.Estado = New EvaluacionIniciada(Me)
    End Sub

    Sub New(ByVal vId As Integer, ByVal vFecha As Date)
        Me.New()
        Me.ID = vId
        Me.Fecha = vFecha
    End Sub

End Class
