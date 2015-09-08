Option Explicit On
Option Strict On

Imports MPP
Imports EE
Imports System.Collections.Generic

Public Class Usuario_Business

    Public Shared ReadOnly MAX_TRIES As Integer = 3

    Function CambiarPassword(ByVal userID As Integer, ByVal password As String) As Boolean
        Dim datUser As New Usuario_Data
        If password = "" Then
            Throw New EmptyDataException
        End If

        Dim encrypter As MyEncrypter = MyEncrypter.GetMyEncripter
        password = encrypter.GetHash(password)

        Return datUser.CambiarPassword(userID, password)
    End Function

    Public Sub Alta(ByRef obj As Usuario)
        Dim datUser As New Usuario_Data
        obj.SetLanguage(New Idioma(1, ""))
        If obj.Password = "" Then
            Throw New EmptyDataException
        End If

        Dim encrypter As MyEncrypter = MyEncrypter.GetMyEncripter
        obj.Password = encrypter.GetHash(obj.Password)

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

    Public Function ObtenerUsuarios(ByVal completarIdioma As Boolean) As List(Of Usuario)
        Dim datUser As New Usuario_Data
        If Not completarIdioma Then
            Return datUser.ObtenerUsuarios()
        Else
            Dim usuarios = datUser.ObtenerUsuarios()

            Dim datIdioma As New Idioma_Data
            Dim idiomas = datIdioma.ObtenerIdiomas()

            For Each usuario As Usuario In usuarios
                For Each idioma As Idioma In idiomas
                    If idioma.ID.Equals(usuario.Idioma.ID) Then
                        usuario.Idioma = idioma
                        Exit For
                    End If
                Next
            Next
            Return usuarios
        End If
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
            Dim datIdioma As New Idioma_Data
            Dim idiomas = datIdioma.ObtenerIdiomas()
            For Each idioma As Idioma In idiomas
                If idioma.ID.Equals(obj.Idioma.ID) Then
                    obj.Idioma = idioma
                    Exit For
                End If
            Next

            returnVal = True
            obj.Intentos = 0
            'Bitacora_Business.Logear(Bitacora_Business.LOG_IN_TYPE, Bitacora_Business.LOG_IN_OK, obj.UserName)
            Bitacora_Business.Logear("Login", "Login exitoso", obj.UserName)

        Else
            obj.Intentos += 1

            If obj.Intentos >= MAX_TRIES Then
                obj.Activo = False
                Me.Modificacion(obj)
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