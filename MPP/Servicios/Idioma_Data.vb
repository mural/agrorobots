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

    Function ActualizarIdioma(ByVal idiomaID As Integer, ByVal descripcion As String) As Boolean
        Dim oDatos As New DAL.Datos
        Dim hdatos As New Hashtable
        Dim DS As New DataSet

        hdatos.Add("@ID", idiomaID)
        hdatos.Add("@Desc", descripcion)

        Return oDatos.Escribir("UpdateIdioma", hdatos)
    End Function

    Function CrearIdioma(ByVal idiomaID As Integer, ByVal descripcion As String) As Boolean
        Dim oDatos As New DAL.Datos
        Dim hdatos As New Hashtable
        Dim DS As New DataSet

        hdatos.Add("@IdiomaID", idiomaID)
        hdatos.Add("@IdiomaDesc", descripcion)

        Return oDatos.Escribir("CreateIdioma", hdatos)
    End Function

    Function BorrarIdioma(ByVal idiomaID As Integer) As Boolean
        Dim oDatos As New DAL.Datos
        Dim hdatos As New Hashtable
        Dim DS As New DataSet

        hdatos.Add("@IdiomaID", idiomaID)

        Return oDatos.Escribir("DeleteIdioma", hdatos)
    End Function
End Class