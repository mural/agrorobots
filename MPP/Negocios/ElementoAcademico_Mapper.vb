Imports EE

Public Class ElementoAcademico_Mapper
    Inherits Mapper(Of ElementoAcademico)

    Public Sub New()
        CampoClave = "CodigoAcademico"
    End Sub

    Public Overrides Sub OBJaHASH(ByRef obj As ElementoAcademico, ByRef Item As Hashtable)
        hdatos.Add("@CodigoAcademico", obj.CodigoAcademico)
        hdatos.Add("@Comentario", obj.Comentario)
        hdatos.Add("@Contenido", obj.Contenido)
        hdatos.Add("@CriteriosAprobacion", obj.CriteriosAprobacion)
        hdatos.Add("@Descripcion", obj.Descripcion)
        hdatos.Add("@Duracion", obj.Duracion)
        hdatos.Add("@FechaInicio", obj.FechaInicio)
        hdatos.Add("@Nombre", obj.Nombre)
        hdatos.Add("@Temas", obj.Temas)
        hdatos.Add("@Cupo", obj.Cupo)
        hdatos.Add("@Clases", obj.Clases)
        hdatos.Add("@Precio", obj.Precio)
        hdatos.Add("@Imagen", obj.Imagen)
    End Sub

    Public Overrides Function Actualizar(ByRef obj As ElementoAcademico, Optional ByVal insertar As Boolean = False) As Boolean
        Return Actualizar(obj, "ElementoAcademicoActualizar")
    End Function

    Public Overrides Sub DSaEE(ByRef objNuevo As ElementoAcademico, ByRef Item As DataRow)
        objNuevo.CodigoAcademico = CInt(Item("CodigoAcademico"))
        objNuevo.Comentario = CStr(Item("Comentario"))
        objNuevo.Contenido = CStr(Item("Contenido"))
        objNuevo.CriteriosAprobacion = CStr(Item("CriteriosAprobacion"))
        objNuevo.Descripcion = CStr(Item("Descripcion"))
        objNuevo.Duracion = CInt(Item("Duracion"))
        objNuevo.FechaInicio = CDate(Item("FechaInicio"))
        objNuevo.Nombre = CStr(Item("Nombre"))
        objNuevo.Temas = CStr(Item("Temas"))
        objNuevo.Cupo = CInt(Item("Cupo"))
        objNuevo.Clases = CInt(Item("Clases"))
        objNuevo.Precio = CDec(Item("Precio"))
        objNuevo.Imagen = DbImageOrNull(Item("Imagen"))
    End Sub

    Public Overrides Function Obtener(ByVal codigoAcademico As Integer) As ElementoAcademico
        Return Obtener(codigoAcademico, "ElementoAcademicoObtener")
    End Function

    Public Overrides Function Listar() As List(Of ElementoAcademico)
        Return Listar("ElementoAcademicoListar")
    End Function

    Public Overloads Overrides Function Borrar(id As Integer) As Boolean
        Return Borrar(id, "ElementoAcademicoBorrar")
    End Function
End Class
