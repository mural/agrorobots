Public Class MiError
    Inherits PaginaGenerica

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        ''Response.AddHeader("REFRESH", "2;history.go(-1)") 'URL=/Front/Home.aspx
    End Sub

    Protected Overrides Sub TraducirComponentesDinamicos()

    End Sub
End Class