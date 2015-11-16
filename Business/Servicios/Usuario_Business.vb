Option Explicit On
Option Strict On

Imports MPP
Imports EE
Imports System.Collections.Generic

Public Class Usuario_Business

    Dim familiaBusiness As New Familia_Business

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
        obj.SetLanguage(New Idioma(1, "", ""))
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

        If obj.Intentos >= MAX_TRIES Then
            Throw New IntentosLoginException()
        End If
        If Not obj.Activo Then
            Throw New NoActivoException()
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

    Public Function activarUsuario(usuarioActivar As String) As Boolean
        Try
            Dim usu_data As New Usuario_Data
            Dim usuario = New Usuario()
            usuario.UserName = usuarioActivar
            usu_data.ConsultarByUsu(usuario)
            usuario.Activo = True
            usuario.Intentos = 0
            usu_data.Modificacion(usuario)
        Catch ex As Exception
            Return False
        End Try
        Return True
    End Function

    Public Function obtenerUsuario(usuario As String) As Usuario
        Dim usuarioObtener = New Usuario()
        Try
            Dim usu_data As New Usuario_Data
            usuarioObtener.UserName = usuario
            usu_data.ConsultarByUsu(usuarioObtener)
        Catch ex As Exception
            Return Nothing
        End Try
        Return usuarioObtener
    End Function

    Public Function obtenerUsuarioPorID(usuarioID As Integer) As Usuario
        Dim usuarioObtener As Usuario
        Try
            Dim usu_data As New Usuario_Data
            usuarioObtener = usu_data.ConsultarPorId(usuarioID)
        Catch ex As Exception
            Return Nothing
        End Try
        Return usuarioObtener
    End Function

    Public Function ObtenerProfesores() As List(Of Usuario)
        Dim fliasBusiness As New Familia_Business
        Dim datUser As New Usuario_Data
        Dim profesores As New List(Of Usuario)

        For Each usuario As Usuario In datUser.ObtenerUsuarios()
            If usuario.GetFamilias.Contains(fliasBusiness.ObtenerFamiliaProfesor) Then
                profesores.Add(usuario)
            End If
        Next
        Return profesores
    End Function

    Public Function ObtenerAlumnos() As List(Of Usuario)
        Dim fliasBusiness As New Familia_Business
        Dim datUser As New Usuario_Data
        Dim alumnos As New List(Of Usuario)

        For Each usuario As Usuario In datUser.ObtenerUsuarios()
            If usuario.GetFamilias.Contains(fliasBusiness.ObtenerFamiliaAlumno) Then
                alumnos.Add(usuario)
            End If
        Next
        Return alumnos
    End Function

    Function EsAlumno(usuario As Usuario) As Boolean
        Return usuario.GetFamilias.Contains(familiaBusiness.ObtenerFamiliaAlumno)
    End Function

    Function EsProfesor(usuario As Usuario) As Boolean
        Return usuario.GetFamilias.Contains(familiaBusiness.ObtenerFamiliaProfesor)
    End Function

    Function ObtenerUsuariosFiltrados(username As String, email As String, nombre As String) As List(Of Usuario)
        Dim filtrado = New List(Of Usuario)
        For Each usuario In ObtenerUsuarios(True)
            Dim valida = True
            If Not username Is Nothing Then
                If Not String.IsNullOrEmpty(username) And Not usuario.UserName.Contains(username) Then
                    valida = False
                End If
            End If
            If Not email Is Nothing Then
                If Not String.IsNullOrEmpty(email) And Not usuario.Email.Contains(email) Then
                    valida = False
                End If
            End If
            If Not nombre Is Nothing Then
                If Not String.IsNullOrEmpty(nombre) And Not usuario.Nombre.Contains(nombre) Then
                    valida = False
                End If
            End If
            If valida Then
                filtrado.Add(usuario)
            End If
        Next
        Return filtrado
    End Function

    Function PoseeElementoAcademico(usuario As Usuario, elemento As ElementoAcademico) As Boolean
        For Each elemAcademico As ElementoAcademico In Usuario.ElementosAcademicos
            If elemAcademico.CodigoAcademico = elemento.CodigoAcademico Then
                Return True
            End If
        Next
        Return False
    End Function

    Function PoseeElementoAcademico(usuario As Usuario, elemento As Integer) As Boolean
        Dim elementoAcademicoBusiness As New Business.ElementoAcademico_Business
        Dim elementoAcademico = elementoAcademicoBusiness.Obtener(elemento)
        Return PoseeElementoAcademico(usuario, elementoAcademico)
    End Function

End Class