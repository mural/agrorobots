Imports Business
Imports Business.Idiomas
Imports EE
Imports System.Threading
Imports System.Globalization

Public Class Registracion
    Inherits PaginaGenerica

    Public usuario_Business As New Usuario_Business
    Dim familia_Business As New Familia_Business

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        IrInicioUsuarioSiEstaLoguedo()

        Me.Form.DefaultButton = Me.btnRegistrar_480.UniqueID
    End Sub

    Protected Overrides Sub TraducirComponentesDinamicos()

    End Sub

    Protected Overrides Sub InitializeCulture()
        culturaActual = CULTURA_US
        MyBase.InitializeCulture()
    End Sub

    Protected Sub Registrar_Click(sender As Object, e As EventArgs) Handles btnRegistrar_480.Click
        Dim Apellido = apellidoNuevo.Text
        Dim Nombre = nombreNuevo.Text
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

        If Not vldPasswordMatch.IsValid Then
            vldPasswordMatch.Text = IdiomManager.GetIdiomManager.GetTranslationById(90030)
        End If

        If Page.IsValid Then
            Try
                Dim nuevoUsuario = New Usuario(Activo, Admin, Apellido, 0, Nothing, 0, Nombre, Password, UserName, Email)
                nuevoUsuario.AddComponent(familia_Business.ObtenerFamiliaAlumno) 'Alumno por defecto
                usuario_Business.Alta(nuevoUsuario)

                emailRegistro()
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
        apellidoNuevo.Text = ""
        nombreNuevo.Text = ""
        usuarioNuevo.Text = ""
        emailNuevo.Text = ""
        passwordNuevo.Text = ""
        passwordRepetidoNuevo.Text = ""
    End Sub

    Protected Sub emailRegistro()
        Dim asunto = idiomas.GetTranslationById(62) 'Registracion en Agrorobots E-Learning
        'Para activar su usuario ingrese a
        Dim cuerpo = idiomas.GetTranslationById(63) + " http://" + servidorApp + "/Pantalla_Login.aspx?usuarioactivar=" + usuarioNuevo.Text
        If EmailManager.EnviarEmail(Server, emailNuevo.Text, asunto, cuerpo) Then
            Resultado.Text = idiomas.GetTranslationById(64) 'Email enviado, verifique su casilla
        Else
            Resultado.Text = idiomas.GetTranslationById(65) 'Error de envio de email.
        End If
    End Sub

    Protected Sub cvldUser_ServerValidate(source As Object, args As ServerValidateEventArgs) Handles cvldUser_23.ServerValidate
        If Not Validaciones.MinimaLongitud(args, cvldUser_23, 4) Then
            Exit Sub
        End If
    End Sub

    Protected Sub cvldPass_27_ServerValidate(source As Object, args As ServerValidateEventArgs) Handles cvldPass_27.ServerValidate
        If Not Validaciones.MinimaLongitud(args, cvldPass_27, 4) Then
            Exit Sub
        End If
    End Sub
End Class