Imports EE
Imports Business
Imports Business.Idiomas

Public Class AbmTraducciones
    Inherits PaginaGenerica

    Dim idioma_Business As New Business.Idioma_Business
    Dim idioma_Control_Business As New Business.Idioma_Control_Business
    Dim idioma As Idioma

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        usuario = Session.Item("user")
        If Not (Page.IsPostBack) Then
            CargarTraducciones()
        End If
    End Sub

    Private Sub CargarTraducciones()
        idioma = Session.Item("idioma")
        If idioma Is Nothing Then
            idioma = usuario.Idioma()
            Session.Item("idioma") = idioma
        End If
        Me.GridView1_.DataSource = idioma_Control_Business.GetIdiomsByIDWithOriginals(idioma, Session.Item("filtroTraducciones"))
        Me.GridView1_.DataBind()
    End Sub

    Private Sub CargarIdiomas()
        Me.GridView2_.DataSource = idioma_Business.ObtenerIdiomas()
        Me.GridView2_.DataBind()
    End Sub

    Protected Overrides Sub TraducirComponentesDinamicos()
        CargarIdiomas()
        CargarTraducciones()
        TraducirLoopingControls(Me)
    End Sub

    Protected Sub AddNew(ByVal sender As Object, ByVal e As EventArgs)
        'Dim IdiomaID As String = DirectCast(GridView1_.FooterRow _
        '     .FindControl("txtIdiomaID"), TextBox).Text
        Dim IdiomaID = DirectCast(Session.Item("idioma"), Idioma).ID

        Dim Traduccion As String = DirectCast(GridView1_.FooterRow _
                     .FindControl("txtTraduccion"), TextBox).Text
        Dim ControlID As String = DirectCast(GridView1_.FooterRow _
             .FindControl("txtControl"), TextBox).Text

        Try
            Dim valido = True
            If String.IsNullOrEmpty(IdiomaID) Or String.IsNullOrEmpty(Traduccion) Or String.IsNullOrEmpty(ControlID) Then
                valido = False
                lblMensajes.Text = String.Format(idiomas.GetTranslationById(90016), "")
                lblMensajes.CssClass = "formError"
            End If
            If valido Then
                If Not IsNumeric(IdiomaID) Or Not IsNumeric(ControlID) Then
                    valido = False
                    lblMensajes.Text = String.Format(idiomas.GetTranslationById(90017), "")
                End If
            End If
            If valido Then
                idioma_Control_Business.CrearTraduccion(IdiomaID, Traduccion, ControlID)
                lblMensajes.Text = idiomas.GetTranslationById(90046) 'Se proceso la solicitud con éxito.
            End If
        Catch ex As Exception
            lblMensajes.Text = idiomas.GetTranslationById(90045) 'No se pudo procesar la solicitud.
        End Try

        GridView1_.EditIndex = -1
        CargarTraducciones()

        IdiomManager.GetIdiomManager.CargarTraduccionesByUsuario(usuario.Idioma)
        'recargar la pagina
        Response.Redirect(Request.RawUrl)
    End Sub

    Protected Sub Edit(ByVal sender As Object, ByVal e As GridViewEditEventArgs)
        GridView1_.EditIndex = e.NewEditIndex
        CargarTraducciones()
    End Sub
    Protected Sub CancelEdit(ByVal sender As Object, ByVal e As GridViewCancelEditEventArgs)
        GridView1_.EditIndex = -1
        CargarTraducciones()
    End Sub
    Protected Sub Update(ByVal sender As Object, ByVal e As GridViewUpdateEventArgs)
        Dim ID As String = DirectCast(GridView1_.Rows(e.RowIndex) _
                                     .FindControl("lblID"), Label).Text
        Dim Traduccion As String = DirectCast(GridView1_.Rows(e.RowIndex) _
                                     .FindControl("txtTraduccionName"), TextBox).Text

        Dim valido = True
        If String.IsNullOrEmpty(ID) Or String.IsNullOrEmpty(Traduccion) Then
            valido = False
            lblMensajes.Text = String.Format(idiomas.GetTranslationById(90016), "")
        End If

        If valido Then
            idioma_Control_Business.UpdateIdiomaById(ID, Traduccion)
            lblMensajes.Text = String.Format(idiomas.GetTranslationById(90017), "")
        End If

        GridView1_.EditIndex = -1
        CargarTraducciones()

        IdiomManager.GetIdiomManager.CargarTraduccionesByUsuario(usuario.Idioma)
        'recargar la pagina
        Response.Redirect(Request.RawUrl)
    End Sub

    Protected Sub Delete(ByVal sender As Object, ByVal e As EventArgs)
        Dim lnkRemove As LinkButton = DirectCast(sender, LinkButton)

        idioma_Control_Business.BorrarTraduccion(lnkRemove.CommandArgument)

        GridView1_.EditIndex = -1
        CargarTraducciones()
    End Sub

    Protected Sub OnPaging(ByVal sender As Object, ByVal e As GridViewPageEventArgs)
        CargarTraducciones()
        GridView1_.PageIndex = e.NewPageIndex
        GridView1_.DataBind()
        lblMensajes.Text = ""
    End Sub

    Protected Sub GridView2_SelectedIndexChanging(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewSelectEventArgs) Handles GridView2_.SelectedIndexChanging
        Dim idiomaSeleccionado = idioma_Business.ObtenerIdiomas().ElementAt(e.NewSelectedIndex)

        Session.Item("idioma") = idiomaSeleccionado

        'recargar la pagina
        Response.Redirect(Request.RawUrl)
    End Sub

    Protected Sub buscar_31_Click(sender As Object, e As EventArgs) Handles buscar_31.Click
        Session.Item("filtroTraducciones") = txtBusqueda.Text
    End Sub

    Protected Sub limpiar_36_Click(sender As Object, e As EventArgs) Handles limpiar_36.Click
        Session.Item("filtroTraducciones") = ""

        'recargar la pagina
        Response.Redirect(Request.RawUrl)
    End Sub
End Class