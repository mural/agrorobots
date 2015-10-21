Imports EE

Public Class ProfesorElementoAcademico_Mapper
    Inherits Mapper(Of ProfesorElementoAcademico)

    Public Sub New()
    End Sub

    Public Overrides Sub OBJaHASH(ByRef obj As ProfesorElementoAcademico, ByRef Item As Hashtable)
        hdatos.Add("@ID", obj.ID)
        hdatos.Add("@IdProfesor", obj.IdProfesor)
        hdatos.Add("@IdElementoAcademico", obj.IdElementoAcademico)
    End Sub

    Public Overrides Function Actualizar(ByRef obj As ProfesorElementoAcademico, Optional ByVal insertar As Boolean = False) As Boolean
        Return Actualizar(obj, "ProfesorElementoAcademicoActualizar")
    End Function

    Public Overrides Sub DSaEE(ByRef objNuevo As ProfesorElementoAcademico, ByRef Item As DataRow)
        objNuevo.ID = CInt(Item("ID"))
        objNuevo.IdProfesor = CInt(Item("IdProfesor"))
        objNuevo.IdElementoAcademico = CInt(Item("IdElementoAcademico"))
    End Sub

    Public Overrides Function Obtener(ByVal codigoAcademico As Integer) As ProfesorElementoAcademico
        Return Obtener(codigoAcademico, "ProfesorElementoAcademicoObtener")
    End Function

    Public Overrides Function Listar() As List(Of ProfesorElementoAcademico)
        Return Listar("ProfesorElementoAcademicoListar")
    End Function

    Public Overloads Overrides Function Borrar(id As Integer) As Boolean
        Return Borrar(id, "ProfesorElementoAcademicoBorrar")
    End Function
End Class
