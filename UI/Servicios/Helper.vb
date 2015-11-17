Imports EE

Public Class Helper

    Public Shared Function ActualizarCantidadMensajes(ByRef master As MasterPage, ByVal cantidad As Integer) As Boolean
        If BuscarEnMaster(master, "CantidadMensajes") Is Nothing Then
            Return False
        Else
            CType(BuscarEnMaster(master, "CantidadMensajes"), Label).Text = cantidad
        End If
    End Function

    Public Shared Function BuscarEnMaster(ByRef master As MasterPage, ByVal controlName As String) As Control
        If Not master.Master Is Nothing Then
            Return BuscarEnMaster(master.Master, controlName)
        Else
            Return master.FindControl(controlName)
        End If
        Return Nothing
    End Function

    Public Shared Sub ActualizarMensajes(ByRef session As HttpSessionState, ByVal cantidad As Integer)
        session.Item(Variables.CANTIDAD_MENSAJES) = cantidad
    End Sub

    Public Shared Sub MensajeConClase(ByRef control As Label, ByVal texto As String, ByVal css As String)
        control.Text = texto
        control.CssClass = css
    End Sub

    Public Shared Function StripTags(ByVal html As String) As String
        ' Remove HTML tags.
        Return Regex.Replace(html, "<.*?>", "")
    End Function

    Public Shared Function ElementosAcademicosEnCurso(elementosAcademicos As List(Of ElementoAcademico)) As List(Of ElementoAcademico)
        Dim elementos As New List(Of ElementoAcademico)
        For Each elemento In elementosAcademicos
            If elemento.FechaInicio < My.Settings.FinPrimerPeriodo And elemento.FechaInicio < Date.Now And My.Settings.FinPrimerPeriodo > Date.Now Then
                elementos.Add(elemento)
            End If
            If elemento.FechaInicio > My.Settings.FinPrimerPeriodo And elemento.FechaInicio < My.Settings.FinSegundoPeriodo And elemento.FechaInicio < Date.Now And My.Settings.FinSegundoPeriodo > Date.Now Then
                elementos.Add(elemento)
            End If
        Next
        Return elementos
    End Function

    Public Shared Function ElementosAcademicosFinalizados(elementosAcademicos As List(Of ElementoAcademico)) As List(Of ElementoAcademico)
        Dim elementos As New List(Of ElementoAcademico)
        For Each elemento In elementosAcademicos
            If elemento.FechaInicio < My.Settings.FinPrimerPeriodo And elemento.FechaInicio < Date.Now And My.Settings.FinPrimerPeriodo < Date.Now Then
                elementos.Add(elemento)
            End If
            If elemento.FechaInicio > My.Settings.FinPrimerPeriodo And elemento.FechaInicio < My.Settings.FinSegundoPeriodo And elemento.FechaInicio < Date.Now And My.Settings.FinSegundoPeriodo < Date.Now Then
                elementos.Add(elemento)
            End If
        Next
        Return elementos
    End Function

End Class
