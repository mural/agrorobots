﻿Option Explicit On
Option Strict On
Imports System.Data.SqlClient

Public Class Servicio_BackUp_Data


    ''' 
    ''' <param name="pathDestino"></param>
    Public Sub CrearBackUp(ByVal pathDestino As String)
        Dim con As SqlConnection = Connection.GetObjConnextion
        Dim cmd As SqlCommand = Data.GetCommand("CreateBackUp", con)
        Dim params As New Parameters
        params.SetStringParameter("@location", pathDestino)
        cmd.Parameters.AddRange(params.GetSQLParameter.ToArray)

        Try
            cmd.ExecuteNonQuery()
        Catch ex As Exception
            EventLog.WriteEntry("Agrorobots", ex.Message)
            Throw New ArgumentException("90005")
        Finally
            con.Close()
            cmd.Dispose()
        End Try


    End Sub

    ''' 
    ''' <param name="pathSource"></param>
    Public Sub RestoreBackUp(ByVal pathSource As String)
        Dim con As SqlConnection = Connection.GetObjConnextionMaster
        Dim cmd As SqlCommand
        Dim query As String = ""
        query += "ALTER DATABASE agrorobots SET OFFLINE WITH ROLLBACK IMMEDIATE;"
        query += "ALTER DATABASE agrorobots SET ONLINE;"
        query += "RESTORE DATABASE [agrorobots] FROM  DISK = N'" & pathSource & "' WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10"

        cmd = Data.GetCommandTypeText(query, con)
        Try
            cmd.ExecuteNonQuery()
        Catch ex As Exception
            Throw New ArgumentException("90006")
        Finally
            con.Close()
            cmd.Dispose()
            Connection.ResetConnections()
        End Try

    End Sub

    Public Sub TestConnection()
        Dim con As SqlConnection = Connection.GetObjConnextion
        con.Open()
    End Sub

End Class