Imports EE
Imports Business

Public Class ExamenesCorreccion
    Inherits PaginaAutorizada

    Dim elementoAcademicoBusiness As New Business.ElementoAcademico_Business
    Dim idElementoAcademico As String

    Dim examenBusiness As New Business.Examen_Business

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        idElementoAcademico = Request.QueryString("id")
        Dim idElementoAcademicoInt As Integer
        If Not String.IsNullOrEmpty(idElementoAcademico) And Integer.TryParse(idElementoAcademico, idElementoAcademicoInt) And Not elementoAcademicoBusiness.Obtener(idElementoAcademicoInt) Is Nothing Then
            If Not (Page.IsPostBack) Then
                CargarExamenesACorregir()
            End If
        Else
            Response.Redirect(PaginasConocidas.HOME)
        End If
    End Sub

    Protected Overrides Sub TraducirComponentesDinamicos()
        CargarExamenesACorregir()
        TraducirLoopingControls(Me)
    End Sub

    Private Sub CargarExamenesACorregir()
        Me.GridView1_.DataSource = examenBusiness.ListarPorElementoAcademico(CInt(idElementoAcademico), True)
        Me.GridView1_.DataBind()
    End Sub

    Protected Sub CorregirExamen(ByVal sender As Object, ByVal e As EventArgs)
        Dim link As ImageButton = DirectCast(sender, ImageButton)
        Response.Redirect(PaginasConocidas.CORRECCION_EXAMEN + "?id=" + link.CommandArgument)
    End Sub
End Class