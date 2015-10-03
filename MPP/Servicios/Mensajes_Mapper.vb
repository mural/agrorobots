Imports EE

Public Class Mensajes_Mapper
    Inherits Mapper(Of Mensaje)

    Public Overrides Sub OBJaHASH(ByRef obj As Mensaje, ByRef Item As Hashtable)
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
        hdatos.Add("@LeidoEmisor", obj.LeidoEmisor)
        hdatos.Add("@LeidoReceptor", obj.LeidoReceptor)
        hdatos.Add("@Fecha", obj.Fecha)
        hdatos.Add("@BorradoEmisor", obj.BorradoEmisor)
        hdatos.Add("@BorradoReceptor", obj.BorradoReceptor)
        hdatos.Add("@Chat", obj.Chat)
    End Sub

    Public Overrides Function Actualizar(ByRef obj As Mensaje, Optional ByVal insertar As Boolean = False) As Boolean
        Return Actualizar(obj, "MensajeActualizar")
    End Function

    Public Overrides Sub DSaEE(ByRef obj As Mensaje, ByRef Item As DataRow)
        obj.ID = CInt(Item("ID"))
        obj.Contenido = CStr(Item("Contenido"))
        obj.UsuarioEmisor = CInt(Item("UsuarioEmisor"))
        obj.EmailEmisor = CStr(Item("EmailEmisor"))
        obj.RolEmisor = CInt(Item("RolEmisor"))
        obj.UsuarioReceptor = CInt(Item("UsuarioReceptor"))
        obj.EmailReceptor = CStr(Item("EmailReceptor"))
        obj.RolReceptor = CInt(Item("RolReceptor"))
        obj.Broadcast = CBool(Item("Broadcast"))
        obj.IdConversacion = CInt(Item("ID_Conversacion"))
        obj.LeidoEmisor = CBool(Item("LeidoEmisor"))
        obj.LeidoReceptor = CBool(Item("LeidoReceptor"))
        obj.Fecha = CDate(Item("Fecha"))
        obj.BorradoEmisor = CBool(Item("BorradoEmisor"))
        obj.BorradoReceptor = CBool(Item("BorradoReceptor"))
        obj.Chat = CBool(Item("Chat"))
    End Sub

    Public Overrides Function Obtener(ByVal idMensaje As Integer) As Mensaje
        Return Obtener(idMensaje, "MensajeObtener")
    End Function

    Public Overrides Function Listar() As List(Of Mensaje)
        Return Listar("MensajeListar")
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

                DSaEE(objNuevo, Item)

                If objNuevo.UsuarioEmisor <> 0 Then
                    usuario = usuarioMapper.ConsultarPorId(objNuevo.UsuarioEmisor)
                    objNuevo.NombreEmisor = usuario.Nombre
                Else
                    For Each flia In familiaMapper.ObtenerFamilias
                        If flia.ID = objNuevo.RolEmisor Then
                            familia = flia
                            objNuevo.NombreEmisor = familia.Name
                            Exit For
                        End If
                    Next
                End If
                If (objNuevo.UsuarioEmisor = idUsuario And Not objNuevo.BorradoEmisor) Or
                        (Not objNuevo.UsuarioEmisor = idUsuario And Not objNuevo.BorradoReceptor) Then
                    listado.Add(objNuevo)
                End If
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

                DSaEE(objNuevo, Item)

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
                If (objNuevo.RolEmisor = idRol And Not objNuevo.BorradoEmisor) Or
                        (Not objNuevo.RolEmisor = idRol And Not objNuevo.BorradoReceptor) Then
                    listado.Add(objNuevo)
                End If

            Next
        End If

        Return listado
    End Function

    Public Overloads Overrides Function Borrar(id As Integer) As Boolean
        Return Borrar(id, "MensajeBorrar")
    End Function

End Class
