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

    Public ReadOnly CULTURA_ARG As String = "es-AR"
    Public ReadOnly CULTURA_US As String = "en-US"

    Protected culturaActual As String = CULTURA_ARG

    Protected Sub CargaInicial(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        servidorApp = ConfigurationManager.AppSettings.Get("serverNamePort").ToString
    End Sub

    Protected Sub CargarUsuario(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        usuario = Session.Item("user")
        idiomas = IdiomManager.GetIdiomManager

        If usuario Is Nothing Then
            Session.Clear()
            FormsAuthentication.SignOut()
            'Bitacora_Business.Logear("Sesion", "sesion expirada", "no identificado")
        End If
    End Sub

    Protected Overrides Sub InitializeCulture()
        Thread.CurrentThread.CurrentCulture = _
            CultureInfo.CreateSpecificCulture(culturaActual)
        Thread.CurrentThread.CurrentUICulture = New  _
            CultureInfo(culturaActual)
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

End Class
