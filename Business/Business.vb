Imports MPP

Public Class Business(Of EE As New)

    Protected mapperGenerico As Mapper(Of EE)

    Public Overridable Function Crear(ByRef obj As EE)
        Return mapperGenerico.Insertar(obj)
    End Function

    Public Overridable Function Actualizar(ByRef obj As EE) As Boolean
        Return mapperGenerico.Actualizar(obj)
    End Function

    Public Overridable Function Obtener(ByVal id As Integer) As EE
        Return mapperGenerico.Obtener(id)
    End Function

    Public Overridable Function Listar() As List(Of EE)
        Return mapperGenerico.Listar()
    End Function

    Public Overridable Function Borrar(ByVal id As Integer) As Boolean
        Return mapperGenerico.Borrar(id)
    End Function

End Class
