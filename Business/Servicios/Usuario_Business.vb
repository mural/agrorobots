Option Explicit On
Option Strict On

Imports DAL
Imports DTO
Imports System.Collections.Generic


Public Class Usuario_Business

    Dim MAX_TRIES As Integer = 3

    Public Sub Alta(ByRef obj As Usuario)
        Dim datUser As New Usuario_Data
        obj.SetLanguage(New Idioma(1, ""))
        If obj.Password = "" Then
            Throw New EmptyDataException
        End If

        datUser.Alta(obj)

        Dim servicio_DV As New Servicio_Digitos
        servicio_DV.CalcularDigitoH("ID=" & CStr(obj.ID), "Usuario")
    End Sub

    Public Sub Baja(ByRef obj As Usuario)
        Dim datUser As New Usuario_Data
        datUser.Baja(obj)
    End Sub

    Public Sub Modificacion(ByRef obj As Usuario)
        Dim usu_data As New Usuario_Data
        usu_data.Modificacion(obj)

        Dim servicio_DV As New Servicio_Digitos
        servicio_DV.CalcularDigitoH("ID=" & CStr(obj.ID), "Usuario")
    End Sub

    Public Function ObtenerUsuarios() As List(Of Usuario)
        Dim datUser As New Usuario_Data
        Return datUser.ObtenerUsuarios()
    End Function

    Private Function Validar(ByVal obj As Usuario) As Boolean
        Validar = False
    End Function

    Public Function ValidarLogUser(ByRef obj As Usuario) As Boolean
        Dim returnVal As Boolean = False
        Dim passWord As String = obj.Password

        Dim usu_data As New Usuario_Data
        usu_data.ConsultarByUsu(obj)

        If obj.ID = 0 AndAlso IsNothing(obj.Apellido) AndAlso IsNothing(obj.Nombre) Then
            Return False
        End If

        If Not obj.Activo Then
            Throw New IntentosLoginException()
        End If

        Dim encrypter As MyEncrypter = MyEncrypter.GetMyEncripter

        If obj.Password = encrypter.GetHash(passWord) Then
            returnVal = True
            obj.Intentos = 0
            'Bitacora_Business.Logear(Bitacora_Business.LOG_IN_TYPE, Bitacora_Business.LOG_IN_OK, obj.UserName)
            Bitacora_Business.Logear("Login", "Login exitoso", obj.UserName)

        Else
            obj.Intentos += 1

            If obj.Intentos >= MAX_TRIES Then
                obj.Activo = False
                Throw New IntentosLoginException()
            End If
            returnVal = False

            'Bitacora_Business.Logear(Bitacora_Business.LOG_IN_TYPE, Bitacora_Business.LOG_IN_ERROR, obj.UserName)
            Bitacora_Business.Logear("Login", "Login insatisfactorio", obj.UserName)
            ' & obj.Intentos & "/" & obj.Activo
        End If

        Me.Modificacion(obj)

        Return returnVal

    End Function
End Class