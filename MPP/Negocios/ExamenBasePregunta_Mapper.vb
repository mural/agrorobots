Imports EE

Public Class ExamenBasePregunta_Mapper
    Inherits Mapper(Of ExamenBasePregunta)

    Public Overloads Overrides Function Actualizar(ByRef obj As ExamenBasePregunta, Optional insertar As Boolean = False) As Boolean
        Return Actualizar(obj, "ExamenBasePreguntaActualizar")
    End Function

    Public Overloads Overrides Function Borrar(id As Integer) As Boolean
        Return Borrar(id, "ExamenBasePreguntaBorrar")
    End Function

    Public Overrides Sub DSaEE(ByRef obj As ExamenBasePregunta, ByRef Item As DataRow)
        obj.ID = CInt(Item("ID"))
        obj.IdExamenBase = CInt(Item("IDExamenBaseBase"))
        obj.Pregunta = CStr(Item("Pregunta"))
    End Sub

    Public Overloads Overrides Function Listar() As List(Of ExamenBasePregunta)
        Return Listar("ExamenBasePreguntaListar")
    End Function

    Public Overrides Sub OBJaHASH(ByRef obj As ExamenBasePregunta, ByRef Item As Hashtable)
        hdatos.Add("@ID", obj.ID)
        hdatos.Add("@IDExamenBaseBase", obj.IdExamenBase)
        hdatos.Add("@Pregunta", obj.Pregunta)
    End Sub

    Public Overloads Overrides Function Obtener(id As Integer) As ExamenBasePregunta
        Return Obtener(0, "ExamenBasePreguntaObtener")
    End Function
End Class

