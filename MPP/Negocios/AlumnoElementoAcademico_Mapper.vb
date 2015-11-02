Imports EE

Public Class AlumnoElementoAcademico_Mapper
    Inherits Mapper(Of AlumnoElementoAcademico)

    Public Sub New()
    End Sub

    Public Overrides Sub OBJaHASH(ByRef obj As AlumnoElementoAcademico, ByRef Item As Hashtable)
        hdatos.Add("@ID", obj.ID)
        hdatos.Add("@IdAlumno", obj.IdAlumno)
        hdatos.Add("@IdElementoAcademico", obj.IdElementoAcademico)
        hdatos.Add("@Activo", obj.Activo)
        hdatos.Add("@Nota", obj.Nota)
        hdatos.Add("@Presentismo", obj.Presentismo)
    End Sub

    Public Overrides Function Actualizar(ByRef obj As AlumnoElementoAcademico, Optional ByVal insertar As Boolean = False) As Boolean
        Return Actualizar(obj, "AlumnoElementoAcademicoActualizar")
    End Function

    Public Overrides Sub DSaEE(ByRef objNuevo As AlumnoElementoAcademico, ByRef Item As DataRow)
        objNuevo.ID = CInt(Item("ID"))
        objNuevo.IdAlumno = CInt(Item("IdAlumno"))
        objNuevo.IdElementoAcademico = CInt(Item("IdElementoAcademico"))
        objNuevo.Activo = CBool(Item("Activo"))
        objNuevo.Nota = DbDecimalOrNull(Item("Nota"))
        objNuevo.Presentismo = DbIntegerOrNull(Item("Presentismo"))
    End Sub

    Public Overrides Function Obtener(ByVal codigoAcademico As Integer) As AlumnoElementoAcademico
        Return Obtener(codigoAcademico, "AlumnoElementoAcademicoObtener")
    End Function

    Public Overrides Function Listar() As List(Of AlumnoElementoAcademico)
        Return Listar("AlumnoElementoAcademicoListar")
    End Function

    Public Overloads Overrides Function Borrar(id As Integer) As Boolean
        Return Borrar(id, "AlumnoElementoAcademicoBorrar")
    End Function
End Class
