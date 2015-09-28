Imports System.Net.Mail
Imports System.Net.Mime
Imports System.Net
Imports System.Web.Services.Description

Public Class EmailManager

    Public Shared Function EnviarEmail(server As HttpServerUtility, destinatario As String, asunto As String, cuerpo As String) As Boolean
        Try
            Const CdoReferenceTypeName = 1
            Dim objMail, objBP
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
            objMail.htmlBody += "<html><body><h1>" + asunto + "</h1><br/><img src=""cid:agrorobots.png""><br/><br/><div>"
            objMail.htmlBody += cuerpo
            objMail.htmlBody += "</div></body></html>"

            objBP = objMail.AddRelatedBodyPart(server.MapPath("/Imagenes/agrorobots.png"), "agrorobots.png", CdoReferenceTypeName)
            objBP.Fields.Item("urn:schemas:mailheader:Content-ID") = "<agrorobots.png>"
            objBP.Fields.Update()


            objMail.Send()

            Return True
        Catch ex As Exception
            Return False
        End Try
    End Function

End Class
