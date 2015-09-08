Imports System.Data.SqlClient
Imports System.Configuration
Imports System.Configuration.ConfigurationSettings
Imports System.IO


Public Class Conexion

    Private Shared _con As SqlConnection
    Private Shared _conMaster As SqlConnection

    Public Shared Function GetObjConexion() As SqlConnection
        If IsNothing(_con) Then
            _con = New SqlConnection(GetStringConexion())
        End If

        Return _con
    End Function

    Public Shared Function GetObjConexionMaster() As SqlConnection
        If IsNothing(_conMaster) Then
            _conMaster = New SqlConnection(GetStringConexion(True))
        End If
        Return _conMaster
    End Function

    Private Shared Function GetStringConexion(Optional ByVal master As Boolean = False) As String
        GetStringConexion = ""
        Try
            Dim connection As ConnectionStringSettings
            If master = False Then
                connection = ConfigurationManager.ConnectionStrings("agrorobots")
            Else
                connection = ConfigurationManager.ConnectionStrings("master")
            End If

            Dim builder As New SqlConnectionStringBuilder(connection.ConnectionString)
            Return builder.ConnectionString
        Catch ex As Exception
            EventLog.WriteEntry("Agrorobots", ex.Message)
        End Try

    End Function

    Public Shared Sub ResetConexiones()
        Conexion._con.Dispose()
        Conexion._conMaster.Dispose()
        Conexion._con = Nothing
        Conexion._conMaster = Nothing
    End Sub

    Private Sub New()

    End Sub
End Class
