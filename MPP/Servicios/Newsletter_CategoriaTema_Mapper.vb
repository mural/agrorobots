Imports EE

Public Class Newsletter_CategoriaTema_Mapper
    Inherits Mapper(Of Newsletter_CategoriaTema)

    Public Overloads Overrides Function Actualizar(ByRef obj As Newsletter_CategoriaTema, Optional insertar As Boolean = False) As Boolean
        Return Actualizar(obj, "Newsletter_CategoriaTemaActualizar")
    End Function

    Public Overloads Overrides Function Borrar(id As Integer) As Boolean
        Return Borrar(id, "Newsletter_CategoriaTemaBorrar", "IDNewsletter")
    End Function

    Public Overrides Sub DSaEE(ByRef obj As Newsletter_CategoriaTema, ByRef Item As DataRow)
        obj.ID = CInt(Item("ID"))
        obj.IDNewsletter = CInt(Item("IDNewsletter"))
        obj.IDCategoria = CInt(Item("IDCategoria"))
    End Sub

    Public Overloads Overrides Function Listar() As List(Of Newsletter_CategoriaTema)
        Return Listar("Newsletter_CategoriaTemaListar")
    End Function

    Public Overrides Sub OBJaHASH(ByRef obj As Newsletter_CategoriaTema, ByRef Item As Hashtable)
        hdatos.Add("@ID", obj.ID)
        hdatos.Add("@IDNewsletter", obj.IDNewsletter)
        hdatos.Add("@IDCategoria", obj.IDCategoria)
    End Sub

    Public Overloads Overrides Function Obtener(id As Integer) As Newsletter_CategoriaTema
        Return Obtener(id, "Newsletter_CategoriaTemaObtener")
    End Function
End Class
