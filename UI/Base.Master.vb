Imports Business
Imports Business.Idiomas
Imports EE

Public Class Base
    Inherits System.Web.UI.MasterPage

    Protected idiomas As IdiomManager
    Dim idiomaBusiness As New Idioma_Business

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        idiomas = IdiomManager.GetIdiomManager

        If Not Page.IsPostBack Then
            For Each idiomaDisponible In idiomaBusiness.ObtenerIdiomas
                comboIdiomas.Items.Add(New ListItem(idiomaDisponible.Descripcion, idiomaDisponible.ID))
            Next
            If Application.Item("idiomaIDseleccionado") Is Nothing Then ''defecto espanol
                Application.Item("idiomaIDseleccionado") = 1
            End If
            comboIdiomas.SelectedValue = Application.Item("idiomaIDseleccionado")
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