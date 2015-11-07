Imports EE

Public Class Foro_Mapper
    Inherits Mapper(Of Foro)

    Dim usuarioMapper As New Usuario_Data

    Public Overrides Sub OBJaHASH(ByRef obj As Foro, ByRef Item As Hashtable)
        hdatos.Add("@ID", obj.ID)
        hdatos.Add("@IdElementoAcademico", obj.IdElementoAcademico)
        hdatos.Add("@IdUsuario", obj.IdUsuario)
        hdatos.Add("@Fecha", obj.Fecha)
        hdatos.Add("@Comentario", obj.Comentario)
        hdatos.Add("@EsProfesor", obj.EsProfesor)
    End Sub

    Public Overrides Function Actualizar(ByRef obj As Foro, Optional ByVal insertar As Boolean = False) As Boolean
        Return Actualizar(obj, "ForoActualizar")
    End Function

    Public Overrides Sub DSaEE(ByRef objNuevo As Foro, ByRef Item As DataRow)
        objNuevo.ID = CInt(Item("ID"))
        objNuevo.IdElementoAcademico = CInt(Item("IdElementoAcademico"))
        objNuevo.IdUsuario = CInt(Item("IdUsuario"))
        objNuevo.Fecha = CDate(Item("Fecha"))
        objNuevo.Comentario = CStr(Item("Comentario"))
        objNuevo.EsProfesor = CBool(Item("EsProfesor"))
    End Sub

    Public Overrides Function Obtener(ByVal id As Integer) As Foro
        Return Obtener(id, "ForoObtener")
    End Function

    Public Overrides Function Listar() As List(Of Foro)
        Dim items = Listar("ForoListar")
        For Each comentario In items
            comentario.Usuario = usuarioMapper.ConsultarPorId(comentario.IdUsuario)
        Next
        Return items
    End Function

    Public Overloads Overrides Function Borrar(id As Integer) As Boolean
        Return Borrar(id, "ForoBorrar")
    End Function
End Class
