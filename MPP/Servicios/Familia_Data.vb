'Option Explicit On
'Option Strict On

Imports EE
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
        params.SetStringParameter("@desc", obj.Descripcion)
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

    Public Function Baja(ByVal ID As Integer) As Boolean
        Dim oDatos = DAL.Datos.InstanciaDatos
        Dim hdatos As New Hashtable
        Dim DS As New DataSet

        hdatos.Add("@parent", ID)
        If oDatos.EscribirIniciandoTransaccion("CleanFamily", hdatos) Then

            hdatos.Clear()
            hdatos.Add("@id", ID)
            Return oDatos.EscribirCerrandoTransaccion("DeleteComponente", hdatos)
        Else
            Return False
        End If

        Return True
    End Function

    Public Overrides Sub ModificarComp(ByVal obj As EE.Component)
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
        params.SetStringParameter("@desc", obj.Descripcion)
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

    Public Function ObtenerFamilias() As System.Collections.Generic.List(Of EE.Familia)
        Dim oDatos = DAL.Datos.InstanciaDatos
        Dim hdatos As New Hashtable
        Dim DS As New DataSet

        DS = oDatos.Leer("GetAllFamilies", hdatos)

        Dim lstfam As New List(Of Familia)
        If DS.Tables(0).Rows.Count > 0 Then

            For Each Item As DataRow In DS.Tables(0).Rows
                Dim fam As New Familia(CInt(Item("ID")), CStr(Item("Nombre")), CStr(Item("Descripcion")))
                lstfam.Add(fam)
            Next
        End If

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
            ElseIf IsDBNull(dr("URL")) Then
                fam.AddComponent(New Patente(CInt(dr("ID")), CStr(dr("Nombre")), CStr(dr("Descripcion")), CInt(dr("Control_ID")), ""))
            Else
                fam.AddComponent(New Patente(CInt(dr("ID")), CStr(dr("Nombre")), CStr(dr("Descripcion")), CInt(dr("Control_ID")), dr("URL")))
            End If
        Next

        Return fam
    End Function

End Class ' Familia_Data