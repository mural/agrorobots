Option Explicit On
Option Strict On

Imports DTO
Imports System.Data.SqlClient

Public Class Evaluacion_Data

    ''' <summary>
    ''' 'Retorna laa evaluaciones
    ''' </summary>
    ''' <returns></returns>
    ''' <remarks></remarks>
    Public Function ObtenerEvaluaciones() As List(Of Evaluacion)
        Dim con As SqlConnection = Connection.GetObjConnextion
        Dim cmd As SqlCommand = Data.GetCommand("GetAllEvaluaciones", con)

        Dim DT As DataTable
        Try
            DT = Data.GetDataSet(cmd, "Evaluaciones").Tables(0)
        Catch ex As Exception
            Throw ex
        End Try

        Dim evaluaciones As New List(Of Evaluacion)

        For Each row As DataRow In DT.Rows
            Dim completada As Boolean
            Dim objetivos As Boolean
            If row("Completada").Equals(DBNull.Value) Then
                completada = False
            Else
                completada = CBool(row("Completada"))
            End If
            If row("Objetivos").Equals(DBNull.Value) Then
                objetivos = False
            Else
                objetivos = CBool(row("Objetivos"))
            End If

            Dim evaluacion = New Evaluacion(CInt(row("ID_Evaluacion")), CDate(row("Fecha")))
            evaluacion.NombreEvaluado = CStr(row("NombreEvaluado"))
            evaluacion.ID_Evaluado = CInt(row("ID_Evaluado"))

            If completada = True Then
                evaluacion.Estado = New EvaluacionCompletada(evaluacion)
            ElseIf objetivos = True Then
                evaluacion.Estado = New EvaluacionEnviada(evaluacion)
            Else
                evaluacion.Estado = New EvaluacionIniciada(evaluacion)
            End If
            evaluaciones.Add(evaluacion)
        Next

        Return evaluaciones
    End Function

    ''' <summary>
    ''' 'Retorna la evaluacion de un empleado
    ''' </summary>
    ''' <returns></returns>
    ''' <remarks></remarks>
    Public Function ObtenerEvaluacionEmpleado(ByVal idEmpleado As Integer) As Evaluacion
        Dim con As SqlConnection = Connection.GetObjConnextion
        Dim cmd As SqlCommand = Data.GetCommand("GetEvaluacionEmpleado", con)
        Dim parameter1 As New SqlParameter
        parameter1.ParameterName = "@id_empleado"
        parameter1.DbType = DbType.Int32
        parameter1.Value = idEmpleado
        cmd.Parameters.Add(parameter1)

        Dim DT As DataTable

        Try
            DT = Data.GetDataSet(cmd, "Evaluaciones").Tables(0)
        Catch ex As Exception
            Throw ex
        End Try

        Dim evaluacion As New Evaluacion

        For Each row As DataRow In DT.Rows
            Dim completada As Boolean
            Dim objetivos As Boolean
            If row("Completada").Equals(DBNull.Value) Then
                completada = False
            Else
                completada = CBool(row("Completada"))
            End If
            If row("Objetivos").Equals(DBNull.Value) Then
                objetivos = False
            Else
                objetivos = CBool(row("Objetivos"))
            End If

            evaluacion = New Evaluacion(CInt(row("ID_Evaluacion")), CDate(row("Fecha")))
            evaluacion.NombreEvaluado = CStr(row("NombreEvaluado"))
            evaluacion.ID_Evaluado = CInt(row("ID_Evaluado"))

            If completada = True Then
                evaluacion.Estado = New EvaluacionCompletada(evaluacion)
            ElseIf objetivos = True Then
                evaluacion.Estado = New EvaluacionEnviada(evaluacion)
            Else
                evaluacion.Estado = New EvaluacionIniciada(evaluacion)
            End If
        Next

        Return evaluacion
    End Function

    ''' <summary>
    ''' 'Crea una evaluacion
    ''' </summary>
    ''' <param name="evaluacion"></param>
    ''' <remarks></remarks>
    Public Sub Alta(ByVal evaluacion As Evaluacion)
        Dim con As SqlConnection
        Dim cmd As SqlCommand
        Dim params As New Parameters
        params.SetIntParameter("@id_empleado", evaluacion.ID_Evaluado)
        params.SetDateParameter("@fecha", evaluacion.Fecha)
        params.SetBooleanParameter("@objetivos", False)
        params.SetBooleanParameter("@completada", False)
        params.SetIntParameter("@id_evaluador", 0)
        params.SetStringParameter("@nombre_evaluado", evaluacion.NombreEvaluado)

        con = Connection.GetObjConnextion
        cmd = Data.GetCommand("CreateEvaluacion", con, params)

        Try
            cmd.ExecuteNonQuery()
        Catch ex As Exception
            Throw New ArgumentException("90036")
        Finally
            con.Close()
            cmd.Dispose()
        End Try
    End Sub

    ''' <summary>
    ''' 'Modifica una evaluacion
    ''' </summary>
    ''' <param name="evaluacion"></param>
    ''' <remarks></remarks>
    Public Sub Modificar(ByVal evaluacion As Evaluacion)
        Dim con As SqlConnection
        Dim cmd As SqlCommand
        Dim params As New Parameters
        params.SetIntParameter("@id", evaluacion.ID)
        params.SetDateParameter("@fecha", evaluacion.Fecha)
        params.SetBooleanParameter("@objetivos", TypeOf evaluacion.Estado Is EvaluacionEnviada)
        params.SetBooleanParameter("@completada", TypeOf evaluacion.Estado Is EvaluacionCompletada)


        con = Connection.GetObjConnextion
        cmd = Data.GetCommand("UpdateEvaluacion", con, params)

        Try
            cmd.ExecuteNonQuery()
        Catch ex As Exception
            Throw New ArgumentException("90036")
        Finally
            con.Close()
            cmd.Dispose()
        End Try
    End Sub

    Function ObtenerEvaluacionPorEvaluador(ByVal idEvaluador As Integer) As Evaluacion
        Dim con As SqlConnection = Connection.GetObjConnextion
        Dim cmd As SqlCommand = Data.GetCommand("GetEvaluacionPorEvaluador", con)
        Dim parameter1 As New SqlParameter
        parameter1.ParameterName = "@id_evaluador"
        parameter1.DbType = DbType.Int32
        parameter1.Value = idEvaluador
        cmd.Parameters.Add(parameter1)

        Dim DT As DataTable

        Try
            DT = Data.GetDataSet(cmd, "Evaluaciones").Tables(0)
        Catch ex As Exception
            Throw ex
        End Try

        Dim evaluacion As New Evaluacion

        For Each row As DataRow In DT.Rows
            Dim completada As Boolean
            Dim objetivos As Boolean
            If row("Completada").Equals(DBNull.Value) Then
                completada = False
            Else
                completada = CBool(row("Completada"))
            End If
            If row("Objetivos").Equals(DBNull.Value) Then
                objetivos = False
            Else
                objetivos = CBool(row("Objetivos"))
            End If

            evaluacion = New Evaluacion(CInt(row("ID_Evaluacion")), CDate(row("Fecha")))
            evaluacion.NombreEvaluado = CStr(row("NombreEvaluado"))
            evaluacion.ID_Evaluado = CInt(row("ID_Evaluado"))

            If completada = True Then
                evaluacion.Estado = New EvaluacionCompletada(evaluacion)
            ElseIf objetivos = True Then
                evaluacion.Estado = New EvaluacionEnviada(evaluacion)
            Else
                evaluacion.Estado = New EvaluacionIniciada(evaluacion)
            End If
        Next

        Return evaluacion
    End Function

End Class
