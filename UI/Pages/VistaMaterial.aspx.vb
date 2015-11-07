Imports EE
Imports Business
Imports EE.ElementoAcademico

Public Class VistaMaterial
    Inherits PaginaAutorizada

    Dim elementoAcademicoBusiness As New Business.ElementoAcademico_Business

    Dim idElementoAcademico As String
    Dim materialBusiness As New MaterialDeEstudio_Business
    Dim materialDeEstudio As New MaterialDeEstudio

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        idElementoAcademico = Request.QueryString("id")
        Dim idElementoAcademicoInt As Integer
        If Not String.IsNullOrEmpty(idElementoAcademico) And Integer.TryParse(idElementoAcademico, idElementoAcademicoInt) And Not elementoAcademicoBusiness.Obtener(idElementoAcademicoInt) Is Nothing Then
            CargarMateriales()
        Else
            Response.Redirect(PaginasConocidas.HOME)
        End If
        materialDeEstudio = Session("materialDeEstudio")
    End Sub

    Protected Overrides Sub TraducirComponentesDinamicos()
        CargarMateriales()
        TraducirLoopingControls(Me)
    End Sub

    Private Sub CargarMateriales()
        Me.GridView1_.DataSource = materialBusiness.ListarPorElementoAcademico(CInt(idElementoAcademico))
        Me.GridView1_.DataBind()
    End Sub


    Protected Sub OnPaging(ByVal sender As Object, ByVal e As GridViewPageEventArgs)
        CargarMateriales()
        GridView1_.PageIndex = e.NewPageIndex
        GridView1_.DataBind()
    End Sub


    Protected Sub GridView1_SelectedIndexChanging(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewSelectEventArgs) Handles GridView1_.SelectedIndexChanging
        Dim pageFactor = GridView1_.PageIndex * GridView1_.PageSize
        Session("materialDeEstudio") = materialBusiness.ListarPorElementoAcademico(idElementoAcademico).ElementAt(pageFactor + e.NewSelectedIndex)
        materialDeEstudio = Session("materialDeEstudio")
    End Sub

End Class