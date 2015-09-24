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

            TraducirMenu(usuario)
        End If
    End Sub

    Public Sub TraducirMenu(ByRef usuario As Usuario)
        'idiomas
        ''menu top
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

        ''menu lateral
        For Each menuItem As MenuItem In TopNavigationMenu.Items
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
            If Nothing Is SideNavigationMenu.FindItem(menuItem.Value) Then
                SideNavigationMenu.Items.Add(menuItem)
            End If
        Next
    End Sub

    Protected Sub SideNavigationMenu_MenuItemClick(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.MenuEventArgs) Handles SideNavigationMenu.MenuItemClick
        Select Case e.Item.Value
            'alumno
            Case "RendirExamen"
                Response.Redirect("ExamenMateria.aspx")

                'profesor
            Case "CorregirExamen"
                Response.Redirect("ExamenCorrecion.aspx")
            Case "ContenidoCarrera"
                Response.Redirect("ContenidoCarrera.aspx")
            Case "ContenidoMateria"
                Response.Redirect("ContenidoMateria.aspx")

                'administrativo
            Case "Pago"
                Response.Redirect("Pago.aspx")

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

        End Select
    End Sub

    Protected Sub TopNavigationMenu_MenuItemClick(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.MenuEventArgs) Handles TopNavigationMenu.MenuItemClick
        Select Case e.Item.Value
            Case "Home_3001"
                Response.Redirect("Pantalla_Principal.aspx")
            Case "Carreras_3003"
                Response.Redirect("Carreras.aspx")
            Case "Contactenos"
                Response.Redirect("Contactenos.aspx")
            Case "Clave_3008"
                Response.Redirect("CambioClave.aspx")
            Case "Mensajes_3009"
                Response.Redirect("Mensajes.aspx")
            Case "Idioma_10006"
                Response.Redirect("CambioIdioma.aspx")
        End Select
    End Sub

End Class