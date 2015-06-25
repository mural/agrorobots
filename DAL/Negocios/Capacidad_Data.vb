Option Explicit On
Option Strict On

Imports DTO
Imports System.Data.SqlClient

Public Class Capacidad_Data

    ''' <summary>
    ''' 'Retorna todas las capacidades
    ''' </summary>
    ''' <returns></returns>
    ''' <remarks></remarks>
    Public Function ObtenerCapacidades() As System.Collections.Generic.List(Of Capacidad)
        Dim con As SqlConnection = Connection.GetObjConnextion
        Dim cmd As SqlCommand = Data.GetCommand("GetAllCapacidades", con)
        Dim DT As DataTable
        Try
            DT = Data.GetDataSet(cmd, "Capacidades").Tables(0)
        Catch ex As Exception
            Throw ex
        End Try

        Dim lst As New List(Of Capacidad)
        For Each row As DataRow In DT.Rows
            Dim obj As New Capacidad(CInt(row("ID")), CStr(row("Descripcion")))

            lst.Add(obj)
        Next

        Return lst
    End Function

    Function ObtenerCapacidadesPorPerfil(ByVal idPerfil As Integer) As List(Of Capacidad)
        Dim con As SqlConnection = Connection.GetObjConnextion
        Dim cmd As SqlCommand = Data.GetCommand("GetCapacidadesPorPerfil", con)
        Dim parameter1 As New SqlParameter
        parameter1.ParameterName = "@id_perfil"
        parameter1.DbType = DbType.Int32
        parameter1.Value = idPerfil
        cmd.Parameters.Add(parameter1)

        Dim DT As DataTable
        Try
            DT = Data.GetDataSet(cmd, "Capacidades").Tables(0)
        Catch ex As Exception
            Throw ex
        End Try

        Dim lst As New List(Of Capacidad)
        For Each row As DataRow In DT.Rows
            Dim obj As New Capacidad(CInt(row("ID")), CStr(row("Descripcion")), CInt(row("Nivel")))

            lst.Add(obj)
        Next

        Return lst
    End Function

End Class