Option Explicit On
Option Strict On

Imports DTO

Public Class Usuario_Data
    Public Sub Alta(ByRef obj As Usuario)
        Dim con As SqlClient.SqlConnection = Connection.GetObjConnextion
        Dim cmd As SqlClient.SqlCommand
        Dim trx As SqlClient.SqlTransaction

        Dim params As New Parameters
        params.SetBooleanParameter("@Activo", obj.Activo)
        params.SetBooleanParameter("@Admin", obj.Admin)
        params.SetStringParameter("@Apellido", obj.Apellido)
        params.SetIntParameter("@Idioma_Id", obj.Idioma.ID)
        params.SetStringParameter("@Nombre", obj.Nombre)
        params.SetStringParameter("@Password", obj.Password)
        params.SetStringParameter("@UserName", obj.UserName)

        Try
            con.Open()
            trx = con.BeginTransaction
        Catch ex As Exception
            Throw New ArgumentException("90001")
        End Try

        cmd = Data.GetCommand("NewUser", con, params, trx)

        Try
            obj.ID = CInt(cmd.ExecuteScalar())
        Catch ex As Exception
            trx.Rollback()
            con.Close()
            If ex.Message.Contains("UQ_Usuario_UserName") Then
                Throw New ArgumentException("90028")
            Else
                Throw New ArgumentException("90012")
            End If
        Finally
            cmd.Dispose()
        End Try


        Dim cmd3 As SqlClient.SqlCommand = Nothing
        Try
            For Each c As Component In obj.GetFamilias
                Dim params3 As New Parameters
                params3.SetIntParameter("@Usu_Id", obj.ID)
                params3.SetIntParameter("@Comp_Id", c.ID)
                cmd3 = Data.GetCommand("AssignPermissionToUser", con, params3, trx)

                cmd3.ExecuteNonQuery()
                cmd3.Dispose()
            Next
        Catch ex As Exception
            trx.Rollback()
            Throw New ArgumentException("90012")
        End Try

        Try
            trx.Commit()
            con.Close()
        Catch ex As Exception
            Throw New ArgumentException("90009")
        End Try

    End Sub

    Public Sub Baja(ByRef obj As Usuario)
        Dim con As SqlClient.SqlConnection = Connection.GetObjConnextion
        Dim cmd As SqlClient.SqlCommand
        Dim params As New Parameters
        params.SetIntParameter("@ID", obj.ID)
        Try
            cmd = Data.GetCommand("DeleteUser", con, params)
            cmd.ExecuteNonQuery()
        Catch ex As Exception
            Throw New ArgumentException("90029")
        End Try
    End Sub

    Public Sub ConsultarByUsu(ByRef obj As Usuario)

        Dim con As SqlClient.SqlConnection
        Dim cmd As New SqlClient.SqlCommand
        Dim params As New Parameters

        params.SetStringParameter("@usu", obj.UserName)

        con = Connection.GetObjConnextion()
        cmd = Data.GetCommand("GetUserByUserName", con)

        For Each p As SqlClient.SqlParameter In params.GetSQLParameter
            cmd.Parameters.Add(p)
        Next

        Dim dts As New DataSet

        Try
            dts = Data.GetDataSet(cmd, "Usuario")
        Catch ex As Exception
            Throw ex
        End Try

        Dim dtTable As DataTable = dts.Tables(0)

        For Each row As DataRow In dtTable.Rows
            obj.Activo = DirectCast(row("Activo"), Boolean)
            obj.Admin = DirectCast(row("Admin"), Boolean)
            obj.Apellido = DirectCast(row("Apellido"), String)
            obj.ID = DirectCast(row("ID"), Integer)
            obj.Intentos = DirectCast(row("Intentos"), Short)
            obj.Nombre = DirectCast(row("Nombre"), String)
            obj.Password = DirectCast(row("Password"), String)
            obj.SetLanguage(New Idioma(CInt(row("Idioma_Id")), ""))
        Next

        cmd.Dispose()

    End Sub

    Public Sub Modificacion(ByRef obj As Usuario)
        Dim con As SqlClient.SqlConnection
        Dim cmd As New SqlClient.SqlCommand
        Dim cmd2 As New SqlClient.SqlCommand
        Dim cmd3 As New SqlClient.SqlCommand
        Dim trx As SqlClient.SqlTransaction
        Dim params As New Parameters

        params.SetIntParameter("@ID", obj.ID)
        params.SetBooleanParameter("@Activo", obj.Activo)
        params.SetBooleanParameter("@Admin", obj.Admin)
        params.SetStringParameter("@Apellido", obj.Apellido)
        params.SetIntParameter("@Idioma_ID", obj.Idioma.ID)
        params.SetStringParameter("@Nombre", obj.Nombre)
        params.SetStringParameter("@Password", obj.Password)
        params.SetStringParameter("@UserName", obj.UserName)
        params.SetIntParameter("@Intentos", obj.Intentos)

        con = Connection.GetObjConnextion()

        Try
            con.Open()
            trx = con.BeginTransaction
        Catch ex As Exception
            Throw New ArgumentException("90001")
        End Try

        cmd = Data.GetCommand("UpdateUserByUsuOrId", con, params, trx)

        Try
            cmd.ExecuteNonQuery()
        Catch ex As Exception
            trx.Rollback()
            Throw New ArgumentException("90012")
        Finally
            cmd.Dispose()
        End Try

        If obj.PermissionsModified = True Then

            Dim params2 As New Parameters
            params2.SetIntParameter("@UsuId", obj.ID)
            cmd2 = Data.GetCommand("RemoveAllComponentesFromUsu", con, params2, trx)

            Try
                cmd2.ExecuteNonQuery()
            Catch ex As Exception
                trx.Rollback()
                Throw New ArgumentException("90012")
            Finally
                cmd2.Dispose()
            End Try


            Try
                For Each c As Component In obj.GetFamilias
                    Dim params3 As New Parameters
                    params3.SetIntParameter("@Usu_Id", obj.ID)
                    params3.SetIntParameter("@Comp_Id", c.ID)
                    cmd3 = Data.GetCommand("AssignPermissionToUser", con, params3, trx)

                    cmd3.ExecuteNonQuery()
                    cmd3.Dispose()
                Next
            Catch ex As Exception
                trx.Rollback()
                Throw New ArgumentException("90012")
            End Try

            obj.PermissionsModified = False
        End If

        Try
            trx.Commit()
            con.Close()
        Catch ex As Exception
            Throw New ArgumentException("90009")
        End Try


    End Sub

    Public Function ObtenerUsuarios() As List(Of Usuario)
        Dim con As SqlClient.SqlConnection
        Dim cmd As New SqlClient.SqlCommand
        Dim DT As DataTable

        con = Connection.GetObjConnextion
        cmd = Data.GetCommand("GetAllUsers", con)

        DT = Data.GetDataSet(cmd, "Usuario").Tables(0)
        Dim compData As New Component_Data

        Dim lst As New List(Of Usuario)
        For Each row As DataRow In DT.Rows
            Dim user As New Usuario( _
            CBool(row("Activo")) _
            , CBool(row("Admin")) _
            , CStr(row("Apellido")) _
            , CInt(row("ID")) _
            , New Idioma(CInt(row("Idioma_Id")), "") _
            , CInt(row("Intentos")) _
            , CStr(row("Nombre")) _
            , CStr(row("Password")) _
            , CStr(row("UserName")))

            compData.ObtenerComponentsOfUser(user)

            lst.Add(user)
        Next

        Return lst

    End Function
End Class