Imports EE
Imports Business

Public Class CarrerasDetalle
    Inherits PaginaGenerica

    Dim elementoAcademico_Business As New ElementoAcademico_Business
    Dim idElementoAcademico As String
    Dim elementoAcademico As ElementoAcademico

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        idElementoAcademico = Request.QueryString("id")
        If Not String.IsNullOrEmpty(idElementoAcademico) Then
            CargarElementoAcademico()
            lblTitulo.Text = elementoAcademico.Nombre
            navActual.Text = elementoAcademico.Nombre
        Else
            Response.Redirect(PaginasConocidas.HOME)
        End If
    End Sub

    Private Sub CargarElementoAcademico()
        Try
            elementoAcademico = elementoAcademico_Business.Obtener(CInt(idElementoAcademico))
        Catch e As Exception
        End Try
    End Sub

    Protected Overrides Sub TraducirComponentesDinamicos()

    End Sub
End Class