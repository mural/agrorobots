Imports EE
Imports Business

Public Class Carrito
    Inherits PaginaGenerica

    Dim carritoSesion As List(Of ElementoAcademico)

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        carritoSesion = Session("carrito")
        If Not (Page.IsPostBack) Then
            CargarCarrito()
        End If
    End Sub

    Protected Overrides Sub TraducirComponentesDinamicos()
        CargarCarrito()
        TraducirLoopingControls(Me)
    End Sub

    Private Sub CargarCarrito()
        Me.GridView1_.DataSource = carritoSesion
        Me.GridView1_.DataBind()
    End Sub

    Protected Sub Delete(ByVal sender As Object, ByVal e As EventArgs)
        Dim lnkRemove As LinkButton = DirectCast(sender, LinkButton)

        Dim borrarUsuario = New Usuario()
        borrarUsuario.ID = lnkRemove.CommandArgument
        ''quitar elemento de session

        GridView1_.EditIndex = -1
        CargarCarrito()
    End Sub

    Protected Sub inscribirse_118_Click(sender As Object, e As EventArgs) Handles inscribirse_118.Click
        Response.Redirect(PaginasConocidas.INSCRIPCION)
    End Sub
End Class