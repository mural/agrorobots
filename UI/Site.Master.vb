Imports System.Data.SqlClient
Imports Business
Imports Business.Idiomas
Imports EE

Public Class Site
    Inherits System.Web.UI.MasterPage

    Dim login As New Business.Login
    Public usuario As Usuario

    Dim menuItem As MenuItem

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        usuario = Session.Item("user")
        ArmarMenuLateral(usuario)

        'validar pagina
        Dim valido As Boolean = False
        For Each patente As Patente In usuario.GetOnlyPatentes()
            If patente.URL.Equals(Request.Url.Segments(2)) Then
                valido = True
                Exit For
            End If
        Next
        For Each paginaPermitida As String In PaginasPermitidas.GetInstance.GetPaginasPermitidas
            If paginaPermitida.Equals(Request.Url.Segments(2)) Then
                valido = True
                Exit For
            End If
        Next
        If Not valido Then
            Response.Redirect("SinPermisos.aspx")
        End If

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
        If usuario Is Nothing Then
            Response.Redirect("/Pantalla_Login.aspx")
        Else
            SideNavigationMenu.Items.Clear()
            For Each patente As Patente In usuario.GetOnlyPatentes
                Dim menuItem = New MenuItem(patente.Descripcion, patente.Name)
                If Nothing Is SideNavigationMenu.FindItem(menuItem.Value) Then
                    SideNavigationMenu.Items.Add(menuItem)
                End If
            Next
        End If
    End Sub

    Public Sub Logout()
        Session.Clear()
        FormsAuthentication.SignOut()
        Bitacora_Business.Logear("Logout", "Logout exitoso", HttpContext.Current.User.Identity.Name)
        Session.Item("user") = Nothing
        Response.Redirect("/Pantalla_Login.aspx")
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
            Case "Idioma_10006"
                Response.Redirect("CambioIdioma.aspx")
        End Select
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
End Class