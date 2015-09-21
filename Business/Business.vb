Imports MPP

Public Class Business(Of EE)

    Protected mapper As Mapper(Of EE)

    Public Function Crear(ByRef obj As EE)
        Return mapper.Insertar(obj)
    End Function

    Function Actualizar(ByRef obj As EE) As Boolean
        Return mapper.Actualizar(obj)
    End Function

    Function Obtener(ByVal id As Integer) As EE
        Return mapper.Obtener(id)
    End Function

    Function Listar() As List(Of EE)
        Return mapper.Listar()
    End Function

    Function Borrar(ByVal id As Integer) As Boolean
        Return mapper.Borrar(id)
    End Function

End Class
