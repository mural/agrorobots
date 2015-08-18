﻿Imports System.Data.SqlClient
Imports Business
Imports EE

Public Class Site
    Inherits System.Web.UI.MasterPage


    Dim login As New Business.Login
    Dim usuario As Usuario

    Dim menuItem As MenuItem

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        usuario = Session.Item("user")
        Elegir_Perfil(usuario)

        'validar pagina
        Dim valido As Boolean = False
        For Each patente As Patente In usuario.GetOnlyPatentes()
            If patente.URL.Equals(Request.Url.Segments(2)) Then
                valido = True
            End If
        Next
        If "Pantalla_Principal.aspx".Equals(Request.Url.Segments(2)) Then
            valido = True
        End If

        If Not valido Then
            Response.Redirect("Pantalla_Principal.aspx")
        End If

        'idiomas
        For Each menuItem As MenuItem In NavigationMenu.Items
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

    Public Sub Elegir_Perfil(ByRef usuario As Usuario)
        If usuario Is Nothing Then
            Response.Redirect("/Pantalla_Login.aspx")
        Else
            If usuario.Alumno = False Then
                menuItem = NavigationMenu.FindItem("MiCursada")
                If menuItem IsNot Nothing Then
                    NavigationMenu.Items.Remove(menuItem)
                End If
            End If
            If usuario.Profesor = False Then
                menuItem = NavigationMenu.FindItem("MisClases")
                If menuItem IsNot Nothing Then
                    NavigationMenu.Items.Remove(menuItem)
                End If
            End If
            If usuario.EmpleadoAdm = False Then
                menuItem = NavigationMenu.FindItem("PanelAdministrativo")
                If menuItem IsNot Nothing Then
                    NavigationMenu.Items.Remove(menuItem)
                End If
            End If
            If usuario.Director = False Then
                menuItem = NavigationMenu.FindItem("Direccion")
                If menuItem IsNot Nothing Then
                    NavigationMenu.Items.Remove(menuItem)
                End If
            End If

            If usuario.Admin = True Then
                menuItem = NavigationMenu.FindItem("MenuAdvance")
                If menuItem IsNot Nothing Then
                    NavigationMenu.Items.Remove(menuItem)
                End If
            Else
                menuItem = NavigationMenu.FindItem("MenuAdmin_3007")
                If menuItem IsNot Nothing Then
                    NavigationMenu.Items.Remove(menuItem)
                End If
            End If
        End If
    End Sub

    Public Sub Logout()
        FormsAuthentication.SignOut()
        'Bitacora_Business.Logear("Logout", "Logout exitoso", HttpContext.Current.User.Identity.Name)
        Session.Item("user") = Nothing
        Response.Redirect("/Pantalla_Login.aspx")
    End Sub

    Protected Sub NavigationMenu_MenuItemClick(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.MenuEventArgs) Handles NavigationMenu.MenuItemClick
        Select Case e.Item.Value
            Case "Home_3001"
                Response.Redirect("Pantalla_Principal.aspx")
            Case "Carreras_3003"
                Response.Redirect("Carreras.aspx")
            Case "Materias"
                Response.Redirect("Materias.aspx")
            Case "Examenes"
                Response.Redirect("Examenes.aspx")
            Case "Alumnos"
                Response.Redirect("Alumnos.aspx")
            Case "CarrerasMaterias"
                Response.Redirect("CarrerasMaterias.aspx")

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

            Case "Contactenos"
                Response.Redirect("Contactenos.aspx")

            Case "Idiomas_10101"
                Response.Redirect("AbmIdiomas.aspx")
            Case "Traducciones_10102"
                Response.Redirect("AbmTraducciones.aspx")
            Case "Bitacora_10103"
                Response.Redirect("Bitacora.aspx")
            Case "Backup_10104"
                Response.Redirect("Backup.aspx")

            Case "Logout_503"
                Logout()
        End Select
    End Sub
End Class