Imports EE

Public Class FichaEncuestaRespuesta_Mapper
    Inherits Mapper(Of FichaEncuestaRespuesta)

    Public Overloads Overrides Function Actualizar(ByRef obj As FichaEncuestaRespuesta, Optional insertar As Boolean = False) As Boolean
        Return Actualizar(obj, "FichaEncuesta_RespuestaActualizar")
    End Function

    Public Overloads Overrides Function Borrar(id As Integer) As Boolean
        Return Borrar(id, "FichaEncuesta_RespuestaBorrar")
    End Function

    Public Overrides Sub DSaEE(ByRef obj As FichaEncuestaRespuesta, ByRef Item As DataRow)
        obj.ID = CInt(Item("ID"))
    End Sub

    Public Overloads Overrides Function Listar() As List(Of FichaEncuestaRespuesta)
        Return Listar("FichaEncuesta_RespuestaListar")
    End Function

    Public Overrides Sub OBJaHASH(ByRef obj As FichaEncuestaRespuesta, ByRef Item As Hashtable)
        hdatos.Add("@ID", obj.ID)
    End Sub

    Public Overloads Overrides Function Obtener(id As Integer) As FichaEncuestaRespuesta
        Return Obtener(0, "FichaEncuesta_RespuestaObtener")
    End Function
End Class
