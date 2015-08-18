'Option Explicit On
'Option Strict On

Imports EE
Imports System.Data.SqlClient

Public Class Component_Data
    Public Sub ObtenerComponents(ByRef obj As Component)
        Dim con As SqlConnection = Connection.GetObjConnextion
        Dim params As New Parameters
        params.SetIntParameter("@fam", obj.ID)
        Dim cmd As SqlCommand = Data.GetCommand("GetComponentsByFamily", con, params)

        Dim dt As DataTable
        Try
            dt = Data.GetDataSet(cmd, "componente").Tables(0)
        Catch ex As Exception
            Throw ex
        End Try


        For Each dr As DataRow In dt.Rows
            If IsDBNull(dr("Control_ID")) Then
                DirectCast(obj, Familia).AddComponent(Familia_Data.LoadPatentesOfFamily(CInt(dr("ID")), CStr(dr("Nombre")), CStr(dr("Descripcion"))))
            Else
                DirectCast(obj, Familia).AddComponent(New Patente(CInt(dr("ID")), CStr(dr("Nombre")), CStr(dr("Descripcion")), CInt(dr("Control_ID")), CStr(dr("URL"))))
            End If
        Next
    End Sub

    Public Sub ObtenerComponentsOfUser(ByRef obj As Usuario)
        Dim con As SqlConnection = Connection.GetObjConnextion
        Dim cmd As SqlCommand

        Try
            cmd = Data.GetCommand("GetComponentsByUsu", con)
        Catch ex As Exception
            Throw ex
        End Try

        Dim params As New Parameters
        params.SetIntParameter("@usu", obj.ID)
        cmd.Parameters.AddRange(params.GetSQLParameter.ToArray)

        Dim dt As DataTable

        Try
            dt = Data.GetDataSet(cmd, "componente").Tables(0)
        Catch ex As Exception
            Throw ex
        End Try

        For Each dr As DataRow In dt.Rows
            If IsDBNull(dr("Control_ID")) Then
                obj.AddComponent(Familia_Data.LoadPatentesOfFamily(CInt(dr("ID")), CStr(dr("Nombre")), CStr(dr("Descripcion"))))
            ElseIf IsDBNull(dr("URL")) Then
                obj.AddComponent(New Patente(CInt(dr("ID")), CStr(dr("Nombre")), CStr(dr("Descripcion")), CInt(dr("Control_ID")), ""))
            Else
                obj.AddComponent(New Patente(CInt(dr("ID")), CStr(dr("Nombre")), CStr(dr("Descripcion")), CInt(dr("Control_ID")), CStr(dr("URL"))))
            End If
        Next

    End Sub

    Public Function ObtenerAllComponentes() As System.Collections.Generic.List(Of EE.Component)
        Dim con As SqlConnection = Connection.GetObjConnextion
        Dim cmd As SqlCommand = Data.GetCommand("GetAllComponents", con)

        Dim dt As DataTable

        Try
            dt = Data.GetDataSet(cmd, "componente").Tables(0)
        Catch ex As Exception
            Throw ex
        End Try

        Dim lst As New List(Of Component)

        For Each dr As DataRow In dt.Rows
            If IsDBNull(dr("Control_ID")) Then
                lst.Add(New Familia(CInt(dr("ID")), CStr(dr("Nombre")), CStr(dr("Descripcion"))))
            Else
                lst.Add(New Patente(CInt(dr("ID")), CStr(dr("Nombre")), CStr(dr("Descripcion")), CInt(dr("Control_ID")), CStr(dr("URL"))))
            End If
        Next

        Return lst
    End Function

    Public Overridable Sub ModificarComp(ByVal obj As Component)

    End Sub

End Class