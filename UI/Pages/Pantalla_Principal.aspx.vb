Imports EE
Imports Business
Imports MigraDoc.DocumentObjectModel
Imports MigraDoc.DocumentObjectModel.Shapes
Imports MigraDoc.DocumentObjectModel.Tables
Imports MigraDoc.DocumentObjectModel.Color

Imports System.Xml.XPath
Imports MigraDoc.Rendering
Imports PdfSharp.Pdf

Public Class Pantalla_Principal
    Inherits PaginaAutorizada

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        usuario = Session.Item("user")
        userName.Text = usuario.Nombre + " " + usuario.Apellido

        inconsistencias.Text = ObtenerInconsistencias()
    End Sub

    Protected Overrides Sub TraducirComponentesDinamicos()

    End Sub

    Protected Sub PopUpInconsistencias()
        If (Not Page.IsPostBack) Then
            If ObtenerInconsistencias() <> String.Empty Then
                Dim myBodyTag As HtmlGenericControl
                myBodyTag = Page.Master.FindControl("MasterPageBodyTag")
                myBodyTag.Attributes.Add("onload", "ObtenerIncosistencias();")

                Dim ClientScriptName As String = "Incosistencias"
                Dim PageType As Type = Me.GetType()

                ' Get a ClientScriptManager reference from the Page class.
                Dim csm As ClientScriptManager = Page.ClientScript

                ' Check to see if the client script is already registered.
                If (Not csm.IsClientScriptBlockRegistered(PageType, ClientScriptName)) Then
                    Dim ClientScriptText As New StringBuilder()
                    ClientScriptText.AppendLine("function ObtenerIncosistencias() {")
                    ClientScriptText.AppendLine(" alert('" & ObtenerInconsistencias() & "');")
                    ClientScriptText.AppendLine("}")
                    csm.RegisterClientScriptBlock(PageType, ClientScriptName, ClientScriptText.ToString(), True)
                End If
            End If
        End If
    End Sub

    Public Function ObtenerInconsistencias() As String
        If usuario.Admin = True Then
            'Inconsistencias.Visible = True
            'recalcular_710.Visible = True

            Dim dig As New Servicio_Digitos
            'Verifico si hubo un cambio por fuera del sistema
            Dim lst As List(Of String) = dig.VerificarDigitos()
            If lst.Count > 0 Then
                Dim errores As String = "Errores de datos: "
                For i = 0 To lst.Count - 1
                    'par son tabla
                    If (i Mod 2 = 0) Then
                        errores += "Tabla: "
                        errores += lst.Item(i)
                    Else 'impar son ID
                        errores += ", ID: "
                        errores += lst.Item(i)

                    End If
                Next
                Return errores
            End If
        End If
        Return String.Empty
    End Function


    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As EventArgs) Handles recalcular_710.Click
        Dim servicio_DV As New Servicio_Digitos

        Dim usr As New Usuario_Business
        Dim users As List(Of Usuario) = usr.ObtenerUsuarios(False)
        For Each User As Usuario In users
            Try
                servicio_DV.CalcularDigitoH("ID=" & User.ID, "Usuario")
            Catch ex As Exception
            End Try
        Next

        Page_Load(sender, e)
    End Sub

    Protected Sub buscarsitio_104_Click(sender As Object, e As EventArgs) Handles buscarsitio_104.Click
        Try
            Dim resultados As New List(Of Patente)
            For Each patenteUsuario As Patente In usuario.GetOnlyPatentes
                Dim traducido = TraducirItem(patenteUsuario.Name)
                If traducido.ToLowerInvariant.Contains(txtBuscar.Text.ToLowerInvariant) Then
                    patenteUsuario.Display = traducido
                    resultados.Add(patenteUsuario)
                End If
            Next

            Me.GridView1_.DataSource = resultados
            Me.GridView1_.DataBind()
        Catch ex As Exception
        End Try
    End Sub

    Protected Sub Selection(ByVal sender As Object, ByVal e As EventArgs)
        Dim lnkSelect As LinkButton = DirectCast(sender, LinkButton)

        Response.Redirect(lnkSelect.CommandArgument)

    End Sub

    Public Function TraducirItem(ByVal item As String) As String
        If item.Contains("_") Then
            Return idiomas.GetTranslationById(item.Split("_")(1))
        End If
        Return item
    End Function

End Class