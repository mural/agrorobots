Imports EE

Public Class AlumnoMaterialDeEstudio_Mapper
    Inherits Mapper(Of AlumnoMaterialDeEstudio)

    Public Sub New()
    End Sub

    Public Overrides Sub OBJaHASH(ByRef obj As AlumnoMaterialDeEstudio, ByRef Item As Hashtable)
        hdatos.Add("@ID", obj.ID)
        hdatos.Add("@IdAlumno", obj.IdAlumno)
        hdatos.Add("@IdMaterialDeEstudio", obj.IdMaterialDeEstudio)
        hdatos.Add("@VistoEnTiempo", obj.VistoEnTiempo)
    End Sub

    Public Overrides Function Actualizar(ByRef obj As AlumnoMaterialDeEstudio, Optional ByVal insertar As Boolean = False) As Boolean
        Return Actualizar(obj, "AlumnoMaterialActualizar")
    End Function

    Public Overrides Sub DSaEE(ByRef objNuevo As AlumnoMaterialDeEstudio, ByRef Item As DataRow)
        objNuevo.ID = CInt(Item("ID"))
        objNuevo.IdAlumno = CInt(Item("IdAlumno"))
        objNuevo.IdMaterialDeEstudio = CInt(Item("IdMaterialDeEstudio"))
        objNuevo.VistoEnTiempo = CBool(Item("VistoEnTiempo"))
    End Sub

    Public Overrides Function Obtener(ByVal id As Integer) As AlumnoMaterialDeEstudio
        Return Obtener(id, "AlumnoMaterialObtener")
    End Function

    Public Overrides Function Listar() As List(Of AlumnoMaterialDeEstudio)
        Return Listar("AlumnoMaterialListar")
    End Function

    Public Overloads Overrides Function Borrar(id As Integer) As Boolean
        Return Borrar(id, "AlumnoMaterialBorrar")
    End Function
End Class
