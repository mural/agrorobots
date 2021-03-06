﻿Imports EE
Imports Business
Imports Business.Idiomas

Public Class MenuBase
    Inherits System.Web.UI.MasterPage

    Public usuario As Usuario

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        usuario = Session.Item("user")
        If Not usuario Is Nothing Then
            ArmarMenuLateral(usuario)

            TraducirMenu()
        End If
    End Sub

    Public Sub TraducirMenu()
        'idiomas
        ''menu lateral
        For Each menuItem As MenuItem In SideNavigationMenu.Items
            Try
                If menuItem.ChildItems.Count > 0 Then
                    For Each menuChild As MenuItem In menuItem.ChildItems
                        Try
                            menuChild.Text = IdiomManager.GetIdiomManager.GetTranslationById(menuChild.Value.Split("_")(1))
                        Catch ex As Exception
                        End Try
                    Next
                End If
                menuItem.Text = IdiomManager.GetIdiomManager.GetTranslationById(menuItem.Value.Split("_")(1))
            Catch ex As Exception
            End Try
        Next
    End Sub

    Public Sub ArmarMenuLateral(ByRef usuario As Usuario)
        SideNavigationMenu.Items.Clear()
        For Each patente As Patente In usuario.GetOnlyPatentes
            Dim menuItem = New MenuItem(patente.Descripcion, patente.Name)
            If Nothing Is SideNavigationMenu.FindItem(menuItem.Value) And patente.ControlID > 0 Then
                SideNavigationMenu.Items.Add(menuItem)
            End If
        Next
    End Sub

    Protected Sub SideNavigationMenu_MenuItemClick(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.MenuEventArgs) Handles SideNavigationMenu.MenuItemClick
        Select Case e.Item.Value
            'comun
            Case "Clave_3008"
                Response.Redirect("CambioClave.aspx")
            Case "Mensajes_3009"
                Response.Redirect("Mensajes.aspx")
            Case "Idioma_10006"
                Response.Redirect("CambioIdioma.aspx")

                'alumno
            Case "CuentaCorriente_10111"
                Response.Redirect(PaginasConocidas.CUENTA_CORRIENTE)
            Case "MiCursada_10121"
                Response.Redirect(PaginasConocidas.MI_CURSADA)

                'profesor
            Case "CorregirExamen"
                Response.Redirect("ExamenCorrecion.aspx")
            Case "ContenidoCarrera"
                Response.Redirect("ContenidoCarrera.aspx")
            Case "ContenidoMateria"
                Response.Redirect("ContenidoMateria.aspx")
            Case "ContenidoElementoAcademico_10110"
                Response.Redirect("ContenidoElementoAcademico.aspx")
            Case "MisClases_10122"
                Response.Redirect(PaginasConocidas.MIS_CLASES)
            Case "EdicionMaterial_10123"
                Response.Redirect(PaginasConocidas.EDICION_MATERIAL)
            Case "EdicionExamen_10124"
                Response.Redirect(PaginasConocidas.EDICION_EXAMEN)

                'administrativo
            Case "Pago"
                Response.Redirect(PaginasConocidas.PAGO)
            Case "AbmComprobantes_10129"
                Response.Redirect(PaginasConocidas.GESTION_COMPROBANTES)

                'director
            Case "EvaluarRevisionExamen"
                Response.Redirect("ExamenEvaluacionRevision.aspx")
            Case "NuevaCarrera"
                Response.Redirect("NuevaCarrera.aspx")
            Case "RevisionCarrera"
                Response.Redirect("RevisionCarrera.aspx")
            Case "NuevaMateria"
                Response.Redirect("NuevaMateria.aspx")
            Case "RevisionMateria"
                Response.Redirect("RevisionMateria.aspx")
            Case "AbmElementoAcademico_10109"
                Response.Redirect("AbmElementoAcademico.aspx")

                'admin
            Case "AbmIdiomas_10101"
                Response.Redirect("AbmIdiomas.aspx")
            Case "AbmTraducciones_10102"
                Response.Redirect("AbmTraducciones.aspx")
            Case "Bitacora_10103"
                Response.Redirect("Bitacora.aspx")
            Case "BackUp_10104"
                Response.Redirect("Backup.aspx")
            Case "AbmPermisos_10106"
                Response.Redirect("AbmPermisos.aspx")
            Case "AbmUsuarios_10107"
                Response.Redirect("AbmUsuarios.aspx")
            Case "AbmNovedades_10108"
                Response.Redirect(PaginasConocidas.ABM_NOVEDADES)
            Case "AbmEncuestas_10113"
                Response.Redirect(PaginasConocidas.ABM_ENCUESTAS)
            Case "AbmFichas_10114"
                Response.Redirect(PaginasConocidas.ABM_FICHAS)
            Case "ResultadosEncuestas_10115"
                Response.Redirect(PaginasConocidas.RESULTADOS_ENCUESTAS)
            Case "ResultadosFichas_10116"
                Response.Redirect(PaginasConocidas.RESULTADOS_FICHAS)
            Case "EstadisticasRespuesta_10117"
                Response.Redirect(PaginasConocidas.ESTADISTICAS_RESPUESTA)
            Case "Ganancias_10118"
                Response.Redirect(PaginasConocidas.GANANCIAS)
            Case "Satisfaccion_10119"
                Response.Redirect(PaginasConocidas.SATISFACCION)
            Case "GananciasComparativas_10120"
                Response.Redirect(PaginasConocidas.GANANACIAS_COMPARATIVAS)
        End Select
    End Sub

End Class