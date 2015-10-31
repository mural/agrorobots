Imports EE

Public Class ExamenRespuesta_Mapper
    Inherits Mapper(Of ExamenRespuesta)

    Public Overloads Overrides Function Actualizar(ByRef obj As ExamenRespuesta, Optional insertar As Boolean = False) As Boolean
        Return Actualizar(obj, "ExamenRespuestaActualizar")
    End Function

    Public Overloads Overrides Function Borrar(id As Integer) As Boolean
        Return Borrar(id, "ExamenRespuestaBorrar")
    End Function

    Public Overrides Sub DSaEE(ByRef obj As ExamenRespuesta, ByRef Item As DataRow)
        obj.ID = CInt(Item("ID"))
        obj.IdExamen = CInt(Item("IdExamen"))
        obj.IdPregunta = CInt(Item("IDPregunta"))
        obj.IdOpcion = CInt(Item("IdOpcion"))
        obj.Respuesta = CStr(Item("Respuesta"))
    End Sub

    Public Overloads Overrides Function Listar() As List(Of ExamenRespuesta)
        Return Listar("ExamenRespuestaListar")
    End Function

    Public Overrides Sub OBJaHASH(ByRef obj As ExamenRespuesta, ByRef Item As Hashtable)
        hdatos.Add("@ID", obj.ID)
        hdatos.Add("@IdExamen", obj.IdExamen)
        hdatos.Add("@IDPregunta", obj.IdPregunta)
        hdatos.Add("@IdOpcion", obj.IdOpcion)
        hdatos.Add("@Respuesta", obj.Respuesta)
    End Sub

    Public Overloads Overrides Function Obtener(id As Integer) As ExamenRespuesta
        Return Obtener(id, "ExamenRespuestaObtener")
    End Function
End Class
