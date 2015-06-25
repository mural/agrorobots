Option Explicit On
Option Strict On
Imports System.Data.SqlClient
Imports DTO

Public Class Bitacora_Data


    ''' 
    ''' <param name="tipo"></param>
    ''' <param name="desc"></param>
    Public Sub Logear(ByVal tipo As String, ByVal desc As String, ByVal UserName As String)
        Dim con As SqlConnection = Connection.GetObjConnextion

        Dim params As New Parameters
        params.SetStringParameter("@tipo", tipo)
        params.SetStringParameter("@desc", desc)
        params.SetStringParameter("@user", UserName)
        Dim cmd As SqlCommand = Data.GetCommand("LogInBitagora", con, params)

        Try
            cmd.ExecuteNonQuery()
        Catch ex As Exception
            Throw ex
        Finally
            con.Close()
            cmd.Dispose()
        End Try

    End Sub

    Public Function GetItemsBitacora() As List(Of Bitacora)
        Dim con As SqlClient.SqlConnection
        Dim cmd As New SqlClient.SqlCommand
        Dim DT As DataTable

        con = Connection.GetObjConnextion
        cmd = Data.GetCommand("GetItemsBitacora", con)

        DT = Data.GetDataSet(cmd, "Bitacora").Tables(0)
        Dim compData As New Component_Data

        Dim lst As New List(Of Bitacora)
        For Each row As DataRow In DT.Rows
            Dim itemBit As New Bitacora( _
                                              CLng(row("id")), _
                                              CStr(IIf(IsDBNull(row("User")), "", row("User"))), _
                                              CStr(row("Tipo")), _
                                              CDate(row("FechaHora")), _
                                              CStr(row("Descripcion")) _
                                              )
            lst.Add(itemBit)
        Next

        Return lst

    End Function

End Class ' Bitacora_Data