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
            CargarPermisosPorFamilia(familia_Business.ObtenerFamilias(Session.Item("familiaSeleccionada")))
            Me.lblFamiliaSeleccionada.Text = familia_Business.ObtenerFamilias(Session.Item("familiaSeleccionada")).Name
        End If

        TraducirLoopingControls(Me)
    End Sub

    Private Sub CargarFamilias()
        Me.GridView1_.DataSource = familia_Business.ObtenerFamilias
        Me.GridView1_.DataBind()
    End Sub

    Private Sub CargarPatentes()
        Me.GridView2_.DataSource =
            component_Business.ObtenerPatentesDisponiblesPorFamilia(familia_Business.ObtenerFamilias(Session.Item("familiaSeleccionada")).ID)
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
        CargarPermisosPorFamilia(familia_Business.ObtenerFamilias(Session.Item("familiaSeleccionada")))

        Me.lblFamiliaSeleccionada.Text = familia_Business.ObtenerFamilias(Session.Item("familiaSeleccionada")).Name

    End Sub


    Protected Sub btnActualizar_405_Click(sender As Object, e As EventArgs) Handles btnActualizar_405.Click
        Dim familiaUpdate = familia_Business.ObtenerFamilias(Session.Item("familiaSeleccionada"))
        Dim permisos As New List(Of Component)

        For Each gridViewRow As GridViewRow In Me.GridView2_.Rows
            If DirectCast(gridViewRow.FindControl("cbItem"), CheckBox).Checked = True Then
                Dim ID As Integer = DirectCast(gridViewRow.FindControl("lblID"), Label).Text
                For Each patente As Patente In component_Business.ObtenerPatentesDisponiblesPorFamilia(familiaUpdate.ID)
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
End Class