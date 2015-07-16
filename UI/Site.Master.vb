Imports System.Data.SqlClient
Imports Business
Imports DTO

Public Class Site
    Inherits System.Web.UI.MasterPage


    Dim login As New Business.Login
    Dim usuario As Usuario

    Dim menuItem As MenuItem

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        usuario = Session.Item("user")
        Elegir_Perfil(usuario)
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
                menuItem = NavigationMenu.FindItem("MenuAdmin")
                If menuItem IsNot Nothing Then
                    NavigationMenu.Items.Remove(menuItem)
                End If
            End If
        End If
    End Sub

    Public Sub Logout()
        FormsAuthentication.SignOut()
        'Bitacora_Business.Logear("Logout", "Logout exitoso", HttpContext.Current.User.Identity.Name)
        Response.Redirect("/Pantalla_Login.aspx")
    End Sub

    Protected Sub NavigationMenu_MenuItemClick(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.MenuEventArgs) Handles NavigationMenu.MenuItemClick
        Select Case e.Item.Value
            Case "Home"
                Response.Redirect("Pantalla_Principal.aspx")
            Case "Carreras"
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
            Case "Bitacora"
                Response.Redirect("Bitacora.aspx")
            Case "Backup"
                Response.Redirect("Backup.aspx")
            Case "Logout"
                Logout()
        End Select
    End Sub
End Class