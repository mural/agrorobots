Imports MPP

Public Class Business(Of EE As New)

    Protected mapper As Mapper(Of EE)

    Public Overridable Function Crear(ByRef obj As EE)
        Return mapper.Insertar(obj)
    End Function

    Public Overridable Function Actualizar(ByRef obj As EE) As Boolean
        Return mapper.Actualizar(obj)
    End Function

    Public Overridable Function Obtener(ByVal id As Integer) As EE
        Return mapper.Obtener(id)
    End Function

    Public Overridable Function Listar() As List(Of EE)
        Return mapper.Listar()
    End Function

    Public Overridable Function Borrar(ByVal id As Integer) As Boolean
        Return mapper.Borrar(id)
    End Function

End Class
