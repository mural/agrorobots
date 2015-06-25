Option Explicit On
Option Strict On

Imports DTO
Imports System.Data.SqlClient

Public Class Nivel_Data

    ''' <summary>
    ''' 'Retorna todos los niveles
    ''' </summary>
    ''' <returns></returns>
    ''' <remarks></remarks>
    Public Function ObtenerNiveles() As System.Collections.Generic.List(Of Nivel)
        Dim con As SqlConnection = Connection.GetObjConnextion
        Dim cmd As SqlCommand = Data.GetCommand("GetAllNiveles", con)

        Dim DT As DataTable

        Try
            DT = Data.GetDataSet(cmd, "Niveles").Tables(0)
        Catch ex As Exception
            Throw ex
        End Try

        Dim lst As New List(Of Nivel)

        For Each row As DataRow In DT.Rows
            Dim obj As New Nivel(CInt(row("ID")), CStr(row("Nombre")), 0)

            lst.Add(obj)
        Next

        Return lst
    End Function

    ''' <summary>
    ''' 'Retorna el nivel para cada capacidad
    ''' </summary>
    ''' <returns></returns>
    ''' <remarks></remarks>
    Public Function ObtenerNivelesDeCapacidades() As System.Collections.Generic.List(Of Nivel)
        Dim con As SqlConnection = Connection.GetObjConnextion
        Dim cmd As SqlCommand = Data.GetCommand("GetNivelesDeCapacidades", con)

        Dim DT As DataTable

        Try
            DT = Data.GetDataSet(cmd, "Niveles").Tables(0)
        Catch ex As Exception
            Throw ex
        End Try

        Dim lst As New List(Of Nivel)

        For Each row As DataRow In DT.Rows
            Dim obj As New Nivel(0, CStr(row("Descripcion")), CDbl(row("Promedio")))

            lst.Add(obj)
        Next

        Return lst
    End Function

End Class