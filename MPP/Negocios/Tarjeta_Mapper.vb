Imports EE

Public Class Tarjeta_Mapper
    Inherits Mapper(Of Tarjeta)

    Public Overrides Sub OBJaHASH(ByRef obj As Tarjeta, ByRef Item As Hashtable)
        hdatos.Add("@ID", obj.ID)
        hdatos.Add("@IdUsuario", obj.IdUsuario)
        hdatos.Add("@Tipo", obj.Tipo)
        hdatos.Add("@Numero", obj.Numero)
        hdatos.Add("@Nombre", obj.Nombre)
        hdatos.Add("@Expiracion", obj.Expiracion)
    End Sub

    Public Overrides Function Actualizar(ByRef obj As Tarjeta, Optional ByVal insertar As Boolean = False) As Boolean
        Return Actualizar(obj, "TarjetasActualizar")
    End Function

    Public Overrides Sub DSaEE(ByRef objNuevo As Tarjeta, ByRef Item As DataRow)
        objNuevo.ID = CInt(Item("ID"))
        objNuevo.IdUsuario = CInt(Item("IdUsuario"))
        objNuevo.Tipo = CStr(Item("Tipo"))
        objNuevo.Numero = CStr(Item("Numero"))
        objNuevo.Nombre = CStr(Item("Nombre"))
        objNuevo.Expiracion = CDate(Item("Expiracion"))
    End Sub

    Public Overrides Function Obtener(ByVal codigoAcademico As Integer) As Tarjeta
        Return Obtener(codigoAcademico, "TarjetasObtener")
    End Function

    Public Overrides Function Listar() As List(Of Tarjeta)
        Return Listar("TarjetasListar")
    End Function

    Public Overloads Overrides Function Borrar(id As Integer) As Boolean
        Return Borrar(id, "TarjetasBorrar")
    End Function
End Class
