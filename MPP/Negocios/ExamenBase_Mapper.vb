Imports EE

Public Class ExamenBase_Mapper
    Inherits Mapper(Of ExamenBase)

    Dim examenBasePreguntaMapper As New ExamenBasePregunta_Mapper

    Public Overloads Overrides Function Actualizar(ByRef obj As ExamenBase, Optional insertar As Boolean = False) As Boolean
        Return Actualizar(obj, "ExamenBaseActualizar")
    End Function

    Public Overloads Overrides Function Borrar(id As Integer) As Boolean
        Return Borrar(id, "ExamenBaseBorrar")
    End Function

    Public Overrides Sub DSaEE(ByRef obj As ExamenBase, ByRef Item As DataRow)
        obj.ID = CInt(Item("ID"))
        obj.IdElementoAcademico = CInt(Item("IdElementoAcademico"))
        obj.Detalle = CStr(Item("Detalle"))
        obj.Tipo = CStr(Item("Tipo"))
        obj.TiempoMax = CInt(Item("TiempoMax"))
        obj.Activo = CBool(Item("Activo"))
    End Sub

    Public Overloads Overrides Function Listar() As List(Of ExamenBase)
        Dim examenesBase = New List(Of ExamenBase)
        Try
            For Each examenBase In Listar("ExamenBaseListar")
                For Each pregunta In examenBasePreguntaMapper.Listar
                    If pregunta.IdExamenBase = examenBase.ID Then
                        examenBase.Preguntas.Add(pregunta)
                    End If
                Next
                examenesBase.Add(examenBase)
            Next
        Catch ex As Exception
        End Try
        Return examenesBase
    End Function

    Public Overrides Sub OBJaHASH(ByRef obj As ExamenBase, ByRef Item As Hashtable)
        hdatos.Add("@ID", obj.ID)
        hdatos.Add("@IdElementoAcademico", obj.IdElementoAcademico)
        hdatos.Add("@Detalle", obj.Detalle)
        hdatos.Add("@Tipo", obj.Tipo)
        hdatos.Add("@TiempoMax", obj.TiempoMax)
        hdatos.Add("@Activo", obj.Activo)
    End Sub

    Public Overloads Overrides Function Obtener(id As Integer) As ExamenBase
        Dim examenBase = Obtener(id, "ExamenBaseObtener")
        For Each pregunta In examenBasePreguntaMapper.Listar
            If pregunta.IdExamenBase = examenBase.ID Then
                examenBase.Preguntas.Add(pregunta)
            End If
        Next
        Return examenBase
    End Function
End Class

