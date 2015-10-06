Imports EE

Public Class FichaEncuestaPregunta_Mapper
    Inherits Mapper(Of FichaEncuestaPregunta)

    Public Overloads Overrides Function Actualizar(ByRef obj As FichaEncuestaPregunta, Optional insertar As Boolean = False) As Boolean
        Return Actualizar(obj, "FichaEncuesta_PreguntaActualizar")
    End Function

    Public Overloads Overrides Function Borrar(id As Integer) As Boolean
        Return Borrar(id, "FichaEncuesta_PreguntaBorrar")
    End Function

    Public Overrides Sub DSaEE(ByRef obj As FichaEncuestaPregunta, ByRef Item As DataRow)
        obj.ID = CInt(Item("ID"))
        obj.IDFichaEncuestaBase = CInt(Item("IDFichaEncuestaBase"))
        obj.Pregunta = CStr(Item("Pregunta"))
    End Sub

    Public Overloads Overrides Function Listar() As List(Of FichaEncuestaPregunta)
        Return Listar("FichaEncuesta_PreguntaListar")
    End Function

    Public Overrides Sub OBJaHASH(ByRef obj As FichaEncuestaPregunta, ByRef Item As Hashtable)
        hdatos.Add("@ID", obj.ID)
        hdatos.Add("@IDFichaEncuestaBase", obj.IDFichaEncuestaBase)
        hdatos.Add("@Pregunta", obj.Pregunta)
    End Sub

    Public Overloads Overrides Function Obtener(id As Integer) As FichaEncuestaPregunta
        Return Obtener(0, "FichaEncuesta_PreguntaObtener")
    End Function
End Class
