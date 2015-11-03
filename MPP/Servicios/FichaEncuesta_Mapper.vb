Imports EE

Public Class FichaEncuesta_Mapper
    Inherits Mapper(Of FichaEncuesta)

    Dim fichaEncuestaRespuestaMapper As New FichaEncuestaRespuesta_Mapper
    Public Property IdFichaEncuesta As Integer

    Public Overrides Function Insertar(ByRef obj As FichaEncuesta) As Boolean
        Preparar()
        Dim resultado = False

        If obj.Respuestas.Count > 0 Then 'ficha
            Me.Transaccion = AccionTransaccion.Iniciar
            resultado = Me.Actualizar(obj, True)
            IdFichaEncuesta = oDatos.RespuestaEscritura

            If resultado Then 'si salio bien la escritura anterior
                fichaEncuestaRespuestaMapper.Transaccion = AccionTransaccion.Continuar
                For i = 0 To obj.Respuestas.Count - 1
                    Dim respuesta As FichaEncuestaRespuesta = obj.Respuestas(i)
                    respuesta.IDFichaEncuesta = IdFichaEncuesta
                    If i = obj.Respuestas.Count - 1 Then
                        fichaEncuestaRespuestaMapper.Transaccion = AccionTransaccion.Cerrar
                    End If
                    resultado = fichaEncuestaRespuestaMapper.Insertar(respuesta)
                Next
            End If
        Else 'encuesta
            resultado = Me.Actualizar(obj, True)
        End If
        Return resultado
    End Function

    Public Overloads Overrides Function Actualizar(ByRef obj As FichaEncuesta, Optional insertar As Boolean = False) As Boolean
        Return Actualizar(obj, "FichaEncuestaActualizar")
    End Function

    Public Overloads Overrides Function Borrar(id As Integer) As Boolean
        Return Borrar(id, "FichaEncuestaBorrar")
    End Function

    Public Overrides Sub DSaEE(ByRef obj As FichaEncuesta, ByRef Item As DataRow)
        obj.ID = CInt(Item("ID"))
        obj.IDFichaEncuestaBase = CInt(Item("IDFichaEncuestaBase"))
        obj.Fecha = CDate(Item("Fecha"))
        obj.Usuario = DbStringOrNull(Item("Usuario"))
        obj.Email = DbStringOrNull(Item("Email"))
        obj.Sesion = DbStringOrNull(Item("Sesion"))
        obj.RespuestaUnica = DbStringOrNull(Item("RespuestaUnica"))

    End Sub

    Public Overloads Overrides Function Listar() As List(Of FichaEncuesta)
        Return Listar("FichaEncuestaListar")
    End Function

    Public Overrides Sub OBJaHASH(ByRef obj As FichaEncuesta, ByRef Item As Hashtable)
        hdatos.Add("@ID", obj.ID)
        hdatos.Add("@IDFichaEncuestaBase", obj.IDFichaEncuestaBase)
        hdatos.Add("@Fecha", obj.Fecha)
        hdatos.Add("@Usuario", obj.Usuario)
        hdatos.Add("@Email", obj.Email)
        hdatos.Add("@Sesion", obj.Sesion)
        hdatos.Add("@RespuestaUnica", obj.RespuestaUnica)

    End Sub

    Public Overloads Overrides Function Obtener(id As Integer) As FichaEncuesta
        Return Obtener(id, "FichaEncuestaObtener")
    End Function
End Class
