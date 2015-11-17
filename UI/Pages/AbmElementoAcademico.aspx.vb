Imports EE
Imports Business
Imports EE.ElementoAcademico

Public Class AbmElementoAcademico
    Inherits PaginaAutorizada

    Dim usuarioBusiness As New Business.Usuario_Business
    Dim elementoAcademicoBusiness As New Business.ElementoAcademico_Business
    Dim elementoAcademico As New ElementoAcademico

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        elementoAcademico = Session("elementoSeleccionado")
        If Not (Page.IsPostBack) Then
            CargarElementosAcademicos()
            CargarEstados()
            CargarProfesores()
        End If
    End Sub

    Protected Overrides Sub TraducirComponentesDinamicos()
        CargarElementosAcademicos()
        TraducirLoopingControls(Me)
    End Sub

    Private Sub CargarElementosAcademicos()
        Me.GridView1_.DataSource = elementoAcademicoBusiness.Listar
        Me.GridView1_.DataBind()
    End Sub

    Private Sub CargarEstados()
        comboEstados.Items.Add(New ListItem("Sin contenido", "SIN_CONTENIDO"))
        comboEstados.Items.Add(New ListItem("Con contenido", "CON_CONTENIDO"))
        comboEstados.Items.Add(New ListItem("Con contenido rechazado", "CON_CONTENIDO_RECHAZADO"))
        comboEstados.Items.Add(New ListItem("Disponible", "DISPONIBLE"))
    End Sub

    Private Sub CargarProfesores()
        comboProfesores.Items.Add(New ListItem("-", 0))
        For Each profesor As Usuario In usuarioBusiness.ObtenerProfesores
            comboProfesores.Items.Add(New ListItem(profesor.Nombre, profesor.ID))
        Next
    End Sub

    Protected Sub Update(sender As Object, e As EventArgs) Handles btnActualizar_405.Click
        If Not elementoAcademico Is Nothing Then

            Dim Nombre = txtNombre.Text
            Dim Contenido = areaContenido.InnerText
            Dim img As FileUpload = CType(imgUpload, FileUpload)
            Dim imgByte As Byte() = Nothing
            If img.HasFile AndAlso Not img.PostedFile Is Nothing Then
                Dim File As HttpPostedFile = imgUpload.PostedFile
                imgByte = New Byte(File.ContentLength - 1) {}
                'force the control to load data in array
                File.InputStream.Read(imgByte, 0, File.ContentLength)
            End If
            Dim FechaInicio = Date.ParseExact(txtFechaInicio.Value, "MM/dd/yyyy", Nothing)

            Try
                Dim valido = True
                If String.IsNullOrEmpty(Nombre) And String.IsNullOrEmpty(Contenido) Then
                    valido = False
                    lblMensajes.Text = String.Format(idiomas.GetTranslationById(90016), "")
                    lblMensajes.CssClass = "formError"
                End If
                If valido And Page.IsValid Then
                    elementoAcademico.Nombre = Nombre
                    elementoAcademico.Contenido = Contenido
                    If Not imgByte Is Nothing Then
                        elementoAcademico.Imagen = imgByte
                    End If
                    elementoAcademico.FechaInicio = FechaInicio
                    elementoAcademico.Estado = comboEstados.SelectedValue
                    elementoAcademico.Profesor = usuarioBusiness.obtenerUsuarioPorID(comboProfesores.SelectedValue)

                    If elementoAcademicoBusiness.ActualizarConProfesor(elementoAcademico) Then
                        MensajeOk(lblMensajes)

                        Limpiar()
                    Else
                        MensajeError(lblMensajes)
                    End If
                End If
            Catch ex As Exception
                MensajeError(lblMensajes)
            End Try

            GridView1_.EditIndex = -1
            CargarElementosAcademicos()
        End If
    End Sub

    Protected Sub Delete(ByVal sender As Object, ByVal e As EventArgs)
        Try
            Dim lnkRemove As LinkButton = DirectCast(sender, LinkButton)

            'ver que no tenga alumnos asignados
            Dim alumnos = elementoAcademicoBusiness.Obtener(lnkRemove.CommandArgument).Alumnos
            If alumnos.Count = 0 Then
                elementoAcademicoBusiness.Borrar(lnkRemove.CommandArgument)
            Else
                MensajeError(lblMensajes, "Hay alumnos inscriptos")
            End If

            GridView1_.EditIndex = -1
            CargarElementosAcademicos()
        Catch ex As Exception
            ex.ToString()
        End Try
    End Sub

    Protected Sub OnPaging(ByVal sender As Object, ByVal e As GridViewPageEventArgs)
        CargarElementosAcademicos()
        GridView1_.PageIndex = e.NewPageIndex
        GridView1_.DataBind()
        lblMensajes.Text = ""
    End Sub

    Protected Sub btnCrear_32_Click(sender As Object, e As EventArgs) Handles btnCrear_32.Click
        Dim nombre = Me.txtNombre.Text
        Dim contenido = areaContenido.InnerText

        Dim imgByte As Byte() = Nothing
        If imgUpload.HasFile AndAlso Not imgUpload.PostedFile Is Nothing Then
            Dim File As HttpPostedFile = imgUpload.PostedFile
            imgByte = New Byte(File.ContentLength - 1) {}
            'force the control to load data in array
            File.InputStream.Read(imgByte, 0, File.ContentLength)
        End If
        Dim FechaInicio = Date.ParseExact(txtFechaInicio.Value, "MM/dd/yyyy", Nothing)

        Try
            Dim valido = True
            If String.IsNullOrEmpty(nombre) And String.IsNullOrEmpty(contenido) Then
                valido = False
                lblMensajes.Text = String.Format(idiomas.GetTranslationById(90016), "")
                lblMensajes.CssClass = "formError"
            End If
            If valido And Page.IsValid Then
                Dim elementoAcademico As New ElementoAcademico
                elementoAcademico.CodigoAcademico = 0
                elementoAcademico.Nombre = nombre
                elementoAcademico.Contenido = contenido
                If Not imgByte Is Nothing Then
                    elementoAcademico.Imagen = imgByte
                End If
                elementoAcademico.FechaInicio = FechaInicio
                elementoAcademico.Estado = "SIN_CONTENIDO" 'enum?
                elementoAcademico.Profesor = usuarioBusiness.obtenerUsuarioPorID(comboProfesores.SelectedValue)

                If elementoAcademicoBusiness.CrearConProfesor(elementoAcademico) Then
                    MensajeOk(lblMensajes)

                    Limpiar()
                Else
                    MensajeError(lblMensajes)
                End If
            End If
        Catch ex As Exception
            MensajeError(lblMensajes)
        End Try

        GridView1_.EditIndex = -1
        CargarElementosAcademicos()
    End Sub

    Protected Sub GridView1_SelectedIndexChanging(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewSelectEventArgs) Handles GridView1_.SelectedIndexChanging
        Dim pageFactor = GridView1_.PageIndex * GridView1_.PageSize
        Session("elementoSeleccionado") = elementoAcademicoBusiness.Listar.ElementAt(pageFactor + e.NewSelectedIndex)
        elementoAcademico = Session("elementoSeleccionado")

        Me.txtNombre.Text = elementoAcademico.Nombre
        Me.areaContenido.InnerText = elementoAcademico.Contenido
        Me.comboEstados.SelectedValue = elementoAcademico.Estado
        If elementoAcademico.Profesor Is Nothing Then
            Me.comboProfesores.SelectedValue = 0
        Else
            Me.comboProfesores.SelectedValue = elementoAcademico.Profesor.ID
        End If
        Me.txtFechaInicio.Value = elementoAcademico.FechaInicio.ToString("MM/dd/yyyy")
    End Sub

    Private Sub Limpiar()
        Me.txtNombre.Text = ""
        Me.areaContenido.InnerText = ""
        Me.comboEstados.SelectedValue = "SIN_CONTENIDO"
        Me.comboProfesores.SelectedValue = 0
        Me.txtFechaInicio.Value = ""
        'imagen
        Session("elementoSeleccionado") = Nothing
    End Sub

    Protected Sub validadorSize_ServerValidate(source As Object, args As ServerValidateEventArgs)
        Dim filesize As Double = imgUpload.FileContent.Length
        If filesize > 50000000 Then
            args.IsValid = False
        Else
            args.IsValid = True
        End If
    End Sub

End Class