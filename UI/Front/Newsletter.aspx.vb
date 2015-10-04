Imports EE
Imports Business

Public Class Newsletter
    Inherits PaginaGenerica

    Dim categoriaTemaBusiness As New CategoriaTema_Business
    Dim newsletterBusiness As New Newsletter_Business

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            CargarTemas()
        End If
    End Sub

    Protected Overrides Sub TraducirComponentesDinamicos()

    End Sub

    Protected Sub CargarTemas()
        For Each categoriaTema In categoriaTemaBusiness.Listar()
            lstbTemas.Items.Add(New ListItem(categoriaTema.Nombre, categoriaTema.ID))
        Next
        lstbTemas.Items(0).Selected = True
    End Sub


    Protected Sub btnSuscribirse_43_Click(sender As Object, e As EventArgs) Handles btnSuscribirse_43.Click
        LimpiarMensaje(lblMensajes)

        If Page.IsValid Then
            'validar que haya algun tema
            Dim obj As New EE.Newsletter
            obj.Email = email.Text
            obj.Nombre = ""
            obj.IDIdioma = ObtenerIdiomaSeleccionadoID()

            For i = 0 To lstbTemas.GetSelectedIndices.Length - 1
                Dim item = lstbTemas.Items(lstbTemas.GetSelectedIndices(i))
                obj.Temas.Add(categoriaTemaBusiness.Obtener(item.Value))
            Next
            Try
                If newsletterBusiness.Crear(obj) Then
                    MensajeOk(lblMensajes)
                Else
                    MensajeError(lblMensajes)
                End If
            Catch ex As Exception
                MensajeError(lblMensajes)
            End Try
        End If
    End Sub

    Protected Sub btnSuscribirse_44_Click(sender As Object, e As EventArgs) Handles btnSuscribirse_44.Click
        LimpiarMensaje(lblMensajes)

        If Page.IsValid Then
            Try
                If newsletterBusiness.Desuscribir(email.Text) Then
                    MensajeOk(lblMensajes)
                Else
                    MensajeError(lblMensajes)
                End If
            Catch ex As Exception
                MensajeError(lblMensajes)
            End Try
        End If
    End Sub

End Class