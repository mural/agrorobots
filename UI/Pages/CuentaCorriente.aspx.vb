Imports EE
Imports Business
Imports MigraDoc.DocumentObjectModel
Imports MigraDoc.DocumentObjectModel.Shapes
Imports MigraDoc.DocumentObjectModel.Tables
Imports MigraDoc.DocumentObjectModel.Color

Imports System.Xml.XPath
Imports MigraDoc.Rendering
Imports PdfSharp.Pdf

Public Class CuentaCorriente
    Inherits PaginaAutorizada

    Dim ctaCteUsuarioBusiness As New Business.CtaCteUsuario_Business
    Dim comprobanteBusiness As New Business.Comprobante_Business
    Dim comprobanteNotaBusiness As New Business.ComprobanteNota_Business

    Dim comprobantesHelper As New ComprobantesHelper

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
        Me.GridView1_.DataSource = ctaCteUsuarioBusiness.ListarPorUsuario(usuario.ID)
        Me.GridView1_.DataBind()
    End Sub

    Protected Sub OnPaging(ByVal sender As Object, ByVal e As GridViewPageEventArgs)
        CargarMovimientos()
        GridView1_.PageIndex = e.NewPageIndex
        GridView1_.DataBind()
    End Sub

    Public Function ObtenerTipo(ByVal IDCtaCte As Integer) As String
        Return comprobantesHelper.ObtenerTipo(IDCtaCte)
    End Function

    Public Function ObtenerDetalle(ByVal IDCtaCte As Integer) As String
        Return comprobantesHelper.ObtenerDetalle(IDCtaCte)
    End Function

    Public Function ObtenerMontoTotal(ByVal IDCtaCte As Integer) As String
        Return comprobantesHelper.ObtenerMontoTotal(IDCtaCte)
    End Function

    Protected Sub PDF(ByVal sender As Object, ByVal e As EventArgs)
        Dim link As ImageButton = DirectCast(sender, ImageButton)
        Dim IDCtaCte = CInt(link.CommandArgument)

        comprobantesHelper.PDF(IDCtaCte, Response, Server)

    End Sub

End Class