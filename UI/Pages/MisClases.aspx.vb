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
        Me.GridView1_.DataSource = Helper.ElementosAcademicosEnCurso(usuario.ElementosAcademicos)
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

    Protected Sub ExamenEdicion(ByVal sender As Object, ByVal e As EventArgs)
        Dim link As ImageButton = DirectCast(sender, ImageButton)
        Response.Redirect(PaginasConocidas.EDICION_EXAMEN + "?id=" + link.CommandArgument)
    End Sub

    Protected Sub ExamenCorregir(ByVal sender As Object, ByVal e As EventArgs)
        Dim link As ImageButton = DirectCast(sender, ImageButton)
        Response.Redirect(PaginasConocidas.EXAMENES_CORRECION + "?id=" + link.CommandArgument)
    End Sub

    Protected Sub Foro(ByVal sender As Object, ByVal e As EventArgs)
        Dim link As ImageButton = DirectCast(sender, ImageButton)
        Response.Redirect(PaginasConocidas.FORO + "?id=" + link.CommandArgument)
    End Sub

    Protected Sub Streaming(ByVal sender As Object, ByVal e As EventArgs)
        Dim link As ImageButton = DirectCast(sender, ImageButton)
        Response.Redirect(PaginasConocidas.STREAMING + "?id=" + link.CommandArgument)
    End Sub

End Class