Option Explicit On
Option Strict On

Imports DTO
Imports System.Data.SqlClient

Public Class Familia_Data
    Inherits Component_Data

    ''' 
    ''' <param name="obj"></param>
    Public Sub Alta(ByRef obj As Familia)
        Dim con As SqlConnection = Connection.GetObjConnextion
        Dim trx As SqlTransaction = Nothing

        Try
            con.Open()
            trx = con.BeginTransaction
        Catch ex As Exception
            Throw New ArgumentException("90001")
        End Try

        Dim params As New Parameters
        params.SetStringParameter("@name", obj.Name)
        params.SetStringParameter("@desc", obj.Descricion)
        Dim cmd As SqlCommand = Data.GetCommand("NewFamilia", con, params, trx)

        Try
            obj.ID = CInt(cmd.ExecuteScalar())
        Catch ex As Exception
            trx.Rollback()
            con.Close()
            Throw New ArgumentException("90007")
        Finally
            cmd.Dispose()
        End Try

        For Each c As Component In DirectCast(obj, Familia).GetComponents
            Dim params3 As New Parameters
            params3.SetIntParameter("@child", c.ID)
            params3.SetIntParameter("@parent", obj.ID)

            Dim cmd3 As SqlCommand = Data.GetCommand("AsignarCompAFam", con, params3, trx)
            Try
                cmd3.ExecuteNonQuery()
            Catch ex As Exception
                trx.Rollback()
                con.Close()
                Throw New ArgumentException("90007")
            End Try
        Next

        Try
            trx.Commit()
        Catch ex As Exception
            Throw New ArgumentException("90009")
        End Try

        con.Close()
    End Sub

    ''' 
    ''' <param name="obj"></param>
    Public Sub Baja(ByVal obj As Familia)
        Dim con As SqlConnection = Connection.GetObjConnextion
        Dim trx As SqlTransaction = Nothing

        Try
            con.Open()
            trx = con.BeginTransaction
        Catch ex As Exception
            Throw New ArgumentException("90001")
        End Try

        Dim params2 As New Parameters
        params2.SetIntParameter("@parent", obj.ID)
        Dim cmd2 As SqlCommand = Data.GetCommand("CleanFamily", con, params2, trx)

        Try
            cmd2.ExecuteNonQuery()
        Catch ex As Exception
            trx.Rollback()
            con.Close()
            Throw New ArgumentException("90008")
        End Try

        Dim params As New Parameters
        params.SetIntParameter("@id", obj.ID)
        Dim cmd As SqlCommand = Data.GetCommand("DeleteFamilia", con, params, trx)

        Try
            cmd.ExecuteNonQuery()
        Catch ex As Exception
            trx.Rollback()
            con.Close()
            Throw New ArgumentException("90008")
        Finally
            cmd.Dispose()
        End Try

        Try
            trx.Commit()
        Catch ex As Exception
            Throw New ArgumentException("90009")
        End Try
        con.Close()
    End Sub

    Public Overrides Sub ModificarComp(ByVal obj As DTO.Component)
        MyBase.ModificarComp(obj)

        Dim con As SqlConnection = Connection.GetObjConnextion
        Dim trx As SqlTransaction = Nothing
        Try
            con.Open()
            trx = con.BeginTransaction
        Catch ex As Exception
            Throw New ArgumentException("90001")
        End Try

        Dim params As New Parameters
        params.SetIntParameter("@ID", obj.ID)
        params.SetStringParameter("@name", obj.Name)
        params.SetStringParameter("@desc", obj.Descricion)
        Dim cmd As SqlCommand = Data.GetCommand("UpdateFamilia", con, params, trx)

        Dim params2 As New Parameters
        params2.SetIntParameter("@parent", obj.ID)
        Dim cmd2 As SqlCommand = Data.GetCommand("CleanFamily", con, params2, trx)

        Try
            cmd.ExecuteNonQuery()
            cmd2.ExecuteNonQuery()
        Catch ex As Exception
            trx.Rollback()
            con.Close()
            Throw New ArgumentException("90007")
        End Try

        For Each c As Component In DirectCast(obj, Familia).GetComponents
            Dim params3 As New Parameters
            params3.SetIntParameter("@child", c.ID)
            params3.SetIntParameter("@parent", obj.ID)

            Dim cmd3 As SqlCommand = Data.GetCommand("AsignarCompAFam", con, params3, trx)
            Try
                cmd3.ExecuteNonQuery()
            Catch ex As Exception
                trx.Rollback()
                con.Close()
                Throw New ArgumentException("90007")
            End Try

        Next
        Try
            trx.Commit()
        Catch ex As Exception
            Throw New ArgumentException("90009")
        End Try

        con.Close()
    End Sub

    Public Function ObtenerFamilias() As System.Collections.Generic.List(Of DTO.Familia)
        Dim con As SqlConnection = Connection.GetObjConnextion
        Dim cmd As SqlCommand = Data.GetCommand("GetAllFamilies", con)

        Dim dt As DataTable

        Try
            dt = Data.GetDataSet(cmd, "componente").Tables(0)
        Catch ex As Exception
            Throw ex
        End Try

        Dim lstfam As New List(Of Familia)

        For Each dr As DataRow In dt.Rows
            Dim fam As New Familia( _
                                      CInt(dr("ID")), _
                                      CStr(dr("Nombre")), _
                                      CStr(dr("Descripcion")))
            lstfam.Add(fam)
        Next

        Return lstfam
    End Function

    Public Shared Function LoadPatentesOfFamily(ByVal Familia_Id As Integer, ByVal NameOfGroup As String, ByVal DescriptionOfGroup As String) As Familia
        Dim con As SqlConnection = Connection.GetObjConnextion
        Dim cmd As SqlCommand = Data.GetCommand("GetComponentsByFamily", con)
        Dim params As New Parameters
        params.SetIntParameter("@fam", Familia_Id)

        cmd.Parameters.AddRange(params.GetSQLParameter.ToArray)

        Dim dt As DataTable

        Try
            dt = Data.GetDataSet(cmd, "componente").Tables(0)
        Catch ex As Exception
            Throw ex
        End Try


        Dim fam As New Familia(Familia_Id, NameOfGroup, DescriptionOfGroup)

        For Each dr As DataRow In dt.Rows
            If IsDBNull(dr("Control_ID")) Then
                fam.AddComponent(Familia_Data.LoadPatentesOfFamily(CInt(dr("ID")), CStr(dr("Nombre")), CStr(dr("Descripcion"))))
            Else
                fam.AddComponent(New Patente(CInt(dr("ID")), CStr(dr("Nombre")), CStr(dr("Descripcion")), CInt(dr("Control_ID"))))
            End If
        Next

        Return fam
    End Function

End Class ' Familia_Data