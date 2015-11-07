Imports EE
Imports Business

Public Class MiCursada
    Inherits PaginaAutorizada

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not (Page.IsPostBack) Then
            CargarCursada()
        End If
    End Sub

    Protected Overrides Sub TraducirComponentesDinamicos()
        CargarCursada()
        TraducirLoopingControls(Me)
    End Sub

    Private Sub CargarCursada()
        Me.GridView1_.DataSource = usuario.ElementosAcademicos
        Me.GridView1_.DataBind()
    End Sub

    Protected Sub OnPaging(ByVal sender As Object, ByVal e As GridViewPageEventArgs)
        CargarCursada()
        GridView1_.PageIndex = e.NewPageIndex
        GridView1_.DataBind()
    End Sub

    Protected Sub Material(ByVal sender As Object, ByVal e As EventArgs)
        Dim link As ImageButton = DirectCast(sender, ImageButton)
        Response.Redirect(PaginasConocidas.VISTA_MATERIAL + "?id=" + link.CommandArgument)
    End Sub

    Protected Sub Examen(ByVal sender As Object, ByVal e As EventArgs)
        Dim link As ImageButton = DirectCast(sender, ImageButton)
        Response.Redirect(PaginasConocidas.EXAMENES_ALUMNOS + "?id=" + link.CommandArgument)
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