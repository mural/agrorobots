Imports Business
Imports Business.Idiomas
Imports EE

Public Class Registracion
    Inherits PaginaGenerica

    Public usuario_Business As New Usuario_Business
    Dim familia_Business As New Familia_Business

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        IdiomManager.GetIdiomManager.CargarTraduccionesByUsuario(New Idioma(1, "Español"))
    End Sub

    Protected Overrides Sub TraducirComponentesDinamicos()

    End Sub

    Protected Sub Registrar_Click(sender As Object, e As EventArgs) Handles btnRegistrar_480.Click
        Dim Apellido = ""
        Dim Nombre = ""
        Dim Email = emailNuevo.Text
        Dim UserName = usuarioNuevo.Text
        Dim Activo = False
        Dim Admin = False
        Dim Password = passwordNuevo.Text
        Dim ConfirmPassword = passwordRepetidoNuevo.Text
        'Dim Familias = New List(Of Familia)
        'For i = 0 To lstbFamilia.GetSelectedIndices.Length - 1
        '    Familias.Add(Familia_Business.ObtenerFamilias(lstbFamilia.GetSelectedIndices(i)))
        'Next

        'If Not vldPasswordMatch.IsValid Then
        '    vldPasswordMatch.Text = IdiomManager.GetIdiomManager.GetTranslationById(90030)
        'End If

        If Page.IsValid Then
            Try
                Dim nuevoUsuario = New Usuario(Activo, Admin, Apellido, 0, Nothing, 0, Nombre, Password, UserName, Email)
                'For Each familia In Familias
                nuevoUsuario.AddComponent(familia_Business.ObtenerFamilias(0)) ''ADMIN ?
                'Next
                ''usuario_Business.Alta(nuevoUsuario)



                Vaciar()
            Catch ax As ArgumentException
                If ax.Message.Equals("90028") Then
                    Resultado.Text = IdiomManager.GetIdiomManager.GetTranslationById(90028)
                End If
            Catch ex As Exception
                Resultado.Text = IdiomManager.GetIdiomManager.GetTranslationById(90012)
            End Try
        End If
    End Sub

    Private Sub Vaciar()
        usuarioNuevo.Text = ""
        emailNuevo.Text = ""
        passwordNuevo.Text = ""
        passwordRepetidoNuevo.Text = ""
    End Sub

    Protected Sub testEmail_Click(sender As Object, e As EventArgs) Handles testEmail.Click
        Dim asunto = "Registracion en Agrorobots E-Learning"
        Dim cuerpo = "Para activar su usuario ingrese a http://localhost:49216/Pantalla_Login.aspx?usuarioactivar=" + usuarioNuevo.Text
        If EmailManager.EnviarEmail(Server, emailNuevo.Text, asunto, cuerpo) Then
            Resultado.Text = "Email enviado, verifique su casilla"
        Else
            Resultado.Text = "Error de envio, use este link ?"
        End If
    End Sub
End Class