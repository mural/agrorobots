Imports System.Data.SqlClient
Imports System.Configuration
Imports System.Configuration.ConfigurationSettings
Imports System.IO


Public Class Connection

    Private Shared _con As SqlConnection
    Private Shared _conMaster As SqlConnection

    Public Shared Function GetObjConnextion() As SqlConnection
        If IsNothing(_con) Then
            _con = New SqlConnection(GetConnectionBuilded())
        End If

        Return _con
    End Function

    Public Shared Function GetObjConnextionMaster() As SqlConnection
        If IsNothing(_conMaster) Then
            _conMaster = New SqlConnection(GetConnectionBuilded(True))
        End If
        Return _conMaster
    End Function

    Private Shared Function GetConnectionBuilded(Optional ByVal master As Boolean = False) As String
        GetConnectionBuilded = ""
        Try
            Dim connection As ConnectionStringSettings
            If master = False Then
                connection = ConfigurationManager.ConnectionStrings("libreria")
            Else
                connection = ConfigurationManager.ConnectionStrings("master")
            End If

            Dim builder As New SqlConnectionStringBuilder(connection.ConnectionString)
            Return builder.ConnectionString
        Catch ex As Exception
            EventLog.WriteEntry("Libreria", ex.Message)
        End Try

    End Function

    Public Shared Sub ResetConnections()
        Connection._con.Dispose()
        Connection._conMaster.Dispose()
        Connection._con = Nothing
        Connection._conMaster = Nothing
    End Sub

    Private Sub New()

    End Sub
End Class
