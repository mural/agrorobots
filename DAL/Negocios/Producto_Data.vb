Option Explicit On
Option Strict On

Imports DTO
Imports System.Data.SqlClient

Public Class Producto_Data

    ''' <summary>
    ''' 'Retorna todos los Productos
    ''' </summary>
    ''' <returns></returns>
    ''' <remarks></remarks>
    Public Function ObtenerProductos() As System.Collections.Generic.List(Of Producto)
        Dim con As SqlConnection = Connection.GetObjConnextion
        'Uso el stored procedure de Productos
        Dim cmd As SqlCommand = Data.GetCommand("GetAllProductos", con)

        Dim DT As DataTable

        Try
            DT = Data.GetDataSet(cmd, "Productos").Tables(0)
        Catch ex As Exception
            'Throw ex
        End Try

        Dim lst As New List(Of Producto)

        For Each row As DataRow In DT.Rows
            Dim obj As New Producto(CInt(row("ID")), CStr(row("Descripcion")), CInt(row("Valor")))

            lst.Add(obj)
        Next

        Return lst
    End Function

End Class