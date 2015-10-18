Imports EE

Public Class FichaEncuesta_Mapper
    Inherits Mapper(Of FichaEncuesta)

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
        obj.Activa = CBool(Item("Activa"))
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
        hdatos.Add("@Activa", obj.Activa)
    End Sub

    Public Overloads Overrides Function Obtener(id As Integer) As FichaEncuesta
        Return Obtener(0, "FichaEncuestaObtener")
    End Function
End Class
