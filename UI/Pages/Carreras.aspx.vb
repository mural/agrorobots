Imports Business
Imports EE.ElementoAcademico

Public Class Carreras
    Inherits PaginaGenerica

    Dim elementoAcademico_Business As New ElementoAcademico_Business

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not (Page.IsPostBack) Then
            CargarElementosAcademicos()
        End If
    End Sub

    Private Sub CargarElementosAcademicos()
        Try
            Me.GridView1_.DataSource = elementoAcademico_Business.ListarPorEstado(ElementoAcademicoEnum.Disponible)
            Me.GridView1_.DataBind()
        Catch e As Exception
        End Try
    End Sub

    Protected Overrides Sub TraducirComponentesDinamicos()

    End Sub

    Protected Sub Selection(ByVal sender As Object, ByVal e As EventArgs)
        Dim lnkSelect As LinkButton = DirectCast(sender, LinkButton)

        Response.Redirect(PaginasConocidas.CATALOGO_DETALLE + "?id=" + lnkSelect.CommandArgument)

    End Sub

End Class