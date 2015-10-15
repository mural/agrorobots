Imports EE
Imports Business

Public Class CarrerasDetalle
    Inherits PaginaGenerica

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

    Private Sub CargarElementoAcademico()
        Try
            elementoAcademico = elementoAcademico_Business.Obtener(CInt(idElementoAcademico))

            navActual.Text = elementoAcademico.Nombre
            lblTitulo.Text = elementoAcademico.Nombre
            lblDescripcion.Text = elementoAcademico.Descripcion
            lblDuracion.Text = elementoAcademico.Duracion
            lblClases.Text = elementoAcademico.Clases
            lblPrecio.Text = elementoAcademico.Precio
            lblCupo.Text = elementoAcademico.Cupo
            lblFechaInicio.Text = elementoAcademico.FechaInicio
        Catch e As Exception
        End Try
    End Sub

    Protected Overrides Sub TraducirComponentesDinamicos()

    End Sub

    Protected Sub inscribirse_Click(sender As Object, e As EventArgs) Handles inscribirse_118.Click
        'comprobar sesion
        If UsuarioLogueado() Then
            'Response.Redirect(PaginasConocidas.INSCRIPCION + "?id=" + idElementoAcademico)
            Dim carritoSesion As List(Of ElementoAcademico) = Session("carrito")
            If carritoSesion Is Nothing Then
                carritoSesion = New List(Of ElementoAcademico)
            End If
            If Not carritoSesion.Contains(elementoAcademico) Then
                carritoSesion.Add(elementoAcademico)
            End If

            Session("carrito") = carritoSesion

            Response.Redirect(PaginasConocidas.CARRITO)
        Else
            Response.Redirect(PaginasConocidas.LOGIN + "?inscribir=" + idElementoAcademico)
        End If
    End Sub
End Class