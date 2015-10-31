Imports EE

Public Class Comentarios_Mapper
    Inherits Mapper(Of Comentario)

    Dim usuarioMapper As New Usuario_Data

    Public Sub New()
    End Sub

    Public Overrides Sub OBJaHASH(ByRef obj As Comentario, ByRef Item As Hashtable)
        hdatos.Add("@ID", obj.ID)
        hdatos.Add("@IdUsuario", obj.IdUsuario)
        hdatos.Add("@IdElementoAcademico", obj.IdElementoAcademico)
        hdatos.Add("@Comentario", obj.Comentario)
        hdatos.Add("@Fecha", obj.Fecha)
    End Sub

    Public Overrides Function Actualizar(ByRef obj As Comentario, Optional ByVal insertar As Boolean = False) As Boolean
        Return Actualizar(obj, "ComentariosActualizar")
    End Function

    Public Overrides Sub DSaEE(ByRef objNuevo As Comentario, ByRef Item As DataRow)
        objNuevo.ID = CInt(Item("ID"))
        objNuevo.IdUsuario = CInt(Item("IdUsuario"))
        objNuevo.IdElementoAcademico = CInt(Item("IdElementoAcademico"))
        objNuevo.Comentario = CStr(Item("Comentario"))
        objNuevo.Fecha = CDate(Item("Fecha"))
    End Sub

    Public Overloads Overrides Function Obtener(id As Integer) As Comentario
        Return Obtener(id, "ComentariosObtener")
    End Function

    Public Overrides Function Listar() As List(Of Comentario)
        Dim comentarios = Listar("ComentariosListar")
        For Each comentario In comentarios
            comentario.Usuario = usuarioMapper.ConsultarPorId(comentario.IdUsuario)
        Next
        Return comentarios
    End Function

    Public Overloads Overrides Function Borrar(id As Integer) As Boolean
        Return Borrar(id, "ComentariosBorrar")
    End Function
End Class
