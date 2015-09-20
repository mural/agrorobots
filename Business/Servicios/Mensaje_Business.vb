Imports EE
Imports MPP

Public Class Mensaje_Business

    Dim mensajesMapper As New Mensajes_Mapper
    Dim familiaBusiness As New Familia_Business

    Public Function EnviarMensaje(ByRef obj As Mensaje)
        Return mensajesMapper.InsertarMensaje(obj)
    End Function

    Public Function EnviarMensajeDeAdmin(ByVal idUsuario As Integer, ByVal contenido As String)
        Dim mensaje As New Mensaje
        mensaje.UsuarioReceptor = idUsuario
        mensaje.RolEmisor = familiaBusiness.ObtenerFamiliaAdmin.ID
        mensaje.Contenido = contenido
        mensaje.Leido = False
        mensaje.Fecha = Now
        Return mensajesMapper.InsertarMensaje(mensaje)
    End Function

    Public Function EnviarMensajeAAdmin(ByVal idUsuario As Integer, ByVal emailEmisor As String, ByVal contenido As String)
        Dim mensaje As New Mensaje
        mensaje.UsuarioEmisor = idUsuario
        mensaje.EmailEmisor = emailEmisor
        mensaje.Contenido = contenido
        mensaje.RolReceptor = familiaBusiness.ObtenerFamiliaAdmin.ID
        mensaje.Leido = False
        mensaje.Fecha = Now
        Return mensajesMapper.InsertarMensaje(mensaje)
    End Function

    Function ActualizarMensaje(ByRef obj As Mensaje) As Boolean
        Return mensajesMapper.ActualizarMensaje(obj)
    End Function

    Function ObtenerMensajesPorUsuario(ByVal idUsuario As Integer) As List(Of Mensaje)
        Return mensajesMapper.ConsultarPorUsuario(idUsuario)
    End Function

    Function ObtenerMensajesPorRol(ByVal idRol As Integer) As List(Of Mensaje)
        Return mensajesMapper.ConsultarPorRol(idRol)
    End Function

    Function ObtenerMensajesDeAdmin() As List(Of Mensaje)
        Return ObtenerMensajesPorRol(familiaBusiness.ObtenerFamiliaAdmin.ID)
    End Function

    Function BorrarMensaje(ByVal idMensaje As Integer) As Boolean
        Return mensajesMapper.BorrarMensaje(idMensaje)
    End Function
End Class
