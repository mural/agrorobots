Imports EE
Imports Business

Public Class Pago
    Inherits PaginaAutorizada

    Dim ctaCteUsuarioBusiness As New Business.CtaCteUsuario_Business
    Dim elementoAcademicoBusiness As New ElementoAcademico_Business

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not (Page.IsPostBack) Then
            CargarMovimientos()
        End If
    End Sub

    Protected Overrides Sub TraducirComponentesDinamicos()
        CargarMovimientos()
        TraducirLoopingControls(Me)
    End Sub

    Private Sub CargarMovimientos()
        Me.GridView1_.DataSource = ctaCteUsuarioBusiness.ListarPorFacturasNoPagas
        Me.GridView1_.DataBind()
    End Sub

    Protected Sub OnPaging(ByVal sender As Object, ByVal e As GridViewPageEventArgs)
        CargarMovimientos()
        GridView1_.PageIndex = e.NewPageIndex
        GridView1_.DataBind()
    End Sub

    Protected Sub ConfirmarPago(ByVal sender As Object, ByVal e As EventArgs)
        Dim link As ImageButton = DirectCast(sender, ImageButton)
        Dim ID = CInt(link.CommandArgument)

        Dim ctacte = ctaCteUsuarioBusiness.Obtener(ID)
        ctacte.Estado = "PAGO"
        ctaCteUsuarioBusiness.Actualizar(ctacte)

        For Each comprobanteDetalle In ctacte.Comprobante.Items
            elementoAcademicoBusiness.ActivarInscripcion(ctacte.IdUsuario, comprobanteDetalle.CodigoProducto)
        Next

        RecargarPagina()
    End Sub

End Class