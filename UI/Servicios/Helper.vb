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


    Public Shared Sub ActualizarMensajes(ByRef session As HttpSessionState)
        If session.Item(Variables.CANTIDAD_MENSAJES) Is Nothing Then
            session.Item(Variables.CANTIDAD_MENSAJES) = 0
        End If
    End Sub

    Public Shared Sub ActualizarMensajes(ByRef session As HttpSessionState, ByVal cantidad As Integer)
        If session.Item(Variables.CANTIDAD_MENSAJES) Is Nothing Then
            session.Item(Variables.CANTIDAD_MENSAJES) = 0
        Else
            session.Item(Variables.CANTIDAD_MENSAJES) = cantidad
        End If
    End Sub

End Class
