Imports EE
Imports Business
Imports EE.ElementoAcademico

Public Class Streaming
    Inherits PaginaAutorizada

    Dim elementoAcademicoBusiness As New Business.ElementoAcademico_Business

    Dim idElementoAcademico As String
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        idElementoAcademico = Request.QueryString("id")
        Dim idElementoAcademicoInt As Integer
        If Not String.IsNullOrEmpty(idElementoAcademico) And Integer.TryParse(idElementoAcademico, idElementoAcademicoInt) And Not elementoAcademicoBusiness.Obtener(idElementoAcademicoInt) Is Nothing Then
            CargarStreaming()
        Else
            Response.Redirect(PaginasConocidas.HOME)
        End If

    End Sub

    Protected Overrides Sub TraducirComponentesDinamicos()
        
    End Sub

    Private Sub CargarStreaming()
        Interaction.MsgBox("Streaming!", MsgBoxStyle.Information)
    End Sub

End Class