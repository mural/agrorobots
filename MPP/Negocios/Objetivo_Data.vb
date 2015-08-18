Option Explicit On
Option Strict On

Imports EE
Imports System.Data.SqlClient

Public Class Objetivo_Data

    ''' <summary>
    ''' 'Retorna los objetivos por empleado
    ''' </summary>
    ''' <returns></returns>
    ''' <remarks></remarks>
    Public Function ObtenerObjetivosPorEmpleado(ByVal idEmpleado As Integer) As List(Of Objetivo)
        Dim con As SqlConnection = Connection.GetObjConnextion
        Dim cmd As SqlCommand = Data.GetCommand("GetObjetivosPorEmpleado", con)
        Dim parameter1 As New SqlParameter
        parameter1.ParameterName = "@id_empleado"
        parameter1.DbType = DbType.Int32
        parameter1.Value = idEmpleado
        cmd.Parameters.Add(parameter1)

        Dim DT As DataTable

        Try
            DT = Data.GetDataSet(cmd, "Objetivos").Tables(0)
        Catch ex As Exception
            Throw ex
        End Try

        Dim lst As New List(Of Objetivo)

        For Each row As DataRow In DT.Rows
            Dim cumplido As Boolean
            Dim motivo As String
            If row("Cumplido").Equals(DBNull.Value) Then
                cumplido = False
            Else
                cumplido = CBool(row("Cumplido"))
            End If
            If row("Motivo").Equals(DBNull.Value) Then
                motivo = ""
            Else
                motivo = CStr(row("Motivo"))
            End If

            Dim obj As New Objetivo(CInt(row("ID_Objetivo")), CStr(row("Descripcion")), cumplido, CDate(row("Fecha")), motivo)

            lst.Add(obj)
        Next

        Return lst
    End Function

    ''' <summary>
    ''' Ingresa de un objetivo
    ''' </summary>
    ''' <param name="objetivo"></param>
    ''' <remarks></remarks>
    Public Sub Alta(ByVal idEmpleado As Integer, ByVal objetivo As Objetivo)
        Dim con As SqlConnection
        Dim cmd As SqlCommand
        Dim params As New Parameters
        params.SetIntParameter("@id_empleado", idEmpleado)
        params.SetStringParameter("@descripcion", objetivo.Descripcion)
        params.SetBooleanParameter("@cumplido", objetivo.Cumplido)
        params.SetDateParameter("@fecha", objetivo.Fecha)
        params.SetStringParameter("@motivo", objetivo.Motivo)

        con = Connection.GetObjConnextion
        cmd = Data.GetCommand("CreateObjetivo", con, params)

        Try
            objetivo.ID = CInt(cmd.ExecuteScalar())
        Catch ex As Exception
            Throw New ArgumentException("90036")
        Finally
            con.Close()
            cmd.Dispose()
        End Try
    End Sub

    ''' <summary>
    ''' 'Elimina un objetivo
    ''' </summary>
    ''' <param name="idObjetivo"></param>
    ''' <remarks></remarks>
    Public Sub Baja(ByVal idObjetivo As Integer)
        Dim con As SqlConnection
        Dim cmd As SqlCommand
        Dim params As New Parameters
        params.SetIntParameter("@id", idObjetivo)

        con = Connection.GetObjConnextion
        cmd = Data.GetCommand("DeleteObjetivo", con, params)

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
    ''' 'Modifica un objetivo
    ''' </summary>
    ''' <param name="objetivo"></param>
    ''' <remarks></remarks>
    Public Sub Modificar(ByVal objetivo As Objetivo)
        Dim con As SqlConnection
        Dim cmd As SqlCommand
        Dim params As New Parameters
        params.SetIntParameter("@id", objetivo.ID)
        params.SetStringParameter("@descripcion", objetivo.Descripcion)
        params.SetBooleanParameter("@cumplido", objetivo.Cumplido)
        params.SetDateParameter("@fecha", objetivo.Fecha)
        params.SetStringParameter("@motivo", objetivo.Motivo)

        con = Connection.GetObjConnextion
        cmd = Data.GetCommand("UpdateObjetivo", con, params)

        Try
            cmd.ExecuteNonQuery()
        Catch ex As Exception
            Throw New ArgumentException("90036")
        Finally
            con.Close()
            cmd.Dispose()
        End Try
    End Sub

End Class
