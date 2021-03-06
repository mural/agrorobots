﻿Imports EE
Imports Business
Imports System.IO


Public Class Examenes
    Inherits PaginaAutorizada

    Dim elementoAcademicoBusiness As New Business.ElementoAcademico_Business
    Dim idElementoAcademico As String
    Dim usuarioBusiness As New Usuario_Business

    Dim examenBaseBusiness As New Business.ExamenBase_Business
    Dim examenBusiness As New Business.Examen_Business

    Dim virtualPath As String

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        virtualPath = PaginasConocidas.DIR_ESCRITURA_APP & "audioExamen.wma"

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

    Protected Sub ExamenAudio(ByVal sender As Object, ByVal e As EventArgs)
        Try
            Dim link As ImageButton = DirectCast(sender, ImageButton)
            Dim examen = examenBusiness.Obtener(link.CommandArgument)

            If Not examen.Audio Is Nothing Then
                Dim documentBinary As Byte() = DirectCast(examen.Audio, Byte())
                Dim fStream As New FileStream(virtualPath, FileMode.Create)
                fStream.Write(documentBinary, 0, documentBinary.Length)
                fStream.Close()
                fStream.Dispose()

                Response.ContentType = "application/octet-stream"
                Response.AppendHeader("Content-Disposition", "attachment; filename=" + "audioExamen.wma")
                Response.TransmitFile(virtualPath)
                Response.End()
            Else
                Interaction.MsgBox("No audio", MsgBoxStyle.Information)
            End If
        Catch ex As Exception
            ex.ToString()
        End Try
    End Sub

End Class