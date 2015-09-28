Imports Business
Imports Business.Idiomas
Imports EE

Public Class Base
    Inherits System.Web.UI.MasterPage

    Protected usuario As Usuario
    Protected idiomas As IdiomManager
    Dim idiomaBusiness As New Idioma_Business
    Dim usuario_Business As New Usuario_Business

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        idiomas = IdiomManager.GetIdiomManager

        If Not Page.IsPostBack Then
            For Each idiomaDisponible In idiomaBusiness.ObtenerIdiomas
                comboIdiomas.Items.Add(New ListItem(idiomaDisponible.Descripcion, idiomaDisponible.ID))
            Next
            'Si hay un usuario cargo su idioma
            usuario = Session.Item("user")
            If Not usuario Is Nothing Then
                comboIdiomas.SelectedValue = usuario.Idioma.ID

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

        'Si hay un usuario le guardo el idioma elegido
        usuario = Session.Item("user")
        If Not usuario Is Nothing Then
            Dim idiomaSeleccionado = idiomaBusiness.ObtenerIdiomaPorId(comboIdiomas.SelectedValue)
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
            idiomas.CargarTraduccionesByUsuario(New Idioma(1, "-"))
        Else
            idiomas.CargarTraduccionesByUsuario(New Idioma(Application.Item("idiomaIDseleccionado"), "-"))
        End If
    End Sub
End Class