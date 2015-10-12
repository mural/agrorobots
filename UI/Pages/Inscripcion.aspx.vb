Imports EE
Imports Business

Public Class Inscripcion
    Inherits PaginaAutorizada

    Dim elementoAcademico_Business As New ElementoAcademico_Business
    Dim idElementoAcademico As String
    Dim elementoAcademico As ElementoAcademico

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        idElementoAcademico = Request.QueryString("id")
        Dim idElementoAcademicoInt As Integer
        If Not String.IsNullOrEmpty(idElementoAcademico) And Integer.TryParse(idElementoAcademico, idElementoAcademicoInt) And Not elementoAcademico_Business.Obtener(idElementoAcademicoInt) Is Nothing Then
            CargarElementoAcademico()
        Else
            Response.Redirect(PaginasConocidas.HOME)
        End If
    End Sub

    Protected Overrides Sub TraducirComponentesDinamicos()

    End Sub

    Private Sub CargarElementoAcademico()
        Try
            elementoAcademico = elementoAcademico_Business.Obtener(CInt(idElementoAcademico))

            nav_curso.Text = elementoAcademico.Nombre
            nav_curso_link.HRef = PaginasConocidas.CATALOGO_DETALLE + "?id=" + idElementoAcademico

            'lblTitulo.Text = elementoAcademico.Nombre
            'lblDescripcion.Text = elementoAcademico.Descripcion
            'lblDuracion.Text = elementoAcademico.Duracion
            'lblClases.Text = elementoAcademico.Clases
            'lblPrecio.Text = elementoAcademico.Precio
            'lblCupo.Text = elementoAcademico.Cupo
            'lblFechaInicio.Text = elementoAcademico.FechaInicio
        Catch e As Exception
        End Try
    End Sub
End Class