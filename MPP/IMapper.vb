Public Interface IMapper(Of EE)

    Function Insertar(ByRef obj As EE) As Boolean

    Function Actualizar(ByRef obj As EE, Optional ByVal insertar As Boolean = False) As Boolean

    Function Obtener(ByVal id As Integer) As EE

    Function Listar() As List(Of EE)

    Function Borrar(id As Integer) As Boolean

End Interface
