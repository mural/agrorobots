Option Explicit On
Option Strict On

Imports EE
Imports System.Data.SqlClient

Public Class Idioma_Data
    Public Function ObtenerIdiomas() As List(Of Idioma)
        Dim con As SqlConnection = Connection.GetObjConnextion
        Dim cmd As SqlCommand = Data.GetCommand("GetAllIdioms", con)

        Dim dt As DataTable

        Try
            dt = Data.GetDataSet(cmd, "Idioma").Tables(0)
        Catch ex As Exception
            Throw ex
        End Try

        Dim lstIdiom As New List(Of Idioma)

        For Each dr As DataRow In dt.Rows
            Dim Idiom As New Idioma( _
                                      CInt(dr("ID")), _
                                      CStr(dr("Nombre")))
            lstIdiom.Add(Idiom)
        Next

        Return lstIdiom
    End Function
End Class