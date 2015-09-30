Imports EE
Imports MPP

Public Class Mensaje_Business

    Dim mensajesMapper As New Mensajes_Mapper
    Dim familiaBusiness As New Familia_Business

    Public Function EnviarMensaje(ByRef obj As Mensaje)
        Return mensajesMapper.Insertar(obj)
    End Function

    Public Function EnviarMensajeDeAdmin(ByVal idUsuario As Integer, ByVal contenido As String)
        Dim mensaje As New Mensaje
        mensaje.UsuarioReceptor = idUsuario
        mensaje.RolEmisor = familiaBusiness.ObtenerFamiliaAdmin.ID
        mensaje.Contenido = contenido
        mensaje.Fecha = Now
        Return mensajesMapper.Insertar(mensaje)
    End Function

    Public Function EnviarMensajeAAdmin(ByVal idUsuario As Integer, ByVal emailEmisor As String, ByVal contenido As String)
        Dim mensaje As New Mensaje
        mensaje.UsuarioEmisor = idUsuario
        mensaje.EmailEmisor = emailEmisor
        mensaje.Contenido = contenido
        mensaje.RolReceptor = familiaBusiness.ObtenerFamiliaAdmin.ID
        mensaje.Fecha = Now
        Return mensajesMapper.Insertar(mensaje)
    End Function

    Function ActualizarMensaje(ByRef obj As Mensaje) As Boolean
        Return mensajesMapper.Actualizar(obj)
    End Function

    Function ObtenerMensajesPorUsuario(ByVal idUsuario As Integer) As List(Of Mensaje)
        Return mensajesMapper.ConsultarPorUsuario(idUsuario)
    End Function

    Sub MarcarMensajesLeidos(ByVal id As Integer, Optional ByVal isAdmin As Boolean = False)
        Dim mensajes = ObtenerMensajesPorUsuario(id)
        If isAdmin Then
            mensajes = ObtenerMensajesPorRol(id)
        End If
        For Each mensaje As Mensaje In mensajes
            If Not mensaje.LeidoReceptor And Not mensaje.UsuarioEmisor = id And Not mensaje.RolEmisor = id Then
                mensaje.LeidoReceptor = True
                ActualizarMensaje(mensaje)
            End If
        Next
    End Sub

    Function ObtenerMensajesNoLeidos(ByVal idUsuarioRol As Integer, Optional ByVal isAdmin As Boolean = False) As Integer
        Dim mensajes = ObtenerMensajesPorUsuario(idUsuarioRol)
        If isAdmin Then
            mensajes = ObtenerMensajesPorRol(idUsuarioRol)
        End If
        Dim mensajesNoLeidos = 0
        For Each mensaje As Mensaje In mensajes
            If Not mensaje.LeidoReceptor And Not mensaje.UsuarioEmisor = idUsuarioRol And Not mensaje.RolEmisor = idUsuarioRol Then
                mensajesNoLeidos += 1
            End If
        Next
        Return mensajesNoLeidos
    End Function

    Function ObtenerMensajesPorRol(ByVal idRol As Integer) As List(Of Mensaje)
        Return mensajesMapper.ConsultarPorRol(idRol)
    End Function

    Function ObtenerMensajesDeAdmin() As List(Of Mensaje)
        Return ObtenerMensajesPorRol(familiaBusiness.ObtenerFamiliaAdmin.ID)
    End Function

    Function BorrarMensajeLogico(ByVal idUsuarioRol As Integer, ByVal idMensaje As Integer) As Boolean
        Dim mensaje = mensajesMapper.Obtener(idMensaje)
        If mensaje.UsuarioEmisor = idUsuarioRol Or mensaje.RolEmisor = idUsuarioRol Then
            mensaje.BorradoEmisor = True
        Else
            mensaje.BorradoReceptor = True
        End If
        Return ActualizarMensaje(mensaje)
    End Function

    Function BorrarMensaje(ByVal idMensaje As Integer) As Boolean
        Return mensajesMapper.Borrar(idMensaje)
    End Function
End Class
