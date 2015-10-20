Imports EE
Imports Business
Imports Business.Idiomas
Imports MPP

Public Class Login
    Public Sub LogearUsuario(ByRef obj As Usuario)
        Dim user_dinam As New Usuario_Business
        Dim restore As New Servicio_BackUp_Data

        If Not user_dinam.ValidarLogUser(obj) Then
            Throw New ArgumentException("-1")
            Exit Sub
        Else
            Dim idMange As IdiomManager = IdiomManager.GetIdiomManager
            idMange.SetIdiom(obj.Idioma)

            Dim compDinam As New Component_Business
            compDinam.ObtenerComponentsOfUser(obj)

            Dim elemDinam As New ElementoAcademico_Business
            obj.ElementosAcademicos = elemDinam.ObtenerPorUsuario(obj.ID)
        End If
    End Sub

    Public Function activarUsuario(usuarioActivar As String) As Boolean
        Dim user_dinam As New Usuario_Business
        Return user_dinam.activarUsuario(usuarioActivar)
    End Function

    Public Function recuperarClave(usuario As String, email As String) As String
        Dim user_dinam As New Usuario_Business
        Dim encrypter As MyEncrypter = MyEncrypter.GetMyEncripter

        Try
            Dim usuarioRecuperado = user_dinam.obtenerUsuario(usuario)
            If usuarioRecuperado IsNot Nothing Then
                If usuarioRecuperado.Email.Equals(email) Then

                    'Genero una nueva clave
                    Dim nuevaClave = "1234"
                    user_dinam.CambiarPassword(usuarioRecuperado.ID, nuevaClave)
                    activarUsuario(usuario)
                    Return nuevaClave
               
            End If
            End If
        Catch ex As Exception
            Return ""
        End Try
        Return ""
    End Function


End Class
