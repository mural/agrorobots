Imports DTO
Imports Business

Public Class Backup
    Inherits System.Web.UI.Page

    Dim usuario As Usuario

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        usuario = Session.Item("user")
        If usuario.Admin = False Then
            Response.Redirect("Pantalla_Principal.aspx")
        End If
    End Sub

    Protected Sub BackupBtn_Click(ByVal sender As Object, ByVal e As EventArgs) Handles BackupBtn.Click
        Dim path As String = BackupText.Text
        If System.IO.Directory.Exists(path) Then
            Dim backUper As New Servicio_BackUp
            Try
                Dim backupDestination As String = path & "\agrorobots_" & Today.Day.ToString("00") & "-" & Today.Month.ToString("00") & "-" & Today.Year.ToString & ".bak"
                backUper.CrearBackUp(backupDestination)

                BackupLabel.Text = "Backup realizado"
                Bitacora_Business.Logear("Backup", "Backup realizado", usuario.UserName)
            Catch ex As Exception
                BackupLabel.Text = "Error creando el Backup"
                Bitacora_Business.Logear("Backup", "Error creando el Backup", usuario.UserName)
            End Try
        End If
    End Sub

    Protected Sub RestoreBtn_Click(ByVal sender As Object, ByVal e As EventArgs) Handles RestoreBtn.Click
        Dim path As String = RestoreText.Text
        If System.IO.File.Exists(path) Then
            Dim backUper As New Servicio_BackUp
            Try
                backUper.RestoreBackUp(path)

                RestoreLabel.Text = "Restore realizado"
                Bitacora_Business.Logear("Restore", "Restore realizado", usuario.UserName)
            Catch ex As Exception
                RestoreLabel.Text = "Error realizando el Restore"
                Bitacora_Business.Logear("Restore", "Error realizando el Restore", usuario.UserName)
            End Try
        End If
    End Sub
End Class