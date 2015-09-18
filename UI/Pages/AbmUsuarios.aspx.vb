﻿Imports EE
Imports Business
Imports Business.Idiomas

Public Class AbmUsuario
    Inherits PaginaGenerica

    Public usuario_Business As New Usuario_Business
    Dim familia_Business As New Familia_Business
    Dim usuarioSeleccionado As Usuario
    Dim familiaSeleccionada As Integer = 0

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        usuarioSeleccionado = Session("usuarioSeleccionado")
        If Not (Page.IsPostBack) Then
            CargarUsuarios()

            lstbFamilia.Items.Clear()
            For Each familia As Familia In familia_Business.ObtenerFamilias
                lstbFamilia.Items.Add(familia.Name)
            Next
            lstbFamilia.Items(0).Selected = True
        End If
    End Sub

    Protected Overrides Sub TraducirComponentesDinamicos()
        CargarUsuarios()
        TraducirLoopingControls(Me)
    End Sub

    Private Sub CargarUsuarios()
        Me.GridView1_.DataSource = usuario_Business.ObtenerUsuarios(True)
        Me.GridView1_.DataBind()
    End Sub

    Private Sub Vaciar()
        txtApellido.Text = ""
        txtNombre.Text = ""
        txtUsername.Text = ""
        txtPassword.Text = ""
        txtConfirmPassword.Text = ""
        Session("usuarioSeleccionado") = Nothing
        lblMensajes.Text = ""
        LimpiarValidaciones()
    End Sub

    Private Sub LimpiarValidaciones()
        vldApellido_21.IsValid = True
        vldNombre_22.IsValid = True
        vldUser_23.IsValid = True
        vldPassword_27.IsValid = True
        vldConfirmPassword_28.IsValid = True
        vldPasswordMatch.IsValid = True
    End Sub

    Protected Sub AddNew(ByVal sender As Object, ByVal e As EventArgs) Handles btnCrear_32.Click
        Dim Apellido = txtApellido.Text
        Dim Nombre = txtNombre.Text
        Dim UserName = txtUsername.Text
        Dim Email = "mural@scvsoft.com" 'actualizar la pagina para usar EMAIL
        Dim Activo = cbxActivo.Checked
        Dim Admin = cbxAdmin.Checked
        Dim Password = txtPassword.Text
        Dim ConfirmPassword = txtConfirmPassword.Text
        Dim Familias = New List(Of Familia)
        For i = 0 To lstbFamilia.GetSelectedIndices.Length - 1
            Familias.Add(familia_Business.ObtenerFamilias(lstbFamilia.GetSelectedIndices(i)))
        Next

        lblMensajes.Text = ""

        If Not vldPasswordMatch.IsValid Then
            vldPasswordMatch.Text = IdiomManager.GetIdiomManager.GetTranslationById(90030)
        End If

        If Page.IsValid Then
            Try
                Dim nuevoUsuario = New Usuario(Activo, Admin, Apellido, 0, Nothing, 0, Nombre, Password, UserName, Email)
                For Each familia In Familias
                    usuarioSeleccionado.AddComponent(familia)
                    nuevoUsuario.AddComponent(familia)
                Next
                usuario_Business.Alta(nuevoUsuario)

                Vaciar()
            Catch ax As ArgumentException
                If ax.Message.Equals("90028") Then
                    lblMensajes.Text = IdiomManager.GetIdiomManager.GetTranslationById(90028)
                End If
            Catch ex As Exception
                lblMensajes.Text = IdiomManager.GetIdiomManager.GetTranslationById(90012)
            End Try
        End If

        GridView1_.EditIndex = -1
        CargarUsuarios()
        TraducirLoopingControls(Me)
    End Sub

    Protected Sub Update(ByVal sender As Object, ByVal e As EventArgs) Handles btnActualizar_405.Click
        If Not usuarioSeleccionado Is Nothing Then

            Dim Apellido = txtApellido.Text
            Dim Nombre = txtNombre.Text
            Dim UserName = txtUsername.Text
            Dim Activo = cbxActivo.Checked
            Dim Admin = cbxAdmin.Checked
            Dim Familias = New List(Of Familia)
            For i = 0 To lstbFamilia.GetSelectedIndices.Length - 1
                Familias.Add(familia_Business.ObtenerFamilias(lstbFamilia.GetSelectedIndices(i)))
            Next


            lblMensajes.Text = ""
            vldPassword_27.IsValid = True
            cvldPass_27.IsValid = True
            vldConfirmPassword_28.IsValid = True
            vldPasswordMatch.IsValid = True

            If Page.IsValid Then
                Try
                    usuarioSeleccionado.Apellido = Apellido
                    usuarioSeleccionado.Nombre = Nombre
                    usuarioSeleccionado.Activo = Activo
                    usuarioSeleccionado.Admin = Admin
                    usuarioSeleccionado.RemoveAllComponents()
                    For Each familia In Familias
                        usuarioSeleccionado.AddComponent(familia)
                    Next
                    usuario_Business.Modificacion(usuarioSeleccionado)

                    Vaciar()
                Catch ex As Exception
                    lblMensajes.Text = IdiomManager.GetIdiomManager.GetTranslationById(90012)
                End Try
            End If

            GridView1_.EditIndex = -1
            CargarUsuarios()
        Else
            LimpiarValidaciones()
            lblMensajes.Text = IdiomManager.GetIdiomManager.GetTranslationById(90035)
        End If
    End Sub

    Protected Sub Delete(ByVal sender As Object, ByVal e As EventArgs)
        Dim lnkRemove As LinkButton = DirectCast(sender, LinkButton)

        Dim borrarUsuario = New Usuario()
        borrarUsuario.ID = lnkRemove.CommandArgument
        usuario_Business.Baja(borrarUsuario)

        Vaciar()

        GridView1_.EditIndex = -1
        CargarUsuarios()
    End Sub

    Protected Sub OnPaging(ByVal sender As Object, ByVal e As GridViewPageEventArgs)
        CargarUsuarios()
        GridView1_.PageIndex = e.NewPageIndex
        GridView1_.DataBind()
    End Sub

    Protected Sub GridView1_SelectedIndexChanging(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewSelectEventArgs) Handles GridView1_.SelectedIndexChanging
        Dim pageFactor = GridView1_.PageIndex * GridView1_.PageSize
        Session("usuarioSeleccionado") = usuario_Business.ObtenerUsuarios(False).ElementAt(pageFactor + e.NewSelectedIndex)
        usuarioSeleccionado = Session("usuarioSeleccionado")
        Me.txtApellido.Text = usuarioSeleccionado.Apellido
        Me.txtNombre.Text = usuarioSeleccionado.Nombre
        Me.txtUsername.Text = usuarioSeleccionado.UserName
        Me.cbxActivo.Checked = usuarioSeleccionado.Activo
        Me.cbxAdmin.Checked = usuarioSeleccionado.Admin
        Me.lstbFamilia.ClearSelection()
        For Each flia In usuarioSeleccionado.GetFamilias()
            For Each item As ListItem In lstbFamilia.Items
                If item.ToString() = flia.Name Then
                    item.Selected = True
                End If
            Next
        Next

        Me.txtPassword.Text = "-"
        Me.txtConfirmPassword.Text = "-"
    End Sub

    Protected Sub btnLimpiar_36_Click(sender As Object, e As EventArgs) Handles btnLimpiar_36.Click
        Vaciar()
    End Sub

    Protected Sub cvldApellido_ServerValidate(source As Object, args As ServerValidateEventArgs) Handles cvldApellido_21.ServerValidate
        Validaciones.MinimaLongitud(args, cvldApellido_21, 2)
    End Sub

    Protected Sub cvldUser_ServerValidate(source As Object, args As ServerValidateEventArgs) Handles cvldUser_23.ServerValidate
        If Not Validaciones.MinimaLongitud(args, cvldUser_23, 4) Then
            Exit Sub
        End If

    End Sub

    Protected Sub cvldPass_27_ServerValidate(source As Object, args As ServerValidateEventArgs) Handles cvldPass_27.ServerValidate
        If Not Validaciones.MinimaLongitud(args, cvldPass_27, 4) Then
            Exit Sub
        End If

    End Sub
End Class