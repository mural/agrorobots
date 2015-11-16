Imports EE

Public Class Examen_Mapper
    Inherits Mapper(Of Examen)

    Dim examenRespuestaMapper As New ExamenRespuesta_Mapper
    Public Property IdExamen As Integer

    Public Overrides Function Insertar(ByRef obj As Examen) As Boolean
        Preparar()
        Dim resultado = False

        If obj.Respuestas.Count > 0 Then 'examen
            Me.Transaccion = AccionTransaccion.Iniciar
            resultado = Me.Actualizar(obj, True)
            IdExamen = oDatos.RespuestaEscritura

            If resultado Then 'si salio bien la escritura anterior
                examenRespuestaMapper.Transaccion = AccionTransaccion.Continuar
                For i = 0 To obj.Respuestas.Count - 1
                    Dim respuesta As ExamenRespuesta = obj.Respuestas(i)
                    respuesta.IdExamen = IdExamen
                    If i = obj.Respuestas.Count - 1 Then
                        examenRespuestaMapper.Transaccion = AccionTransaccion.Cerrar
                    End If
                    resultado = examenRespuestaMapper.Insertar(respuesta)
                Next
            End If
        Else '
            resultado = Me.Actualizar(obj, True)
        End If
        Return resultado
    End Function

    Public Overloads Overrides Function Actualizar(ByRef obj As Examen, Optional insertar As Boolean = False) As Boolean
        Return Actualizar(obj, "ExamenActualizar")
    End Function

    Public Overloads Overrides Function Borrar(id As Integer) As Boolean
        Return Borrar(id, "ExamenBorrar")
    End Function

    Public Overrides Sub DSaEE(ByRef obj As Examen, ByRef Item As DataRow)
        obj.ID = CInt(Item("ID"))
        obj.IdExamenBase = CInt(Item("IdExamenBase"))
        obj.Fecha = CDate(Item("Fecha"))
        obj.IdAlumno = CInt(Item("IdAlumno"))
        obj.Nota = CDec(Item("Nota"))
        obj.Comentario = DbStringOrNull(Item("Comentario"))
        obj.Finalizado = DbBooleanOrNull(Item("Finalizado"))
    End Sub

    Public Overloads Overrides Function Listar() As List(Of Examen)
        Return Listar("ExamenListar")
    End Function

    Public Overrides Sub OBJaHASH(ByRef obj As Examen, ByRef Item As Hashtable)
        hdatos.Add("@ID", obj.ID)
        hdatos.Add("@IdExamenBase", obj.IdExamenBase)
        hdatos.Add("@Fecha", obj.Fecha)
        hdatos.Add("@IdAlumno", obj.IdAlumno)
        hdatos.Add("@Nota", obj.Nota)
        hdatos.Add("@Comentario", obj.Comentario)
        hdatos.Add("@Finalizado", obj.Finalizado)
    End Sub

    Public Overloads Overrides Function Obtener(id As Integer) As Examen
        Return Obtener(id, "ExamenObtener")
    End Function
End Class
