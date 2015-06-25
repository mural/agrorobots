Public Class EvaluacionEnviada
    Inherits EstadoEvaluacion

    Sub New(ByVal evaluacion As Evaluacion)
        Me.Evaluacion = evaluacion
    End Sub

    Public Overrides Function Evaluar() As Integer
        Me.Evaluacion.Estado = New EvaluacionCompletada(Me.Evaluacion)
        Return Evaluacion.Evaluacion_Estado.Evaluada
    End Function

    Public Overrides Function EnviarObjetivos() As Integer
        Throw New ObjetivosYaEnviadosException()
    End Function
End Class
