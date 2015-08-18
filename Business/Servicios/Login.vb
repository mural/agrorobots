Imports EE
Imports Business
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
            Bitacora_Business.Logear(Bitacora_Business.LOG_IN_TYPE, Bitacora_Business.LOG_IN_OK, "Test de permisos")
        End If
    End Sub
End Class
