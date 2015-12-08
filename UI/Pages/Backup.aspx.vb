Imports EE
Imports Business

Public Class Backup
    Inherits PaginaAutorizada

    Dim serverPath As String
    Dim filename As String
    Dim virtualPath As String
    Dim backupDestination As String

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        filename = "agrorobots_" & Today.Day.ToString("00") & "-" & Today.Month.ToString("00") & "-" & Today.Year.ToString & ".bak"
        virtualPath = PaginasConocidas.DIR_ESCRITURA_APP & filename
        serverPath = PaginasConocidas.DIR_ESCRITURA_APP
        backupDestination = serverPath & filename

        BackupText.Text = backupDestination
        BackupText.Enabled = False

        ''subirBackup.
    End Sub

    Protected Overrides Sub TraducirComponentesDinamicos()

    End Sub

    Protected Sub BackupBtn_Click(ByVal sender As Object, ByVal e As EventArgs) Handles BackupBtn_10104.Click
        'Dim path As String = BackupText.Text
        If System.IO.Directory.Exists(serverPath) Then
            Dim backUper As New Servicio_BackUp
            Try
                backUper.CrearBackUp(backupDestination)

                BackupLabel.Text = idiomas.GetTranslationById(90014)
                Bitacora_Business.Logear("Backup", "Backup realizado", usuario.UserName)
            Catch ex As Exception
                BackupLabel.Text = idiomas.GetTranslationById(90005)
                Bitacora_Business.Logear("Backup", "Error creando el Backup", usuario.UserName)
            End Try
        End If
    End Sub

    Protected Sub RestoreBtn_Click(ByVal sender As Object, ByVal e As EventArgs) Handles RestoreBtn_33.Click
        Dim path As String = RestoreText.Text
        ''Dim path As String = subirBackup.FileName

        Dim backUper As New Servicio_BackUp
        Try
            backUper.RestoreBackUp(path)

            RestoreLabel.Text = idiomas.GetTranslationById(90015)
            Bitacora_Business.Logear("Restore", "Restore realizado", usuario.UserName)
        Catch ex As Exception
            RestoreLabel.Text = idiomas.GetTranslationById(90006)
            Bitacora_Business.Logear("Restore", "Error realizando el Restore", usuario.UserName)
        End Try
    End Sub


    Protected Sub descargaBackup_Click(sender As Object, e As ImageClickEventArgs) Handles descargaBackup.Click
        Try
            Response.ContentType = "application/octet-stream"
            Response.AppendHeader("Content-Disposition", "attachment; filename=" + filename)
            Response.TransmitFile(virtualPath)
            Response.End()
        Catch ex As Exception
            ex.ToString()
        End Try
    End Sub
End Class