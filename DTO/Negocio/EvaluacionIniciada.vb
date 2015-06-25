Public Class EvaluacionIniciada
    Inherits EstadoEvaluacion

    Sub New(ByVal evaluacion As Evaluacion)
        Me.Evaluacion = evaluacion
    End Sub

    Public Overrides Function Evaluar() As Integer
        Throw New ObjetivosNoCargadosException()
    End Function

    Public Overrides Function EnviarObjetivos() As Integer
        Me.Evaluacion.Estado = New EvaluacionEnviada(Me.Evaluacion)
        Return Evaluacion.Evaluacion_Estado.Enviada
    End Function
End Class
