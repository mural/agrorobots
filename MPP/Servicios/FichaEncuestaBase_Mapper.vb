Imports EE

Public Class FichaEncuestaBase_Mapper
    Inherits Mapper(Of FichaEncuestaBase)

    Public Overloads Overrides Function Actualizar(ByRef obj As FichaEncuestaBase, Optional insertar As Boolean = False) As Boolean
        Return Actualizar(obj, "FichaEncuesta_BaseActualizar")
    End Function

    Public Overloads Overrides Function Borrar(id As Integer) As Boolean
        Return Borrar(id, "FichaEncuesta_BaseBorrar")
    End Function

    Public Overrides Sub DSaEE(ByRef obj As FichaEncuestaBase, ByRef Item As DataRow)
        obj.ID = CInt(Item("ID"))
    End Sub

    Public Overloads Overrides Function Listar() As List(Of FichaEncuestaBase)
        Return Listar("FichaEncuesta_BaseListar")
    End Function

    Public Overrides Sub OBJaHASH(ByRef obj As FichaEncuestaBase, ByRef Item As Hashtable)
        hdatos.Add("@ID", obj.ID)
    End Sub

    Public Overloads Overrides Function Obtener(id As Integer) As FichaEncuestaBase
        Return Obtener(0, "FichaEncuesta_BaseObtener")
    End Function
End Class
