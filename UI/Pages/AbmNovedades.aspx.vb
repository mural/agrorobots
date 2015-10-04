Imports EE
Imports Business

Public Class AbmNovedades
    Inherits PaginaAutorizada

    Dim novedadesBusiness As New Business.Novedades_Business
    Dim categoriaTemaBusiness As New CategoriaTema_Business

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not (Page.IsPostBack) Then
            CargarNovedades()
        End If
    End Sub

    Protected Overrides Sub TraducirComponentesDinamicos()
        CargarNovedades()
    End Sub

    Private Sub CargarNovedades()
        Me.GridView1_.DataSource = novedadesBusiness.Listar
        Me.GridView1_.DataBind()

        CargarTemas()
    End Sub

    Public Function ObtenerTema(ByVal idTema As Integer) As String
        Return categoriaTemaBusiness.Obtener(idTema).Nombre
    End Function

    Protected Sub CargarTemas()
        Dim comboTiposFooter = CType(Me.GridView1_.FooterRow.FindControl("comboTipos"), DropDownList)
        comboTiposFooter.Items.Clear()
        Dim comboTiposEdit As DropDownList = Nothing
        If GridView1_.EditIndex > -1 Then
            comboTiposEdit = CType(GridView1_.Rows(GridView1_.EditIndex).FindControl("comboTipos"), DropDownList)
            comboTiposEdit.Items.Clear()
        End If
        For Each categoriaTema In categoriaTemaBusiness.Listar()
            If Not comboTiposFooter Is Nothing Then
                comboTiposFooter.Items.Add(New ListItem(categoriaTema.Nombre, categoriaTema.ID))
            End If
            If Not comboTiposEdit Is Nothing Then
                comboTiposEdit.Items.Add(New ListItem(categoriaTema.Nombre, categoriaTema.ID))
                comboTiposEdit.SelectedIndex = GridView1_.EditIndex
            End If
        Next
    End Sub

    Protected Sub AddNew(ByVal sender As Object, ByVal e As EventArgs)
        ''Dim IdiomaID As String = DirectCast(GridView1_.FooterRow _
        ''     .FindControl("txtIdiomaID"), TextBox).Text
        'Dim IdiomaID = DirectCast(Session.Item("idioma"), Idioma).ID

        'Dim Traduccion As String = DirectCast(GridView1_.FooterRow _
        '             .FindControl("txtTraduccion"), TextBox).Text
        'Dim ControlID As String = DirectCast(GridView1_.FooterRow _
        '     .FindControl("txtControl"), TextBox).Text

        'Try
        '    Dim valido = True
        '    If String.IsNullOrEmpty(IdiomaID) Or String.IsNullOrEmpty(Traduccion) Or String.IsNullOrEmpty(ControlID) Then
        '        valido = False
        '        lblMensajes.Text = String.Format(idiomas.GetTranslationById(90016), "")
        '        lblMensajes.CssClass = "formError"
        '    End If
        '    If valido Then
        '        If Not IsNumeric(IdiomaID) Or Not IsNumeric(ControlID) Then
        '            valido = False
        '            lblMensajes.Text = String.Format(idiomas.GetTranslationById(90017), "")
        '        End If
        '    End If
        '    If valido Then
        '        idioma_Control_Business.CrearTraduccion(IdiomaID, Traduccion, ControlID)
        '        lblMensajes.Text = idiomas.GetTranslationById(90046) 'Se proceso la solicitud con éxito.
        '    End If
        'Catch ex As Exception
        '    lblMensajes.Text = idiomas.GetTranslationById(90045) 'No se pudo procesar la solicitud.
        'End Try

        'GridView1_.EditIndex = -1
        'CargarNovedades()()

        'IdiomManager.GetIdiomManager.CargarTraduccionesByUsuario(usuario.Idioma)
        ''recargar la pagina
        'Response.Redirect(Request.RawUrl)
    End Sub

    Protected Sub Edit(ByVal sender As Object, ByVal e As GridViewEditEventArgs)
        GridView1_.EditIndex = e.NewEditIndex
    End Sub
    Protected Sub CancelEdit(ByVal sender As Object, ByVal e As GridViewCancelEditEventArgs)
        GridView1_.EditIndex = -1
        CargarNovedades()
    End Sub
    Protected Sub Update(ByVal sender As Object, ByVal e As GridViewUpdateEventArgs)
        'Dim ID As String = DirectCast(GridView1_.Rows(e.RowIndex) _
        '                             .FindControl("lblID"), Label).Text
        'Dim Traduccion As String = DirectCast(GridView1_.Rows(e.RowIndex) _
        '                             .FindControl("txtTraduccionName"), TextBox).Text

        'Dim valido = True
        'If String.IsNullOrEmpty(ID) Or String.IsNullOrEmpty(Traduccion) Then
        '    valido = False
        '    lblMensajes.Text = String.Format(idiomas.GetTranslationById(90016), "")
        'End If

        'If valido Then
        '    idioma_Control_Business.UpdateIdiomaById(ID, Traduccion)
        '    lblMensajes.Text = String.Format(idiomas.GetTranslationById(90017), "")
        'End If

        'GridView1_.EditIndex = -1
        'CargarNovedades()()

        'IdiomManager.GetIdiomManager.CargarTraduccionesByUsuario(usuario.Idioma)
        ''recargar la pagina
        'Response.Redirect(Request.RawUrl)
    End Sub

    Protected Sub Delete(ByVal sender As Object, ByVal e As EventArgs)
        Dim lnkRemove As LinkButton = DirectCast(sender, LinkButton)

        novedadesBusiness.Borrar(lnkRemove.CommandArgument)

        GridView1_.EditIndex = -1
        CargarNovedades()
    End Sub

    Protected Sub OnPaging(ByVal sender As Object, ByVal e As GridViewPageEventArgs)
        CargarNovedades()
        GridView1_.PageIndex = e.NewPageIndex
        GridView1_.DataBind()
        lblMensajes.Text = ""
    End Sub

End Class