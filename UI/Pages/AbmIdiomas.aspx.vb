Imports Business.Idiomas

Public Class AbmIdiomas
    Inherits PaginaAutorizada

    Dim idioma_Business As New Business.Idioma_Business

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not (Page.IsPostBack) Then
            CargarIdiomas()
        End If
    End Sub

    Private Sub CargarIdiomas()
        Me.GridView1_.DataSource = idioma_Business.ObtenerIdiomas()
        Me.GridView1_.DataBind()
    End Sub

    Protected Overrides Sub TraducirComponentesDinamicos()
        CargarIdiomas()
        TraducirLoopingControls(Me)
    End Sub

    Protected Sub AddNew(ByVal sender As Object, ByVal e As EventArgs)
        Dim IdiomaID As String = DirectCast(GridView1_.FooterRow _
             .FindControl("txtIdiomaID"), TextBox).Text
        Dim Descripcion As String = DirectCast(GridView1_.FooterRow _
                     .FindControl("txtDescripcion"), TextBox).Text
        Dim Codigo As String = DirectCast(GridView1_.FooterRow _
             .FindControl("txtCodigo"), TextBox).Text

        Dim valido = True
        If String.IsNullOrEmpty(IdiomaID) Or String.IsNullOrEmpty(Descripcion) Or String.IsNullOrEmpty(Codigo) Then
            valido = False
            lblMensajes.Text = String.Format(IdiomManager.GetIdiomManager.GetTranslationById(90016), "")
            lblMensajes.CssClass = "formError"
        End If
        If valido Then
            If Not IsNumeric(IdiomaID) Then
                valido = False
                lblMensajes.Text = String.Format(IdiomManager.GetIdiomManager.GetTranslationById(90017), "")
            End If
        End If
        If valido Then
            If idioma_Business.CrearIdioma(IdiomaID, Descripcion, Codigo) Then
                lblMensajes.Text = IdiomManager.GetIdiomManager.GetTranslationById(80001)
            Else
                lblMensajes.Text = IdiomManager.GetIdiomManager.GetTranslationById(90040)
            End If
        End If

        GridView1_.EditIndex = -1
        CargarIdiomas()
    End Sub

    Protected Sub Edit(ByVal sender As Object, ByVal e As GridViewEditEventArgs)
        GridView1_.EditIndex = e.NewEditIndex
        CargarIdiomas()
    End Sub
    Protected Sub CancelEdit(ByVal sender As Object, ByVal e As GridViewCancelEditEventArgs)
        GridView1_.EditIndex = -1
        CargarIdiomas()
    End Sub
    Protected Sub Update(ByVal sender As Object, ByVal e As GridViewUpdateEventArgs)
        Dim ID As String = DirectCast(GridView1_.Rows(e.RowIndex) _
                             .FindControl("lblIdiomaID"), Label).Text
        Dim Descripcion As String = DirectCast(GridView1_.Rows(e.RowIndex) _
                                     .FindControl("txtDescripcion"), TextBox).Text
        Dim Codigo As String = DirectCast(GridView1_.Rows(e.RowIndex) _
                                     .FindControl("txtCodigo"), TextBox).Text

        Dim valido = True
        If String.IsNullOrEmpty(ID) Or String.IsNullOrEmpty(Descripcion) Or String.IsNullOrEmpty(Codigo) Then
            valido = False
            lblMensajes.Text = String.Format(IdiomManager.GetIdiomManager.GetTranslationById(90016), "")
        End If

        If valido Then
            If idioma_Business.ActualizarIdioma(ID, Descripcion, Codigo) Then
                lblMensajes.Text = IdiomManager.GetIdiomManager.GetTranslationById(80001)
            Else
                lblMensajes.Text = IdiomManager.GetIdiomManager.GetTranslationById(90040)
            End If
        End If

        GridView1_.EditIndex = -1
        CargarIdiomas()
    End Sub

    Protected Sub Delete(ByVal sender As Object, ByVal e As EventArgs)
        Dim lnkRemove As LinkButton = DirectCast(sender, LinkButton)

        idioma_Business.BorrarIdioma(lnkRemove.CommandArgument)

        GridView1_.EditIndex = -1
        CargarIdiomas()
    End Sub

    Protected Sub OnPaging(ByVal sender As Object, ByVal e As GridViewPageEventArgs)
        CargarIdiomas()
        GridView1_.PageIndex = e.NewPageIndex
        GridView1_.DataBind()
        lblMensajes.Text = ""
    End Sub

End Class