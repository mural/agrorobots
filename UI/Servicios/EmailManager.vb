Public Class EmailManager

    Public Shared Function EnviarEmail(server As HttpServerUtility, destinatario As String, asunto As String, cuerpo As String) As Boolean
        Try
            Dim objMail
            objMail = server.CreateObject("CDO.Message")
            Dim servidorSMTP, emailOrigen, claveOrigen
            servidorSMTP = "smtp.gmail.com"
            emailOrigen = "mural86@gmail.com"  'cuenta que envia
            claveOrigen = "tgceusmsjjpfzvyd"   'pass

            objMail.Configuration.Fields.Item("http://schemas.microsoft.com/cdo/configuration/sendusing") = 2
            objMail.Configuration.Fields.Item("http://schemas.microsoft.com/cdo/configuration/smtpserver") = servidorSMTP
            objMail.Configuration.Fields.Item("http://schemas.microsoft.com/cdo/configuration/smtpauthenticate") = 1
            objMail.Configuration.Fields.Item("http://schemas.microsoft.com/cdo/configuration/smtpserverport") = 465
            objMail.Configuration.Fields.Item("http://schemas.microsoft.com/cdo/configuration/smtpusessl") = True
            objMail.Configuration.Fields.Item("http://schemas.microsoft.com/cdo/configuration/sendusername") = emailOrigen
            objMail.Configuration.Fields.Item("http://schemas.microsoft.com/cdo/configuration/sendpassword") = claveOrigen
            objMail.Configuration.Fields.Item("http://schemas.microsoft.com/cdo/configuration/smtpconnectiontimeout") = 60
            objMail.Configuration.Fields.Update()

            objMail.Sender = emailOrigen
            objMail.To = destinatario
            objMail.Subject = asunto
            objMail.htmlBody = cuerpo
            objMail.Send()
            Return True
        Catch ex As Exception
            Return False
        End Try
    End Function

End Class
