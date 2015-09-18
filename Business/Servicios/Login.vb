Imports EE
Imports Business
Imports Business.Idiomas
Imports MPP

Public Class Login
    Public Sub LogearUsuario(ByRef obj As Usuario)
        Dim user_dinam As New Usuario_Business
        Dim restore As New Servicio_BackUp_Data
        'Try
        'restore.TestConnection()
        'Catch ex As Exception
        '    restore.RestoreFromBackUp("C:\database.bak")
        'End Try

        If Not user_dinam.ValidarLogUser(obj) Then
            Throw New ArgumentException("-1")
            Exit Sub
        Else
            Dim idMange As IdiomManager = IdiomManager.GetIdiomManager
            idMange.SetIdiom(obj.Idioma)

            Dim compDinam As New Component_Business
            compDinam.ObtenerComponentsOfUser(obj)
        End If
    End Sub

    Public Function activarUsuario(usuarioActivar As String) As Boolean
        Dim user_dinam As New Usuario_Business
        Return user_dinam.activarUsuario(usuarioActivar)
    End Function

    Public Function recuperarClave(usuario As String, email As String) As String
        Dim user_dinam As New Usuario_Business
        Dim encrypter As MyEncrypter = MyEncrypter.GetMyEncripter

        Dim usuarioRecuperado = user_dinam.obtenerUsuario(usuario)
        If usuarioRecuperado IsNot Nothing Then
            If usuarioRecuperado.Email.Equals(email) Then
                Try
                    'Genero una nueva clave
                    Dim nuevaClave = "1234"
                    user_dinam.CambiarPassword(usuarioRecuperado.ID, nuevaClave)
                    Return nuevaClave
                Catch ex As Exception
                    Return ""
                End Try
            End If
        End If
        Return ""
    End Function


End Class
