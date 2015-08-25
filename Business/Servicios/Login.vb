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

            For Each familia As Familia In obj.GetFamilias()
                If familia.Name.Equals("Administrador") Then
                    obj.Admin = True
                ElseIf familia.Name.Equals("Alumno") Then
                    obj.Alumno = True
                ElseIf familia.Name.Equals("Profesor") Then
                    obj.Profesor = True
                ElseIf familia.Name.Equals("Empleado") Then
                    obj.EmpleadoAdm = True
                ElseIf familia.Name.Equals("Director") Then
                    obj.Director = True
                End If
            Next
        End If
    End Sub
End Class
