Imports EE

Public Class FichaEncuestaBase_Mapper
    Inherits Mapper(Of FichaEncuestaBase)

    Dim fichaEncuestaPreguntaMapper As New FichaEncuestaPregunta_Mapper

    Public Overloads Overrides Function Actualizar(ByRef obj As FichaEncuestaBase, Optional insertar As Boolean = False) As Boolean
        Return Actualizar(obj, "FichaEncuesta_BaseActualizar")
    End Function

    Public Overloads Overrides Function Borrar(id As Integer) As Boolean
        Return Borrar(id, "FichaEncuesta_BaseBorrar")
    End Function

    Public Overrides Sub DSaEE(ByRef obj As FichaEncuestaBase, ByRef Item As DataRow)
        obj.ID = CInt(Item("ID"))
        Dim foto = Item("Foto")
        If Not foto Is DBNull.Value Then
            obj.Foto = CType(Item("Foto"), Byte())
        End If
        obj.Tipo = CStr(Item("Tipo"))
        obj.Descripcion = CStr(Item("Descripcion"))
    End Sub

    Public Overloads Overrides Function Listar() As List(Of FichaEncuestaBase)
        Dim fichasYEncuestasBase = New List(Of FichaEncuestaBase)
        Try
            For Each fichaEncuestaBase In Listar("FichaEncuesta_BaseListar")
                For Each pregunta In fichaEncuestaPreguntaMapper.Listar
                    If pregunta.IDFichaEncuestaBase = fichaEncuestaBase.ID Then
                        fichaEncuestaBase.Preguntas.Add(pregunta)
                    End If
                Next
                fichasYEncuestasBase.Add(fichaEncuestaBase)
            Next
        Catch ex As Exception
        End Try
        Return fichasYEncuestasBase
    End Function

    Public Overrides Sub OBJaHASH(ByRef obj As FichaEncuestaBase, ByRef Item As Hashtable)
        hdatos.Add("@ID", obj.ID)
        hdatos.Add("@Foto", obj.Foto)
        hdatos.Add("@Tipo", obj.Tipo)
        hdatos.Add("@Descripcion", obj.Descripcion)
    End Sub

    Public Overloads Overrides Function Obtener(id As Integer) As FichaEncuestaBase
        Return Obtener(0, "FichaEncuesta_BaseObtener")
    End Function
End Class
