Option Explicit On
Option Strict On

Imports EE
Imports System.Data.SqlClient

Public Class Candidato_Data

    ''' <summary>
    ''' 'Retorna todas los candidatos
    ''' </summary>
    ''' <returns></returns>
    ''' <remarks></remarks>
    Public Function ObtenerCandidatos() As System.Collections.Generic.List(Of Candidato)
        Dim con As SqlConnection = Connection.GetObjConnextion
        Dim cmd As SqlCommand = Data.GetCommand("GetAllCandidatos", con)

        Dim DT As DataTable

        Try
            DT = Data.GetDataSet(cmd, "Candidatos").Tables(0)
        Catch ex As Exception
            Throw ex
        End Try

        Dim lst As New List(Of Candidato)

        For Each row As DataRow In DT.Rows
            Dim perfil As New Perfil(CInt(row("ID_Perfil")), CStr(row("Nombre")), CStr(row("Apellido")), CStr(row("Email")), Nothing)
            Dim obj As New Candidato(CInt(row("ID")), perfil)

            lst.Add(obj)
        Next

        Return lst
    End Function

End Class
