Imports EE

Public Class MenuBase
    Inherits System.Web.UI.MasterPage

    Public usuario As Usuario

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        usuario = Session.Item("user")
        If Not usuario Is Nothing Then
            ArmarMenuLateral(usuario)
        End If
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

End Class