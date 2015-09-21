Public MustInherit Class Mapper(Of EE)
    Protected oDatos As New DAL.Datos
    Protected hdatos As New Hashtable
    Protected DS As New DataSet

    Public Sub Preparar()
        oDatos = New DAL.Datos
        hdatos = New Hashtable
        DS = New DataSet
    End Sub

    MustOverride Function Insertar(ByRef obj As EE) As Boolean

    MustOverride Function Actualizar(ByRef obj As EE) As Boolean

    MustOverride Function Obtener(ByVal id As Integer) As EE

    MustOverride Function Listar() As List(Of EE)

    MustOverride Function Borrar(ByVal id As Integer) As Boolean

End Class
