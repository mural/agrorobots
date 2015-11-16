﻿Imports EE
Imports Business


Public Class Examenes
    Inherits PaginaAutorizada

    Dim elementoAcademicoBusiness As New Business.ElementoAcademico_Business
    Dim idElementoAcademico As String
    Dim usuarioBusiness As New Usuario_Business

    Dim examenBaseBusiness As New Business.ExamenBase_Business
    Dim examenBusiness As New Business.Examen_Business

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        idElementoAcademico = Request.QueryString("id")
        Dim idElementoAcademicoInt As Integer
        If Not String.IsNullOrEmpty(idElementoAcademico) And Integer.TryParse(idElementoAcademico, idElementoAcademicoInt) And Not elementoAcademicoBusiness.Obtener(idElementoAcademicoInt) Is Nothing Then
            If Not (Page.IsPostBack) Then
                If usuarioBusiness.PoseeElementoAcademico(usuario, idElementoAcademico) Then
                    CargarExamenesARendir()
                    CargarExamenesRendidos()
                Else
                    Response.Redirect(PaginasConocidas.HOME)
                End If
            End If
        Else
            Response.Redirect(PaginasConocidas.HOME)
        End If
    End Sub

    Protected Overrides Sub TraducirComponentesDinamicos()
        CargarExamenesARendir()
        CargarExamenesRendidos()
        TraducirLoopingControls(Me)
    End Sub

    Private Sub CargarExamenesARendir()
        Me.GridView1_.DataSource = examenBaseBusiness.ListarPorElementoAcademicoNoRendidos(CInt(idElementoAcademico), usuario.ID)
        Me.GridView1_.DataBind()
    End Sub

    Private Sub CargarExamenesRendidos()
        Me.GridView2_.DataSource = examenBusiness.ListarPorElementoAcademicoYAlumnoRendidos(CInt(idElementoAcademico), usuario.ID)
        Me.GridView2_.DataBind()
    End Sub

    Protected Sub ExamenARendir(ByVal sender As Object, ByVal e As EventArgs)
        Dim alumnoElementoAcademico As AlumnoElementoAcademico
        For Each elemAcademico In usuario.ElementosAcademicos
            If elemAcademico.CodigoAcademico = CInt(idElementoAcademico) Then
                alumnoElementoAcademico = elemAcademico.AlumoEstado
                Exit For
            End If
        Next
        If alumnoElementoAcademico.Presentismo > 74 Then
            Dim link As ImageButton = DirectCast(sender, ImageButton)
            Response.Redirect(PaginasConocidas.RENDIR_EXAMEN + "?id=" + link.CommandArgument)
        Else
            Interaction.MsgBox(idiomas.GetTranslationById(191), MsgBoxStyle.Information) 'Se require 75% de presentismo para rendir
        End If
    End Sub

    Protected Sub ExamenRendido(ByVal sender As Object, ByVal e As EventArgs)
        Dim link As ImageButton = DirectCast(sender, ImageButton)
        Response.Redirect(PaginasConocidas.RESULTADO_EXAMEN + "?id=" + link.CommandArgument)
    End Sub


End Class