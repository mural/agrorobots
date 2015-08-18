Option Explicit On
Option Strict On
Imports System.Data.SqlClient

Public Class Servicio_Digitos_Data


    ''' 
    ''' <param name="ids"></param>
    ''' <param name="table"></param>
    Public Sub GuardarDigitoH(ByVal ids As String, ByVal table As String, ByVal hash As String)
        Dim con As SqlConnection = Connection.GetObjConnextion
        Dim cmd As SqlCommand = Data.GetCommand("SetDHToRow", con)
        Dim param As New Parameters
        param.SetStringParameter("@table", table)
        param.SetStringParameter("@id", ids)
        param.SetStringParameter("@hash", hash)
        cmd.Parameters.AddRange(param.GetSQLParameter.ToArray)

        Try
            cmd.ExecuteNonQuery()
        Catch ex As Exception
            Throw New ArgumentException("90010")
            EventLog.WriteEntry("GAT", ex.Message)
        Finally
            con.Close()
            cmd.Dispose()
        End Try

    End Sub

    Public Sub GuardarDigitoV(ByVal table As String, ByVal hash As String)
        Dim con As SqlConnection = Connection.GetObjConnextion
        Dim param As New Parameters
        param.SetStringParameter("@table", table)
        param.SetStringParameter("@hash", hash)
        Dim cmd As SqlCommand = Data.GetCommand("SetDVbyTable", con, param)

        Try
            cmd.ExecuteNonQuery()
        Catch ex As Exception
            Throw New ArgumentException("90011")
            EventLog.WriteEntry("GAT", ex.Message)
        Finally
            con.Close()
            cmd.Dispose()
        End Try
    End Sub


    Public Function ObtenerDigitosV() As DataTable
        Dim con As SqlConnection = Connection.GetObjConnextion
        Dim cmd As SqlCommand = Data.GetCommand("GetAllDigits", con)

        Dim dt As DataSet

        Try
            dt = Data.GetDataSet(cmd, "DigitoV")
        Catch ex As Exception
            Throw ex
        End Try


        cmd.Dispose()

        Return dt.Tables(0)
    End Function

    ''' 
    ''' <param name="ids"></param>
    ''' <param name="tabla"></param>
    Public Function ObtenerFila(ByVal ids As String, ByVal tabla As String) As DataRow
        Dim con As SqlConnection = Connection.GetObjConnextion
        Dim cmd As SqlCommand = Data.GetCommand("GetRow4DH", con)
        Dim param As New Parameters
        param.SetStringParameter("@table", tabla)
        param.SetStringParameter("@id", ids)
        cmd.Parameters.AddRange(param.GetSQLParameter.ToArray)

        Dim dt As DataSet

        Try
            dt = Data.GetDataSet(cmd, tabla)
        Catch ex As Exception
            Throw ex
        End Try

        Dim dr As DataRow = dt.Tables(0).Rows(0)

        cmd.Dispose()

        Return dr

    End Function

    ''' 
    ''' <param name="table"></param>
    Public Function ObtenerTabla(ByVal table As String) As DataTable
        Dim con As SqlConnection = Connection.GetObjConnextion
        Dim param As New Parameters
        param.SetStringParameter("@table", table)
        Dim cmd As SqlCommand = Data.GetCommand("GetTable4DV", con, param)

        Dim dt As DataTable

        Try
            dt = Data.GetDataSet(cmd, table).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try

        Return dt
    End Function


End Class ' Servicio_Digitos_Data