Imports Business

Public Class CarrerasDetalle
    Inherits PaginaGenerica

    Dim elementoAcademico_Business As New ElementoAcademico_Business
    Dim idElementoAcademico As String

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        idElementoAcademico = Request.QueryString("id")
        If Not String.IsNullOrEmpty(idElementoAcademico) Then
            CargarElementosAcademicos()
            lblTitulo.Text = "Carrera " + idElementoAcademico
        Else
            Response.Redirect("SinPermisos.aspx")
        End If
    End Sub

    Private Sub CargarElementosAcademicos()
        Try
            elementoAcademico_Business.Obtener(CInt(idElementoAcademico))
        Catch e As Exception
        End Try
    End Sub

    Protected Overrides Sub TraducirComponentesDinamicos()

    End Sub
End Class