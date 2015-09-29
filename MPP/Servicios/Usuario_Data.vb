Option Explicit On
Option Strict On

Imports EE
Imports DAL

Public Class Usuario_Data

    Function CambiarPassword(ByVal userID As Integer, ByVal password As String) As Boolean
        Dim oDatos As New DAL.Datos
        Dim hdatos As New Hashtable
        Dim DS As New DataSet

        hdatos.Add("@ID", userID)
        hdatos.Add("@Password", password)

        Return oDatos.Escribir("UpdateUserPassword", hdatos)
    End Function

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
        params.SetStringParameter("@Email", obj.Email)

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
            cmd = Data.GetCommand("UsuarioBorrar", con, params)
            cmd.ExecuteNonQuery()
        Catch ex As Exception
            Throw New ArgumentException("90029")
        End Try
    End Sub

    Public Sub ConsultarByUsu(ByRef obj As Usuario)

        Dim oDatos As New DAL.Datos
        Dim hdatos As New Hashtable
        Dim DS As New DataSet

        hdatos.Add("@usu", obj.UserName)

        DS = oDatos.Leer("GetUserByUserName", hdatos)

        If DS.Tables(0).Rows.Count > 0 Then

            For Each Item As DataRow In DS.Tables(0).Rows
                obj.Activo = CBool(Item("Activo"))
                obj.Admin = CBool(Item("Admin"))
                obj.Apellido = CStr(Item("Apellido"))
                obj.ID = CInt(Item("ID"))
                obj.Intentos = CInt(Item("Intentos"))
                obj.Nombre = CStr(Item("Nombre"))
                obj.Password = CStr(Item("Password"))
                obj.SetLanguage(New Idioma(CInt(Item("Idioma_Id")), "", ""))
                obj.Email = CStr(Item("Email"))
            Next
            Return
        Else
            Return
        End If
    End Sub

    Public Function ConsultarPorId(idUsuario As Integer) As Usuario
        Dim oDatos As New DAL.Datos
        Dim hdatos As New Hashtable
        Dim DS As New DataSet
        Dim obj As New Usuario

        hdatos.Add("@IDUsuario", idUsuario)

        DS = oDatos.Leer("UsuarioObtenerPorId", hdatos)

        If DS.Tables(0).Rows.Count > 0 Then

            For Each Item As DataRow In DS.Tables(0).Rows
                obj.Activo = CBool(Item("Activo"))
                obj.Admin = CBool(Item("Admin"))
                obj.Apellido = CStr(Item("Apellido"))
                obj.ID = CInt(Item("ID"))
                obj.Intentos = CInt(Item("Intentos"))
                obj.Nombre = CStr(Item("Nombre"))
                obj.Password = CStr(Item("Password"))
                obj.SetLanguage(New Idioma(CInt(Item("Idioma_Id")), "", ""))
                obj.Email = CStr(Item("Email"))
            Next
            Return obj
        Else
            Return obj
        End If
    End Function

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
        params.SetStringParameter("@UserName", obj.UserName)
        params.SetIntParameter("@Intentos", obj.Intentos)
        params.SetStringParameter("@Email", obj.Email)
        params.SetImageParameter("@Foto", obj.Foto)

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
        cmd = Data.GetCommand("UsuarioListar", con)

        DT = Data.GetDataSet(cmd, "Usuario").Tables(0)
        Dim compData As New Component_Data

        Dim lst As New List(Of Usuario)
        For Each row As DataRow In DT.Rows
            Dim user As New Usuario( _
            CBool(row("Activo")) _
            , CBool(row("Admin")) _
            , CStr(row("Apellido")) _
            , CInt(row("ID")) _
            , New Idioma(CInt(row("Idioma_Id")), "", "") _
            , CInt(row("Intentos")) _
            , CStr(row("Nombre")) _
            , CStr(row("Password")) _
            , CStr(row("UserName")) _
            , CStr(row("Email")))

            Dim foto = row("Foto")
            If Not foto Is DBNull.Value Then
                user.Foto = CType(row("Foto"), Byte())
            End If

            compData.ObtenerComponentsOfUser(user)

            lst.Add(user)
        Next

        Return lst

    End Function

End Class