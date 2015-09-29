Imports EE
Imports Business
Imports Business.Idiomas
Imports System.Threading
Imports System.Globalization

Public MustInherit Class PaginaGenerica
    Inherits System.Web.UI.Page

    Protected usuario As Usuario
    Protected idiomas As IdiomManager
    Protected servidorApp As String

    Public ReadOnly CULTURA_ARG As String = "es-AR" 'por defecto

    Protected Sub CargaInicial(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        servidorApp = ConfigurationManager.AppSettings.Get("serverNamePort").ToString

        'iniciar mensajes
        Helper.ActualizarMensajes(Session)
    End Sub

    Protected Sub CargarUsuario(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            usuario = Session.Item("user")
            idiomas = IdiomManager.GetIdiomManager


            If usuario Is Nothing Then
                Session.Clear()
                FormsAuthentication.SignOut()
                'Bitacora_Business.Logear("Sesion", "sesion expirada", "no identificado")
            End If

        Catch ex As Exception
        End Try
    End Sub

    Protected Overrides Sub InitializeCulture()
        Dim culturaActual = Application.Item(Variables.CULTURA_CODIGO_ACTUAL)
        If culturaActual Is Nothing Then
            culturaActual = CULTURA_ARG
        End If
        Thread.CurrentThread.CurrentCulture = CultureInfo.CreateSpecificCulture(culturaActual)
        Thread.CurrentThread.CurrentUICulture = New CultureInfo(CStr(culturaActual))
    End Sub

    Private Shared _mensajeBorrar As String
    Public Shared Property MensajeBorrar() As String
        Get
            Return _mensajeBorrar
        End Get
        Set(ByVal value As String)
            _mensajeBorrar = value
        End Set
    End Property

    Protected Sub CargaIdiomas(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        MensajeBorrar = IdiomManager.GetIdiomManager().GetTranslationById(80002)
    End Sub

    Protected Sub Inicio(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreRenderComplete
        Traducir()
    End Sub

    Public Sub Traducir()
        Static start_time As DateTime
        Static stop_time As DateTime
        Dim elapsed_time As TimeSpan
        start_time = Now

        TraducirLoopingControls(Me)
        TraducirComponentesDinamicos()

        stop_time = Now
        elapsed_time = stop_time.Subtract(start_time)
        Debug.Write("Traducido en: ")
        Debug.WriteLine(elapsed_time)
    End Sub

    Protected MustOverride Sub TraducirComponentesDinamicos()

    Public Sub TraducirLoopingControls(ByVal oControl As Control)
        Dim frmCtrl As Control
        Dim oArrayList = New ArrayList
        For Each frmCtrl In oControl.Controls
            If Not String.IsNullOrEmpty(frmCtrl.ID) Then
                If frmCtrl.ID.Contains("_") Then
                    Try
                        If TypeOf frmCtrl Is RequiredFieldValidator Then
                            CType(frmCtrl, RequiredFieldValidator).Text = String.Format(idiomas.GetTranslationById(90016), idiomas.GetTranslationById(CType(frmCtrl, BaseValidator).ID.Split("_")(1)))
                        ElseIf TypeOf frmCtrl Is CustomValidator Then
                            'traduccion manual
                        ElseIf TypeOf frmCtrl Is Label Then
                            CType(frmCtrl, Label).Text = idiomas.GetTranslationById(CType(frmCtrl, Label).ID.Split("_")(1))
                        ElseIf TypeOf frmCtrl Is Button Then
                            CType(frmCtrl, Button).Text = idiomas.GetTranslationById(CType(frmCtrl, Button).ID.Split("_")(1))
                        ElseIf TypeOf frmCtrl Is LinkButton Then
                            CType(frmCtrl, LinkButton).Text = idiomas.GetTranslationById(CType(frmCtrl, LinkButton).ID.Split("_")(1))
                        ElseIf TypeOf frmCtrl Is CheckBox Then
                            CType(frmCtrl, CheckBox).Text = idiomas.GetTranslationById(CType(frmCtrl, CheckBox).ID.Split("_")(1))
                        ElseIf TypeOf frmCtrl Is GridView Then
                            For Each header As DataControlField In DirectCast(frmCtrl, GridView).Columns
                                Try
                                    header.HeaderText = idiomas.GetTranslationById(header.HeaderText.Split("_")(1))
                                Catch ex As Exception
                                End Try
                            Next
                        End If
                    Catch ex As Exception
                    End Try
                End If
            End If
            If frmCtrl.HasControls Then
                TraducirLoopingControls(frmCtrl)
            End If

        Next
    End Sub

    Public Sub RecargarPagina()
        'recargar la pagina
        Response.Redirect(Request.RawUrl)
    End Sub

    'usado en cuenta o donde no hay usuario
    Protected Sub CargarIdiomaSeleccionado()
        If Application.Item("idiomaIDseleccionado") Is Nothing Then
            idiomas.CargarTraduccionesByUsuario(New Idioma(1, "-", ""))
        Else
            idiomas.CargarTraduccionesByUsuario(New Idioma(Application.Item("idiomaIDseleccionado"), "-", ""))
        End If
    End Sub

    Public Function UsuarioLogueado() As Boolean
        If usuario Is Nothing Then
            Return False
        End If
        Return True
    End Function

    Public Sub IrInicioUsuarioSiEstaLoguedo()
        If UsuarioLogueado() Then
            FormsAuthentication.RedirectFromLoginPage(usuario.Nombre, False)
        End If
    End Sub

    Public Function ObtenerImagen(image As Object) As String
        If image Is Nothing Then
            Return ""
        End If
        Return "data:image/png;base64," + Convert.ToBase64String(image)
    End Function

    Public Function ObtenerImagenUsuario(image As Object) As String
        Dim imagenUsuario = ObtenerImagen(image)
        If imagenUsuario = "" Then
            Return "/Imagenes/avatar.gif"
        End If
        Return imagenUsuario
    End Function

End Class
