Imports EE

Public Class Mensajes_Mapper
    Inherits Mapper

    Function InsertarMensaje(ByRef obj As Mensaje) As Boolean
        Preparar()

        obj.ID = 0

        Return ActualizarMensaje(obj)
    End Function

    Function ActualizarMensaje(ByRef obj As Mensaje) As Boolean
        Preparar()

        hdatos.Add("@ID", obj.ID)
        hdatos.Add("@Contenido", obj.Contenido)
        hdatos.Add("@UsuarioEmisor", obj.UsuarioEmisor)
        hdatos.Add("@EmailEmisor", obj.EmailEmisor)
        hdatos.Add("@RolEmisor", obj.RolEmisor)
        hdatos.Add("@UsuarioReceptor", obj.UsuarioReceptor)
        hdatos.Add("@EmailReceptor", obj.EmailReceptor)
        hdatos.Add("@RolReceptor", obj.RolReceptor)
        hdatos.Add("@Broadcast", obj.Broadcast)
        hdatos.Add("@ID_Conversacion", obj.IdConversacion)
        hdatos.Add("@Leido", obj.Leido)
        hdatos.Add("@Fecha", obj.Fecha)

        Return oDatos.Escribir("MensajeActualizar", hdatos)
    End Function

    Public Function ConsultarPorUsuario(ByVal idUsuario) As List(Of Mensaje)
        Preparar()
        Dim usuarioMapper As New Usuario_Data
        Dim usuario As Usuario
        Dim familiaMapper As New Familia_Data
        Dim familia As Familia

        hdatos.Add("@Usuario", idUsuario)

        DS = oDatos.Leer("MensajeObtenerPorUsuario", hdatos)

        Dim listado As New List(Of Mensaje)
        If DS.Tables(0).Rows.Count > 0 Then
            For Each Item As DataRow In DS.Tables(0).Rows
                Dim objNuevo As New Mensaje

                objNuevo.ID = CInt(Item("ID"))
                objNuevo.Contenido = CStr(Item("Contenido"))
                objNuevo.UsuarioEmisor = CInt(Item("UsuarioEmisor"))
                objNuevo.EmailEmisor = CStr(Item("EmailEmisor"))
                objNuevo.RolEmisor = CInt(Item("RolEmisor"))
                objNuevo.UsuarioReceptor = CInt(Item("UsuarioReceptor"))
                objNuevo.EmailReceptor = CStr(Item("EmailReceptor"))
                objNuevo.RolReceptor = CInt(Item("RolReceptor"))
                objNuevo.Broadcast = CBool(Item("Broadcast"))
                objNuevo.IdConversacion = CInt(Item("ID_Conversacion"))
                objNuevo.Leido = CBool(Item("Leido"))
                objNuevo.Fecha = CDate(Item("Fecha"))

                If objNuevo.UsuarioEmisor <> 0 Then
                    Usuario = usuarioMapper.ConsultarPorId(objNuevo.UsuarioEmisor)
                    objNuevo.NombreEmisor = Usuario.Nombre
                Else
                    For Each flia In familiaMapper.ObtenerFamilias
                        If flia.ID = objNuevo.RolEmisor Then
                            familia = flia
                            objNuevo.NombreEmisor = familia.Name
                            Exit For
                        End If
                    Next
                End If
                listado.Add(objNuevo)
            Next
        End If

        Return listado
    End Function

    Public Function ConsultarPorRol(ByVal idRol) As List(Of Mensaje)
        Preparar()
        Dim usuarioMapper As New Usuario_Data
        Dim usuario As Usuario
        Dim familiaMapper As New Familia_Data
        Dim familia As Familia

        hdatos.Add("@Rol", idRol)

        DS = oDatos.Leer("MensajeObtenerPorRol", hdatos)

        Dim listado As New List(Of Mensaje)
        If DS.Tables(0).Rows.Count > 0 Then
            For Each Item As DataRow In DS.Tables(0).Rows
                Dim objNuevo As New Mensaje

                objNuevo.ID = CInt(Item("ID"))
                objNuevo.Contenido = CStr(Item("Contenido"))
                objNuevo.UsuarioEmisor = CInt(Item("UsuarioEmisor"))
                objNuevo.EmailEmisor = CStr(Item("EmailEmisor"))
                objNuevo.RolEmisor = CInt(Item("RolEmisor"))
                objNuevo.UsuarioReceptor = CInt(Item("UsuarioReceptor"))
                objNuevo.EmailReceptor = CStr(Item("EmailReceptor"))
                objNuevo.RolReceptor = CInt(Item("RolReceptor"))
                objNuevo.Broadcast = CBool(Item("Broadcast"))
                objNuevo.IdConversacion = CInt(Item("ID_Conversacion"))
                objNuevo.Leido = CBool(Item("Leido"))
                objNuevo.Fecha = CDate(Item("Fecha"))

                If objNuevo.UsuarioEmisor <> 0 Then
                    usuario = usuarioMapper.ConsultarPorId(objNuevo.UsuarioEmisor)
                    objNuevo.NombreEmisor = usuario.Nombre
                Else
                    usuario = usuarioMapper.ConsultarPorId(objNuevo.UsuarioReceptor)
                    For Each flia In familiaMapper.ObtenerFamilias
                        If flia.ID = objNuevo.RolEmisor Then
                            familia = flia
                            objNuevo.NombreEmisor = familia.Name + " &#x27a4; " + usuario.Nombre
                            Exit For
                        End If
                    Next
                End If
                listado.Add(objNuevo)
            Next
        End If

        Return listado
    End Function

    Function BorrarMensaje(ByVal idMensaje As Integer) As Boolean
        Preparar()

        hdatos.Add("@ID", idMensaje)

        Return oDatos.Escribir("MensajeBorrar", hdatos)
    End Function
End Class
