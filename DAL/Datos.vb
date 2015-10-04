Imports System.Data.SqlClient
Imports System.Configuration

Public Class Datos
    Private Shared _datos
    Private Sub New()
    End Sub
    Public Shared Function InstanciaDatos() As Datos
        If IsNothing(_datos) Then
            _datos = New Datos
        End If
        Return _datos
    End Function

    Public Property RespuestaEscritura
    Private Cnn = Conexion.GetObjConexion()
    Private Tranx As SqlTransaction
    Private Cmd As SqlCommand

    Public Function Leer(ByVal consulta As String, ByVal hdatos As Hashtable) As DataSet

        Dim Ds As New DataSet
        Cmd = New SqlCommand

        Cmd.Connection = Cnn
        Cmd.CommandText = consulta
        Cmd.CommandType = CommandType.StoredProcedure

        If Not hdatos Is Nothing Then
            'si la hashtable no esta vacia, y tiene el dato q busco 
            For Each dato As String In hdatos.Keys
                'cargo los parametros que le estoy pasando con la Hash
                Cmd.Parameters.AddWithValue(dato, hdatos(dato))
            Next
        End If

        Dim Adaptador As New SqlDataAdapter(Cmd)
        Adaptador.Fill(Ds)
        Return Ds

    End Function

    Public Function Escribir(ByVal consulta As String, ByVal hdatos As Hashtable,
                             Optional ByVal iniciarTx As Boolean = True,
                             Optional ByVal confirmarTx As Boolean = True) As Boolean

        If Cnn.State = ConnectionState.Closed Then
            Cnn.Open()
        End If

        Try
            If iniciarTx Then
                Tranx = Cnn.BeginTransaction
            End If
            Cmd = New SqlCommand
            Cmd.Connection = Cnn
            Cmd.CommandText = consulta
            Cmd.CommandType = CommandType.StoredProcedure
            Cmd.Transaction = Tranx

            If Not hdatos Is Nothing Then
                For Each dato As String In hdatos.Keys
                    'cargo los parametros que le estoy pasando con la Hash
                    Cmd.Parameters.AddWithValue(dato, hdatos(dato))
                Next
            End If

            RespuestaEscritura = Cmd.ExecuteScalar
            If confirmarTx Then
                Tranx.Commit()
                Cnn.Close()
            End If
            Return True

        Catch ex As Exception
            Tranx.Rollback()
            Cnn.Close()
            Return False
        End Try

    End Function

    Public Function EscribirIniciandoTransaccion(ByVal consulta As String, ByVal hdatos As Hashtable) As Boolean
        Return Escribir(consulta, hdatos, True, False)
    End Function

    Public Function EscribirContinuandoTransaccion(ByVal consulta As String, ByVal hdatos As Hashtable) As Boolean
        Return Escribir(consulta, hdatos, False, False)
    End Function

    Public Function EscribirCerrandoTransaccion(ByVal consulta As String, ByVal hdatos As Hashtable) As Boolean
        Return Escribir(consulta, hdatos, False, True)
    End Function

End Class
