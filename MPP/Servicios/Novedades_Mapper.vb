﻿Imports EE

Public Class Novedades_Mapper
    Inherits Mapper(Of Novedades)

    Public Overrides Sub OBJaHASH(ByRef obj As Novedades, ByRef Item As Hashtable)
        hdatos.Add("@ID", obj.ID)
        hdatos.Add("@Texto", obj.Texto)
        hdatos.Add("@Foto", obj.Foto)
        hdatos.Add("@Fecha", obj.Fecha)
        hdatos.Add("@IDCategoriaTema", obj.IDCategoriaTema)
    End Sub

    Public Overrides Function Actualizar(ByRef obj As Novedades, Optional ByVal insertar As Boolean = False) As Boolean
        Return Actualizar(obj, "NovedadesActualizar")
    End Function

    Public Overrides Sub DSaEE(ByRef obj As Novedades, ByRef Item As DataRow)
        obj.ID = CInt(Item("ID"))
        obj.Texto = CStr(Item("Texto"))
        Dim foto = Item("Foto")
        If Not foto Is DBNull.Value Then
            obj.Foto = CType(Item("Foto"), Byte())
        End If
        obj.Fecha = CDate(Item("Fecha"))
        obj.IDCategoriaTema = CInt(Item("IDCategoriaTema"))
    End Sub

    Public Overloads Overrides Function Obtener(id As Integer) As Novedades
        Return Obtener(id, "NovedadesObtener")
    End Function

    Public Overloads Overrides Function Listar() As List(Of Novedades)
        Return Listar("NovedadesListar")
    End Function

    Public Overloads Overrides Function Borrar(id As Integer) As Boolean
        Return Borrar(id, "NovedadesBorrar")
    End Function
End Class