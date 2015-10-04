Imports EE

Public Class CategoriaTema_Mapper
    Inherits Mapper(Of CategoriaTema)

    Public Overloads Overrides Function Actualizar(ByRef obj As CategoriaTema, Optional insertar As Boolean = False) As Boolean
        Return Actualizar(obj, "CategoriaTemaActualizar")
    End Function

    Public Overloads Overrides Function Borrar(id As Integer) As Boolean
        Return Borrar(id, "CategoriaTemaBorrar")
    End Function

    Public Overrides Sub DSaEE(ByRef obj As CategoriaTema, ByRef Item As DataRow)
        obj.ID = CInt(Item("ID"))
        obj.Nombre = CStr(Item("Nombre"))
    End Sub

    Public Overloads Overrides Function Listar() As List(Of CategoriaTema)
        Return Listar("CategoriaTemaListar")
    End Function

    Public Overrides Sub OBJaHASH(ByRef obj As CategoriaTema, ByRef Item As Hashtable)
        hdatos.Add("@ID", obj.ID)
        hdatos.Add("@Nombre", obj.Nombre)
    End Sub

    Public Overloads Overrides Function Obtener(id As Integer) As CategoriaTema
        Return Obtener(id, "CategoriaTemaObtener")
    End Function
End Class
