Option Explicit On
Option Strict On

Imports EE
Imports System.Data.SqlClient

Public Class Empleado_Data

    ''' <summary>
    ''' 'Retorna todos los empledos
    ''' </summary>
    ''' <returns></returns>
    ''' <remarks></remarks>
    Public Function ObtenerEmpleados() As System.Collections.Generic.List(Of Empleado)
        Dim con As SqlConnection = Connection.GetObjConnextion
        Dim cmd As SqlCommand = Data.GetCommand("GetAllEmpleados", con)

        Dim DT As DataTable

        Try
            DT = Data.GetDataSet(cmd, "Empleados").Tables(0)
        Catch ex As Exception
            Throw ex
        End Try

        Dim lst As New List(Of Empleado)

        For Each row As DataRow In DT.Rows
            Dim cargo As New Producto(CInt(row("ID")), CStr(row("Descripcion")), CInt(row("Valor")))
            Dim perfil As New Perfil(CInt(row("ID_Perfil")), CStr(row("Nombre")), CStr(row("Apellido")), CStr(row("Email")), Nothing)
            Dim obj As New Empleado(CInt(row("ID")), CDbl(row("sueldo")), CDate(row("fecha_ingreso")), CDate(row("fecha_ascenso")), perfil, cargo)

            lst.Add(obj)
        Next

        Return lst
    End Function

End Class