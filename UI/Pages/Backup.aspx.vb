Imports EE
Imports Business

Public Class Backup
    Inherits PaginaGenerica

    Dim usuario As Usuario
    Dim serverPath As String
    Dim backupDestination As String

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        usuario = Session.Item("user")
        serverPath = Server.MapPath("~/App_Data/")
        backupDestination = serverPath & "agrorobots_" & Today.Day.ToString("00") & "-" & Today.Month.ToString("00") & "-" & Today.Year.ToString & ".bak"

        BackupText.Text = backupDestination
        BackupText.Enabled = False

        RestoreText.Text = backupDestination
        RestoreText.Enabled = False
    End Sub

    Protected Overrides Sub TraducirComponentesDinamicos()

    End Sub

    Protected Sub BackupBtn_Click(ByVal sender As Object, ByVal e As EventArgs) Handles BackupBtn_10104.Click
        'Dim path As String = BackupText.Text
        If System.IO.Directory.Exists(serverPath) Then
            Dim backUper As New Servicio_BackUp
            Try
                backUper.CrearBackUp(backupDestination)

                BackupLabel.Text = Idiomas.IdiomManager.GetIdiomManager.GetTranslationById(90014)
                Bitacora_Business.Logear("Backup", "Backup realizado", usuario.UserName)
            Catch ex As Exception
                BackupLabel.Text = Idiomas.IdiomManager.GetIdiomManager.GetTranslationById(90005)
                Bitacora_Business.Logear("Backup", "Error creando el Backup", usuario.UserName)
            End Try
        End If
    End Sub

    Protected Sub RestoreBtn_Click(ByVal sender As Object, ByVal e As EventArgs) Handles RestoreBtn_33.Click
        Dim path As String = RestoreText.Text
        If System.IO.File.Exists(path) Then
            Dim backUper As New Servicio_BackUp
            Try
                backUper.RestoreBackUp(path)

                RestoreLabel.Text = Idiomas.IdiomManager.GetIdiomManager.GetTranslationById(90015)
                Bitacora_Business.Logear("Restore", "Restore realizado", usuario.UserName)
            Catch ex As Exception
                RestoreLabel.Text = Idiomas.IdiomManager.GetIdiomManager.GetTranslationById(90006)
                Bitacora_Business.Logear("Restore", "Error realizando el Restore", usuario.UserName)
            End Try
        End If
    End Sub
End Class