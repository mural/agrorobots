Option Explicit On
Option Strict On

Imports EE
Imports System.Data.SqlClient

Public Class Idioma_Data
    Public Function ObtenerIdiomas() As List(Of Idioma)
        Dim con As SqlConnection = Connection.GetObjConnextion
        Dim cmd As SqlCommand = Data.GetCommand("IdiomasListar", con)

        Dim dt As DataTable

        Try
            dt = Data.GetDataSet(cmd, "Idioma").Tables(0)
        Catch ex As Exception
        End Try

        Dim lstIdiom As New List(Of Idioma)

        For Each dr As DataRow In dt.Rows
            Dim Idiom As New Idioma( _
                                      CInt(dr("ID")), _
                                      CStr(dr("Nombre")), _
                                      CStr(dr("Codigo")))
            lstIdiom.Add(Idiom)
        Next

        Return lstIdiom
    End Function

    Function ActualizarIdioma(ByVal idiomaID As Integer, ByVal descripcion As String, ByVal codigo As String) As Boolean
        Dim oDatos = DAL.Datos.InstanciaDatos
        Dim hdatos As New Hashtable
        Dim DS As New DataSet

        hdatos.Add("@ID", idiomaID)
        hdatos.Add("@Desc", descripcion)
        hdatos.Add("@Codigo", codigo)

        Return oDatos.Escribir("IdiomaActualizar", hdatos)
    End Function

    Function CrearIdioma(ByVal idiomaID As Integer, ByVal descripcion As String, ByVal codigo As String) As Boolean
        Dim oDatos = DAL.Datos.InstanciaDatos
        Dim hdatos As New Hashtable
        Dim DS As New DataSet

        hdatos.Add("@IdiomaID", idiomaID)
        hdatos.Add("@IdiomaDesc", descripcion)
        hdatos.Add("@Codigo", codigo)

        Return oDatos.Escribir("IdiomaCrear", hdatos)
    End Function

    Function BorrarIdioma(ByVal idiomaID As Integer) As Boolean
        Dim oDatos = DAL.Datos.InstanciaDatos
        Dim hdatos As New Hashtable
        Dim DS As New DataSet

        hdatos.Add("@IdiomaID", idiomaID)

        Return oDatos.Escribir("IdiomaBorrar", hdatos)
    End Function
End Class