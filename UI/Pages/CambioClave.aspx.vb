Imports Business
Imports Business.Idiomas
Imports EE

Public Class CambioClave
    Inherits PaginaGenerica

    Dim usuario As Usuario
    Dim usuario_Business As New Usuario_Business

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        usuario = Session.Item("user")
    End Sub

    Protected Overrides Sub TraducirComponentesDinamicos()

    End Sub

    Protected Sub btnActualizar_405_Click(sender As Object, e As EventArgs) Handles btnActualizar_405.Click
        lblMensajes.Text = ""

        If Not vldPasswordActualRequerido.IsValid Then
            vldPasswordActualRequerido.Text = String.Format(IdiomManager.GetIdiomManager.GetTranslationById(90016),
                                         IdiomManager.GetIdiomManager.GetTranslationById(26))
        End If
        If Not vldPassword.IsValid Then
            vldPassword.Text = String.Format(IdiomManager.GetIdiomManager.GetTranslationById(90016),
                                         IdiomManager.GetIdiomManager.GetTranslationById(27))
        End If
        If Not vldConfirmPassword.IsValid Then
            vldConfirmPassword.Text = String.Format(IdiomManager.GetIdiomManager.GetTranslationById(90016),
                                         IdiomManager.GetIdiomManager.GetTranslationById(28))
        End If
        If Not vldPasswordMatch.IsValid Then
            vldPasswordMatch.Text = IdiomManager.GetIdiomManager.GetTranslationById(90030)
        End If

        If Page.IsValid Then
            Try
                usuario_Business.CambiarPassword(usuario.ID, txtConfirmPassword.Text)
                usuario.Password = MyEncrypter.GetMyEncripter.GetHash(txtConfirmPassword.Text)
                Session.Item("user") = usuario
                lblMensajes.Text = IdiomManager.GetIdiomManager.GetTranslationById(80001)
                lblMensajes.CssClass = ""
                'Vaciar
                txtPasswordActual.Text = ""
                txtPassword.Text = ""
                txtConfirmPassword.Text = ""
            Catch ex As Exception
                lblMensajes.Text = IdiomManager.GetIdiomManager.GetTranslationById(90040)
                lblMensajes.CssClass = "formError"
            End Try
        End If
    End Sub

    Protected Sub vldPasswordActualCustom_ServerValidate(source As Object, args As ServerValidateEventArgs) Handles vldPasswordActualCustom.ServerValidate
        Dim value = args.Value
        If Not MyEncrypter.GetMyEncripter.GetHash(args.Value).Equals(usuario.Password) Then
            args.IsValid = False
            vldPasswordActualCustom.Text = IdiomManager.GetIdiomManager.GetTranslationById(90031)
        End If
    End Sub

    Protected Sub vldPasswordCustom_ServerValidate(source As Object, args As ServerValidateEventArgs) Handles vldPasswordCustom.ServerValidate
        Dim value = args.Value
        If args.Value.Count < 4 Then
            args.IsValid = False
            vldPasswordCustom.Text = IdiomManager.GetIdiomManager.GetTranslationById(90036)
        End If
    End Sub
End Class