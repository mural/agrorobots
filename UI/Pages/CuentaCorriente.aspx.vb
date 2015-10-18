Imports EE
Imports Business

Public Class CuentaCorriente
    Inherits PaginaAutorizada

    Dim ctaCteUsuarioBusiness As New Business.CtaCteUsuario_Business

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not (Page.IsPostBack) Then
            CargarMovimientos()
        End If
    End Sub

    Protected Overrides Sub TraducirComponentesDinamicos()
        CargarMovimientos()
        TraducirLoopingControls(Me)
    End Sub

    Private Sub CargarMovimientos()
        Me.GridView1_.DataSource = ctaCteUsuarioBusiness.ListarPorUsuario(usuario.ID)
        Me.GridView1_.DataBind()
    End Sub

    Protected Sub OnPaging(ByVal sender As Object, ByVal e As GridViewPageEventArgs)
        CargarMovimientos()
        GridView1_.PageIndex = e.NewPageIndex
        GridView1_.DataBind()
    End Sub
End Class