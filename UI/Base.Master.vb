Imports Business

Public Class Base
    Inherits System.Web.UI.MasterPage

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Public Sub Logout()
        Session.Clear()
        FormsAuthentication.SignOut()
        Bitacora_Business.Logear("Logout", "Logout exitoso", HttpContext.Current.User.Identity.Name)
        Session.Item("user") = Nothing
        Response.Redirect("/Pantalla_Login.aspx")
    End Sub
End Class