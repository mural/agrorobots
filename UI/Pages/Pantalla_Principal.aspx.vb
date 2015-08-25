Imports EE
Imports Business

Public Class Pantalla_Principal
    Inherits PaginaGenerica

    Dim usuario As Usuario

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim name = HttpContext.Current.User.Identity.Name
        'userName.Text = name

        usuario = Session.Item("user")
        userName.Text = name + " " + usuario.Apellido
        inconsistencias.Text = ObtenerInconsistencias()
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

    Protected Overrides Sub TraducirComponentesDinamicos()

    End Sub

    Public Function ObtenerInconsistencias() As String

        If usuario.Admin = True Then
            'Inconsistencias.Visible = True
            Button1.Visible = True

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


    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As EventArgs) Handles Button1.Click
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
End Class