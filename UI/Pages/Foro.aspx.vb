Imports Business

Public Class Foro
    Inherits PaginaAutorizada

    Dim foroBusiness As New Foro_Business
    Dim elementoAcademicoBusiness As New Business.ElementoAcademico_Business
    Dim usuarioBusiness As New Usuario_Business
    Dim idElementoAcademico As String

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        idElementoAcademico = Request.QueryString("id")
        Dim idElementoAcademicoInt As Integer
        If Not String.IsNullOrEmpty(idElementoAcademico) And Integer.TryParse(idElementoAcademico, idElementoAcademicoInt) And Not elementoAcademicoBusiness.Obtener(idElementoAcademicoInt) Is Nothing Then
            If usuarioBusiness.PoseeElementoAcademico(usuario, idElementoAcademico) Then
                CargarComentarios()
            Else
                Response.Redirect(PaginasConocidas.HOME)
            End If
        Else
            Response.Redirect(PaginasConocidas.HOME)
        End If
    End Sub

    Protected Overrides Sub TraducirComponentesDinamicos()
        CargarComentarios()
        TraducirLoopingControls(Me)
    End Sub

    Private Sub CargarComentarios()
        Me.GridComentarios.DataSource = foroBusiness.ListarPorElementoAcademico(CInt(idElementoAcademico))
        Me.GridComentarios.DataBind()
    End Sub

    Protected Sub Comentar_135_Click(sender As Object, e As EventArgs) Handles Comentar_135.Click
        Dim comentarioNuevo = New EE.Foro
        comentarioNuevo.IdElementoAcademico = CInt(idElementoAcademico)
        comentarioNuevo.IdUsuario = usuario.ID
        comentarioNuevo.Fecha = Date.Now
        comentarioNuevo.Comentario = comentario.Text
        comentarioNuevo.EsProfesor = usuarioBusiness.EsProfesor(usuario)
        foroBusiness.Crear(comentarioNuevo)

        RecargarPagina()
    End Sub

End Class