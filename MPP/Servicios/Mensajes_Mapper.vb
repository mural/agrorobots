﻿Imports EE

Public Class Mensajes_Mapper
    Inherits Mapper(Of Mensaje)

    Public Overrides Function Insertar(ByRef obj As Mensaje) As Boolean
        Preparar()

        obj.ID = 0

        Return Actualizar(obj)
    End Function

    Public Overrides Function Actualizar(ByRef obj As Mensaje) As Boolean
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
        hdatos.Add("@LeidoEmisor", obj.LeidoEmisor)
        hdatos.Add("@LeidoReceptor", obj.LeidoReceptor)
        hdatos.Add("@Fecha", obj.Fecha)
        hdatos.Add("@BorradoEmisor", obj.BorradoEmisor)
        hdatos.Add("@BorradoReceptor", obj.BorradoReceptor)
        hdatos.Add("@Chat", obj.Chat)

        Return oDatos.Escribir("MensajeActualizar", hdatos)
    End Function

    Private Sub DSaEE(ByRef objNuevo As Mensaje, ByRef Item As DataRow)
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
        objNuevo.LeidoEmisor = CBool(Item("LeidoEmisor"))
        objNuevo.LeidoReceptor = CBool(Item("LeidoReceptor"))
        objNuevo.Fecha = CDate(Item("Fecha"))
        objNuevo.BorradoEmisor = CBool(Item("BorradoEmisor"))
        objNuevo.BorradoReceptor = CBool(Item("BorradoReceptor"))
        objNuevo.Chat = CBool(Item("Chat"))
    End Sub

    Public Overrides Function Obtener(ByVal idMensaje As Integer) As Mensaje
        Preparar()

        hdatos.Add("@ID", idMensaje)

        DS = oDatos.Leer("MensajeObtener", hdatos)
        Dim objNuevo As New Mensaje

        If DS.Tables(0).Rows.Count > 0 Then
            For Each Item As DataRow In DS.Tables(0).Rows

                DSaEE(objNuevo, Item)
            Next
        End If
        Return objNuevo
    End Function

    Public Overrides Function Listar() As List(Of Mensaje)
        Preparar()

        DS = oDatos.Leer("MensajeListar", hdatos)
        Dim listado As New List(Of Mensaje)

        If DS.Tables(0).Rows.Count > 0 Then
            For Each Item As DataRow In DS.Tables(0).Rows
                Dim objNuevo As New Mensaje

                DSaEE(objNuevo, Item)
                listado.Add(objNuevo)
            Next
        End If
        Return listado
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

    Public Overrides Function Borrar(ByVal idMensaje As Integer) As Boolean
        Preparar()

        hdatos.Add("@ID", idMensaje)

        Return oDatos.Escribir("MensajeBorrar", hdatos)
    End Function
End Class
