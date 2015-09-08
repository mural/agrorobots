Imports EE
Imports Business
Imports Business.Idiomas

Public Class AbmPermisos
    Inherits PaginaGenerica

    Dim familia_Business As New Familia_Business
    Dim component_Business As New Component_Business
    Dim usuario_Business As New Usuario_Business
    Dim usuario As Usuario
    Dim familiaSeleccionada As Integer = 0

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        usuario = Session.Item("user")
        familiaSeleccionada = Session.Item("familiaSeleccionada")
        If Not (Page.IsPostBack) Then
            CargarFamilias()
        End If
    End Sub

    Protected Overrides Sub TraducirComponentesDinamicos()
        CargarFamilias()
        If Not (Page.IsPostBack) Then
            CargarPatentes()
            CargarPermisosPorFamiliaSeleccionada()
        End If

        TraducirLoopingControls(Me)
    End Sub

    Private Sub CargarPermisosPorFamiliaSeleccionada()
        CargarPermisosPorFamilia(familia_Business.ObtenerFamilias(Session.Item("familiaSeleccionada")))
        Me.lblFamiliaSeleccionada.Text = familia_Business.ObtenerFamilias(Session.Item("familiaSeleccionada")).Name
    End Sub

    Private Sub CargarFamilias()
        Me.GridView1_.DataSource = familia_Business.ObtenerFamilias
        Me.GridView1_.DataBind()
    End Sub

    Private Sub CargarPatentes()
        Me.GridView2_.DataSource =
            component_Business.ObtenerPatentes()
        Me.GridView2_.DataBind()
    End Sub

    Private Sub CargarPermisosPorFamilia(ByRef familia As Familia)
        'Limpiar permisos
        For Each gridViewRow As GridViewRow In Me.GridView2_.Rows
            DirectCast(gridViewRow.FindControl("cbItem"), CheckBox).Checked = False
        Next

        component_Business.ObtenerPermisosDeFamilia(familia)

        For Each patente As Patente In familia.GetComponents
            For Each gridViewRow As GridViewRow In Me.GridView2_.Rows
                Dim ID As Integer = DirectCast(gridViewRow.FindControl("lblID"), Label).Text
                If patente.ID.Equals(ID) Then
                    DirectCast(gridViewRow.FindControl("cbItem"), CheckBox).Checked = True
                End If
            Next
        Next
    End Sub

    Protected Sub GridView1_SelectedIndexChanging(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewSelectEventArgs) Handles GridView1_.SelectedIndexChanging
        Session.Item("familiaSeleccionada") = e.NewSelectedIndex

        CargarPatentes()
        CargarPermisosPorFamiliaSeleccionada()

    End Sub


    Protected Sub btnActualizar_405_Click(sender As Object, e As EventArgs) Handles btnActualizar_405.Click
        Dim familiaUpdate = familia_Business.ObtenerFamilias(Session.Item("familiaSeleccionada"))
        Dim permisos As New List(Of Component)

        For Each gridViewRow As GridViewRow In Me.GridView2_.Rows
            If DirectCast(gridViewRow.FindControl("cbItem"), CheckBox).Checked = True Then
                Dim ID As Integer = DirectCast(gridViewRow.FindControl("lblID"), Label).Text
                For Each patente As Patente In component_Business.ObtenerPatentes()
                    If patente.ID.Equals(ID) Then
                        permisos.Add(patente)
                    End If
                Next
            End If
        Next
        familiaUpdate.NuevosPermisos(permisos)
        familia_Business.Modificacion(familiaUpdate)

        'Cargar nuevamente los permisos de usuario si tiene el rol (familia) modificado
        Dim compDinam As New Component_Business
        compDinam.ObtenerComponentsOfUser(usuario)
        Session("usuario") = usuario

        'recargar la pagina
        Response.Redirect(Request.RawUrl)
    End Sub

    Protected Sub AddNew(ByVal sender As Object, ByVal e As EventArgs)
        Dim Nombre As String = DirectCast(GridView1_.FooterRow _
             .FindControl("txtName"), TextBox).Text
        Dim Descripcion As String = DirectCast(GridView1_.FooterRow _
                     .FindControl("txtDescripcion"), TextBox).Text

        Dim valido = True
        If String.IsNullOrEmpty(Nombre) Or String.IsNullOrEmpty(Descripcion) Then
            valido = False
            lblMensajes.Text = String.Format(IdiomManager.GetIdiomManager.GetTranslationById(90016), "")
            lblMensajes.CssClass = "formError"
        End If
        If valido Then
            Dim nuevaFamilia = New Familia(0, Nombre, Descripcion)
            If familia_Business.Alta(nuevaFamilia) Then
                lblMensajes.Text = IdiomManager.GetIdiomManager.GetTranslationById(80001)
            Else
                lblMensajes.Text = IdiomManager.GetIdiomManager.GetTranslationById(90040)
            End If
        End If

        Session.Item("familiaSeleccionada") = GridView1_.Rows.Count

        GridView1_.EditIndex = -1
        CargarFamilias()
        CargarPermisosPorFamiliaSeleccionada()
    End Sub

    Protected Sub Edit(ByVal sender As Object, ByVal e As GridViewEditEventArgs)
        GridView1_.EditIndex = e.NewEditIndex
        CargarFamilias()
    End Sub
    Protected Sub CancelEdit(ByVal sender As Object, ByVal e As GridViewCancelEditEventArgs)
        GridView1_.EditIndex = -1
        CargarFamilias()
    End Sub
    Protected Sub Update(ByVal sender As Object, ByVal e As GridViewUpdateEventArgs)
        Dim ID As String = DirectCast(GridView1_.Rows(e.RowIndex) _
                             .FindControl("lblID"), Label).Text
        Dim Nombre As String = DirectCast(GridView1_.Rows(e.RowIndex) _
                             .FindControl("txtName"), TextBox).Text
        Dim Descripcion As String = DirectCast(GridView1_.Rows(e.RowIndex) _
                                     .FindControl("txtDescripcion"), TextBox).Text

        Dim valido = True
        If String.IsNullOrEmpty(ID) Or String.IsNullOrEmpty(Nombre) Or String.IsNullOrEmpty(Descripcion) Then
            valido = False
            lblMensajes.Text = String.Format(IdiomManager.GetIdiomManager.GetTranslationById(90016), "")
        End If

        If valido Then
            Dim familiaModificada = New Familia(ID, Nombre, Descripcion)
            If familia_Business.Modificacion(familiaModificada) Then
                lblMensajes.Text = IdiomManager.GetIdiomManager.GetTranslationById(80001)
            Else
                lblMensajes.Text = IdiomManager.GetIdiomManager.GetTranslationById(90040)
            End If
        End If

        GridView1_.EditIndex = -1
        CargarFamilias()
    End Sub

    Protected Sub Delete(ByVal sender As Object, ByVal e As EventArgs)
        Dim lnkRemove As LinkButton = DirectCast(sender, LinkButton)

        familia_Business.Baja(lnkRemove.CommandArgument)
        Session.Item("familiaSeleccionada") = 0

        GridView1_.EditIndex = -1
        CargarFamilias()
        CargarPermisosPorFamiliaSeleccionada()
    End Sub
End Class