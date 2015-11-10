Imports EE
Imports Business
Imports EE.ElementoAcademico
Imports System.IO

Public Class VistaMaterial
    Inherits PaginaAutorizada

    Dim elementoAcademicoBusiness As New Business.ElementoAcademico_Business
    Dim usuarioBusiness As New Usuario_Business

    Dim idElementoAcademico As String
    Dim materialBusiness As New MaterialDeEstudio_Business
    Dim materialDeEstudio As New MaterialDeEstudio

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        idElementoAcademico = Request.QueryString("id")
        Dim idElementoAcademicoInt As Integer
        If Not String.IsNullOrEmpty(idElementoAcademico) And Integer.TryParse(idElementoAcademico, idElementoAcademicoInt) And Not elementoAcademicoBusiness.Obtener(idElementoAcademicoInt) Is Nothing Then
            If usuarioBusiness.PoseeElementoAcademico(usuario, idElementoAcademico) Then
                CargarMateriales()
            Else
                Response.Redirect(PaginasConocidas.HOME)
            End If
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

        ltrDetalle.Text = materialDeEstudio.Detalle + "<br/>"
        fechaLimite.Text = materialDeEstudio.FechaMaxVisita.ToString

        ltrContenido.Text = ""
        pdf.Attributes.Remove("src")
        video.Attributes.Remove("src")

        ltrContenido.Visible = False
        pdf.Visible = False
        video.Visible = False

        If materialDeEstudio.Tipo.Equals("HTML") Then
            ltrContenido.Text = materialDeEstudio.Contenido + "<br/>"
            ltrContenido.Visible = True
        End If

        If materialDeEstudio.Tipo.Equals("PDF") And Not materialDeEstudio.Archivo Is Nothing Then
            Dim documentBinary As Byte() = DirectCast(materialDeEstudio.Archivo, Byte())
            Dim fStream As New FileStream(Server.MapPath("~/Archivos/") & "/" & "material.pdf", FileMode.Create)
            fStream.Write(documentBinary, 0, documentBinary.Length)
            fStream.Close()
            fStream.Dispose()

            pdf.Attributes.Add("src", "/Scripts/ViewerJS/index.html#/Archivos/material.pdf")
            pdf.Visible = True
        End If

        If materialDeEstudio.Tipo.Equals("VIDEO") Then
            Dim codigoVideo = materialDeEstudio.Contenido
            Try
                'ejemplo: https://www.youtube.com/watch?v=DUyLI02DqLA
                codigoVideo = codigoVideo.Substring(codigoVideo.LastIndexOf("watch?v=") + 8) '8 es el largo de: watch?v=
            Catch ex As Exception
            End Try
            video.Attributes.Add("src", "https://www.youtube.com/embed/" + codigoVideo)
            video.Visible = True
        End If
    End Sub

End Class