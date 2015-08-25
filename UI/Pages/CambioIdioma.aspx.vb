Imports Business
Imports Business.Idiomas
Imports EE

Public Class CambioIdioma
    Inherits PaginaGenerica

    Dim usuario As Usuario
    Dim idioma_Business As New Business.Idioma_Business
    Dim usuario_Business As New Usuario_Business

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        usuario = Session.Item("user")
        If Not (Page.IsPostBack) Then
            CargarIdiomas()
        End If
    End Sub

    Protected Overrides Sub TraducirComponentesDinamicos()
        CargarIdiomas()
        TraducirLoopingControls(Me)
    End Sub

    Private Sub CargarIdiomas()
        Me.GridView1_.DataSource = idioma_Business.ObtenerIdiomas()
        Me.GridView1_.DataBind()
    End Sub

    Protected Sub GridView1_SelectedIndexChanging(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewSelectEventArgs) Handles GridView1_.SelectedIndexChanging
        Dim pageFactor = GridView1_.PageIndex * GridView1_.PageSize
        Dim idiomaSeleccionado = idioma_Business.ObtenerIdiomas().ElementAt(pageFactor + e.NewSelectedIndex)

        Dim idMange As IdiomManager = IdiomManager.GetIdiomManager
        idMange.SetIdiom(idiomaSeleccionado)
        idMange.CargarTraduccionesByUsuario(idiomaSeleccionado)

        'guardar nuevo idioma del usuario actual
        usuario.SetLanguage(idiomaSeleccionado)
        usuario_Business.Modificacion(usuario)

        'recargar la pagina
        Response.Redirect(Request.RawUrl)
    End Sub

End Class