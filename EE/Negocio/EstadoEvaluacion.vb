Public MustInherit Class EstadoEvaluacion

    Private _evaluacion As Evaluacion
    Public Property Evaluacion() As Evaluacion
        Get
            Return _evaluacion
        End Get
        Set(ByVal value As Evaluacion)
            _evaluacion = value
        End Set
    End Property

    Public MustOverride Function EnviarObjetivos() As Integer
    Public MustOverride Function Evaluar() As Integer

End Class
