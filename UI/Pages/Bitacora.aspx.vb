Imports EE
Imports Business

Public Class Bitacora
    Inherits PaginaGenerica

    Dim bitacora_Business As New Business.Bitacora_Business

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not (Page.IsPostBack) Then
            CargarBitacora()
        End If
    End Sub

    Private Sub CargarBitacora()
        Me.GridView1_.DataSource = bitacora_Business.GetItemsBitacora
        Me.GridView1_.DataBind()
    End Sub

    Protected Overrides Sub TraducirComponentesDinamicos()
        CargarBitacora()
        TraducirLoopingControls(Me)
    End Sub

    Protected Sub OnPaging(ByVal sender As Object, ByVal e As GridViewPageEventArgs)
        CargarBitacora()
        GridView1_.PageIndex = e.NewPageIndex
        GridView1_.DataBind()
    End Sub

End Class