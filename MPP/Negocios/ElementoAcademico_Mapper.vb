Imports EE

Public Class ElementoAcademico_Mapper
    Inherits Mapper(Of ElementoAcademico)

    Public Overrides Function Insertar(ByRef obj As ElementoAcademico) As Boolean
        Preparar()

        obj.CodigoAcademico = 0

        Return Actualizar(obj)
    End Function

    Public Overrides Function Actualizar(ByRef obj As ElementoAcademico) As Boolean
        Preparar()

        hdatos.Add("@ID", obj.CodigoAcademico)
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

        Return oDatos.Escribir("ElementoAcademicoActualizar", hdatos)
    End Function

    Private Sub DSaEE(ByRef objNuevo As ElementoAcademico, ByRef Item As DataRow)
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
    End Sub

    Public Overrides Function Obtener(ByVal codigoAcademico As Integer) As ElementoAcademico
        Preparar()

        hdatos.Add("@CodigoAcademico", codigoAcademico)

        DS = oDatos.Leer("ElementoAcademicoObtener", hdatos)
        Dim objNuevo As New ElementoAcademico

        If DS.Tables(0).Rows.Count > 0 Then
            For Each Item As DataRow In DS.Tables(0).Rows

                DSaEE(objNuevo, Item)
            Next
        End If
        Return objNuevo
    End Function

    Public Overrides Function Listar() As List(Of ElementoAcademico)
        Preparar()

        DS = oDatos.Leer("ElementoAcademicoListar", hdatos)
        Dim listado As New List(Of ElementoAcademico)

        If DS.Tables(0).Rows.Count > 0 Then
            For Each Item As DataRow In DS.Tables(0).Rows
                Dim objNuevo As New ElementoAcademico

                DSaEE(objNuevo, Item)
                listado.Add(objNuevo)
            Next
        End If
        Return listado
    End Function

    Overrides Function Borrar(ByVal codigoAcademico As Integer) As Boolean
        Preparar()

        hdatos.Add("@CodigoAcademico", codigoAcademico)

        Return oDatos.Escribir("ElementoAcademicoBorrar", hdatos)
    End Function

End Class
