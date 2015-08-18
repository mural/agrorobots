Public Class EvaluacionCompletada
    Inherits EstadoEvaluacion

    Sub New(ByVal evaluacion As Evaluacion)
        Me.Evaluacion = evaluacion
    End Sub

    Public Overrides Function Evaluar() As Integer
        Throw New EvaluacionYaCompletadaException()
    End Function

    Public Overrides Function EnviarObjetivos() As Integer
        Throw New ObjetivosYaEnviadosException()
    End Function

End Class
