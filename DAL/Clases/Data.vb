Imports System.Data.SqlClient

Public Class Data

    Public Shared Function GetCommand(ByRef storedProcedure As String, ByRef con As SqlConnection) As SqlClient.SqlCommand
        Dim vCommand As New SqlCommand
        vCommand.CommandText = storedProcedure
        vCommand.CommandType = CommandType.StoredProcedure

        If con.State = ConnectionState.Closed Then
            Try
                con.Open()
            Catch ex As Exception
                EventLog.WriteEntry("Agrorobots", ex.Message)
                Throw New ArgumentException("90001")
            End Try
        End If

        vCommand.Connection = con
        Return vCommand
    End Function

    Public Shared Function GetCommand(ByRef storedProcedure As String, ByRef con As SqlConnection, ByRef parameters As Parameters, Optional ByRef trx As SqlTransaction = Nothing) As SqlClient.SqlCommand
        Dim vCommand As New SqlCommand
        vCommand.CommandText = storedProcedure
        vCommand.CommandType = CommandType.StoredProcedure

        If Not IsNothing(trx) Then
            vCommand.Transaction = trx
        End If

        For Each param As SqlParameter In parameters.GetSQLParameter
            vCommand.Parameters.Add(param)
        Next

        If con.State = ConnectionState.Closed Then
            Try
                con.Open()
            Catch ex As Exception
                EventLog.WriteEntry("Agrorobots", ex.Message)
                Throw New ArgumentException("90001")
            End Try
        End If

        vCommand.Connection = con
        Return vCommand
    End Function

    Public Shared Function GetCommandTypeText(ByRef toExecute As String, ByRef con As SqlConnection) As SqlClient.SqlCommand
        Dim vCommand As New SqlCommand
        vCommand.CommandText = toExecute
        vCommand.CommandType = CommandType.Text

        If con.State = ConnectionState.Closed Then
            Try
                con.Open()
            Catch ex As Exception
                EventLog.WriteEntry("Agrorobots", ex.Message)
                Throw New ArgumentException("90001")
            End Try
        End If

        vCommand.Connection = con
        Return vCommand
    End Function

    Public Shared Function GetDataSet(ByRef command As SqlCommand, ByRef table As String) As DataSet
        Dim objAdpter As New SqlDataAdapter(command)
        Dim dataset As New DataSet()
        Try
            objAdpter.Fill(dataset, table)
        Catch ex As Exception
            EventLog.WriteEntry("Agrorobots", ex.Message)
            Throw New ArgumentException("90002")
        Finally
            command.Connection.Close()
        End Try
        Return dataset
    End Function
End Class
