Imports Business
Imports Business.Idiomas
Imports EE
Imports System.Globalization
Imports System.Threading

Public Class Base
    Inherits System.Web.UI.MasterPage

    Protected usuario As Usuario
    Protected idiomas As IdiomManager
    Dim idiomaBusiness As New Idioma_Business
    Dim usuario_Business As New Usuario_Business

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        idiomas = IdiomManager.GetIdiomManager

        Try
        'Si hay un usuario cargo su idioma
            usuario = Session.Item("user")
        Catch ex As Exception
            ex.ToString()
        End Try

        If usuario Is Nothing Then
            PanelNoLogueado.Visible = True
            PanelLogueado.Visible = False
        Else 'hay usuario
            PanelNoLogueado.Visible = False
            PanelLogueado.Visible = True
            lblNombreUsuario.Text = usuario.Apellido
        End If

        If Not Page.IsPostBack Then
            For Each idiomaDisponible In idiomaBusiness.ObtenerIdiomas
                comboIdiomas.Items.Add(New ListItem(idiomaDisponible.Descripcion, idiomaDisponible.ID))
            Next
            If Not usuario Is Nothing Then
                comboIdiomas.SelectedValue = usuario.Idioma.ID
                Application.Item("idiomaIDseleccionado") = usuario.Idioma.ID
            Else 'sino lo tomo de la variable de Aplicacion
                If Application.Item("idiomaIDseleccionado") Is Nothing Then 'defecto espanol
                    Application.Item("idiomaIDseleccionado") = 1
                End If
                comboIdiomas.SelectedValue = Application.Item("idiomaIDseleccionado")
            End If
        End If
    End Sub

    Public Sub Logout()
        Session.Clear()
        FormsAuthentication.SignOut()
        Bitacora_Business.Logear("Logout", "Logout exitoso", HttpContext.Current.User.Identity.Name)
        Session.Item("user") = Nothing
        Response.Redirect("/Pantalla_Login.aspx")
    End Sub

    Protected Sub comboIdiomas_SelectedIndexChanged(sender As Object, e As EventArgs) Handles comboIdiomas.SelectedIndexChanged
        Application.Item("idiomaIDseleccionado") = comboIdiomas.SelectedValue
        Dim idiomaSeleccionado = idiomaBusiness.ObtenerIdiomaPorId(comboIdiomas.SelectedValue)
        Application.Item(Variables.CULTURA_CODIGO_ACTUAL) = idiomaSeleccionado.Codigo

        'Si hay un usuario le guardo el idioma elegido
        usuario = Session.Item("user")
        If Not usuario Is Nothing Then
            Dim idMange As IdiomManager = IdiomManager.GetIdiomManager
            idMange.SetIdiom(idiomaSeleccionado)
            idMange.CargarTraduccionesByUsuario(idiomaSeleccionado)
            'guardar nuevo idioma del usuario actual
            usuario.SetLanguage(idiomaSeleccionado)
            usuario_Business.Modificacion(usuario)
        End If

        CargarIdiomaSeleccionado()
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

        Thread.CurrentThread.CurrentCulture = CultureInfo.CreateSpecificCulture(Application.Item(Variables.CULTURA_CODIGO_ACTUAL))
        Thread.CurrentThread.CurrentUICulture = New CultureInfo(CStr(Application.Item(Variables.CULTURA_CODIGO_ACTUAL)))
    End Sub

End Class