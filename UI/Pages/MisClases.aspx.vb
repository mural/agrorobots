Imports EE
Imports Business

Public Class MisClases
    Inherits PaginaAutorizada

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not (Page.IsPostBack) Then
            CargarClases()
        End If
    End Sub

    Protected Overrides Sub TraducirComponentesDinamicos()
        CargarClases()
        TraducirLoopingControls(Me)
    End Sub

    Private Sub CargarClases()
        Me.GridView1_.DataSource = usuario.ElementosAcademicos
        Me.GridView1_.DataBind()
    End Sub

    Protected Sub OnPaging(ByVal sender As Object, ByVal e As GridViewPageEventArgs)
        CargarClases()
        GridView1_.PageIndex = e.NewPageIndex
        GridView1_.DataBind()
    End Sub

    Protected Sub Material(ByVal sender As Object, ByVal e As EventArgs)
        Dim link As ImageButton = DirectCast(sender, ImageButton)
        Response.Redirect(PaginasConocidas.EDICION_MATERIAL + "?id=" + link.CommandArgument)
    End Sub

    Protected Sub Examen(ByVal sender As Object, ByVal e As EventArgs)
        Dim link As ImageButton = DirectCast(sender, ImageButton)
        Response.Redirect(PaginasConocidas.EDICION_EXAMEN + "?id=" + link.CommandArgument)
    End Sub

    Protected Sub Foro(ByVal sender As Object, ByVal e As EventArgs)
        Dim link As ImageButton = DirectCast(sender, ImageButton)
        Response.Redirect(PaginasConocidas.CATALOGO_DETALLE + "?id=" + link.CommandArgument)
    End Sub
End Class