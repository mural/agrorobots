Imports EE
Imports Business
Imports Business.Idiomas

Public Class AbmPermisos
    Inherits PaginaGenerica

    Dim familia_Business As New Familia_Business
    Dim component_Business As New Component_Business
    Dim usuario As Usuario
    Dim familiaSeleccionada As Integer = 0

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        usuario = Session.Item("user")
        familiaSeleccionada = Session.Item("familiaSeleccionada")
        If Not (Page.IsPostBack) Then
            CargarFamilias()
            CargarPatentes()
        End If
    End Sub

    Protected Overrides Sub TraducirComponentesDinamicos()
        Dim cfedit As CommandField = DirectCast(GridView1_.Columns(3), CommandField)
        cfedit.SelectText = IdiomManager.GetIdiomManager.GetTranslationById(801)
    End Sub

    Private Sub CargarFamilias()
        Me.GridView1_.DataSource = familia_Business.ObtenerFamilias
        Me.GridView1_.DataBind()
    End Sub

    Private Sub CargarPatentes()
        Me.GridView2.DataSource = component_Business.ObtenerPatentes
        Me.GridView2.DataBind()

        ''CargarPermisosPorFamilia(familia_Business.ObtenerFamilias(familiaSeleccionada))
    End Sub

    Private Sub CargarPermisosPorFamilia(ByRef familia As Familia)
        'Limpiar permisos
        For Each gridViewRow As GridViewRow In Me.GridView2.Rows
            DirectCast(gridViewRow.FindControl("cbItem"), CheckBox).Checked = False
        Next

        component_Business.ObtenerPermisosDeFamilia(familia)

        For Each patente As Patente In familia.GetComponents
            For Each gridViewRow As GridViewRow In Me.GridView2.Rows
                Dim ID As Integer = DirectCast(gridViewRow.FindControl("lblID"), Label).Text
                If patente.ID.Equals(ID) Then
                    DirectCast(gridViewRow.FindControl("cbItem"), CheckBox).Checked = True
                End If
            Next
        Next
    End Sub

    Protected Sub AddNew(ByVal sender As Object, ByVal e As EventArgs)
        Dim IdiomaID As String = DirectCast(GridView1_.FooterRow _
             .FindControl("txtIdiomaID"), TextBox).Text
        Dim Traduccion As String = DirectCast(GridView1_.FooterRow _
                     .FindControl("txtTraduccion"), TextBox).Text
        Dim ControlID As String = DirectCast(GridView1_.FooterRow _
             .FindControl("txtControl"), TextBox).Text

        'familia_Business.CrearTraduccion(IdiomaID, Traduccion, ControlID)

        GridView1_.EditIndex = -1
        CargarFamilias()
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
        Dim Traduccion As String = DirectCast(GridView1_.Rows(e.RowIndex) _
                                     .FindControl("txtTraduccionName"), TextBox).Text

        'idioma_Control_Business.UpdateIdiomaById(ID, Traduccion)

        GridView1_.EditIndex = -1
        CargarFamilias()
    End Sub

    Protected Sub Delete(ByVal sender As Object, ByVal e As EventArgs)
        Dim lnkRemove As LinkButton = DirectCast(sender, LinkButton)

        'idioma_Control_Business.BorrarTraduccion(lnkRemove.CommandArgument)

        GridView1_.EditIndex = -1
        CargarFamilias()
    End Sub

    Protected Sub OnPaging(ByVal sender As Object, ByVal e As GridViewPageEventArgs)
        CargarFamilias()
        GridView1_.PageIndex = e.NewPageIndex
        GridView1_.DataBind()
    End Sub

    Protected Sub OnPaging2(ByVal sender As Object, ByVal e As GridViewPageEventArgs)
        GridView2.PageIndex = e.NewPageIndex
        GridView2.DataBind()
        CargarPatentes()
        CargarPermisosPorFamilia(familia_Business.ObtenerFamilias(Session.Item("familiaSeleccionada")))
    End Sub


    Protected Sub GridView1_SelectedIndexChanging(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewSelectEventArgs) Handles GridView1_.SelectedIndexChanging
        Session.Item("familiaSeleccionada") = e.NewSelectedIndex
        CargarPermisosPorFamilia(familia_Business.ObtenerFamilias(Session.Item("familiaSeleccionada")))

        'Fire this on update panel...
        Me.lblFamiliaActual_403.Text = "Familia seleccionada: " + familia_Business.ObtenerFamilias(Session.Item("familiaSeleccionada")).Name

    End Sub


    Protected Sub btnActualizar_405_Click(sender As Object, e As EventArgs) Handles btnActualizar_405.Click
        ''Validar que este seleccionada una familia

        Dim familiaUpdate = familia_Business.ObtenerFamilias(Session.Item("familiaSeleccionada"))
        Dim permisos As New List(Of Component)

        'Me.GridView2.AllowPaging = False
        'CargarPatentes()
        'CargarPermisosPorFamilia(familia_Business.ObtenerFamilias(Session.Item("familiaSeleccionada")))
        For Each gridViewRow As GridViewRow In Me.GridView2.Rows
            If DirectCast(gridViewRow.FindControl("cbItem"), CheckBox).Checked = True Then
                Dim ID As Integer = DirectCast(gridViewRow.FindControl("lblID"), Label).Text
                For Each patente As Patente In component_Business.ObtenerPatentes()
                    If patente.ID.Equals(ID) Then
                        permisos.Add(patente)
                    End If
                Next
            End If
        Next
        'Me.GridView2.AllowPaging = True
        'CargarPatentes()
        'CargarPermisosPorFamilia(familia_Business.ObtenerFamilias(Session.Item("familiaSeleccionada")))

        familiaUpdate.NuevosPermisos(permisos)
        familia_Business.Modificacion(familiaUpdate)

        ''Cargar nuevamente los permisos de usuario
    End Sub
End Class