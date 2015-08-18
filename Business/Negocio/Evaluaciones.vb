Imports EE
Imports MPP

Public Class Evaluaciones

    Public Shared Function traerEvaluaciones() As List(Of Evaluacion)
        Dim evaluaciones = New Evaluacion_Data()
        Return evaluaciones.ObtenerEvaluaciones()
    End Function

    Public Shared Function traerEvaluacion(ByVal idEmpleado As Integer, ByVal nombreEvaluado As String) As Evaluacion
        Dim evaluaciones = New Evaluacion_Data()
        Dim evaluacion = evaluaciones.ObtenerEvaluacionEmpleado(idEmpleado)
        If evaluacion.ID = 0 Then
            Dim nuevaEvaluacion = New Evaluacion
            nuevaEvaluacion.ID_Evaluado = idEmpleado
            nuevaEvaluacion.NombreEvaluado = nombreEvaluado
            nuevaEvaluacion.Fecha = Now
            evaluaciones.Alta(nuevaEvaluacion)
        End If
        evaluacion = evaluaciones.ObtenerEvaluacionEmpleado(idEmpleado)
        Return evaluacion
    End Function

    Public Shared Function traerEvaluacionPorEvaluador(ByVal idEvaluador As Integer) As Evaluacion
        Dim evaluaciones = New Evaluacion_Data()
        Return evaluaciones.ObtenerEvaluacionPorEvaluador(idEvaluador)
    End Function

    Public Shared Sub ActualizarEstadoEvaluacion(ByVal evaluacion As Evaluacion)
        Dim evaluaciones = New Evaluacion_Data()
        evaluaciones.Modificar(evaluacion)
    End Sub

    Public Shared Function traerObjetivos(ByVal idEmpleado As Integer) As List(Of Objetivo)
        Dim objetivo = New Objetivo_Data()
        Dim objetivos = objetivo.ObtenerObjetivosPorEmpleado(idEmpleado)
        If objetivos.Count = 0 Then
            objetivo.Alta(idEmpleado, New Objetivo(0, "", False, Now, ""))
        End If
        objetivos = objetivo.ObtenerObjetivosPorEmpleado(idEmpleado)
        Return objetivos
    End Function

    Public Shared Function UoWObjetivos(ByVal idEmpleado As Integer, ByVal newObjects As List(Of Objetivo), ByVal dirtyObjects As List(Of Objetivo), ByVal removedObjects As List(Of Objetivo)) As Boolean
        Try
            Dim objetivos = New Objetivo_Data()
            For Each nuevo As Objetivo In newObjects
                objetivos.Alta(idEmpleado, nuevo)
            Next
            For Each modificado As Objetivo In dirtyObjects
                objetivos.Modificar(modificado)
            Next
            For Each borrado As Objetivo In removedObjects
                objetivos.Baja(borrado.ID)
            Next
            Return True
        Catch ex As Exception
            Return False
        End Try

    End Function

End Class
