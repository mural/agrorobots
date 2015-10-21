Imports EE

Public Class MaterialDeEstudio_Mapper
    Inherits Mapper(Of MaterialDeEstudio)

    Public Sub New()
    End Sub

    Public Overrides Sub OBJaHASH(ByRef obj As MaterialDeEstudio, ByRef Item As Hashtable)
        hdatos.Add("@ID", obj.ID)
        hdatos.Add("@IdElementoAcademico", obj.IdElementoAcademico)
        hdatos.Add("@Tipo", obj.Tipo)
        hdatos.Add("@Detalle", obj.Detalle)
        hdatos.Add("@Contenido", obj.Contenido)
        hdatos.Add("@Activo", obj.Activo)
    End Sub

    Public Overrides Function Actualizar(ByRef obj As MaterialDeEstudio, Optional ByVal insertar As Boolean = False) As Boolean
        Return Actualizar(obj, "MaterialDeEstudioActualizar")
    End Function

    Public Overrides Sub DSaEE(ByRef objNuevo As MaterialDeEstudio, ByRef Item As DataRow)
        objNuevo.ID = CInt(Item("ID"))
        objNuevo.IdElementoAcademico = CInt(Item("IdElementoAcademico"))
        objNuevo.Tipo = CStr(Item("Tipo"))
        objNuevo.Detalle = CStr(Item("Detalle"))
        objNuevo.Contenido = CStr(Item("Contenido"))
        objNuevo.Activo = CBool(Item("Activo"))
    End Sub

    Public Overrides Function Obtener(ByVal codigoAcademico As Integer) As MaterialDeEstudio
        Return Obtener(codigoAcademico, "MaterialDeEstudioObtener")
    End Function

    Public Overrides Function Listar() As List(Of MaterialDeEstudio)
        Return Listar("MaterialDeEstudioListar")
    End Function

    Public Overloads Overrides Function Borrar(id As Integer) As Boolean
        Return Borrar(id, "MaterialDeEstudioBorrar")
    End Function
End Class
